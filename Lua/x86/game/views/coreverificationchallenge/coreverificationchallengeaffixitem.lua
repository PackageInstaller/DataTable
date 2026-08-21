local var_0_0 = class("CoreVerificationChallengeAffixItem", ReduxView)

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

	arg_3_0.selController_ = arg_3_0.controller:GetController("sel")
	arg_3_0.lockController_ = arg_3_0.controller:GetController("lock")
	arg_3_0.categoryController_ = arg_3_0.affixController_:GetController("category")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.delBtn_, nil, function()
		return
	end)
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1, arg_6_2)
	SetActive(arg_6_0.gameObject_, true)

	arg_6_0.state = arg_6_2

	arg_6_0.categoryController_:SetSelectedIndex(arg_6_2)

	local var_6_0 = ActivityAffixPoolCfg[arg_6_1].affix

	arg_6_0.name.text = getAffixName(var_6_0)
	arg_6_0.desc.text = getAffixDesc(var_6_0)
	arg_6_0.icon.sprite = getAffixSprite(var_6_0)

	if arg_6_2 == 0 then
		arg_6_0.lvText_.text = string.format(GetTips("PINBALL_HERO_LEVEL"), CoreVerificationChallengeData:GetBuffLevelById(arg_6_1))
	end
end

function var_0_0.Show(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
