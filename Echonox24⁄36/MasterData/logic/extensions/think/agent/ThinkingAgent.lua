-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/think/agent/ThinkingAgent.lua

module("logic.extensions.think.agent.ThinkingAgent", package.seeall)

local M = class("ThinkingAgent", BaseAgent)

function M:sendGetAllThinkingRequest()
	local msg = ThinkingExtension_pb.GetAllThinkingRequest()

	self:sendMsg(msg)
end

function M:handleGetAllThinkingReply(status, msg)
	if status == 0 then
		ThinkingModel.instance:setData(msg.infos)
		printWarn("~~~~~获取所有思维成功")
	end
end

function M:sendGetHeroThinkingRequest()
	local msg = ThinkingExtension_pb.GetHeroThinkingRequest()

	self:sendMsg(msg)
end

function M:handleGetHeroThinkingReply(status, msg)
	if status == 0 then
		ThinkingModel.instance:refreshHeroThinkingInfos(msg.infos)
		printWarn("~~~~~获取所有角色的思维成功")
	end
end

function M:sendUnlockThinkingRequest(hero, id)
	local msg = ThinkingExtension_pb.UnlockThinkingRequest()

	msg.hero = hero
	msg.id = id

	self:sendMsg(msg)
end

function M:handleUnlockThinkingReply(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show(lang("已获得思维使用权"))
		GlobalDispatcher:dispatchEvent(EventType.THINKING_GET_USING)
	end
end

function M:sendWearThinkingRequest(heroId, thinkingId, skillId)
	local msg = ThinkingExtension_pb.WearThinkingRequest()

	msg.hero = heroId
	msg.thinking = thinkingId
	msg.skill = skillId
	self._skillTempId = skillId

	self:sendMsg(msg)
end

function M:handleWearThinkingReply(status, msg)
	if status == 0 then
		if self._skillTempId > 0 then
			FloatWordMgr.instance:show(lang("成功穿戴"))
		else
			FloatWordMgr.instance:show(lang("成功卸下"))
		end
	end
end

function M:sendThinkingSkillUpgradeRequest(thinkingId, skillId)
	local msg = ThinkingExtension_pb.ThinkingSkillUpgradeRequest()

	msg.id = thinkingId
	msg.skill = skillId
	self._tempThinkingId = thinkingId
	self._tempSkillId = skillId

	self:sendMsg(msg)
end

function M:handleThinkingSkillUpgradeReply(status, msg)
	if status == 0 then
		local thinkingMO = ThinkingModel.instance:getMoById(self._tempThinkingId)
		local skillId = self._tempSkillId
		local skillLevel = thinkingMO:getSkillLevel(skillId)
		local param = {
			skillId = self._tempSkillId,
			thinkingId = self._tempThinkingId
		}

		if skillLevel == 1 then
			ViewMgr.instance:open(ViewName.ThinkingActiveSuccessView, param)
		else
			ViewMgr.instance:open(ViewName.ThinkingUpgradeSuccessView, param)
		end

		GlobalDispatcher:dispatchEvent(EventType.THINKING_REFRESH)
	end
end

function M:handleChangeThinkingPush(status, msg)
	if status == 0 then
		printWarn("~~~~~~思维变更推送")
		ThinkingModel.instance:setData(msg.infos)
	end
end

function M:handleChangeThinkingWearInfoPush(status, msg)
	if status == 0 then
		printWarn("~~~~~~思维穿戴信息变更推送")
		ThinkingModel.instance:refreshHeroThinkingInfos(msg.infos)
	end
end

M.instance = M.New()

return M
