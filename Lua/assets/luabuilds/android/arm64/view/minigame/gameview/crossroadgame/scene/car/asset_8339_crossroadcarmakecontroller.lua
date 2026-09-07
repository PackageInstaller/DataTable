local CrossRoadCarMakeController = class("CrossRoadCarMakeController")

function CrossRoadCarMakeController:Ctor(arg_1_1)
	self._runningData = arg_1_1
	self.backRoadTF = arg_1_1:GetRoadTF(CrossRoadGameConst.BACK_ROAD_NAME)
	self.backRoadList = arg_1_1:GetRoadList(CrossRoadGameConst.BACK_ROAD_NAME)
	self.carTpl = arg_1_1:GetAllCarTpl()
	self.carGameObjectList = {}
	self.delatTime = 0

	for iter_1_0 = 1, CrossRoadGameConst.GAME_TRACK_COUNT do
		self.carGameObjectList[iter_1_0] = {}
	end

	self._runningData:SetTrackCarGoList(self.carGameObjectList)

	return
end

function CrossRoadCarMakeController:Prepare()
	self._trackCarGOList = {}

	for iter_2_0 = 1, CrossRoadGameConst.GAME_TRACK_COUNT do
		self._trackCarGOList[iter_2_0] = {}
	end

	self._runningData:SetTrackCarGoList(self.carGameObjectList)

	return
end

function CrossRoadCarMakeController:MakeRandomCar(arg_3_1)
	local var_3_0 = CrossRoadGameHelper:WeightCarRandom()
	local var_3_1 = math.random(1, CrossRoadGameConst.GAME_TRACK_COUNT)
	local var_3_2

	for iter_3_0, iter_3_1 in ipairs(CrossRoadGameConst.CAR_TPL) do
		if iter_3_1 == var_3_0.resource then
			var_3_2 = tf(instantiate(self.carTpl[iter_3_0]))
		end
	end

	local var_3_3 = CrossRoadCar.New(var_3_2, var_3_0, var_3_1, self._runningData)

	var_3_3:SetScale(Vector3(CrossRoadGameConst.START_CAR_SCALE, CrossRoadGameConst.START_CAR_SCALE, 1))
	var_3_3:SetParent((self.backRoadTF:Find(tostring(var_3_1))))
	var_3_3:SetPosition((Vector2.New(self.backRoadList[var_3_1].startTF.anchoredPosition.x, self.backRoadList[var_3_1].startTF.anchoredPosition.y - var_3_0.length)))
	var_3_3:SetTarget(self.backRoadList[var_3_1].startTF.anchoredPosition)
	var_3_3:SetDirect({
		0,
		1
	})
	table.insert(self.carGameObjectList[var_3_1], var_3_3)
	self._runningData:SetTrackCarGoList(self.carGameObjectList)

	return
end

function CrossRoadCarMakeController:Step()
	for iter_4_0 = 1, CrossRoadGameConst.GAME_TRACK_COUNT do
		for iter_4_1 = #self.carGameObjectList[iter_4_0], 1, -1 do
			if self.carGameObjectList[iter_4_0][iter_4_1]:GetNeedDispose() then
				table.remove(self.carGameObjectList[iter_4_0], iter_4_1)
				self.carGameObjectList[iter_4_0][iter_4_1]:Dispose()
				self._runningData:SetTrackCarGoList(self.carGameObjectList)
			end
		end
	end

	return
end

function CrossRoadCarMakeController:Clear()
	for iter_5_0 = 1, CrossRoadGameConst.GAME_TRACK_COUNT do
		for iter_5_1 = #self.carGameObjectList[iter_5_0], 1, -1 do
			table.remove(self.carGameObjectList[iter_5_0], iter_5_1)
			self.carGameObjectList[iter_5_0][iter_5_1]:Dispose()
			self._runningData:SetTrackCarGoList(self.carGameObjectList)
		end
	end

	return
end

return CrossRoadCarMakeController
