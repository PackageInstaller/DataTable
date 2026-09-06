-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlesettlement/view/BattleSettlementSuccessView.lua

module("logic.extensions.battlesettlement.view.BattleSettlementSuccessView", package.seeall)

local BattleSettlementSuccessView = class("BattleSettlementSuccessView", BattleSettlementBaseView)

function BattleSettlementSuccessView:ctor()
	BattleSettlementSuccessView.super.ctor(self)
end

function BattleSettlementSuccessView:buildUI()
	BattleSettlementSuccessView.super.buildUI(self)

	self._btnNext = self:getBtn("btnNext")
	self._txtDesc = self:getTxt("btnNext/txtDesc")
	self._btnStatics = self:getBtn("part2/right/team/btnStatics")
	self._settlementScore = SettlementScore.New()

	self._settlementScore:buildUI(self:getGo("part2/right/score"))

	self._settlementTeam = SettlementTeam.New()

	self._settlementTeam:buildUI(self:getGo("part2/right/team"))

	self._settlementReward = SettlementReward.New()

	self._settlementReward:buildUI(self:getGo("part2/right/reward"))

	self._settlementProgress = SettlementProgress.New()

	self._settlementProgress:buildUI(self:getGo("part2/right/progress"))

	if self:getGo("part2/right/desc") then
		self._settlementDesc = SettlementDesc.New()

		self._settlementDesc:buildUI(self:getGo("part2/right/desc"))
	end

	table.insert(self._settlementList, self._settlementScore)
	table.insert(self._settlementList, self._settlementTeam)
	table.insert(self._settlementList, self._settlementReward)
	table.insert(self._settlementList, self._settlementProgress)
	table.insert(self._settlementList, self._settlementDesc)

	self._isSuccess = true
end

function BattleSettlementSuccessView:destroyUI()
	BattleSettlementSuccessView.super.destroyUI(self)

	self._settlementScore = nil
	self._settlementTeam = nil
	self._settlementReward = nil
	self._settlementProgress = nil
	self._settlementDesc = nil
end

function BattleSettlementSuccessView:bindEvents()
	BattleSettlementSuccessView.super.bindEvents(self)
	self._btnNext:AddClickListener(self._onClickNext, self)
	self._btnStatics:AddClickListener(self._onClickStatics, self)
end

function BattleSettlementSuccessView:unbindEvents()
	BattleSettlementSuccessView.super.unbindEvents(self)
	self._btnNext:RemoveClickListener()
	self._btnStatics:RemoveClickListener()
end

function BattleSettlementSuccessView:onEnter()
	BattleSettlementSuccessView.super.onEnter(self)

	local enumType = BattleSettlementModel.instance:getType()

	goutil.setActive(self._btnNext.gameObject, false)

	self._isShowNextBtn = false

	if enumType == BattleSettlementModel.Enum.WarriorTower then
		self._isClickNext = false

		local params = BattleSettlementModel.instance:getParams()

		self._isShowNextBtn = params and not params.isFinalLevel or false

		WTowerController.instance:onReset()
		WTowerController.instance:loadTowerInfo()
	elseif enumType == BattleSettlementModel.Enum.DragonAwaken then
		self._isClickNext = false

		local params = BattleSettlementModel.instance:getParams()

		if params and params.isWin then
			local phaseCfgs = DragonAwakenConfig.instance:getPhaseCfgs(params.activityId)

			if #phaseCfgs == params.curPhaseId and params.curStageId ~= 1 then
				goutil.setActive(self._btnNext.gameObject, true)

				self._isShowNextBtn = true
			end
		end
	elseif enumType == BattleSettlementModel.Enum.HonourTowerChallenge then
		self._isClickNext = false

		local params = BattleSettlementModel.instance:getParams()

		if params and params.isWin then
			local cfg = HonourTowerConfig.instance:getStageCfg(params.challengeId, params.stageId + 1)

			if cfg then
				self._isShowNextBtn = true
			end
		end
	else
		self._isShowNextBtn = false
	end
end

function BattleSettlementSuccessView:onExit()
	BattleSettlementSuccessView.super.onExit(self)
	self:_stopCountdown()

	if ViewMgr.instance:isOpen(ViewName.BattleStatics) then
		UIStateManager.instance:popByName(ViewName.BattleStatics)
	end

	WarriorTowerAgent.instance:rmEvent(WarriorTowerAgent.FightRes, self.onWTNextLevel, self)
