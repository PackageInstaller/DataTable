local SettingToggleItem = class("SettingToggleItem", ReduxView)

function SettingToggleItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SettingToggleItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function SettingToggleItem:InitUI()
	self:BindCfgUI()

	self.selectController = ControllerUtil.GetController(self.transform_, "select")
end

function SettingToggleItem:AddUIListener()
	self:AddBtnListener(self.m_btn01, nil, function()
		if self.callback_ then
			self.callback_(self.index)
		end
	end)
	self:AddBtnListener(self.m_btn02, nil, function()
		if self.callback_ then
			self.callback_(self.index)
		end
	end)
end

function SettingToggleItem:SetData(arg_7_1, arg_7_2)
	manager.redPoint:unbindUIandKey(self.transform_)

	self.index = arg_7_1

	local var_7_0 = arg_7_2:Image()

	self.icon_01.sprite = var_7_0
	self.icon_02.sprite = var_7_0
	self.data = arg_7_2

	if arg_7_2 and arg_7_2.RedPointKey and arg_7_2:RedPointKey() ~= nil then
		for iter_7_0, iter_7_1 in ipairs(arg_7_2:RedPointKey()) do
			manager.redPoint:bindUIandKey(self.transform_, iter_7_1)
		end
	end
end

function SettingToggleItem:SetSelect(arg_8_1)
	if self.index == arg_8_1 then
		self.selectController:SetSelectedIndex(0)
	else
		self.selectController:SetSelectedIndex(1)
	end
end

function SettingToggleItem:RegistCallBack(arg_9_1)
	self.callback_ = arg_9_1
end

function SettingToggleItem:Dispose()
	if self.data and self.data.RedPointKey and self.data:RedPointKey() ~= nil then
		for iter_10_0, iter_10_1 in ipairs(self.data:RedPointKey()) do
			manager.redPoint:unbindUIandKey(self.transform_, iter_10_1)
		end
	end

	SettingToggleItem.super.Dispose(self)
end

return SettingToggleItem
