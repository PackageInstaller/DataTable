-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/agent/AceTeamAgent.lua

module("logic.extensions.aceteam.agent.AceTeamAgent", package.seeall)

local AceTeamAgent = class("AceTeamAgent", BaseAgent)

function AceTeamAgent:ctor()
	return
end

function AceTeamAgent:setExtId(extId)
	AceTeamAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function AceTeamAgent:sendPM_AceTeamGetInfoReq()
	local req = AceTeamExtension_pb.PM_AceTeamGetInfoReq()

	self:sendMsg(req)
end

function AceTeamAgent:handlePM_AceTeamGetInfoRes(status, msg)
	if status == 0 then
		AceTeamModel.instance:setInfo(msg)
	else
		AceTeamModel.instance:onGetInfoErr(status, msg)
	end
end

function AceTeamAgent:sendPM_AceTeamMatchFightReq(activityId)
	local req = AceTeamExtension_pb.PM_AceTeamMatchFightReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AceTeamAgent:handlePM_AceTeamMatchFightRes(status, msg)
	if status == 0 then
		-- block empty
	else
		AceTeamController.instance:onMatchFail()
	end
end

function AceTeamAgent:sendPM_AceTeamCancelMatchReq()
	local req = AceTeamExtension_pb.PM_AceTeamCancelMatchReq()

	self:sendMsg(req)
end

function AceTeamAgent:handlePM_AceTeamCancelMatchRes(status, msg)
	return
end

function AceTeamAgent:sendPM_AceTeamFightBossReq(simpleForm_pb)
	local req = AceTeamExtension_pb.PM_AceTeamFightBossReq()

	if simpleForm_pb ~= nil then
		req.simpleForm:ParseFromString(simpleForm_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function AceTeamAgent:handlePM_AceTeamFightBossRes(status, msg)
	AceTeamController.instance:aceTeamFightBossRes(status)
end

function AceTeamAgent:sendPM_AceTeamSetMatchFormReq(activityId, simpleForm_pb)
	local req = AceTeamExtension_pb.PM_AceTeamSetMatchFormReq()

	req.activityId = activityId

	if simpleForm_pb ~= nil then
		req.simpleForm:ParseFromString(simpleForm_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function AceTeamAgent:handlePM_AceTeamSetMatchFormRes(status, msg)
	if status == 0 then
		AceTeamModel.instance:onSaveForm(msg)
	end

	AceTeamController.instance:aceTeamSetMatchFormRes(status)
	TipsFacade.instance:openCommonTips(lang("aceteamagent__2"))
end

function AceTeamAgent:sendPM_AceTeamBuyMatchTimesReq()
	local req = AceTeamExtension_pb.PM_AceTeamBuyMatchTimesReq()

	self:sendMsg(req)
end

function AceTeamAgent:handlePM_AceTeamBuyMatchTimesRes(status, msg)
	if status == 0 then
		AceTeamModel.instance:onAddBuyTimeCount(msg)
	end
end

function AceTeamAgent:sendPM_AceTeamViewMedalRankReq(startRank, endRank)
	local req = AceTeamExtension_pb.PM_AceTeamViewMedalRankReq()

	req.startRank = startRank
	req.endRank = endRank

	self:sendMsg(req)
end

function AceTeamAgent:handlePM_AceTeamViewMedalRankRes(status, msg)
	if status == 0 then
		AceTeamController.instance:rankDataRes(AceteamrankView.TabDefine.Person, msg)
	end
end

function AceTeamAgent:sendPM_AceTeamViewTeamPowerRankReq()
	local req = AceTeamExtension_pb.PM_AceTeamViewTeamPowerRankReq()

	self:sendMsg(req)
end

function AceTeamAgent:handlePM_AceTeamViewTeamPowerRankRes(status, msg)
	if status == 0 then
		AceTeamController.instance:rankDataRes(AceteamrankView.TabDefine.Team, msg)
	end
end

function AceTeamAgent:sendPM_AceTeamChangeTeamReq(teamId)
	local req = AceTeamExtension_pb.PM_AceTeamChangeTeamReq()

	req.teamId = teamId

	self:sendMsg(req)
end

function AceTeamAgent:handlePM_AceTeamChangeTeamRes(status, msg)
	if status == 0 then
		AceTeamController.instance:onChangeTeam(msg)
	end
end

function AceTeamAgent:sendPM_AceTeamLoadPetsReq()
	local req = AceTeamExtension_pb.PM_AceTeamLoadPetsReq()

	self:sendMsg(req)
end

function AceTeamAgent:handlePM_AceTeamLoadPetsRes(status, msg)
	if status == 0 then
		AceTeamModel.instance:getUpdatePetMo(msg)
	end
end

function AceTeamAgent:sendPM_AceTeamEquipmentLvReq(petId, positionId, targetLv)
	local req = AceTeamExtension_pb.PM_AceTeamEquipmentLvReq()

	req.petId = petId
	req.positionId = positionId

	if targetLv ~= nil then
		req.targetLv = targetLv
	end

	self:sendMsg(req)
end

function AceTeamAgent:handlePM_AceTeamEquipmentLvRes(status, msg)
	if status == 0 then
		TipsFacade.instance:openCommonTips(lang("aceteamagent__3"))
	end
end

function AceTeamAgent:sendPM_AceTeamChangeStarGodPlusReq(petId, slot, fillerDefineId)
	local req = AceTeamExtension_pb.PM_AceTeamChangeStarGodPlusReq()

	req.petId = petId
	req.slot = slot
	req.fillerDefineId = fillerDefineId

	self:sendMsg(req)
end

function AceTeamAgent:handlePM_AceTeamChangeStarGodPlusRes(status, msg)
	if status == 0 then
		TipsFacade.instance:openCommonTips(lang("aceteamagent__4"))
		GlobalDispatcher:dispatch(GlobalNotify.PM_ACETEAM_STARGOD_CHANGE)
	end
end

function AceTeamAgent:sendPM_AceTeamStarGodPlusLvUpReq(petId, slot, targetLv)
	local req = AceTeamExtension_pb.PM_AceTeamStarGodPlusLvUpReq()

	req.petId = petId
	req.slot = slot

	if targetLv ~= nil then
		req.targetLv = targetLv
	end

	self:sendMsg(req)
end

function AceTeamAgent:handlePM_AceTeamStarGodPlusLvUpRes(status, msg)
	if status == 0 then
		TipsFacade.instance:openCommonTips(lang("aceteamagent__5"))
	end
end

function AceTeamAgent:sendPM_AceTeamSkillLvUpReq(petId, skillType, targetLv)
	local req = AceTeamExtension_pb.PM_AceTeamSkillLvUpReq()

	req.petId = petId
	req.skillType = skillType

	if targetLv ~= nil then
		req.targetLv = targetLv
	end

	self:sendMsg(req)
end

function AceTeamAgent:handlePM_AceTeamSkillLvUpRes(status, msg)
	if status == 0 then
		TipsFacade.instance:openCommonTips(lang("aceteamagent__6"))
	end
end

function AceTeamAgent:sendPM_AceTeamAwakenLvUpReq(petId, targetLv)
	local req = AceTeamExtension_pb.PM_AceTeamAwakenLvUpReq()

	req.petId = petId

	if targetLv ~= nil then
		req.targetLv = targetLv
	end

	self:sendMsg(req)
end

function AceTeamAgent:handlePM_AceTeamAwakenLvUpRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_ACETEAM_PETAWAKEN, status, msg)
end

function AceTeamAgent:sendPM_AceTeamBuyPointReq(buyTimes)
	local req = AceTeamExtension_pb.PM_AceTeamBuyPointReq()

	req.buyTimes = buyTimes

	self:sendMsg(req)
end

function AceTeamAgent:handlePM_AceTeamBuyPointRes(status, msg)
	if status == 0 then
		AceTeamModel.instance:onAddPointCount(msg)
	end
end

function AceTeamAgent:sendPM_AceTeamSourceTraceUnlockEffectReq(petId, nodeId, effectId)
	local req = AceTeamExtension_pb.PM_AceTeamSourceTraceUnlockEffectReq()

	req.petId = petId
	req.nodeId = nodeId
	req.effectId = effectId

	self:sendMsg(req)
end

function AceTeamAgent:handlePM_AceTeamSourceTraceUnlockEffectRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.PM_ACETEAM_SOURCE_TRACE_UNLOCK)
	end
