-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoQiHeroEndlessBtlView.lua

module("logic.extensions.aoqihero.view.AoQiHeroEndlessBtlView", package.seeall)

local AoQiHeroEndlessBtlView = class("AoQiHeroEndlessBtlView", AoQiHeroBattleView)
local STATE_GAME_RUNING = 1
local STATE_BIG_ROUND_START = 2
local STATE_CAN_OPERATE = 5
local STATE_BLOCK = 14
local STATE_GAME_END = 15
local ROUND_TIPS_SHOW_TIME = 1

function AoQiHeroEndlessBtlView:ctor()
	AoQiHeroEndlessBtlView.super.ctor(self)
end

function AoQiHeroEndlessBtlView:unbindEvents()
	AoQiHeroEndlessBtlView.super.unbindEvents(self)
end

function AoQiHeroEndlessBtlView:bindEvents()
	AoQiHeroEndlessBtlView.super.bindEvents(self)
end

function AoQiHeroEndlessBtlView:buildUI()
	AoQiHeroEndlessBtlView.super.buildUI(self)

	self._gameStartTips = self:getGo("gameStartTips")
	self._gameStartTxt = self:getTxt("gameStartTips/txt")
end

function AoQiHeroEndlessBtlView:onExit()
	AoQiHeroEndlessBtlView.super.onExit(self)
	removetimer(self._onEndGameEndShow, self)
end

function AoQiHeroEndlessBtlView:onEnter()
	self.addGEvent(self, GlobalNotify.PM_AoQiHeroBattleStartRes, self._PM_AoQiHeroBattleStartRes, self)
	self.addGEvent(self, GlobalNotify.PM_AoQiHeroSyncBattleRes, self._PM_AoQiHeroSyncBattleRes, self)
	self.addGEvent(self, GlobalNotify.PM_AoQiHeroEndlessChallengeRes, self._PM_AoQiHeroEndlessChallengeRes, self)
	self.addGEvent(self, GlobalNotify.PM_NotifyAoQiHeroEndlessChallengeEndRes, self._PM_NotifyAoQiHeroEndlessChallengeEndRes, self)
	self._stateMachine:startTimer()

	self._activityId = checknumber(self:getFirstParam())
	self._stageId = 1

	local stageCfg = AoQiHeroConfig.instance:getEndlessStageCfg(self._activityId, self._stageId)

	self._creepsMasterId = stageCfg.creepsMasterId
	self._lastStageRound = 0
	self._petEffect = {}
	self._petBuffTableDir = {}

	self._stateMachine:gotoState(STATE_GAME_RUNING)
	GameUtil.SetActive(self._gridCell, false)
	GameUtil.SetActive(self._enemyCell, false)
	GameUtil.SetActive(self._damagesText, false)
	GameUtil.SetActive(self._damageTextCell, false)
end

function AoQiHeroEndlessBtlView:initMgr()
	AoQiHeroBattleModel.instance:initMapData(self._activityId, self._creepsMasterId)

	if self._stageId == 1 then
		AoQiHeroBuffMgr.instance:initData(self._activityId)
		AoQiHeroEntityMgr.instance:initData(self._activityId, self._creepsMasterId)
		AoQiHeroSkillMgr.instance:initData(self._activityId)
	else
		AoQiHeroBuffMgr.instance:resetAllBuff()
		AoQiHeroBuffMgr.instance:initData(self._activityId)
		AoQiHeroEntityMgr.instance:initEnemyData(self._activityId, self._creepsMasterId)
	end

	AoQiHeroRoundMgr.instance:initData(self._activityId)
	AoQiHeroBattleModel.instance:initMapSet()

	local teamCfg = AoQiHeroConfig.instance:getTeamCfg(self._activityId, self._creepsMasterId)

	self._roundTime = teamCfg.roundTime
	self._maxRoundLimit = teamCfg.roundLimit
end

function AoQiHeroEndlessBtlView:_initGameRuning()
	self:initMgr()
	self:initView()

	self._winner = nil
	self._isMidLeave = nil
	self._gameStartTxt.text = langPara("第%s关", GameUtil.getChineseNumber(self._stageId))

	GameUtil.SetActive(self._gameStartTips, true)

	self._isPlaying = true

	local tween = UnityTweens.TweenPosition.StartTween(self._gameStartTips, Vector3(0, 0, 0), Vector3(0, 0, 0), ROUND_TIPS_SHOW_TIME)

	tween:AddListener(function()
		GameUtil.SetActive(self._gameStartTips, false)
		AoQiHeroController.instance:sendPM_AoQiHeroBattleStartReq()
	end)