end

function BattleSettlementSuccessView:getAudioId()
	return 30201
end

function BattleSettlementSuccessView:_onEnumTypeIsDefault()
	local param = {}

	table.insert(param, self)
	self:enqueueQueue(self._settlementTeam, param)

	if BattleSettlementModel.instance:checkHasRewardList() then
		self:enqueueQueue(self._settlementReward, nil)
	end

	self:_doOnEnter()

	self._totalTimeForClickEnd = self._delayTime + 1

	self:_delayOnBtnClose()
end

function BattleSettlementSuccessView:_onEnumTypeIsArena()
	self:enqueueQueue(self._settlementRank, nil)
	self:enqueueQueue(self._settlementReward, nil)
	self:_doOnEnter()

	self._totalTimeForClickEnd = self._delayTime + 1

	self:_delayOnBtnClose()
end

function BattleSettlementSuccessView:_onEnumTypeIsKingArena()
	self:enqueueQueue(self._settlementRank, nil)
	self:enqueueQueue(self._settlementReward, nil)
	self:_doOnEnter()

	self._totalTimeForClickEnd = self._delayTime + 1

	self:_delayOnBtnClose()
end

function BattleSettlementSuccessView:_onEnumTypeIsEndless()
	print("_onEnumTypeIsEndless")

	local param = {}

	table.insert(param, self)
	self:enqueueQueue(self._settlementTeam, param)
	self:enqueueQueue(self._settlementReward, nil)
	self:_doOnEnter()

	self._totalTimeForClickEnd = self._delayTime + 1

	self:_delayOnBtnClose()
end

function BattleSettlementSuccessView:_onEnumTypeIsFengbaobao()
	local params = BattleSettlementModel.instance:getParams()
	local tparam = {}

	table.insert(tparam, self)
	self:enqueueQueue(self._settlementProgress, params)
	self:enqueueQueue(self._settlementTeam, tparam)
	self:enqueueQueue(self._settlementReward, nil)
	self:_doOnEnter()

	self._totalTimeForClickEnd = self._delayTime + 1

	self:_delayOnBtnClose()
end

function BattleSettlementSuccessView:_onEnumGodDiShiTian()
	self:enqueueQueue(self._settlementScore, {
		self._isSuccess
	})
	self:enqueueQueue(self._settlementTeam, {
		self
	})
	self:_doOnEnter()

	self._totalTimeForClickEnd = self._delayTime + 1

	self:_delayOnBtnClose()
end

function BattleSettlementSuccessView:_onEnumTunTianChallenge()
	self:enqueueQueue(self._settlementScore, {
		self._isSuccess
	})
	self:enqueueQueue(self._settlementTeam, {
		self
	})
	self:_doOnEnter()

	self._totalTimeForClickEnd = self._delayTime + 1

	self:_delayOnBtnClose()
end

function BattleSettlementSuccessView:_onEnumVillaintrialPet()
	local params = BattleSettlementModel.instance:getParams()

	self:enqueueQueue(self._settlementScore, params)
	self:enqueueQueue(self._settlementTeam, {
		self
	})
	self:_doOnEnter()

	self._totalTimeForClickEnd = self._delayTime + 1

	self:_delayOnBtnClose()
end

function BattleSettlementSuccessView:_onEnumLailisi()
	self:enqueueQueue(self._settlementTeam, {
		self
	})
	self:_doOnEnter()

	self._totalTimeForClickEnd = self._delayTime + 1

	self:_delayOnBtnClose()
end

function BattleSettlementSuccessView:_onEnumHonourTower()
	local param = {}

	table.insert(param, self)
	self:enqueueQueue(self._settlementTeam, param)
	self:enqueueQueue(self._settlementReward, nil)
	self:_doOnEnter()

	self._totalTimeForClickEnd = self._delayTime + 1

	self:_delayOnBtnClose()
end

function BattleSettlementSuccessView:_onEnumSimpleDesc()
	local params = BattleSettlementModel.instance:getParams()

	self:dequeueQueue()
	self:enqueueQueue(self._settlementDesc, {
		params.title,
		params.content
	})
	self:enqueueQueue(self._settlementTeam, {
		self
	})

	if params.hasReward then
		self:enqueueQueue(self._settlementReward, nil)
	end

	self:_doOnEnter()

	self._totalTimeForClickEnd = self._delayTime + 1

	self:_delayOnBtnClose()
