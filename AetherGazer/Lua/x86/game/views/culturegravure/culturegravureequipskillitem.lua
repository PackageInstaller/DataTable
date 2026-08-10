local var_0_0 = class("CultureGravureEquipSkillItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.recommendController_ = arg_3_0.transCon_:GetController("recommend")
end

function var_0_0.AddListeners(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.equipSkillId_ = arg_5_1.id
	arg_5_0.recommmendLevel_ = arg_5_1.recommendLevel

	local var_5_0 = EquipSkillCfg[arg_5_0.equipSkillId_]

	arg_5_0.iconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. var_5_0.icon)
	arg_5_0.nameText_.text = var_5_0.name

	local var_5_1 = var_5_0.upgrade / var_5_0.percent * var_5_0.lvmax
	local var_5_2 = GetCfgDescriptionWithValue(var_5_0.desc[1], tostring(var_5_1))

	if var_5_0.desc_spec_value ~= nil and var_5_0.desc_spec_value ~= "" then
		var_5_2 = string.gsub(var_5_2, tostring(var_5_1), var_5_0.desc_spec_value[var_5_0.lvmax])
	end

	arg_5_0.descText_.text = GetI18NText(var_5_2)

	arg_5_0.recommendController_:SetSelectedState(arg_5_0.recommmendLevel_)
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
