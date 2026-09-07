local CrossRoadCarMgr = class("CrossRoadCarMgr")

function CrossRoadCarMgr:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._sceneMaskTF = arg_1_1
	self._data = arg_1_2
	self._event = arg_1_3

	self:Init()

	return
end

function CrossRoadCarMgr:Init()
	self.carMakeController = CrossRoadCarMakeController.New(self._data)
	self.carMoveController = CrossRoadCarMoveController.New(self._data, self._event)
	self.deltaTime = 0
	self.makedelayTime = CrossRoadGameConst.MAKE_CAR_TIME[1]
	self.lastMakeTime = CrossRoadGameConst.FIRST_CAR_TIQIAN_TIME

	return
end

function CrossRoadCarMgr:Prepare()
	self.carMakeController:Prepare()

	return
end

function CrossRoadCarMgr:Step(arg_4_1)
	self.deltaTime = self.deltaTime + arg_4_1
	self.makedelayTime = CrossRoadGameConst.MAKE_CAR_TIME[math.max(math.min(self._data:GetRoundCnt(), #CrossRoadGameConst.MAKE_CAR_TIME), 1)]

	if self.deltaTime > self.lastMakeTime + self.makedelayTime then
		self.lastMakeTime = self.deltaTime

		self.carMakeController:MakeRandomCar(self.deltaTime)
	end

	self.carMakeController:Step()
	self.carMoveController:Step(arg_4_1)

	return
end

function CrossRoadCarMgr:Clear()
	self.time = 0

	self.carMakeController:Clear()
	self.carMoveController:Clear()

	return
end

return CrossRoadCarMgr
