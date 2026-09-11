local StoreBtnView = class("StoreBtnView", ReduxView)

function StoreBtnView:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.btnType_ = arg_1_2
	self.btnIndex_ = arg_1_3

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "name")
end

function StoreBtnView:Dispose()
	StoreBtnView.super.Dispose(self)
end

function StoreBtnView:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		manager.notify:Invoke(COMMON_BTN_TYPE_SWITCH, self.btnType_, self.btnIndex_)
	end)
end

function StoreBtnView:RefreshUI(arg_5_1)
	if arg_5_1 == self.btnIndex_ then
		self.controller_:SetSelectedState("false")
	else
		self.controller_:SetSelectedState("true")
	end
end

return StoreBtnView
