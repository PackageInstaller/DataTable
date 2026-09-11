local RedEnvelopeBtnView = class("RedEnvelopeBtnView", ReduxView)

function RedEnvelopeBtnView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.index = arg_1_2

	self:BindCfgUI()

	self.selectController_ = self.transform_:GetComponent("ControllerExCollection"):GetController("select")
	self.lockController_ = self.transform_:GetComponent("ControllerExCollection"):GetController("lock")
	self.completedController_ = self.transform_:GetComponent("ControllerExCollection"):GetController("completed")
end

function RedEnvelopeBtnView:OnExit()
	return
end

function RedEnvelopeBtnView:Dispose()
	RedEnvelopeBtnView.super.Dispose(self)
end

function RedEnvelopeBtnView:Refresh(arg_4_1, arg_4_2, arg_4_3)
	self.lockController_:SetSelectedIndex(arg_4_2 < self.index and 1 or 0)
	self.selectController_:SetSelectedIndex(arg_4_1 == self.index and 1 or 0)
	self.completedController_:SetSelectedIndex(arg_4_3 and 1 or 0)
end

return RedEnvelopeBtnView
