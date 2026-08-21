local var_0_0 = class("CoreVerificationChallengeStageAffixItem", ReduxView)

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
			arg_4_0.clickFunc(arg_4_0.buff_id, true)
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.lockBtn_, nil, function()
		ShowTips("CORE_VERIFICATION_CL_BUFF_TIPS_2")
	end)
	arg_4_0:AddBtnListener(arg_4_0.selectBtn_, nil, function()
		if arg_4_0.selController_:GetSelectedIndex() == 0 then
			if #CoreVerificationChallengeData:GetSelectAffixs() < 6 then
				arg_4_0.selController_:SetSelectedIndex(1)
				arg_4_0.showTipsController_:SetSelectedIndex(1)

				if arg_4_0.clickFunc then
					CoreVerificationChallengeData:SetSelectAffixsAdd(arg_4_0.buff_id, arg_4_0.state + 1)
					arg_4_0.clickFunc(arg_4_0.buff_id, false)
				end
			else
				ShowTips("CORE_VERIFICATION_CL_BUFF_TIPS_3")
			end
		else
			arg_4_0.selController_:SetSelectedIndex(0)
			arg_4_0.showTipsController_:SetSelectedIndex(0)

			if arg_4_0.clickFunc then
				CoreVerificationChallengeData:SetSelectAffixsRemove(arg_4_0.buff_id)
				arg_4_0.clickFunc(arg_4_0.buff_id, false)
			end
		end
	end)
end

function var_0_0.RefreshUI(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	SetActive(arg_8_0.gameObject_, true)

	arg_8_0.stage_id = arg_8_4
	arg_8_0.challengeType = arg_8_3

	arg_8_0.showtoogleController_:SetSelectedIndex(arg_8_3)
	arg_8_0.bufftypeController_:SetSelectedIndex(arg_8_2)

	arg_8_0.buff_id = arg_8_1
	arg_8_0.state = arg_8_2

	arg_8_0.categoryController_:SetSelectedIndex(arg_8_2)

	arg_8_0.affixData = ActivityAffixPoolCfg[arg_8_1].affix
	arg_8_0.name.text = getAffixName(arg_8_0.affixData)
	arg_8_0.icon.sprite = getAffixSprite(arg_8_0.affixData)

	local var_8_0 = CoreVerificationChallengeData:GetBuffLevelById(arg_8_0.buff_id)

	arg_8_0.lvText_.text = string.format(GetTips("PINBALL_HERO_LEVEL"), var_8_0)

	if CoreVerificationChallengeData:IsSelectAffixById(arg_8_1) then
		arg_8_0.selController_:SetSelectedIndex(1)
		arg_8_0.showTipsController_:SetSelectedIndex(1)
	else
		arg_8_0.selController_:SetSelectedIndex(0)
		arg_8_0.showTipsController_:SetSelectedIndex(0)
	end
end

function var_0_0.RefreshLock(arg_9_0)
	local var_9_0 = CoreVerificationChallengeData:IsUnLockBuffById(arg_9_0.buff_id)

	arg_9_0.lockController_:SetSelectedIndex(var_9_0 and 0 or 1)
end

function var_0_0.RegisterClickListener(arg_10_0, arg_10_1)
	arg_10_0.clickFunc = arg_10_1
end

function var_0_0.Show(arg_11_0, arg_11_1)
	SetActive(arg_11_0.gameObject_, arg_11_1)
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
