local DormSkillDisplay = class("DormSkillDisplay", ReduxView)

function DormSkillDisplay:OnCtor(arg_1_1)
	if arg_1_1 then
		self:BindCfgUI(arg_1_1)
	end
end

local function var_0_1(arg_2_0)
	return "skill: " .. arg_2_0
end

local function var_0_2(arg_3_0)
	return getSpriteWithoutAtlas("skill_icon_" .. arg_3_0)
end

function DormSkillDisplay:SetData(arg_4_1)
	if self.desc_1 then
		self.desc_1.text = GetI18NText(var_0_1(BackHomeHeroCfg[arg_4_1].skill_list[1]))
	end

	if self.desc_2 then
		self.desc_2.text = GetI18NText(var_0_1(BackHomeHeroCfg[arg_4_1].skill_list[2]))
	end

	local var_4_0 = var_0_2(BackHomeHeroCfg[arg_4_1].skill_list[1])
	local var_4_1 = var_0_2(BackHomeHeroCfg[arg_4_1].skill_list[2])

	if self.icon_1 and var_4_0 then
		self.icon_1.sprite = var_4_0
	end

	if self.icon_2 and var_4_1 then
		self.icon_2.sprite = var_4_1
	end
end

return DormSkillDisplay
