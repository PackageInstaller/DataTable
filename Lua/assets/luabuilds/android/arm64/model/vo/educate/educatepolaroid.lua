local var_0_0 = class("EducatePolaroid", import("model.vo.BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.time = arg_1_1.time or {
		week = 1,
		month = 3,
		day = 7
	}

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.child_polaroid
end

function var_0_0.GetTimeWeight(arg_3_0)
	return arg_3_0.time.month * 28 + arg_3_0.time.week * 7 + arg_3_0.time.day
end

return var_0_0
