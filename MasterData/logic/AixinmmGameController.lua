-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aixinmmgame/controller/AixinmmGameController.lua

module("logic.extensions.aixinmmgame.controller.AixinmmGameController", package.seeall)

local AixinmmGameController = class("AixinmmGameController", BaseController)

function AixinmmGameController:onReset()
	self._clientKey = 0
	self._serverKey = 0
end

function AixinmmGameController:onInit()
	GlobalDispatcher:addListener("enteraixinmmgame", self._enterAixinmmGame, self)
end

function AixinmmGameController:getInfo(activityId)
	AixinmmGameAgent.instance:sendPM_AXMMGameGetInfoReq(activityId)
end

function AixinmmGameController:getGamePrize(activityId, prizeId)
	AixinmmGameAgent.instance:sendPM_AXMMGameGetGamePrizeReq(activityId, prizeId)
end

function AixinmmGameController:startGame(activityId)
	local clientKey = math.random(ServerTime.now())

	self._clientKey = clientKey

	AixinmmGameAgent.instance:sendPM_AXMMGameStartGameReq(activityId, clientKey)
end

function AixinmmGameController:settleGame(activityId, shovelNums)
	local key = GameUtil.getClientEncryptedKey(self._clientKey, self._serverKey, {
		shovelNums
	})

	AixinmmGameAgent.instance:sendPM_AXMMGameEndGameReq(activityId, shovelNums, key)
end

function AixinmmGameController:handleGetInfo(msg)
	AixinmmGameModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.AixinmmGameUpdateInfo)
end

function AixinmmGameController:handleGetGamePrize(msg)
	AixinmmGameModel.instance:onGetGamePrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.AixinmmGameUpdateInfo)
end

function AixinmmGameController:handleStartGame(msg)
	AixinmmGameModel.instance:onStartGame(msg)

	self._serverKey = msg.serverKey

	GlobalDispatcher:dispatch(GlobalNotify.AixinmmGameStartGame)
end

function AixinmmGameController:handleSettleGame(msg)
	AixinmmGameModel.instance:onSettleGame(msg)
	UIStateManager.instance:popByName(ViewName.AixinmmGameMainView)
	GlobalDispatcher:dispatch(GlobalNotify.AixinmmGameUpdateInfo)
end

function AixinmmGameController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function AixinmmGameController:getActivityType()
	return GameEnum.ActivityType.AixinMMHospital
end

function AixinmmGameController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function AixinmmGameController:_enterAixinmmGame(params)
	self:enterAixinmmGame(checknumber(params[1]))
end

function AixinmmGameController:enterAixinmmGame(activityId)
	if checknumber(activityId) <= 0 then
		activityId = self:getActivityId()
	end

	if not self:isInActivityTime(activityId) then
		FloatWordMgr.instance:show("不在活动开始时间内")

		return
	end

	UIStateManager.instance:push(ViewName.AixinmmGameStartView, activityId)
end

AixinmmGameController.instance = AixinmmGameController.New()

return AixinmmGameController
