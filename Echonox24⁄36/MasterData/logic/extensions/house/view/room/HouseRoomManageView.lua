-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/view/room/HouseRoomManageView.lua

module("logic.extensions.house.view.room.HouseRoomManageView", package.seeall)

local M = class("HouseRoomManageView", ViewComponent)
local RoomType = HouseEnum.RoomType
local RoomOpenTyp = HouseMainEnum.RoomOpenTyp
local kDefaultSelectedRoomId = HouseEnum.SUPERVISOR_ROOM_ID
local kMaskShowTime = 0.5
local dictRoomSortIdx = {}

local function _sortRoom(roomA, roomB)
	local function _getSortIdx(roomId)
		local sortIdx = -1
		local openType = HouseMainRoomModel.instance:getRoomOpenTyp(roomId)

		if openType == RoomOpenTyp.UnOpen then
			sortIdx = 0
		elseif openType == RoomOpenTyp.OpenLock then
			sortIdx = 1
		elseif openType == RoomOpenTyp.OpenUnActive then
			sortIdx = 2

			local canActive = HouseMainUtil.canRoomActive(roomId)

			if canActive then
				sortIdx = 13
			end
		elseif openType == RoomOpenTyp.OpenActive then
			sortIdx = 3

			local isNotSetting = HouseMainUtil.isRoomNotSetting(roomId)
			local canUpgrade = HouseMainUtil.canRoomUpgradeLv(roomId)

			if isNotSetting then
				sortIdx = 11
			elseif canUpgrade then
				sortIdx = 12
			end
		end

		return sortIdx
	end

	local sortIdxA = _getSortIdx(roomA)

	dictRoomSortIdx[roomA] = sortIdxA

	local sortIdxB = _getSortIdx(roomB)

	dictRoomSortIdx[roomB] = sortIdxB

	if sortIdxA ~= sortIdxB then
		return sortIdxB < sortIdxA
	else
		local productSortIdx = {
			HouseEnum.TRADING_ROOM_ID,
			HouseEnum.MANUFACTURE_ROOM_ID,
			HouseEnum.SUPERVISOR_ROOM_ID
		}

		if table.indexof(productSortIdx, roomA) then
			local sortIdxA = sortIdxA + table.indexof(productSortIdx, roomA)
			local sortIdxB = sortIdxB + table.indexof(productSortIdx, roomB)

			return sortIdxB < sortIdxA
		end
	end

	return roomA < roomB
end

function M:ctor()
	M.super.ctor(self)

	self._arrayProductRoomId = {}
	self._arrayShelterRoomId = {}
	self._arrayLivingRoomId = {}
	self._arrayProductItem = {}
	self._arrayShelterItem = {}
	self._arrayLivingItem = {}
	self._selectedRoomId = nil
	self._photoWindow = nil
	self._maskShowTimer = SchedulerCtrl.New(self._hideMask, self)
end

function M:buildUI()
	self._btnUpgrade = self:getBtn("room_facility_manage_view_1067574607")
	self._txtBtnUpgrade = goutil.findChildTextComponent(self._btnUpgrade.gameObject, "Text")
	self._btnDetail = self:getBtn("room_facility_manage_view_1537667150")
	self._txtBtnDetail = goutil.findChildTextComponent(self._btnDetail.gameObject, "Text")
	self._txtName = self:getText("room_facility_manage_view_-1619528325")
	self._txtLv = self:getText("room_facility_manage_view_674208982")
	self._goWindow = self:getGo("room_facility_manage_view_454709135")
	self._photoWindow = Astral.PhotoBase.Add(self._goWindow)
	self._goMask = self:getGo("room_facility_manage_view_-636234605")

	self:initRoomItems()
end

function M:initRoomItems()
	local productRootGO = self:getGo("room_facility_manage_view_-526170886")
	local shelterRootGO = self:getGo("room_facility_manage_view_254216104")
	local livingRootGO = self:getGo("room_facility_manage_view_1162957453")
	local itemGO = self:getGo("room_facility_manage_view_556102349")

	local function _createItem(parentGO)
		local cloneItemGO = goutil.clone(itemGO)
		local item = Astral.LuaComponentContainer.Add(cloneItemGO, HouseRoomManageItem)

		item:setClickCallback(self._onClickItem, self)
		goutil.addChildToParent(cloneItemGO, parentGO)
		goutil.setActive(cloneItemGO, true)

		return item
	end

	local zoneCOs = HouseConfig.instance:getConfigList(ConfigName.HouseZone)

	for _, zoneCO in ipairs(zoneCOs) do
		local zoneType = NavMeshUtil.getZoneTypeByZoneId(zoneCO.id)

		if zoneType == HouseEnum.ZoneType.Room then
			if zoneCO.roomType == RoomType.Shelter then
				table.insert(self._arrayShelterRoomId, zoneCO.id)

				local item = _createItem(shelterRootGO)

				table.insert(self._arrayShelterItem, item)
			elseif zoneCO.roomType == RoomType.Living then
				table.insert(self._arrayLivingRoomId, zoneCO.id)

				local item = _createItem(livingRootGO)

				table.insert(self._arrayLivingItem, item)
			end
		end
	end

	self._arrayProductRoomId = {
		HouseEnum.SUPERVISOR_ROOM_ID,
		HouseEnum.MANUFACTURE_ROOM_ID,
		HouseEnum.TRADING_ROOM_ID
	}

	for i = 1, #self._arrayProductRoomId do
		local item = _createItem(productRootGO)

		table.insert(self._arrayProductItem, item)
	end
