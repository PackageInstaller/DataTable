local SpKaliSkill = class("SpKaliSkill", ReduxView)

function SpKaliSkill:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()

	self.statecintroller = self.btn_kailiskillControllerexcollection_:GetController("state")
	self.staminacintroller = self.btn_kailiskillControllerexcollection_:GetController("stamina")
	self.isRedcintroller = self.btn_kailiskillControllerexcollection_:GetController("isRed")
	self.lockcintroller = self.btn_kailiskillControllerexcollection_:GetController("isLock")
end

function SpKaliSkill:AddListeners()
	self:AddBtnListener(self.btn_kailiskillBtn_, nil, function()
		self:OnClick()
	end)
end

function SpKaliSkill:OnClick()
	return
end

function SpKaliSkill:UpdateFillValue(arg_5_1)
	self.lockcintroller:SetSelectedState(arg_5_1.lockTime > 0 and "locked" or "nolocked")

	self.powerimgImg_.fillAmount = 1 - arg_5_1.value or 0
	self.textstaminaText_.text = arg_5_1.cost or 0

	if arg_5_1.value >= 1 then
		self.statecintroller:SetSelectedState("completely")
	else
		self.statecintroller:SetSelectedState("powerimg")
	end

	if arg_5_1.nowAnger >= arg_5_1.cost then
		self.isRedcintroller:SetSelectedState("state0")
	else
		self.isRedcintroller:SetSelectedState("state1")
	end
end

function SpKaliSkill:RefreshData()
	return
end

function SpKaliSkill:Dispose()
	SpKaliSkill.super.Dispose(self)
end

return SpKaliSkill
