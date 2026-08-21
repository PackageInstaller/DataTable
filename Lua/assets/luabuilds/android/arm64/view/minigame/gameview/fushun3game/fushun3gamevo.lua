local var_0_0 = class("Fushun3GameVo")

var_0_0.TimeType = Fushun3GameConst.day_type
var_0_0.TimeFlag = true

function var_0_0.ChangeTimeType(arg_1_0)
	var_0_0.TimeType = arg_1_0

	var_0_0.SetTimeFlag((var_0_0.TimeType == Fushun3GameConst.day_type or var_0_0.TimeType == Fushun3GameConst.sunset_type) and true or false)

	return
end

function var_0_0.GetTimeTypeData()
	return Clone(Fushun3GameConst.time_data[var_0_0.TimeType])
end

function var_0_0.SetTimeFlag(arg_3_0)
	var_0_0.TimeFlag = arg_3_0

	return
end

function var_0_0.GetTimeFlag()
	return var_0_0.TimeFlag
end

function var_0_0.Clear()
	if var_0_0.TypeType == Fushun3GameConst.sunset_type then
		var_0_0.ChangeTimeType(Fushun3GameConst.day_type)
	end

	return
end

return var_0_0
