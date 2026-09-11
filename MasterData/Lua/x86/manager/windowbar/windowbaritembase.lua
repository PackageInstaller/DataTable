local WindowBarItemBase = class("WindowBarItemBase", import("game.extend.ReduxView"))

function WindowBarItemBase:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function WindowBarItemBase:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.isCanAdd_ = true
	self.isCanClick_ = false

	self:RefreshUI()
end

function WindowBarItemBase:AddListeners()
	self:AddBtnListener(nil, nil, "OnClick")
end

function WindowBarItemBase:RefreshUI()
	return
end

function WindowBarItemBase:OnClick()
	return
end

function WindowBarItemBase:SetActive(arg_6_1)
	SetActive(self.gameObject_, arg_6_1)

	if arg_6_1 then
		self:RegisterEvents()
		self:RefreshUI()
	else
		self:RemoveAllEventListener()
	end
end

function WindowBarItemBase:SetCanAdd(arg_7_1)
	if self.isCanAdd_ == arg_7_1 then
		return
	end

	self.isCanAdd_ = arg_7_1

	SetActive(self.add_, arg_7_1)
end

function WindowBarItemBase:SetCanClick(arg_8_1)
	self.isCanClick_ = arg_8_1
end

function WindowBarItemBase:UnBindListener()
	self:RemoveAllEventListener()
end

function WindowBarItemBase:Dispose()
	WindowBarItemBase.super.Dispose(self)

	self.transform_ = nil
	self.gameObject_ = nil
end

return WindowBarItemBase
