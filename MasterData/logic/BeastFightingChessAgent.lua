-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doushouqi/agent/BeastFightingChessAgent.lua

module("logic.extensions.beastfightingchess.agent.BeastFightingChessAgent", package.seeall)

local BeastFightingChessAgent = class("BeastFightingChessAgent", BaseAgent)

function BeastFightingChessAgent:sendBeastFightingChessInfoReq(activityId)
	local req = BeastFightingChessExtension_pb.BeastFightingChessInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BeastFightingChessAgent:handleBeastFightingChessInfoRes(status, msg)
	if status == 0 then
		DoushouqiModel.instance:setBaseInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.BeastFightingChessInfoRes)
	end
end

function BeastFightingChessAgent:sendBeastFightingChessGainPrizeReq(activityId, typeId, prizeId)
	local req = BeastFightingChessExtension_pb.BeastFightingChessGainPrizeReq()

	req.activityId = activityId
	req.typeId = typeId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function BeastFightingChessAgent:handleBeastFightingChessGainPrizeRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId
		local typeId = msg.typeId
		local prizeId = msg.prizeId

		DoushouqiModel.instance:onGainPrize(activityId, typeId, prizeId)
		GlobalDispatcher:dispatch(GlobalNotify.BeastFightingChessGainPrizeRes)
	end
end

function BeastFightingChessAgent:sendBeastFightingChessFinishNewHandReq(activityId, typeId)
	local req = BeastFightingChessExtension_pb.BeastFightingChessFinishNewHandReq()

	req.activityId = activityId
	req.typeId = typeId

	self:sendMsg(req)
end

function BeastFightingChessAgent:handleBeastFightingChessFinishNewHandRes(status, msg)
	if status == 0 then
		local typeId = msg.typeId

		DoushouqiModel.instance:onFinishNewHand(typeId)
		GlobalDispatcher:dispatch(GlobalNotify.BeastFightingChessFinishNewHandRes)
	end
end

function BeastFightingChessAgent:sendBeastFightingChessRecordReq(activityId)
	local req = BeastFightingChessExtension_pb.BeastFightingChessRecordReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BeastFightingChessAgent:handleBeastFightingChessRecordRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.BeastFightingChessRecordRes, msg.record)
	end
end

function BeastFightingChessAgent:sendBeastFightingChessRankReq(activityId, typeId)
	local req = BeastFightingChessExtension_pb.BeastFightingChessRankReq()

	req.activityId = activityId
	req.typeId = typeId

	self:sendMsg(req)
end

function BeastFightingChessAgent:handleBeastFightingChessRankRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.BeastFightingChessRankRes, msg)
	end
end

function BeastFightingChessAgent:sendBeastFightingChessSelectSkillReq(activityId, skillId)
	local req = BeastFightingChessExtension_pb.BeastFightingChessSelectSkillReq()

	req.activityId = activityId
	req.skillId = skillId

	self:sendMsg(req)
end

function BeastFightingChessAgent:handleBeastFightingChessSelectSkillRes(status, msg)
	if status == 0 then
		local skillId = msg.skillId

		DoushouqiModel.instance:setMySkillId(skillId)
		FloatWordMgr.instance:show("选择技能成功")
		GlobalDispatcher:dispatch(GlobalNotify.BeastFightingChessSelectSkillRes)
	end
end

function BeastFightingChessAgent:sendBeastFightingChessMatchReq(activityId, typeId)
	local req = BeastFightingChessExtension_pb.BeastFightingChessMatchReq()

	req.activityId = activityId
	req.typeId = typeId

	self:sendMsg(req)
end

function BeastFightingChessAgent:handleBeastFightingChessMatchRes(status, msg)
	if status == 0 then
		-- block empty
	end

	GlobalDispatcher:dispatch(GlobalNotify.BeastFightingChessMatchRes, status)
end

