local FireWorkResultView = class("FireWorkResultView", ReduxView)

function FireWorkResultView:UIName()
	return "UI/EmptyDream/Firework/FireworkMakingUI"
end

function FireWorkResultView:UIParent()
	return manager.ui.uiMain.transform
end

function FireWorkResultView:Init()
	self:InitUI()
	self:AddUIListener()
end

function FireWorkResultView:InitUI()
	self:BindCfgUI()

	self.stateController = ControllerUtil.GetController(self.transform_, "state")
end

function FireWorkResultView:AddUIListener()
	self:AddBtnListener(self.m_mask, nil, function()
		if self.isWin then
			JumpTools.OpenPageByJump("/fireWorkShow", {
				fire_activity_id = self.params_.fire_activity_id
			})
		else
			JumpTools.OpenPageByJump("fireWorkMake", {
				start = true,
				fire_activity_id = self.params_.fire_activity_id
			})
		end
	end)
end

function FireWorkResultView:OnTop()
	manager.windowBar:SwitchBar({})
end

function FireWorkResultView:OnEnter()
	self.isWin = self.params_.isWin

	if self.isWin then
		self.stateController:SetSelectedIndex(1)
		manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_good", "")
	else
		self.stateController:SetSelectedIndex(0)
		manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_no", "")
	end
end

function FireWorkResultView:OnExit()
	manager.windowBar:HideBar()
end

function FireWorkResultView:Dispose()
	FireWorkResultView.super.Dispose(self)
end

return FireWorkResultView
