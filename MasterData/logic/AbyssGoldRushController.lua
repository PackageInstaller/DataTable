-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/abyssgoldrush/controller/AbyssGoldRushController.lua

module("logic.extensions.abyssgoldrush.controller.AbyssGoldRushController", package.seeall)

local AbyssGoldRushController = class("AbyssGoldRushController", BaseController)

function AbyssGoldRushController:ctor()
	return
end

function AbyssGoldRushController:onInit()
	self:onReset()
end

function AbyssGoldRushController:onReset()
	return
end

function AbyssGoldRushController:handlePM_AbyssGoldRushGetInfoRes(msg)
	AbyssGoldRushModel.instance:saveInfo(msg)

	local data = GameUtil.pbToTable(msg.gameInfo)

	if data then
		AbyssGoldRushGameController.instance:tryRestartGame(msg)
	end

	local actCfg = AbyssGoldRushConfig.instance:getActivityCfg(msg.activityId)
	local matType, id = MaterialMgr.getMatParams(actCfg.fakeItem)

	MaterialFacade.instance:UpdateMaterial(matType, id, AbyssGoldRushModel.instance:getAbyssCoinCount(msg.activityId))
	GlobalDispatcher:dispatch(GlobalNotify.PM_AbyssGoldRushGetInfoRes, msg)
end

function AbyssGoldRushController:handlePM_AbyssGoldRushPresetRes(msg)
	AbyssGoldRushModel.instance:saveHolyStripePreset(msg.activityId, msg.presetId, msg.holyStripePreset)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AbyssGoldRushPresetRes, msg)
end

function AbyssGoldRushController:handlePM_AbyssGoldRushStartGameRes(msg)
	AbyssGoldRushGameModel.instance:saveGameInfo(msg.gameInfo, true)
	AbyssGoldRushGameModel.instance:onStartGame(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AbyssGoldRushStartGameRes, msg)
end

function AbyssGoldRushController:handlePM_AbyssGoldRushPushStepRes(msg)
	AbyssGoldRushGameController.instance:handlePM_AbyssGoldRushPushStepRes(msg)
end

function AbyssGoldRushController:handlePM_AbyssGoldRushFightRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.PM_AbyssGoldRushFightRes, msg)
	end
end

function AbyssGoldRushController:handlePM_AbyssGoldRushNotifyFightRes(msg)
	AbyssGoldRushGameController.instance:handlePM_AbyssGoldRushNotifyFightRes(msg)
end

function AbyssGoldRushController:handlePM_AbyssGoldRushFinishGameRes(msg)
	AbyssGoldRushGameModel.instance:resetGame()
	AbyssGoldRushModel.instance:saveResultInfo(msg)

	local actCfg = AbyssGoldRushConfig.instance:getActivityCfg(msg.activityId)
	local matType, id = MaterialMgr.getMatParams(actCfg.fakeItem)

	MaterialFacade.instance:UpdateMaterial(matType, id, AbyssGoldRushModel.instance:getAbyssCoinCount(msg.activityId))
	GlobalDispatcher:dispatch(GlobalNotify.PM_AbyssGoldRushFinishGameRes, msg)
end

function AbyssGoldRushController:handlePM_AbyssGoldRushRankViewRes(msg)
	AbyssGoldRushModel.instance:saveRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AbyssGoldRushRankViewRes, msg)
end

function AbyssGoldRushController:handlePM_AbyssGoldRushUsePresetRes(msg)
	AbyssGoldRushModel.instance:saveUsePresetId(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AbyssGoldRushPresetRes, msg)
end

function AbyssGoldRushController:getCurScoreLevel(activityId)
	local id = 1
	local curScore = AbyssGoldRushModel.instance:getLevelScore(activityId)
	local cfgs = AbyssGoldRushConfig.instance:getScoreLevelCfgs(activityId)

	for i, v in ipairs(cfgs) do
		if curScore > v.score then
			id = v.id
		end
	end

	return id
end

AbyssGoldRushController.instance = AbyssGoldRushController.New()

return AbyssGoldRushController
