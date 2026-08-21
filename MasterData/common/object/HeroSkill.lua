-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\Object\\HeroSkill.lua

local ResSkillConfig = require("ClientData/ResSkillConfig")
local ResPassiveSkill = require("ClientData/ResPassiveSkill")
local strClassName = "HeroSkill"
local HeroSkill = Class(strClassName)

function HeroSkill:ctor(skillID, level, skill_field)
	self.id = skillID
	self.skillField = skill_field or 0
	self.level = level or 1
	self.isPassive = self.skillField == Const.HERO_SKILL_FIELD.ENTER_PASSIVE or self.skillField == Const.HERO_SKILL_FIELD.HERO_PASSIVE

	if self.isPassive then
		local data = ResPassiveSkill[self.id]

		if data then
			self.resData = data[self.level] or data[1]
		else
			self.style = 2
			self.name = ""
			self.desc = ""

			return
		end

		self.style = 2
		self.name = self.resData.name or ""
		self.desc = self.resData.desc or ""
	else
		local data = ResSkillConfig[self.id]

		if data then
			self.resData = data[self.level] or data[1]
		else
			self.style = 0
			self.name = ""
			self.desc = ""

			return
		end

		self.style = self.resData.skill_type
		self.name = self.resData.name or ""
		self.desc = self.resData.skill_desc or ""
	end

	self.extraDesc = self.resData.extra_desc_id
end

function HeroSkill:getIconPath()
	if self.resData and self.resData.icon_path and self.resData.icon then
		return {
			"Atlas/" .. self.resData.icon_path,
			self.resData.icon
		}
	end
end

function HeroSkill:getStyleInfo()
	if UIConst.SKILL_TYPE_PATH[self.skillField] then
		return UIConst.SKILL_TYPE_PATH[self.skillField]
	end
end

function HeroSkill:getTipsBgInfo()
	local iconName = ""

	if self.level == 0 then
		iconName = "BgDisGrid"
	elseif self.skillField == Const.HERO_SKILL_FIELD.ATTACK then
		iconName = "BgAttackGrid"
	elseif self.skillField == Const.HERO_SKILL_FIELD.SKILL then
		iconName = "BgSkillGrid"
	elseif self.skillField == Const.HERO_SKILL_FIELD.HERO_PASSIVE then
		iconName = "BgPassiveGrid"
	elseif self.skillField == Const.HERO_SKILL_FIELD.ENTER_PASSIVE then
		iconName = "BgSpecialGrid"
	end

	return {
		"Atlas/CommonAtlas/GridAtlas/GridAtlas01",
		iconName
	}
end

return HeroSkill
