local var_0_0 = class("CrossRoadCarMakeController")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._runningData = arg_1_1
	arg_1_0.backRoadTF = arg_1_1:GetRoadTF(CrossRoadGameConst.BACK_ROAD_NAME)
	arg_1_0.backRoadList = arg_1_1:GetRoadList(CrossRoadGameConst.BACK_ROAD_NAME)
	arg_1_0.carTpl = arg_1_1:GetAllCarTpl()
	arg_1_0.carGameObjectList = {}
	arg_1_0.delatTime = 0

	for iter_1_0 = 1, CrossRoadGameConst.GAME_TRACK_COUNT do
		arg_1_0.carGameObjectList[iter_1_0] = {}
	end

	arg_1_0._runningData:SetTrackCarGoList(arg_1_0.carGameObjectList)

	return
end

function var_0_0.Prepare(arg_2_0)
	arg_2_0._trackCarGOList = {}

	for iter_2_0 = 1, CrossRoadGameConst.GAME_TRACK_COUNT do
		arg_2_0._trackCarGOList[iter_2_0] = {}
	end

	arg_2_0._runningData:SetTrackCarGoList(arg_2_0.carGameObjectList)

	return
end

function var_0_0.MakeRandomCar(arg_3_0, arg_3_1)
	local var_3_0 = CrossRoadGameHelper:WeightCarRandom()
	local var_3_1 = math.random(1, CrossRoadGameConst.GAME_TRACK_COUNT)
	local var_3_2

	for iter_3_0, iter_3_1 in ipairs(CrossRoadGameConst.CAR_TPL) do
		if iter_3_1 == var_3_0.resource then
			var_3_2 = tf(instantiate(arg_3_0.carTpl[iter_3_0]))
		end
	end

	local var_3_3 = CrossRoadCar.New(var_3_2, var_3_0, var_3_1, arg_3_0._runningData)

	var_3_3:SetScale(Vector3(CrossRoadGameConst.START_CAR_SCALE, CrossRoadGameConst.START_CAR_SCALE, 1))
	var_3_3:SetParent((arg_3_0.backRoadTF:Find(tostring(var_3_1))))
	var_3_3:SetPosition((Vector2.New(arg_3_0.backRoadList[var_3_1].startTF.anchoredPosition.x, arg_3_0.backRoadList[var_3_1].startTF.anchoredPosition.y - var_3_0.length)))
	var_3_3:SetTarget(arg_3_0.backRoadList[var_3_1].startTF.anchoredPosition)
	var_3_3:SetDirect({
		0,
		1
	})
	table.insert(arg_3_0.carGameObjectList[var_3_1], var_3_3)
	arg_3_0._runningData:SetTrackCarGoList(arg_3_0.carGameObjectList)

	return
end

function var_0_0.Step(arg_4_0)
	for iter_4_0 = 1, CrossRoadGameConst.GAME_TRACK_COUNT do
		for iter_4_1 = #arg_4_0.carGameObjectList[iter_4_0], 1, -1 do
			if arg_4_0.carGameObjectList[iter_4_0][iter_4_1]:GetNeedDispose() then
				table.remove(arg_4_0.carGameObjectList[iter_4_0], iter_4_1)
				arg_4_0.carGameObjectList[iter_4_0][iter_4_1]:Dispose()
				arg_4_0._runningData:SetTrackCarGoList(arg_4_0.carGameObjectList)
			end
		end
	end

	return
end

function var_0_0.Clear(arg_5_0)
	for iter_5_0 = 1, CrossRoadGameConst.GAME_TRACK_COUNT do
		for iter_5_1 = #arg_5_0.carGameObjectList[iter_5_0], 1, -1 do
			table.remove(arg_5_0.carGameObjectList[iter_5_0], iter_5_1)
			arg_5_0.carGameObjectList[iter_5_0][iter_5_1]:Dispose()
			arg_5_0._runningData:SetTrackCarGoList(arg_5_0.carGameObjectList)
		end
	end

	return
end

return var_0_0
