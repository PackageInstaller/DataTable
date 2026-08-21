local var_0_0 = class("CrossRoadCarMgr")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._sceneMaskTF = arg_1_1
	arg_1_0._data = arg_1_2
	arg_1_0._event = arg_1_3

	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	arg_2_0.carMakeController = CrossRoadCarMakeController.New(arg_2_0._data)
	arg_2_0.carMoveController = CrossRoadCarMoveController.New(arg_2_0._data, arg_2_0._event)
	arg_2_0.deltaTime = 0
	arg_2_0.makedelayTime = CrossRoadGameConst.MAKE_CAR_TIME[1]
	arg_2_0.lastMakeTime = CrossRoadGameConst.FIRST_CAR_TIQIAN_TIME

	return
end

function var_0_0.Prepare(arg_3_0)
	arg_3_0.carMakeController:Prepare()

	return
end

function var_0_0.Step(arg_4_0, arg_4_1)
	arg_4_0.deltaTime = arg_4_0.deltaTime + arg_4_1
	arg_4_0.makedelayTime = CrossRoadGameConst.MAKE_CAR_TIME[math.max(math.min(arg_4_0._data:GetRoundCnt(), #CrossRoadGameConst.MAKE_CAR_TIME), 1)]

	if arg_4_0.deltaTime > arg_4_0.lastMakeTime + arg_4_0.makedelayTime then
		arg_4_0.lastMakeTime = arg_4_0.deltaTime

		arg_4_0.carMakeController:MakeRandomCar(arg_4_0.deltaTime)
	end

	arg_4_0.carMakeController:Step()
	arg_4_0.carMoveController:Step(arg_4_1)

	return
end

function var_0_0.Clear(arg_5_0)
	arg_5_0.time = 0

	arg_5_0.carMakeController:Clear()
	arg_5_0.carMoveController:Clear()

	return
end

return var_0_0
