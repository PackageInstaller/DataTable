-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardpreheat2023/agent/AnnualFeePreheat2023Agent.lua

module("logic.extensions.yearcardpreheat2023.agent.AnnualFeePreheat2023Agent", package.seeall)

local AnnualFeePreheat2023Agent = class("AnnualFeePreheat2023Agent", BaseAgent)

function AnnualFeePreheat2023Agent:sendPM_AFP2023GetInfoReq(actId)
	local req = AnnualFeePreheat2023Extension_pb.PM_AFP2023GetInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function AnnualFeePreheat2023Agent:handlePM_AFP2023GetInfoRes(status, msg)
	if status == 0 then
		YearCardPreheat2023Controller.instance:handleGetInfo(msg)
	end
end

function AnnualFeePreheat2023Agent:sendPM_AFP2023MoveReq(actId, x, y)
	local req = AnnualFeePreheat2023Extension_pb.PM_AFP2023MoveReq()

	req.actId = actId
	req.x = x
	req.y = y

	self:sendMsg(req)
end

function AnnualFeePreheat2023Agent:handlePM_AFP2023MoveRes(status, msg)
	if status == 0 then
		YearCardPreheat2023Controller.instance:handleMove(msg)
	end
end

function AnnualFeePreheat2023Agent:sendPM_AFP2023DoEventReq(actId, x, y)
	local req = AnnualFeePreheat2023Extension_pb.PM_AFP2023DoEventReq()

	req.actId = actId
	req.x = x
	req.y = y

	self:sendMsg(req)
end

function AnnualFeePreheat2023Agent:handlePM_AFP2023DoEventRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function AnnualFeePreheat2023Agent:sendPM_AFP2023CollateClueReq(actId)
	local req = AnnualFeePreheat2023Extension_pb.PM_AFP2023CollateClueReq()

	req.actId = actId

	self:sendMsg(req)
end

function AnnualFeePreheat2023Agent:handlePM_AFP2023CollateClueRes(status, msg)
	if status == 0 then
		YearCardPreheat2023Controller.instance:handleCollateClue(msg)
	end
end

function AnnualFeePreheat2023Agent:sendPM_AFP2023GainPersonPrizeReq(actId, id)
	local req = AnnualFeePreheat2023Extension_pb.PM_AFP2023GainPersonPrizeReq()

	req.actId = actId
	req.id = id

	self:sendMsg(req)
end

function AnnualFeePreheat2023Agent:handlePM_AFP2023GainPersonPrizeRes(status, msg)
	if status == 0 then
		YearCardPreheat2023Controller.instance:handleGainPersonPrize(msg)
	end
end

function AnnualFeePreheat2023Agent:sendPM_AFP2023GainProgressPrizeReq(actId, id)
	local req = AnnualFeePreheat2023Extension_pb.PM_AFP2023GainProgressPrizeReq()

	req.actId = actId
	req.id = id

	self:sendMsg(req)
end

function AnnualFeePreheat2023Agent:handlePM_AFP2023GainProgressPrizeRes(status, msg)
	if status == 0 then
		YearCardPreheat2023Controller.instance:handleGainProgressPrize(msg)
	end
end

function AnnualFeePreheat2023Agent:handlePM_AFP2023NotifyEventFinishRes(status, msg)
	if status == 0 then
		YearCardPreheat2023Controller.instance:handleEventFinish(msg)
	end
end

AnnualFeePreheat2023Agent.instance = AnnualFeePreheat2023Agent.New()

return AnnualFeePreheat2023Agent
