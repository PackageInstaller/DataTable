-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seniorarena/agent/Arena3v3Agent.lua

module("logic.extensions.arena3v3.agent.Arena3v3Agent", package.seeall)

local Arena3v3Agent = class("Arena3v3Agent", BaseAgent)

Arena3v3Agent.Arena3v3InfoRes = "Arena3v3Agent_Arena3v3InfoRes"
Arena3v3Agent.Arena3v3CurZoneInRes = "Arena3v3Agent_Arena3v3CurZoneInRes"
Arena3v3Agent.Arena3v3RefreshTargetsRes = "Arena3v3Agent_Arena3v3RefreshTargetsRes"
Arena3v3Agent.Arena3v3ChallengeRes = "Arena3v3Agent_Arena3v3ChallengeRes"
Arena3v3Agent.Arena3v3TopDetailRes = "Arena3v3Agent_Arena3v3TopDetailRes"
Arena3v3Agent.Arena3v3AchievePrizeInfoRes = "Arena3v3Agent_Arena3v3AchievePrizeInfoRes"
Arena3v3Agent.Arena3v3GainAchievePrizeRes = "Arena3v3Agent_Arena3v3GainAchievePrizeRes"
Arena3v3Agent.Arena3v3FormationRes = "Arena3v3Agent_Arena3v3FormationRes"
Arena3v3Agent.Arena3v3SetMyDefenseFormationRes = "Arena3v3Agent_Arena3v3SetMyDefenseFormationRes"
Arena3v3Agent.MyArena3v3ChallengeRecordsRes = "Arena3v3Agent_MyArena3v3ChallengeRecordsRes"
Arena3v3Agent.Arena3v3VideoRes = "Arena3v3Agent_Arena3v3VideoRes"
Arena3v3Agent.Arena3v3BuyChallengeItemRes = "Arena3v3Agent_Arena3v3BuyChallengeItemRes"
Arena3v3Agent.Arena3v3SetMyAttackFormationRes = "Arena3v3Agent_Arena3v3SetMyAttackFormationRes"
Arena3v3Agent.Arena3v3GainHangUpPrizeRes = "Arena3v3Agent_Arena3v3GainHangUpPrizeRes"

function Arena3v3Agent:ctor()
	return
end

function Arena3v3Agent:setExtId(extId)
	Arena3v3Agent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function Arena3v3Agent:sendArena3v3InfoReq(handler, handlerObj, errHandler)
	local req = Arena3v3Extension_pb.Arena3v3InfoReq()

	self:sendMsg(req)
	self:addEventOnce(Arena3v3Agent.Arena3v3InfoRes, handler, handlerObj, errHandler)
end

function Arena3v3Agent:handleArena3v3InfoRes(status, msg)
	self:dispatch(Arena3v3Agent.Arena3v3InfoRes, status, msg)
end

function Arena3v3Agent:sendArena3v3CurZoneInReq(handler, handlerObj, errHandler)
	local req = Arena3v3Extension_pb.Arena3v3CurZoneInReq()

	self:sendMsg(req)
	self:addEventOnce(Arena3v3Agent.Arena3v3CurZoneInRes, handler, handlerObj, errHandler)
end

function Arena3v3Agent:handleArena3v3CurZoneInRes(status, msg)
	self:dispatch(Arena3v3Agent.Arena3v3CurZoneInRes, status, msg)
end

function Arena3v3Agent:sendArena3v3RefreshTargetsReq(seasonId, handler, handlerObj, errHandler)
	local req = Arena3v3Extension_pb.Arena3v3RefreshTargetsReq()

	req.seasonId = seasonId

	self:sendMsg(req)
	self:addEventOnce(Arena3v3Agent.Arena3v3RefreshTargetsRes, handler, handlerObj, errHandler)
end

function Arena3v3Agent:handleArena3v3RefreshTargetsRes(status, msg)
	self:dispatch(Arena3v3Agent.Arena3v3RefreshTargetsRes, status, msg)
