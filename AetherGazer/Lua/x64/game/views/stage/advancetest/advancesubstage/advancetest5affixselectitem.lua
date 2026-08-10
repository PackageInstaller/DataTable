local var_0_0 = class("AdvanceTest4AffixSelectItem", ReduxView)

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
	arg_3_0.pointbgController_ = arg_3_0.controller:GetController("pointbg")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.clickFunc then
			arg_4_0.clickFunc(arg_4_0.index, arg_4_0.state, arg_4_0.buff_id)
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.lockBtn_, nil, function()
		ShowTips("CORE_VERIFICATION_CL_BUFF_TIPS_2")
	end)
	arg_4_0:AddBtnListener(arg_4_0.selectBtn_, nil, function()
		if arg_4_0.selectFunc then
			arg_4_0.selectFunc(arg_4_0.index, arg_4_0.state)
		end
	end)
end

function var_0_0.RefreshUI(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	arg_8_0.index = arg_8_1
	arg_8_0.state = arg_8_3
	arg_8_0.buff_id = arg_8_2[1]
	arg_8_0.point = arg_8_2[2]

	arg_8_0.showtoogleController_:SetSelectedIndex(1)
	arg_8_0.bufftypeController_:SetSelectedIndex(arg_8_3)

	local var_8_0 = arg_8_0.buff_id

	arg_8_0.affixData = ActivityAffixPoolCfg[var_8_0].affix
	arg_8_0.name.text = getAffixName(arg_8_0.affixData)
	arg_8_0.icon.sprite = getAffixSprite(arg_8_0.affixData)

	if arg_8_0.state == 1 then
		arg_8_0.limitText_.text = ActivityAffixPoolCfg[var_8_0].point
		arg_8_0.limitText_2.text = ActivityAffixPoolCfg[var_8_0].point

		arg_8_0.pointbgController_:SetSelectedIndex(1)

		arg_8_0.buffText_.text = "+" .. ActivityAffixPoolCfg[var_8_0].point * 10 .. "%"
	else
		arg_8_0.limitText_.text = ActivityAffixPoolCfg[var_8_0].point
		arg_8_0.limitText_2.text = ActivityAffixPoolCfg[var_8_0].point

		arg_8_0.pointbgController_:SetSelectedIndex(0)
	end

	if arg_8_4 then
		arg_8_0.selController_:SetSelectedIndex(1)
	else
		arg_8_0.selController_:SetSelectedIndex(0)
	end

	if arg_8_5 then
		arg_8_0.showTipsController_:SetSelectedIndex(1)
	else
		arg_8_0.showTipsController_:SetSelectedIndex(0)
	end
end

function var_0_0.RefreshLock(arg_9_0)
	arg_9_0.lockController_:SetSelectedIndex(0)
end

function var_0_0.RegisterClickListener(arg_10_0, arg_10_1)
	arg_10_0.clickFunc = arg_10_1
end

function var_0_0.RegisterSelectListener(arg_11_0, arg_11_1)
	arg_11_0.selectFunc = arg_11_1
end

return var_0_0
