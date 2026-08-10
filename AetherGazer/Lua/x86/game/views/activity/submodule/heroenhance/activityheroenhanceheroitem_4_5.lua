local var_0_0 = class("ActivityHeroEnhanceHeroItem_4_5", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
	arg_1_0:AddUIListener()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.selController_ = arg_2_0.controller_:GetController("status")
	arg_2_0.lockController_ = arg_2_0.controller_:GetController("lock")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.selfBtn_, nil, function()
		if arg_3_0.onClickHandler_ then
			local var_4_0 = ActivityHeroEnhanceCfg[arg_3_0.cfgId_]
			local var_4_1, var_4_2 = ActivityHeroEnhanceTools.IsCfgHeroLock(var_4_0)

			if var_4_1 then
				local var_4_3 = var_4_0.activity_id
				local var_4_4 = ActivityHeroEnhanceTools.GetTutorialCfg(var_4_3)
				local var_4_5 = HeroTools.GetHeroFullName(var_4_4.hero_id)

				ShowTips(string.format(GetTips("ACTIVITY_HERO_ENHANCE_HERO_UNLOCK_CONDITION_2"), var_4_5))

				return
			end

			arg_3_0.onClickHandler_(arg_3_0.cfgId_)
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

function var_0_0.SetSelected(arg_7_0, arg_7_1)
	arg_7_0.selected_ = arg_7_1

	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = ActivityHeroEnhanceCfg[arg_8_0.cfgId_]
	local var_8_1 = var_8_0.activity_id
	local var_8_2 = var_8_0.hero_id
	local var_8_3 = HeroData:GetHeroData(var_8_2)
	local var_8_4 = HeroCfg[var_8_2]

	arg_8_0.headIcon1_.sprite = HeroTools.GetHeadSprite(var_8_2)
	arg_8_0.nameText1_.text = HeroTools.GetHeroFullName(var_8_2)
	arg_8_0.headIcon2_.sprite = HeroTools.GetHeadSprite(var_8_2)
	arg_8_0.nameText2_.text = HeroTools.GetHeroFullName(var_8_2)

	local var_8_5, var_8_6 = ActivityHeroEnhanceTools.IsCfgHeroLock(var_8_0)

	arg_8_0.selController_:SetSelectedState(arg_8_0.selected_ and "select" or "nomal")
	arg_8_0.lockController_:SetSelectedState((arg_8_0.isAni_ or var_8_5) and "true" or "false")

	if var_8_5 then
		if var_8_6.isBeforeStartDay then
			local var_8_7 = GetTips("ACTIVITY_HERO_ENHANCE_HERO_UNLOCK_CONDITION")
		else
			local var_8_8 = ActivityHeroEnhanceTools.GetTutorialCfg(var_8_1)
			local var_8_9 = HeroTools.GetHeroFullName(var_8_8.hero_id)
		end
	elseif not (getData("heroEnhanceHeroUnlock" .. var_8_1, tostring(var_8_2)) or false) then
		saveData("heroEnhanceHeroUnlock" .. var_8_1, tostring(var_8_2), true)
		SetActive(arg_8_0.effectGo_, true)
	else
		SetActive(arg_8_0.effectGo_, false)
	end
end

function var_0_0.PlayAnim(arg_9_0, arg_9_1)
	arg_9_0.lockController_:SetSelectedState("true")

	arg_9_0.animator_.enabled = true

	arg_9_0.animator_:Play("UI_jiesuo", 0, 0)

	if arg_9_0.aniTimer_ then
		arg_9_0.aniTimer_:Stop()

		arg_9_0.aniTimer_ = nil
	end

	arg_9_0.aniTimer_ = Timer.New(function()
		if arg_9_0.animator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			arg_9_0.animator_.enabled = false

			if arg_9_0.aniTimer_ then
				arg_9_0.aniTimer_:Stop()

				arg_9_0.aniTimer_ = nil
			end

			if arg_9_1 then
				arg_9_1()
			end

			arg_9_0.lockController_:SetSelectedState("false")
			manager.ui:UIEventEnabledByUI(true, false)
		end
	end, 0.033, -1)

	manager.ui:UIEventEnabledByUI(false, true)

	arg_9_0.isAni_ = true

	arg_9_0.aniTimer_:Start()
end

function var_0_0.GetRedPointTransform(arg_11_0)
	return arg_11_0.selfBtn_.transform
end

function var_0_0.GetCfgId(arg_12_0)
	return arg_12_0.cfgId_
end

function var_0_0.Dispose(arg_13_0)
	if arg_13_0.aniTimer_ then
		arg_13_0.aniTimer_:Stop()

		arg_13_0.aniTimer_ = nil
	end

	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
