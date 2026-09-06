-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breachformmaster/model/BreachFormMasterFmtMo.lua

module("logic.extensions.originpowersclg.model.BreachFormMasterFmtMo", package.seeall)

local BreachFormMasterFmtMo = class("BreachFormMasterFmtMo", BaseCustomFmtMo)

function BreachFormMasterFmtMo:onInit()
	BreachFormMasterFmtMo.super.onInit(self)
end

function BreachFormMasterFmtMo:initParams(activityId, stepId, stageId)
	self.activityId = activityId
	self.stepId = stepId
	self.stageId = stageId
	self._skipTime = 5

	if self.stepId == BreachFormMasterController.ROBOT_STEP_ID then
		local stageCfg = BreachFormMasterConfig.instance:getStageCfg(self.activityId, self.stepId, self.stageId)
		local creepsMasterId = checknumber(stageCfg.creepsMasterId)

		self._cfgEnemy = BreachFormMasterConfig.instance:getTeamCfg(creepsMasterId)
		self._masterList = BreachFormMasterConfig.instance:getCreepsCfg(creepsMasterId)
		self.topTitleStr = self._cfgEnemy.name
		self.ruleDescStr = self._cfgEnemy.WinDesc

		self:setFormCondition(self._cfgEnemy.formCondition)
	else
		self._opponentInfo = BreachFormMasterModel.instance:getOpponentInfo()
		self.topTitleStr = lang("破阵宗师")

		local activityCfg = BreachFormMasterConfig.instance:getActivityCfg(self.activityId)

		self._skipTime = checknumber(activityCfg.playerBattleSkipTime)
	end
end

function BreachFormMasterFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()
		local useBuff = BreachFormMasterModel.instance:getUseDailyBuff()

		BreachFormMasterAgent.instance:sendPM_BreachFormMasterFightReq(self.activityId, self.stageId, useBuff, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function BreachFormMasterFmtMo:getMonsterConfigList()
	if self.stepId == BreachFormMasterController.ROBOT_STEP_ID then
		return self._masterList
	else
		return {}
	end
end

function BreachFormMasterFmtMo:getExtParams()
	if self.stepId == BreachFormMasterController.ROBOT_STEP_ID then
		return nil
	elseif self._opponentInfo and self._opponentInfo.playerView then
		local data = GameUtil.pbToTable(self._opponentInfo.playerView.curForm.extParams)
		local params = {}

		for k, v in pairs(data) do
			params[k] = v
		end

		return params
	else
		return nil
	end
end

function BreachFormMasterFmtMo:getFmtInfoConfig()
	if self.stepId == BreachFormMasterController.ROBOT_STEP_ID then
		return self._cfgEnemy
	elseif self._opponentInfo and self._opponentInfo.playerView then
		local params = {}
		local data = GameUtil.pbToTable(self._opponentInfo.playerView.curForm.extParams)

		for k, v in pairs(data) do
			params[k] = v
		end

		params.skipTime = self._skipTime

		return params
	else
		return {}
	end
end

function BreachFormMasterFmtMo:getTeamAndFormation(creepCfg)
	if self.stepId == BreachFormMasterController.ROBOT_STEP_ID then
		return BreachFormMasterFmtMo.super.getTeamAndFormation(self, creepCfg)
	else
		local teams = {}
		local formations = {}

		if self._opponentInfo then
			local opForm = self._opponentInfo

			for _, basePetView in ipairs((opForm or nil) and (opForm.playerView.petSimpleView or {})) do
				local posId

				for i = 1, 9 do
					if basePetView.petId == opForm.playerView.curForm.pos[i] then
						posId = i
					end
				end

				if posId then
					local petMo = FightingPowerPetMo.fromBasePetView(basePetView, nil, posId)

					table.insert(teams, petMo)

					formations[posId] = petMo
				end
			end
		end

		ArraySort.sortOn(teams, "position")

		return teams, formations
	end
end

function BreachFormMasterFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	local isCanFight = BreachFormMasterController.instance:checkCanChallenge(self.activityId, self.stepId)

	if not isCanFight then
		return true
	end

	return BreachFormMasterFmtMo.super.checkFormationEmptyAndPosNumLimit(self, posLimitCallback, hasOneKey, onekeyCallBack)
end

return BreachFormMasterFmtMo
