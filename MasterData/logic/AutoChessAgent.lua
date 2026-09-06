-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/agent/AutoChessAgent.lua

module("logic.extensions.autochess.agent.AutoChessAgent", package.seeall)

local AutoChessAgent = class("AutoChessAgent", BaseAgent)

AutoChessAgent.ACInfoRes = "AutoChessAgent.ACInfoRes"
AutoChessAgent.ACStartMatchRes = "AutoChessAgent.ACStartMatchRes"
AutoChessAgent.ACCancelMatchRes = "AutoChessAgent.ACCancelMatchRes"
AutoChessAgent.ACLeaveGameRes = "AutoChessAgent.ACLeaveGameRes"
AutoChessAgent.ACSelectInitBuffRes = "AutoChessAgent.ACSelectInitBuffRes"
AutoChessAgent.ACBuyPetRes = "AutoChessAgent.ACBuyPetRes"
AutoChessAgent.ACRefreshShopRes = "AutoChessAgent.ACRefreshShopRes"
AutoChessAgent.ACLockShopRes = "AutoChessAgent.ACLockShopRes"
AutoChessAgent.ACSellPetRes = "AutoChessAgent.ACSellPetRes"
AutoChessAgent.ACSetFormationRes = "AutoChessAgent.ACSetFormationRes"
AutoChessAgent.ACSelectBuffRes = "AutoChessAgent.ACSelectBuffRes"
AutoChessAgent.ACSelectFullStarBuffRes = "AutoChessAgent.ACSelectFullStarBuffRes"
AutoChessAgent.ACGetBattleRecordRes = "AutoChessAgent.ACGetBattleRecordRes"
AutoChessAgent.ACRankInfoRes = "AutoChessAgent.ACRankInfoRes"
AutoChessAgent.ACNotifyMatchingOverTimeRes = "AutoChessAgent.ACNotifyMatchingOverTimeRes"
AutoChessAgent.ACNotifyMatchFailRes = "AutoChessAgent.ACNotifyMatchFailRes"
AutoChessAgent.ACNotifyGameStartRes = "AutoChessAgent.ACNotifyGameStartRes"
AutoChessAgent.ACNotifyRefreshPetShopRes = "AutoChessAgent.ACNotifyRefreshPetShopRes"
AutoChessAgent.ACNotifyAfterPetChangedRes = "AutoChessAgent.ACNotifyAfterPetChangedRes"
AutoChessAgent.ACNotifyInitBuffInfoChangedRes = "AutoChessAgent.ACNotifyInitBuffInfoChangedRes"
AutoChessAgent.ACNotifyNextRoundRes = "AutoChessAgent.ACNotifyNextRoundRes"
AutoChessAgent.ACNotifySelectFullStarBuffRes = "AutoChessAgent.ACNotifySelectFullStarBuffRes"
AutoChessAgent.ACNotifyGameEndRes = "AutoChessAgent.ACNotifyGameEndRes"
AutoChessAgent.ACNotifyResultCodeRes = "AutoChessAgent.ACNotifyResultCodeRes"

function AutoChessAgent:sendPM_ACInfoReq(activityId)
	local req = AutoChessExtension_pb.PM_ACInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AutoChessAgent:handlePM_ACInfoRes(status, msg)
	if status == 0 then
		AutochessModel.instance:setActInfo(msg)
		GlobalDispatcher:dispatch(AutoChessAgent.ACInfoRes)
	end
end

function AutoChessAgent:sendPM_ACStartMatchReq(activityId)
	local req = AutoChessExtension_pb.PM_ACStartMatchReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AutoChessAgent:handlePM_ACStartMatchRes(status, msg)
	if status == 0 then
		AutochessController.instance:matchRes()
		GlobalDispatcher:dispatch(AutoChessAgent.ACStartMatchRes)
	end
end

function AutoChessAgent:sendPM_ACCancelMatchReq(activityId)
	local req = AutoChessExtension_pb.PM_ACCancelMatchReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AutoChessAgent:handlePM_ACCancelMatchRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(AutoChessAgent.ACCancelMatchRes)
	end