function BeastFightingChessAgent:sendBeastFightingChessCancelMatchReq(activityId)
	local req = BeastFightingChessExtension_pb.BeastFightingChessCancelMatchReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BeastFightingChessAgent:handleBeastFightingChessCancelMatchRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show("取消匹配")
		GlobalDispatcher:dispatch(GlobalNotify.BeastFightingChessCancelMatchRes)
	end
end

function BeastFightingChessAgent:sendBeastFightingChessMatchRobotReq(activityId)
	local req = BeastFightingChessExtension_pb.BeastFightingChessMatchRobotReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BeastFightingChessAgent:handleBeastFightingChessMatchRobotRes(status, msg)
	if status == 0 then
		-- block empty
	end

	GlobalDispatcher:dispatch(GlobalNotify.BeastFightingChessMatchRobotRes, status)
end

function BeastFightingChessAgent:sendBeastFightingChessLeaveRoomReq(activityId)
	local req = BeastFightingChessExtension_pb.BeastFightingChessLeaveRoomReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BeastFightingChessAgent:handleBeastFightingChessLeaveRoomRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.BeastFightingChessLeaveRoomRes)
	end
end

function BeastFightingChessAgent:sendBeastFightingChessReleaseSkillReq(activityId, skillId, targetPointId, param, actionId)
	local req = BeastFightingChessExtension_pb.BeastFightingChessReleaseSkillReq()

	req.activityId = activityId
	req.skillId = skillId
	req.targetPointId = targetPointId
	req.param = param
	req.actionId = actionId

	self:sendMsg(req)
end

function BeastFightingChessAgent:handleBeastFightingChessReleaseSkillRes(status, msg)
	if status == 0 then
		DoushouqiController.instance:onChessReleaseSkillRes()
		GlobalDispatcher:dispatch(GlobalNotify.BeastFightingChessReleaseSkillRes)
	end
end

function BeastFightingChessAgent:sendBeastFightingChessOpenChessReq(activityId, targetPointId, actionId)
	local req = BeastFightingChessExtension_pb.BeastFightingChessOpenChessReq()

	req.activityId = activityId
	req.targetPointId = targetPointId
	req.actionId = actionId

	self:sendMsg(req)
end

function BeastFightingChessAgent:handleBeastFightingChessOpenChessRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.BeastFightingChessOpenChessRes)
	end
end

function BeastFightingChessAgent:sendBeastFightingChessMoveReq(activityId, originPointId, targetPointId, actionId)
	local req = BeastFightingChessExtension_pb.BeastFightingChessMoveReq()

	req.activityId = activityId
	req.originPointId = originPointId
	req.targetPointId = targetPointId
	req.actionId = actionId

	self:sendMsg(req)
end

function BeastFightingChessAgent:handleBeastFightingChessMoveRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.BeastFightingChessMoveRes)
	end
end

function BeastFightingChessAgent:sendBeastFightingChessRequestTieReq(activityId)
	local req = BeastFightingChessExtension_pb.BeastFightingChessRequestTieReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function BeastFightingChessAgent:handleBeastFightingChessRequestTieRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.BeastFightingChessRequestTieRes)
	end
end

function BeastFightingChessAgent:sendBeastFightingChessHandleTieReq(activityId, agree)
	local req = BeastFightingChessExtension_pb.BeastFightingChessHandleTieReq()

	req.activityId = activityId
	req.agree = agree

	self:sendMsg(req)
end

function BeastFightingChessAgent:handleBeastFightingChessHandleTieRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.BeastFightingChessHandleTieRes)
	end
end

function BeastFightingChessAgent:sendBeastFightingChessSendEmoticonReq(activityId, id)
	local req = BeastFightingChessExtension_pb.BeastFightingChessSendEmoticonReq()

	req.activityId = activityId
	req.id = id

	self:sendMsg(req)
end

function BeastFightingChessAgent:handleBeastFightingChessSendEmoticonRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.BeastFightingChessSendEmoticonRes)
	end
end

