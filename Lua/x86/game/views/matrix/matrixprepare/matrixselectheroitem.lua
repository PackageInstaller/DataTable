local var_0_0 = class("MatrixSelectHeroItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.index = 0

	arg_1_0:initUI()
	arg_1_0:AddUIListener()
end

function var_0_0.initUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.stateController_ = ControllerUtil.GetController(arg_2_0.m_statetController, "state")
	arg_2_0.captainController_ = ControllerUtil.GetController(arg_2_0.m_statetController, "captain")
	arg_2_0.lockController = ControllerUtil.GetController(arg_2_0.m_statetController, "lock")
	arg_2_0.levelController = ControllerUtil.GetController(arg_2_0.m_statetController, "level")
end

function var_0_0.CheckHeroLock(arg_3_0, arg_3_1)
	local var_3_0 = GameSetting.matrix_singularity_hero_level_limited.value[1]
	local var_3_1 = HeroData:GetHeroData(arg_3_1)

	if not var_3_1 or var_3_1.unlock ~= 1 then
		return true, GetTips("MATRIX_SINGULARITY_HERO_UNLOCK")
	elseif var_3_0 > var_3_1.level then
		return true, string.format(GetTips("MATRIX_SINGULARITY_HERO_LEVEL_UNLOCK"), var_3_0)
	end

	return false
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.m_clickBtn, nil, function()
		if arg_4_0.difficulty == 3 then
			local var_5_0, var_5_1 = arg_4_0:CheckHeroLock(arg_4_0.heroId)

			if var_5_0 then
				ShowTips(var_5_1)

				return
			end
		end

		if arg_4_0.clickFunc then
			arg_4_0.clickFunc()
		end
	end)
end

function var_0_0.Refresh(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	arg_6_0.heroStandardId = arg_6_1

	local var_6_0 = HeroStandardSystemCfg[arg_6_1]

	if not var_6_0 then
		return
	end

	local var_6_1 = var_6_0.hero_id
	local var_6_2 = HeroCfg[var_6_1]
	local var_6_3 = MatrixData:GetHeroSkin(var_6_1) or var_6_1
	local var_6_4 = SkinCfg[var_6_3]

	arg_6_0.m_icon.sprite = getSpriteViaConfig("HeroIcon", var_6_4.picture_id)
	arg_6_0.m_name.text = GetI18NText(var_6_2.name)
	arg_6_0.m_tip.text = GetI18NText(var_6_0.hero_desc) or ""
	arg_6_0.difficulty = arg_6_4
	arg_6_0.heroId = var_6_1

	if arg_6_4 == 3 then
		local var_6_5 = HeroData:GetHeroData(var_6_1)

		if arg_6_0:CheckHeroLock(var_6_1) then
			arg_6_2 = 2

			arg_6_0.lockController:SetSelectedIndex(1)
			arg_6_0.levelController:SetSelectedIndex(0)
		else
			arg_6_0.lockController:SetSelectedIndex(0)
			arg_6_0.levelController:SetSelectedIndex(1)

			arg_6_0.m_levelLab.text = var_6_5.level
		end

		arg_6_0.m_clickBtn.interactable = true
	else
		arg_6_0.lockController:SetSelectedIndex(0)
		arg_6_0.levelController:SetSelectedIndex(0)

		arg_6_0.m_clickBtn.interactable = arg_6_2 == 0 or arg_6_2 == 1
	end

	arg_6_0.stateController_:SetSelectedIndex(arg_6_2)
	arg_6_0.captainController_:SetSelectedIndex(arg_6_3 and 1 or 0)
end

function var_0_0.RegistCallBack(arg_7_0, arg_7_1)
	arg_7_0.clickFunc = arg_7_1
end

return var_0_0
