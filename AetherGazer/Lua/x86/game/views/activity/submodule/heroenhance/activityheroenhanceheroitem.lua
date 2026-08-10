local var_0_0 = class("ActivityHeroEnhanceHeroItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
	arg_1_0:AddUIListener()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.selController_ = arg_2_0.controller_:GetController("selected")
	arg_2_0.lockController_ = arg_2_0.controller_:GetController("lock")
	arg_2_0.passController_ = arg_2_0.controller_:GetController("pass")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.selfBtn_, nil, function()
		if arg_3_0.onClickHandler_ then
			arg_3_0.onClickHandler_(arg_3_0.heroID)
		end
	end)
end

function var_0_0.SetClickHandler(arg_5_0, arg_5_1)
	if arg_5_1 then
		arg_5_0.onClickHandler_ = arg_5_1
	end
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.cfgId_ = arg_6_1
end

function var_0_0.SetIgnorePass(arg_7_0, arg_7_1)
	arg_7_0.isIgnorePass_ = arg_7_1
end

function var_0_0.SetSelected(arg_8_0, arg_8_1)
	arg_8_0.selected_ = arg_8_1

	return arg_8_0.selected_
end

function var_0_0.RefreshUI(arg_9_0)
	local var_9_0 = ActivityHeroEnhanceCfg[arg_9_0.cfgId_]
	local var_9_1 = var_9_0.activity_id
	local var_9_2 = var_9_0.hero_id
	local var_9_3 = HeroData:GetHeroData(var_9_2)
	local var_9_4 = HeroCfg[var_9_2]

	arg_9_0.headIcon_.sprite = HeroTools.GetHeadSprite(var_9_2)
	arg_9_0.nameText_.text = HeroTools.GetHeroFullName(var_9_2)

	local var_9_5, var_9_6 = ActivityHeroEnhanceTools.IsCfgHeroLock(var_9_0)

	arg_9_0.selController_:SetSelectedState(arg_9_0.selected_ and "true" or "false")
	arg_9_0.lockController_:SetSelectedState(var_9_5 and "true" or "false")

	if not arg_9_0.isIgnorePass_ then
		local var_9_7 = not var_9_5 and ActivityHeroEnhanceTools.IsCfgHeroPass(var_9_0)

		arg_9_0.passController_:SetSelectedState(var_9_7 and "true" or "false")
	end

	if var_9_5 then
		if var_9_6.isBeforeStartDay then
			local var_9_8 = GetTips("ACTIVITY_HERO_ENHANCE_HERO_UNLOCK_CONDITION")

			arg_9_0.lockText_.text = string.format(var_9_8, var_9_6.startDay - var_9_6.curDay)
		else
			local var_9_9 = ActivityHeroEnhanceTools.GetTutorialCfg(var_9_1)
			local var_9_10 = HeroTools.GetHeroFullName(var_9_9.hero_id)

			arg_9_0.lockText_.text = GetTipsF("ACTIVITY_HERO_ENHANCE_HERO_UNLOCK_CONDITION_2", var_9_10)
		end
	end
end

function var_0_0.GetRedPointTransform(arg_10_0)
	return arg_10_0.selfBtn_.transform
end

function var_0_0.GetCfgId(arg_11_0)
	return arg_11_0.cfgId_
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
