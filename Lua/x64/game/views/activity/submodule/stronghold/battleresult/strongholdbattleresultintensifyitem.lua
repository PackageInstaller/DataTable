local var_0_0 = class("StrongholdBattleResultIntensifyItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.m_btn, nil, function()
		if arg_4_0.callback_ then
			arg_4_0.callback_(arg_4_0.id)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.id = arg_6_1

	local var_6_0 = ActivityStrongholdArtifactCfg[arg_6_1]

	arg_6_0.m_icon.sprite = pureGetSpriteWithoutAtlas(var_6_0.icon)
	arg_6_0.m_name.text = var_6_0.name
end

function var_0_0.RegistCallBack(arg_7_0, arg_7_1)
	arg_7_0.callback_ = arg_7_1
end

return var_0_0
