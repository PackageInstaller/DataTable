local RandomSceneView = class("RandomSceneView", ReduxView)

function RandomSceneView:UIName()
	return "Widget/System/Random/RandomSceneUI"
end

function RandomSceneView:UIParent()
	return manager.ui.uiMain.transform
end

function RandomSceneView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function RandomSceneView:InitUI()
	self:BindCfgUI()

	self.btnCon_ = self.conEx_:GetController("btn")
	self.itemList_ = LuaList.New(handler(self, self.IndexItem), self.uiList_, RandomSceneItem)
	self.list_ = {}
	self.musicToggle_ = RandomSettingToggleItem.New(self.musicToggleGo_)
	self.openToggle_ = RandomSettingToggleItem.New(self.openToggleGo_)
	self.openCon_ = self.conEx_:GetController("open")
end

function RandomSceneView:IndexItem(arg_5_1, arg_5_2)
	local var_5_0 = self.list_[arg_5_1]

	arg_5_2:RefreshData(self.list_[arg_5_1], self.data_[self.list_[arg_5_1]], self.selected_[self.list_[arg_5_1]])
	arg_5_2:RegistClickFunc(function()
		local var_6_0 = not self.selected_[var_5_0]

		if not not self.selected_[var_5_0] and #self.selections_ == 1 and HomeSceneSettingData:IsRandomScene() then
			HomeSceneSettingAction.SetIsRandomScene(false, function()
				self:RefreshRight()
			end)
		elseif var_6_0 and not HomeSceneSettingData:IsRandomScene() then
			HomeSceneSettingAction.SetIsRandomScene(true, function()
				self:RefreshRight()
			end)
		end

		self.selected_[var_5_0] = var_6_0

		arg_5_2:RefreshData(var_5_0, self.data_[var_5_0], var_6_0)

		if var_6_0 then
			table.insert(self.selections_, var_5_0)
		else
			table.removebyvalue(self.selections_, var_5_0)
		end

		self:RefreshLeft()
	end)
end

function RandomSceneView:AddUIListeners()
	self.openToggle_:SetCallback(function()
		local var_10_0 = HomeSceneSettingData:IsRandomScene()

		if not var_10_0 and self:HasNoSelection() then
			ShowTips("RANDOM_MODE_SETTING_TIPS4")

			return
		end

		HomeSceneSettingAction.SetIsRandomScene(not var_10_0, function()
			self:RefreshRight()
		end)
	end)
	self:AddBtnListener(self.randomModeBtn_, nil, function()
		if not HomeSceneSettingData:IsRandomScene() then
			ShowTips("RANDOM_MODE_SETTING_TIPS5")

			return
		end

		JumpTools.GoToSystem("randomSceneModePop", {
			type = HomeSceneSettingData:GetRandomMode()
		})
	end)
	self.musicToggle_:SetCallback(function()
		if not HomeSceneSettingData:IsRandomScene() then
			ShowTips("RANDOM_MODE_SETTING_TIPS5")

			return
		end

		SettingAction.ChangeHomeSceneSetting("home_scene_scene_bgm", 1 - self.settingData_.home_scene_scene_bgm)
		self:RefreshRight()
	end)
end

function RandomSceneView:OnEnter()
	self.settingData_ = SettingData:GetHomeSceneSettingData()

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistInfoCallBack(function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "RANDOM_SCENE_TIPS1",
			iconColor = Color(1, 1, 1),
			title = GetTips("FUNCTION_DESC"),
			content = GetTips("RANDOM_SCENE_TIPS1")
		})
	end)
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.Back(1, {
			_BackFromRandomScene = true
		})
	end)
	manager.windowBar:RegistHomeCallBack(function()
		self:SaveSettings(function()
			gameContext:Go("/home", nil, nil, true)
		end)
	end)
	self:RefreshUI()
	self:StartTime()
end

function RandomSceneView:OnTop()
	self:RefreshRight()
end

function RandomSceneView:CameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		0,
		0
	})
	manager.heroRaiseTrack.raiseModel:Finish()
end

