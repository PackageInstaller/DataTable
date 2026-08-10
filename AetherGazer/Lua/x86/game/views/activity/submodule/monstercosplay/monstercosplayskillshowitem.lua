local var_0_0 = class("MonsterCosplaySkillShowItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.cfg = ActivityMonsterCosplaySkillCfg[arg_3_1]
	arg_3_0.index = arg_3_2
	arg_3_0.callBack = arg_3_3

	arg_3_0:UpdateView()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.normalBtn_, nil, function()
		arg_5_0.callBack(arg_5_0.normalBtn_, arg_5_0.cfg, 1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.upBtn_, nil, function()
		arg_5_0.callBack(arg_5_0.upBtn_, arg_5_0.cfg, 2)
	end)
end

function var_0_0.UpdateView(arg_8_0)
	arg_8_0.nameTxt_.text = GetI18NText(arg_8_0.cfg.skill_name)
	arg_8_0.normalIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Summer2024/Summer2024_MonsterPlayUI/" .. arg_8_0.cfg.skill_start_icon)
	arg_8_0.upIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Summer2024/Summer2024_MonsterPlayUI/" .. arg_8_0.cfg.skill_new_icon)
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
