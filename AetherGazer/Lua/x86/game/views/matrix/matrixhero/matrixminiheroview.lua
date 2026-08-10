local var_0_0 = class("MatrixMiniHeroView", ReduxView)

function var_0_0.UIBackCount(arg_1_0)
	return 3
end

function var_0_0.UIName(arg_2_0)
	return "UI/MatrixHero/MatrixMiniHeroUI"
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_4_0)
	arg_4_0.dirty_ = true
	arg_4_0.curPageIndex_ = -1
	arg_4_0.pageIndexS_ = {
		weapon = 3,
		astrolabe = 5,
		skill = 2,
		property = 1,
		equip = 4
	}
	arg_4_0.prefabList_ = {
		"UI/MatrixHero/MatrixHeroAttributeMiniUI",
		"UI/Hero/HeroSkillPage",
		"UI/MatrixHero/MatrixHeroWeaponUI",
		"UI/MatrixHero/MatrixHeroEquipUI",
		"UI/MatrixHero/MatrixHeroAstrolabePage"
	}
	arg_4_0.ClassList_ = {
		MatrixHeroAttributePage,
		MatrixHeroSkillPage,
		MartixHeroWeaponPage,
		MatrixHeroEquipPage,
		MatrixHeroAstrolabePage
	}
end

function var_0_0.Init(arg_5_0)
	arg_5_0:InitUI()
	arg_5_0:AddUIListener()
end

function var_0_0.InitUI(arg_6_0)
	arg_6_0:BindCfgUI()

	arg_6_0.pages_ = {}
	arg_6_0.heroAvatarView_ = HeroAvatarView.New(arg_6_0, arg_6_0.displayGo_)

	arg_6_0.heroAvatarView_:SetShowInteractive(true)

	arg_6_0.toggles_ = {
		arg_6_0.toggle1_,
		arg_6_0.toggle2_,
		arg_6_0.toggle3_,
		arg_6_0.toggle4_,
		arg_6_0.toggle5_
	}
end

function var_0_0.AddUIListener(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.toggles_) do
		iter_7_1.onValueChanged:AddListener(function(arg_8_0)
			if arg_8_0 then
				arg_7_0:SwitchPage(iter_7_0)

				if arg_7_0.pages_[iter_7_0] then
					arg_7_0.pages_[iter_7_0]:SetMatirxHeroInfo(arg_7_0.curHeroId_)
				end
			end
		end)
	end
end

function var_0_0.SelectHero(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1 ~= arg_9_0.curHeroId_ and true or false

	if arg_9_0.curHeroId_ ~= nil and arg_9_0.curHeroId_ ~= arg_9_1 and arg_9_0.curPageIndex_ ~= 1 then
		arg_9_0.waitToPlayInteraction_ = true
	end

	arg_9_0.curHeroId_ = arg_9_1

	if arg_9_0.dirty_ then
		arg_9_0:SwitchPage(1)

		arg_9_0.dirty_ = false
	else
		arg_9_0:SwitchPage(arg_9_0.curPageIndex_)
	end

	arg_9_0:UpdateHeroView()

	arg_9_0.toggles_[arg_9_0.curPageIndex_].isOn = true
	arg_9_0.params_.heroId = arg_9_1

	if var_9_0 and arg_9_0.curPageIndex_ == arg_9_0.pageIndexS_.astrolabe then
		manager.audio:PlayEffect("ui_system", "astrolabe_appear", "")
	end
end

function var_0_0.SwitchPage(arg_10_0, arg_10_1)
	if arg_10_0.curPageIndex_ == arg_10_1 and not arg_10_0.dirty_ then
		return
	end

	arg_10_0.heroAvatarView_:SetShowInteractive(false)

	local var_10_0 = arg_10_0.pages_[arg_10_0.curPageIndex_]

	if var_10_0 then
		var_10_0:Hide()
	end

	local var_10_1 = arg_10_0.curPageIndex_

	arg_10_0.curPageIndex_ = arg_10_1

	if not arg_10_0.pages_[arg_10_1] then
		if arg_10_0.prefabList_[arg_10_1] and arg_10_0.ClassList_[arg_10_1] then
			local var_10_2 = Asset.Load(arg_10_0.prefabList_[arg_10_1])
			local var_10_3 = Object.Instantiate(var_10_2, arg_10_0.pageContainer_)

			arg_10_0.pages_[arg_10_1] = arg_10_0.ClassList_[arg_10_1].New(arg_10_0, var_10_3)

			arg_10_0:CheckPageEnter(arg_10_1)
		end
	else
		arg_10_0.pages_[arg_10_0.curPageIndex_]:Show()
	end

	if arg_10_0.curPageIndex_ == arg_10_0.pageIndexS_.astrolabe then
		manager.audio:PlayEffect("ui_system", "astrolabe_appear", "")
	end

	arg_10_0:UpdateAvatarView()

	if not arg_10_0.dirty_ and var_10_1 ~= nil and var_10_1 ~= arg_10_1 and arg_10_1 == 1 and arg_10_0.waitToPlayInteraction_ then
		if arg_10_0.heroAvatarView_ then
			arg_10_0.heroAvatarView_:PlayChangeRoleInteraction()
		end

		arg_10_0.waitToPlayInteraction_ = false
	end
end

function var_0_0.UpdateAvatarView(arg_11_0)
	SetActive(arg_11_0.m_weaponIcon.gameObject, false)

	if arg_11_0.curPageIndex_ == arg_11_0.pageIndexS_.astrolabe then
		arg_11_0.heroAvatarView_:ShowHeroModel(false)

		if arg_11_0.curPageIndex_ == arg_11_0.pageIndexS_.astrolabe then
			arg_11_0.heroAvatarView_:SetCameraToPage("heroAstrolabe")
		else
			arg_11_0.heroAvatarView_:SwitchCameraToCurrentHero(false)
		end
	elseif arg_11_0.curPageIndex_ == arg_11_0.pageIndexS_.equip then
		arg_11_0.heroAvatarView_:ShowHeroModel(false)
	elseif arg_11_0.curPageIndex_ == arg_11_0.pageIndexS_.weapon then
		arg_11_0.heroAvatarView_:ShowHeroModel(false)

		local var_11_0 = arg_11_0:GetHeroData(arg_11_0.curHeroId_):GetWeaponServantEffect()

		if var_11_0 ~= 0 then
			SetActive(arg_11_0.m_weaponIcon.gameObject, true)

			arg_11_0.m_weaponIcon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/WeaponServant/Portrait/" .. var_11_0)
		end
	else
		arg_11_0.heroAvatarView_:SetSkinId(arg_11_0:GetHeroSkin(arg_11_0.curHeroId_))
		arg_11_0.heroAvatarView_:ShowHeroModel(true)
		arg_11_0.heroAvatarView_:SwitchCameraToCurrentHero(false)
	end
end

function var_0_0.CheckPageEnter(arg_12_0, arg_12_1)
	if not arg_12_0.enteredPage_[arg_12_1] then
		arg_12_0.pages_[arg_12_1]:OnEnter()

		arg_12_0.enteredPage_[arg_12_1] = true
	end
end

function var_0_0.UpdateHeroView(arg_13_0)
	arg_13_0:UpdateAvatarView()

	for iter_13_0, iter_13_1 in pairs(arg_13_0.pages_) do
		iter_13_1:SetMatirxHeroInfo(arg_13_0.curHeroId_)
	end
end

function var_0_0.OnTop(arg_14_0)
	if arg_14_0.pages_ then
		for iter_14_0, iter_14_1 in pairs(arg_14_0.pages_) do
			iter_14_1:OnTop()
		end
	end

	if arg_14_0.heroAvatarView_ then
		arg_14_0.heroAvatarView_:OnTop()
	end

	arg_14_0:SelectHero(arg_14_0.params_.heroId)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_MATRIX_COIN,
		CurrencyConst.CURRENCY_TYPE_MATRIX_PT,
		CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION
	})
	manager.windowBar:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			pages = MatrixConst.MATRIX_GAME_HELP_PAGES
		}
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_COIN, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_PT, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION, true)
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.GoToSystem("/matrixBlank/matrixPrepare")
	end)
