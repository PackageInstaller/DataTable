local var_0_0 = class("CoreVerificationChallengeStageAffixItemMode2", ReduxView)

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
	arg_3_0.pointbgController_ = arg_3_0.controller:GetController("pointbg")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.clickFunc then
			arg_4_0.clickFunc(arg_4_0.buff_id, true)
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.selectBtn_, nil, function()
		if arg_4_0.selController_:GetSelectedIndex() == 0 then
			arg_4_0.selController_:SetSelectedIndex(1)

			if arg_4_0.clickFunc then
				CoreVerificationChallengeMode2Data:SetSelectAffixsAdd(arg_4_0.buff_id, arg_4_0.state + 1)
				arg_4_0.clickFunc(arg_4_0.buff_id, false)
			end
		else
			arg_4_0.selController_:SetSelectedIndex(0)

			if arg_4_0.clickFunc then
				CoreVerificationChallengeMode2Data:SetSelectAffixsRemove(arg_4_0.buff_id)
				arg_4_0.clickFunc(arg_4_0.buff_id, false)
			end
		end
	end)
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	SetActive(arg_7_0.gameObject_, true)

	arg_7_0.stage_id = arg_7_4
	arg_7_0.challengeType = arg_7_3

	arg_7_0.showtoogleController_:SetSelectedIndex(arg_7_3)
	arg_7_0.bufftypeController_:SetSelectedIndex(arg_7_2)

	arg_7_0.buff_id = arg_7_1
	arg_7_0.state = arg_7_2

	arg_7_0.categoryController_:SetSelectedIndex(arg_7_2)

	arg_7_0.affixData = ActivityAffixPoolCfg[arg_7_1].affix
	arg_7_0.name.text = getAffixName(arg_7_0.affixData)
	arg_7_0.icon.sprite = getAffixSprite(arg_7_0.affixData)

	if arg_7_0.state == 1 then
		arg_7_0.limitText_.text = ActivityAffixPoolCfg[arg_7_1].point
		arg_7_0.limitText_2.text = ActivityAffixPoolCfg[arg_7_1].point

		arg_7_0.pointbgController_:SetSelectedIndex(1)

		arg_7_0.buffText_.text = "+" .. ActivityAffixPoolCfg[arg_7_1].point * 10 .. "%"
	else
		arg_7_0.limitText_.text = ActivityAffixPoolCfg[arg_7_1].point
		arg_7_0.limitText_2.text = ActivityAffixPoolCfg[arg_7_1].point

		arg_7_0.pointbgController_:SetSelectedIndex(0)
	end

	if CoreVerificationChallengeMode2Data:IsSelectAffixById(arg_7_1) then
		arg_7_0.selController_:SetSelectedIndex(1)
	else
		arg_7_0.selController_:SetSelectedIndex(0)
	end
end

function var_0_0.RefreshLock(arg_8_0)
	local var_8_0 = CoreVerificationChallengeMode2Data:IsUnLockBuffById(arg_8_0.buff_id)

	arg_8_0.lockController_:SetSelectedIndex(var_8_0 and 0 or 1)
end

function var_0_0.RegisterClickListener(arg_9_0, arg_9_1)
	arg_9_0.clickFunc = arg_9_1
end

function var_0_0.Show(arg_10_0, arg_10_1)
	SetActive(arg_10_0.gameObject_, arg_10_1)
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
