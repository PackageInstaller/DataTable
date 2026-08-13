class = var_0_10000

local var_0_0 = var_0_10000("CrossRoadCarMoveController")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._runningData = arg_1_1
	arg_1_0._event = arg_1_2

	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.GetRoadTF

	CrossRoadGameConst = var_1_10006
	arg_1_0.sceneRoadTF = var_1_1(var_1_0, var_1_10006.SCENE_ROAD_NAME)

	local var_1_2 = arg_1_1
	local var_1_3 = arg_1_1.GetRoadList

	CrossRoadGameConst = var_6
	arg_1_0.sceneRoadList = var_1_3(var_1_2, var_6.SCENE_ROAD_NAME)
	CrossRoadGameConst = var_3
	arg_1_0.addScale = var_3.ADD_CAR_SCALE
	CrossRoadGameConst = var_3
	arg_1_0.startScale = var_3.START_CAR_SCALE
	arg_1_0.walkLineEnd = arg_1_1:GetFrontRoadUnderLine()
	arg_1_0.itemLine = arg_1_1:GetFrontRoadDistance()
	CrossRoadGameConst = var_3
	arg_1_0.spCarState = var_3.SP_CAR_MOVE

	return
end

function var_0_0.Step(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0._runningData

	arg_2_0.carMapList = var_2.GetTrackCarGoList(var_2_0)

	local var_2_1 = 1

	CrossRoadGameConst = var_1_10003

	for iter_2_0 = var_2_1, var_1_10003.GAME_TRACK_COUNT do
		ipairs = var_1_10006

		for iter_2_1, iter_2_2 in var_1_10006(arg_2_0.carMapList[iter_2_0]) do
			arg_2_0:UpdateCarMove(iter_2_2, arg_2_1)
		end
	end

	return
end

function var_0_0.UpdateCarRunningState(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:GetTrack()

	CrossRoadGameConst = var_1_10003

	if var_3_0 == var_1_10003.BACK_ROAD_NAME then
		arg_3_0:SetCarInSceneTrack(arg_3_1)
	else
		CrossRoadGameConst = var_3

		if var_3_0 == var_3.SCENE_ROAD_NAME then
			arg_3_0:SetCarInFrontTrack(arg_3_1)
		else
			CrossRoadGameConst = var_3

			if var_3_0 == var_3.FRONT_ROAD_NAME then
				arg_3_1:SetDispose(true)
			else
				CrossRoadGameConst = var_3

				if var_3_0 == var_3.SP_ROAD_NAME then
					arg_3_0:SetSpCarState(arg_3_1)
				end
			end
		end
	end

	return
end

function var_0_0.SetSpCarState(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1

	if arg_4_1.GetState(var_4_0) == arg_4_0.spCarState.start then
		local var_4_1 = arg_4_1:GetId()

		CrossRoadGameConst = var_4_0

		if var_4_1 == var_4_0.XINZEXI then
			local var_4_2 = arg_4_1:GetSpTrackId()
			local var_4_3 = arg_4_0:GetNearTrackId(var_4_2)
			local var_4_4 = arg_4_0:GetDownerthirdPosByTrackId(var_4_3)

			arg_4_1:SetSpTrackId(var_4_3)
			arg_4_1:SetTarget(var_4_4)
			arg_4_1:SetState(arg_4_0.spCarState.mid)
		else
			arg_4_0:SetSpCarInMoveEnd(arg_4_1)
		end
	elseif var_2 == arg_4_0.spCarState.mid then
		local var_4_5 = arg_4_1:GetSpTrackId()
		local var_4_6 = arg_4_0:GetNearTrackId(var_4_5)

		arg_4_1:SetSpTrackId(var_4_6)
		arg_4_0:SetSpCarInMoveEnd(arg_4_1)
	elseif var_2 == arg_4_0.spCarState.moveEnd then
		arg_4_0:SetCarInFrontTrack(arg_4_1)
	end

	return
end

function var_0_0.SetSpCarInMoveEnd(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:GetSpTrackId()
	local var_5_1 = arg_5_0.sceneRoadList[var_5_0].midTF.anchoredPosition

	arg_5_1:SetTarget(var_5_1)
	arg_5_1:SetState(arg_5_0.spCarState.moveEnd)

	return
end

function var_0_0.SetCarInSceneTrack(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:GetTrackID()
	local var_6_1 = arg_6_0.sceneRoadTF
	local var_6_2 = var_3.Find

	tostring = var_1_10006

	local var_6_3 = var_6_2(var_6_1, var_1_10006(var_6_0))
	local var_6_4 = arg_6_0.sceneRoadList[var_6_0].startTF.anchoredPosition
	local var_6_5 = arg_6_0.sceneRoadList[var_6_0].midTF.anchoredPosition

	arg_6_1:SetParent(var_6_3)
	arg_6_1:SetPosition(var_6_4)

	CrossRoadGameHelper = var_6

	if var_6:CheckIsSPCar(arg_6_1:GetId()) then
		arg_6_1:SetSpTrackId(arg_6_0:GetNearTrackId(var_6_0))

		var_6_5 = arg_6_0:GetUperQuarterPosByTrackId(var_6_0)

		arg_6_1:SetTarget(var_6_5)

		local var_6_6 = arg_6_1
		local var_6_7 = arg_6_1.SetTrack

		CrossRoadGameConst = var_9

		var_6_7(var_6_6, var_9.SP_ROAD_NAME)
		arg_6_1:SetState(arg_6_0.spCarState.start)
	else
		arg_6_1:SetTarget(var_6_5)

		local var_6_8 = arg_6_1
		local var_6_9 = arg_6_1.SetTrack

		CrossRoadGameConst = var_9

		var_6_9(var_6_8, var_9.SCENE_ROAD_NAME)
	end

	return
end

function var_0_0.SetCarInFrontTrack(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1:GetTrackID()

	CrossRoadGameHelper = var_1_10003

	if var_1_10003:CheckIsSPCar(arg_7_1:GetId()) then
		var_7_0 = arg_7_1:GetSpTrackId()
	end

	local var_7_1 = arg_7_0.sceneRoadList[var_7_0].midTF.anchoredPosition
	local var_7_2 = arg_7_0.sceneRoadList[var_7_0].endTF.anchoredPosition

	arg_7_1:SetPosition(var_7_1)
	arg_7_1:SetTarget(var_7_2)
	arg_7_1:SetDirect({
		0,
		-1
	})

	local var_7_3 = arg_7_1
	local var_7_4 = arg_7_1.SetTrack

	CrossRoadGameConst = var_8

	var_7_4(var_7_3, var_8.FRONT_ROAD_NAME)

	return
end

function var_0_0.UpdateCarMove(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1:GetPosition()
	local var_8_1 = arg_8_1:GetSpeed()
	local var_8_2 = arg_8_1:GetDirect()
	local var_8_3 = arg_8_1:GetTarget()
	local var_8_4 = arg_8_1:GetTrackID()
	local var_8_5 = arg_8_1:GetTrack()
	local var_8_6 = arg_8_1
	local var_8_7 = arg_8_1.GetId(var_8_6)
	local var_8_8 = 1

	CrossRoadGameConst = var_8_6

	local var_8_10

	if var_8_5 == var_8_6.SCENE_ROAD_NAME then
		var_8_8 = arg_8_0:GetCarNowAddScale(var_8_0, var_8_4)

		local var_8_9 = arg_8_1

		var_8_10 = arg_8_1.SetScale
		Vector3 = var_14

		var_8_10(var_8_9, var_14(var_8_8, var_8_8, 1))

		var_8_2 = arg_8_0:GetNorCarDirct(var_8_0, var_8_4)
	else
		CrossRoadGameConst = var_8_10

		if var_8_5 == var_8_10.FRONT_ROAD_NAME then
			var_8_8 = arg_8_0.addScale + arg_8_0.startScale

			if var_8_0.y < arg_8_0.walkLineEnd then
				var_8_8 = 3
			end

			CrossRoadGameHelper = var_11

			if var_11:CheckIsSPCar(arg_8_1:GetId()) then
				var_8_4 = arg_8_1:GetSpTrackId()
			end

			var_8_2 = arg_8_0:GetEndCarDirct(var_8_0, var_8_4)
		else
			CrossRoadGameConst = var_11

			if var_8_5 == var_11.SP_ROAD_NAME then
				var_8_8 = arg_8_0:GetCarNowAddScale(var_8_0, var_8_4)

				local var_8_11 = arg_8_1
				local var_8_12 = arg_8_1.SetScale

				Vector3 = var_14

				var_8_12(var_8_11, var_14(var_8_8, var_8_8, 1))

				var_8_2 = arg_8_0:GetSpCarDirct(arg_8_1)
			end
		end
	end

	local var_8_13 = arg_8_0
	local var_8_14 = var_8_8 * arg_8_0.GetCarSpeed(var_8_13, arg_8_1, var_8_2)
	local var_8_15 = {
		var_8_14 * var_8_2[1] * arg_8_2,
		var_8_14 * var_8_2[2] * arg_8_2
	}

	Vector2 = var_12

	local var_8_16 = var_12(var_8_0.x + var_8_15[1], var_8_0.y + var_8_15[2])

	CrossRoadGameConst = var_8_13

	if var_8_5 == var_8_13.FRONT_ROAD_NAME then
		arg_8_0:SpCarCheckAndMakeItem(arg_8_1, var_8_16, var_8_0)

		if arg_8_0:CheckCarNeedEndDispose(arg_8_1) then
			return
		end
	end

	CrossRoadGameHelper = var_13

	if var_13:OnSeg(var_8_16, var_8_3, var_8_0) then
		arg_8_0:UpdateCarRunningState(arg_8_1)
	else
		arg_8_1:SetPosition(var_8_16)
	end

	return
end

function var_0_0.SpCarCheckAndMakeItem(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	CrossRoadGameHelper = var_1_10004

	if var_1_10004:CheckIsSPCar(arg_9_1:GetId()) ~= true then
		return
	end

	CrossRoadGameHelper = var_4

	if var_4:isMiddle(arg_9_3.y, arg_9_0.itemLine, arg_9_2.y) and arg_9_0:CanSpCarMakeItem(arg_9_1) then
		local var_9_0 = arg_9_1
		local var_9_1 = arg_9_1.GetSpTrackId(var_9_0)
		local var_9_2 = arg_9_1
		local var_9_3 = arg_9_1.GetId(var_9_2)

		CrossRoadGameConst = var_9_0

		if var_9_3 == var_9_0.XINZEXI then
			var_9_2 = arg_9_1

			arg_9_1.SetSpCarAction(var_9_2, function()
				local var_10_0 = arg_9_0._event

				CrossRoadGameConst = var_2_10002

				var_10_0(var_2_10002.MAKE_BING_MIAN, var_9_1)

				return
			end)
		else
			local var_9_4 = arg_9_0._event

			CrossRoadGameConst = var_9_2

			var_9_4(var_9_2.MAKE_XUAN_WO, var_9_1)
		end
	end

	return
end

function var_0_0.CheckCarNeedEndDispose(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1:GetTrackID()

	if arg_11_1:GetPosition().y < arg_11_0.sceneRoadList[var_11_0].endTF.anchoredPosition.y then
		arg_11_0:UpdateCarRunningState(arg_11_1)

		return true
	end

	return false
end

function var_0_0.CanSpCarMakeItem(arg_12_0, arg_12_1)
	math = var_1_10002

	local var_12_0 = var_1_10002.random(1, 100)
	local var_12_1 = 0
	local var_12_2 = arg_12_1:GetId()

	CrossRoadGameConst = var_5

	if var_12_2 == var_5.XINZEXI then
		CrossRoadGameConst = var_12_2
		var_12_1 = var_12_2.BINGMIAN_MAKE_PROBABILITY
	else
		CrossRoadGameConst = var_12_2
		var_12_1 = var_12_2.XUANWO_MAKE_PROBABILITY
	end

	return var_12_1 < var_12_0
end

function var_0_0.GetCarNowAddScale(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0:GetCarNowScale(arg_13_1, arg_13_2)

	return arg_13_0.addScale * var_13_0 + arg_13_0.startScale
end

function var_0_0.GetCarNowScale(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.sceneRoadList[arg_14_2].startTF.anchoredPosition.y
	local var_14_1 = arg_14_0.sceneRoadList[arg_14_2].midTF.anchoredPosition.y

	return (var_14_0 - arg_14_1.y) / (var_14_0 - var_14_1)
end

function var_0_0.GetNorCarDirct(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.sceneRoadList[arg_15_2].midTF.anchoredPosition

	CrossRoadGameHelper = var_1_10004

	local var_15_1 = var_1_10004:GetPosDis(arg_15_1, var_15_0)

	return {
		(var_15_0.x - arg_15_1.x) / var_15_1,
		(var_15_0.y - arg_15_1.y) / var_15_1
	}
end

function var_0_0.GetEndCarDirct(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0.sceneRoadList[arg_16_2].endTF.anchoredPosition

	CrossRoadGameHelper = var_1_10004

	local var_16_1 = var_1_10004:GetPosDis(arg_16_1, var_16_0)

	return {
		(var_16_0.x - arg_16_1.x) / var_16_1,
		(var_16_0.y - arg_16_1.y) / var_16_1
	}
end

function var_0_0.GetNearTrackId(arg_17_0, arg_17_1)
	if 4 <= arg_17_1 then
		math = var_2

		return var_2.random(4, 6)
	end

	if arg_17_1 <= 3 then
		math = var_2

		return var_2.random(1, 3)
	end

	return arg_17_1
end

function var_0_0.GetUperQuarterPosByTrackId(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.sceneRoadList[arg_18_1].startTF.anchoredPosition
	local var_18_1 = arg_18_0.sceneRoadList[arg_18_1].midTF.anchoredPosition

	CrossRoadGameHelper = var_1_10004

	local var_18_2 = var_1_10004:GetHalfPos(var_18_0, var_18_1)

	CrossRoadGameHelper = var_4

	return (var_4:GetHalfPos(var_18_0, var_18_2))
end

function var_0_0.GetDownerthirdPosByTrackId(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.sceneRoadList[arg_19_1].startTF.anchoredPosition
	local var_19_1 = arg_19_0.sceneRoadList[arg_19_1].midTF.anchoredPosition

	CrossRoadGameHelper = var_1_10004

	return (var_1_10004:GetThirdPos(var_19_1, var_19_0))
end

function var_0_0.GetCarSpeed(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_1:GetSpeed()

	math = var_1_10004

	return var_20_0 / var_1_10004.abs(arg_20_2[2])
end

function var_0_0.GetSpCarDirct(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1
	local var_21_1 = arg_21_1.GetTarget(var_21_0)
	local var_21_2 = arg_21_1:GetPosition()

	CrossRoadGameHelper = var_21_0

	local var_21_3 = var_21_0:GetPosDis(var_21_1, var_21_2)

	return {
		(var_21_1.x - var_21_2.x) / var_21_3,
		(var_21_1.y - var_21_2.y) / var_21_3
	}
end

function var_0_0.Clear(arg_22_0)
	return
end

return var_0_0
