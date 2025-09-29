-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/agent/AchievementAgent.lua

module("logic.extensions.playerinfo.agent.AchievementAgent", package.seeall)

local M = class("AchievementAgent", BaseAgent)

function M:ctor()
	M.super.ctor(self)
end

function M:sendGetAllAchievementRequest()
	local msg = AchievementExtension_pb.GetAllAchievementRequest()

	self:sendMsg(msg)
end

function M:handleGetAllAchievementReply(status, msg)
	if status == 0 then
		AchievementModel.instance:refreshAchievementMoByAgent(msg.achievements or {})
		AchievementModel.instance:updateAchievementSkillInfo(msg.skill or {})
		GlobalDispatcher:dispatchEvent(EventType.UPDATA_ACHIEVEMENT)
	end
end

function M:sendTakeRewardRequest(ids)
	local msg = AchievementExtension_pb.TakeRewardRequest()

	for i, v in ipairs(ids) do
		table.insert(msg.ids, v)
	end

	self:sendMsg(msg)
end

function M:handleTakeRewardReply(status, msg)
	if status == 0 then
		AchievementAgent.instance:sendGetAllAchievementRequest()
		AchievementModel.instance:refreshSingleAchMoByAgent(msg.achievements)
		AchievementModel.instance:updateAchievementSkillInfo({
			msg.skill
		} or {}, true)
		GlobalDispatcher:dispatchEvent(EventType.UPDATA_ACHIEVEMENT)
		GlobalDispatcher:dispatchEvent(EventType.ACHIEVEMENT_FILLAMOUNT_ANI)
	end
end

function M:sendTakeAchievementSkillLevelRewardRequest(skillId, levels)
	local msg = AchievementExtension_pb.TakeAchievementSkillLevelRewardRequest()

	msg.skillId = skillId

	for i, v in ipairs(levels) do
		table.insert(msg.levels, v)
	end

	self:sendMsg(msg)
end

function M:handleTakeAchievementSkillLevelRewardReply(status, msg)
	if status == 0 then
		AchievementModel.instance:updateAchievementSkillInfo({
			msg.skill
		} or {})
		GlobalDispatcher:dispatchEvent(EventType.ACHIEVEMENT_TAKE_REWARD_SUC)
	end
end

M.instance = M.New()

return M
