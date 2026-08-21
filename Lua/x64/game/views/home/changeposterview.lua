local var_0_0 = class("ChangePosterView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero/HeroChangeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.heroHeadList_ = LuaList.New(handler(arg_4_0, arg_4_0.HeadRenderer), arg_4_0.uiListGo_, HeroLongHead)
	arg_4_0.filterView_ = NewHeroListFilterView.New(arg_4_0.filterGo_)

	arg_4_0.filterView_:SetListChangeHandler(handler(arg_4_0, arg_4_0.OnListChange))

	arg_4_0.emptyController_ = ControllerUtil.GetController(arg_4_0.uiListGo_.transform, "empty")
	arg_4_0.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
end

function var_0_0.OnListChange(arg_5_0, arg_5_1)
	arg_5_0.heroIdList_ = arg_5_1

	arg_5_0.heroHeadList_:StartScroll(#arg_5_0.heroIdList_)

	if #arg_5_0.heroIdList_ > 0 then
		arg_5_0.emptyController_:SetSelectedState("false")
		arg_5_0:SelectHero(arg_5_0.heroIdList_[1])
	else
		arg_5_0.emptyController_:SetSelectedState("true")
	end
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.showBtn_, nil, function()
		if PlayerData:IsRandomHero() then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("RANDOM_ASSIST_TIPS"),
				OkCallback = function()
					PlayerAction.SetIsRandomHero(false, function()
						return
					end)
					PlayerAction.ChangePosterGirl(arg_6_0.curHeroId_)
				end
			})
		else
			PlayerAction.ChangePosterGirl(arg_6_0.curHeroId_)
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.skinBtn_, nil, function()
		arg_6_0:Go("/heroSkin", {
			heroID = arg_6_0.curHeroId_
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.randomHeroBtn_, nil, function()
		JumpTools.GoToSystem("/randomHero", {})
	end)
end

function var_0_0.OnChangePosterGirl(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0.params_.lastView == "home" then
		JumpTools.OpenPageByJump("/home", {
			changePoster = true
		})
	else
		arg_12_0:Back()
	end
end

function var_0_0.HeadRenderer(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.heroIdList_[arg_13_1]

	arg_13_2.gameObject_.name = tostring(var_13_0)

	arg_13_2:SetProxy(arg_13_0.heroViewProxy_)
	arg_13_2:SetHeroId(var_13_0, arg_13_0.type_)
	arg_13_2:SetRedPointEnable(arg_13_0.heroViewProxy_.showHeroHeadRedPoint)
	arg_13_2:SetSelected(arg_13_2.heroId_ == arg_13_0.curHeroId_)
	arg_13_2:RegisterClickListener(function()
		arg_13_0:SelectHero(arg_13_2.heroId_)
		OperationRecorder.Record("hero", "selectHero")
	end)
end

function var_0_0.SelectHero(arg_15_0, arg_15_1)
	arg_15_0.curHeroId_ = arg_15_1
	arg_15_0.curHeroInfo_ = HeroData:GetHeroList()[arg_15_0.curHeroId_]
	arg_15_0.heroCfg_ = HeroCfg[arg_15_1]

	for iter_15_0, iter_15_1 in pairs(arg_15_0.heroHeadList_:GetItemList()) do
		iter_15_1:SetSelected(iter_15_1.heroId_ == arg_15_1)
	end

	arg_15_0:UpdateHeroView()
	arg_15_0:UpdateAvatarView()
end

function var_0_0.UpdateHeroView(arg_16_0)
	arg_16_0.nameText_.text = GetI18NText(arg_16_0.heroCfg_.name)
	arg_16_0.subNameText_.text = HeroTools.GetHeroName(arg_16_0.curHeroId_)
	arg_16_0.fightPowerText_.text = getBattlePower(HeroData:GetHeroData(arg_16_0.curHeroId_))
end

function var_0_0.UpdateBar(arg_17_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.UpdateAvatarView(arg_18_0)
	local var_18_0 = arg_18_0.heroViewProxy_:GetHeroUsingSkinInfo(arg_18_0.curHeroId_).id

	manager.heroRaiseTrack:SetModelState(var_18_0)
end

function var_0_0.CameraEnter(arg_19_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		0,
		0
	}, arg_19_0.displayGo_)
end

function var_0_0.OnEnter(arg_20_0)
	local var_20_0 = HeroTools.Sort(HeroData:GetHeroList())

	arg_20_0.filterView_:OnEnter(arg_20_0.heroViewProxy_)
	arg_20_0.filterView_:SetHeroIdList(var_20_0)
	arg_20_0:UpdateBar()

	local var_20_1 = SkinCfg[PlayerData:GetPosterGirlHeroSkinId()].hero
	local var_20_2 = 1

	if arg_20_0.params_.index then
		var_20_2 = arg_20_0.params_.index
		var_20_1 = arg_20_0.heroIdList_[var_20_2]
	else
		for iter_20_0, iter_20_1 in ipairs(arg_20_0.heroIdList_) do
			if iter_20_1 == var_20_1 then
				var_20_2 = iter_20_0

				break
			end
		end
	end

	arg_20_0:SelectHero(var_20_1)
	arg_20_0.heroHeadList_:StartScroll(#arg_20_0.heroIdList_, var_20_2)
end

function var_0_0.OnMainHomeViewTop(arg_21_0)
	if arg_21_0.filterView_ then
		arg_21_0.filterView_:Reset()
	end

	arg_21_0.pos_ = nil
end

function var_0_0.OnHeroSort(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5)
	arg_22_0.filterView_:RefreshSort(arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5)
end

function var_0_0.OnExit(arg_23_0)
	if arg_23_0.filterView_ and arg_23_0.filterView_.OnExit then
		arg_23_0.filterView_:OnExit()
	end

	manager.windowBar:HideBar()

	if #arg_23_0.heroIdList_ <= 0 then
		HeroData:ResetSortValue()
		arg_23_0.filterView_:Reset()
	end

	arg_23_0.params_.index = table.keyof(arg_23_0.heroIdList_, arg_23_0.curHeroId_)
	arg_23_0.pos_ = arg_23_0.heroHeadList_:GetScrolledPosition()
end

function OnCameraEnter()
	return
end

function var_0_0.Dispose(arg_25_0)
	if arg_25_0.heroHeadList_ then
		arg_25_0.heroHeadList_:Dispose()

		arg_25_0.heroHeadList_ = nil
	end

	if arg_25_0.filterView_ then
		arg_25_0.filterView_:Dispose()

		arg_25_0.filterView_ = nil
	end

	var_0_0.super.Dispose(arg_25_0)
end

return var_0_0
