local BaseHeroDataTemplate = class("BaseHeroDataTemplate")

function BaseHeroDataTemplate:Ctor(arg_1_1)
	local var_1_0 = {}
	local var_1_1 = {}

	for iter_1_0, iter_1_1 in ipairs(HeroCfg[arg_1_1].skills) do
		table.insert(var_1_0, {
			skill_level = 1,
			skill_id = iter_1_1
		})

		if iter_1_0 <= 5 then
			table.insert(var_1_1, {
				level = 0,
				index = iter_1_0
			})
		end
	end

	self.id = arg_1_1
	self.exp = 0
	self.level = 1
	self.star = HeroCfg[arg_1_1].unlock_star
	self.using_skin = 0
	self.battle_using_skin = 0
	self.break_level = 0
	self.unlock = 0
	self.unlocked_astrolabe = {}
	self.using_astrolabe = {}
	self.equip = {
		{
			pos = 1,
			equip_id = 0
		},
		{
			pos = 2,
			equip_id = 0
		},
		{
			pos = 3,
			equip_id = 0
		},
		{
			pos = 4,
			equip_id = 0
		},
		{
			pos = 5,
			equip_id = 0
		},
		{
			pos = 6,
			equip_id = 0
		}
	}
	self.skill = var_1_0
	self.skillAttrList = var_1_1
	self.weapon_info = {
		exp = 0,
		breakthrough = 0,
		level = 1
	}
	self.servant_uid = 0
	self.servantInfo = {
		id = 0,
		uid = 0,
		lock = true,
		stage = 1
	}
	self.transition = {}
	self.moduleLevel = 0
	self.moduleAssignment = 0
end

function BaseHeroDataTemplate:Init(arg_2_1)
	Debug.LogError("heroDataTeamplate Type：" .. self:GetType() .. "need to override function Init(data)")
end

function BaseHeroDataTemplate:ModifyHero(arg_3_1)
	Debug.LogError("heroDataTeamplate Type：" .. self:GetType() .. "need to override function ModifyHero()")
end

function BaseHeroDataTemplate:GetServantInfo()
	Debug.LogError("heroDataTeamplate Type：" .. self:GetType() .. "need to override function GetServantInfo()")
end

function BaseHeroDataTemplate:GetWeaponInfo()
	Debug.LogError("heroDataTeamplate Type：" .. self:GetType() .. "need to override function GetWeaponInfo()")
end

function BaseHeroDataTemplate:GetEquipInfoList()
	Debug.LogError("heroDataTeamplate Type：" .. self:GetType() .. "need to override function GetEquipInfoList()")
end

function BaseHeroDataTemplate:GetSkillInfoList()
	Debug.LogError("heroDataTeamplate Type：" .. self:GetType() .. "need to override function GetSkillInfoList()")
end

function BaseHeroDataTemplate:GetSkillAttrList()
	Debug.LogError("heroDataTeamplate Type：" .. self:GetType() .. "need to override function GetSkillAttrList()")
end

function BaseHeroDataTemplate:GetTransitionInfoList()
	Debug.LogError("heroDataTeamplate Type：" .. self:GetType() .. "need to override function GetTransitionInfoList()")
end

function BaseHeroDataTemplate:GetType()
	Debug.LogError("heroDataTeamplate Type：" .. self:GetType() .. "need to override function GetType()")

	return HeroConst.HERO_DATA_TYPE.UNDEFINED
end

function BaseHeroDataTemplate:IsOath()
	Debug.LogError("heroDataTeamplate Type：" .. self:GetType() .. "need to override function IsOath()")

	return false
end

return BaseHeroDataTemplate
