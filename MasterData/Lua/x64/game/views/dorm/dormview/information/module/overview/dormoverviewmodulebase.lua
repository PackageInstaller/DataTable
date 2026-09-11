local DormOverviewModuleBase = class("DormOverviewModuleBase", BaseView)

function DormOverviewModuleBase:ModuleName()
	return ""
end

function DormOverviewModuleBase:Ctor(arg_2_1)
	self.gameObject_ = GameObject.Instantiate(Asset.Load(self:ModuleName()), arg_2_1)
	self.transform_ = self.gameObject_.transform
	self.transform_.localPosition = Vector3.zero
	self.transform_.localScale = Vector3.one
	self.isActive = true

	self:InitUI()
end

function DormOverviewModuleBase:InitUI()
	return
end

function DormOverviewModuleBase:OnEnter()
	return
end

function DormOverviewModuleBase:OnExit()
	return
end

function DormOverviewModuleBase:GetId()
	return self.id
end

function DormOverviewModuleBase:Dispose()
	if not isNil(self.gameObject_) then
		GameObject.Destroy(self.gameObject_)
		Asset.Unload(self:ModuleName())

		self.gameObject_ = nil
	end

	DormOverviewModuleBase.super.Dispose(self)
end

return DormOverviewModuleBase
