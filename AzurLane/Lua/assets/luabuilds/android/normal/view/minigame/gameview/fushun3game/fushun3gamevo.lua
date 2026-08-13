class = var_0_10000

local var_0_0 = var_0_10000("Fushun3GameVo")

Fushun3GameConst = var_1
var_0_0.TimeType = var_1.day_type
var_0_0.TimeFlag = true

function var_0_0.ChangeTimeType(arg_1_0)
	var_0_0.TimeType = arg_1_0

	local var_1_0 = var_0_0.TimeType

	Fushun3GameConst = var_1_10002

	if var_1_0 ~= var_1_10002.day_type then
		local var_1_1 = var_0_0.TimeType

		Fushun3GameConst = var_2

		local var_1_2

		if var_1_1 == var_2.sunset_type then
			var_1_2 = true
		else
			var_1_2 = false
		end

		var_0_0.SetTimeFlag(var_1_2)

		return
	end
end

function var_0_0.GetTimeTypeData()
	Clone = var_1_10000
	Fushun3GameConst = var_1_10001

	return var_1_10000(var_1_10001.time_data[var_0_0.TimeType])
end

function var_0_0.SetTimeFlag(arg_3_0)
	var_0_0.TimeFlag = arg_3_0

	return
end

function var_0_0.GetTimeFlag()
	return var_0_0.TimeFlag
end

function var_0_0.Clear()
	local var_5_0 = var_0_0.TypeType

	Fushun3GameConst = var_1_10001

	if var_5_0 == var_1_10001.sunset_type then
		local var_5_1 = var_0_0.ChangeTimeType

		Fushun3GameConst = var_1

		var_5_1(var_1.day_type)
	end

	return
end

return var_0_0
