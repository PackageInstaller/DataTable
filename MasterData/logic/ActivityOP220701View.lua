-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/op220701/ActivityOP220701View.lua

module("logic.extensions.operationsummary.view.op220701.ActivityOP220701View", package.seeall)

local ActivityOP220701View = class("ActivityOP220701View", ViewComponent)
local buffActId = 17045

function ActivityOP220701View:ctor()
	ActivityOP220701View.super.ctor(self)
end

function ActivityOP220701View:unbindEvents()
	ActivityOP220701View.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnLilize)
	GameUtil.rmClickHandler(self._btnPray)
	self._tipCustomInput:RemoveListener()
end

function ActivityOP220701View:bindEvents()
	ActivityOP220701View.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnLilize, self._onClickLilize, self)
	GameUtil.addClickHandler(self._btnPray, self._onClickPray, self)
	self._tipCustomInput:AddListener(self._onCustomInputCallback, self)
end

function ActivityOP220701View:buildUI()
	ActivityOP220701View.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtTime = self:getTxt("time/txtTime")
	self._subTab = self:getGo("subTab")
	self._txtPlayerScore = self:getTxt("txtPlayerScore")
	self._btnTip = self:getBtn("btnTip")
	self._btnLilize = self:getBtn("btnLilize")
	self._btnPray = self:getBtn("btnPray")
	self._btnLilizeRed = self:getGo("btnLilize/redPoint")
	self._btnPrayRed = self:getGo("btnPray/redPoint")
	self._tip = self:getGo("tips2")
	self._tipCustomInput = UICustomInput.Get(self._tip)

	local playerRoot = self:getGo("playerRoot")

	self._playerSliderMo = PlayerSliderMo.New(playerRoot)

	goutil.setActive(self._tip, false)
end

function ActivityOP220701View:onExit()
	ActivityOP220701View.super.onExit(self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._onTickDailyRefreshData, self)
	GlobalDispatcher:removeListener(GlobalNotify.TimeServerPetGainGetInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.TimeServerPetGainGetProgressPrizeRes, self._onGetProgressPrizeRes, self)
	self._playerSliderMo:onExit()
	self:_removeBgEffect()
	RedPointController.instance:unregRedPoint(self._btnLilizeRed)
	RedPointController.instance:unregRedPoint(self._btnPrayRed)
end

function ActivityOP220701View:onEnter()
	ActivityOP220701View.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.TimeServerPetGainGetInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.TimeServerPetGainGetProgressPrizeRes, self._onGetProgressPrizeRes, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._onTickDailyRefreshData, self)

	self._activityMainId = 17043
	self._cfgActivity = TimeServerPetGainConfig.instance:getActivityCfg(self._activityMainId)
	self._progressPlanId = self._cfgActivity.progressPlanId
	self._targetRaceId = self._cfgActivity.raceId

	self:_initRewardSlider()
	self:_initActivityTimeText()
	self:showTabAt(self._subTab, ViewName.ActivitySmallSummaryFourView)
	self:_playBgEffect()
	self:_onTickDailyRefreshData()
	TimeServerPetGainAgent.instance:sendPM_TimeServerPetGainGetInfoReq(self._activityMainId)
	RedPointController.instance:regRedPoint(self._btnLilizeRed, RedPointModel.ID_OP220701_1)
	RedPointController.instance:regRedPoint(self._btnPrayRed, RedPointModel.ID_OP220701_2)
end

