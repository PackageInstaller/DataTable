local EatSnakeQuitPopView = class("EatSnakeQuitPopView", ReduxView)

function EatSnakeQuitPopView:UIName()
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_Com/SandPlay_Com_PopUI"
end

function EatSnakeQuitPopView:UIParent()
	return manager.ui.uiPop.transform
end

function EatSnakeQuitPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function EatSnakeQuitPopView:InitUI()
	self:BindCfgUI()
end

function EatSnakeQuitPopView:AddUIListener()
	self:AddBtnListener(self.cancelBtn_, nil, function()
		if self.params_.cancelAction then
			self.params_.cancelAction()
		end

		self:Back()
	end)
	self:AddBtnListener(self.reBattleBtn_, nil, function()
		if self.params_.battleAction then
			manager.audio:StopAll()
			self.params_.battleAction()
		end

		self:Back()
	end)
	self:AddBtnListener(self.confirmBtn_, nil, function()
		if self.params_.failAction then
			self.params_.failAction()
		end

		manager.audio:Stop("effect")
		self:Back()
	end)
end

function EatSnakeQuitPopView:OnEnter()
	self:UpdateView()
end

function EatSnakeQuitPopView:OnEnterOver()
	self:StopTimer()

	self.timer_ = FrameTimer.New(function()
		manager.audio:Pause("effect", true)
	end, 6, 1)

	self.timer_:Start()
end

function EatSnakeQuitPopView:UpdateView()
	self.titleText_.text = self.params_.title or GetTips("PROMPT")
	self.contentText_.text = self.params_.content

	if not self.params_.reBattleBtn_ then
		self.reBattleBtn_.gameObject:SetActive(false)
	else
		self.reBattleBtn_.gameObject:SetActive(true)
	end
end

function EatSnakeQuitPopView:OnExit()
	manager.audio:Pause("effect", false)
end

function EatSnakeQuitPopView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()
	end
end

function EatSnakeQuitPopView:Dispose()
	EatSnakeQuitPopView.super.Dispose(self)
end

return EatSnakeQuitPopView
