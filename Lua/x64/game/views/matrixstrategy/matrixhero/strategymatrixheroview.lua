local var_0_0 = class("StrategyMatrixHeroView", MatrixMiniHeroView)

function var_0_0.UIBackCount(arg_1_0)
	return 1
end

function var_0_0.UIName(arg_2_0)
	return "UI/StrategyMatrix/StrategyMatrixMiniHeroUI"
end

function var_0_0.OnCtor(arg_3_0)
	arg_3_0.dirty_ = true
	arg_3_0.curPageIndex_ = -1
	arg_3_0.pageIndexS_ = {
		weapon = 3,
		astrolabe = 5,
		skill = 2,
		treasure = 6,
		property = 1,
		equip = 4
	}
	arg_3_0.prefabList_ = {
		"UI/StrategyMatrix/StrategyMatrixHeroAttributeMiniUI",
		"UI/Hero/HeroSkillPage",
		"UI/StrategyMatrix/StrategyMatrixHeroWeaponUI",
		"UI/StrategyMatrix/StrategyMatrixHeroEquipUI",
		"UI/StrategyMatrix/StrategyMatrixHeroAstrolabePage",
		"UI/StrategyMatrix/StrategyMatrixTreasureMiniUI"
	}
	arg_3_0.ClassList_ = {
		StrategyMatrixHeroAttributePage,
		StrategyMatrixHeroSkillPage,
		StrategyMartixHeroWeaponPage,
		StrategyMatrixHeroEquipPage,
		StrategyMatrixHeroAstrolabePage,
		StrategyMatrixTreasurePage
	}
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.pages_ = {}
	arg_4_0.heroAvatarView_ = HeroAvatarView.New(arg_4_0, arg_4_0.displayGo_)

	arg_4_0.heroAvatarView_:SetShowInteractive(true)

	arg_4_0.toggles_ = {
		arg_4_0.toggle1_,
		arg_4_0.toggle2_,
		arg_4_0.toggle3_,
		arg_4_0.toggle4_,
		arg_4_0.toggle5_,
		arg_4_0.toggle6_
	}
end

function var_0_0.AddUIListener(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.toggles_) do
		iter_5_1.onValueChanged:AddListener(function(arg_6_0)
			if arg_6_0 then
				arg_5_0:SwitchPage(iter_5_0)

				if arg_5_0.pages_[iter_5_0] then
					arg_5_0.pages_[iter_5_0]:SetMatirxHeroInfo(arg_5_0.matrix_activity_id, arg_5_0.curHeroId_)
				end
			end
		end)
	end

	arg_5_0:AddBtnListener(arg_5_0.m_rewardBtn, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnTop(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		ACTIVITY_MATRIX_COIN
	})
	manager.windowBar:SetGameHelpKey(StrategyMatrixTools.GetGameTipKey(arg_8_0.matrix_activity_id))
	manager.windowBar:SetActivityId(ACTIVITY_MATRIX_COIN, arg_8_0.matrix_activity_id)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.matrix_activity_id = arg_9_0.params_.matrix_activity_id

	var_0_0.super.OnEnter(arg_9_0)

	if arg_9_0:GetMatrixPhaseData():GetPhase() == 3 then
		SetActive(arg_9_0.m_rewardBtn.gameObject, true)
	else
		SetActive(arg_9_0.m_rewardBtn.gameObject, false)
	end
end

function var_0_0.UpdateHeroView(arg_10_0)
	arg_10_0:UpdateAvatarView()

	for iter_10_0, iter_10_1 in pairs(arg_10_0.pages_) do
		iter_10_1:SetMatirxHeroInfo(arg_10_0.matrix_activity_id, arg_10_0.curHeroId_)
	end
end

function var_0_0.UpdateAvatarView(arg_11_0)
	if arg_11_0.curPageIndex_ == arg_11_0.pageIndexS_.astrolabe then
		arg_11_0.heroAvatarView_:ShowHeroModel(false)
		arg_11_0.heroAvatarView_:SetCameraToPage("heroAstrolabe")
	elseif arg_11_0.curPageIndex_ == arg_11_0.pageIndexS_.equip or arg_11_0.curPageIndex_ == arg_11_0.pageIndexS_.treasure then
		arg_11_0.heroAvatarView_:ShowHeroModel(false)
		arg_11_0.heroAvatarView_:SetCameraToPage("heroEquip")
	elseif arg_11_0.curPageIndex_ == arg_11_0.pageIndexS_.weapon then
		arg_11_0.heroAvatarView_:ShowHeroModel(false)
		arg_11_0.heroAvatarView_:SetCameraToPage("heroWeapon")

		if arg_11_0:GetHeroData(arg_11_0.curHeroId_):GetWeaponServantEffect() ~= 0 then
			-- block empty
		end
	else
		arg_11_0.heroAvatarView_:SetSkinId(arg_11_0:GetHeroSkin(arg_11_0.curHeroId_))
		arg_11_0.heroAvatarView_:ShowHeroModel(true)
		arg_11_0.heroAvatarView_:SwitchCameraToCurrentHero(false)
	end
end

function var_0_0.GetHeroData(arg_12_0, arg_12_1)
	return StrategyMatrixData:GetHeroData(arg_12_1)
end

function var_0_0.GetHeroSkin(arg_13_0, arg_13_1)
	return StrategyMatrixData:GetHeroSkin(arg_13_0.matrix_activity_id, arg_13_1)
end

function var_0_0.GetMatrixPhaseData(arg_14_0)
	return StrategyMatrixData:GetMatrixPhaseData(arg_14_0.matrix_activity_id)
end

return var_0_0
