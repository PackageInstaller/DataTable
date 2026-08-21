local var_0_0 = class("RandomHeroView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Random/RandomAssistantUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.btnCon_ = arg_4_0.conEx_:GetController("btn")
	arg_4_0.heroIdList_ = {}
	arg_4_0.heroHeadList_ = LuaList.New(handler(arg_4_0, arg_4_0.HeadRenderer), arg_4_0.uiList_, HeroLongHead)
	arg_4_0.filterView_ = NewHeroListFilterView.New(arg_4_0.filterGo_)

	arg_4_0.filterView_:SetListChangeHandler(handler(arg_4_0, arg_4_0.OnListChange))

	arg_4_0.emptyController_ = ControllerUtil.GetController(arg_4_0.uiList_.transform, "empty")
	arg_4_0.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	arg_4_0.sceneToggle_ = RandomSettingToggleItem.New(arg_4_0.sceneToggleGo_)
	arg_4_0.aniToggle_ = RandomSettingToggleItem.New(arg_4_0.aniToggleGo_)
	arg_4_0.openToggle_ = RandomSettingToggleItem.New(arg_4_0.openToggleGo_)
	arg_4_0.openCon_ = arg_4_0.conEx_:GetController("open")
	arg_4_0.dlcAnimCon_ = arg_4_0.conEx_:GetController("dlcAnim")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0.openToggle_:SetCallback(function()
		local var_6_0 = PlayerData:IsRandomHero()

		if not var_6_0 and arg_5_0:HasNoSelection() then
			ShowTips("RANDOM_MODE_SETTING_TIPS1")

			return
		end

		PlayerAction.SetIsRandomHero(not var_6_0, function()
			arg_5_0:RefreshRight()
		end)
	end)
	arg_5_0:AddBtnListener(arg_5_0.randomModeBtn_, nil, function()
		if not PlayerData:IsRandomHero() then
			ShowTips("RANDOM_MODE_SETTING_TIPS2")

			return
		end

		JumpTools.GoToSystem("randomHeroModePop", {
			type = PlayerData:GetRandomHeroMode()
		})
	end)
	arg_5_0.sceneToggle_:SetCallback(function()
		if not PlayerData:IsRandomHero() then
			ShowTips("RANDOM_MODE_SETTING_TIPS2")

			return
		end

		PlayerAction.SetIsRandomHeroUseDlcScene(not PlayerData:IsRandomHeroUseDlcScene(), function()
			arg_5_0:RefreshRight()
		end)
	end)
	arg_5_0.aniToggle_:SetCallback(function()
		if not PlayerData:IsRandomHero() then
			ShowTips("RANDOM_MODE_SETTING_TIPS2")

			return
		end

		if not arg_5_0:CanSwitchDlcAnim() then
			ShowTips("RANDOM_MODE_SETTING_TIPS3")

			return
		end

		PlayerAction.SetIsRandomHeroShowEachDebutAnim(not PlayerData:IsRandomHeroShowEachDebutAnim(), function()
			arg_5_0:RefreshRight()
		end)
	end)
end

function var_0_0.HeadRenderer(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.heroIdList_[arg_13_1]

	arg_13_2.gameObject_.name = tostring(var_13_0)

	arg_13_2:SetProxy(arg_13_0.heroViewProxy_)
	arg_13_2:SetHeroId(var_13_0, arg_13_0.type_)
	arg_13_2:SetSelected(arg_13_0.selected_[var_13_0])

	arg_13_2.nameText_.text = GetI18NText(HeroCfg[var_13_0].name)

	arg_13_2:RegisterClickListener(function()
		local var_14_0 = not arg_13_0.selected_[var_13_0]

		if not var_14_0 and #arg_13_0.selections_ == 1 and PlayerData:IsRandomHero() then
			PlayerAction.SetIsRandomHero(false, function()
				arg_13_0:RefreshRight()
			end)
		elseif var_14_0 and not PlayerData:IsRandomHero() then
			PlayerAction.SetIsRandomHero(true, function()
				arg_13_0:RefreshRight()
			end)
		end

		arg_13_0.selected_[var_13_0] = var_14_0

		arg_13_2:SetSelected(var_14_0)

		if var_14_0 then
			table.insert(arg_13_0.selections_, var_13_0)
		else
			table.removebyvalue(arg_13_0.selections_, var_13_0)
		end

		arg_13_0:RefreshLeft()
	end)
end

function var_0_0.OnListChange(arg_17_0, arg_17_1)
	arg_17_0.heroIdList_ = arg_17_1

	arg_17_0.heroHeadList_:StartScroll(#arg_17_0.heroIdList_)

	if #arg_17_0.heroIdList_ > 0 then
		arg_17_0.emptyController_:SetSelectedState("false")
	else
		arg_17_0.emptyController_:SetSelectedState("true")
	end
end

function var_0_0.OnHeroSort(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
	arg_18_0.filterView_:RefreshSort(arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
end

function var_0_0.OnEnter(arg_19_0)
	arg_19_0.settingData_ = SettingData:GetHomeSceneSettingData()

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistInfoCallBack(function()
		local var_20_0 = GetTips("RANDOM_ASSIST_TIPS1")

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "RANDOM_ASSIST_TIPS1",
			iconColor = Color(1, 1, 1),
			title = GetTips("FUNCTION_DESC"),
			content = var_20_0
		})
	end)
	manager.windowBar:RegistHomeCallBack(function()
		arg_19_0:SaveSettings(function()
			gameContext:Go("/home", nil, nil, true)
		end)
	end)
	arg_19_0:RefreshUI()
end

function var_0_0.OnTop(arg_23_0)
	arg_23_0:RefreshRight()
end

function var_0_0.CameraEnter(arg_24_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		0,
		0
	})
	manager.heroRaiseTrack.raiseModel:Finish()
end

function var_0_0.SaveSettings(arg_25_0, arg_25_1)
	arg_25_0.selections_ = {}

	for iter_25_0, iter_25_1 in pairs(arg_25_0.selected_) do
		if iter_25_1 then
			table.insert(arg_25_0.selections_, iter_25_0)
		end
	end

	table.sort(arg_25_0.selections_)

	if not table.equal(arg_25_0.selections_, arg_25_0.oldSelections_, "all") then
		PlayerAction.SetRandomHeroList(arg_25_0.selections_, function()
			PlayerTools.UpdateRandomData(HomeSceneSettingConst.RANDOM_MODE.EACH_ENTER)

			if arg_25_1 then
				arg_25_1()
			end
		end)
	elseif arg_25_1 then
		arg_25_1()
	end
end

function var_0_0.OnExit(arg_27_0)
	arg_27_0:SaveSettings()

	if arg_27_0.filterView_ and arg_27_0.filterView_.OnExit then
		arg_27_0.filterView_:OnExit()
	end

	if #arg_27_0.heroIdList_ <= 0 then
		HeroData:ResetSortValue()
		arg_27_0.filterView_:Reset()
	end

	CommonFilterData:ClearFilter(Filter_Root_Define.Hero_Filter_List.filter_id)
	manager.windowBar:HideBar()
end

function var_0_0.RefreshUI(arg_28_0)
	arg_28_0:RefreshList()
	arg_28_0:RefreshLeft()
	arg_28_0:RefreshRight()
end

function var_0_0.RefreshRight(arg_29_0)
	arg_29_0.sceneToggle_:SetValue(PlayerData:IsRandomHeroUseDlcScene())
	arg_29_0.aniToggle_:SetValue(PlayerData:IsRandomHeroShowEachDebutAnim())
	arg_29_0.openToggle_:SetValue(PlayerData:IsRandomHero())
	arg_29_0.openCon_:SetSelectedState(PlayerData:IsRandomHero() and "on" or "off")
	arg_29_0.dlcAnimCon_:SetSelectedState(arg_29_0:CanSwitchDlcAnim() and "enable" or "disable")

	local var_29_0 = PlayerData:GetRandomHeroMode()

	if var_29_0 == HomeSceneSettingConst.RANDOM_MODE.EACH_DAY then
		arg_29_0.randomModeText_.text = GetTips("RANDOM_MODE_SETTING_PERDAY")
	elseif var_29_0 == HomeSceneSettingConst.RANDOM_MODE.EACH_LOGIN then
		arg_29_0.randomModeText_.text = GetTips("RANDOM_MODE_SETTING_PERTIME")
	elseif var_29_0 == HomeSceneSettingConst.RANDOM_MODE.EACH_ENTER then
		arg_29_0.randomModeText_.text = GetTips("RANDOM_MODE_SETTING_PERPLAY")
	else
		arg_29_0.randomModeText_.text = "unknown"
	end
end

function var_0_0.RefreshList(arg_30_0)
	arg_30_0.selections_ = clone(PlayerData:GetRandomHeroList())
	arg_30_0.oldSelections_ = clone(arg_30_0.selections_)
	arg_30_0.selected_ = {}

	for iter_30_0, iter_30_1 in ipairs(arg_30_0.selections_) do
		arg_30_0.selected_[iter_30_1] = true
	end

	local var_30_0 = HeroTools.Sort(HeroData:GetHeroList())

	arg_30_0.filterView_:OnEnter(arg_30_0.heroViewProxy_)
	arg_30_0.filterView_:SetExtraSorter(function(arg_31_0, arg_31_1)
		local var_31_0 = arg_30_0.selected_[arg_31_0.id]

		if var_31_0 ~= arg_30_0.selected_[arg_31_1.id] then
			return true, var_31_0
		end

		return false, false
	end)
	arg_30_0.filterView_:SetHeroIdList(var_30_0)
	arg_30_0.heroHeadList_:StartScroll(#arg_30_0.heroIdList_, 1)
end

function var_0_0.RefreshLeft(arg_32_0)
	arg_32_0.numText_.text = #arg_32_0.selections_
end

function var_0_0.Dispose(arg_33_0)
	if arg_33_0.heroHeadList_ then
		arg_33_0.heroHeadList_:Dispose()

		arg_33_0.heroHeadList_ = nil
	end

	if arg_33_0.filterView_ then
		arg_33_0.filterView_:Dispose()

		arg_33_0.filterView_ = nil
	end

	if arg_33_0.sceneToggle_ then
		arg_33_0.sceneToggle_:Dispose()

		arg_33_0.sceneToggle_ = nil
	end

	if arg_33_0.aniToggle_ then
		arg_33_0.aniToggle_:Dispose()

		arg_33_0.aniToggle_ = nil
	end

	if arg_33_0.openToggle_ then
		arg_33_0.openToggle_:Dispose()

		arg_33_0.openToggle_ = nil
	end

	var_0_0.super.Dispose(arg_33_0)
end

function var_0_0.HasNoSelection(arg_34_0)
	for iter_34_0, iter_34_1 in pairs(arg_34_0.selected_) do
		if iter_34_1 then
			return false
		end
	end

	return true
end

function var_0_0.CanSwitchDlcAnim(arg_35_0)
	return PlayerData:IsRandomHeroUseDlcScene() and PlayerData:GetRandomHeroMode() == HomeSceneSettingConst.RANDOM_MODE.EACH_ENTER
end

return var_0_0
