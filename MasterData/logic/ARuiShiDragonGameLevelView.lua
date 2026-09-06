-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aruishidragongame/view/ARuiShiDragonGameLevelView.lua

module("logic.extensions.aruishidragongame.view.ARuiShiDragonGameLevelView", package.seeall)

local ARuiShiDragonGameLevelView = class("ARuiShiDragonGameLevelView", ViewComponent)

function ARuiShiDragonGameLevelView:buildUI()
	ARuiShiDragonGameLevelView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnSimple = self:getBtn("btnSimple")
	self._btnNormal = self:getBtn("btnNormal")
	self._btnHard = self:getBtn("btnHard")
	self._txtNum = self:getTxt("txtNum")
end

function ARuiShiDragonGameLevelView:bindEvents()
	ARuiShiDragonGameLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSimple, self._onClickSimple, self)
	GameUtil.addClickHandler(self._btnNormal, self._onClickNormal, self)
	GameUtil.addClickHandler(self._btnHard, self._onClickHard, self)
end

function ARuiShiDragonGameLevelView:unbindEvents()
	ARuiShiDragonGameLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSimple)
	GameUtil.rmClickHandler(self._btnNormal)
	GameUtil.rmClickHandler(self._btnHard)
end

function ARuiShiDragonGameLevelView:onEnter()
	ARuiShiDragonGameLevelView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.ARuiShiDragonGameEndRes, self._onGameEndRes, self)

	self._activityId = self:getFirstParam()
	self._cfgActivity = ARuiShiDragonGameConfig.instance:getActivityCfg(self._activityId)
	self._maxDailyTimes = self._cfgActivity.dailyTimes

	self:_updateGameNum()
end

function ARuiShiDragonGameLevelView:onExit()
	ARuiShiDragonGameLevelView.super.onExit(self)
end

function ARuiShiDragonGameLevelView:_onClickSimple()
	if not self:_isLeftGameNum() then
		FloatWordMgr.instance:show("今日无剩余次数")

		return
	end

	local level = 1

	UIStateManager.instance:push(ViewName.ARuiShiDragonGameView, self._activityId, level)
end

function ARuiShiDragonGameLevelView:_onClickNormal()
	if not self:_isLeftGameNum() then
		FloatWordMgr.instance:show("今日无剩余次数")

		return
	end

	local level = 2

	UIStateManager.instance:push(ViewName.ARuiShiDragonGameView, self._activityId, level)
end

function ARuiShiDragonGameLevelView:_onClickHard()
	if not self:_isLeftGameNum() then
		FloatWordMgr.instance:show("今日无剩余次数")

		return
	end

	local level = 3

	UIStateManager.instance:push(ViewName.ARuiShiDragonGameView, self._activityId, level)
end

function ARuiShiDragonGameLevelView:_updateGameNum()
	local curNum = ARuiShiDragonGameModel.instance:getTodayTimes(self._activityId)
	local leftNum = Mathf.Max(0, self._maxDailyTimes - curNum)

	if leftNum > 0 then
		if not ColorConst.White then
			local colorStr = ColorConst.Red

			self._txtNum.text = string.format("今日剩余次数：<color=#%s>%d</color>/%d", colorStr, leftNum, self._maxDailyTimes)
		end
	end
end

function ARuiShiDragonGameLevelView:_isLeftGameNum()
	local curNum = ARuiShiDragonGameModel.instance:getTodayTimes(self._activityId)

	return curNum < self._maxDailyTimes
end

function ARuiShiDragonGameLevelView:_onGameEndRes()
	self:_updateGameNum()
end

return ARuiShiDragonGameLevelView
