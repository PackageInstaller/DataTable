-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroMainView.lua

module("logic.extensions.aoqihero.view.AoqiHeroMainView", package.seeall)

local AoqiHeroMainView = class("AoqiHeroMainView", ViewComponent)

function AoqiHeroMainView:ctor()
	AoqiHeroMainView.super.ctor(self)
end

function AoqiHeroMainView:unbindEvents()
	AoqiHeroMainView.super.unbindEvents(self)
end

function AoqiHeroMainView:bindEvents()
	AoqiHeroMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnNormal, self._onClickNormalStage, self)
	GameUtil.addClickHandler(self._btnEndless, self._onClickEndlessStage, self)
	GameUtil.addClickHandler(self._btnPVP, self._onClickPVP, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTips, self)
	GameUtil.addClickHandler(self._btnBag, self._onClickBag, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnDaily, self._onClickDaily, self)
end

function AoqiHeroMainView:buildUI()
	AoqiHeroMainView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._goldBar = self:getGo("goldBar")
	self._btnTip = self:getGo("btnTip")
	self._btnBag = self:getGo("btnBag")
	self._redPointBag = self:getGo("btnBag/redpoint")
	self._btnRank = self:getGo("btnRank")
	self._btnPrize = self:getGo("btnPrize")
	self._btnShop = self:getGo("btnShop")
	self._btnPVP = self:getGo("btnPVP")
	self._pvpBlockGo = self:getGo("btnPVP/block")
	self._redPointPVP = self:getGo("btnPVP/redpoint")
	self._btnNormal = self:getGo("btnNormal")
	self._normalBlockGo = self:getGo("btnNormal/block")
	self._btnEndless = self:getGo("btnEndless")
	self._endlessBlockGo = self:getGo("btnEndless/block")
	self._redpointEndless = self:getGo("btnEndless/redpoint")
	self._txtMaxStage = self:getTxt("btnEndless/txtMaxStage")
	self._txtRankInfo = self:getTxt("btnPVP/txtRankInfo")
	self._txtTime = self:getTxt("time/txtTime")
	self._btnDaily = self:getGo("btnDaily")
	self._receiveDailyGo = self:getGo("btnDaily/receive")
	self._redpointDaily = self:getGo("btnDaily/redpoint")
end

function AoqiHeroMainView:onExit()
	AoqiHeroMainView.super.onExit(self)
end

function AoqiHeroMainView:onEnter()
	AoqiHeroMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_AoQiHeroInfoRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_NotifyAoQiHeroEndlessChallengeEndRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_NotifyAoQiHeroNormalChallengeEndRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_NotifyAoQiHeroPvPRoomEndRes, self._refreshView, self)

	self._activityId = 450001
	self._activityCfg = AoQiHeroConfig.instance:getActivityCfg(self._activityId)

	AoQiHeroAgent.instance:sendPM_AoQiHeroInfoReq(self._activityId)
	AoQiHeroAgent.instance:sendPM_AoQiHeroCardListReq(self._activityId)
	AoQiHeroAgent.instance:sendPM_AoQiHeroRankInfoReq(self._activityId, 3)
	self:_setTopGoldBar()

	self._txtTime.text = GameUtil.getActTimeDesc(GameEnum.ActivityType.AoqiHero, self._activityId)
end

