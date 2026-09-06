-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aruishidragongame/agent/ARuiShiDragonGameAgent.lua

module("logic.extensions.aruishidragongame.agent.ARuiShiDragonGameAgent", package.seeall)

local ARuiShiDragonGameAgent = class("ARuiShiDragonGameAgent", BaseAgent)

function ARuiShiDragonGameAgent:sendPM_ARuiShiDragonGameInfoReq(activityId)
	local req = ARuiShiDragonGameExtension_pb.PM_ARuiShiDragonGameInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ARuiShiDragonGameAgent:handlePM_ARuiShiDragonGameInfoRes(status, msg)
	if status == 0 then
		ARuiShiDragonGameModel.instance:onInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ARuiShiDragonGameInfoRes)
	end
end

function ARuiShiDragonGameAgent:sendPM_ARuiShiDragonGameStartReq(activityId, clientKey)
	local req = ARuiShiDragonGameExtension_pb.PM_ARuiShiDragonGameStartReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)

	self._startActivityId = activityId
end

function ARuiShiDragonGameAgent:handlePM_ARuiShiDragonGameStartRes(status, msg)
	if status == 0 then
		ARuiShiDragonGameModel.instance:onStartRes(msg, self._startActivityId)
		GlobalDispatcher:dispatch(GlobalNotify.ARuiShiDragonGameStartRes)
	end

	self._startActivityId = nil
end

function ARuiShiDragonGameAgent:sendPM_ARuiShiDragonGameEndReq(activityId, isPass, num, encryptedKey)
	local req = ARuiShiDragonGameExtension_pb.PM_ARuiShiDragonGameEndReq()

	req.activityId = activityId
	req.isPass = isPass
	req.num = num
	req.encryptedKey = encryptedKey

	self:sendMsg(req)

	self._isPass = isPass
	self._num = num
	self._encryptedKey = encryptedKey
end

function ARuiShiDragonGameAgent:handlePM_ARuiShiDragonGameEndRes(status, msg)
	if status == 0 then
		ARuiShiDragonGameModel.instance:onEndRes(msg, self._isPass, self._num, self._encryptedKey)
		GlobalDispatcher:dispatch(GlobalNotify.ARuiShiDragonGameEndRes)
	end

	self._isPass = nil
	self._num = nil
	self._encryptedKey = nil
end

function ARuiShiDragonGameAgent:sendPM_ARuiShiDragonGameGainPrizeReq(activityId, prizeId)
	local req = ARuiShiDragonGameExtension_pb.PM_ARuiShiDragonGameGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function ARuiShiDragonGameAgent:handlePM_ARuiShiDragonGameGainPrizeRes(status, msg)
	if status == 0 then
		ARuiShiDragonGameModel.instance:onGainPrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ARuiShiDragonGameGainPrizeRes)
	end
end

ARuiShiDragonGameAgent.instance = ARuiShiDragonGameAgent.New()

return ARuiShiDragonGameAgent