function ActivityOP220701View:_initRewardSlider()
	local playerParam = {}

	playerParam.view = self
	playerParam.prizeCfgs = TimeServerPetGainConfig.instance:getProgressCfgList(self._progressPlanId)

	function playerParam.getPlayerProgress()
		return TimeServerPetGainModel.instance:getMoByActivityId(self._activityMainId):getUserNum()
	end

	function playerParam.getNeedScoreByRewardCfg(rewardCfg)
		return rewardCfg.userNum
	end

	function playerParam.isPlayerRewardCanGet(rewardCfg)
		return TimeServerPetGainModel.instance:getMoByActivityId(self._activityMainId):isRewardCanGet(rewardCfg.id, rewardCfg.userNum)
	end

	function playerParam.isPlayerRewardGeted(rewardCfg)
		return TimeServerPetGainModel.instance:getMoByActivityId(self._activityMainId):isRewardGeted(rewardCfg.id)
	end

	function playerParam.sendGainPlayerPrizeReq(rewardCfg)
		TimeServerPetGainAgent.instance:sendPM_TimeServerPetGainGetProgressPrizeReq(self._activityMainId, rewardCfg.id)
	end

	function playerParam.parseGetProgress(rewardCfg)
		return rewardCfg.userNum
	end

	function playerParam.getRewardTip(rewardCfg)
		local isExist = BagModel.instance:isExistRaceId(self._targetRaceId)

		if not isExist then
			return self._cfgActivity.content
		end

		return ""
	end

	local isSkipAnimation = false

	self._playerSliderMo:initParam(playerParam, isSkipAnimation)
	self._playerSliderMo:onEnter()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
end

function ActivityOP220701View:_initActivityTimeText()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.Summary, self._activityMainId)
	local startDate = GameUtil.time2date(startTime)
	local endDate = GameUtil.time2date(endTime)

	self._txtTime.text = string.format("活动时间：%02d.%02d 5:00-%02d.%02d 5:00", startDate.month, startDate.day, endDate.month, endDate.day)
end

function ActivityOP220701View:_setPlayerScore()
	local num = TimeServerPetGainModel.instance:getMoByActivityId(self._activityMainId):getUserNum()

	self._txtPlayerScore.text = langPara("%d人获得", num)
end

function ActivityOP220701View:_onGetInfoRes()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
	self:_setPlayerScore()
end

function ActivityOP220701View:_onGetProgressPrizeRes()
	self._playerSliderMo:updatePlayerReward()
	self:_setPlayerScore()
end

function ActivityOP220701View:_onTickDailyRefreshData()
	local actCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.Summary, buffActId)

	GameUtil.SetActive(self._btnPray, (actCfg or nil) and GameUtil.checkIsInTimePeriod(actCfg.startTime, actCfg.endTime))
end

function ActivityOP220701View:_playBgEffect()
	return
end

function ActivityOP220701View:_removeBgEffect()
	return
end

function ActivityOP220701View:_onCustomInputCallback(hover)
	if not hover then
		goutil.setActive(self._tip, false)
	end
end

function ActivityOP220701View:_onClickTip()
	local txtDesc = goutil.findChildTextComponent(self._tip, "tableview/viewport/content")
	local ruleCo = RulesConfig.instance:getRuleCo("ActivityOP220701View_rule1") or {}

	txtDesc.text = ruleCo.rules or ""

	goutil.setActive(self._tip, true)
end

function ActivityOP220701View:_onClickLilize()
	SurveyController.instance:reportBehavior(201012)
	RedPointController.instance:saveUserOnceRedPoint(RedPointModel.ID_OP220701_1, true)
	UIStateManager.instance:push(ViewName.ActivityOP220701VedioView, "cg_0_0")
end

function ActivityOP220701View:_onClickPray()
	local cfgActivity = TimeServerPetGainConfig.instance:getActivityCfg(buffActId)
	local array = MaterialMgr.changeItemStrArr(cfgActivity.buff)
	local contentArray = {}

	for _, str in ipairs(array) do
		local type, id, _ = MaterialMgr.getMatParams(str)
		local cfg = MaterialMgr.getMatCfg(type, id)

		table.insert(contentArray, cfg.desc)
	end

	SurveyController.instance:reportBehavior(201013)
	RedPointController.instance:saveUserOnceRedPoint(RedPointModel.ID_OP220701_2, true)
	TipsFacade.instance:openTipWindow(lang("tip"), table.concat(contentArray, "\n"), nil, lang("confirm"))
end

return ActivityOP220701View
