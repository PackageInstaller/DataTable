local ClickButtonStep = class("ClickButtonStep", ComponentStep)

function ClickButtonStep:Click()
	local var_1_0 = self:Component()

	if var_1_0 ~= nil and self:CheckTarget(var_1_0) then
		self:OnStepEnd()
		var_1_0.onClick:Invoke()
	end
end

function ClickButtonStep:CheckTarget(arg_2_1)
	if arg_2_1:GetType() == typeof(Button) then
		return true
	end

	error("ClickButtonStep CheckTarget Component Type Error")

	return false
end

return ClickButtonStep