end

function M:destroyUI()
	table.clear(self._arrayProductRoomId)
	table.clear(self._arrayShelterRoomId)
	table.clear(self._arrayLivingRoomId)
	table.clear(self._arrayProductItem)
	table.clear(self._arrayShelterItem)
	table.clear(self._arrayLivingItem)
	table.clear(dictRoomSortIdx)

	self._photoWindow = nil

	self._maskShowTimer:clear()

	self._maskShowTimer = nil
end

function M:bindEvents()
	self._btnUpgrade:AddClickListener(self._onClickBtnUpgrade, self)
	self._btnDetail:AddClickListener(self._onClickBtnDetail, self)
end

function M:unbindEvents()
	self._btnUpgrade:RemoveClickListener()
	self._btnDetail:RemoveClickListener()
end

function M:_setEvents(isOn)
	if isOn then
		GlobalDispatcher:addEventListener(EventType.SUPERVISOR_INFO_CHANGE, self._onSupervisorInfoChange, self)
		GlobalDispatcher:addEventListener(EventType.MANUFACTURE_PLANT_INFO_CHANGE, self._onManufactureInfoChange, self)
		GlobalDispatcher:addEventListener(EventType.TRADING_POST_INFO, self._onTradingInfoChange, self)
		GlobalDispatcher:addEventListener(EventType.HOUSE_HOLDROOM_INFO_CHANGE, self._onHoldroomInfoChange, self)
		GlobalDispatcher:addEventListener(EventType.HOUSE_PROTOMER_INFO_CHANGE, self._onProtomerInfoChange, self)
		HouseDispatcher:addEventListener(HouseEventType.LIVE_ZONE_ACTIVE, self._onRoomActive, self)
		HouseDispatcher:addEventListener(HouseEventType.LIVE_ZONE_INFO_REFRESH, self._onLiveZoneInfoChange, self)
		HouseDispatcher:addEventListener(HouseEventType.LIVING_ZONE_NAME_CHANGE, self._onLiveZoneNameChange, self)
		HouseDispatcher:addEventListener(HouseEventType.HOUSE_ROOM_RES_HAS_LOADED, self._onRoomResLoaded, self)
	else
		GlobalDispatcher:removeEventListener(EventType.SUPERVISOR_INFO_CHANGE, self._onSupervisorInfoChange, self)
		GlobalDispatcher:removeEventListener(EventType.MANUFACTURE_PLANT_INFO_CHANGE, self._onManufactureInfoChange, self)
		GlobalDispatcher:removeEventListener(EventType.TRADING_POST_INFO, self._onTradingInfoChange, self)
		GlobalDispatcher:removeEventListener(EventType.HOUSE_HOLDROOM_INFO_CHANGE, self._onHoldroomInfoChange, self)
		GlobalDispatcher:removeEventListener(EventType.HOUSE_PROTOMER_INFO_CHANGE, self._onProtomerInfoChange, self)
		HouseDispatcher:removeEventListener(HouseEventType.LIVE_ZONE_ACTIVE, self._onRoomActive, self)
		HouseDispatcher:removeEventListener(HouseEventType.LIVE_ZONE_INFO_REFRESH, self._onLiveZoneInfoChange, self)
		HouseDispatcher:removeEventListener(HouseEventType.LIVING_ZONE_NAME_CHANGE, self._onLiveZoneNameChange, self)
		HouseDispatcher:removeEventListener(HouseEventType.HOUSE_ROOM_RES_HAS_LOADED, self._onRoomResLoaded, self)
	end
end

function M:onEnter()
	self:initWindow()

	self._selectedRoomId = nil

	self:refreshView(false)
	LivingFacilitiesZoneController.instance:setIsInManageView(true)
	self:_setEvents(true)
end

function M:onExit(closeReasonType)
	self._maskShowTimer:stop()
	self:_setEvents(false)
	self:_setRoomForceLoadRes(false, closeReasonType ~= WindowType.WindowCloseReasonType.QuickCloseType)
	self._photoWindow:TurnOff()
	LivingFacilitiesZoneController.instance:setIsInManageView(false)
