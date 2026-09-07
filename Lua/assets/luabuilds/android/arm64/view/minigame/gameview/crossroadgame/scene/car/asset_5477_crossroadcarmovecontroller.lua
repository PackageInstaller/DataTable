local CrossRoadCarMoveController = class("CrossRoadCarMoveController")

function CrossRoadCarMoveController:Ctor(arg_1_1, arg_1_2)
	self._runningData = arg_1_1
	self._event = arg_1_2
	self.sceneRoadTF = arg_1_1:GetRoadTF(CrossRoadGameConst.SCENE_ROAD_NAME)
	self.sceneRoadList = arg_1_1:GetRoadList(CrossRoadGameConst.SCENE_ROAD_NAME)
	self.addScale = CrossRoadGameConst.ADD_CAR_SCALE
	self.startScale = CrossRoadGameConst.START_CAR_SCALE
	self.walkLineEnd = arg_1_1:GetFrontRoadUnderLine()
	self.itemLine = arg_1_1:GetFrontRoadDistance()
	self.spCarState = CrossRoadGameConst.SP_CAR_MOVE

	return
end

function CrossRoadCarMoveController:Step(arg_2_1)
	self.carMapList = self._runningData:GetTrackCarGoList()

	for iter_2_0 = 1, CrossRoadGameConst.GAME_TRACK_COUNT do
		for iter_2_1, iter_2_2 in ipairs(self.carMapList[iter_2_0]) do
			self:UpdateCarMove(iter_2_2, arg_2_1)
		end
	end

	return
end

function CrossRoadCarMoveController:UpdateCarRunningState(arg_3_1)
	local var_3_0 = arg_3_1:GetTrack()

	if var_3_0 == CrossRoadGameConst.BACK_ROAD_NAME then
		self:SetCarInSceneTrack(arg_3_1)
	elseif var_3_0 == CrossRoadGameConst.SCENE_ROAD_NAME then
		self:SetCarInFrontTrack(arg_3_1)
	elseif var_3_0 == CrossRoadGameConst.FRONT_ROAD_NAME then
		arg_3_1:SetDispose(true)
	elseif var_3_0 == CrossRoadGameConst.SP_ROAD_NAME then
		self:SetSpCarState(arg_3_1)
	end

	return
end

function CrossRoadCarMoveController:SetSpCarState(arg_4_1)
	local var_4_0 = arg_4_1:GetState()

	if var_4_0 == self.spCarState.start then
		if arg_4_1:GetId() == CrossRoadGameConst.XINZEXI then
			local var_4_1 = self:GetNearTrackId((arg_4_1:GetSpTrackId()))

			arg_4_1:SetSpTrackId(var_4_1)
			arg_4_1:SetTarget((self:GetDownerthirdPosByTrackId(var_4_1)))
			arg_4_1:SetState(self.spCarState.mid)
		else
			self:SetSpCarInMoveEnd(arg_4_1)
		end
	elseif var_4_0 == self.spCarState.mid then
		arg_4_1:SetSpTrackId((self:GetNearTrackId((arg_4_1:GetSpTrackId()))))
		self:SetSpCarInMoveEnd(arg_4_1)
	elseif var_4_0 == self.spCarState.moveEnd then
		self:SetCarInFrontTrack(arg_4_1)
	end

	return
end

function CrossRoadCarMoveController:SetSpCarInMoveEnd(arg_5_1)
	arg_5_1:SetTarget(self.sceneRoadList[arg_5_1:GetSpTrackId()].midTF.anchoredPosition)
	arg_5_1:SetState(self.spCarState.moveEnd)

	return
end

function CrossRoadCarMoveController:SetCarInSceneTrack(arg_6_1)
	local var_6_0 = arg_6_1:GetTrackID()
	local var_6_1 = self.sceneRoadList[var_6_0].midTF.anchoredPosition

	arg_6_1:SetParent((self.sceneRoadTF:Find(tostring(var_6_0))))
	arg_6_1:SetPosition(self.sceneRoadList[var_6_0].startTF.anchoredPosition)

	if CrossRoadGameHelper:CheckIsSPCar(arg_6_1:GetId()) then
		arg_6_1:SetSpTrackId(self:GetNearTrackId(var_6_0))

		var_6_1 = self:GetUperQuarterPosByTrackId(var_6_0)

		arg_6_1:SetTarget(var_6_1)
		arg_6_1:SetTrack(CrossRoadGameConst.SP_ROAD_NAME)
		arg_6_1:SetState(self.spCarState.start)
	else
		arg_6_1:SetTarget(var_6_1)
		arg_6_1:SetTrack(CrossRoadGameConst.SCENE_ROAD_NAME)
	end

	return
