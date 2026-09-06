-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/abyssgoldrush/agent/AbyssGoldRushAgent.lua

module("logic.extensions.abyssgoldrush.agent.AbyssGoldRushAgent", package.seeall)

local AbyssGoldRushAgent = class("AbyssGoldRushAgent", BaseAgent)

function AbyssGoldRushAgent:sendPM_AbyssGoldRushGetInfoReq(activityId)
	local req = AbyssGoldRushExtension_pb.PM_AbyssGoldRushGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function AbyssGoldRushAgent:handlePM_AbyssGoldRushGetInfoRes(status, msg)
	if status == 0 then
		AbyssGoldRushController.instance:handlePM_AbyssGoldRushGetInfoRes(msg)
	end
end

function AbyssGoldRushAgent:sendPM_AbyssGoldRushPresetReq(activityId, presetId, holyStripePreset)
	local req = AbyssGoldRushExtension_pb.PM_AbyssGoldRushPresetReq()

	req.activityId = activityId
	req.presetId = presetId

	if holyStripePreset then
		for i, v in ipairs(holyStripePreset) do
			req.holyStripePreset:append(v)
		end
	end

	self:sendMsg(req)
end

function AbyssGoldRushAgent:handlePM_AbyssGoldRushPresetRes(status, msg)
	if status == 0 then
		AbyssGoldRushController.instance:handlePM_AbyssGoldRushPresetRes(msg)
	end
end

function AbyssGoldRushAgent:sendPM_AbyssGoldRushStartGameReq(activityId, holyStripeIds)
	local req = AbyssGoldRushExtension_pb.PM_AbyssGoldRushStartGameReq()

	req.activityId = activityId

	if holyStripeIds then
		for _, holyStripeId in ipairs(holyStripeIds) do
			req.holyStripeIds:append(holyStripeId)
		end
	end

	self:sendMsg(req)
end

function AbyssGoldRushAgent:handlePM_AbyssGoldRushStartGameRes(status, msg)
	if status == 0 then
		AbyssGoldRushController.instance:handlePM_AbyssGoldRushStartGameRes(msg)
	end
end

function AbyssGoldRushAgent:sendPM_AbyssGoldRushPushStepReq(activityId, targetStepId, extParam)
	local req = AbyssGoldRushExtension_pb.PM_AbyssGoldRushPushStepReq()

	req.activityId = activityId
	req.targetStepId = targetStepId

	if extParam then
		req.extParam = extParam
	end

	self:sendMsg(req)
end

function AbyssGoldRushAgent:handlePM_AbyssGoldRushPushStepRes(status, msg)
	if status == 0 then
		AbyssGoldRushController.instance:handlePM_AbyssGoldRushPushStepRes(msg)
	end
end

function AbyssGoldRushAgent:sendPM_AbyssGoldRushFightReq(activityId, form, useHolyStripeIds)
	local req = AbyssGoldRushExtension_pb.PM_AbyssGoldRushFightReq()

	req.activityId = activityId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	if useHolyStripeIds then
		for i, v in ipairs(useHolyStripeIds) do
			req.useHolyStripeIds:append(v)
		end
	end

	self:sendMsg(req)
end

function AbyssGoldRushAgent:handlePM_AbyssGoldRushFightRes(status, msg)
	AbyssGoldRushController.instance:handlePM_AbyssGoldRushFightRes(status, msg)
end

function AbyssGoldRushAgent:handlePM_AbyssGoldRushNotifyFightRes(status, msg)
	if status == 0 then
		AbyssGoldRushController.instance:handlePM_AbyssGoldRushNotifyFightRes(msg)
	end
end

function AbyssGoldRushAgent:sendPM_AbyssGoldRushFinishGameReq(activityId, gainPrize, selectHolyStripeIds)
	local req = AbyssGoldRushExtension_pb.PM_AbyssGoldRushFinishGameReq()

	req.activityId = activityId
	req.gainPrize = gainPrize

	if selectHolyStripeIds then
		for i, v in ipairs(selectHolyStripeIds) do
			req.selectHolyStripeIds:append(v)
		end
	end

	self:sendMsg(req)
end

function AbyssGoldRushAgent:handlePM_AbyssGoldRushFinishGameRes(status, msg)
	if status == 0 then
		AbyssGoldRushController.instance:handlePM_AbyssGoldRushFinishGameRes(msg)
	end
end

function AbyssGoldRushAgent:sendPM_AbyssGoldRushRankViewReq(activityId, rankType)
	local req = AbyssGoldRushExtension_pb.PM_AbyssGoldRushRankViewReq()

	req.activityId = activityId
	req.rankType = rankType

	self:sendMsg(req)
end

function AbyssGoldRushAgent:handlePM_AbyssGoldRushRankViewRes(status, msg)
	if status == 0 then
		AbyssGoldRushController.instance:handlePM_AbyssGoldRushRankViewRes(msg)
	end
end

function AbyssGoldRushAgent:sendPM_AbyssGoldRushUsePresetReq(activityId, useHolyStripePresetId)
	local req = AbyssGoldRushExtension_pb.PM_AbyssGoldRushUsePresetReq()

	req.activityId = activityId
	req.useHolyStripePresetId = useHolyStripePresetId

	self:sendMsg(req)
end

function AbyssGoldRushAgent:handlePM_AbyssGoldRushUsePresetRes(status, msg)
	if status == 0 then
		AbyssGoldRushController.instance:handlePM_AbyssGoldRushUsePresetRes(msg)
	end
end

AbyssGoldRushAgent.instance = AbyssGoldRushAgent.New()

return AbyssGoldRushAgent
