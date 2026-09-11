local RechargePageBase = class("RechargePageBase", BaseView)

function RechargePageBase:Ctor(arg_1_1, ...)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init(...)
end

function RechargePageBase:Init(...)
	self:InitUI(...)
	self:AddUIListener()
end

function RechargePageBase:InitUI(...)
	return
end

function RechargePageBase:AddUIListener()
	return
end

function RechargePageBase:UpdateBar()
	return
end

function RechargePageBase:OnEnter()
	return
end

function RechargePageBase:OnExit()
	return
end

function RechargePageBase:Hide()
	SetActive(self.gameObject_, false)
end

function RechargePageBase:Show()
	SetActive(self.gameObject_, true)
end

function RechargePageBase:Dispose()
	RechargePageBase.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return RechargePageBase
