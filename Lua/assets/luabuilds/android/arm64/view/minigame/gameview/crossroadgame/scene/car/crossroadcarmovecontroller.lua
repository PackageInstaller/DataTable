local var_0_0 = class("CrossRoadCarMoveController")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._runningData = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0.sceneRoadTF = arg_1_1:GetRoadTF(CrossRoadGameConst.SCENE_ROAD_NAME)
	arg_1_0.sceneRoadList = arg_1_1:GetRoadList(CrossRoadGameConst.SCENE_ROAD_NAME)
	arg_1_0.addScale = CrossRoadGameConst.ADD_CAR_SCALE
	arg_1_0.startScale = CrossRoadGameConst.START_CAR_SCALE
	arg_1_0.walkLineEnd = arg_1_1:GetFrontRoadUnderLine()
	arg_1_0.itemLine = arg_1_1:GetFrontRoadDistance()
	arg_1_0.spCarState = CrossRoadGameConst.SP_CAR_MOVE

	return
end

function var_0_0.Step(arg_2_0, arg_2_1)
	arg_2_0.carMapList = arg_2_0._runningData:GetTrackCarGoList()

	for iter_2_0 = 1, CrossRoadGameConst.GAME_TRACK_COUNT do
		for iter_2_1, iter_2_2 in ipairs(arg_2_0.carMapList[iter_2_0]) do
			arg_2_0:UpdateCarMove(iter_2_2, arg_2_1)
		end
	end

	return
end

