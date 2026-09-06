-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/agent/CampScuffleAgent.lua

module("logic.extensions.funcamp.agent.CampScuffleAgent", package.seeall)

local CampScuffleAgent = class("CampScuffleAgent", BaseAgent)

function CampScuffleAgent:sendCS_ScuffleInfoReq()
	local req = CampScuffleExtension_pb.CS_ScuffleInfoReq()

	self:sendMsg(req)
end

function CampScuffleAgent:handleCS_ScuffleInfoRes(status, msg)
	if status == 0 then
		-- block empty
	end

	CampScuffleController.instance:onInfoRes(status, msg)
end

function CampScuffleAgent:sendCS_StartMatchingReq()
	local req = CampScuffleExtension_pb.CS_StartMatchingReq()

	self:sendMsg(req)
end

function CampScuffleAgent:handleCS_StartMatchingRes(status, msg)
	if status == 0 then
		-- block empty
	end

	CampScuffleController.instance:onStartMatchingRes(status, msg)
end

function CampScuffleAgent:sendCS_CancelMatchingReq()
	local req = CampScuffleExtension_pb.CS_CancelMatchingReq()

	self:sendMsg(req)
end

function CampScuffleAgent:handleCS_CancelMatchingRes(status, msg)
	if status == 0 then
		-- block empty
	end

	CampScuffleController.instance:onCancelMatchingRes(status, msg)
end

function CampScuffleAgent:sendCS_LeaveGameReq()
	local req = CampScuffleExtension_pb.CS_LeaveGameReq()

	self:sendMsg(req)
end

function CampScuffleAgent:handleCS_LeaveGameRes(status, msg)
	if status == 0 then
		-- block empty
	end

	CampScuffleController.instance:onLeaveGameRes(status, msg)
end

function CampScuffleAgent:sendCS_BanPetReq(banPetIds)
	local req = CampScuffleExtension_pb.CS_BanPetReq()

	for i, v1 in ipairs(banPetIds) do
		req.banPetIds:append(v1)
	end

	self:sendMsg(req)
end

function CampScuffleAgent:handleCS_BanPetRes(status, msg)
	if status == 0 then
		-- block empty
	end

	CampScuffleController.instance:onBanPetRes(status, msg)
end

function CampScuffleAgent:sendCS_SetFormReq(form)
	local req = CampScuffleExtension_pb.CS_SetFormReq()

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function CampScuffleAgent:handleCS_SetFormRes(status, msg)
	if status == 0 then
		-- block empty
	end

	CampScuffleController.instance:onSetFormRes(status, msg)
end

function CampScuffleAgent:sendCS_AchievePrizeInfoReq()
	local req = CampScuffleExtension_pb.CS_AchievePrizeInfoReq()

	self:sendMsg(req)
end

function CampScuffleAgent:handleCS_AchievePrizeInfoRes(status, msg)
	CampScuffleController.instance:onAchievePrizeInfoRes(status, msg)
end

function CampScuffleAgent:sendCS_GainAchievePrizeReq(id)
	local req = CampScuffleExtension_pb.CS_GainAchievePrizeReq()

	req.id = id

	self:sendMsg(req)
end

function CampScuffleAgent:handleCS_GainAchievePrizeRes(status, msg)
	CampScuffleController.instance:onGainAchievePrizeRes(status, msg)
end

function CampScuffleAgent:sendCS_BuyTimesReq()
	local req = CampScuffleExtension_pb.CS_BuyTimesReq()

	self:sendMsg(req)
end

function CampScuffleAgent:handleCS_BuyTimesRes(status, msg)
	CampScuffleController.instance:onBuyTimesRes(status, msg)
end

function CampScuffleAgent:sendCS_GetBattleRecordReq()
	local req = CampScuffleExtension_pb.CS_GetBattleRecordReq()

	self:sendMsg(req)
end

function CampScuffleAgent:handleCS_GetBattleRecordRes(status, msg)
	CampScuffleController.instance:onGetBattleRecordRes(status, msg)
end

function CampScuffleAgent:sendCS_GetBattleVideoReq(battleId)
	local req = CampScuffleExtension_pb.CS_GetBattleVideoReq()

	req.battleId = battleId

	self:sendMsg(req)
end

function CampScuffleAgent:handleCS_GetBattleVideoRes(status, msg)
	CampScuffleController.instance:onGetBattleVideoRes(status, msg)
end

function CampScuffleAgent:sendCS_GetRankInfoReq()
	local req = CampScuffleExtension_pb.CS_GetRankInfoReq()

	self:sendMsg(req)
end

function CampScuffleAgent:handleCS_GetRankInfoRes(status, msg)
	CampScuffleController.instance:onGetRankInfoRes(status, msg)
end

function CampScuffleAgent:handleCS_NotifyMatchingOverTimeRes(status, msg)
	CampScuffleController.instance:onNotifyMatchingOverTimeRes(status, msg)
end

function CampScuffleAgent:handleCS_NotifyMatchFailRes(status, msg)
	CampScuffleController.instance:onNotifyMatchFailRes(status, msg)
end

function CampScuffleAgent:handleCS_NotifyGameStartRes(status, msg)
	CampScuffleController.instance:onNotifyGameStartRes(status, msg)
end

function CampScuffleAgent:handleCS_NotifyOpBanFinishRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function CampScuffleAgent:handleCS_NotfiyStartSetFormRes(status, msg)
	CampScuffleController.instance:onNotfiyStartSetFormRes(status, msg)
end

function CampScuffleAgent:handleCS_NotifiyOpReadyFightRes(status, msg)
	CampScuffleController.instance:onNotifiyOpReadyFightRes(status, msg)
end

function CampScuffleAgent:handleCS_NotifyGameEndRes(status, msg)
	CampScuffleController.instance:onNotifyGameEndRes(status, msg)
end

CampScuffleAgent.instance = CampScuffleAgent.New()

return CampScuffleAgent