end

function Arena3v3Agent:sendArena3v3ChallengeReq(seasonId, targetUserId, handler, handlerObj, errHandler)
	local req = Arena3v3Extension_pb.Arena3v3ChallengeReq()

	req.seasonId = seasonId
	req.targetUserId = targetUserId

	self:sendMsg(req)
	self:addEventOnce(Arena3v3Agent.Arena3v3ChallengeRes, handler, handlerObj, errHandler)
end

function Arena3v3Agent:handleArena3v3ChallengeRes(status, msg)
	if status ~= 0 then
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end

	self:dispatch(Arena3v3Agent.Arena3v3ChallengeRes, status, msg)
end

function Arena3v3Agent:sendArena3v3TopDetailReq(handler, handlerObj, errHandler)
	local req = Arena3v3Extension_pb.Arena3v3TopDetailReq()

	self:sendMsg(req)
	self:addEventOnce(Arena3v3Agent.Arena3v3TopDetailRes, handler, handlerObj, errHandler)
end

function Arena3v3Agent:handleArena3v3TopDetailRes(status, msg)
	self:dispatch(Arena3v3Agent.Arena3v3TopDetailRes, status, msg)
end

function Arena3v3Agent:sendArena3v3AchievePrizeInfoReq(handler, handlerObj, errHandler)
	local req = Arena3v3Extension_pb.Arena3v3AchievePrizeInfoReq()

	self:sendMsg(req)
	self:addEventOnce(Arena3v3Agent.Arena3v3AchievePrizeInfoRes, handler, handlerObj, errHandler)
end

function Arena3v3Agent:handleArena3v3AchievePrizeInfoRes(status, msg)
	self:dispatch(Arena3v3Agent.Arena3v3AchievePrizeInfoRes, status, msg)
end

function Arena3v3Agent:sendArena3v3GainAchievePrizeReq(handler, handlerObj, errHandler)
	local req = Arena3v3Extension_pb.Arena3v3GainAchievePrizeReq()

	self:sendMsg(req)
	self:addEventOnce(Arena3v3Agent.Arena3v3GainAchievePrizeRes, handler, handlerObj, errHandler)
end

function Arena3v3Agent:handleArena3v3GainAchievePrizeRes(status, msg)
	self:dispatch(Arena3v3Agent.Arena3v3GainAchievePrizeRes, status, msg)
end

function Arena3v3Agent:sendArena3v3MyDefenseFormationReq(handler, handlerObj, errHandler)
	local req = Arena3v3Extension_pb.Arena3v3MyDefenseFormationReq()

	self:sendMsg(req)
	self:addEventOnce(Arena3v3Agent.Arena3v3FormationRes, handler, handlerObj, errHandler)
end

function Arena3v3Agent:handleArena3v3FormationRes(status, msg)
	self:dispatch(Arena3v3Agent.Arena3v3FormationRes, status, msg)
end

function Arena3v3Agent:sendArena3v3OtherFormationReq(targetUserId, handler, handlerObj, errHandler)
	local req = Arena3v3Extension_pb.Arena3v3OtherFormationReq()

	req.targetUserId = targetUserId

	self:sendMsg(req)
	self:addEventOnce(Arena3v3Agent.Arena3v3FormationRes, handler, handlerObj, errHandler)
end

function Arena3v3Agent:sendArena3v3SetMyDefenseFormationReq(forms_pb_Ary, handler, handlerObj, errHandler)
	local req = Arena3v3Extension_pb.Arena3v3SetMyDefenseFormationReq()

	if forms_pb_Ary ~= nil then
		for i, v1 in ipairs(forms_pb_Ary) do
			local forms = req.forms:add()

			forms:ParseFromString(v1:SerializeToString())
		end
	end

	self:sendMsg(req)
	self:addEventOnce(Arena3v3Agent.Arena3v3SetMyDefenseFormationRes, handler, handlerObj, errHandler)