end

function BattleSettlementSuccessView:_onEnumNightFeastBoss()
	local params = BattleSettlementModel.instance:getParams()

	self:enqueueQueue(self._settlementProgress, {
		params.curTotalDamage,
		params.maxBossHp,
		params.conditionStr
	})
	self:enqueueQueue(self._settlementTeam, {
		self
	})
	self:_doOnEnter()

	self._totalTimeForClickEnd = self._delayTime + 1

	self:_delayOnBtnClose()
end

function BattleSettlementSuccessView:_onClickNext()
	if self._isClickNext then
		return
	end

	self._isClickNext = true

	local enumType = BattleSettlementModel.instance:getType()

	if enumType == BattleSettlementModel.Enum.WarriorTower then
		WarriorTowerAgent.instance:rmEvent(WarriorTowerAgent.FightRes, self.onWTNextLevel, self)
		WarriorTowerAgent.instance:addListener(WarriorTowerAgent.FightRes, self.onWTNextLevel, self)
		WTowerController.instance:onClickNextLevel()
	elseif enumType == BattleSettlementModel.Enum.DragonAwaken then
		DragonAwakenController.instance:startNextFight()
		self:_onClickClose()

		self._isClickNext = false
	elseif enumType == BattleSettlementModel.Enum.HonourTowerChallenge then
		goutil.setActive(self._btnNext.gameObject, false)
		HonourTowerController.instance:onClickNextLevel()
		self:close()
	end
end

function BattleSettlementSuccessView:onWTNextLevel(status, msg)
	if status == 0 then
		local enumType = BattleSettlementModel.instance:getType()

		self:close()

		if enumType == BattleSettlementModel.Enum.WarriorTower then
			WTowerController.instance:setBattleSettlementParams()
		end
	else
		self:_onClickClose()

		self._isClickNext = false
	end
end

function BattleSettlementSuccessView:_onClickStatics()
	ViewMgr.instance:open(ViewName.BattleStatics)
end

function BattleSettlementSuccessView:_onAnimEnd()
	BattleSettlementSuccessView.super._onAnimEnd(self)
	goutil.setActive(self._btnNext.gameObject, self._isShowNextBtn)

	if self._isShowNextBtn then
		self:_startCountdown()
	end

	self:_popupAceteamBossEndView()
	GlobalDispatcher:dispatch(GlobalNotify.BattleSettlementAniPlayEnd)
end

function BattleSettlementSuccessView:_onSecond()
	self._countdownTime = self._countdownTime - 1

	if self._countdownTime >= 0 then
		self:_setDesc(self._countdownTime)
	else
		self:_onCountdownEnd()
		self:_stopCountdown()
	end
end

function BattleSettlementSuccessView:_startCountdown()
	local enumType = BattleSettlementModel.instance:getType()

	if enumType == BattleSettlementModel.Enum.WarriorTower or enumType == BattleSettlementModel.Enum.HonourTowerChallenge then
		self._countdownTime = 5

		self:_setDesc(self._countdownTime)
		settimer(1, self._onSecond, self)
	end
end

function BattleSettlementSuccessView:_stopCountdown()
	removetimer(self._onSecond, self)
end

function BattleSettlementSuccessView:_onCountdownEnd()
	self:_onClickNext()
end

function BattleSettlementSuccessView:_setDesc(time)
	self._txtDesc.text = string.format("下一关（%d秒）", self._countdownTime)
end

function BattleSettlementSuccessView:_popupAceteamBossEndView()
	AceTeamController.instance:checkPopupAceteamBossEndView()
end

function BattleSettlementSuccessView:_popupExtraPassView()
	BattleSettlementSuccessView.super._popupExtraPassView(self)

	local enumType = BattleSettlementModel.instance:getType()

	if enumType == BattleSettlementModel.Enum.GodDiShiTian then
		self:_openGodDiShiTian()
	elseif enumType == BattleSettlementModel.Enum.ShenJiChallenge then
		local params = BattleSettlementModel.instance:getParams()

		ShenJiChallengeController.instance:openExtraBattleResultView(params)
	end
end

function BattleSettlementSuccessView:_openGodDiShiTian()
	GodDiShiTianController.instance:openExtraBattleResultView()
end

return BattleSettlementSuccessView
