local RandomSettingToggleItem = class("RandomSettingToggleItem", ReduxView)

function RandomSettingToggleItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function RandomSettingToggleItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function RandomSettingToggleItem:InitUI()
	self:BindCfgUI()

	self.selectController = self.conEx_:GetController("select")
end

function RandomSettingToggleItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.callback_ then
			self.callback_(self.index)
		end
	end)
end

function RandomSettingToggleItem:SetValue(arg_6_1)
	self.selectController:SetSelectedState(arg_6_1 and "on" or "off")
end

function RandomSettingToggleItem:SetCallback(arg_7_1)
	self.callback_ = arg_7_1
end

function RandomSettingToggleItem:Dispose()
	RandomSettingToggleItem.super.Dispose(self)
end

return RandomSettingToggleItem
