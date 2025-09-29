-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/climbingtower/config/ClimbingTowerEffectCO.lua

module("logic.extensions.climbingtower.config.ClimbingTowerEffectCO", package.seeall)

local M = class("ClimbingTowerEffectCO")

function M:ctor(cfg)
	self._code = cfg.code
	self._type = cfg.type
	self._skillcode = cfg.skillcode
	self._object = {}

	if cfg.object and #cfg.object > 0 then
		for _, numVal in ipairs(cfg.object) do
			self._object[numVal] = numVal
		end
	end

	self._career = {}
	self._careerNum = cfg.career and #cfg.career or 0

	if self._careerNum > 0 then
		for _, career in ipairs(cfg.career) do
			self._career[career] = career
		end
	end

	self._camp = {}
	self._campNum = cfg.camp and #cfg.camp or 0

	if self._campNum > 0 then
		for _, camp in ipairs(cfg.camp) do
			self._camp[camp] = camp
		end
	end

	self._role = {}
	self._roleNum = cfg.role and #cfg.role or 0

	if self._roleNum > 0 then
		for _, roleId in ipairs(cfg.role) do
			self._role[roleId] = roleId
		end
	end
end

function M:getCode()
	return self._code
end

function M:getTyp()
	return self._type
end

function M:getSkillCode()
	return self._skillcode
end

function M:getSkillEnhanceCO()
	return ActiveSkillConfig.instance:getActiveSkillCOWrapper(self:getSkillCode())
end

function M:getSkillName()
	local skillEnhanceCO = self:getSkillEnhanceCO()

	return skillEnhanceCO and skillEnhanceCO:getName() or ""
end

function M:getSkillDesc()
	local skillEnhanceCO = self:getSkillEnhanceCO()

	if skillEnhanceCO then
		local desc = skillEnhanceCO:getDescription()

		return desc
	end

	return ""
end

function M:getSkillIcon()
	local skillEnhanceCO = self:getSkillEnhanceCO()

	if skillEnhanceCO == nil then
		return nil
	end

	local skillCO = skillEnhanceCO:getSkillCO()

	if skillCO == nil then
		return nil
	end

	return ActiveSkillCOUtil.getSkillIcon(skillCO)
end

function M:getTargetObjectTypMap()
	return self._object
end

function M:getTargetCareerMap()
	return self._career
end

function M:getTargetCareerCount()
	return self._careerNum
end

function M:getTargetCampMap()
	return self._camp
end

function M:getTargetCampCount()
	return self._campNum
end

function M:getTargetRoleMap()
	return self._role
end

function M:getTargetRoleCount()
	return self._roleNum
end

return M