end

function var_0_0.OnBehind(arg_16_0)
	if arg_16_0.heroAvatarView_ then
		arg_16_0.heroAvatarView_:OnBehind()
	end
end

function var_0_0.OnEnter(arg_17_0)
	manager.ui:SetMainCamera("hero")

	arg_17_0.enteredPage_ = {}

	local var_17_0 = 1

	if arg_17_0.heroAvatarView_ then
		arg_17_0.heroAvatarView_:OnEnter()
	end

	for iter_17_0, iter_17_1 in pairs(arg_17_0.pages_) do
		arg_17_0:CheckPageEnter(iter_17_0)
	end

	arg_17_0:SelectHero(arg_17_0.params_.heroId)
end

function var_0_0.ConditionOK(arg_18_0)
	return true, ""
end

function var_0_0.OnMainHomeViewTop(arg_19_0)
	arg_19_0.dirty_ = true

	if arg_19_0.heroAvatarView_ then
		arg_19_0.heroAvatarView_:OnMainHomeViewTop()
	end
end

function var_0_0.OnExit(arg_20_0)
	arg_20_0:RemoveAllEventListener()

	if arg_20_0.heroAvatarView_ then
		arg_20_0.heroAvatarView_:OnExit()
	end

	if arg_20_0.pages_ then
		for iter_20_0, iter_20_1 in pairs(arg_20_0.pages_) do
			iter_20_1:OnExit()
		end
	end

	arg_20_0.curHeroId_ = nil

	if arg_20_0.talkTimer_ then
		arg_20_0.talkTimer_:Stop()

		arg_20_0.talkTimer_ = nil
	end

	HeroTools.StopTalk()
end

function var_0_0.Dispose(arg_21_0)
	arg_21_0:RemoveAllListeners()

	if arg_21_0.heroAvatarView_ then
		arg_21_0.heroAvatarView_:Dispose()

		arg_21_0.heroAvatarView_ = nil
	end

	if arg_21_0.pages_ then
		for iter_21_0, iter_21_1 in pairs(arg_21_0.pages_) do
			iter_21_1:Dispose()
		end

		arg_21_0.pages_ = nil
	end

	if arg_21_0.toggles_ then
		for iter_21_2, iter_21_3 in pairs(arg_21_0.toggles_) do
			iter_21_3.onValueChanged:RemoveAllListeners()
		end

		arg_21_0.toggles_ = nil
	end

	var_0_0.super.Dispose(arg_21_0)
end

function var_0_0.GetHeroData(arg_22_0, arg_22_1)
	return MatrixData:GetHeroData(arg_22_1)
end

function var_0_0.GetHeroSkin(arg_23_0, arg_23_1)
	return MatrixData:GetHeroSkin(arg_23_1)
end

return var_0_0
