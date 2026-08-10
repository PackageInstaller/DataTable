local var_0_0 = class("CoreVerificationChallengeAffixSelectItem", ReduxView)

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

	arg_3_0.categoryController_ = arg_3_0.affixController_:GetController("category")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn, nil, function()
		return
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_2.type - 1 == 0 then
		arg_6_0.categoryController_:SetSelectedIndex(0)
	else
		arg_6_0.categoryController_:SetSelectedIndex(1)
	end

	local var_6_0 = ActivityAffixPoolCfg[arg_6_2.buff_id].affix

	arg_6_0.icon.sprite = getAffixSprite(var_6_0)
end

function var_0_0.Show(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
