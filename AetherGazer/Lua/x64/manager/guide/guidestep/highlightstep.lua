local var_0_0 = class("HighLightStep", ComponentStep)

function var_0_0.Click(arg_1_0)
	if arg_1_0:Component() ~= nil then
		arg_1_0:OnStepEnd()
	end
end

return var_0_0
