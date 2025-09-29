-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/view/LivingExchangeFacilityTipsView.lua

module("logic.extensions.livingfacilities.view.LivingExchangeFacilityTipsView", package.seeall)

local M = class("LivingExchangeFacilityTipsView", ViewComponent)

function M:buildUI()
	self._iconBg = self:getBigBg("living_exchange_facility_tips_-1629832703")
	self._currentSetGo = self:getGo("living_exchange_facility_tips_2125188506")
	self._txtName = self:getText("living_exchange_facility_tips_1952225140")
	self._txtHint = self:getText("living_exchange_facility_tips_330729996")
	self._countPointRootGo = self:getGo("living_exchange_facility_tips_1932786154")
	self._pointGo = self:getGo("living_exchange_facility_tips_954333718")
	self._btnPre = self:getBtn("living_exchange_facility_tips_588988824")
	self._btnNext = self:getBtn("living_exchange_facility_tips_-558458830")
	self._btnCancel = self:getBtn("health_tips_990624757")
	self._btnExchange = self:getBtn("health_tips_1992688632")
	self._imgBtnExchange = self:getImage("health_tips_1992688632")
	self._btnClose = self:getBtn("health_tips_-1683292806")
	self._atsIcon = self:getImage("living_exchange_facility_tips_803173590")
	self._goProductHint = self:getGo("living_exchange_facility_tips_232956524")
end

function M:destroyUI()
	self._iconBg:ClearImage()

	self._iconBg = nil
	self._currentSetGo = nil
	self._txtName = nil
	self._txtHint = nil
	self._countPointRootGo = nil
	self._pointGo = nil
	self._btnPre = nil
	self._btnNext = nil
	self._btnCancel = nil
	self._btnExchange = nil
	self._btnClose = nil
	self._atsIcon = nil
end

function M:bindEvents()
	self._btnPre:AddClickListener(self._onClickPre, self)
	self._btnNext:AddClickListener(self._onClickNext, self)
	self._btnCancel:AddClickListener(self._onClickCancel, self)
	self._btnExchange:AddClickListener(self._onClickExchange, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnPre:RemoveClickListener()
	self._btnNext:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnExchange:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function M:_bindEvents()
	return
end

function M:_unbindEvents()
	return
end

function M:_setEvent(add)
	if add then
		HouseDispatcher:addEventListener(HouseEventType.LIVE_ZONE_INFO_REFRESH, self._refreshInfo, self)
	else
		HouseDispatcher:removeEventListener(HouseEventType.LIVE_ZONE_INFO_REFRESH, self._refreshInfo, self)
	end
end

function M:onEnter()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Room)
	self:_bindEvents()
	self:_initView()
	self:_setEvent(true)
end

function M:onExit()
	self:_setEvent(false)
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Room)
	self:_unbindEvents()
	self._iconBg:ClearImage()
end

function M:_needExchangeEnsure()
	local needEnsure = false
	local type = self._zoneMo:getType()
	local furnitures = HouseFurnitureModel.instance:getRoomFurnitures(self._zoneMo:getId())

	if HouseSceneUtil.isDormitoryRoom(type) then
		if type == HouseEnum.LivingRoomType.SpecialDormitory then
			needEnsure = true
		else
			local members = self._zoneMo:getRoomMember()

			if #members > 0 then
				needEnsure = true
			else
				needEnsure = #furnitures > 0
			end
		end
	else
		needEnsure = #furnitures > 0
	end

	return needEnsure
end

function M:_onClickPre()
	self._currentIndex = self._currentIndex - 1

	if self._currentIndex <= 0 then
		self._currentIndex = #self._facilitiesList
	end

	self:_refreshView()
	self:_refreshPointView()
end

function M:_onClickNext()
	self._currentIndex = self._currentIndex + 1

	if self._currentIndex > #self._facilitiesList then
		self._currentIndex = 1
	end

	self:_refreshView()
	self:_refreshPointView()
end

function M:_onClickCancel()
	self:close()