function AoqiHeroMainView:_refreshView()
	local endlessStageId, endlessCircleNum = AoQiHeroModel.instance:getEndlessStageInfo(self._activityId)

	self._txtMaxStage.text = endlessStageId > 0 and langPara("最佳：%d关%d回合", endlessStageId, endlessCircleNum) or lang("最佳：0关")

	local rank = AoQiHeroModel.instance:getPvpRank(self._activityId)

	rank = checknumber(rank)

	local score = AoQiHeroModel.instance:getPvpScore(self._activityId)

	score = checknumber(score)
	self._txtRankInfo.text = rank < 0 and langPara("积分：%d\n排名：未上榜", score) or langPara("积分：%d\n排名：%d", score, rank)

	local isPassAll = AoQiHeroController.instance:isPassAllStage(self._activityId)

	GameUtil.SetActive(self._pvpBlockGo, not isPassAll)
	GameUtil.SetActive(self._endlessBlockGo, not isPassAll)
	GameUtil.SetActive(self._normalBlockGo, isPassAll)

	local times = AoQiHeroModel.instance:getPvpTimes(self._activityId)

	GameUtil.SetActive(self._redpointEndless, isPassAll and AoQiHeroController.instance:isCanGetEndlessPrize(self._activityId))

	local var_7_0

	if isPassAll then
		::label_7_0::

		var_7_0 = AoQiHeroController.instance:hasNewReport()
		var_7_0 = var_7_0 or self._activityCfg.pvpDailyTimes - times > 0
	end

	GameUtil.SetActive(self._redPointPVP, var_7_0)
	GameUtil.SetActive(self._receiveDailyGo, AoQiHeroModel.instance:getHadGainedTodayPrize(self._activityId))
	GameUtil.SetActive(self._redpointDaily, not AoQiHeroModel.instance:getHadGainedTodayPrize(self._activityId))
	GameUtil.SetActive(self._redPointBag, AoQiHeroController.instance:checkHasPoeCanLvUp(self._activityId))
end

function AoqiHeroMainView:_onClickNormalStage()
	if AoQiHeroController.instance:isPassAllStage(self._activityId) == true then
		FloatWordMgr.instance:show(lang("已通关全部关卡"))

		return
	end

	UIStateManager.instance:push(ViewName.AoqiHeroNormalStageView, self._activityId)
end

function AoqiHeroMainView:_onClickEndlessStage()
	if not AoQiHeroController.instance:isPassAllStage(self._activityId) then
		FloatWordMgr.instance:show(lang("请先通关全部普通关卡"))

		return
	end

	UIStateManager.instance:push(ViewName.AoqiHeroEndlessStageView, self._activityId)
end

function AoqiHeroMainView:_onClickPVP()
	if not AoQiHeroController.instance:isPassAllStage(self._activityId) then
		FloatWordMgr.instance:show(lang("请先通关全部普通关卡"))

		return
	end

	UIStateManager.instance:push(ViewName.AoqiHeroPvPMainView, self._activityId)
end

function AoqiHeroMainView:_onClickTips()
	TipsFacade.instance:openRulesView("aoqi_hero_rule")
end

function AoqiHeroMainView:_onClickBag()
	UIStateManager.instance:push(ViewName.AoqiHeroStrengthenView, self._activityId)
end

function AoqiHeroMainView:_onClickRank()
	UIStateManager.instance:push(ViewName.AoqiHeroRankView, self._activityId)
end

function AoqiHeroMainView:_onClickPrize()
	UIStateManager.instance:push(ViewName.AoqiHeroPrizeView, self._activityId)
end

function AoqiHeroMainView:_onClickShop()
	GotoMgr.gotoByString(self._activityCfg.jumpTo)
end

function AoqiHeroMainView:_onClickDaily()
	if AoQiHeroModel.instance:getHadGainedTodayPrize(self._activityId) then
		FloatWordMgr.instance:show(lang("今日已领取"))
	else
		AoQiHeroAgent.instance:sendPM_AoQiHeroGainDailyPrizeReq(self._activityId)
	end
end

function AoqiHeroMainView:_setTopGoldBar()
	local activityCfg = AoQiHeroConfig.instance:getActivityCfg(self._activityId)
	local btn_list = {}
	local cfgList = string.split(activityCfg.showBar, "#")

	for i, v in ipairs(cfgList) do
		table.insert(btn_list, {
			showAdd = false,
			id = v
		})
	end

	MainUIController.instance:showGlodBar(self._goldBar, self._viewPresentor, btn_list, false)
end

return AoqiHeroMainView
