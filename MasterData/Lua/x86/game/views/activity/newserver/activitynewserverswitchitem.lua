local ActivityNewServerSwitchItem = class("ActivityNewServerSwitchItem", ReduxView)

function ActivityNewServerSwitchItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.index_ = arg_1_2

	self:Init()
end

function ActivityNewServerSwitchItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityNewServerSwitchItem:InitUI()
	self:BindCfgUI()

	self.selectController_ = ControllerUtil.GetController(self.transform_, "select")
end

function ActivityNewServerSwitchItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickHandler_ then
			self.clickHandler_(self.index_)
		end
	end)
end

function ActivityNewServerSwitchItem:SetClickCallBack(arg_6_1)
	self.clickHandler_ = arg_6_1
end

function ActivityNewServerSwitchItem:RefreshSelect(arg_7_1)
	self.selectController_:SetSelectedState(tostring(self.index_ == arg_7_1))
end

return ActivityNewServerSwitchItem
