-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonedragondungeon/controller/BoneDragonDungeonController.lua

module("logic.extensions.bonedragondungeon.controller.BoneDragonDungeonController", package.seeall)

local BoneDragonDungeonController = class("BoneDragonDungeonController", BaseController)

function BoneDragonDungeonController:ctor()
	return
end

function BoneDragonDungeonController:onInit()
	self:onReset()
end

function BoneDragonDungeonController:onReset()
	self._isGaming = false
end

function BoneDragonDungeonController:openMissionView(activityId, stageId, eventId, roleId)
	local fmtMo = BoneDragonDungeonModel.instance:getFmtMo()

	fmtMo:initParams(activityId, stageId, eventId, roleId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function BoneDragonDungeonController:handlePM_BoneDragonDungeonGetInfoRes(msg)
	BoneDragonDungeonModel.instance:saveInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_BoneDragonDungeonGetInfoRes)
end

function BoneDragonDungeonController:handlePM_BoneDragonDungeonStartExploreRes(msg)
	BoneDragonDungeonModel.instance:saveGameInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_BoneDragonDungeonStartExploreRes)
end

function BoneDragonDungeonController:handlePM_BoneDragonDungeonMoveRes(msg)
	BoneDragonDungeonModel.instance:saveMoveInfo(msg)

	if msg.finishStage == true then
		GlobalDispatcher:dispatch(GlobalNotify.BoneDragonDungeonCompleteLevel)
	end
end

function BoneDragonDungeonController:handlePM_BoneDragonDungeonExitOrResetRes(msg)
	if msg.exit == true then
		BoneDragonDungeonController.instance:endGame(msg.activityId)
	else
		BoneDragonDungeonModel.instance:initSwitchState(msg.activityId, msg.stageId)
		BoneDragonDungeonModel.instance:initRailState(msg.activityId, msg.stageId)
		BoneDragonDungeonModel.instance:saveResetMap(msg)
		FloatWordMgr.instance:show(lang("当前地图已重置"))
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_BoneDragonDungeonExitOrResetRes, msg.exit)
end

function BoneDragonDungeonController:handlePM_BoneDragonDungeonBuyPetRes(msg)
	BoneDragonDungeonModel.instance:saveBuyPet(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_BoneDragonDungeonBuyPetRes)
end

function BoneDragonDungeonController:handlePM_BoneDragonDungeonHandleEventRes(msg)
	if msg.finish == true then
		BoneDragonDungeonModel.instance:saveHandlerEvent(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_BoneDragonDungeonHandleEventRes)
end

function BoneDragonDungeonController:handlePM_BoneDragonDungeonGainProgressPrizeRes(msg)
	BoneDragonDungeonModel.instance:savePrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_BoneDragonDungeonGetInfoRes)
end

function BoneDragonDungeonController:handlePM_Notify_BoneDragonDungeonChallengeResult(msg)
	if msg.win == true then
		BoneDragonDungeonModel.instance:saveBattleEvent(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_BoneDragonDungeonHandleEventRes)
end

function BoneDragonDungeonController:checkExitOpen(activityId, stageId)
	local gameInfo = BoneDragonDungeonModel.instance:getGameInfo()

	if not gameInfo then
		return false
	end

	local stageCfg = BoneDragonDungeonConfig.instance:getStageCfg(activityId, stageId)
	local eventCfgs = BoneDragonDungeonConfig.instance:getEventCfgs(stageCfg.eventPlanId)
	local isAllEventFinish = true

	for i, v in ipairs(eventCfgs) do
		if v.finishToExit == true and not BoneDragonDungeonModel.instance:isEventFinish(v.eventId) then
			isAllEventFinish = false
		end
	end

	return isAllEventFinish
end

function BoneDragonDungeonController:startGame(activityId, stageId)
	self._isGaming = true

	BoneDragonDungeonAgent.instance:sendPM_BoneDragonDungeonStartExploreReq(activityId, stageId)
end

function BoneDragonDungeonController:endGame(activityId)
	BoneDragonDungeonModel.instance:clearGameInfo()

	self._isGaming = false
end

function BoneDragonDungeonController:isGaming(activityId)
	return self._isGaming == true
end

BoneDragonDungeonController.instance = BoneDragonDungeonController.New()

return BoneDragonDungeonController
