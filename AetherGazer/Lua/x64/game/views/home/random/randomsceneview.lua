local var_0_0 = class("RandomSceneView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Random/RandomSceneUI"
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
	arg_4_0.itemList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.uiList_, RandomSceneItem)
	arg_4_0.list_ = {}
	arg_4_0.musicToggle_ = RandomSettingToggleItem.New(arg_4_0.musicToggleGo_)
	arg_4_0.openToggle_ = RandomSettingToggleItem.New(arg_4_0.openToggleGo_)
	arg_4_0.openCon_ = arg_4_0.conEx_:GetController("open")
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.list_[arg_5_1]

	arg_5_2:RefreshData(var_5_0, arg_5_0.data_[var_5_0], arg_5_0.selected_[var_5_0])
	arg_5_2:RegistClickFunc(function()
		local var_6_0 = not arg_5_0.selected_[var_5_0]

		if not var_6_0 and #arg_5_0.selections_ == 1 and HomeSceneSettingData:IsRandomScene() then
			HomeSceneSettingAction.SetIsRandomScene(false, function()
				arg_5_0:RefreshRight()
			end)
		elseif var_6_0 and not HomeSceneSettingData:IsRandomScene() then
			HomeSceneSettingAction.SetIsRandomScene(true, function()
				arg_5_0:RefreshRight()
			end)
		end

		arg_5_0.selected_[var_5_0] = var_6_0

		arg_5_2:RefreshData(var_5_0, arg_5_0.data_[var_5_0], var_6_0)

		if var_6_0 then
			table.insert(arg_5_0.selections_, var_5_0)
		else
			table.removebyvalue(arg_5_0.selections_, var_5_0)
		end

		arg_5_0:RefreshLeft()
	end)
end

function var_0_0.AddUIListeners(arg_9_0)
	arg_9_0.openToggle_:SetCallback(function()
		local var_10_0 = HomeSceneSettingData:IsRandomScene()

		if not var_10_0 and arg_9_0:HasNoSelection() then
			ShowTips("RANDOM_MODE_SETTING_TIPS4")

			return
		end

		HomeSceneSettingAction.SetIsRandomScene(not var_10_0, function()
			arg_9_0:RefreshRight()
		end)
	end)
	arg_9_0:AddBtnListener(arg_9_0.randomModeBtn_, nil, function()
		if not HomeSceneSettingData:IsRandomScene() then
			ShowTips("RANDOM_MODE_SETTING_TIPS5")

			return
		end

		JumpTools.GoToSystem("randomSceneModePop", {
			type = HomeSceneSettingData:GetRandomMode()
		})
	end)
	arg_9_0.musicToggle_:SetCallback(function()
		if not HomeSceneSettingData:IsRandomScene() then
			ShowTips("RANDOM_MODE_SETTING_TIPS5")

			return
		end

		local var_13_0 = "home_scene_scene_bgm"
		local var_13_1 = 1 - arg_9_0.settingData_[var_13_0]

		SettingAction.ChangeHomeSceneSetting(var_13_0, var_13_1)
		arg_9_0:RefreshRight()
	end)
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0.settingData_ = SettingData:GetHomeSceneSettingData()

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistInfoCallBack(function()
		local var_15_0 = GetTips("RANDOM_SCENE_TIPS1")

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "RANDOM_SCENE_TIPS1",
			iconColor = Color(1, 1, 1),
			title = GetTips("FUNCTION_DESC"),
			content = var_15_0
		})
	end)
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.Back(1, {
			_BackFromRandomScene = true
		})
	end)
	manager.windowBar:RegistHomeCallBack(function()
		arg_14_0:SaveSettings(function()
			gameContext:Go("/home", nil, nil, true)
		end)
	end)
	arg_14_0:RefreshUI()
	arg_14_0:StartTime()
end

function var_0_0.OnTop(arg_19_0)
	arg_19_0:RefreshRight()
end

function var_0_0.CameraEnter(arg_20_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		0,
		0
	})
	manager.heroRaiseTrack.raiseModel:Finish()
end

function var_0_0.SaveSettings(arg_21_0, arg_21_1)
	arg_21_0.selections_ = {}

	for iter_21_0, iter_21_1 in pairs(arg_21_0.selected_) do
		if iter_21_1 then
			table.insert(arg_21_0.selections_, iter_21_0)
		end
	end

	table.sort(arg_21_0.selections_)

	if not table.equal(arg_21_0.selections_, arg_21_0.oldSelections_, "all") then
		HomeSceneSettingAction.SetRandomSceneList(arg_21_0.selections_, function()
			PlayerTools.UpdateRandomData(HomeSceneSettingConst.RANDOM_MODE.EACH_ENTER)

			if arg_21_1 then
				arg_21_1()
			end
		end)
	elseif arg_21_1 then
		arg_21_1()
	end
end

