local var_0_0 = class("CoreVerificationCommonStageAffixItem", ReduxView)

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
	arg_3_0.bufftypeController_ = arg_3_0.controller:GetController("bufftype")
	arg_3_0.showtoogleController_ = arg_3_0.controller:GetController("showtoogle")
	arg_3_0.showTipsController_ = arg_3_0.controller:GetController("showTips")
	arg_3_0.categoryController_ = arg_3_0.affixController_:GetController("category")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.clickFunc then
			arg_4_0.clickFunc(arg_4_0.buff_id, true, arg_4_0.index)
		end
	end)
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	SetActive(arg_6_0.gameObject_, true)

	arg_6_0.index = arg_6_4
	arg_6_0.challengeType = arg_6_3

	arg_6_0.showtoogleController_:SetSelectedIndex(0)
	arg_6_0.bufftypeController_:SetSelectedIndex(arg_6_2)

	arg_6_0.buff_id = arg_6_1
	arg_6_0.state = arg_6_2

	arg_6_0.categoryController_:SetSelectedIndex(arg_6_2)

	arg_6_0.affixData = ActivityAffixPoolCfg[arg_6_1].affix
	arg_6_0.name.text = getAffixName(arg_6_0.affixData)
	arg_6_0.icon.sprite = getAffixSprite(arg_6_0.affixData)

	local var_6_0 = CoreVerificationChallengeData:GetBuffLevelById(arg_6_0.buff_id)

	arg_6_0.lvText_.text = string.format(GetTips("PINBALL_HERO_LEVEL"), var_6_0)
end

function var_0_0.RefreshLock(arg_7_0)
	arg_7_0.lockController_:SetSelectedIndex(0)
end

function var_0_0.RegisterClickListener(arg_8_0, arg_8_1)
	arg_8_0.clickFunc = arg_8_1
end

function var_0_0.Show(arg_9_0, arg_9_1)
	SetActive(arg_9_0.gameObject_, arg_9_1)
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
