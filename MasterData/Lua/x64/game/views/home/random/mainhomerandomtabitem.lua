local MainHomeRandomTabItem = class("MainHomeRandomTabItem", ReduxView)

function MainHomeRandomTabItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function MainHomeRandomTabItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function MainHomeRandomTabItem:InitUI()
	self:BindCfgUI()

	self.selectController = ControllerUtil.GetController(self.transform_, "select")
end

function MainHomeRandomTabItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.callback_ then
			self.callback_(self.index)
		end
	end)
end

function MainHomeRandomTabItem:SetSelect(arg_6_1)
	if self.index == arg_6_1 then
		self.selectController:SetSelectedIndex(0)
	else
		self.selectController:SetSelectedIndex(1)
	end
end

function MainHomeRandomTabItem:RegistCallBack(arg_7_1)
	self.callback_ = arg_7_1
end

function MainHomeRandomTabItem:Dispose()
	manager.redPoint:unbindUIandKey(self.transform_)
	MainHomeRandomTabItem.super.Dispose(self)
end

return MainHomeRandomTabItem
