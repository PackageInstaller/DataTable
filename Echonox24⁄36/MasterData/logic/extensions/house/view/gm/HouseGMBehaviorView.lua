-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/view/gm/HouseGMBehaviorView.lua

module("logic.extensions.house.view.gm.HouseGMBehaviorView", package.seeall)

local M = class("HouseGMBehaviorView", ViewComponent)
local kItemName = "gmItem"

function M:buildUI()
	self._scroll = Astral.ScrollRectLoop.Get(self:getGo("behavior_tree_select_tips_-1644766839"))

	self._scroll:InitFix(kScrollDirV, 300, 50, 200, 15, 2, self._onCellUpdate, self)

	self._goScrollContent = self:getGo("behavior_tree_select_tips_-1994358518")
	self._btnConfirm = self:getBtn("behavior_tree_select_tips_-1850787053")
	self._btnCancel = self:getBtn("behavior_tree_select_tips_-1771286663")
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnConfirm:AddClickListener(self._onClickBtnConfirm, self)
	self._btnCancel:AddClickListener(self._onClickBtnCancel, self)
end

function M:unbindEvents()
	self._btnConfirm:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
end

function M:onEnter()
	self._paramData = self:getFirstParam() or {}
	self._selectedBehavior = HouseGMController.instance:getFocusBehavior()
	self._behaviors = HouseGMController.instance:getEffectBehaviors()
	self._scroll.TotalCellNum = #self._behaviors
end

function M:onExit()
	self._scroll.TotalCellNum = 0

	self:_clear()
end

function M:_clear()
	local count = self._goScrollContent.transform.childCount

	for i = 0, count - 1 do
		local cellTrf = self._goScrollContent.transform:GetChild(i)
		local itemGO = goutil.findChild(cellTrf.gameObject, kItemName)

		if itemGO then
			gmItem = Astral.LuaComponentContainer.Get(itemGO, HouseGMBehaviorItem)

			gmItem:destroy()
			goutil.destroy(itemGO)
		end
	end
end

function M:_onCellUpdate(cellTransform, index, preIndex)
	index = index + 1

	local itemGO = goutil.findChild(cellTransform.gameObject, kItemName)
	local gmItem

	if not itemGO then
		itemGO = self:getResInstance(ResName.Main_behavior_tree_select_item)
		itemGO.name = kItemName

		goutil.addChildToParent(itemGO, cellTransform.gameObject)

		gmItem = Astral.LuaComponentContainer.Add(itemGO, HouseGMBehaviorItem)

		gmItem:setHandler(self)
	else
		gmItem = Astral.LuaComponentContainer.Get(itemGO, HouseGMBehaviorItem)
	end

	local behavior = self._behaviors[index]

	gmItem:setBehaviorType(behavior)
	gmItem:setSelected(self._selectedBehavior == behavior)
end

function M:changeBehavior(behavior, isOn)
	if isOn then
		self._selectedBehavior = behavior
	elseif self._selectedBehavior == behavior then
		self._selectedBehavior = false
	end

	self._scroll:UpdateVisualCells()
end

function M:_onClickBtnConfirm()
	HouseGMController.instance:setFocusBehavior(self._selectedBehavior)

	if self._paramData.confirmCallback then
		self._paramData.confirmCallback(self._paramData.confirmTarget)
	end

	self:close()
end

function M:_onClickBtnCancel()
	self:close()
end

return M
