-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarymarket/view/AnniversaryMarketRewardLevelView.lua

module("logic.extensions.anniversarymarket.view.AnniversaryMarketRewardLevelView", package.seeall)

local AnniversaryMarketRewardLevelView = class("AnniversaryMarketRewardLevelView", ViewComponent)

function AnniversaryMarketRewardLevelView:ctor()
	AnniversaryMarketRewardLevelView.super.ctor(self)
end

function AnniversaryMarketRewardLevelView:unbindEvents()
	AnniversaryMarketRewardLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function AnniversaryMarketRewardLevelView:bindEvents()
	AnniversaryMarketRewardLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function AnniversaryMarketRewardLevelView:buildUI()
	AnniversaryMarketRewardLevelView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtCurScore = self:getTxt("total/txtCurScore")
	self._txtReward = self:getTxt("tip/txtReward")
	self._rewardcell = self:getGo("rewardcell")
	self._tableview = self:getGo("tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._rewardcell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._progressSlider = self:getSlider("tableview/viewport/content/progressSlider")
	self._tabTableview = self:getGo("tabTableview")
	self._btnTabCell = self:getGo("btnTabCell")
	self._scrollTabList = ScrollerList.create(self._tabTableview, self._btnTabCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
end

function AnniversaryMarketRewardLevelView:onExit()
	AnniversaryMarketRewardLevelView.super.onExit(self)
	self._scrollList:dispose()
	self._scrollTabList:dispose()
end

function AnniversaryMarketRewardLevelView:onEnter()
	AnniversaryMarketRewardLevelView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._curTabIdx = params[2] or 1
	self._info = AnniversaryMarketModel.instance:getInfo(self._activityId)
	self._actCfg = AnniversaryMarketConfig.instance:getActCfg(self._activityId)
	self._poolCfg = AnniversaryMarketConfig.instance:getPrizePoolCfg(self._activityId)
	self._prizeLevelCfg = AnniversaryMarketConfig.instance:getPrizeLevelCfgByPoolId(self._activityId, self._curTabIdx)

	self:_onSetUI()
end

function AnniversaryMarketRewardLevelView:_onSetUI()
	self._txtCurScore.text = self._info.totalRefreshTimes

	local curCfg
	local curCfgIdx, scoreList = self:_getCurCfgIdxAndScoreList()
	local curCfg = self._prizeLevelCfg[curCfgIdx]

	self._txtReward.text = curCfg.refreshRewardDesc

	self._scrollTabList:reloadData(self._poolCfg)
	self._scrollList:reloadData(self._prizeLevelCfg)
	self._scrollList:updateUnderSlider(self._progressSlider, self._info.totalRefreshTimes, scoreList)
end

function AnniversaryMarketRewardLevelView:_updateRewardCell(view, cell, data)
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local txtLevel = goutil.findChildTextComponent(cell, "txtLevel")

	txtDesc.text = data.refreshEffect
	txtLevel.text = data.refreshNum
end

function AnniversaryMarketRewardLevelView:_clearRewardCell(cell)
	return
end

function AnniversaryMarketRewardLevelView:_updateTabCell(view, cell, data)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local changeGroup = cell:GetComponent(ComponentType.UIChangeGroup)

	txtName.text = data.prizePoolName

	changeGroup:SetState(self._curTabIdx == data.prizePoolId and 1 or 0)
	GameUtil.addClickHandler(cell.gameObject, function()
		self._curTabIdx = data.prizePoolId
		self._prizeLevelCfg = AnniversaryMarketConfig.instance:getPrizeLevelCfgByPoolId(self._activityId, self._curTabIdx)

		local curCfgIdx, scoreList = self:_getCurCfgIdxAndScoreList()
		local curCfg = self._prizeLevelCfg[curCfgIdx]

		self._txtReward.text = curCfg.refreshRewardDesc

		self._scrollTabList:reloadData(self._poolCfg)
		self._scrollList:reloadData(self._prizeLevelCfg)
		self._scrollList:updateUnderSlider(self._progressSlider, self._info.totalRefreshTimes, scoreList)
	end, self)
end

function AnniversaryMarketRewardLevelView:_clearTabCell(cell)
	GameUtil.rmClickHandler(cell.gameObject)
end

function AnniversaryMarketRewardLevelView:_getCurCfgIdxAndScoreList()
	local curCfgIdx = 0
	local scoreList = {}

	for i, cfg in ipairs(self._prizeLevelCfg) do
		table.insert(scoreList, cfg.refreshNum)

		if self._info.totalRefreshTimes >= cfg.refreshNum then
			curCfgIdx = i
		end
	end

	if curCfgIdx == 0 then
		curCfgIdx = 1
	end

	return curCfgIdx, scoreList
end

return AnniversaryMarketRewardLevelView
