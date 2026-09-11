local DormInfomationModuleBase = class("DormInfomationModuleBase", BaseView)

function DormInfomationModuleBase:ModuleName()
	return ""
end

function DormInfomationModuleBase:Ctor(arg_2_1)
	self.gameObject_ = GameObject.Instantiate(Asset.Load(self:ModuleName()), arg_2_1)
	self.transform_ = self.gameObject_.transform
	self.transform_.localPosition = Vector3.zero
	self.transform_.localScale = Vector3.one
	self.isActive = true

	self:InitUI()
end

function DormInfomationModuleBase:InitUI()
	return
end

function DormInfomationModuleBase:OnEnter()
	return
end

function DormInfomationModuleBase:OnExit()
	return
end

function DormInfomationModuleBase:CanShow(arg_6_1)
	return true
end

function DormInfomationModuleBase:Show(arg_7_1)
	self.gameObject_:SetActive(true)

	self.id = arg_7_1
end

function DormInfomationModuleBase:Hide()
	self.gameObject_:SetActive(false)
end

function DormInfomationModuleBase:GetId()
	return self.id
end

function DormInfomationModuleBase:Dispose()
	if not isNil(self.gameObject_) then
		GameObject.Destroy(self.gameObject_)
		Asset.Unload(self:ModuleName())

		self.gameObject_ = nil
	end

	DormInfomationModuleBase.super.Dispose(self)
end

return DormInfomationModuleBase
