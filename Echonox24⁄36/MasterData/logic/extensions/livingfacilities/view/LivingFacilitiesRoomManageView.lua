-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/view/LivingFacilitiesRoomManageView.lua

module("logic.extensions.livingfacilities.view.LivingFacilitiesRoomManageView", package.seeall)

local M = class("LivingFacilitiesRoomManageView", ViewComponent)

function M:buildUI()
	self._txtLevel = self:getText("room_live_manage_view_1651817245")
	self._txtPeople = self:getText("room_live_manage_view_768877417")
	self._txtSize = self:getText("room_live_manage_view_814355202")
	self._txtDesc = self:getText("room_live_manage_view_1475580438")
	self._txtAtmos = self:getText("room_live_manage_view_1947157614")
	self._txtGreen = self:getText("room_live_manage_view_2140302601")
	self._txtMood = self:getText("room_live_manage_view_1441770327")
	self._txtFavor = self:getText("room_live_manage_view_1392670481")
	self._inputName = self:getText("room_live_manage_view_676226150")
	self._txtTitleName = self:getText("0&title_view_-788888785")
	self._btnEdit = self:getBtn("room_live_manage_view_2054590023")
	self._btnExchange = self:getBtn("room_live_manage_view_-365859099")
	self._btnReturn = self:getBtn("0&title_view_-878360263")
	self._specialItem = self:getGo("room_live_manage_view_1626384009")
	self._specialIcon = self:getImage("room_live_manage_view_604439445")
	self._specialText = self:getText("room_live_manage_view_1268574066")
end

function M:destroyUI()
	self._txtLevel = nil
	self._txtPeople = nil
	self._txtSize = nil
	self._txtDesc = nil
	self._txtAtmos = nil
	self._txtGreen = nil
	self._txtMood = nil
	self._txtFavor = nil
	self._inputName = nil
	self._txtTitleName = nil
	self._btnEdit = nil
	self._btnExchange = nil
	self._btnReturn = nil
end

function M:bindEvents()
	self._btnEdit:AddClickListener(self._onClickEdit, self)
	self._btnExchange:AddClickListener(self._onClickExchange, self)
	self._btnReturn:AddClickListener(self._onClickReturn, self)
end

function M:unbindEvents()
	self._btnEdit:RemoveClickListener()
	self._btnExchange:RemoveClickListener()
	self._btnReturn:RemoveClickListener()
end

function M:_setEvent(add)
	if add then
		HouseDispatcher:addEventListener(HouseEventType.LIVING_ZONE_NAME_CHANGE, self._refreshName, self)
		HouseDispatcher:addEventListener(HouseEventType.LIVE_ZONE_INFO_REFRESH, self._refreshView, self)
	else
		HouseDispatcher:removeEventListener(HouseEventType.LIVING_ZONE_NAME_CHANGE, self._refreshName, self)
		HouseDispatcher:removeEventListener(HouseEventType.LIVE_ZONE_INFO_REFRESH, self._refreshView, self)
	end
end

function M:_bindEvents()
	return
end

function M:_unbindEvents()
	return
end

function M:onEnter()
	self:_setEvent(true)
	self:_bindEvents()
	self:_refreshView()
end

function M:onExit()
	self:_setEvent(false)
	self:_unbindEvents()
	ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Anim)
end

function M:_onClickReturn()
	self:back()

	if not LivingFacilitiesZoneController.instance:isInManageView() then
		ViewMgr.instance:open(ViewName.LivingFacilitiesMain)
	end
end

function M:_onClickEdit()
	local info = {}

	info.callBackFunc = self._callBackFunc
	info.callBackHandle = self

	local zoneMo = LivingFacilitiesZoneController.instance:getCurrentZoneMo()

	info.defaultName = zoneMo and zoneMo:getName() or ""
	info.charLimit = 5

	ViewMgr.instance:open(ViewName.EditCommonTip, info)
end

function M:_callBackFunc(name)
	local zoneId = LivingFacilitiesZoneController.instance:getCurrentZoneId()

	LivingFacilitiesAgent.instance:sendSetZoneNameRequest(zoneId, name)
end

function M:_onClickExchange()
	ViewMgr.instance:open(ViewName.LivingExchangeFacilityTips)
end

function M:_refreshView()
	local zoneMo = LivingFacilitiesZoneController.instance:getCurrentZoneMo()

	if zoneMo then
		self._txtLevel.text = string.format("Lv.%s", zoneMo:getAtmosphereLevel())
		self._txtPeople.text = string.format("%s/%s", zoneMo:getInRoomHeroCount(), zoneMo:getHeroCount())
		self._txtSize.text = string.format("设施规格 %s", zoneMo:getSizeName())
		self._txtDesc.text = zoneMo:getFacilitiesDesc()
		self._txtAtmos.text = zoneMo:getAtmosphere()

		if zoneMo:getTypeName() then
			goutil.setActive(self._specialItem, true)

			self._txtGreen.text = zoneMo:getAtmosphereSpecial()
			self._specialText.text = string.format("%s值", zoneMo:getTypeName())

			HouseMainUtil.changAtmosphereIcon(self._specialIcon, zoneMo:getAtmosType())
		else
			goutil.setActive(self._specialItem, false)
		end

		local atmos = LivingFacilitiesZoneModel.instance:getNormalAtmosphereValue()

		self._txtMood.text = LivingFacilitiesZoneController.instance:getMoodAddByBasicsNum(atmos)

		self:_refreshName()
		goutil.setActive(self._btnEdit.gameObject, HouseSceneUtil.isDormitoryRoom(zoneMo:getType()))
	else
		goutil.setActive(self._btnEdit.gameObject, false)
	end
end

function M:_refreshName()
	local zoneMo = LivingFacilitiesZoneController.instance:getCurrentZoneMo()

	if zoneMo then
		self._txtTitleName.text = zoneMo:getName()
		self._inputName.text = zoneMo:getName()
	end
end

return M
