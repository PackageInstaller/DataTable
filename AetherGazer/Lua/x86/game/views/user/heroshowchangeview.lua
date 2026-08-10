local var_0_0 = class("HeroShowChangeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/UserInfor/HeroShowChangeUI"
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
	arg_4_0.showController_ = arg_4_0.controller_:GetController("show")
	arg_4_0.nameDisplayController = arg_4_0.controller_:GetController("nameDisplay")
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
	arg_6_0:AddBtnListener(arg_6_0.infoBtn_, nil, function()
		arg_6_0:Go("/newHero", {
			isEnter = true,
			hid = arg_6_0.curHeroId_,
			type = HeroConst.HERO_DATA_TYPE.DEFAULT
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.showBtn_, nil, function()
		arg_6_0:SetHeroShowList(arg_6_0.lastHeroID_, arg_6_0.curHeroId_)
		arg_6_0:Back()
		SendMessageManagerToSDK("changePosterGirl")
	end)
	arg_6_0:AddBtnListener(arg_6_0.unshowBtn_, nil, function()
		arg_6_0:SetHeroShowList(arg_6_0.curHeroId_, nil)
		arg_6_0:Back()
		SendMessageManagerToSDK("changePosterGirl")
	end)
end

function var_0_0.OnChangePosterGirl(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0.params_.lastView == "home" then
		JumpTools.OpenPageByJump("/home", {
			changePoster = true
		})
	else
		arg_10_0:Back()
	end
end

function var_0_0.HeadRenderer(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.heroIdList_[arg_11_1]

	arg_11_2.gameObject_.name = tostring(var_11_0)

	arg_11_2:SetProxy(arg_11_0.heroViewProxy_)
	arg_11_2:SetHeroId(var_11_0, arg_11_0.type_)
	arg_11_2:SetRedPointEnable(arg_11_0.heroViewProxy_.showHeroHeadRedPoint)
	arg_11_2:SetSelected(arg_11_2.heroId_ == arg_11_0.curHeroId_)
	arg_11_2:RegisterClickListener(function()
		arg_11_0:SelectHero(arg_11_2.heroId_)
		OperationRecorder.Record("hero", "selectHero")
	end)
	arg_11_2:SetLable(arg_11_0:CheckHeroIsShow(var_11_0) and GetTips("IS_IN_SHOW") or nil)
end

function var_0_0.SelectHero(arg_13_0, arg_13_1)
	arg_13_0.curHeroId_ = arg_13_1
	arg_13_0.curHeroInfo_ = HeroData:GetHeroList()[arg_13_0.curHeroId_]
	arg_13_0.heroCfg_ = HeroCfg[arg_13_1]

	for iter_13_0, iter_13_1 in pairs(arg_13_0.heroHeadList_:GetItemList()) do
		iter_13_1:SetSelected(iter_13_1.heroId_ == arg_13_1)
	end

	arg_13_0.showController_:SetSelectedState(tostring(arg_13_0:CheckHeroIsShow(arg_13_1)))

	if arg_13_0.heroViewProxy_:IsHeroOath(arg_13_1) then
		if arg_13_0.heroViewProxy_:HasCustomNickName(arg_13_1) then
			arg_13_0.nameDisplayController:SetSelectedState("oathCustomName")
		else
			arg_13_0.nameDisplayController:SetSelectedState("oath")
		end
	else
		arg_13_0.nameDisplayController:SetSelectedState("normal")
	end

	arg_13_0:UpdateHeroView()
	arg_13_0:UpdateAvatarView()
end

function var_0_0.UpdateHeroView(arg_14_0)
	arg_14_0.nameText_.text = GetI18NText(arg_14_0.heroCfg_.name)
	arg_14_0.subNameText_.text = GetI18NText(arg_14_0.heroViewProxy_:GetHeroName(arg_14_0.curHeroId_))
	arg_14_0.fightPowerText_.text = getBattlePower(HeroData:GetHeroData(arg_14_0.curHeroId_))
end

function var_0_0.UpdateBar(arg_15_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.UpdateAvatarView(arg_16_0)
	manager.heroRaiseTrack:SetModelStateByHeroProxy(arg_16_0.heroViewProxy_, arg_16_0.curHeroId_)
end

function var_0_0.CameraEnter(arg_17_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		0,
		0
	}, false)
	manager.heroRaiseTrack:SetAstrolableAtive(false)
end

function var_0_0.OnEnter(arg_18_0)
	local var_18_0 = HeroTools.Sort(HeroData:GetHeroList())

	arg_18_0.filterView_:OnEnter(arg_18_0.heroViewProxy_)
	arg_18_0.filterView_:SetHeroIdList(var_18_0)
	arg_18_0.filterView_:SetExtraSorter(function(arg_19_0, arg_19_1)
		local var_19_0 = arg_18_0:CheckHeroIsShow(arg_19_0.id)
		local var_19_1 = arg_18_0:CheckHeroIsShow(arg_19_1.id)

		if var_19_0 ~= var_19_1 then
			return true, var_19_0 and not var_19_1
		end

		return false, false
	end)
	arg_18_0:UpdateBar()

	arg_18_0.lastHeroID_ = arg_18_0.params_.heroID

	local var_18_1 = 1

	if arg_18_0.params_.index then
		var_18_1 = arg_18_0.params_.index
	end

	arg_18_0.filterView_:SetHeroIdList(arg_18_0.heroIdList_, arg_18_0.type_)
	arg_18_0:SelectHero(arg_18_0.heroIdList_[var_18_1])
	arg_18_0.heroHeadList_:StartScroll(#arg_18_0.heroIdList_, var_18_1)
end

function var_0_0.CheckHeroIsShow(arg_20_0, arg_20_1)
	local var_20_0 = PlayerData:GetHeroShowList()

	for iter_20_0, iter_20_1 in pairs(var_20_0) do
		if iter_20_1 == arg_20_1 then
			return true
		end
	end

	return false
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

function var_0_0.SetHeroShowList(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_1 == nil and arg_26_2 == nil then
		return
	end

	local var_26_0 = PlayerData:GetHeroShowList()

	if arg_26_1 == nil then
		for iter_26_0 = 1, #var_26_0 do
			if var_26_0[iter_26_0] == arg_26_2 then
				table.remove(var_26_0, iter_26_0)
			end
		end

		table.insert(var_26_0, arg_26_2)
	elseif arg_26_2 == nil then
		for iter_26_1 = 1, #var_26_0 do
			if var_26_0[iter_26_1] == arg_26_1 then
				table.remove(var_26_0, iter_26_1)

				break
			end
		end
	else
		local var_26_1 = 0

		for iter_26_2 = 1, #var_26_0 do
			if var_26_0[iter_26_2] == arg_26_2 then
				var_26_1 = iter_26_2
			end
		end

		for iter_26_3 = 1, #var_26_0 do
			if var_26_0[iter_26_3] == arg_26_1 then
				if var_26_1 == 0 then
					var_26_0[iter_26_3] = arg_26_2
				else
					var_26_0[iter_26_3], var_26_0[var_26_1] = var_26_0[var_26_1], var_26_0[iter_26_3]
				end
			end
		end
	end

	PlayerAction.ChangeHeros(var_26_0)
end

return var_0_0
