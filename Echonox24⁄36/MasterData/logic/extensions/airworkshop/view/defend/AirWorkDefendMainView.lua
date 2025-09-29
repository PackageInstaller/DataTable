-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/defend/AirWorkDefendMainView.lua

module("logic.extensions.airworkshop.view.defend.AirWorkDefendMainView", package.seeall)

local M = class("AirWorkDefendMainView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._loopListHelper = LoopListHelper.New(self:getGo("defend_create_schema_view_1990248901"))

	self._loopListHelper:InitListView(0, self._onCellUpdate, self)
end

function M:bindEvents()
	return
end

function M:onEnter()
	self:_initPlanList()
end

function M:_initPlanList()
	self._curSelectIndex = 1

	local planCount = AirWorkMapModel.instance:getPlanCount()

	self._planList = {}

	for i = 1, planCount do
		self._planList[i] = {}
	end

	local levelMOList = AirWorkMapModel.instance:getAllLevelMO()
	local moList = {}

	for i, v in ipairs(levelMOList) do
		table.insert(moList, v)
	end

	table.sort(moList, function(moA, moB)
		local isOnlineA = moA:getOnlineStatus() and 1 or 0
		local isOnlineB = moB:getOnlineStatus() and 1 or 0

		if isOnlineA == isOnlineB then
			return moA:getId() > moB:getId()
		else
			return isOnlineB < isOnlineA
		end
	end)

	for i, v in ipairs(moList) do
		self._planList[i].levelMo = v
	end

	self._loopListHelper:SetListItemCount(#self._planList, true)
end

function M:_onCellUpdate(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local itemData = self._planList[curIndex]
	local item = self._loopListHelper:NewListViewItem("create_level_item")
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, AirWorkLevelTabCell)

	shower:setData(itemData.levelMo, curIndex, self._curSelectIndex)

	return item
end

function M:onExit()
	self:_unbindEvents()
	self._loopListHelper:ClearCells()
end

function M:destroyUI()
	self._loopListHelper:Dispose()

	self._loopListHelper = nil
end

return M
