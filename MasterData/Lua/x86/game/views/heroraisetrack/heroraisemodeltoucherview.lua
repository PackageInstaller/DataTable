local HeroRaiseModelToucherView = class("HeroRaiseModelToucherView", ReduxView)

function HeroRaiseModelToucherView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.rotateNode_ = nil

	self:Init()
end

function HeroRaiseModelToucherView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroRaiseModelToucherView:InitUI()
	self.backGo_ = self:FindGo("back")
end

function HeroRaiseModelToucherView:SetRotateNode(arg_4_1)
	self.rotateNode_ = arg_4_1
end

function HeroRaiseModelToucherView:AddUIListener()
	self:AddDragListener(self.backGo_, function()
		self.startRot_ = self.rotateNode_ and self.rotateNode_.localEulerAngles or Vector3.zero
		self.lastRotateY_ = nil
		self.lastDeltaX_ = 0
	end, function(arg_7_0, arg_7_1)
		if self.rotateNode_ then
			local var_7_0 = self.lastRotateY_ or self.rotateNode_.localEulerAngles.y
			local var_7_1 = var_7_0 + (arg_7_0 - (self.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - var_7_0

			if var_7_0 + (arg_7_0 - (self.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - var_7_0 < -HeroConst.MAX_RORATE_ANGLE then
				var_7_1 = -HeroConst.MAX_RORATE_ANGLE
			elseif var_7_0 + (arg_7_0 - (self.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - var_7_0 > HeroConst.MAX_RORATE_ANGLE then
				var_7_1 = HeroConst.MAX_RORATE_ANGLE
			end

			self.lastRotateY_ = var_7_0 + var_7_1
			self.lastDeltaX_ = arg_7_0
			self.rotateNode_.localRotation = Quaternion.RotateTowards(self.rotateNode_.localRotation, Quaternion.Euler(self.startRot_.x, var_7_0 + var_7_1, self.startRot_.z), HeroConst.MAX_RORATE_ANGLE)
		end
	end)
end

function HeroRaiseModelToucherView:OnEnter()
	return
end

function HeroRaiseModelToucherView:OnExit()
	self.rotateNode_ = nil
end

function HeroRaiseModelToucherView:Dispose()
	self.rotateNode_ = nil

	HeroRaiseModelToucherView.super.Dispose(self)
end

return HeroRaiseModelToucherView
