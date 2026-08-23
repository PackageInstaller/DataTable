local var_0_0 = {
	getSecondsFromOpenById = function(arg_1_0)
		return (g.core.config.parameter_info.get(arg_1_0).parameter - 1) * 24 * 3600 - g.core.common.ServerTime:getOpenTimeFromZero()
	end,
	getTimeIndex = function()
		local var_2_0 = g.core.common.ServerTime:getDateObject().hour

		if var_2_0 >= 6 and var_2_0 < 18 then
			return 1
		else
			return 2
		end
	end
}

function var_0_0.isNight()
	return var_0_0.getTimeIndex() == 2
end

return var_0_0