end

function AceTeamAgent:sendPM_AceTeamSourceTraceSelectEffectReq(petId, nodeId, effectId)
	local req = AceTeamExtension_pb.PM_AceTeamSourceTraceSelectEffectReq()

	req.petId = petId
	req.nodeId = nodeId
	req.effectId = effectId

	self:sendMsg(req)
end

function AceTeamAgent:handlePM_AceTeamSourceTraceSelectEffectRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.PM_ACETEAM_SOURCE_TRACE_SELECT)
	end
end

function AceTeamAgent:handlePM_AceTeamNotifyMatchOvertimeRes(status, msg)
	AceTeamController.instance:onMatchTimeOver()
end

function AceTeamAgent:handlePM_AceTeamNotifyMatchFightFinishRes(status, msg)
	AceTeamModel.instance:onNotifyFight(msg)

	if msg.bossId > 0 then
		UIJumper.instance:pushOneStack(ViewName.ActbosstriggerView)
	end
end

function AceTeamAgent:handlePM_AceTeamNotifyMatchFailRes(status, msg)
	return
end

function AceTeamAgent:handlePM_AceTeamNotifyFightBossFinishRes(status, msg)
	if status == 0 then
		AceTeamModel.instance:notifyFightBossFinish(msg)
	end
end

function AceTeamAgent:handlePM_NotifyAceTeamPetChangedRes(status, msg)
	if status == 0 then
		AceTeamModel.instance:updateOnePetMo(msg.curTeamId, msg.pet)
		GlobalDispatcher:dispatch(GlobalNotify.PM_ACETEAM_GETINFO)
	end
end

function AceTeamAgent:handlePM_NotifyAceTeamPointChangeRes(status, msg)
	AceTeamModel.instance:updatePoint(msg)
end

function AceTeamAgent:sendPM_AceTeamHolyStripeLevelUpReq(petId, positionId, targetLv)
	local req = AceTeamExtension_pb.PM_AceTeamHolyStripeLevelUpReq()

	req.petId = petId
	req.positionId = positionId

	if targetLv ~= nil then
		req.targetLv = targetLv
	end

	self:sendMsg(req)
end

function AceTeamAgent:handlePM_AceTeamHolyStripeLevelUpRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.PM_ACETEAM_HOLYSTRIPE_LEVELUP)
	end
end

function AceTeamAgent:sendPM_AceTeamHoyStripeChangeSuitReq(petId, suitId)
	local req = AceTeamExtension_pb.PM_AceTeamHoyStripeChangeSuitReq()

	req.petId = petId
	req.suitId = suitId

	self:sendMsg(req)
end

function AceTeamAgent:handlePM_AceTeamHoyStripeChangeSuitRes(status, msg)
	if status == 0 then
		TipsFacade.instance:openCommonTips(lang("灵纹替换成功"))
		GlobalDispatcher:dispatch(GlobalNotify.PM_ACETEAM_HOLYSTRIPE_CHANGE)
	end
end

AceTeamAgent.instance = AceTeamAgent.New()

return AceTeamAgent
