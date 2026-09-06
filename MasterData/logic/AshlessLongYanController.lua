-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ashlesslongyan/controller/AshlessLongYanController.lua

module("logic.extensions.ashlesslongyan.controller.AshlessLongYanController", package.seeall)

local AshlessLongYanController = class("AshlessLongYanController", BaseController)

function AshlessLongYanController:onInit()
	self:onReset()
end

function AshlessLongYanController:onReset()
	return
end

function AshlessLongYanController:sendPM_AshlessLongYanGetInfoReq(activityId)
	AshlessLongYanAgent.instance:sendPM_AshlessLongYanGetInfoReq(activityId)
end

function AshlessLongYanController:handlePM_AshlessLongYanGetInfoRes(msg)
	local mo = self:getLongYanMo(msg.activityId)

	mo:handlePM_AshlessLongYanGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_AshlessLongYanGetInfoRes)
end

function AshlessLongYanController:sendPM_AshlessLongYanChallengeReq(activityId, phaseId, stageId, form)
	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)

		local result = false
		local mo = self:getLongYanMo(activityId)
		local msg = mo:getEndResMsg()

		if msg:HasField("changeSetId") then
			mo:setChangeSetId(msg.changeSetId)
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)

			local tipsContent = "本层已通关"

			local function okFunc()
				if mo:getCurPhaseId() + 1 > mo:getMaxPhaseId() then
					UIJumper.instance:removeTopState(ViewName.AshlessLongYanStageView)
				end

				BattleController.instance:endBattle()
			end

			local alignment = UnityEngine.TextAnchor.MiddleCenter

			TipsFacade.instance:openTipWindowNoX("胜利", tipsContent, okFunc, "确定", alignment)

			result = true
		elseif msg.win then
			UIStateManager.instance:push(ViewName.AshlessLongYanClgResultPopView, activityId, phaseId, stageId)

			result = true
		end

		return result
	end)
	AshlessLongYanAgent.instance:sendPM_AshlessLongYanChallengeReq(activityId, phaseId, stageId, form)
end

function AshlessLongYanController:handlePM_AshlessLongYanChallengeRes(msg)
	return
end

function AshlessLongYanController:sendPM_AshlessLongYanConfirmScoreReq(activityId, phaseId, stageId, confirm)
	AshlessLongYanAgent.instance:sendPM_AshlessLongYanConfirmScoreReq(activityId, phaseId, stageId, confirm)
end

function AshlessLongYanController:handlePM_AshlessLongYanConfirmScoreRes(msg)
	local mo = self:getLongYanMo(msg.activityId)

	mo:handlePM_AshlessLongYanConfirmScoreRes(msg)

	if msg:HasField("changeSetId") then
		mo:setChangeSetId(msg.changeSetId)
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_AshlessLongYanConfirmScoreRes)
end

function AshlessLongYanController:sendPM_AshlessLongYanUseWoodReq(activityId, phaseId, stageId, useCount)
	AshlessLongYanAgent.instance:sendPM_AshlessLongYanUseWoodReq(activityId, phaseId, stageId, useCount)
end

function AshlessLongYanController:handlePM_AshlessLongYanUseWoodRes(msg)
	local mo = self:getLongYanMo(msg.activityId)

	mo:handlePM_AshlessLongYanUseWoodRes(msg)

	if msg:HasField("changeSetId") then
		mo:setChangeSetId(msg.changeSetId)
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_AshlessLongYanUseWoodRes, msg)
end

function AshlessLongYanController:sendPM_AshlessLongYanStashOrTakeReq(activityId, phaseId, stageId, stashOrTake)
	AshlessLongYanAgent.instance:sendPM_AshlessLongYanStashOrTakeReq(activityId, phaseId, stageId, stashOrTake)
end

function AshlessLongYanController:handlePM_AshlessLongYanStashOrTakeRes(msg)
	local mo = self:getLongYanMo(msg.activityId)

	mo:handlePM_AshlessLongYanStashOrTakeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_AshlessLongYanStashOrTakeRes)
end

function AshlessLongYanController:sendPM_AshlessLongYanResetPhaseReq(activityId, phaseId)
	AshlessLongYanAgent.instance:sendPM_AshlessLongYanResetPhaseReq(activityId, phaseId)
end

function AshlessLongYanController:handlePM_AshlessLongYanResetPhaseRes(msg)
	local mo = self:getLongYanMo(msg.activityId)

	mo:handlePM_AshlessLongYanResetPhaseRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_AshlessLongYanResetPhaseRes)
end

function AshlessLongYanController:handlePM_Notify_AshlessLongYanChallengeEndRes(msg)
	local mo = self:getLongYanMo(msg.activityId)

	mo:handlePM_Notify_AshlessLongYanChallengeEndRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_Notify_AshlessLongYanChallengeEndRes)
end

function AshlessLongYanController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function AshlessLongYanController:getActivityType()
	return GameEnum.ActivityType.AshlessLongYan
end

function AshlessLongYanController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function AshlessLongYanController:getLongYanMo(activityId)
	return AshlessLongYanModel.instance:getLongYanMo(activityId)
end

function AshlessLongYanController:getRaceId(activityId)
	return PetSkinConfig.instance:getPetSkinRaceId(self:getSkinId(activityId))
end

function AshlessLongYanController:getSkinId(activityId)
	local data = AshlessLongYanConfig.instance:getActData(activityId)

	return (data or nil) and (data.skinId or 0)
end

function AshlessLongYanController:enterBattle(activityId, phaseId, stageId)
	local fmtMo = AshlessLongYanModel.instance:getLongYanFmtMo()

	fmtMo:updateCfg(activityId, phaseId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function AshlessLongYanController:getTryStartClgResultAndTips(isNeedTips, activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local mo = self:getLongYanMo(activityId)

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif mo:isPassAll() then
		result = GameEnum.ResultCode.IsPass
		tips = "已通关"
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

AshlessLongYanController.instance = AshlessLongYanController.New()

return AshlessLongYanController
