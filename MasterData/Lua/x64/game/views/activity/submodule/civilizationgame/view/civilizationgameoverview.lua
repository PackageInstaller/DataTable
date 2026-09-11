local CivilizationGameOverView = class("CivilizationGameOverView", ReduxView)

function CivilizationGameOverView:UIName()
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_Culture/V4_2_GodEaterUI_Culture_EndPopUI"
end

function CivilizationGameOverView:UIParent()
	return manager.ui.uiPop.transform
end

function CivilizationGameOverView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CivilizationGameOverView:InitUI()
	self:BindCfgUI()

	self.stateController_ = self.mainControllerEx_:GetController("state")
end

function CivilizationGameOverView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		JumpTools.OpenPageByJump("/civilizationGameMainView", {
			activityID = ActivityConst.ACTIVITY_CIVILIZATION
		})
	end)
end

function CivilizationGameOverView:OnEnter()
	self:RefreshUI()
end

function CivilizationGameOverView:RefreshUI()
	if self.params_.isWin then
		self.winTitleText_.text = GetTips("GODEATER_CIVILIZATION_GAME_WIN_TITLE")
		self.descText_.text = GetTips("GODEATER_CIVILIZATION_GAME_WIN_TIPS")

		self.stateController_:SetSelectedState("win")
	else
		self.loseTitleText_.text = GetTips("GODEATER_CIVILIZATION_GAME_FAIL_TITLE")
		self.descText_.text = GetTips("GODEATER_CIVILIZATION_GAME_FAIL_TIPS")

		self.stateController_:SetSelectedState("lose")
	end
end

function CivilizationGameOverView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function CivilizationGameOverView:OnExit()
	manager.windowBar:HideBar()
end

function CivilizationGameOverView:Dispose()
	CivilizationGameOverView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return CivilizationGameOverView