end

function Arena3v3Agent:handleArena3v3SetMyDefenseFormationRes(status, msg)
	self:dispatch(Arena3v3Agent.Arena3v3SetMyDefenseFormationRes, status, msg)
end

function Arena3v3Agent:sendMyArena3v3ChallengeRecordsReq(handler, handlerObj, errHandler)
	local req = Arena3v3Extension_pb.MyArena3v3ChallengeRecordsReq()

	self:sendMsg(req)
	self:addEventOnce(Arena3v3Agent.MyArena3v3ChallengeRecordsRes, handler, handlerObj, errHandler)
end

function Arena3v3Agent:handleMyArena3v3ChallengeRecordsRes(status, msg)
	self:dispatch(Arena3v3Agent.MyArena3v3ChallengeRecordsRes, status, msg)
end

function Arena3v3Agent:sendArena3v3VideoReq(battleId, handler, handlerObj, errHandler)
	local req = Arena3v3Extension_pb.Arena3v3VideoReq()

	req.battleId = battleId

	self:sendMsg(req)
	self:addEventOnce(Arena3v3Agent.Arena3v3VideoRes, handler, handlerObj, errHandler)
end

function Arena3v3Agent:handleArena3v3VideoRes(status, msg)
	self:dispatch(Arena3v3Agent.Arena3v3VideoRes, status, msg)
end

function Arena3v3Agent:sendArena3v3BuyChallengeItemReq(wantBuyTimes, handler, handlerObj, errHandler)
	local req = Arena3v3Extension_pb.Arena3v3BuyChallengeItemReq()

	req.wantBuyTimes = wantBuyTimes

	self:sendMsg(req)
	self:addEventOnce(Arena3v3Agent.Arena3v3BuyChallengeItemRes, handler, handlerObj, errHandler)
end

function Arena3v3Agent:handleArena3v3BuyChallengeItemRes(status, msg)
	self:dispatch(Arena3v3Agent.Arena3v3BuyChallengeItemRes, status, msg)
end

function Arena3v3Agent:sendArena3v3MyAttackFormationReq(handler, handlerObj, errHandler)
	local req = Arena3v3Extension_pb.Arena3v3MyAttackFormationReq()

	self:sendMsg(req)
	self:addEventOnce(Arena3v3Agent.Arena3v3FormationRes, handler, handlerObj, errHandler)
end

function Arena3v3Agent:sendArena3v3SetMyAttackFormationReq(forms_pb_Ary, handler, handlerObj, errHandler)
	local req = Arena3v3Extension_pb.Arena3v3SetMyAttackFormationReq()

	if forms_pb_Ary ~= nil then
		for i, v2 in ipairs(forms_pb_Ary) do
			local forms = req.forms:add()

			forms:ParseFromString(v2:SerializeToString())
		end
	end

	self:sendMsg(req)
	self:addEventOnce(Arena3v3Agent.Arena3v3SetMyAttackFormationRes, handler, handlerObj, errHandler)
end

function Arena3v3Agent:handleArena3v3SetMyAttackFormationRes(status, msg)
	self:dispatch(Arena3v3Agent.Arena3v3SetMyAttackFormationRes, status, msg)
end

function Arena3v3Agent:sendArena3v3GainHangUpPrizeReq(handler, handlerObj, errHandler)
	local req = Arena3v3Extension_pb.Arena3v3GainHangUpPrizeReq()

	self:sendMsg(req)
	self:addEventOnce(Arena3v3Agent.Arena3v3GainHangUpPrizeRes, handler, handlerObj, errHandler)
end

function Arena3v3Agent:handleArena3v3GainHangUpPrizeRes(status, msg)
	self:dispatch(Arena3v3Agent.Arena3v3GainHangUpPrizeRes, status, msg)
end

Arena3v3Agent.instance = Arena3v3Agent.New()

return Arena3v3Agent
