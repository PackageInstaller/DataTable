local UseLensCheck = class("UseLensCheck", CaptureConditionBase)

function UseLensCheck:CheckCondition(arg_1_1)
	local var_1_0 = CaptureGameSettingData:GetLens()

	for iter_1_0, iter_1_1 in ipairs(arg_1_1 or {}) do
		if iter_1_1 == var_1_0 then
			return true
		end
	end

	return false
end

return UseLensCheck