end

function AoQiHeroEndlessBtlView:_initGameEnd()
	local winner = self._winner

	if winner then
		if winner == AoQiHeroConst.AttackTeam then
			self._lastStageRound = AoQiHeroRoundMgr.instance:getBigRound()

			self:_onGameEnd()
			self:_startNextStage()
		elseif winner == AoQiHeroConst.DefenceTeam then
			self:_openSettlementView()
		end
	end
end

function AoQiHeroEndlessBtlView:_onEndGameEndShow()
	self:_onGameEnd()
	self:_startNextStage()
end

function AoQiHeroEndlessBtlView:_startNextStage()
	self._stageId = self._stageId + 1

	local stageCfg = AoQiHeroConfig.instance:getEndlessStageCfg(self._activityId, self._stageId)

	if stageCfg then
		self._creepsMasterId = stageCfg.creepsMasterId

		local myTeamMo = AoQiHeroEntityMgr.instance:getTeamMo(AoQiHeroConst.AttackTeam)
		local raceIds = {}

		for i, v in ipairs(myTeamMo.pos) do
			local petMo = AoQiHeroEntityMgr.instance:getPet(v)

			table.insert(raceIds, petMo.configId)
		end

		AoQiHeroController.instance:sendPM_AoQiHeroEndlessChallengeReq(self._activityId, self._stageId, raceIds, self.viewName)
	else
		self:_openSettlementView()
	end
end

function AoQiHeroEndlessBtlView:_openSettlementView()
	local param = {}

	param.title = lang("目标")
	param.content = self._stageId > 1 and langPara("已通过第%d关，本关使用%d回合", self._stageId - 1, self._lastStageRound) or lang("未通过任意关卡")

	AoQiHeroController.instance:saveEndlessStageInfo(self._activityId, self._stageId - 1, self._lastStageRound)
	UIStateManager.instance:push(ViewName.AoqiHeroSettlementView, self._activityId, true, 2, param)
end

function AoQiHeroEndlessBtlView:_onClickClose()
	if self._isPlaying == true or self._stateMachine.currStateName ~= STATE_CAN_OPERATE and self._stateMachine.currStateName ~= STATE_GAME_END then
		return
	end

	TipsFacade.instance:openPopupWindow(lang("提示"), lang("是否中途退出，结算当前关卡"), function()
		if self._isPlaying == true or self._stateMachine.currStateName ~= STATE_CAN_OPERATE and self._stateMachine.currStateName ~= STATE_GAME_END then
			FloatWordMgr.instance:show(lang("正在回合中，请在可操作时间内退出"))

			return
		end

		self._isMidLeave = true

		self._stateMachine:gotoState(STATE_BLOCK)
	end)
end

function AoQiHeroEndlessBtlView:_onClickTips()
	local ruleCfgs = AoQiHeroConfig.instance:getImageRuleCfg(2)
	local list = {}

	for i, v in ipairs(ruleCfgs) do
		table.insert(list, {
			url = v.resName,
			desc = v.desc
		})
	end

	TipsFacade.instance:openImageRuleView(list, ruleCfgs[1].title)
end

function AoQiHeroEndlessBtlView:_PM_AoQiHeroSyncBattleRes()
	if self._winner then
		-- block empty
	else
		self._stateMachine:gotoState(STATE_BIG_ROUND_START)
	end
end

function AoQiHeroEndlessBtlView:_PM_AoQiHeroEndlessChallengeRes()
	self._stateMachine:gotoState(STATE_GAME_RUNING)
end

function AoQiHeroEndlessBtlView:_PM_NotifyAoQiHeroEndlessChallengeEndRes(isWin)
	if isWin then
		self._winner = AoQiHeroConst.AttackTeam or AoQiHeroConst.DefenceTeam
	end

	self._stateMachine:gotoState(STATE_GAME_END)
end

return AoQiHeroEndlessBtlView
