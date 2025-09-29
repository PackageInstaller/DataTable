-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/agent/HeroPowerAgent.lua

module("logic.extensions.charactersystem.agent.HeroPowerAgent", package.seeall)

local M = class("HeroPowerAgent", BaseAgent)

function M:ctor()
	M.super.ctor(self)
end

function M:sendHeroPowerInfoRequest(heroId, callback, callbackHandle)
	local req = HeroPowerExtension_pb.HeroPowerInfoRequest()

	req.heroId = heroId

	self:invoke({
		funcName = "handleHeroPowerInfoReply",
		sendData = req,
		handleCall = function(status, msg)
			if status == 0 then
				CharacterAuthorityModel.instance:updateHeroPowerInfo(msg.heroId, msg.nodesInfo, msg.extNodesInfo)
				GlobalDispatcher:dispatchEvent(EventType.HERO_POWER_REFRESH_NODE_INFO)
				CharacterAuthorityModel.instance:updateHeroRecord(msg.heroId, msg.records)

				if callback then
					callback(callbackHandle)
				end
			end
		end
	})
end

function M:sendHeroNodeActRequest(heroId, nodeId)
	self._nodeActCache = CharacterAuthorityModel.instance:getPowerNodeUnlockCache(heroId, nodeId)

	local msg = HeroPowerExtension_pb.HeroNodeActRequest()

	msg.heroId = heroId
	msg.nodeId = nodeId

	self:sendMsg(msg)
	CharacterAuthorityModel.instance:setPlayNodeEffectSend(true)
end

function M:handleHeroNodeActReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.HERO_POWER_UNLOCK, self._nodeActCache)
	end

	self._nodeActCache = nil
end

function M:sendHeroExtNodeActRequest(heroId, nodeId)
	self._nodeActExtCache = CharacterAuthorityModel.instance:getPowerNodeUnlockCache(heroId, nodeId)

	local msg = HeroPowerExtension_pb.HeroExtNodeActRequest()

	msg.heroId = heroId
	msg.nodeId = nodeId

	self:sendMsg(msg)
end

function M:handleHeroExtNodeActReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.HERO_POWER_UNLOCK, self._nodeActExtCache)
	end

	self._nodeActExtCache = nil
end

function M:handleHeroPowerInfoPush(status, msg)
	if status == 0 then
		CharacterAuthorityModel.instance:setPlayNodeEffectRecieve(true)
		CharacterAuthorityModel.instance:updateHeroPowerInfo(msg.heroId, msg.nodesInfo, msg.extNodesInfo)
		GlobalDispatcher:dispatchEvent(EventType.HERO_POWER_REFRESH_NODE_INFO)
		CharacterAuthorityModel.instance:updateHeroRecord(msg.heroId, msg.records)
	end
end

M.instance = M.New()

return M
