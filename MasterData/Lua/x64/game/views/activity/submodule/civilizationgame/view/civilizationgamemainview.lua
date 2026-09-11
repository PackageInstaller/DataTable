local CivilizationGameMainView = class("CivilizationGameMainView", ReduxView)

function CivilizationGameMainView:UIName()
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_Culture/V4_2_GodEaterUI_Culture_MainUI"
end

function CivilizationGameMainView:UIParent()
	return manager.ui.uiMain.transform
end

function CivilizationGameMainView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CivilizationGameMainView:InitUI()
	self:BindCfgUI()

	self.selectController_ = self.mainControllerEx_:GetController("tips")
	self.heroEmptyController_ = self.mainControllerEx_:GetController("empty")
	self.heroController_ = self.selectControllerEx_:GetController("Toggle")
end

function CivilizationGameMainView:AddUIListener()
	self:AddBtnListener(self.heroBtn_, nil, function()
		self.selectController_:SetSelectedState("on")
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self.selectController_:SetSelectedState("off")
	end)
	self:AddBtnListener(self.taskBtn_, nil, function()
		JumpTools.OpenPageByJump("ActivityGodEaterCivilizationTaskView", {
			activityId = ActivityConst.ACTIVITY_CIVILIZATION
		})
	end)
	self:AddBtnListener(self.illuBtn_, nil, function()
		JumpTools.OpenPageByJump("/civilizationGameIlluView")
	end)
	self:AddBtnListener(self.playBtn_, nil, function()
		if self:GetHeroID() == 0 then
			ShowTips("GODEATER_CIVILIZATION_GAME_NOT_SELECTED_HERO")
			self.selectController_:SetSelectedState("on")
		else
			self.selectController_:SetSelectedState("off")
			CivilizationGameTools.EnterGameView(self:GetHeroID(), ActivityCivilizationStageCfg.all[1])
		end
	end)
	self:AddBtnListener(self.teachBtn_, nil, function()
		if self:GetHeroID() == 0 then
			ShowTips("GODEATER_CIVILIZATION_GAME_NOT_SELECTED_HERO")
			self.selectController_:SetSelectedState("on")
		else
			self.selectController_:SetSelectedState("off")
			CivilizationGameTools.EnterGameView(self:GetHeroID(), ActivityCivilizationStageCfg.all[2])
		end
	end)
	self:AddBtnListener(self.select1Btn_, nil, function()
		if self:GetHeroID() == 1 then
			return
		end

		self:SetHeroID(1)
		self:UpdateView()
	end)
	self:AddBtnListener(self.select2Btn_, nil, function()
		if self:GetHeroID() == 2 then
			return
		end

		self:SetHeroID(2)
		self:UpdateView()
	end)
end

function CivilizationGameMainView:OnEnter()
	self.activityID_ = self.params_.activityID

	if not ActivityData:GetActivityData(self.activityID_) then
		JumpTools.Back()
		ShowTips("TIME_OVER")

		return
	end

	self:UpdateView()
	self:BindRedPoint()
	GodEaterAction.UpdateRedPoint()
end

function CivilizationGameMainView:UpdateView()
	local var_15_0 = self:GetHeroID()

	if var_15_0 == 0 then
		self.heroEmptyController_:SetSelectedState("empty")
		self.heroController_:SetSelectedIndex(2)

		self.heroNameText_.text = GetTips("GODEATER_CIVILIZATION_GAME_NOT_SELECTED_HERO_TIPS")
		self.descText_.text = ""
	else
		self.heroEmptyController_:SetSelectedIndex(var_15_0)
		self.heroController_:SetSelectedIndex(var_15_0 == 1 and 0 or 1)

		self.descText_.text = ActivityCivilizationHeroCfg[var_15_0].description
	end

	for iter_15_0 = 1, 2 do
		self["hero" .. iter_15_0 .. "NameText_"].text = ActivityCivilizationHeroCfg[iter_15_0].name
		self["hero" .. iter_15_0 .. "DescText_"].text = ActivityCivilizationHeroCfg[iter_15_0].description

		if var_15_0 == iter_15_0 then
			self.heroNameText_.text = ActivityCivilizationHeroCfg[iter_15_0].name
		end
	end

	self.timeText_.text = GetTips("GOD_EATER_GAME_DESC_3")
end

function CivilizationGameMainView:GetHeroID()
	return getData("civilizationGame", "heroID") or 0
end

function CivilizationGameMainView:SetHeroID(arg_17_1)
	self.selectController_:SetSelectedState("off")
	saveData("civilizationGame", "heroID", arg_17_1)
end

function CivilizationGameMainView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.taskBtn_.transform, RedPointConst.ACTIVITY_CODEATER_CIVILIZATION)
end

function CivilizationGameMainView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform, RedPointConst.ACTIVITY_CODEATER_CIVILIZATION)
end

function CivilizationGameMainView:OnExit()
	self:UnbindRedPoint()
	manager.windowBar:HideBar()
end

function CivilizationGameMainView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("GODEATER_CIVILIZATION_GAME_DESC")
end

function CivilizationGameMainView:Dispose()
	CivilizationGameMainView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return CivilizationGameMainView
