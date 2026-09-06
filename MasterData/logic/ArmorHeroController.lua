-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/armorhero/controller/ArmorHeroController.lua

module("logic.extensions.armorhero.controller.ArmorHeroController", package.seeall)

local ArmorHeroController = class("ArmorHeroController", BaseController)

function ArmorHeroController:onInit()
	self:onReset()
end

function ArmorHeroController:onReset()
	self._fmtMoMap = {}
end

function ArmorHeroController:getInfoKey(activityId, stageId)
	local actId = checknumber(activityId)
	local stId = checknumber(stageId)

	if actId > 0 and stId > 0 then
		return string.format("%s_%s", actId, stId)
	end
end

function ArmorHeroController:_getFmtMo(activityId, stageId)
	local key = self:getInfoKey(activityId, stageId)

	if key then
		local fmtMo = self._fmtMoMap[key]

		if not fmtMo then
			fmtMo = ArmorHeroFmtMo.New()
			self._fmtMoMap[key] = fmtMo
		end

		return fmtMo
	end
end

function ArmorHeroController:showBossMissionView(activityId, stageId)
	local fmtMo = self:_getFmtMo(activityId, stageId)

	if fmtMo then
		fmtMo:initParams(activityId, stageId)
		CustomFmtController.instance:showMissionView(fmtMo)
	end
end

function ArmorHeroController:getInfo(activityId)
	ArmorHeroAgent.instance:sendPM_ArmorHeroInfoReq(activityId)
end

function ArmorHeroController:handleGetInfo(msg)
	ArmorHeroModel.instance:handlePM_ArmorHeroInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_ArmorHeroInfoRes)
end

function ArmorHeroController:sendSummon(activityId, summonId)
	ArmorHeroAgent.instance:sendPM_ArmorHeroSummonReq(activityId, summonId)
end

function ArmorHeroController:handleSummon(msg)
	ArmorHeroModel.instance:handlePM_ArmorHeroSummonRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_ArmorHeroSummonRes)
end

function ArmorHeroController:sendGainTaskPrize(activityId)
	ArmorHeroAgent.instance:sendPM_ArmorHeroGainTaskPrizeReq(activityId)
end

function ArmorHeroController:handleGainTaskPrize(msg)
	ArmorHeroModel.instance:handlePM_ArmorHeroGainTaskPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_ArmorHeroGainTaskPrizeRes)
end

function ArmorHeroController:sendGainBookPrize(activityId)
	ArmorHeroAgent.instance:sendPM_ArmorHeroGainBookPrizeReq(activityId)
end

function ArmorHeroController:handleGainBookPrize(msg)
	ArmorHeroModel.instance:handlePM_ArmorHeroGainBookPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_ArmorHeroGainBookPrizeRes)
end

function ArmorHeroController:sendGainSharePrize(activityId)
	ArmorHeroAgent.instance:sendPM_ArmorHeroGainSharePrizeReq(activityId)
end

function ArmorHeroController:handleGainSharePrize(msg)
	ArmorHeroModel.instance:handlePM_ArmorHeroGainSharePrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_ArmorHeroGainSharePrizeRes)
end

function ArmorHeroController:sendGainProgressPrize(activityId, progressId, stageId)
	ArmorHeroAgent.instance:sendPM_ArmorHeroGainProgressPrizeReq(activityId, progressId, stageId)
end

function ArmorHeroController:handleGainProgressPrize(msg)
	ArmorHeroModel.instance:handlePM_ArmorHeroGainProgressPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_ArmorHeroGainProgressPrizeRes)
end

function ArmorHeroController:sendChallenge(activityId, form_pb, stageId)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onResBossBattleEnd, self, activityId, stageId))
	ArmorHeroAgent.instance:sendPM_ArmorHeroChallengeReq(activityId, form_pb, stageId)
end

function ArmorHeroController:handleNotifyClgFinish(msg)
	ArmorHeroModel.instance:handlePM_ArmorHeroNotifyClgFinish(msg)
end

function ArmorHeroController:_onResBossBattleEnd(activityId, stageId)
	BattleFacade.instance:registerResultHandler(nil, nil)

	local bossDamage = ArmorHeroModel.instance:getBossDamage(activityId, stageId)

	BattleSettlementController.instance:addConditionElement(langPara("累计造成伤害：<color=#99FFB0>%s</color>", bossDamage))
	UIStateManager.instance:open(ViewName.BattleSettlementSuccess)

	return true
end

ArmorHeroController.instance = ArmorHeroController.New()

return ArmorHeroController
