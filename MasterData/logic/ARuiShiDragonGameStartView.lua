-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aruishidragongame/view/ARuiShiDragonGameStartView.lua

module("logic.extensions.aruishidragongame.view.ARuiShiDragonGameStartView", package.seeall)

local ARuiShiDragonGameStartView = class("ARuiShiDragonGameStartView", ViewComponent)

function ARuiShiDragonGameStartView:buildUI()
	ARuiShiDragonGameStartView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnStart = self:getBtn("btnStart")
	self._txtTime = self:getTxt("time/txt")
	self._txtNum = self:getTxt("txtNum")

	local rewardRoot = self:getGo("rewardRoot")

	self._playerSliderMo = PlayerSliderMo.New(rewardRoot)
	self._txtTotalScore = self:getTxt("total/txtTotal")
end

function ARuiShiDragonGameStartView:bindEvents()
	ARuiShiDragonGameStartView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
end

function ARuiShiDragonGameStartView:unbindEvents()
	ARuiShiDragonGameStartView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnStart)
end

function ARuiShiDragonGameStartView:onEnter()
	ARuiShiDragonGameStartView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.ARuiShiDragonGameInfoRes, self._onGameInfoRes, self)
	self.addGEvent(self, GlobalNotify.ARuiShiDragonGameGainPrizeRes, self._onGainPrizeRes, self)

	self._activityId = ARuiShiDragonGameModel.instance:getActivityId()

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("outtime"), function()
			self:close()
		end)

		return
	end

	self._cfgActivity = ARuiShiDragonGameConfig.instance:getActivityCfg(self._activityId)
	self._maxDailyTimes = self._cfgActivity.dailyTimes

	self:_initActivityTime()
	self:_updatePlayerScore()
	self:_updateGameNum()
	self:_initRewardParams()
	ARuiShiDragonGameAgent.instance:sendPM_ARuiShiDragonGameInfoReq(self._activityId)
end

function ARuiShiDragonGameStartView:onExit()
	ARuiShiDragonGameStartView.super.onExit(self)
end

function ARuiShiDragonGameStartView:_onClickTip()
	TipsFacade.instance:openRulesView("aruishidragongamestartview_rule")
end

function ARuiShiDragonGameStartView:_onClickStart()
	local curNum = ARuiShiDragonGameModel.instance:getTodayTimes(self._activityId)

	if curNum >= self._maxDailyTimes then
		FloatWordMgr.instance:show("今日无剩余次数")

		return
	end

	UIStateManager.instance:push(ViewName.ARuiShiDragonGameLevelView, self._activityId)
end

function ARuiShiDragonGameStartView:_onGameInfoRes()
	self:_updatePlayerScore()
	self:_updateGameNum()
	self._playerSliderMo:updatePlayerReward()
end

function ARuiShiDragonGameStartView:_onGainPrizeRes()
	self._playerSliderMo:updatePlayerReward()
end

function ARuiShiDragonGameStartView:_initActivityTime()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function ARuiShiDragonGameStartView:_updateGameNum()
	local curNum = ARuiShiDragonGameModel.instance:getTodayTimes(self._activityId)
	local leftNum = Mathf.Max(0, self._maxDailyTimes - curNum)

	if leftNum > 0 then
		if not ColorConst.White then
			local colorStr = ColorConst.Red

			self._txtNum.text = string.format("今日剩余次数：<color=#%s>%d</color>/%d", colorStr, leftNum, self._maxDailyTimes)
		end
	end
end

function ARuiShiDragonGameStartView:_updatePlayerScore()
	self._txtTotalScore.text = ARuiShiDragonGameModel.instance:getRewardProgress(self._activityId)
end

function ARuiShiDragonGameStartView:_initRewardParams()
	local playerParam = {}

	playerParam.view = self
	playerParam.prizeCfgs = ARuiShiDragonGameConfig.instance:getPrizeList(self._activityId)

	function playerParam.getPlayerProgress()
		return ARuiShiDragonGameModel.instance:getRewardProgress(self._activityId)
	end

	function playerParam.getNeedScoreByRewardCfg(rewardCfg)
		return rewardCfg.progress
	end

	function playerParam.getPrizeByRewardCfg(rewardCfg)
		local prizes = string.split(rewardCfg.prize, "#")

		return prizes[1]
	end

	function playerParam.isPlayerRewardCanGet(rewardCfg)
		return ARuiShiDragonGameModel.instance:isPlayerRewardCanGet(self._activityId, rewardCfg.prizeId, rewardCfg.progress)
	end

	function playerParam.isPlayerRewardGeted(rewardCfg)
		return ARuiShiDragonGameModel.instance:isPlayerRewardGeted(self._activityId, rewardCfg.prizeId)
	end

	function playerParam.sendGainPlayerPrizeReq(rewardCfg)
		ARuiShiDragonGameAgent.instance:sendPM_ARuiShiDragonGameGainPrizeReq(self._activityId, rewardCfg.prizeId)
	end

	self._playerSliderMo:initParam(playerParam, true)
	self._playerSliderMo:initSlider()
end

return ARuiShiDragonGameStartView
