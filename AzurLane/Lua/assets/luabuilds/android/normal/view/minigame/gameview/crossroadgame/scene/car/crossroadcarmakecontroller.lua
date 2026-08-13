class = var_0_10000

local var_0_0 = var_0_10000("CrossRoadCarMakeController")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._runningData = arg_1_1

	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.GetRoadTF

	CrossRoadGameConst = var_1_10004
	arg_1_0.backRoadTF = var_1_1(var_1_0, var_1_10004.BACK_ROAD_NAME)

	local var_1_2 = arg_1_1
	local var_1_3 = arg_1_1.GetRoadList

	CrossRoadGameConst = var_4
	arg_1_0.backRoadList = var_1_3(var_1_2, var_4.BACK_ROAD_NAME)

	local var_1_4 = arg_1_1

	arg_1_0.carTpl = arg_1_1.GetAllCarTpl(var_1_4)
	arg_1_0.carGameObjectList = {}
	arg_1_0.delatTime = 0

	local var_1_5 = 1

	CrossRoadGameConst = var_1_4

	for iter_1_0 = var_1_5, var_1_4.GAME_TRACK_COUNT do
		arg_1_0.carGameObjectList[iter_1_0] = {}
	end

	local var_1_6 = arg_1_0._runningData

	var_2.SetTrackCarGoList(var_1_6, arg_1_0.carGameObjectList)

	return
end

function var_0_0.Prepare(arg_2_0)
	arg_2_0._trackCarGOList = {}

	local var_2_0 = 1

	CrossRoadGameConst = var_1_10002

	for iter_2_0 = var_2_0, var_1_10002.GAME_TRACK_COUNT do
		arg_2_0._trackCarGOList[iter_2_0] = {}
	end

	local var_2_1 = arg_2_0._runningData

	var_1.SetTrackCarGoList(var_2_1, arg_2_0.carGameObjectList)

	return
end

function var_0_0.MakeRandomCar(arg_3_0, arg_3_1)
	CrossRoadGameHelper = var_1_10002

	local var_3_0 = var_1_10002
	local var_3_1 = var_1_10002.WeightCarRandom(var_3_0)

	math = var_3_0

	local var_3_2 = var_3_0.random
	local var_3_3 = 1

	CrossRoadGameConst = var_1_10005

	local var_3_4 = var_3_2(var_3_3, var_1_10005.GAME_TRACK_COUNT)
	local var_3_5

	ipairs = var_5
	CrossRoadGameConst = var_1_10006

	for iter_3_0, iter_3_1 in var_5(var_1_10006.CAR_TPL) do
		if iter_3_1 == var_3_1.resource then
			tf = var_10
			instantiate = var_1_10011
			var_3_5 = var_10(var_1_10011(arg_3_0.carTpl[iter_3_0]))
		end
	end

	CrossRoadCar = var_5

	local var_3_6 = var_5.New(var_3_5, var_3_1, var_3_4, arg_3_0._runningData)
	local var_3_7 = arg_3_0.backRoadTF
	local var_3_8 = var_6.Find

	tostring = var_8

	local var_3_9 = var_3_8(var_3_7, var_8(var_3_4))
	local var_3_10 = arg_3_0.backRoadList[var_3_4].startTF.anchoredPosition

	Vector2 = var_8

	local var_3_11 = var_8.New(var_3_10.x, var_3_10.y - var_3_1.length)

	CrossRoadGameConst = var_9

	local var_3_12 = var_9.START_CAR_SCALE
	local var_3_13 = var_3_6
	local var_3_14 = var_3_6.SetScale

	Vector3 = var_1_10012

	var_3_14(var_3_13, var_1_10012(var_3_12, var_3_12, 1))
	var_3_6:SetParent(var_3_9)
	var_3_6:SetPosition(var_3_11)
	var_3_6:SetTarget(var_3_10)
	var_3_6:SetDirect({
		0,
		1
	})

	table = var_10

	var_10.insert(arg_3_0.carGameObjectList[var_3_4], var_3_6)

	local var_3_15 = arg_3_0._runningData

	var_10.SetTrackCarGoList(var_3_15, arg_3_0.carGameObjectList)

	return
end

function var_0_0.Step(arg_4_0)
	local var_4_0 = 1

	CrossRoadGameConst = var_1_10002

	for iter_4_0 = var_4_0, var_1_10002.GAME_TRACK_COUNT do
		for iter_4_1 = #arg_4_0.carGameObjectList[iter_4_0], 1, -1 do
			local var_4_1 = arg_4_0.carGameObjectList[iter_4_0][iter_4_1]

			if var_9.GetNeedDispose(var_4_1) then
				table = var_10

				var_10.remove(arg_4_0.carGameObjectList[iter_4_0], iter_4_1)
				var_9:Dispose()

				local var_4_2 = arg_4_0._runningData

				var_10.SetTrackCarGoList(var_4_2, arg_4_0.carGameObjectList)
			end
		end
	end

	return
end

function var_0_0.Clear(arg_5_0)
	local var_5_0 = 1

	CrossRoadGameConst = var_1_10002

	for iter_5_0 = var_5_0, var_1_10002.GAME_TRACK_COUNT do
		for iter_5_1 = #arg_5_0.carGameObjectList[iter_5_0], 1, -1 do
			local var_5_1 = arg_5_0.carGameObjectList[iter_5_0][iter_5_1]

			table = var_1_10010

			var_1_10010.remove(arg_5_0.carGameObjectList[iter_5_0], iter_5_1)
			var_5_1:Dispose()

			local var_5_2 = arg_5_0._runningData

			var_1_10010.SetTrackCarGoList(var_5_2, arg_5_0.carGameObjectList)
		end
	end

	return
end

return var_0_0
