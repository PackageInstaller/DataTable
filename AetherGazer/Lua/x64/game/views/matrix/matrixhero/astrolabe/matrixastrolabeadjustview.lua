local var_0_0 = class("AstrolabeAdjustView", ReduxView)

function var_0_0.UIBackCount(arg_1_0)
	return 3
end

function var_0_0.UIName(arg_2_0)
	return "UI/MatrixHero/MatrixAstrolabeAdjustUI"
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_4_0)
	return
end

function var_0_0.Init(arg_5_0)
	arg_5_0:InitUI()
	arg_5_0:AddListeners()
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.overviewBtn_, nil, function()
		JumpTools.OpenPageByJump("matrixOrigin/matrixMiniHero")
	end)
end

function var_0_0.InitUI(arg_8_0)
	arg_8_0:BindCfgUI()

	arg_8_0.infoSGo_ = {}
	arg_8_0.astrolabeMessageView_ = MatrixAstrolabeInfoView.New(arg_8_0, arg_8_0.messageGo_)
end

function var_0_0.OnTop(arg_9_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_MATRIX_PT,
		CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION
	})
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.OpenPageByJump("matrixOrigin/matrixMiniHero")
	end)
end

function var_0_0.SelectItem(arg_11_0, arg_11_1)
	if arg_11_0.lastSelectItem_ then
		arg_11_0.lastSelectItem_:ShowSelect(false)
	end

	local var_11_0 = arg_11_1:GetItemInfo()

	arg_11_1:ShowSelect(true)
	arg_11_0.astrolabeMessageView_:RefreshUI(var_11_0, arg_11_0.heroInfo_.servantId)

	arg_11_0.lastSelectItem_ = arg_11_1
end

function var_0_0.RefreshUI(arg_12_0)
	local var_12_0 = arg_12_0:GetHeroData(arg_12_0.params_.heroId)
	local var_12_1 = var_12_0:GetStandardId()
	local var_12_2

	if var_12_0:GetIsOwnerHero() then
		local var_12_3 = var_12_0:GetEntrySnapShot()

		var_12_2 = GetPracticalData(var_12_3)
	else
		var_12_2 = GetVirtualData(var_12_1)
	end

	arg_12_0.heroInfo_ = var_12_2
	arg_12_0.heroInfo_.using_astrolabe = var_12_0:GetAstrolabeEffectList()
	arg_12_0.heroInfo_.unlocked_astrolabe = HeroAstrolabeCfg.all
	arg_12_0.heroInfo_.servantId = var_12_0:GetWeaponServantEffect()

	arg_12_0:RefreshAstrolabeInfo()
end

function var_0_0.RefreshAstrolabeInfo(arg_13_0)
	if arg_13_0.heroInfo_ then
		arg_13_0.equipNum_ = #arg_13_0.heroInfo_.using_astrolabe

		arg_13_0:RefreshAstrolabeView()
	end
end

function var_0_0.RefreshAstrolabeView(arg_14_0)
	if arg_14_0.heroInfo_ then
		arg_14_0.currentRace_ = arg_14_0.heroInfo_.id

		if arg_14_0.astrolabeInfoView_ and arg_14_0.lastRace_ and arg_14_0.lastRace_ ~= arg_14_0.currentRace_ then
			SetActive(arg_14_0.infoSGo_[arg_14_0.lastRace_], false)
			arg_14_0.astrolabeInfoView_:Dispose()

			arg_14_0.astrolabeInfoView_ = nil
		end

		if arg_14_0.astrolabeInfoView_ == nil then
			if arg_14_0.infoSGo_[arg_14_0.currentRace_] == nil then
				arg_14_0.infoSGo_[arg_14_0.currentRace_] = Object.Instantiate(Asset.Load("UI/Astrolabe/Race_" .. arg_14_0.currentRace_), arg_14_0.infoTrs_)
			end

			SetActive(arg_14_0.infoSGo_[arg_14_0.currentRace_], true)

			arg_14_0.astrolabeInfoView_ = arg_14_0:GetHeroAstrolabeInfoView().New(arg_14_0, arg_14_0.infoSGo_[arg_14_0.currentRace_])

			arg_14_0.astrolabeInfoView_:RegistCallBack(handler(arg_14_0, arg_14_0.SelectItem))

			arg_14_0.lastRace_ = arg_14_0.currentRace_
		end

		arg_14_0.astrolabeInfoView_:RefreshUI(arg_14_0.heroInfo_)
	end
end

function var_0_0.GetHeroAstrolabeInfoView(arg_15_0)
	return HeroAstrolabeInfoView
end

function var_0_0.OnEnter(arg_16_0)
	arg_16_0:RefreshUI()

	local var_16_0 = arg_16_0.params_.selectPos

	if var_16_0 and var_16_0[1] ~= 0 then
		arg_16_0:SelectItem(arg_16_0.astrolabeInfoView_:GetItem(var_16_0[1], var_16_0[2]))
	else
		arg_16_0:SelectItem(arg_16_0.astrolabeInfoView_:GetFirstSelectItem())
	end
end

function var_0_0.OnExit(arg_17_0)
	if arg_17_0.lastSelectItem_ then
		arg_17_0.lastSelectItem_:ShowSelect(false)

		arg_17_0.lastSelectItem_ = nil
	end

	if arg_17_0.astrolabeInfoView_ then
		arg_17_0.astrolabeInfoView_:OnExit()
	end

	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_18_0)
	var_0_0.super.Dispose(arg_18_0)

	if arg_18_0.astrolabeInfoView_ then
		arg_18_0.astrolabeInfoView_:Dispose()

		arg_18_0.astrolabeInfoView_ = nil
	end

	if arg_18_0.astrolabeMessageView_ then
		arg_18_0.astrolabeMessageView_:Dispose()

		arg_18_0.astrolabeMessageView_ = nil
	end
end

function var_0_0.GetHeroData(arg_19_0, arg_19_1)
	return MatrixData:GetHeroData(arg_19_1)
end

return var_0_0
