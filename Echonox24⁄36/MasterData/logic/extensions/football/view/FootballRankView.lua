-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/football/view/FootballRankView.lua

module("logic.extensions.football.view.FootballRankView", package.seeall)

local M = class("FootballRankView", ViewComponent)

function M:buildUI()
	self._loopListHelper = LoopListHelper.New(self:getGo("football_ranking_tips_1399406689"))

	self._loopListHelper:InitListView(0, self._onCellUpdate, self)

	self._myRankView = Astral.LuaComponentContainer.Add(self:getGo("1&football_ranking_item_1466361685"), FootballRankCell)
	self._closeBtn = self:getBtn("3&middle_tips_common_bg_-1205189576")
	self._scrollGo = self:getGo("football_ranking_tips_1399406689")
	self._contentGo = self:getGo("football_ranking_tips_1163946668")

	self._loopListHelper:AddDragListener(self._onDrag, self)
end

function M:bindEvents()
	self._closeBtn:AddClickListener(self._onClickClose, self)
end

function M:_bindEvents()
	GlobalDispatcher:addEventListener(EventType.RANK_INFO_UPDATE, self._onNotifyRankUpdate, self)
end

function M:onEnter()
	self._noMoreRank = false
	self._perGotCount = 20

	self:_bindEvents()

	self._rankList = {}

	self:_sendReq()
end

function M:_onDrag()
	local maxY = goutil.getHeight(self._contentGo.transform) - goutil.getHeight(self._scrollGo.transform)

	if maxY < 0 then
		maxY = 0
	end

	if maxY + 10 < self._contentGo.transform.anchoredPosition.y then
		self:_sendReq()
	end

	printWarn(maxY, self._contentGo.transform.anchoredPosition.y)
end

function M:_sendReq()
	if self._hasSendReq then
		return
	end

	if self._noMoreRank then
		return
	end

	self._hasGotCount = #self._rankList

	RankAgent.instance:sendGetRankListRequest(GameEnum.RankEnum.FOOTBALL, self._hasGotCount + 1, self._hasGotCount + self._perGotCount)

	self._hasSendReq = true
end

function M:_onNotifyRankUpdate(_, rankId)
	self._hasSendReq = false
	self._myRankNO = RankNetModel.instance:getMyRankById(rankId)

	local rankList = RankNetModel.instance:getRankListById(rankId)

	for i, v in ipairs(rankList) do
		self._rankList[v.rank] = v
	end

	if #rankList == 0 then
		self._noMoreRank = true
	end

	self:_refreshView()
end

function M:_refreshView()
	self._loopListHelper:SetListItemCount(#self._rankList, false)
	self._myRankView:setData(self._myRankNO)
end

function M:_onCellUpdate(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local itemData = self._rankList[curIndex]
	local item = self._loopListHelper:NewListViewItem("football_ranking_item")
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, FootballRankCell)

	shower:setData(itemData)

	return item
end

function M:onExit()
	self:_unbindEvents()
	self._loopListHelper:ClearCells()
end

function M:unbindEvents()
	self._closeBtn:RemoveClickListener()
end

function M:_unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.RANK_INFO_UPDATE, self._onNotifyRankUpdate, self)
end

function M:_onClickClose()
	self:close()
end

function M:destroyUI()
	self._loopListHelper:RemoveDragListener()
	self._loopListHelper:Dispose()

	self._loopListHelper = nil
end

return M
