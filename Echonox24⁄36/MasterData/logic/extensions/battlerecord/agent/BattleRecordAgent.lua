-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlerecord/agent/BattleRecordAgent.lua

module("logic.extensions.battlerecord.agent.BattleRecordAgent", package.seeall)

local BattleRecordAgent = class("BattleRecordAgent", BaseAgent)

function BattleRecordAgent:sendGetBattleRecordListRequest(userId)
	local req = BattleRecordExtension_pb.GetBattleRecordListRequest()

	req.userId = userId

	self:sendMsg(req)
end

function BattleRecordAgent:handleGetBattleRecordListReply(status, msg)
	if status == 0 then
		BattleRecordModel.instance:fillRecordMOList(msg.record)
	end
end

function BattleRecordAgent:sendGetBattleRecordRequest(userId, recordId)
	local req = BattleRecordExtension_pb.GetBattleRecordRequest()

	req.userId = userId
	req.recordId = recordId

	self:sendMsg(req)
end

function BattleRecordAgent:handleGetBattleRecordReply(status, msg)
	if status == 0 then
		BattleRecordUtil.enterBattle(msg)
	else
		printError("enter battle record failed!")
	end
end

BattleRecordAgent.instance = BattleRecordAgent.New()

return BattleRecordAgent
