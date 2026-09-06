-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/BFMissionView.lua

module("logic.extensions.mission.view.BFMissionView", package.seeall)

local BFMissionView = class("BFMissionView", MissionView)

function BFMissionView:ctor()
	BFMissionView.super.ctor(self)
end

function BFMissionView:onEnter()
	self._fightId = checknumber(self._viewPresentor._openParam[1])
	self._monsterId = checknumber(self._viewPresentor._openParam[2])

	BulletScreenModel.instance:setEnum(GameEnum.BulletScene.Formation)
	BulletScreenModel.instance:setKey(string.format("bf_%s_%s", self._fightId, self._monsterId))
	self:onEnterInherit()
	self:procMid()
	FastFormation.instance:setGetCurPetList(function()
		return BreakFormationModel.instance:getAllPetList()
	end)
	self._videoButton.gameObject:SetActive(false)
	GlobalDispatcher:addListener(BreachFormationAgent.PM_BreachFormationFightRes, self._onMissionBattleResBack, self)
end

function BFMissionView:_onClickVideo()
	local ranKey = BattleRecordRankController.instance:getBfRankKey(self._fightId, self._monsterId)

	BattleRecordRankController.instance:enterBattleRecoresView(ranKey)
end

function BFMissionView:onExit()
	GlobalDispatcher:removeListener(BreachFormationAgent.PM_BreachFormationFightRes, self._onMissionBattleResBack, self)
	BFMissionView.super.onExit(self)
	BreakFormationModel.instance:clearAllPetList()
end

function BFMissionView:procMid()
	local cfg
	local mode = BreakFormationModel.instance:getCurMode() or BreakFormationModel.MODE_NORMAL

	cfg = mode == BreakFormationModel.MODE_NORMAL and BreakFormationConfig.instance:getMonsterCfg(self._fightId, self._monsterId) or BreakFormationConfig.instance:getHellMonsterCfg(self._fightId, self._monsterId)

	local titleStr = langPara("第%d阵", self._monsterId)
	local levelStr = ""
	local buffDesc = BreakFormationConfig.instance:getBuffCfg(cfg.buffId).desc
	local periodId = BreakFormationModel.instance.periodId
	local pcfg = BreakFormationConfig.instance:getTeamCfg(periodId)
	local desc = BreakFormationModel.instance:getConditionDesc(periodId)
	local ruleDesc = langPara("1.击败所有敌方精灵即可通关，获得通关奖励。\n2.%s。\n3.%s", desc, buffDesc)

	self:_setDescStr(titleStr, levelStr, ruleDesc)
end

function BFMissionView:_setBattleResultTxtTitle()
	local str = string.format("破阵天下 %s", self:_getTitleStr())

	BattleSettlementModel.instance:setTxtTitle(str)
end

function BFMissionView:_enterBattle()
	BreakFormationModel.instance:resetNewScoreIdx()
	BattleFacade.instance:startBreakFormation(self._fightId, self._monsterId)
	BreakFormationController.instance:startBattle(self._fightId, self._monsterId, self:getSelfPower())
	UIJumper.instance:pushOneStack(ViewName.BreakFormation, true)
end

function BFMissionView:getSelfPower()
	local power, speed = 0, 0
	local formation = FormationNewModel.instance:GetCurTeam():GetCurFormation()

	for _, v in ipairs(formation:GetPositions()) do
		if v > 0 then
			local pet = BagPetsController.instance:getPet(v)

			if pet then
				power = power + pet:getFightingPower()
			end
		end
	end

	return power
end

function BFMissionView:setRuleDesc()
	BFMissionView.super.setRuleDesc(self)

	local bfParam = {}

	bfParam.challengeType = MissionConst.BreakFormation

	MissionModel.instance:setRuleParam(bfParam)
end

return BFMissionView