end

function M:initWindow()
	self._photoWindow:TurnOn(1624, 750)

	local photoProducer = self._photoWindow.producer

	Astral.TransformUtil.SetLocalPos(photoProducer.producerContainer.transform, 0, 0, 0)

	local layers = MainCameraMaskMode.Layers[HouseEnum.DEFAULT_CAMERA_MASK_MODE]
	local cullingMask = Astral.LayerUtil.GetLayerMask(unpack(layers))
	local camera = PhotoBaseExtension.GetCamera(self._photoWindow)

	camera.cullingMask = cullingMask

	PhotoBaseExtension.SetCameraTag(self._photoWindow, "RTCamera")
	PhotoBaseExtension.SetCameraPostProcessing(self._photoWindow, true, 0)
	PhotoBaseExtension.SetCameraPerspective(self._photoWindow, HouseEnum.DEFAULT_FOV)
end

function M:refreshView(onlySelected)
	if not onlySelected then
		table.sort(self._arrayProductRoomId, _sortRoom)
		table.sort(self._arrayShelterRoomId, _sortRoom)
		table.sort(self._arrayLivingRoomId, _sortRoom)
	end

	self:_trySelectRoom()

	local function _refreshItems(items, ids)
		for i, item in ipairs(items) do
			local roomId = ids[i]

			if not onlySelected then
				item:setRoomId(roomId)
			end

			item:setSelected(roomId == self._selectedRoomId)
		end
	end

	_refreshItems(self._arrayProductItem, self._arrayProductRoomId)
	_refreshItems(self._arrayShelterItem, self._arrayShelterRoomId)
	_refreshItems(self._arrayLivingItem, self._arrayLivingRoomId)
	self:_refreshDetailView()
	self:_refreshWindow()

	if onlySelected then
		self:_showMask()
	else
		goutil.setActive(self._goMask, false)
	end
end

function M:_trySelectRoom()
	local function _getSpecialRoom(ids)
		for _, roomId in ipairs(ids) do
			if dictRoomSortIdx[roomId] > 10 then
				return roomId
			end
		end
	end

	if not self._selectedRoomId then
		local specialRoomId = _getSpecialRoom(self._arrayProductRoomId)

		specialRoomId = specialRoomId or _getSpecialRoom(self._arrayShelterRoomId)
		specialRoomId = specialRoomId or _getSpecialRoom(self._arrayLivingRoomId)
		self._selectedRoomId = kDefaultSelectedRoomId

		self:_setRoomForceLoadRes(true)
	end
end

function M:_refreshDetailView()
	goutil.setActive(self._btnUpgrade.gameObject, false)
	goutil.setActive(self._btnDetail.gameObject, false)

	local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, self._selectedRoomId)
	local roomType = roomCO.roomType
	local openType = HouseMainRoomModel.instance:getRoomOpenTyp(self._selectedRoomId)

	if openType == RoomOpenTyp.UnOpen then
		-- block empty
	else
		local level = HouseMainUtil.getRoomLv(self._selectedRoomId)
		local lvStr = level > 0 and string.format("Lv.%s", level) or ""

		self._txtLv.text = lvStr
		self._txtName.text = HouseMainUtil.getRoomName(self._selectedRoomId)

		if openType == RoomOpenTyp.OpenLock then
			self._txtLv.text = ""
		elseif openType == RoomOpenTyp.OpenUnActive then
			self._txtLv.text = ""

			goutil.setActive(self._btnDetail.gameObject, true)

			self._txtBtnDetail.text = lang("tip_activate")
		elseif openType == RoomOpenTyp.OpenActive then
			local isNotSetting = HouseMainUtil.isRoomNotSetting(self._selectedRoomId)

			if isNotSetting then
				goutil.setActive(self._btnDetail.gameObject, true)

				self._txtBtnDetail.text = lang("tip_setting")
				self._txtLv.text = ""
			else
				goutil.setActive(self._btnDetail.gameObject, true)

				if roomType == RoomType.Shelter then
					goutil.setActive(self._btnUpgrade.gameObject, true)

					self._txtBtnDetail.text = lang("tip_goto_1")
				elseif roomType == RoomType.Living then
					self._txtBtnDetail.text = lang("tip_goto_1")
				else
					goutil.setActive(self._btnUpgrade.gameObject, true)

					self._txtBtnDetail.text = lang("tip_goto_1")
				end
			end
		end
	end
end

function M:_refreshWindow()
	local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, self._selectedRoomId)
	local pos = string.split(roomCO.focusPos, "#")

	self._photoWindow:SetCameraPosition(pos[1], pos[2], pos[3])
	self._photoWindow:SetCameraRotation(0, 0, roomCO.angle)
