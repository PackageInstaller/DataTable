local LocalSystemTimeUtil = class("LocalSystemTimeUtil", import(".SystemTimeUtil"))

function LocalSystemTimeUtil:Flush()
	local var_1_0 = string.split(os.date("%H:%M:%S"), ":")
	local var_1_1 = var_1_0[2]
	local var_1_2 = tonumber(var_1_0[1])

	if self.callback then
		self.callback(var_1_2, var_1_1, var_1_2 < 12 and "AM" or "PM")
	end

	self:AddTimer((self:GetSecondsToNextMinute((os.time()))))

	return
end

return LocalSystemTimeUtil
