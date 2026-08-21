local var_0_0 = class("HeroPreviewChangeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/CharacterGuideUI/CharacterPreviewUI"
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

	arg_4_0.heroInfoView_ = HeroPreviewInfoView.New(arg_4_0.heroInfoGo_)
	arg_4_0.emptyController_ = ControllerUtil.GetController(arg_4_0.uiListGo_.transform, "empty")
	arg_4_0.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.PREVIEW)
end

function var_0_0.OnListChange(arg_5_0, arg_5_1)
	arg_5_0.heroIdList_ = arg_5_1

	arg_5_0.heroHeadList_:StartScroll(#arg_5_1)

	if #arg_5_0.heroIdList_ > 0 then
		arg_5_0.emptyController_:SetSelectedState("false")
		arg_5_0:SelectHero(arg_5_0.heroIdList_[1])
	else
		arg_5_0.emptyController_:SetSelectedState("true")
	end
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.infoBtn_, nil, function()
		arg_6_0:Go("/heroPreviewMain", {
			isEnter = true,
			isDraw = true,
			hid = arg_6_0.curHeroId_
		})
	end)
end

function var_0_0.HeadRenderer(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.heroIdList_[arg_8_1]

	arg_8_2.gameObject_.name = tostring(var_8_0)

	arg_8_2:SetProxy(arg_8_0.heroViewProxy_)
	arg_8_2:SetHeroId(var_8_0, arg_8_0.type_)
	arg_8_2:SetRedPointEnable(arg_8_0.heroViewProxy_.showHeroHeadRedPoint)
	arg_8_2:SetSelected(arg_8_2.heroId_ == arg_8_0.curHeroId_)
	arg_8_2:SetRareIcon(HeroCfg[var_8_0].rare)
	arg_8_2:RegisterClickListener(function()
		arg_8_0:SelectHero(arg_8_2.heroId_)
		OperationRecorder.Record("hero", "selectHero")
	end)
end

function var_0_0.SelectHero(arg_10_0, arg_10_1)
	arg_10_0.curHeroId_ = arg_10_1
	arg_10_0.curHeroInfo_ = HeroData:GetHeroList()[arg_10_0.curHeroId_]
	arg_10_0.heroCfg_ = HeroCfg[arg_10_1]

	for iter_10_0, iter_10_1 in pairs(arg_10_0.heroHeadList_:GetItemList()) do
		iter_10_1:SetSelected(iter_10_1.heroId_ == arg_10_1)
	end

	arg_10_0.heroInfoView_:SetHeroInfo(arg_10_0.curHeroInfo_)
	arg_10_0:UpdateHeroView()
	arg_10_0:UpdateAvatarView()
end

function var_0_0.UpdateHeroView(arg_11_0)
	return
end

function var_0_0.UpdateAvatarView(arg_12_0)
	local var_12_0 = arg_12_0.heroViewProxy_:GetHeroUsingSkinInfo(arg_12_0.curHeroId_).id

	manager.heroRaiseTrack:SetModelState(var_12_0)
end

function var_0_0.CameraEnter(arg_13_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		0,
		0
	}, arg_13_0.displayGo_)
	manager.heroRaiseTrack:SetAstrolableAtive(false)
end

function var_0_0.OnTop(arg_14_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_15_0)
	local var_15_0 = HeroTools.Sort(HeroData:GetHeroList(), true)

	arg_15_0.filterView_:OnEnter(arg_15_0.heroViewProxy_)
	arg_15_0.filterView_:SetHeroIdList(var_15_0)

	local var_15_1 = 1

	if arg_15_0.params_.index then
		var_15_1 = arg_15_0.params_.index
	else
		for iter_15_0, iter_15_1 in ipairs(arg_15_0.heroIdList_) do
			if iter_15_1 == arg_15_0.curHeroId_ then
				var_15_1 = iter_15_0

				break
			end
		end
	end

	arg_15_0:SelectHero(arg_15_0.heroIdList_[var_15_1])
	arg_15_0.heroHeadList_:StartScroll(#arg_15_0.heroIdList_, var_15_1)
end

function var_0_0.OnMainHomeViewTop(arg_16_0)
	if arg_16_0.filterView_ then
		arg_16_0.filterView_:Reset()
	end

	arg_16_0.pos_ = nil
end

function var_0_0.OnExit(arg_17_0)
	manager.windowBar:HideBar()

	if #arg_17_0.heroIdList_ <= 0 then
		HeroData:ResetSortValue()
		arg_17_0.filterView_:Reset()
	end

	arg_17_0.params_.index = table.keyof(arg_17_0.heroIdList_, arg_17_0.curHeroId_)
	arg_17_0.pos_ = arg_17_0.heroHeadList_:GetScrolledPosition()

	arg_17_0.heroInfoView_:OnExit()
	manager.heroRaiseTrack:CancelAllAsyncLoadModelOp()
end

function var_0_0.Dispose(arg_18_0)
	if arg_18_0.heroHeadList_ then
		arg_18_0.heroHeadList_:Dispose()

		arg_18_0.heroHeadList_ = nil
	end

	if arg_18_0.filterView_ then
		arg_18_0.filterView_:Dispose()

		arg_18_0.filterView_ = nil
	end

	if arg_18_0.heroInfoView_ then
		arg_18_0.heroInfoView_:Dispose()

		arg_18_0.heroInfoView_ = nil
	end

	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
