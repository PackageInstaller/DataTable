-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/view/monitor/MonitorUseItemView.lua

module("logic.extensions.controlaction.view.monitor.MonitorUseItemView", package.seeall)

local M = class("MonitorUseItemView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._txtDesc = self:getText("regulatory_monitor_time_open_tips_296942332")
	self._btnClose = self:getBtn("regulatory_monitor_time_open_tips_2094289739")
	self._btnSmall = self:getBtn("regulatory_monitor_time_open_tips_-1837285426")
	self._btnSure = self:getBtn("regulatory_monitor_time_open_tips_67049254")
	self._btnCancel = self:getBtn("regulatory_monitor_time_open_tips_-1665591347")
	self._itemCell = Astral.SimpleLuaComponentContainer.Add(self:getGo("0&rewards_detail_item_2141037416"), ItemCell)

	self._itemCell:setShowSelectedEffect(false)
	goutil.setActive(self._btnSmall.gameObject, false)
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnSmall:AddClickListener(self._onClickSmall, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
	self._btnCancel:AddClickListener(self._onClickCancel, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnSmall:RemoveClickListener()
	self._btnSure:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
end

function M:onEnter()
	local itemId = AirtightRoomUtil.getItemId()
	local count = ItemModel.instance:getItemCountByItemId(itemId)
	local itemData = ItemUtil.createItemData({
		itemId = itemId
	})

	self._itemCell:updateData(itemData)
	self._itemCell:getComponent("num"):setCountText("")
	self._itemCell:getComponent("num"):setCostText(string.format("%s/%s", count, 1))
	self._itemCell:getComponent("num"):setCostTextActive(true)

	self._txtDesc.text = lang("tip_controlaction_monitor_useitem")
end

function M:onExit()
	return
end

function M:onExitFinished()
	return
end

function M:_onClickSure()
	local itemId = AirtightRoomUtil.getItemId()
	local count = ItemModel.instance:getItemCountByItemId(itemId)

	if count <= 0 then
		FloatWordMgr.instance:show(lang("tip_controlaction_monitor_item_lack"))

		return
	end

	AirtightRoomAgent.instance:sendEnterAirtightRoomRequest()
	self:close()
end

function M:_onClickCancel()
	self:close()
end

function M:_onClickClose()
	self:close()
end

function M:_onClickSmall()
	self:close()
end

return M
