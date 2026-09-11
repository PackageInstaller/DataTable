local GoldMinerSelectLevelView = class("GoldMinerSelectLevelView", ReduxView)

function GoldMinerSelectLevelView:UIName()
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_GoldenMiner/V4_2_GodEaterUI_GoldenMiner_StageUI"
end

function GoldMinerSelectLevelView:UIParent()
	return manager.ui.uiMain.transform
end

function GoldMinerSelectLevelView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GoldMinerSelectLevelView:InitUI()
	self:BindCfgUI()

	self.curLevelID_ = 0
	self.selectLevelItemHandler_ = handler(self, self.OnSelectLevelItem)

	for iter_4_0 = 1, 8 do
		self["stageItem" .. iter_4_0 .. "_"] = GoldMinerSelectLevelItem.New(self["stageGo" .. iter_4_0 .. "_"], iter_4_0, self.selectLevelItemHandler_)
	end

	self.controller_ = self.controllerEx_:GetController("hero")
	self.panelController_ = self.panelControllerEx_:GetController("showHeroPanel")
	self.selectController1_ = self.panelControllerEx1_:GetController("selected")
	self.panelHeroController1_ = self.panelControllerEx1_:GetController("hero")
	self.selectController2_ = self.panelControllerEx2_:GetController("selected")
	self.panelHeroController2_ = self.panelControllerEx2_:GetController("hero")
end

function GoldMinerSelectLevelView:OnSelectLevelItem(arg_5_1, arg_5_2)
	if self.curLevelID_ == arg_5_2 then
		return
	end

	self.curLevelID_ = arg_5_2

	for iter_5_0 = 1, 8 do
		self["stageItem" .. iter_5_0 .. "_"]:RefreshSelect(self.curLevelID_)
	end

	if self["stageItem" .. arg_5_1 .. "_"] then
		self:RemoveTween()

		self.scrollView_.horizontal = false
		self.tween_ = LeanTween.value(self.content_, self.content_.transform.localPosition.x, -self["stageItem" .. arg_5_1 .. "_"].transform_.localPosition.x + self.scrollViewTrans_.rect.width / 2 - self["stageItem" .. arg_5_1 .. "_"].transform_.rect.width / 2, 0.2):setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
			self.content_.transform.localPosition = Vector3(arg_6_0, 0, 0)
		end))
	else
		self.scrollView_.horizontal = true
	end
end

function GoldMinerSelectLevelView:RemoveTween()
	if self.tween_ then
		self.tween_:setOnUpdate(nil)
		LeanTween.cancel(self.content_)

		self.tween_ = nil
	end
end

function GoldMinerSelectLevelView:AddUIListener()
	self:AddBtnListener(self.changeHeroBtn_, nil, function()
		self.panelController_:SetSelectedState("true")
	end)
	self:AddBtnListener(self.panelBtn1_, nil, function()
		local var_10_0

		if GodEaterData:GetCurHeroID() == 1045 then
			return
		else
			var_10_0 = 1045
		end

		self.panelController_:SetSelectedState("false")
		GodEaterAction.GoldMinerChangeHero(ActivityConst.ACTIVITY_GOLDMINER, var_10_0, function()
			GodEaterData:SetCurHeroID(var_10_0)
			self:RefreshHeroInfo()
		end)
	end)
	self:AddBtnListener(self.panelBtn2_, nil, function()
		local var_12_0

		if GodEaterData:GetCurHeroID() == 1046 then
			return
		else
			var_12_0 = 1046
		end

		self.panelController_:SetSelectedState("false")
		GodEaterAction.GoldMinerChangeHero(ActivityConst.ACTIVITY_GOLDMINER, var_12_0, function()
			GodEaterData:SetCurHeroID(var_12_0)
			self:RefreshHeroInfo()
		end)
	end)
	self.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_14_0, arg_14_1)
		self:TryToCloseSectionView()
		self:TryToCloseHeroPanel()
	end))
	self.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_15_0, arg_15_1)
		self:TryToCloseSectionView()
		self:TryToCloseHeroPanel()
	end))
