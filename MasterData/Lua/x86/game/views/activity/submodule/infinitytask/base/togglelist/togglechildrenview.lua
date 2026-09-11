local ToggleChildrenView = class("ToggleChildrenView", ReduxView)

function ToggleChildrenView:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.parentIndex_ = arg_1_2
	self.index_ = arg_1_3

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "toggle")
end

function ToggleChildrenView:AddListeners()
	self:AddBtnListener(self.toggle_, nil, function()
		manager.notify:Invoke(TOGGLE_LIST_CHILDREN_UPDATE, self.parentIndex_, self.index_)
	end)
end

function ToggleChildrenView:Dispose()
	ToggleChildrenView.super.Dispose(self)
end

function ToggleChildrenView:SetSelectOn(arg_5_1)
	if self.index_ == arg_5_1 then
		self.controller_:SetSelectedState("on")
	else
		self.controller_:SetSelectedState("off")
	end
end

return ToggleChildrenView
