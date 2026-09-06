-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/angelpowerclg/controller/AngelPowerClgController.lua

module("logic.extensions.angelpowerclg.controller.AngelPowerClgController", package.seeall)

local AngelPowerClgController = class("AngelPowerClgController", BaseController)

function AngelPowerClgController:ctor()
	return
end

function AngelPowerClgController:onInit()
	self:onReset()
	GlobalDispatcher:addListener("enterangelpowerclgmainview", self._enterEventOpenView, self)
end

function AngelPowerClgController:onReset()
	return
end

function AngelPowerClgController:handlePM_AngelPowerGetInfoRes(msg)
	GlobalDispatcher:removeListener(GlobalNotify.BattleHurtData, self._onBattleHurtData, self)
	GlobalDispatcher:removeListener(GlobalNotify.BattleRoundStart, self._onBattleRoundStart, self)
	AngelPowerClgModel.instance:setInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AngelPowerGetInfoRes)
end

function AngelPowerClgController:handlePM_AngelPowerChallengeRes(msg)
	return
end

function AngelPowerClgController:_initWinner(gameObject)
	return {
		go = gameObject
	}
end

function AngelPowerClgController:_updateWinner(obj, view)
	local actCfg = AngelPowerClgConfig.instance:getActivityCfg(self._teamActivityId)
	local transferRound = actCfg.transferRoundCount + 1 - view._curRoundNum

	return (transferRound > 0 or nil) and langPara("敌阵将在%d回合后变身为面具精灵", transferRound)
end

function AngelPowerClgController:_isReachWinner(obj, view)
	local actCfg = AngelPowerClgConfig.instance:getActivityCfg(self._teamActivityId)

	return nil
end

function AngelPowerClgController:handlePM_Notify_AngelPowerChallengeEndRes(msg)
	GlobalDispatcher:addListener(GlobalNotify.BattleHurtData, self._onBattleHurtData, self)
	GlobalDispatcher:addListener(GlobalNotify.BattleRoundStart, self._onBattleRoundStart, self)
	AngelPowerClgModel.instance:resetBattleInfo()
	BattleFacade.instance:registerBattleWinnerOpHandler(GameUtil.handler(self._initWinner, self), GameUtil.handler(self._updateWinner, self), GameUtil.handler(self._isReachWinner, self))

	self._teamActivityId = msg.activityId

	BattleFacade.instance:registerResultHandler(function()
		GlobalDispatcher:removeListener(GlobalNotify.BattleHurtData, self._onBattleHurtData, self)
		GlobalDispatcher:removeListener(GlobalNotify.BattleRoundStart, self._onBattleRoundStart, self)

		if msg.win then
			ViewMgr.instance:open(ViewName.BattleSettlementSuccess)
		else
			ViewMgr.instance:open(ViewName.BattleSettlementFail)
		end

		return true
	end)
	AngelPowerClgModel.instance:setStageInfo(msg)

	if msg.changeSetId then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
	end

	local params = {}
	local scoreData = {}

	for i, v in ipairs(msg.scores) do
		scoreData[v.left] = v.right
	end

	local stageCfg = AngelPowerClgConfig.instance:getStageCfg(msg.activityId, msg.stageId)
	local transferPetCfg = AngelPowerClgConfig.instance:getTransferPetCfg(stageCfg.transferPetPlanId)
	local requireList = string.split(stageCfg.winScoreRequirements, "#")

	params.requireList = {}

	for i, v in ipairs(requireList) do
		local configData = string.split(v, "=")
		local type = checknumber(configData[1])
		local needNum = checknumber(configData[2])

		if not scoreData[type] then
			local maskName = transferPetCfg[type].maskName

			table.insert(params.requireList, {
				maskName = maskName,
				needNum = needNum,
				curNum = scoreData[type]
			})
		end
	end

	local teamCfg = AngelPowerClgConfig.instance:getTeamCfg(stageCfg.creepsMasterId)

	params.winId = teamCfg.winId

	BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.AngelPower, params)

	local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._teamActivityId)

	if isAoqiGodProcessType then
		local allPass = AngelPowerClgController.instance:allStagePass(self._teamActivityId)

		if allPass then
			AoqiGodController.instance:doHandleChallengeFinishReady(GameEnum.ActivityType.AngelPowerClg, self._teamActivityId)
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_Notify_AngelPowerChallengeEndRes)
end

function AngelPowerClgController:_onBattleHurtData(hurtData)
	local scene = SceneMgr.instance:getCurScene()

	if scene:getSceneType() == SceneType.Battle then
		local targetUnit = hurtData.target
		local damage = 0

		if hurtData.damageEvts then
			for i, v in pairs(hurtData.damageEvts) do
				if v.damage < 0 then
					damage = damage + v.damage
				end
			end
		end

		if targetUnit and hurtData.target.teamId == 1 and hurtData.attacker ~= hurtData.target and checknumber(damage) < 0 and not self._stopCalculateDamage then
			local petCfg = PetSkinConfig.instance:getPetSkinCfg(hurtData.attacker.raceId)
			local races = hurtData.attacker.attrs:getAttributes()

			if not races or #races == 0 then
				races = PetSkinConfig.instance:getAllElementAttrs(hurtData.attacker.modelId)
			end

			AngelPowerClgModel.instance:addBattleDamageInfo(hurtData.target.id, races[1], hurtData.damageEvts[1].damage)
			targetUnit.unitUI:setAttrs({
				AngelPowerClgModel.instance:getBattleMaxAttr(hurtData.target.id)
			})
		end
	end
end

function AngelPowerClgController:_onBattleRoundStart(roundNum)
	local actCfg = AngelPowerClgConfig.instance:getActivityCfg(self._teamActivityId)

	self._stopCalculateDamage = roundNum > actCfg.transferRoundCount
end

function AngelPowerClgController:allStagePass(activityId)
	local passStage = AngelPowerClgModel.instance:getPassStage(activityId)
	local stageCfgs = AngelPowerClgConfig.instance:getStageCfgs(activityId) or {}

	return passStage >= #stageCfgs
end

function AngelPowerClgController:_enterEventOpenView(params)
	local actId = checknumber(params[1])

	UIStateManager.instance:push(ViewName.AngelPowerClgMainView, actId)
end

AngelPowerClgController.instance = AngelPowerClgController.New()

return AngelPowerClgController
