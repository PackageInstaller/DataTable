-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pigraise/agent/AnimalsAgent.lua

module("logic.extensions.animals.agent.AnimalsAgent", package.seeall)

local AnimalsAgent = class("AnimalsAgent", BaseAgent)

AnimalsAgent.PM_AnimalsGetStateRes = "AnimalsAgent_PM_AnimalsGetStateRes"
AnimalsAgent.PM_AnimalsProcessFeedBackRes = "AnimalsAgent_PM_AnimalsProcessFeedBackRes"
AnimalsAgent.PM_AnimalsTouchRes = "AnimalsAgent_PM_AnimalsTouchRes"
AnimalsAgent.PM_AnimalsFeedRes = "AnimalsAgent_PM_AnimalsFeedRes"
AnimalsAgent.PM_AnimalsFollowRes = "AnimalsAgent_PM_AnimalsFollowRes"
AnimalsAgent.PM_AnimalsGainIntimacyPrizeRes = "AnimalsAgent_PM_AnimalsGainIntimacyPrizeRes"
AnimalsAgent.PM_AnimalsGetFeedbackEventRes = "AnimalsAgent_PM_AnimalsGetFeedbackEventRes"
AnimalsAgent.PM_AnimalsGinPigRes = "AnimalsAgent_PM_AnimalsGinPigRes"
AnimalsAgent.PM_AnimalsPigAdventureInfoRes = "AnimalsAgent_PM_AnimalsPigAdventureInfoRes"
AnimalsAgent.PM_AnimalsPigAdventurePrizeRes = "AnimalsAgent_PM_AnimalsPigAdventurePrizeRes"
AnimalsAgent.PM_AnimalsGainPetRewardRes = "AnimalsAgent_PM_AnimalsGainPetRewardRes"
AnimalsAgent.PM_AnimalsRenameRes = "AnimalsAgent_PM_AnimalsRenameRes"
AnimalsAgent.PM_AnimalsActivateRes = "AnimalsAgent_PM_AnimalsActivateRes"
AnimalsAgent.PM_AnimalsTakeRes = "AnimalsAgent_PM_AnimalsTakeRes"

function AnimalsAgent:ctor()
	return
end

function AnimalsAgent:setExtId(extId)
	AnimalsAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function AnimalsAgent:sendPM_AnimalsGetStateReq(handler, handlerObj, errHandler)
	forcePrint("==========LoginController._enterGame=======AnimalsAgent:sendPM_AnimalsGetStateReq")

	local req = AnimalsExtension_pb.PM_AnimalsGetStateReq()

	self:sendMsg(req)
	self:addEventOnce(AnimalsAgent.PM_AnimalsGetStateRes, handler, handlerObj, errHandler)
end

function AnimalsAgent:handlePM_AnimalsGetStateRes(status, msg)
	forcePrint("==========LoginController._enterGame=======AnimalsAgent:sendPM_AnimalsGetStateReq====back")
	self:dispatch(AnimalsAgent.PM_AnimalsGetStateRes, status, msg)
end

function AnimalsAgent:sendPM_AnimalsProcessFeedBackReq(id, handler, handlerObj, errHandler)
	local req = AnimalsExtension_pb.PM_AnimalsProcessFeedBackReq()

	req.id = id

	self:sendMsg(req)
	self:addEventOnce(AnimalsAgent.PM_AnimalsProcessFeedBackRes, handler, handlerObj, errHandler)
end

function AnimalsAgent:handlePM_AnimalsProcessFeedBackRes(status, msg)
	self:dispatch(AnimalsAgent.PM_AnimalsProcessFeedBackRes, status, msg)
end

function AnimalsAgent:sendPM_AnimalsTouchReq(id, handler, handlerObj, errHandler)
	local req = AnimalsExtension_pb.PM_AnimalsTouchReq()

	req.id = id

	self:sendMsg(req)
	self:addEventOnce(AnimalsAgent.PM_AnimalsTouchRes, handler, handlerObj, errHandler)
end

function AnimalsAgent:handlePM_AnimalsTouchRes(status, msg)
	self:dispatch(AnimalsAgent.PM_AnimalsTouchRes, status, msg)
end

function AnimalsAgent:sendPM_AnimalsFeedReq(id, handler, handlerObj, errHandler)
	local req = AnimalsExtension_pb.PM_AnimalsFeedReq()

	req.id = id

	self:sendMsg(req)
	self:addEventOnce(AnimalsAgent.PM_AnimalsFeedRes, handler, handlerObj, errHandler)
end

function AnimalsAgent:handlePM_AnimalsFeedRes(status, msg)
	self:dispatch(AnimalsAgent.PM_AnimalsFeedRes, status, msg)
end

function AnimalsAgent:sendPM_AnimalsFollowReq(id, follow, handler, handlerObj, errHandler)
	local req = AnimalsExtension_pb.PM_AnimalsFollowReq()

	req.id = id
	req.follow = follow

	self:sendMsg(req)
	self:addEventOnce(AnimalsAgent.PM_AnimalsFollowRes, handler, handlerObj, errHandler)
end

function AnimalsAgent:handlePM_AnimalsFollowRes(status, msg)
	self:dispatch(AnimalsAgent.PM_AnimalsFollowRes, status, msg)
end

function AnimalsAgent:sendPM_AnimalsGainIntimacyPrizeReq(id, level, handler, handlerObj, errHandler)
	local req = AnimalsExtension_pb.PM_AnimalsGainIntimacyPrizeReq()

	req.id = id
	req.level = level

	self:sendMsg(req)
	self:addEventOnce(AnimalsAgent.PM_AnimalsGainIntimacyPrizeRes, handler, handlerObj, errHandler)
