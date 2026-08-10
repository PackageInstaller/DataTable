local var_0_0 = class("MatrixHeroView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/MatrixHero/MatrixHeroUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	arg_3_0.dirty_ = true
	arg_3_0.curPageIndex_ = 1
	arg_3_0.pageIndexS_ = {
		skill = 2,
		property = 1
	}
	arg_3_0.prefabList_ = {
		[1] = "UI/MatrixHero/MatrixHeroAttributeUI",
		[2] = "UI/Hero/HeroSkillPage"
	}
	arg_3_0.ClassList_ = {
		MatrixHeroAttributePageCom,
		MatrixHeroSkillPageCom
	}
	arg_3_0.pageConditionList_ = {
		handler(arg_3_0, arg_3_0.ConditionOK),
		(handler(arg_3_0, arg_3_0.ConditionOK))
	}
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.mainPageController_ = ControllerUtil.GetController(arg_5_0.gameObject_.transform, "mainPage")
	arg_5_0.pages_ = {}
	arg_5_0.shortScrollHelper_ = LuaList.New(handler(arg_5_0, arg_5_0.ShortHeadRenderer), arg_5_0.heroShortListGo_, MatrixHeroHead)
	arg_5_0.completeScrollHelper_ = LuaList.New(handler(arg_5_0, arg_5_0.LongHeadRenderer), arg_5_0.heroCompleteListGo_, MatrixHeroHead)
	arg_5_0.curScrollHelper_ = arg_5_0.shortScrollHelper_
	arg_5_0.heroAvatarView_ = HeroAvatarView.New(arg_5_0, arg_5_0.displayGo_)

	arg_5_0.heroAvatarView_:SetShowInteractive(true)

	arg_5_0.toggles_ = {
		arg_5_0.toggle1_,
		arg_5_0.toggle2_
	}
	arg_5_0.infoView = MatrixHeroAttributePageCom.New(arg_5_0, arg_5_0.infoViewGo_)
end

function var_0_0.ShortHeadRenderer(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.heroList_[arg_6_1]

	arg_6_2.gameObject_.name = tostring(var_6_0)

	arg_6_2:SetSize("short")
	arg_6_2:SetHeroId(var_6_0)
	arg_6_2:SetSelected(var_6_0 == arg_6_0.curHeroId_)
	arg_6_2:RegisterClickListener(function()
		arg_6_0:SelectHero(var_6_0)
	end)
end

function var_0_0.LongHeadRenderer(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.heroList_[arg_8_1]

	arg_8_2.gameObject_.name = tostring(var_8_0)

	arg_8_2:SetSize("long")
	arg_8_2:SetHeroId(var_8_0)
	arg_8_2:SetSelected(var_8_0 == arg_8_0.curHeroId_)
	arg_8_2:RegisterClickListener(function()
		arg_8_0:SelectHero(var_8_0)
	end)
end

function var_0_0.SelectHero(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1 ~= arg_10_0.curHeroId_ and true or false

	if arg_10_0.curHeroId_ ~= nil and arg_10_0.curHeroId_ ~= arg_10_1 and arg_10_0.curPageIndex_ ~= 1 then
		arg_10_0.waitToPlayInteraction_ = true
	end

	arg_10_0.curHeroId_ = arg_10_1

	for iter_10_0, iter_10_1 in pairs(arg_10_0.curScrollHelper_:GetItemList()) do
		iter_10_1:SetSelected(iter_10_1:GetHeroStandardId() == arg_10_1)
	end

	if arg_10_0.dirty_ then
		arg_10_0:SwitchPage(1)

		arg_10_0.dirty_ = false
	else
		arg_10_0:SwitchPage(arg_10_0.curPageIndex_)
	end

	arg_10_0:UpdateHeroView()

	arg_10_0.toggles_[arg_10_0.curPageIndex_].isOn = true
	arg_10_0.params_.hid = arg_10_1

	if var_10_0 then
		if arg_10_0.pages_[arg_10_0.curPageIndex_] then
			arg_10_0.pages_[arg_10_0.curPageIndex_]:PlayEnterAni()
		end

		if arg_10_0.curPageIndex_ == arg_10_0.pageIndexS_.astrolabe then
			manager.audio:PlayEffect("ui_system", "astrolabe_appear", "")
		end
	end
end

function var_0_0.SwitchToDetail(arg_11_0)
	arg_11_0.mainPageController_:SetSelectedState("detail")

	local var_11_0 = table.indexof(arg_11_0.heroList_, arg_11_0.curHeroId_)

	if var_11_0 then
		arg_11_0.shortScrollHelper_:StartScroll(#arg_11_0.heroList_, var_11_0)
	end

	arg_11_0.playableDirector_.time = 0

	arg_11_0.playableDirector_:Play()
end

function var_0_0.AddUIListener(arg_12_0)
	arg_12_0:AddBtnListener(arg_12_0.detailBtn_, nil, function()
		arg_12_0:SwitchToDetail()
	end)
	arg_12_0:AddBtnListener(arg_12_0.allHeroBtn_, nil, function()
		arg_12_0.mainPageController_:SetSelectedState("list")

		local var_14_0 = table.indexof(arg_12_0.heroList_, arg_12_0.curHeroId_)

		if var_14_0 then
			arg_12_0.completeScrollHelper_:StartScroll(#arg_12_0.heroList_, var_14_0)
		end
	end)
	arg_12_0.mainPageController_:AddSelectChangeListener(function(arg_15_0)
		if arg_12_0.mainPageController_:GetSelectedState() == "detail" then
			arg_12_0.curScrollHelper_ = arg_12_0.shortScrollHelper_
		else
			arg_12_0.curScrollHelper_ = arg_12_0.completeScrollHelper_
		end

		arg_12_0:SelectHero(arg_12_0.curHeroId_)
	end)

	for iter_12_0, iter_12_1 in pairs(arg_12_0.toggles_) do
		iter_12_1.onValueChanged:AddListener(function(arg_16_0)
			if arg_16_0 then
				arg_12_0:SwitchPage(iter_12_0)

				if arg_12_0.pages_[iter_12_0] then
					arg_12_0.pages_[iter_12_0]:SetMatirxHeroInfo(arg_12_0.curHeroId_)
				end

				print(iter_12_0)
			end
		end)
	end
end

function var_0_0.SwitchPage(arg_17_0, arg_17_1)
	local var_17_0 = true
	local var_17_1 = ""

	if arg_17_0.pageConditionList_[arg_17_1] then
		var_17_0, var_17_1 = arg_17_0.pageConditionList_[arg_17_1]()
	end

	if not var_17_0 then
		ShowTips(var_17_1)

		arg_17_0.toggles_[arg_17_0.curPageIndex_].isOn = true

		return
	end

	if arg_17_0.curPageIndex_ == arg_17_1 and not arg_17_0.dirty_ then
		return
	end

	arg_17_0.heroAvatarView_:SetShowInteractive(false)

	local var_17_2 = arg_17_0.pages_[arg_17_0.curPageIndex_]

	if var_17_2 then
		var_17_2:Hide()
	end

	local var_17_3 = arg_17_0.curPageIndex_

	arg_17_0.curPageIndex_ = arg_17_1

	if not arg_17_0.pages_[arg_17_1] then
		if arg_17_0.prefabList_[arg_17_1] and arg_17_0.ClassList_[arg_17_1] then
			local var_17_4 = Asset.Load(arg_17_0.prefabList_[arg_17_1])
			local var_17_5 = Object.Instantiate(var_17_4, arg_17_0.pageContainer_)

			arg_17_0.pages_[arg_17_1] = arg_17_0.ClassList_[arg_17_1].New(arg_17_0, var_17_5)

			arg_17_0:CheckPageEnter(arg_17_1)
		end
	else
		arg_17_0.pages_[arg_17_0.curPageIndex_]:Show()
	end

	if arg_17_0.curPageIndex_ == arg_17_0.pageIndexS_.astrolabe then
		manager.audio:PlayEffect("ui_system", "astrolabe_appear", "")
	end

	arg_17_0:UpdateAvatarView()

	if not arg_17_0.dirty_ and var_17_3 ~= nil and var_17_3 ~= arg_17_1 and arg_17_1 == 1 and arg_17_0.waitToPlayInteraction_ then
		if arg_17_0.heroAvatarView_ then
			arg_17_0.heroAvatarView_:PlayChangeRoleInteraction()
		end

		arg_17_0.waitToPlayInteraction_ = false
	end

	arg_17_0:RecordStay(var_17_3)
end

function var_0_0.UpdateAvatarView(arg_18_0)
	if arg_18_0.mainPageController_:GetSelectedState() == "detail" and arg_18_0.curPageIndex_ == arg_18_0.pageIndexS_.astrolabe then
		arg_18_0.heroAvatarView_:ShowHeroModel(false)

		if arg_18_0.curPageIndex_ == arg_18_0.pageIndexS_.astrolabe then
			arg_18_0.heroAvatarView_:SetCameraToPage("heroAstrolabe")
		else
			arg_18_0.heroAvatarView_:SwitchCameraToCurrentHero(false)
		end
	else
		local var_18_0 = HeroStandardSystemCfg[arg_18_0.curHeroId_]

		arg_18_0.heroAvatarView_:SetSkinId(MatrixData:GetHeroSkin(var_18_0.hero_id))
		arg_18_0.heroAvatarView_:ShowHeroModel(true)
		arg_18_0.heroAvatarView_:SwitchCameraToCurrentHero(false)
	end
end

function var_0_0.CheckPageEnter(arg_19_0, arg_19_1)
	if not arg_19_0.enteredPage_[arg_19_1] then
		arg_19_0.pages_[arg_19_1]:OnEnter()

		arg_19_0.enteredPage_[arg_19_1] = true
	end
end

function var_0_0.UpdateHeroView(arg_20_0)
	arg_20_0:UpdateAvatarView()

	for iter_20_0, iter_20_1 in pairs(arg_20_0.pages_) do
		iter_20_1:SetMatirxHeroInfo(arg_20_0.curHeroId_)
	end

	if arg_20_0.mainPageController_:GetSelectedState() == "list" then
		arg_20_0.infoView:SetMatirxHeroInfo(arg_20_0.curHeroId_)
	end
end

function var_0_0.OnTop(arg_21_0)
	if arg_21_0.pages_ then
		for iter_21_0, iter_21_1 in pairs(arg_21_0.pages_) do
			iter_21_1:OnTop()
		end
	end

	if arg_21_0.heroAvatarView_ then
		arg_21_0.heroAvatarView_:OnTop()
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
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
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_PT, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION, true)
end

function var_0_0.OnBehind(arg_22_0)
	if arg_22_0.heroAvatarView_ then
		arg_22_0.heroAvatarView_:OnBehind()
	end
end

function var_0_0.OnEnter(arg_23_0)
	arg_23_0.heroList_ = MatrixData:GetReadyHeroList()

	manager.windowBar:RegistBackCallBack(function()
		if arg_23_0.mainPageController_:GetSelectedState() == "list" then
			arg_23_0:SwitchToDetail()
		else
			JumpTools:Back()
		end
	end)
	manager.ui:SetMainCamera("hero")

	arg_23_0.enteredPage_ = {}

	local var_23_0 = 1

	if arg_23_0.heroAvatarView_ then
		if arg_23_0.params_.isEnter then
			arg_23_0:OnMainHomeViewTop()

			arg_23_0.params_.isEnter = nil
		end

		arg_23_0.heroAvatarView_:OnEnter()
	end

	for iter_23_0, iter_23_1 in pairs(arg_23_0.pages_) do
		arg_23_0:CheckPageEnter(iter_23_0)
	end

	local var_23_1 = #arg_23_0.heroList_

	if arg_23_0.params_.hid then
		arg_23_0:SelectHero(arg_23_0.params_.hid)
	else
		arg_23_0:SelectHero(arg_23_0.heroList_[1])
	end

	for iter_23_2 = 1, #arg_23_0.heroList_ do
		if arg_23_0.curHeroId_ == arg_23_0.heroList_[iter_23_2] then
			var_23_0 = iter_23_2

			break
		end
	end

	local var_23_2 = "detail"

	arg_23_0.mainPageController_:SetSelectedState(var_23_2)

	if arg_23_0.mainPageController_:GetSelectedState() == var_23_2 then
		arg_23_0.shortScrollHelper_:StartScroll(var_23_1, var_23_0)
	else
		arg_23_0.completeScrollHelper_:StartScroll(var_23_1, var_23_0)
	end
end

function var_0_0.ConditionOK(arg_25_0)
	return true, ""
end

function var_0_0.OnMainHomeViewTop(arg_26_0)
	arg_26_0.dirty_ = true

	if arg_26_0.heroAvatarView_ then
		arg_26_0.heroAvatarView_:OnMainHomeViewTop()
	end
end

function var_0_0.OnExit(arg_27_0)
	arg_27_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()

	if arg_27_0.heroAvatarView_ then
		arg_27_0.heroAvatarView_:OnExit()
	end

	if arg_27_0.pages_ then
		for iter_27_0, iter_27_1 in pairs(arg_27_0.pages_) do
			iter_27_1:OnExit()
		end
	end

	arg_27_0.curHeroId_ = nil

	if arg_27_0.talkTimer_ then
		arg_27_0.talkTimer_:Stop()

		arg_27_0.talkTimer_ = nil
	end

	HeroTools.StopTalk()
	arg_27_0:RecordStay(arg_27_0.curPageIndex_)
end

function var_0_0.Dispose(arg_28_0)
	arg_28_0.mainPageController_:RemoveAllListeners()
	arg_28_0:RemoveAllListeners()

	if arg_28_0.shortScrollHelper_ then
		arg_28_0.shortScrollHelper_:Dispose()

		arg_28_0.shortScrollHelper_ = nil
	end

	if arg_28_0.completeScrollHelper_ then
		arg_28_0.completeScrollHelper_:Dispose()

		arg_28_0.completeScrollHelper_ = nil
	end

	if arg_28_0.heroAvatarView_ then
		arg_28_0.heroAvatarView_:Dispose()

		arg_28_0.heroAvatarView_ = nil
	end

	if arg_28_0.pages_ then
		for iter_28_0, iter_28_1 in pairs(arg_28_0.pages_) do
			iter_28_1:Dispose()
		end

		arg_28_0.pages_ = nil
	end

	if arg_28_0.toggles_ then
		for iter_28_2, iter_28_3 in pairs(arg_28_0.toggles_) do
			iter_28_3.onValueChanged:RemoveAllListeners()
		end

		arg_28_0.toggles_ = nil
	end

	var_0_0.super.Dispose(arg_28_0)
end

function var_0_0.RecordStay(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0:GetStayTime()

	if var_29_0 == 0 then
		return
	end

	local var_29_1 = 0

	if arg_29_1 == arg_29_0.pageIndexS_.skill then
		var_29_1 = 30106
	elseif arg_29_1 == arg_29_0.pageIndexS_.astrolabe then
		var_29_1 = 30107
	end

	OperationRecorder.RecordStayView("STAY_VIEW_MATRIX_HERO", var_29_0, var_29_1)
	arg_29_0:UpdateLastOpenTime()
end

return var_0_0
