-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/view/LivingFacilitiesEntryPanelView.lua

module("logic.extensions.livingfacilities.view.LivingFacilitiesEntryPanelView", package.seeall)

local M = class("LivingFacilitiesEntryPanelView")
local LivingRoomType = HouseEnum.LivingRoomType
local kMaxHeroNum = 4
local kRefreshInterval = 5

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self._mainGo)

	self:_buildUI()
end

function M:_buildUI()
	self._btnFacilityManage = Astral.ButtonAdapter.Get(self._registry:findUIElement("room_live_entry_panel_-720780025"))
	self._btnPersonnelManage = Astral.ButtonAdapter.Get(self._registry:findUIElement("room_live_entry_panel_-1497656049"))
	self._btnCloth = Astral.ButtonAdapter.Get(self._registry:findUIElement("room_live_entry_panel_-1020294292"))
	self._btnHint = Astral.ButtonAdapter.Get(self._registry:findUIElement("room_live_entry_panel_543039616"))
	self._basicsNum = self._registry:findUIElement("room_live_entry_panel_-2093640169", UIComponentType.Text)
	self._dormNum = self._registry:findUIElement("room_live_entry_panel_-492523077", UIComponentType.Text)
	self._rightTopGo = self._registry:findUIElement("room_live_entry_panel_1138402587")
	self._goBg = self._registry:findUIElement("room_live_entry_panel_-200967180")
	self._goDorm = self._registry:findUIElement("room_live_entry_panel_-576678403")
	self._goHerosRoot = self._registry:findUIElement("room_live_entry_panel_-161032117")
	self._arrayHeroItem = {}

	for i = 1, kMaxHeroNum do
		local itemGO = goutil.findChild(self._goHerosRoot, string.format("cell_%s/room_head", i))
		local heroItem = Astral.LuaComponentContainer.Add(itemGO, RoomWorkerItem)

		heroItem:setClickCallback(self._onClickHeroItem, self)
		table.insert(self._arrayHeroItem, heroItem)
	end

	self._btnProduct = Astral.ButtonAdapter.Get(self._registry:findUIElement("room_live_entry_panel_-927900957"))
	self._imgProgress = goutil.findChildImageComponent(self._btnProduct.gameObject, "fill")
	self._imgProductIcon = goutil.findChildImageComponent(self._btnProduct.gameObject, "icon")
	self._txtProgress = goutil.findChildTextComponent(self._btnProduct.gameObject, "txtProgress")
	self._refreshTimer = SchedulerCtrl.New(self._refreshProductProgress, self)
	self._hintGo = self._registry:findUIElement("room_live_entry_panel_480024534")
	self._markView = Astral.LuaComponentContainer.Add(self._hintGo, LivingFacilitiesMarkView)
end

function M:_bindEvents()
	self._btnFacilityManage:AddClickListener(self._onClickBtnFacilityManage, self)
	self._btnPersonnelManage:AddClickListener(self._onClickBtnPersonnelManage, self)
	self._btnCloth:AddClickListener(self._onClickBtnCloth, self)
	self._btnHint:AddClickListener(self._onClickBtnHint, self)
	self._btnProduct:AddClickListener(self._onClickBtnProduct, self)
end

function M:_unbindEvents()
	self._btnFacilityManage:RemoveClickListener()
	self._btnPersonnelManage:RemoveClickListener()
	self._btnCloth:RemoveClickListener()
	self._btnHint:RemoveClickListener()
	self._btnProduct:RemoveClickListener()
end

function M:onEnter()
	self:_bindEvents()
	self:_setEvent(true)
	self:_refreshInfo()
end

function M:onExit()
	self._refreshTimer:stop()
	self:_setEvent(false)
	self:_unbindEvents()
end

function M:OnDestroy()
	self:_destroyUI()
end

function M:_setEvent(add)
	if add then
		HouseDispatcher:addEventListener(HouseEventType.LIVE_ZONE_INFO_REFRESH, self._refreshInfo, self)
		HouseDispatcher:addEventListener(HouseEventType.HOUSE_FURNITURES_UPDATE, self._onFurnitureUpdate, self)
		HouseDispatcher:addEventListener(HouseEventType.LIVE_PRODUCT_UPDATE, self._onProductUpdate, self)
	else
		HouseDispatcher:removeEventListener(HouseEventType.LIVE_ZONE_INFO_REFRESH, self._refreshInfo, self)
		HouseDispatcher:removeEventListener(HouseEventType.HOUSE_FURNITURES_UPDATE, self._onFurnitureUpdate, self)
		HouseDispatcher:removeEventListener(HouseEventType.LIVE_PRODUCT_UPDATE, self._onProductUpdate, self)
	end
end

function M:_destroyUI()
	self._refreshTimer:clear()

	self._refreshTimer = nil

	self._registry:cleanRegistry()

	self._registry = nil
	self._btnFacilityManage = nil
	self._btnPersonnelManage = nil
	self._btnCloth = nil
	self._btnHint = nil
	self._compContainer = nil
	self._mainGo = nil
	self._markView = nil
end

function M:_refreshHeros()
	local zoneMo = LivingFacilitiesZoneController.instance:getCurrentZoneMo()
	local bunkList = zoneMo:getBunkList()

	for idx, heroItem in ipairs(self._arrayHeroItem) do
		local bunkInfo = bunkList[idx]

		if bunkInfo then
			heroItem:setVisible(true)

			if bunkInfo.heroId > 0 then
				heroItem:setHero(bunkInfo.heroId)
			else
				heroItem:setNone()
			end
		else
			heroItem:setVisible(false)
		end
	end