end

function M:_showMask()
	goutil.setActive(self._goMask, true)
	self._maskShowTimer:restart(kMaskShowTime, false)
end

function M:_hideMask()
	local roomUnit = HouseSceneUtil.getHouseRoomUnit(self._selectedRoomId)

	if roomUnit.resLoader:hasLoadedRes() then
		goutil.setActive(self._goMask, false)
	else
		self:_showMask()
	end
end

function M:_onClickBtnUpgrade()
	local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, self._selectedRoomId)
	local roomType = roomCO.roomType

	if roomType == RoomType.Shelter then
		local protomerId = ContainmentModel.instance:getProtomerId(self._selectedRoomId)

		ContainmentFacade.instance:openProtomerUpgradeView(protomerId)
	elseif self._selectedRoomId == HouseEnum.SUPERVISOR_ROOM_ID then
		self:_openSupervisorUpgradeView()
	elseif self._selectedRoomId == HouseEnum.MANUFACTURE_ROOM_ID then
		self:_openManufactureUpgradeView()
	elseif self._selectedRoomId == HouseEnum.TRADING_ROOM_ID then
		self:_openTradingUpgradeView()
	end
end

function M:_openSupervisorUpgradeView()
	local maxLv = SupervisorConfig.instance:getMaxLv()
	local currLv = SupervisorModel.instance:getSupervisorLv()

	if currLv < maxLv then
		ViewMgr.instance:open(ViewName.SupervisorUpgrade)
	else
		FloatWordMgr.instance:show(lang("tip_level_max_up_1"))
	end
end

function M:_openManufactureUpgradeView()
	local maxLv = SupervisorConfig.instance:getMaxModuleLv()
	local currLv = ManufactureModel.instance:getLv()

	if currLv < maxLv then
		ViewMgr.instance:open(ViewName.ManufactureUpgrade)
	else
		FloatWordMgr.instance:show(lang("tip_level_max_up_1"))
	end
end

function M:_openTradingUpgradeView()
	local maxLv = SupervisorConfig.instance:getMaxModuleLv()
	local mo = TradingModel.instance:getTradePostMo()
	local currLv = mo:getLevel()

	if currLv < maxLv then
		ViewMgr.instance:open(ViewName.TradingDeviceUpgrade)
	else
		FloatWordMgr.instance:show(lang("tip_level_max_up_1"))
	end
end

function M:_setRoomForceLoadRes(forceLoad, needUnloadRes)
	HouseDispatcher:dispatchEvent(HouseEventType.SET_FORCE_LOAD_ROOM_RES, self._selectedRoomId, forceLoad, needUnloadRes)
end

function M:_onClickBtnDetail()
	local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, self._selectedRoomId)
	local roomType = roomCO.roomType
	local openType = HouseMainRoomModel.instance:getRoomOpenTyp(self._selectedRoomId)

	if openType == RoomOpenTyp.UnOpen then
		-- block empty
	elseif openType == RoomOpenTyp.OpenLock then
		-- block empty
	elseif openType == RoomOpenTyp.OpenUnActive then
		HouseMainUtil.tryActiveZone(self._selectedRoomId, false)
	elseif openType == RoomOpenTyp.OpenActive then
		local isNotSetting = HouseMainUtil.isRoomNotSetting(self._selectedRoomId)

		if isNotSetting then
			if roomType == RoomType.Shelter then
				ContainmentFacade.instance:openHoldingChangeView(self._selectedRoomId - 1100)
			elseif roomType == RoomType.Living then
				LivingFacilitiesZoneController.instance:setCurrentZoneId(self._selectedRoomId)
				ViewMgr.instance:open(ViewName.LivingExchangeFacilityTips)
			end
		else
			SystemJumpController.instance:jumpToHouseRoomCustom(self._selectedRoomId)
		end
	end
end

function M:_onClickItem(roomId)
	if self._selectedRoomId ~= roomId then
		self:_setRoomForceLoadRes(false, true)

		self._selectedRoomId = roomId

		self:_setRoomForceLoadRes(true)
		self:refreshView(true)
	end
end

function M:_onSupervisorInfoChange()
	self:refreshView(false)
end

function M:_onManufactureInfoChange()
	self:refreshView(false)
end

function M:_onTradingInfoChange()
	self:refreshView(false)
end

function M:_onHoldroomInfoChange()
	self:refreshView(false)
end

function M:_onProtomerInfoChange()
	self:refreshView(false)
end

function M:_onRoomActive()
	return
end

function M:_onLiveZoneInfoChange()
	self:refreshView(false)
end

function M:_onLiveZoneNameChange()
	self:refreshView(false)
end

function M:_onRoomResLoaded(e, roomId)
	return
end

return M
