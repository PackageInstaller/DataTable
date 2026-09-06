-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breachformmaster/controller/BreachFormMasterController.lua

module("logic.extensions.breachformmaster.controller.BreachFormMasterController", package.seeall)

local BreachFormMasterController = class("BreachFormMasterController", BaseController)

BreachFormMasterController.ROBOT_STEP_ID = 1
BreachFormMasterController.ATTACK_RANK_TYPE = 1
BreachFormMasterController.DEFECSE_RANK_TYPE = 2
BreachFormMasterController.ATTACK_FROMTION_INFO = 1
BreachFormMasterController.DEFECSE_FROMTION_INFO = 2

function BreachFormMasterController:ctor()
	return
end

function BreachFormMasterController:onInit()
	self:onReset()
end

function BreachFormMasterController:onReset()
	self._tempActivityId = nil
	self._tempStepId = nil
	self._tempStageId = nil
	self._infoType = nil
	self._scrollIdx = 0
end

function BreachFormMasterController:openMissionView(activityId, stepId, stageId)
	if stepId == BreachFormMasterController.ROBOT_STEP_ID then
		local fmtMo = BreachFormMasterModel.instance:getFmtMo()

		fmtMo:initParams(activityId, stepId, stageId)
		CustomFmtController.instance:showMissionView(fmtMo)
	else
		self._tempActivityId = activityId
		self._tempStepId = stepId
		self._tempStageId = stageId
		self._infoType = BreachFormMasterController.ATTACK_FROMTION_INFO

		BreachFormMasterAgent.instance:sendPM_BreachFormMasterStageInfoReq(activityId, stageId)
	end
end

function BreachFormMasterController:openFormationView(activityId, stageId)
	self._tempActivityId = activityId
	self._tempStageId = stageId
	self._infoType = BreachFormMasterController.DEFECSE_FROMTION_INFO

	BreachFormMasterAgent.instance:sendPM_BreachFormMasterStageInfoReq(activityId, stageId)
end

function BreachFormMasterController:handlePM_BreachFormMasterStageInfoRes(msg)
	BreachFormMasterModel.instance:saveOpponentInfo(msg)

	if self._infoType == BreachFormMasterController.ATTACK_FROMTION_INFO then
		local fmtMo = BreachFormMasterModel.instance:getFmtMo()

		fmtMo:initParams(self._tempActivityId, self._tempStepId, self._tempStageId)
		CustomFmtController.instance:showMissionView(fmtMo)
	elseif self._infoType == BreachFormMasterController.DEFECSE_FROMTION_INFO then
		local fmtMo = BreachFormMasterModel.instance:getDefenseFmtMo()

		fmtMo:initParams(self._tempActivityId)
		CustomFmtController.instance:showMissionFormationView(fmtMo)
	end

	self._tempActivityId = nil
	self._tempStepId = nil
	self._tempStageId = nil
	self._infoType = nil

	GlobalDispatcher:dispatch(GlobalNotify.PM_BreachFormMasterStageInfoRes)
end

function BreachFormMasterController:handlePM_BreachFormMasterGetInfoRes(msg)
	BreachFormMasterModel.instance:saveInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_BreachFormMasterGetInfoRes)
end

function BreachFormMasterController:handlePM_BreachFormMasterRankViewRes(msg)
	BreachFormMasterModel.instance:saveRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_BreachFormMasterRankViewReq)
end

function BreachFormMasterController:handlePM_BreachFormMasterBattleReportRes(msg)
	BreachFormMasterModel.instance:saveReportInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_BreachFormMasterBattleReportRes)
end

function BreachFormMasterController:handlePM_BreachFormMasterBattleVideoRes(msg)
	local battleResult = msg.btlResult
	local teamId = 1

	local function callBack()
		BattleModel.instance:setLeftTeamId(teamId)
		BattleController.instance:viewUserFightMonsterBtlResult(battleResult, false)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_BreachFormMasterBattleVideoRes, callBack)
end

function BreachFormMasterController:handlePM_BreachFormMasterFightNotifyRes(msg)
	if msg.isWin == true then
		BreachFormMasterModel.instance:saveBattleResult(msg)
		BattleFacade.instance:registerResultHandler(self._openBattleResultView, self)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_BreachFormMasterGetInfoRes)
end

function BreachFormMasterController:_openBattleResultView()
	UIStateManager.instance:push(ViewName.BreachFormMasterResultView)

	return true
end

function BreachFormMasterController:isDefensePlayer(activityId)
	local curStepId = BreachFormMasterModel.instance:getCurStepId(activityId)

	if curStepId == BreachFormMasterController.ROBOT_STEP_ID then
		return false
	end

	local stageInfos = BreachFormMasterModel.instance:getStageInfos(activityId) or {}

	for i, v in pairs(stageInfos) do
		if checknumber(v.defensePlayerView.headInfo.userId) == checknumber(RoleModel.instance:getUserId()) then
			return true, v.stageId
		end
	end

	return false
end

function BreachFormMasterController:checkCanChallenge(activityId, stepId)
	local actCfg = BreachFormMasterConfig.instance:getActivityCfg(activityId)
	local timeArr = string.split(actCfg.challengeClosedTimeRange, "-")
	local isInTime = not GameUtil.checkIsInTimePeriod(timeArr[1], timeArr[2], true)

	if not isInTime then
		FloatWordMgr.instance:show(lang("未在开启时间内"))
	end

	return isInTime
end

function BreachFormMasterController:calcAttackActivePetScore(activityId, num)
	local stepId = BreachFormMasterModel.instance:getCurStepId(activityId)
	local stepCfg = BreachFormMasterConfig.instance:getStepCfg(activityId, stepId)

	return checknumber(num) * stepCfg.attackPetActiveScore
end

function BreachFormMasterController:calcDefenceActivePetScore(activityId, num)
	local stepId = BreachFormMasterModel.instance:getCurStepId(activityId)
	local stepCfg = BreachFormMasterConfig.instance:getStepCfg(activityId, stepId)

	return checknumber(num) * stepCfg.defensePetActiveScore
end

function BreachFormMasterController:getScrollIdx()
	return self._scrollIdx
end

function BreachFormMasterController:setScrollIdx(idx)
	self._scrollIdx = idx
end

BreachFormMasterController.instance = BreachFormMasterController.New()

return BreachFormMasterController
