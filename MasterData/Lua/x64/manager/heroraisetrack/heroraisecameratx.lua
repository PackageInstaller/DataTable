local HeroRaiseCameraTx = class("HeroRaiseCameraTx")

function HeroRaiseCameraTx:Ctor()
	self.gameObject_ = nil
	self.transform_ = nil
	self.animator_ = nil
end

function HeroRaiseCameraTx:Init(arg_2_1)
	self.transform_ = Object.Instantiate(Asset.Load(arg_2_1), manager.ui.mainCamera.transform)

	if not isNil(self.transform_) then
		self.gameObject_ = self.transform_.gameObject
		self.animator_ = self.transform_:GetComponent(typeof(Animator))

		if isNil(self.animator_) then
			self.animator_ = self.transform_:GetComponentInChildren(typeof(Animator))
		end
	end
end

function HeroRaiseCameraTx:PlayAnim(arg_3_1)
	if isNil(self.animator_) then
		return
	end

	self.animator_:Play(arg_3_1)
end

function HeroRaiseCameraTx:CheckValid()
	if isNil(self.gameObject_) then
		return false
	end

	return true
end

function HeroRaiseCameraTx:Dispose()
	if not isNil(self.gameObject_) then
		Object.Destroy(self.gameObject_)
	end

	self.gameObject_ = nil
	self.transform_ = nil
	self.animator_ = nil
end

return HeroRaiseCameraTx