function BeastFightingChessAgent:handleNotifyBeastFightingChessMatchOverTimeRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show("匹配超时")
		GlobalDispatcher:dispatch(GlobalNotify.NotifyBeastFightingChessMatchOverTimeRes)
	end
end

function BeastFightingChessAgent:handleNotifyBeastFightingChessMatchFailRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show("匹配失败")
		UIStateManager.instance:popByName(ViewName.DoushouqimatchView)
		GlobalDispatcher:dispatch(GlobalNotify.NotifyBeastFightingChessMatchFailRes)
	end
end

function BeastFightingChessAgent:handleNotifyBeastFightingChessMatchRobotFailRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show("匹配机器人失败")
		UIStateManager.instance:popByName(ViewName.DoushouqimatchView)
		GlobalDispatcher:dispatch(GlobalNotify.NotifyBeastFightingChessMatchRobotFailRes)
	end
end

function BeastFightingChessAgent:handleNotifyBeastFightingChessStartGameRes(status, msg)
	if status == 0 then
		DoushouqiController.instance:onNotifyBeastFightingChessStartGameRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.NotifyBeastFightingChessStartGameRes)
	end
end

function BeastFightingChessAgent:handleNotifyBeastFightingChessActionRes(status, msg)
	if status == 0 then
		DoushouqiController.instance:onNotifyBeastFightingChessActionRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.NotifyBeastFightingChessActionRes)
	end
end

function BeastFightingChessAgent:handleNotifyBeastFightingChessOpRequestTieRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.NotifyBeastFightingChessOpRequestTieRes)
	end
end

function BeastFightingChessAgent:handleNotifyBeastFightingChessOpHandleTieRes(status, msg)
	if status == 0 then
		local agree = msg.agree
		local str = agree and "同意" or "不同意"
		local text = string.format("对方%s和局", str)

		FloatWordMgr.instance:show(text)
		GlobalDispatcher:dispatch(GlobalNotify.NotifyBeastFightingChessOpHandleTieRes)
	end
end

function BeastFightingChessAgent:handleNotifyBeastFightingChessOpEmoticonRes(status, msg)
	if status == 0 then
		local id = msg.id

		GlobalDispatcher:dispatch(GlobalNotify.NotifyBeastFightingChessOpEmoticonRes, id)
	end
end

function BeastFightingChessAgent:handleNotifyBeastFightingChessGameEndRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId
		local typeId = msg.typeId

		if msg.state == 1 or msg.state == 0 then
			self:sendBeastFightingChessInfoReq(activityId)

			if typeId == DoushouqiController.ChessType.Doushouqi then
				DoushouqiGameController.instance:onNotifyBeastFightingChessGameEndRes(msg)
			elseif typeId == DoushouqiController.ChessType.Weihuqi then
				DoushouqiTigerGameController.instance:onNotifyBeastFightingChessGameEndRes(msg)
			end
		else
			if msg.state == 2 then
				FloatWordMgr.instance:show("我方主动退出对局")
			elseif msg.state == 3 then
				FloatWordMgr.instance:show("对方退出对局")
			elseif msg.state < 0 then
				FloatWordMgr.instance:show("对局失败")
			end

			UIStateManager.instance:popByName(ViewName.DoushouqigameView)
			UIStateManager.instance:popByName(ViewName.DoushouqitigergameView)
			UIStateManager.instance:popByName(ViewName.Popupwindow)
		end

		GlobalDispatcher:dispatch(GlobalNotify.NotifyBeastFightingChessGameEndRes)
	end
end

function BeastFightingChessAgent:handleNotifyBeastFightingChessErrorRes(status, msg)
	if status == 0 then
		local resultCode = msg.resultCode
		local str = MsgFlowMgr.instance:getResultCodeStr(resultCode)

		FloatWordMgr.instance:show(str)
		GlobalDispatcher:dispatch(GlobalNotify.NotifyBeastFightingChessErrorRes)
	end
end

BeastFightingChessAgent.instance = BeastFightingChessAgent.New()

return BeastFightingChessAgent
