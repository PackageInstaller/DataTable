-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bricksxgame/controller/BricksxgameController.lua

module("logic.extensions.bricksxgame.controller.BricksxgameController", package.seeall)

local BricksxgameController = class("BricksxgameController", BaseController)

function BricksxgameController:onInit()
	self:onReset()
end

function BricksxgameController:onReset()
	return
end

function BricksxgameController:getDeafultActId()
	return 454001
end

function BricksxgameController:sendGetInfo(activityId)
	XiaoXiaoLeGameAgent.instance:sendPM_XiaoXiaoLeGameInfoReq(activityId)
end

function BricksxgameController:onGetInfo(msg)
	BricksxgameModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.BRICKSXGAME_INFO_UPDATE)
end

function BricksxgameController:sendGetPrize(activityId)
	XiaoXiaoLeGameAgent.instance:sendPM_XiaoXiaoLeGameOneKeyGainPrizeReq(activityId)
end

function BricksxgameController:onGetPrize(msg)
	BricksxgameModel.instance:onGetPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.BRICKSXGAME_INFO_UPDATE)
end

function BricksxgameController:sendGetRank(activityId)
	XiaoXiaoLeGameAgent.instance:sendPM_XiaoXiaoLeGameRankReq(activityId)
end

function BricksxgameController:onGetRank(msg)
	BricksxgameModel.instance:onGetRank(msg)
	GlobalDispatcher:dispatch(GlobalNotify.BRICKSXGAME_INFO_UPDATE)
end

function BricksxgameController:sendStartGame(activityId)
	self._tempActivityId = activityId

	local clientKey = math.random(ServerTime.now())

	self._clientKey = clientKey

	XiaoXiaoLeGameAgent.instance:sendPM_XiaoXiaoLeGameStartGameReq(activityId, clientKey)
end

function BricksxgameController:onStartGame(msg)
	self._serverKey = msg.serverKey

	UIStateManager.instance:push(ViewName.BricksxgameplayView, self._tempActivityId)
end

function BricksxgameController:sendEndGame(activityId, isPass, score)
	local encryptedKey = GameUtil.getClientEncryptedKey(self._clientKey, self._serverKey, {
		score
	})

	XiaoXiaoLeGameAgent.instance:sendPM_XiaoXiaoLeGameEndGameReq(activityId, isPass, score, encryptedKey)
end

function BricksxgameController:onEndGame(msg)
	GlobalDispatcher:dispatch(GlobalNotify.BRICKSXGAME_END_GAME)
end

function BricksxgameController:sendPM_XiaoXiaoLeGameSweepReq(activityId, score, times)
	XiaoXiaoLeGameAgent.instance:sendPM_XiaoXiaoLeGameSweepReq(activityId, score, times)
end

function BricksxgameController:handlePM_XiaoXiaoLeGameSweepRes(msg)
	BricksxgameModel.instance:handlePM_XiaoXiaoLeGameSweepRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_XiaoXiaoLeGameSweepRes, msg.score)
end

function BricksxgameController:hasCanGetPrize(activityId)
	local info = BricksxgameModel.instance:getInfo(activityId)

	if info then
		if info.gainPrizeIds ~= nil then
			if not info.gainPrizeIds then
				local gainPrizeIds = {}
				local prizeList = BricksxgameConfig.instance:getPorgressListById(activityId)

				if gainPrizeIds then
					for i, v in ipairs(prizeList) do
						if info.score >= v.score and not table.indexof(gainPrizeIds, v.prizeId) then
							return true
						end
					end
				end
			end
		end
	end

	return false
end

BricksxgameController.instance = BricksxgameController.New()

return BricksxgameController
