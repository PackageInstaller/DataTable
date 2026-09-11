local NewServerTaskSwitchItem = class("NewServerTaskSwitchItem", ReduxView)

function NewServerTaskSwitchItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.taskType_ = arg_1_2

	self:Init()
end

function NewServerTaskSwitchItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function NewServerTaskSwitchItem:InitUI()
	self:BindCfgUI()

	self.selectController_ = ControllerUtil.GetController(self.transform_, "select")
end

function NewServerTaskSwitchItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickHandler_ then
			self.clickHandler_(self.taskType_)
		end
	end)
end

function NewServerTaskSwitchItem:SetClickCallBack(arg_6_1)
	self.clickHandler_ = arg_6_1
end

function NewServerTaskSwitchItem:RefreshSelect(arg_7_1)
	self.selectController_:SetSelectedState(tostring(self.taskType_ == arg_7_1))
end

return NewServerTaskSwitchItem