function RandomSceneView:SaveSettings(arg_21_1)
	self.selections_ = {}

	for iter_21_0, iter_21_1 in pairs(self.selected_) do
		if iter_21_1 then
			table.insert(self.selections_, iter_21_0)
		end
	end

	table.sort(self.selections_)

	if not table.equal(self.selections_, self.oldSelections_, "all") then
		HomeSceneSettingAction.SetRandomSceneList(self.selections_, function()
			PlayerTools.UpdateRandomData(HomeSceneSettingConst.RANDOM_MODE.EACH_ENTER)

			if arg_21_1 then
				arg_21_1()
			end
		end)
	elseif arg_21_1 then
		arg_21_1()
	end
end

function RandomSceneView:OnExit()
	self:StopTimer()
	self:SaveSettings()
	manager.windowBar:HideBar()
end

function RandomSceneView:RefreshUI()
	self:RefreshList()
	self:RefreshLeft()
	self:RefreshRight()
end

function RandomSceneView:RefreshRight()
	self.musicToggle_:SetValue(self.settingData_.home_scene_scene_bgm == 1)
	self.openToggle_:SetValue(HomeSceneSettingData:IsRandomScene())
	self.openCon_:SetSelectedState(HomeSceneSettingData:IsRandomScene() and "on" or "off")

	local var_25_0 = HomeSceneSettingData:GetRandomMode()

	self.randomModeText_.text = var_25_0 == HomeSceneSettingConst.RANDOM_MODE.EACH_DAY and GetTips("RANDOM_MODE_SETTING_PERDAY") or var_25_0 == HomeSceneSettingConst.RANDOM_MODE.EACH_LOGIN and GetTips("RANDOM_MODE_SETTING_PERTIME") or var_25_0 == HomeSceneSettingConst.RANDOM_MODE.EACH_ENTER and GetTips("RANDOM_MODE_SETTING_PERPLAY") or "unknown"
end

function RandomSceneView:RefreshList()
	self.selections_ = clone(HomeSceneSettingData:GetRandomSceneList())
	self.oldSelections_ = clone(self.selections_)
	self.selected_ = {}

	for iter_26_0, iter_26_1 in ipairs(self.selections_) do
		self.selected_[iter_26_1] = true
	end

	self.data_ = {}
	self.list_ = {}

	for iter_26_2, iter_26_3 in ipairs(HomeSceneSettingCfg.all) do
		if HomeSceneSettingCfg[iter_26_3].limit_display == 1 then
			local var_26_0 = HomeSceneSettingData:GetUsedState(iter_26_3)

			if var_26_0 == SceneConst.HOME_SCENE_TYPE.UNLOCK or var_26_0 == SceneConst.HOME_SCENE_TYPE.TRIAL then
				table.insert(self.list_, iter_26_3)

				self.data_[iter_26_3] = var_26_0
			end
		end
	end

	table.sort(self.list_, function(arg_27_0, arg_27_1)
		if self.selected_[arg_27_0] ~= self.selected_[arg_27_1] then
			return self.selected_[arg_27_0]
		end

		if self.data_[arg_27_0] ~= self.data_[arg_27_1] then
			return self.data_[arg_27_0] > self.data_[arg_27_1]
		end

		return arg_27_0 < arg_27_1
	end)
	self.itemList_:StartScroll(#self.list_, table.indexof(self.list_, self.curSceneID_))
end

function RandomSceneView:RefreshLeft()
	self.numText_.text = #self.selections_
end

function RandomSceneView:StartTime()
	self:StopTimer()

	local var_29_0 = manager.time:GetServerTime()

	self.timer_ = Timer.New(function()
		if #self.oldSelections_ ~= #HomeSceneSettingData:GetRandomSceneList() then
			self:RefreshList()
		end
	end, 1.5, -1)

	self.timer_:Start()
end

function RandomSceneView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function RandomSceneView:Dispose()
	if self.itemList_ then
		self.itemList_:Dispose()

		self.itemList_ = nil
	end

	if self.musicToggle_ then
		self.musicToggle_:Dispose()

		self.musicToggle_ = nil
	end

	if self.openToggle_ then
		self.openToggle_:Dispose()

		self.openToggle_ = nil
	end

	RandomSceneView.super.Dispose(self)
end

function RandomSceneView:HasNoSelection()
	for iter_33_0, iter_33_1 in pairs(self.selected_) do
		if iter_33_1 then
			return false
		end
	end

	return true
end

return RandomSceneView
