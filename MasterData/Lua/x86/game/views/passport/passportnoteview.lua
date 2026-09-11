local PassportNoteView = class("PassportNoteView", ReduxView)

function PassportNoteView:UIName()
	return "Widget/System/Passport/PassportNoteUI"
end

function PassportNoteView:UIParent()
	return manager.ui.uiMain.transform
end

function PassportNoteView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PassportNoteView:InitUI()
	self:BindCfgUI()
end

function PassportNoteView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function PassportNoteView:UpdateBar()
	return
end

function PassportNoteView:OnEnter()
	return
end

function PassportNoteView:OnExit()
	return
end

function PassportNoteView:OnTop()
	return
end

function PassportNoteView:OnExitInput()
	JumpTools.Back()

	return true
end

function PassportNoteView:Dispose()
	PassportNoteView.super.Dispose(self)
end

return PassportNoteView