end

function AutoChessAgent:sendPM_ACLeaveGameReq(activityId)
	local req = AutoChessExtension_pb.PM_ACLeaveGameReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AutoChessAgent:handlePM_ACLeaveGameRes(status, msg)
	if status == 0 then
		UIStateManager.instance:clear(true)
		UIStateManager.instance:push(ViewName.AutochessmainView)
		GlobalDispatcher:dispatch(AutoChessAgent.ACLeaveGameRes)
	end
end

function AutoChessAgent:sendPM_ACSelectInitBuffReq(buffId)
	local req = AutoChessExtension_pb.PM_ACSelectInitBuffReq()

	req.buffId = buffId

	self:sendMsg(req)
end

function AutoChessAgent:handlePM_ACSelectInitBuffRes(status, msg)
	if status == 0 then
		AutochessController.instance:selectInitBuffFinish()
		GlobalDispatcher:dispatch(AutoChessAgent.ACSelectInitBuffRes)
	end
end

function AutoChessAgent:sendPM_ACBuyPetReq(index, raceId)
	local req = AutoChessExtension_pb.PM_ACBuyPetReq()

	req.index = index
	req.raceId = raceId

	self:sendMsg(req)
end

function AutoChessAgent:handlePM_ACBuyPetRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(AutoChessAgent.ACBuyPetRes)
	end
end

function AutoChessAgent:sendPM_ACRefreshShopReq()
	local req = AutoChessExtension_pb.PM_ACRefreshShopReq()

	self:sendMsg(req)
end

function AutoChessAgent:handlePM_ACRefreshShopRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(AutoChessAgent.ACRefreshShopRes)
	end
end

function AutoChessAgent:sendPM_ACLockShopReq(lock)
	local req = AutoChessExtension_pb.PM_ACLockShopReq()

	req.lock = lock

	self:sendMsg(req)
end

function AutoChessAgent:handlePM_ACLockShopRes(status, msg)
	if status == 0 then
		AutochessModel.instance:changeShopLocked()
		GlobalDispatcher:dispatch(AutoChessAgent.ACLockShopRes)
	end
end

function AutoChessAgent:sendPM_ACSellPetReq(raceId, star)
	local req = AutoChessExtension_pb.PM_ACSellPetReq()

	req.raceId = raceId
	req.star = star

	self:sendMsg(req)
end

function AutoChessAgent:handlePM_ACSellPetRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(AutoChessAgent.ACSellPetRes)
	end
end

function AutoChessAgent:sendPM_ACSetFormationReq(form)
	local req = AutoChessExtension_pb.PM_ACSetFormationReq()

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function AutoChessAgent:handlePM_ACSetFormationRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(AutoChessAgent.ACSetFormationRes)
	end
end

function AutoChessAgent:sendPM_ACSelectBuffReq(buffId)
	local req = AutoChessExtension_pb.PM_ACSelectBuffReq()

	req.buffId = buffId

	self:sendMsg(req)
end

function AutoChessAgent:handlePM_ACSelectBuffRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(AutoChessAgent.ACSelectBuffRes)
	end
end

function AutoChessAgent:sendPM_ACSelectFullStarBuffReq(buffId)
	local req = AutoChessExtension_pb.PM_ACSelectFullStarBuffReq()

	req.buffId = buffId

	self:sendMsg(req)
end

function AutoChessAgent:handlePM_ACSelectFullStarBuffRes(status, msg)
	if status == 0 then
		AutochessController.instance:onHandleSelectEquipBuff()
		GlobalDispatcher:dispatch(AutoChessAgent.ACSelectFullStarBuffRes)
	end
end

function AutoChessAgent:sendPM_ACGetBattleRecordReq(activityId)
	local req = AutoChessExtension_pb.PM_ACGetBattleRecordReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AutoChessAgent:handlePM_ACGetBattleRecordRes(status, msg)
	if status == 0 then
		local record = msg.record

		GlobalDispatcher:dispatch(AutoChessAgent.ACGetBattleRecordRes, record)
	end