end

function GoldMinerSelectLevelView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.subActivityID_ = ActivityCfg[self.activityID_].sub_activity_list

	self.panelController_:SetSelectedState("false")

	if not self:IsOpenSectionView() then
		self.curLevelID_ = 0
	end

	for iter_16_0 = 1, 8 do
		self["stageItem" .. iter_16_0 .. "_"]:OnEnter(ActivityGodEaterGoldminerStageCfg.all[iter_16_0])
		self["stageItem" .. iter_16_0 .. "_"]:RefreshSelect(self.curLevelID_)
	end

	self:RefreshHeroInfo()
	self:TryToCloseHeroPanel()

	self.scrollView_.horizontal = true
	self.timeText_.text = GetTips("GOD_EATER_GAME_DESC_1")

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("GOD_EATER_GAME_TIPS_3")
	manager.windowBar:RegistBackCallBack(function()
		if self:IsOpenSectionView() then
			self:TryToCloseSectionView()
		else
			JumpTools.Back()
		end
	end)
end

function GoldMinerSelectLevelView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("GOD_EATER_GAME_TIPS_3")
	manager.windowBar:RegistBackCallBack(function()
		if self:IsOpenSectionView() then
			self:TryToCloseSectionView()
		else
			JumpTools.Back()
		end
	end)
end

function GoldMinerSelectLevelView:RefreshHeroInfo()
	local var_20_0 = GodEaterData:GetCurHeroID()

	self.controller_:SetSelectedState(var_20_0)

	if var_20_0 > 0 then
		self.heroNameText_.text = ActivityGodEaterGoldminerHeroCfg[var_20_0].hero_name
		self.heroSkillText_.text = ActivityGodEaterGoldminerHeroCfg[var_20_0].skill_des
	end

	for iter_20_0 = 1, 2 do
		local var_20_1 = ActivityGodEaterGoldminerHeroCfg.all[iter_20_0]

		self["panelNameText" .. iter_20_0 .. "_"].text = ActivityGodEaterGoldminerHeroCfg[ActivityGodEaterGoldminerHeroCfg.all[iter_20_0]].hero_name
		self["panelDesText" .. iter_20_0 .. "_"].text = ActivityGodEaterGoldminerHeroCfg[ActivityGodEaterGoldminerHeroCfg.all[iter_20_0]].skill_des

		if var_20_0 == var_20_1 then
			self["selectController" .. iter_20_0 .. "_"]:SetSelectedState("true")
		else
			self["selectController" .. iter_20_0 .. "_"]:SetSelectedState("false")
		end

		self["panelHeroController" .. iter_20_0 .. "_"]:SetSelectedState(var_20_1)
	end
end

function GoldMinerSelectLevelView:OnExit()
	manager.windowBar:HideBar()

	for iter_21_0 = 1, 8 do
		self["stageItem" .. iter_21_0 .. "_"]:OnExit()
	end

	self:RemoveTween()
end

function GoldMinerSelectLevelView:TryToCloseSectionView()
	if self:IsOpenSectionView() then
		self.curLevelID_ = 0

		for iter_22_0 = 1, 8 do
			self["stageItem" .. iter_22_0 .. "_"]:RefreshSelect(self.curLevelID_)
		end

		self.scrollView_.horizontal = true

		JumpTools.Back()
	end
end

function GoldMinerSelectLevelView:TryToCloseHeroPanel()
	self.panelController_:SetSelectedState("false")
end

function GoldMinerSelectLevelView:IsOpenSectionView()
	return self:IsOpenRoute("goldMinerStageSectionView")
end

function GoldMinerSelectLevelView:GoldMinerOpenSelectHeroPanel()
	self.panelController_:SetSelectedState("true")
end

function GoldMinerSelectLevelView:Dispose()
	for iter_26_0 = 1, 8 do
		self["stageItem" .. iter_26_0 .. "_"]:Dispose()
	end

	self.super.Dispose(self)
end

return GoldMinerSelectLevelView
