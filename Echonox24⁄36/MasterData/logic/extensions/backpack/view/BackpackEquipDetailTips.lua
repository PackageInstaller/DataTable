-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/BackpackEquipDetailTips.lua

module("logic.extensions.backpack.view.BackpackEquipDetailTips", package.seeall)

local M = class("BackpackEquipDetailTips", EquipDetailInfoComponent)

function M:ctor(compContainer)
	M.super.ctor(self, compContainer)
end

function M:bindEvents()
	M.super.bindEvents(self)
	self._btnDetail:AddClickListener(self._onClickDetail, self)
	GlobalDispatcher:addEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self.refreshView, self)
end

function M:unbindEvents()
	M.super.unbindEvents(self)
	self._btnDetail:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self.refreshView, self)
end

function M:buildUI()
	M.super.buildUI(self)
	self._btnDetail:setActive(true)
end

function M:onEnter()
	self:bindEvents()
end

function M:onExit()
	self:unbindEvents()
end

function M:refreshTip(mo)
	self:setEquipData(mo)

	if mo:getRedPointIsNew() then
		local itemid = mo:getUuid()
		local type = GameEnum.ItemTypeEnum.EquipItemType

		BackpackAgent.instance:sendremoveRedPointRequest(type, {
			itemid
		})
	end
end

function M:_onClickDetail()
	EquipIntensifyController.instance:setOperatingEquip(self._equipMo)
	ViewMgr.instance:open(ViewName.EquipIntensifyAndDetailView, EquipEnum.IntensifyViewPage.Detail)
end

function M:_refreshHeadIcon()
	goutil.setActive(self._headGo, false)
end

return M