function var_0_0.OnExit(arg_23_0)
	arg_23_0:StopTimer()
	arg_23_0:SaveSettings()
	manager.windowBar:HideBar()
end

function var_0_0.RefreshUI(arg_24_0)
	arg_24_0:RefreshList()
	arg_24_0:RefreshLeft()
	arg_24_0:RefreshRight()
end

function var_0_0.RefreshRight(arg_25_0)
	arg_25_0.musicToggle_:SetValue(arg_25_0.settingData_.home_scene_scene_bgm == 1)
	arg_25_0.openToggle_:SetValue(HomeSceneSettingData:IsRandomScene())
	arg_25_0.openCon_:SetSelectedState(HomeSceneSettingData:IsRandomScene() and "on" or "off")

	local var_25_0 = HomeSceneSettingData:GetRandomMode()

	if var_25_0 == HomeSceneSettingConst.RANDOM_MODE.EACH_DAY then
		arg_25_0.randomModeText_.text = GetTips("RANDOM_MODE_SETTING_PERDAY")
	elseif var_25_0 == HomeSceneSettingConst.RANDOM_MODE.EACH_LOGIN then
		arg_25_0.randomModeText_.text = GetTips("RANDOM_MODE_SETTING_PERTIME")
	elseif var_25_0 == HomeSceneSettingConst.RANDOM_MODE.EACH_ENTER then
		arg_25_0.randomModeText_.text = GetTips("RANDOM_MODE_SETTING_PERPLAY")
	else
		arg_25_0.randomModeText_.text = "unknown"
	end
end

function var_0_0.RefreshList(arg_26_0)
	arg_26_0.selections_ = clone(HomeSceneSettingData:GetRandomSceneList())
	arg_26_0.oldSelections_ = clone(arg_26_0.selections_)
	arg_26_0.selected_ = {}

	for iter_26_0, iter_26_1 in ipairs(arg_26_0.selections_) do
		arg_26_0.selected_[iter_26_1] = true
	end

	arg_26_0.data_ = {}
	arg_26_0.list_ = {}

	for iter_26_2, iter_26_3 in ipairs(HomeSceneSettingCfg.all) do
		if HomeSceneSettingCfg[iter_26_3].limit_display == 1 then
			local var_26_0 = HomeSceneSettingData:GetUsedState(iter_26_3)

			if var_26_0 == SceneConst.HOME_SCENE_TYPE.UNLOCK or var_26_0 == SceneConst.HOME_SCENE_TYPE.TRIAL then
				table.insert(arg_26_0.list_, iter_26_3)

				arg_26_0.data_[iter_26_3] = var_26_0
			end
		end
	end

	table.sort(arg_26_0.list_, function(arg_27_0, arg_27_1)
		local var_27_0 = arg_26_0.selected_[arg_27_0]

		if var_27_0 ~= arg_26_0.selected_[arg_27_1] then
			return var_27_0
		end

		if arg_26_0.data_[arg_27_0] ~= arg_26_0.data_[arg_27_1] then
			return arg_26_0.data_[arg_27_0] > arg_26_0.data_[arg_27_1]
		end

		return arg_27_0 < arg_27_1
	end)
	arg_26_0.itemList_:StartScroll(#arg_26_0.list_, table.indexof(arg_26_0.list_, arg_26_0.curSceneID_))
end

function var_0_0.RefreshLeft(arg_28_0)
	arg_28_0.numText_.text = #arg_28_0.selections_
end

function var_0_0.StartTime(arg_29_0)
	arg_29_0:StopTimer()

	local var_29_0 = manager.time:GetServerTime()

	arg_29_0.timer_ = Timer.New(function()
		local var_30_0 = HomeSceneSettingData:GetRandomSceneList()

		if #arg_29_0.oldSelections_ ~= #var_30_0 then
			arg_29_0:RefreshList()
		end
	end, 1.5, -1)

	arg_29_0.timer_:Start()
end

function var_0_0.StopTimer(arg_31_0)
	if arg_31_0.timer_ then
		arg_31_0.timer_:Stop()

		arg_31_0.timer_ = nil
	end
end

function var_0_0.Dispose(arg_32_0)
	if arg_32_0.itemList_ then
		arg_32_0.itemList_:Dispose()

		arg_32_0.itemList_ = nil
	end

	if arg_32_0.musicToggle_ then
		arg_32_0.musicToggle_:Dispose()

		arg_32_0.musicToggle_ = nil
	end

	if arg_32_0.openToggle_ then
		arg_32_0.openToggle_:Dispose()

		arg_32_0.openToggle_ = nil
	end

	var_0_0.super.Dispose(arg_32_0)
end

function var_0_0.HasNoSelection(arg_33_0)
	for iter_33_0, iter_33_1 in pairs(arg_33_0.selected_) do
		if iter_33_1 then
			return false
		end
	end

	return true
end

return var_0_0
