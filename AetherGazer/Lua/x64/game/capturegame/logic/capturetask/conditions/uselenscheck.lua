local var_0_0 = class("UseLensCheck", CaptureConditionBase)

function var_0_0.CheckCondition(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1 or {}
	local var_1_1 = CaptureGameSettingData:GetLens()

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		if iter_1_1 == var_1_1 then
			return true
		end
	end

	return false
end

return var_0_0