end

function M:_onClickBtnFacilityManage()
	local zoneMo = LivingFacilitiesZoneController.instance:getCurrentZoneMo()

	if zoneMo and zoneMo:getType() ~= 0 then
		ViewMgr.instance:open(ViewName.LivingFacilitiesRoomManage)
	else
		ViewMgr.instance:open(ViewName.LivingExchangeFacilityTips)
	end
end

function M:_onClickBtnPersonnelManage()
	ViewMgr.instance:open(ViewName.LivingFacilitiesAdjustSchedule)
end

function M:_onClickBtnCloth()
	HouseDispatcher:dispatchEvent(HouseEventType.LIVE_CLOTH_OPEN)
end

function M:_onClickBtnHint()
	ViewMgr.instance:open(ViewName.LivingFacilitiesAtmosValueTip)
end

function M:_onClickBtnProduct()
	local zoneMo = LivingFacilitiesZoneController.instance:getCurrentZoneMo()
	local currStore = zoneMo:getCurrStore()

	if currStore > 0 then
		ViewMgr.instance:open(ViewName.LivingFacilitiesProduct)
	elseif zoneMo:getInRoomHeroCount() > 0 then
		ViewMgr.instance:open(ViewName.LivingFacilitiesProduct)
	else
		local bunkList = zoneMo:getBunkList()

		if #bunkList > 0 then
			local dialog = Dialog.showWarnMessage(lang("tip_title"), lang("tip_product_fragment_lang_2"))

			dialog:setConfirmListener(function()
				ViewMgr.instance:open(ViewName.LivingFacilitiesAdjustSchedule)
			end, self)
		else
			FloatWordMgr.instance:show(lang("tip_product_fragment_lang_3"))
		end
	end
end

function M:_onClickHeroItem(item)
	self:_onClickBtnPersonnelManage()
end

function M:_refreshInfo(e, zoneId)
	local zoneMo = LivingFacilitiesZoneController.instance:getCurrentZoneMo()

	if zoneMo then
		local atmosTotal = LivingFacilitiesZoneModel.instance:getNormalAtmosphereValue()
		local basicsNum = LivingFacilitiesZoneController.instance:getMoodAddByBasicsNum(atmosTotal) * 60

		self._basicsNum.text = string.format("%.1f", LivingFacilitiesZoneController.instance:formatAtmosphereValue(basicsNum, 1))

		local atmos = zoneMo:getAtmosphere()
		local dormNum = LivingFacilitiesZoneController.instance:getMoodAddByDormNum(atmos) * 60

		self._dormNum.text = string.format("%.1f", dormNum - dormNum % 0.1)

		goutil.setActive(self._btnPersonnelManage.gameObject, zoneMo:getHeroCount() ~= 0)
		goutil.setActive(self._btnCloth.gameObject, zoneMo:getType() ~= 0)
		goutil.setActive(self._rightTopGo, zoneMo:getType() ~= 0)

		local isDormitory = HouseSceneUtil.isDormitoryRoom(zoneMo:getType())

		goutil.setActive(self._goDorm, isDormitory)

		local bottom = isDormitory and 0 or 98
		local minX = self._goBg.transform.offsetMin.x

		self._goBg.transform.offsetMin = Vector2.New(minX, bottom)
	end

	self:_refreshHeros()
	self:_refreshProduct()
	self:_refreshMarks()
end

function M:_refreshProduct()
	self._refreshTimer:stop()

	local zoneMo = LivingFacilitiesZoneController.instance:getCurrentZoneMo()

	if zoneMo and zoneMo:getType() == HouseEnum.LivingRoomType.SpecialDormitory then
		goutil.setActive(self._btnProduct.gameObject, true)

		local fragmentId = zoneMo:getShowFragmentId()

		if fragmentId then
			goutil.setActive(self._imgProductIcon.gameObject, true)

			local itemCo = BackpackConfig.instance:getItemInfoByItemId(fragmentId)

			IconLoader.setSprite(self._imgProductIcon, IconType.ItemIcon, itemCo.icon)
		else
			goutil.setActive(self._imgProductIcon.gameObject, false)
		end

		local currStore = zoneMo:getCurrStore()
		local limitStore = zoneMo:getLimitStore()

		if zoneMo:getInRoomHeroCount() > 0 then
			if currStore <= 0 then
				self:_refreshProductProgress()
				self._refreshTimer:restart(kRefreshInterval, true)
			else
				self._imgProgress.fillAmount = 1
			end
		else
			self._imgProgress.fillAmount = 0
		end

		self._txtProgress.text = string.format("%s/%s", currStore, limitStore)
	else
		goutil.setActive(self._btnProduct.gameObject, false)
	end
end

function M:_refreshProductProgress()
	local zoneMo = LivingFacilitiesZoneController.instance:getCurrentZoneMo()

	self._imgProgress.fillAmount = zoneMo:getNextProductProgress()
end

function M:_refreshMarks()
	local genderMark = LivingFacilitiesZoneController.instance:getGenderMark()
	local campMark = LivingFacilitiesZoneController.instance:getCampMark()

	self._markView:updateData(genderMark, campMark)
end

function M:_onFurnitureUpdate(e, bunkFurnChange)
	if bunkFurnChange then
		local zoneId = LivingFacilitiesZoneController.instance:getCurrentZoneId()

		if zoneId then
			LivingFacilitiesAgent.instance:sendGetLiveZoneInfoRequest(zoneId)
		end
	end

	self:_refreshHeros()
	self:_refreshProduct()
end

function M:_onProductUpdate()
	self:_refreshProduct()
end

return M
