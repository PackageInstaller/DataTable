local RandomHeroView = class("RandomHeroView", ReduxView)

function RandomHeroView:UIName()
	return "Widget/System/Random/RandomAssistantUI"
end

function RandomHeroView:UIParent()
	return manager.ui.uiMain.transform
end

function RandomHeroView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function RandomHeroView:InitUI()
	self:BindCfgUI()

	self.btnCon_ = self.conEx_:GetController("btn")
	self.heroIdList_ = {}
	self.heroHeadList_ = LuaList.New(handler(self, self.HeadRenderer), self.uiList_, HeroLongHead)
	self.filterView_ = NewHeroListFilterView.New(self.filterGo_)

	self.filterView_:SetListChangeHandler(handler(self, self.OnListChange))

	self.emptyController_ = ControllerUtil.GetController(self.uiList_.transform, "empty")
	self.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	self.sceneToggle_ = RandomSettingToggleItem.New(self.sceneToggleGo_)
	self.aniToggle_ = RandomSettingToggleItem.New(self.aniToggleGo_)
	self.openToggle_ = RandomSettingToggleItem.New(self.openToggleGo_)
	self.openCon_ = self.conEx_:GetController("open")
	self.dlcAnimCon_ = self.conEx_:GetController("dlcAnim")
end

function RandomHeroView:AddUIListeners()
	self.openToggle_:SetCallback(function()
		local var_6_0 = PlayerData:IsRandomHero()

		if not var_6_0 and self:HasNoSelection() then
			ShowTips("RANDOM_MODE_SETTING_TIPS1")

			return
		end

		PlayerAction.SetIsRandomHero(not var_6_0, function()
			self:RefreshRight()
		end)
	end)
	self:AddBtnListener(self.randomModeBtn_, nil, function()
		if not PlayerData:IsRandomHero() then
			ShowTips("RANDOM_MODE_SETTING_TIPS2")

			return
		end

		JumpTools.GoToSystem("randomHeroModePop", {
			type = PlayerData:GetRandomHeroMode()
		})
	end)
	self.sceneToggle_:SetCallback(function()
		if not PlayerData:IsRandomHero() then
			ShowTips("RANDOM_MODE_SETTING_TIPS2")

			return
		end

		PlayerAction.SetIsRandomHeroUseDlcScene(not PlayerData:IsRandomHeroUseDlcScene(), function()
			self:RefreshRight()
		end)
	end)
	self.aniToggle_:SetCallback(function()
		if not PlayerData:IsRandomHero() then
			ShowTips("RANDOM_MODE_SETTING_TIPS2")

			return
		end

		if not self:CanSwitchDlcAnim() then
			ShowTips("RANDOM_MODE_SETTING_TIPS3")

			return
		end

		PlayerAction.SetIsRandomHeroShowEachDebutAnim(not PlayerData:IsRandomHeroShowEachDebutAnim(), function()
			self:RefreshRight()
		end)
	end)
end

function RandomHeroView:HeadRenderer(arg_13_1, arg_13_2)
	local var_13_0 = self.heroIdList_[arg_13_1]

	arg_13_2.gameObject_.name = tostring(self.heroIdList_[arg_13_1])

	arg_13_2:SetProxy(self.heroViewProxy_)
	arg_13_2:SetHeroId(self.heroIdList_[arg_13_1], self.type_)
	arg_13_2:SetSelected(self.selected_[self.heroIdList_[arg_13_1]])

	arg_13_2.nameText_.text = GetI18NText(HeroCfg[self.heroIdList_[arg_13_1]].name)

	arg_13_2:RegisterClickListener(function()
		local var_14_0 = not self.selected_[var_13_0]

		if not not self.selected_[var_13_0] and #self.selections_ == 1 and PlayerData:IsRandomHero() then
			PlayerAction.SetIsRandomHero(false, function()
				self:RefreshRight()
			end)
		elseif var_14_0 and not PlayerData:IsRandomHero() then
			PlayerAction.SetIsRandomHero(true, function()
				self:RefreshRight()
			end)
		end

		self.selected_[var_13_0] = var_14_0

		arg_13_2:SetSelected(var_14_0)

		if var_14_0 then
			table.insert(self.selections_, var_13_0)
		else
			table.removebyvalue(self.selections_, var_13_0)
		end

		self:RefreshLeft()
	end)
end

function RandomHeroView:OnListChange(arg_17_1)
	self.heroIdList_ = arg_17_1

	self.heroHeadList_:StartScroll(#self.heroIdList_)

	if #self.heroIdList_ > 0 then
		self.emptyController_:SetSelectedState("false")
	else
		self.emptyController_:SetSelectedState("true")
	end
end

function RandomHeroView:OnHeroSort(arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
	self.filterView_:RefreshSort(arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
end

function RandomHeroView:OnEnter()
	self.settingData_ = SettingData:GetHomeSceneSettingData()

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistInfoCallBack(function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "RANDOM_ASSIST_TIPS1",
			iconColor = Color(1, 1, 1),
			title = GetTips("FUNCTION_DESC"),
			content = GetTips("RANDOM_ASSIST_TIPS1")
		})
	end)
	manager.windowBar:RegistHomeCallBack(function()
		self:SaveSettings(function()
			gameContext:Go("/home", nil, nil, true)
		end)
	end)
	self:RefreshUI()
end

function RandomHeroView:OnTop()
	self:RefreshRight()
end

function RandomHeroView:CameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		0,
		0
	})
	manager.heroRaiseTrack.raiseModel:Finish()