end

function AnimalsAgent:handlePM_AnimalsGainIntimacyPrizeRes(status, msg)
	self:dispatch(AnimalsAgent.PM_AnimalsGainIntimacyPrizeRes, status, msg)
end

function AnimalsAgent:sendPM_AnimalsGetFeedbackEventReq(id, handler, handlerObj, errHandler)
	local req = AnimalsExtension_pb.PM_AnimalsGetFeedbackEventReq()

	req.id = id

	self:sendMsg(req)
	self:addEventOnce(AnimalsAgent.PM_AnimalsGetFeedbackEventRes, handler, handlerObj, errHandler)
end

function AnimalsAgent:handlePM_AnimalsGetFeedbackEventRes(status, msg)
	self:dispatch(AnimalsAgent.PM_AnimalsGetFeedbackEventRes, status, msg)
end

function AnimalsAgent:sendPM_AnimalsOneKeyTouchReq(id, handler, handlerObj, errHandler)
	local req = AnimalsExtension_pb.PM_AnimalsOneKeyTouchReq()

	req.id = id

	self:sendMsg(req)
	self:addEventOnce(AnimalsAgent.PM_AnimalsTouchRes, handler, handlerObj, errHandler)
end

function AnimalsAgent:sendPM_AnimalsGinPigReq(name, hair, tail, skin, handler, handlerObj, errHandler)
	local req = AnimalsExtension_pb.PM_AnimalsGinPigReq()

	req.name = name
	req.hair = hair
	req.tail = tail
	req.skin = skin

	self:sendMsg(req)
	self:addEventOnce(AnimalsAgent.PM_AnimalsGinPigRes, handler, handlerObj, errHandler)
end

function AnimalsAgent:handlePM_AnimalsGinPigRes(status, msg)
	self:dispatch(AnimalsAgent.PM_AnimalsGinPigRes, status, msg)
end

function AnimalsAgent:sendPM_AnimalsPigAdventureInfoReq(id, handler, handlerObj, errHandler)
	local req = AnimalsExtension_pb.PM_AnimalsPigAdventureInfoReq()

	req.id = id

	self:sendMsg(req)
	self:addEventOnce(AnimalsAgent.PM_AnimalsPigAdventureInfoRes, handler, handlerObj, errHandler)
end

function AnimalsAgent:handlePM_AnimalsPigAdventureInfoRes(status, msg)
	self:dispatch(AnimalsAgent.PM_AnimalsPigAdventureInfoRes, status, msg)
end

function AnimalsAgent:sendPM_AnimalsPigAdventurePrizeReq(handler, handlerObj, errHandler)
	local req = AnimalsExtension_pb.PM_AnimalsPigAdventurePrizeReq()

	self:sendMsg(req)
	self:addEventOnce(AnimalsAgent.PM_AnimalsPigAdventurePrizeRes, handler, handlerObj, errHandler)
end

function AnimalsAgent:handlePM_AnimalsPigAdventurePrizeRes(status, msg)
	self:dispatch(AnimalsAgent.PM_AnimalsPigAdventurePrizeRes, status, msg)
end

function AnimalsAgent:sendPM_AnimalsGainPetRewardReq(id, handler, handlerObj, errHandler)
	local req = AnimalsExtension_pb.PM_AnimalsGainPetRewardReq()

	req.id = id

	self:sendMsg(req)
	self:addEventOnce(AnimalsAgent.PM_AnimalsGainPetRewardRes, handler, handlerObj, errHandler)
end

function AnimalsAgent:handlePM_AnimalsGainPetRewardRes(status, msg)
	self:dispatch(AnimalsAgent.PM_AnimalsGainPetRewardRes, status, msg)
end

function AnimalsAgent:sendPM_AnimalsRenameReq(id, name, handler, handlerObj, errHandler)
	local req = AnimalsExtension_pb.PM_AnimalsRenameReq()

	req.id = id
	req.name = name

	self:sendMsg(req)
	self:addEventOnce(AnimalsAgent.PM_AnimalsRenameRes, handler, handlerObj, errHandler)
end

function AnimalsAgent:handlePM_AnimalsRenameRes(status, msg)
	self:dispatch(AnimalsAgent.PM_AnimalsRenameRes, status, msg)
end

function AnimalsAgent:sendPM_AnimalsActivateReq(defineId, handler, handlerObj, errHandler)
	local req = AnimalsExtension_pb.PM_AnimalsActivateReq()

	req.defineId = defineId

	self:sendMsg(req)
	self:addEventOnce(AnimalsAgent.PM_AnimalsActivateRes, handler, handlerObj, errHandler)
end

function AnimalsAgent:handlePM_AnimalsActivateRes(status, msg)
	self:dispatch(AnimalsAgent.PM_AnimalsActivateRes, status, msg)
end

function AnimalsAgent:sendPM_AnimalsTakeReq(id, handler, handlerObj, errHandler)
	local req = AnimalsExtension_pb.PM_AnimalsTakeReq()

	req.id = id

	self:sendMsg(req)
	self:addEventOnce(AnimalsAgent.PM_AnimalsTakeRes, handler, handlerObj, errHandler)
end

function AnimalsAgent:handlePM_AnimalsTakeRes(status, msg)
	self:dispatch(AnimalsAgent.PM_AnimalsTakeRes, status, msg)
end

AnimalsAgent.instance = AnimalsAgent.New()

return AnimalsAgent