function var_0_0.UpdateCarRunningState(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:GetTrack()

	if var_3_0 == CrossRoadGameConst.BACK_ROAD_NAME then
		arg_3_0:SetCarInSceneTrack(arg_3_1)
	elseif var_3_0 == CrossRoadGameConst.SCENE_ROAD_NAME then
		arg_3_0:SetCarInFrontTrack(arg_3_1)
	elseif var_3_0 == CrossRoadGameConst.FRONT_ROAD_NAME then
		arg_3_1:SetDispose(true)
	elseif var_3_0 == CrossRoadGameConst.SP_ROAD_NAME then
		arg_3_0:SetSpCarState(arg_3_1)
	end

	return
end

function var_0_0.SetSpCarState(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:GetState()

	if var_4_0 == arg_4_0.spCarState.start then
		if arg_4_1:GetId() == CrossRoadGameConst.XINZEXI then
			local var_4_1 = arg_4_0:GetNearTrackId((arg_4_1:GetSpTrackId()))

			arg_4_1:SetSpTrackId(var_4_1)
			arg_4_1:SetTarget((arg_4_0:GetDownerthirdPosByTrackId(var_4_1)))
			arg_4_1:SetState(arg_4_0.spCarState.mid)
		else
			arg_4_0:SetSpCarInMoveEnd(arg_4_1)
		end
	elseif var_4_0 == arg_4_0.spCarState.mid then
		arg_4_1:SetSpTrackId((arg_4_0:GetNearTrackId((arg_4_1:GetSpTrackId()))))
		arg_4_0:SetSpCarInMoveEnd(arg_4_1)
	elseif var_4_0 == arg_4_0.spCarState.moveEnd then
		arg_4_0:SetCarInFrontTrack(arg_4_1)
	end

	return
end

function var_0_0.SetSpCarInMoveEnd(arg_5_0, arg_5_1)
	arg_5_1:SetTarget(arg_5_0.sceneRoadList[arg_5_1:GetSpTrackId()].midTF.anchoredPosition)
	arg_5_1:SetState(arg_5_0.spCarState.moveEnd)

	return
end

function var_0_0.SetCarInSceneTrack(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:GetTrackID()
	local var_6_1 = arg_6_0.sceneRoadList[var_6_0].midTF.anchoredPosition

	arg_6_1:SetParent((arg_6_0.sceneRoadTF:Find(tostring(var_6_0))))
	arg_6_1:SetPosition(arg_6_0.sceneRoadList[var_6_0].startTF.anchoredPosition)

	if CrossRoadGameHelper:CheckIsSPCar(arg_6_1:GetId()) then
		arg_6_1:SetSpTrackId(arg_6_0:GetNearTrackId(var_6_0))

		var_6_1 = arg_6_0:GetUperQuarterPosByTrackId(var_6_0)

		arg_6_1:SetTarget(var_6_1)
		arg_6_1:SetTrack(CrossRoadGameConst.SP_ROAD_NAME)
		arg_6_1:SetState(arg_6_0.spCarState.start)
	else
		arg_6_1:SetTarget(var_6_1)
		arg_6_1:SetTrack(CrossRoadGameConst.SCENE_ROAD_NAME)
	end

	return
end

function var_0_0.SetCarInFrontTrack(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1:GetTrackID()

	if CrossRoadGameHelper:CheckIsSPCar(arg_7_1:GetId()) then
		var_7_0 = arg_7_1:GetSpTrackId()
	end

	arg_7_1:SetPosition(arg_7_0.sceneRoadList[var_7_0].midTF.anchoredPosition)
	arg_7_1:SetTarget(arg_7_0.sceneRoadList[var_7_0].endTF.anchoredPosition)
	arg_7_1:SetDirect({
		0,
		-1
	})
	arg_7_1:SetTrack(CrossRoadGameConst.FRONT_ROAD_NAME)

	return
end

function var_0_0.UpdateCarMove(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1:GetPosition()
	local var_8_1 = arg_8_1:GetSpeed()
	local var_8_2 = arg_8_1:GetDirect()
	local var_8_3 = arg_8_1:GetTarget()
	local var_8_4 = arg_8_1:GetTrackID()
	local var_8_5 = arg_8_1:GetTrack()
	local var_8_6 = arg_8_1:GetId()
	local var_8_7 = 1

	if var_8_5 == CrossRoadGameConst.SCENE_ROAD_NAME then
		var_8_7 = arg_8_0:GetCarNowAddScale(var_8_0, var_8_4)

		arg_8_1:SetScale(Vector3(var_8_7, var_8_7, 1))

		var_8_2 = arg_8_0:GetNorCarDirct(var_8_0, var_8_4)
	elseif var_8_5 == CrossRoadGameConst.FRONT_ROAD_NAME then
		var_8_7 = arg_8_0.addScale + arg_8_0.startScale

		if var_8_0.y < arg_8_0.walkLineEnd then
			var_8_7 = 3
		end

		if CrossRoadGameHelper:CheckIsSPCar(arg_8_1:GetId()) then
			var_8_4 = arg_8_1:GetSpTrackId()
		end

		var_8_2 = arg_8_0:GetEndCarDirct(var_8_0, var_8_4)
	elseif var_8_5 == CrossRoadGameConst.SP_ROAD_NAME then
		var_8_7 = arg_8_0:GetCarNowAddScale(var_8_0, var_8_4)

		arg_8_1:SetScale(Vector3(var_8_7, var_8_7, 1))

		var_8_2 = arg_8_0:GetSpCarDirct(arg_8_1)
	end

	local var_8_8 = var_8_7 * arg_8_0:GetCarSpeed(arg_8_1, var_8_2)
	local var_8_9 = Vector2(var_8_0.x + ({
		var_8_8 * var_8_2[1] * arg_8_2,
		var_8_8 * var_8_2[2] * arg_8_2
	})[1], var_8_0.y + ({
		var_8_8 * var_8_2[1] * arg_8_2,
		var_8_8 * var_8_2[2] * arg_8_2
	})[2])

	if var_8_5 == CrossRoadGameConst.FRONT_ROAD_NAME then
		arg_8_0:SpCarCheckAndMakeItem(arg_8_1, var_8_9, var_8_0)

		if arg_8_0:CheckCarNeedEndDispose(arg_8_1) then
			return
		end
	end

	if CrossRoadGameHelper:OnSeg(var_8_9, var_8_3, var_8_0) then
		arg_8_0:UpdateCarRunningState(arg_8_1)
	else
		arg_8_1:SetPosition(var_8_9)
	end

	return
end

function var_0_0.SpCarCheckAndMakeItem(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if CrossRoadGameHelper:CheckIsSPCar(arg_9_1:GetId()) ~= true then
		return
	end

	if CrossRoadGameHelper:isMiddle(arg_9_3.y, arg_9_0.itemLine, arg_9_2.y) and arg_9_0:CanSpCarMakeItem(arg_9_1) then
		local var_9_0 = arg_9_1:GetSpTrackId()

		if arg_9_1:GetId() == CrossRoadGameConst.XINZEXI then
			arg_9_1:SetSpCarAction(function()
				arg_9_0._event(CrossRoadGameConst.MAKE_BING_MIAN, var_9_0)

				return
			end)
		else
			arg_9_0._event(CrossRoadGameConst.MAKE_XUAN_WO, (arg_9_1:GetSpTrackId()))
		end
	end

	return
end

function var_0_0.CheckCarNeedEndDispose(arg_11_0, arg_11_1)
	if arg_11_1:GetPosition().y < arg_11_0.sceneRoadList[arg_11_1:GetTrackID()].endTF.anchoredPosition.y then
		arg_11_0:UpdateCarRunningState(arg_11_1)

		return true
	end

	return false
end

function var_0_0.CanSpCarMakeItem(arg_12_0, arg_12_1)
	local var_12_0 = math.random(1, 100)
	local var_12_1 = 0

	var_12_1 = arg_12_1:GetId() == CrossRoadGameConst.XINZEXI and CrossRoadGameConst.BINGMIAN_MAKE_PROBABILITY or CrossRoadGameConst.XUANWO_MAKE_PROBABILITY

	return var_12_1 < var_12_0
end

function var_0_0.GetCarNowAddScale(arg_13_0, arg_13_1, arg_13_2)
	return arg_13_0.addScale * arg_13_0:GetCarNowScale(arg_13_1, arg_13_2) + arg_13_0.startScale
end

function var_0_0.GetCarNowScale(arg_14_0, arg_14_1, arg_14_2)
	return (arg_14_0.sceneRoadList[arg_14_2].startTF.anchoredPosition.y - arg_14_1.y) / (arg_14_0.sceneRoadList[arg_14_2].startTF.anchoredPosition.y - arg_14_0.sceneRoadList[arg_14_2].midTF.anchoredPosition.y)
end

function var_0_0.GetNorCarDirct(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = CrossRoadGameHelper:GetPosDis(arg_15_1, arg_15_0.sceneRoadList[arg_15_2].midTF.anchoredPosition)

	return {
		(arg_15_0.sceneRoadList[arg_15_2].midTF.anchoredPosition.x - arg_15_1.x) / var_15_0,
		(arg_15_0.sceneRoadList[arg_15_2].midTF.anchoredPosition.y - arg_15_1.y) / var_15_0
	}
end

function var_0_0.GetEndCarDirct(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = CrossRoadGameHelper:GetPosDis(arg_16_1, arg_16_0.sceneRoadList[arg_16_2].endTF.anchoredPosition)

	return {
		(arg_16_0.sceneRoadList[arg_16_2].endTF.anchoredPosition.x - arg_16_1.x) / var_16_0,
		(arg_16_0.sceneRoadList[arg_16_2].endTF.anchoredPosition.y - arg_16_1.y) / var_16_0
	}
end

function var_0_0.GetNearTrackId(arg_17_0, arg_17_1)
	if arg_17_1 >= 4 then
		return math.random(4, 6)
	end

	if arg_17_1 <= 3 then
		return math.random(1, 3)
	end

	return arg_17_1
end

function var_0_0.GetUperQuarterPosByTrackId(arg_18_0, arg_18_1)
	return (CrossRoadGameHelper:GetHalfPos(arg_18_0.sceneRoadList[arg_18_1].startTF.anchoredPosition, (CrossRoadGameHelper:GetHalfPos(arg_18_0.sceneRoadList[arg_18_1].startTF.anchoredPosition, arg_18_0.sceneRoadList[arg_18_1].midTF.anchoredPosition))))
end

function var_0_0.GetDownerthirdPosByTrackId(arg_19_0, arg_19_1)
	return (CrossRoadGameHelper:GetThirdPos(arg_19_0.sceneRoadList[arg_19_1].midTF.anchoredPosition, arg_19_0.sceneRoadList[arg_19_1].startTF.anchoredPosition))
end

function var_0_0.GetCarSpeed(arg_20_0, arg_20_1, arg_20_2)
	return arg_20_1:GetSpeed() / math.abs(arg_20_2[2])
end

function var_0_0.GetSpCarDirct(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1:GetTarget()
	local var_21_1 = arg_21_1:GetPosition()
	local var_21_2 = CrossRoadGameHelper:GetPosDis(var_21_0, var_21_1)

	return {
		(var_21_0.x - var_21_1.x) / var_21_2,
		(var_21_0.y - var_21_1.y) / var_21_2
	}
end

function var_0_0.Clear(arg_22_0)
	return
end

return var_0_0
