class = var_0_10000

local var_0_0 = var_0_10000("CrossRoadCarMgr")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._sceneMaskTF = arg_1_1
	arg_1_0._data = arg_1_2
	arg_1_0._event = arg_1_3

	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	CrossRoadCarMakeController = var_1_10001
	arg_2_0.carMakeController = var_1_10001.New(arg_2_0._data)
	CrossRoadCarMoveController = var_1
	arg_2_0.carMoveController = var_1.New(arg_2_0._data, arg_2_0._event)
	arg_2_0.deltaTime = 0
	CrossRoadGameConst = var_1
	arg_2_0.makedelayTime = var_1.MAKE_CAR_TIME[1]
	CrossRoadGameConst = var_1
	arg_2_0.lastMakeTime = var_1.FIRST_CAR_TIQIAN_TIME

	return
end

function var_0_0.Prepare(arg_3_0)
	local var_3_0 = arg_3_0.carMakeController

	var_1.Prepare(var_3_0)

	return
end

function var_0_0.Step(arg_4_0, arg_4_1)
	arg_4_0.deltaTime = arg_4_0.deltaTime + arg_4_1

	local var_4_0 = arg_4_0._data
	local var_4_1 = var_2.GetRoundCnt(var_4_0)

	math = var_1_10003

	local var_4_2 = var_1_10003.max

	math = var_1_10005

	local var_4_3 = var_1_10005.min
	local var_4_4 = var_4_1

	CrossRoadGameConst = var_1_10008

	local var_4_5 = var_4_2(var_4_3(var_4_4, #var_1_10008.MAKE_CAR_TIME), 1)

	CrossRoadGameConst = var_4_0
	arg_4_0.makedelayTime = var_4_0.MAKE_CAR_TIME[var_4_5]

	if arg_4_0.deltaTime > arg_4_0.lastMakeTime + arg_4_0.makedelayTime then
		arg_4_0.lastMakeTime = arg_4_0.deltaTime

		local var_4_6 = arg_4_0.carMakeController

		var_4.MakeRandomCar(var_4_6, arg_4_0.deltaTime)
	end

	local var_4_7 = arg_4_0.carMakeController

	var_4.Step(var_4_7)

	local var_4_8 = arg_4_0.carMoveController

	var_4.Step(var_4_8, arg_4_1)

	return
end

function var_0_0.Clear(arg_5_0)
	arg_5_0.time = 0

	local var_5_0 = arg_5_0.carMakeController

	var_1.Clear(var_5_0)

	local var_5_1 = arg_5_0.carMoveController

	var_1.Clear(var_5_1)

	return
end

return var_0_0
