local var_0_0 = class("CombineGameRoleItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.data = arg_4_1
	arg_4_0.lv = arg_4_2
	arg_4_0.type = arg_4_3

	arg_4_0:UpdateView()
end

function var_0_0.UpdateView(arg_5_0)
	SetActive(arg_5_0.maskGo_, arg_5_0.lv < arg_5_0.data.lv)

	local var_5_0 = ActivityCombineFactorCfg[arg_5_0.data.id]

	arg_5_0.LvTxt_.text = "等级" .. arg_5_0.data.lv .. "解锁"

	if arg_5_0.type == 1 then
		local var_5_1 = ActivityCombineSkillCfg[var_5_0.effect[1]]

		arg_5_0.descTxt_.text = GetI18NText(var_5_1.description)
		arg_5_0.iconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/combinegame/" .. var_5_1.icon)
	else
		arg_5_0.descTxt_.text = GetI18NText(var_5_0.description)
		arg_5_0.iconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/combinegame/" .. var_5_0.icon)
	end
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0:UpdateView()
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
	Object.Destroy(arg_7_0.gameObject_)
end

return var_0_0