end

function M:_onClickExchange()
	if self:_canExchange(true) then
		local type = self._zoneMo:getType()
		local facilitiesCo = self._facilitiesList[self._currentIndex]

		if type and type > 0 and self:_needExchangeEnsure() then
			ViewMgr.instance:open(ViewName.LivingExchangeFacilityEnsure, facilitiesCo.type)
		else
			LivingFacilitiesAgent.instance:sendChangeZoneTypeRequest(self._zoneMo:getId(), facilitiesCo.type)
			self:_onClickClose()
		end
	end
end

function M:_onClickClose()
	self:close()
end

function M:_canExchange(showFloatWord)
	local canExchange = true
	local facilitiesCo = self._facilitiesList[self._currentIndex]

	if self._zoneMo:getType() == facilitiesCo.type then
		canExchange = false

		if showFloatWord then
			FloatWordMgr.instance:show(lang("tip_living_room_exchange_lang_1"))
		end
	elseif facilitiesCo.type == HouseEnum.LivingRoomType.SpecialDormitory then
		local currCount = LivingFacilitiesZoneModel.instance:getSpRoomCount()
		local maxCount = SupervisorModel.instance:getSpRoomMaxCount()

		if maxCount <= currCount then
			canExchange = false

			if showFloatWord then
				FloatWordMgr.instance:show(lang("tip_living_room_exchange_lang_2"))
			end
		end
	end

	return canExchange
end

function M:_initView()
	self._zoneMo = LivingFacilitiesZoneController.instance:getCurrentZoneMo()
	self._facilitiesList = LivingFacilitiesZoneController.instance:getAllFacilitiesBySize(self._zoneMo:getSize())
	self._currentIndex = 1

	self:_refreshView()
	self:_refreshPointView()
end

function M:_refreshView()
	local facilitiesCo = self._facilitiesList[self._currentIndex]

	self._iconBg:SetImage(string.format("ui/dynicon/room/room_live_template/%s.png", facilitiesCo.bgIcon), nil, self)
	goutil.setActive(self._currentSetGo, self._zoneMo:getType() == facilitiesCo.type)

	local nameStr = facilitiesCo.name

	if facilitiesCo.type == HouseEnum.LivingRoomType.SpecialDormitory then
		local currCount = LivingFacilitiesZoneModel.instance:getSpRoomCount()
		local maxCount = SupervisorModel.instance:getSpRoomMaxCount()

		nameStr = string.format("%s  %s/%s", nameStr, currCount, maxCount)
	end

	self._txtName.text = nameStr
	self._txtHint.text = facilitiesCo.hint

	local atmosphereType = facilitiesCo.atmosphere > 0 and facilitiesCo.atmosphere or 1

	HouseMainUtil.changAtmosphereIcon(self._atsIcon, atmosphereType)
	goutil.setActive(self._goProductHint, facilitiesCo.type == HouseEnum.LivingRoomType.SpecialDormitory)

	local colorStr = self:_canExchange() and "#FF3E48" or "#808080"

	self._imgBtnExchange.color = parsecolor(colorStr)
end

function M:_refreshPointView()
	for i = 0, self._countPointRootGo.transform.childCount - 1 do
		local obj = goutil.findChild(self._countPointRootGo, "point_" .. i + 1)

		goutil.setActive(obj, false)
	end

	for i, facilities in ipairs(self._facilitiesList) do
		local obj = goutil.findChild(self._countPointRootGo, "point_" .. i)

		if not obj then
			obj = goutil.clone(self._pointGo, "point_" .. i)

			goutil.addChildToParent(obj, self._countPointRootGo)
		end

		goutil.setActive(obj, true)

		local select = goutil.findChild(obj, "select")
		local noselect = goutil.findChild(obj, "noselect")

		goutil.setActive(select, i == self._currentIndex)
		goutil.setActive(noselect, i ~= self._currentIndex)
	end
end

function M:_refreshInfo()
	self:_refreshView()
end

return M