end

function CrossRoadCarMoveController:SetCarInFrontTrack(arg_7_1)
	local var_7_0 = arg_7_1:GetTrackID()

	if CrossRoadGameHelper:CheckIsSPCar(arg_7_1:GetId()) then
		var_7_0 = arg_7_1:GetSpTrackId()
	end

	arg_7_1:SetPosition(self.sceneRoadList[var_7_0].midTF.anchoredPosition)
	arg_7_1:SetTarget(self.sceneRoadList[var_7_0].endTF.anchoredPosition)
	arg_7_1:SetDirect({
		0,
		-1
	})
	arg_7_1:SetTrack(CrossRoadGameConst.FRONT_ROAD_NAME)

	return
end

function CrossRoadCarMoveController:UpdateCarMove(arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1:GetPosition()
	local var_8_1 = arg_8_1:GetSpeed()
	local var_8_2 = arg_8_1:GetDirect()
	local var_8_3 = arg_8_1:GetTarget()
	local var_8_4 = arg_8_1:GetTrackID()
	local var_8_5 = arg_8_1:GetTrack()
	local var_8_6 = arg_8_1:GetId()
	local var_8_7 = 1

	if var_8_5 == CrossRoadGameConst.SCENE_ROAD_NAME then
		var_8_7 = self:GetCarNowAddScale(var_8_0, var_8_4)

		arg_8_1:SetScale(Vector3(var_8_7, var_8_7, 1))

		var_8_2 = self:GetNorCarDirct(var_8_0, var_8_4)
	elseif var_8_5 == CrossRoadGameConst.FRONT_ROAD_NAME then
		var_8_7 = self.addScale + self.startScale

		if var_8_0.y < self.walkLineEnd then
			var_8_7 = 3
		end

		if CrossRoadGameHelper:CheckIsSPCar(arg_8_1:GetId()) then
			var_8_4 = arg_8_1:GetSpTrackId()
		end

		var_8_2 = self:GetEndCarDirct(var_8_0, var_8_4)
	elseif var_8_5 == CrossRoadGameConst.SP_ROAD_NAME then
		var_8_7 = self:GetCarNowAddScale(var_8_0, var_8_4)

		arg_8_1:SetScale(Vector3(var_8_7, var_8_7, 1))

		var_8_2 = self:GetSpCarDirct(arg_8_1)
	end

	local var_8_8 = var_8_7 * self:GetCarSpeed(arg_8_1, var_8_2)
	local var_8_9 = {
		var_8_8 * var_8_2[1] * arg_8_2,
		var_8_8 * var_8_2[2] * arg_8_2
	}
	local var_8_10 = Vector2(var_8_0.x + var_8_9[1], var_8_0.y + var_8_9[2])

	if var_8_5 == CrossRoadGameConst.FRONT_ROAD_NAME then
		self:SpCarCheckAndMakeItem(arg_8_1, var_8_10, var_8_0)

		if self:CheckCarNeedEndDispose(arg_8_1) then
			return
		end
	end

	if CrossRoadGameHelper:OnSeg(var_8_10, var_8_3, var_8_0) then
		self:UpdateCarRunningState(arg_8_1)
	else
		arg_8_1:SetPosition(var_8_10)
	end

	return
end

function CrossRoadCarMoveController:SpCarCheckAndMakeItem(arg_9_1, arg_9_2, arg_9_3)
	if CrossRoadGameHelper:CheckIsSPCar(arg_9_1:GetId()) ~= true then
		return
	end

	if CrossRoadGameHelper:isMiddle(arg_9_3.y, self.itemLine, arg_9_2.y) and self:CanSpCarMakeItem(arg_9_1) then
		local var_9_0 = arg_9_1:GetSpTrackId()

		if arg_9_1:GetId() == CrossRoadGameConst.XINZEXI then
			arg_9_1:SetSpCarAction(function()
				self._event(CrossRoadGameConst.MAKE_BING_MIAN, var_9_0)

				return
			end)
		else
			self._event(CrossRoadGameConst.MAKE_XUAN_WO, var_9_0)
		end
	end

	return
end

function CrossRoadCarMoveController:CheckCarNeedEndDispose(arg_11_1)
	if arg_11_1:GetPosition().y < self.sceneRoadList[arg_11_1:GetTrackID()].endTF.anchoredPosition.y then
		self:UpdateCarRunningState(arg_11_1)

		return true
	end

	return false
end

function CrossRoadCarMoveController:CanSpCarMakeItem(arg_12_1)
	return (arg_12_1:GetId() == CrossRoadGameConst.XINZEXI and CrossRoadGameConst.BINGMIAN_MAKE_PROBABILITY or CrossRoadGameConst.XUANWO_MAKE_PROBABILITY) < math.random(1, 100)
end

function CrossRoadCarMoveController:GetCarNowAddScale(arg_13_1, arg_13_2)
	return self.addScale * self:GetCarNowScale(arg_13_1, arg_13_2) + self.startScale
end

function CrossRoadCarMoveController:GetCarNowScale(arg_14_1, arg_14_2)
	return (self.sceneRoadList[arg_14_2].startTF.anchoredPosition.y - arg_14_1.y) / (self.sceneRoadList[arg_14_2].startTF.anchoredPosition.y - self.sceneRoadList[arg_14_2].midTF.anchoredPosition.y)
end

function CrossRoadCarMoveController:GetNorCarDirct(arg_15_1, arg_15_2)
	local var_15_0 = CrossRoadGameHelper:GetPosDis(arg_15_1, self.sceneRoadList[arg_15_2].midTF.anchoredPosition)

	return {
		(self.sceneRoadList[arg_15_2].midTF.anchoredPosition.x - arg_15_1.x) / var_15_0,
		(self.sceneRoadList[arg_15_2].midTF.anchoredPosition.y - arg_15_1.y) / var_15_0
	}
end

function CrossRoadCarMoveController:GetEndCarDirct(arg_16_1, arg_16_2)
	local var_16_0 = CrossRoadGameHelper:GetPosDis(arg_16_1, self.sceneRoadList[arg_16_2].endTF.anchoredPosition)

	return {
		(self.sceneRoadList[arg_16_2].endTF.anchoredPosition.x - arg_16_1.x) / var_16_0,
		(self.sceneRoadList[arg_16_2].endTF.anchoredPosition.y - arg_16_1.y) / var_16_0
	}
end

function CrossRoadCarMoveController:GetNearTrackId(arg_17_1)
	if arg_17_1 >= 4 then
		return math.random(4, 6)
	end

	if arg_17_1 <= 3 then
		return math.random(1, 3)
	end

	return arg_17_1
end

function CrossRoadCarMoveController:GetUperQuarterPosByTrackId(arg_18_1)
	return (CrossRoadGameHelper:GetHalfPos(self.sceneRoadList[arg_18_1].startTF.anchoredPosition, (CrossRoadGameHelper:GetHalfPos(self.sceneRoadList[arg_18_1].startTF.anchoredPosition, self.sceneRoadList[arg_18_1].midTF.anchoredPosition))))
end

function CrossRoadCarMoveController:GetDownerthirdPosByTrackId(arg_19_1)
	return (CrossRoadGameHelper:GetThirdPos(self.sceneRoadList[arg_19_1].midTF.anchoredPosition, self.sceneRoadList[arg_19_1].startTF.anchoredPosition))
end

function CrossRoadCarMoveController:GetCarSpeed(arg_20_1, arg_20_2)
	return arg_20_1:GetSpeed() / math.abs(arg_20_2[2])
end

function CrossRoadCarMoveController:GetSpCarDirct(arg_21_1)
	local var_21_0 = arg_21_1:GetTarget()
	local var_21_1 = arg_21_1:GetPosition()
	local var_21_2 = CrossRoadGameHelper:GetPosDis(var_21_0, var_21_1)

	return {
		(var_21_0.x - var_21_1.x) / var_21_2,
		(var_21_0.y - var_21_1.y) / var_21_2
	}
end

function CrossRoadCarMoveController:Clear()
	return
end

return CrossRoadCarMoveController
