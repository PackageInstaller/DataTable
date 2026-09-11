local SignToggleItem = class("SignToggleItem", ReduxView)

function SignToggleItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SignToggleItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function SignToggleItem:InitUI()
	self:BindCfgUI()

	self.selectController = self.m_ControllerEx_:GetController("select")
	self.lockController = ControllerUtil.GetController(self.transform_, "lock")
	self.iconControllerUnselect = self.m_iconControllerEx1_:GetController("icon")
	self.iconControllerSelect = self.m_iconControllerEx2_:GetController("icon")
end

function SignToggleItem:AddUIListener()
	self:AddBtnListener(self.m_btn, nil, function()
		if self.callback_ then
			self.callback_(self.index)
		end
	end)
end

function SignToggleItem:SetData(arg_6_1, arg_6_2)
	manager.redPoint:unbindUIandKey(self.transform_)

	self.index = arg_6_1

	if arg_6_2:RedPointKey() then
		manager.redPoint:bindUIandKey(self.transform_, arg_6_2:RedPointKey())
	end

	self.m_title.text = GetI18NText(arg_6_2:Title())
	self.m_selectTitle.text = GetI18NText(arg_6_2:Title())

	local var_6_0 = arg_6_2:Image()

	if var_6_0 then
		self.iconControllerUnselect:SetSelectedState(var_6_0)
		self.iconControllerSelect:SetSelectedState(var_6_0)
	end

	if PlayerData:GetPlayerInfo().userLevel < arg_6_2:GetLimitLevel() then
		self.lockController:SetSelectedIndex(1)
	else
		self.lockController:SetSelectedIndex(0)
	end
end

function SignToggleItem:SetSelect(arg_7_1)
	if self.index == arg_7_1 then
		self.selectController:SetSelectedIndex(1)
	else
		self.selectController:SetSelectedIndex(0)
	end
end

function SignToggleItem:RegistCallBack(arg_8_1)
	self.callback_ = arg_8_1
end

function SignToggleItem:Dispose()
	manager.redPoint:unbindUIandKey(self.transform_)
	SignToggleItem.super.Dispose(self)
end

return SignToggleItem
