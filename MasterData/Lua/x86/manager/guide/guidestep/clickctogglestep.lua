local ClickCToggleStep = class("ClickCToggleStep", ComponentStep)

function ClickCToggleStep:Click()
	local var_1_0 = self:Component()

	if var_1_0 ~= nil and self:CheckTarget(var_1_0) then
		self:OnStepEnd()
	end
end

function ClickCToggleStep:CheckTarget(arg_2_1)
	if arg_2_1:GetType() == typeof(CToggle) then
		arg_2_1.isOn = true

		return true
	end

	error("ClickCToggleStep CheckTarget Component Type Error")

	return false
end

return ClickCToggleStep