end

function AutoChessAgent:sendPM_ACRankInfoReq(activityId)
	local req = AutoChessExtension_pb.PM_ACRankInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AutoChessAgent:handlePM_ACRankInfoRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(AutoChessAgent.ACRankInfoRes, msg)
	end
end

function AutoChessAgent:handlePM_ACNotifyMatchingOverTimeRes(status, msg)
	if status == 0 then
		AutochessController.instance:matchFailed()
		GlobalDispatcher:dispatch(AutoChessAgent.ACNotifyMatchingOverTimeRes)
	end
end

function AutoChessAgent:handlePM_ACNotifyMatchFailRes(status, msg)
	if status == 0 then
		AutochessController.instance:matchFailed()
		GlobalDispatcher:dispatch(AutoChessAgent.ACNotifyMatchFailRes)
	end
end

function AutoChessAgent:handlePM_ACNotifyGameStartRes(status, msg)
	if status == 0 then
		AutochessController.instance:notifyGameStartRes(msg)
		GlobalDispatcher:dispatch(AutoChessAgent.ACNotifyGameStartRes)
	end
end

function AutoChessAgent:handlePM_ACNotifyRefreshPetShopRes(status, msg)
	if status == 0 then
		AutochessModel.instance:refreshPetShop(msg)
		GlobalDispatcher:dispatch(AutoChessAgent.ACNotifyRefreshPetShopRes)
	end
end

function AutoChessAgent:handlePM_ACNotifyAfterPetChangedRes(status, msg)
	if status == 0 then
		AutochessController.instance:notifyAfterPetChangedRes(msg)
		GlobalDispatcher:dispatch(AutoChessAgent.ACNotifyAfterPetChangedRes)
	end
end

function AutoChessAgent:handlePM_ACNotifyInitBuffInfoChangedRes(status, msg)
	if status == 0 then
		AutochessController.instance:notifyInitBuffInfoChangedRes(msg)
		GlobalDispatcher:dispatch(AutoChessAgent.ACNotifyInitBuffInfoChangedRes)
	end
end

function AutoChessAgent:handlePM_ACNotifyNextRoundRes(status, msg)
	if status == 0 then
		AutochessController.instance:notifyNextRoundRes(msg)
		GlobalDispatcher:dispatch(AutoChessAgent.ACNotifyNextRoundRes)
	end
end

function AutoChessAgent:handlePM_ACNotifySelectFullStarBuffRes(status, msg)
	if status == 0 then
		AutochessModel.instance:setFullStarBuffIds(msg.buffIds)
		UIStateManager.instance:push(ViewName.AutochessselectfullstarbuffView)
		GlobalDispatcher:dispatch(AutoChessAgent.ACNotifySelectFullStarBuffRes)
	end
end

function AutoChessAgent:handlePM_ACNotifyGameEndRes(status, msg)
	if status == 0 then
		AutochessController.instance:notifyGameEndRes(msg)
		GlobalDispatcher:dispatch(AutoChessAgent.ACNotifyGameEndRes)
	end
end

function AutoChessAgent:handlePM_ACNotifyResultCodeRes(status, msg)
	if status == 0 then
		local resultcode = msg.resultCode

		FloatWordMgr.instance:show("错误码 ：", resultcode)

		local str = MsgFlowMgr.instance:getResultCodeStr(resultcode)

		FloatWordMgr.instance:show(str)
		GlobalDispatcher:dispatch(AutoChessAgent.ACNotifyResultCodeRes)
	end
end

function AutoChessAgent:handlePM_ACNotifySelectedBuffRes(status, msg)
	if status == 0 then
		local buffid = msg.buffId

		AutochessModel.instance:insertEquipBuffId(buffid)
		GlobalDispatcher:dispatch(AutoChessAgent.ACNotifySelectedBuffRes)
	end
end

AutoChessAgent.instance = AutoChessAgent.New()

return AutoChessAgent
