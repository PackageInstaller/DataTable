local var_0_0 = class("DormSkillDisplay", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	if arg_1_1 then
		arg_1_0:BindCfgUI(arg_1_1)
	end
end

local function var_0_1(arg_2_0)
	return "skill: " .. arg_2_0
end

local function var_0_2(arg_3_0)
	return getSpriteWithoutAtlas("skill_icon_" .. arg_3_0)
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	local var_4_0 = BackHomeHeroCfg[arg_4_1]

	if arg_4_0.desc_1 then
		arg_4_0.desc_1.text = GetI18NText(var_0_1(var_4_0.skill_list[1]))
	end

	if arg_4_0.desc_2 then
		arg_4_0.desc_2.text = GetI18NText(var_0_1(var_4_0.skill_list[2]))
	end

	local var_4_1 = var_0_2(var_4_0.skill_list[1])
	local var_4_2 = var_0_2(var_4_0.skill_list[2])

	if arg_4_0.icon_1 and var_4_1 then
		arg_4_0.icon_1.sprite = var_4_1
	end

	if arg_4_0.icon_2 and var_4_2 then
		arg_4_0.icon_2.sprite = var_4_2
	end
end

return var_0_0
