local var_0_0 = class("ClickCToggleStep", ComponentStep)

function var_0_0.Click(arg_1_0)
	local var_1_0 = arg_1_0:Component()

	if var_1_0 ~= nil and arg_1_0:CheckTarget(var_1_0) then
		arg_1_0:OnStepEnd()
	end
end

function var_0_0.CheckTarget(arg_2_0, arg_2_1)
	if arg_2_1:GetType() == typeof(CToggle) then
		arg_2_1.isOn = true

		return true
	end

	error("ClickCToggleStep CheckTarget Component Type Error")

	return false
end

return var_0_0