end

function RandomHeroView:SaveSettings(arg_25_1)
	self.selections_ = {}

	for iter_25_0, iter_25_1 in pairs(self.selected_) do
		if iter_25_1 then
			table.insert(self.selections_, iter_25_0)
		end
	end

	table.sort(self.selections_)

	if not table.equal(self.selections_, self.oldSelections_, "all") then
		PlayerAction.SetRandomHeroList(self.selections_, function()
			PlayerTools.UpdateRandomData(HomeSceneSettingConst.RANDOM_MODE.EACH_ENTER)

			if arg_25_1 then
				arg_25_1()
			end
		end)
	elseif arg_25_1 then
		arg_25_1()
	end
end

function RandomHeroView:OnExit()
	self:SaveSettings()

	if self.filterView_ and self.filterView_.OnExit then
		self.filterView_:OnExit()
	end

	if #self.heroIdList_ <= 0 then
		HeroData:ResetSortValue()
		self.filterView_:Reset()
	end

	CommonFilterData:ClearFilter(Filter_Root_Define.Hero_Filter_List.filter_id)
	manager.windowBar:HideBar()
end

function RandomHeroView:RefreshUI()
	self:RefreshList()
	self:RefreshLeft()
	self:RefreshRight()
end

function RandomHeroView:RefreshRight()
	self.sceneToggle_:SetValue(PlayerData:IsRandomHeroUseDlcScene())
	self.aniToggle_:SetValue(PlayerData:IsRandomHeroShowEachDebutAnim())
	self.openToggle_:SetValue(PlayerData:IsRandomHero())
	self.openCon_:SetSelectedState(PlayerData:IsRandomHero() and "on" or "off")
	self.dlcAnimCon_:SetSelectedState(self:CanSwitchDlcAnim() and "enable" or "disable")

	local var_29_0 = PlayerData:GetRandomHeroMode()

	self.randomModeText_.text = var_29_0 == HomeSceneSettingConst.RANDOM_MODE.EACH_DAY and GetTips("RANDOM_MODE_SETTING_PERDAY") or var_29_0 == HomeSceneSettingConst.RANDOM_MODE.EACH_LOGIN and GetTips("RANDOM_MODE_SETTING_PERTIME") or var_29_0 == HomeSceneSettingConst.RANDOM_MODE.EACH_ENTER and GetTips("RANDOM_MODE_SETTING_PERPLAY") or "unknown"
end

function RandomHeroView:RefreshList()
	self.selections_ = clone(PlayerData:GetRandomHeroList())
	self.oldSelections_ = clone(self.selections_)
	self.selected_ = {}

	for iter_30_0, iter_30_1 in ipairs(self.selections_) do
		self.selected_[iter_30_1] = true
	end

	self.filterView_:OnEnter(self.heroViewProxy_)
	self.filterView_:SetExtraSorter(function(arg_31_0, arg_31_1)
		if self.selected_[arg_31_0.id] ~= self.selected_[arg_31_1.id] then
			return true, self.selected_[arg_31_0.id]
		end

		return false, false
	end)
	self.filterView_:SetHeroIdList((HeroTools.Sort(HeroData:GetHeroList())))
	self.heroHeadList_:StartScroll(#self.heroIdList_, 1)
end

function RandomHeroView:RefreshLeft()
	self.numText_.text = #self.selections_
end

function RandomHeroView:Dispose()
	if self.heroHeadList_ then
		self.heroHeadList_:Dispose()

		self.heroHeadList_ = nil
	end

	if self.filterView_ then
		self.filterView_:Dispose()

		self.filterView_ = nil
	end

	if self.sceneToggle_ then
		self.sceneToggle_:Dispose()

		self.sceneToggle_ = nil
	end

	if self.aniToggle_ then
		self.aniToggle_:Dispose()

		self.aniToggle_ = nil
	end

	if self.openToggle_ then
		self.openToggle_:Dispose()

		self.openToggle_ = nil
	end

	RandomHeroView.super.Dispose(self)
end

function RandomHeroView:HasNoSelection()
	for iter_34_0, iter_34_1 in pairs(self.selected_) do
		if iter_34_1 then
			return false
		end
	end

	return true
end

function RandomHeroView:CanSwitchDlcAnim()
	return PlayerData:IsRandomHeroUseDlcScene() and PlayerData:GetRandomHeroMode() == HomeSceneSettingConst.RANDOM_MODE.EACH_ENTER
end

return RandomHeroView
