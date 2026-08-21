local var_0_0 = class("CrossRoadCar")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0._tf = arg_1_1
	arg_1_0._runningData = arg_1_4
	arg_1_0.id = arg_1_2.id
	arg_1_0.trackId = arg_1_3
	arg_1_0.carMsg = arg_1_2
	arg_1_0.speed = arg_1_2.speed
	arg_1_0.width = arg_1_2.width
	arg_1_0.length = arg_1_2.length
	arg_1_0.spineTF = arg_1_0._tf:Find("spine")
	arg_1_0.spineAnimUI = GetComponent(arg_1_0.spineTF, "SpineAnimUI")
	arg_1_0.playingStatus = CrossRoadGameConst.CAR_STATE.showBack
	arg_1_0.playingTrack = CrossRoadGameConst.BACK_ROAD_NAME
	arg_1_0.playingAction = "normal"
	arg_1_0.target = nil
	arg_1_0.pos = nil
	arg_1_0.needDispose = false
	arg_1_0.carCarshList = {}
	arg_1_0.direct = {
		0,
		1
	}

	arg_1_0:setActionNormal()

	return
end

function var_0_0.GetCarRectPoint(arg_2_0)
	local var_2_0 = arg_2_0:GetPosition()

	return var_2_0.x - arg_2_0._tf.rect.width / 2, var_2_0.y, var_2_0.x + arg_2_0._tf.rect.width / 2, var_2_0.y + arg_2_0._tf.rect.height
end

function var_0_0.SetParent(arg_3_0, arg_3_1)
	setParent(arg_3_0._tf, arg_3_1, false)

	return
end

function var_0_0.SetPosition(arg_4_0, arg_4_1)
	arg_4_0._tf.anchoredPosition = arg_4_1

	return
end

function var_0_0.SetDispose(arg_5_0, arg_5_1)
	arg_5_0.needDispose = arg_5_1

	return
end

function var_0_0.GetNeedDispose(arg_6_0)
	return arg_6_0.needDispose
end

function var_0_0.GetId(arg_7_0)
	return arg_7_0.id
end

function var_0_0.SetCarCrashList(arg_8_0, arg_8_1)
	arg_8_1:SetParent(arg_8_0._tf)
	arg_8_1:SetScale(Vector3(-1 / arg_8_0._tf.localScale.x, 1 / arg_8_0._tf.localScale.x, 1))
	arg_8_1:SetPosition(Vector2(arg_8_1:GetPosition().x - arg_8_0._tf.anchoredPosition.x, 0))
	table.insert(arg_8_0.carCarshList, arg_8_1)

	return
end

function var_0_0.GetPosition(arg_9_0)
	return arg_9_0._tf.anchoredPosition
end

function var_0_0.SetDirect(arg_10_0, arg_10_1)
	arg_10_0.direct = arg_10_1

	return
end

function var_0_0.GetDirect(arg_11_0)
	return arg_11_0.direct
end

function var_0_0.SetTarget(arg_12_0, arg_12_1)
	arg_12_0.target = arg_12_1

	return
end

function var_0_0.GetTarget(arg_13_0)
	return arg_13_0.target
end

function var_0_0.SetScale(arg_14_0, arg_14_1)
	arg_14_0._tf.localScale = arg_14_1

	return
end

function var_0_0.SetActive(arg_15_0, arg_15_1)
	setActive(arg_15_0._tf, arg_15_1)

	return
end

function var_0_0.SetState(arg_16_0, arg_16_1)
	arg_16_0.playingStatus = arg_16_1

	return
end

function var_0_0.GetSpeed(arg_17_0)
	local var_17_0 = math.min(arg_17_0._runningData:GetRoundCnt(), #CrossRoadGameConst.CAR_SPEED_SCALE)

	return arg_17_0.speed * (1 + (var_17_0 < 1 and 0 or CrossRoadGameConst.CAR_SPEED_SCALE[var_17_0]))
end

function var_0_0.GetState(arg_18_0)
	return arg_18_0.playingStatus
end

function var_0_0.GetTrack(arg_19_0)
	return arg_19_0.playingTrack
end

function var_0_0.SetTrack(arg_20_0, arg_20_1)
	arg_20_0.playingTrack = arg_20_1

	return
end

function var_0_0.GetTrackID(arg_21_0)
	return arg_21_0.trackId
end

function var_0_0.SetAction(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_0.playingAction == arg_22_1 then
		return
	end

	arg_22_0.playingAction = arg_22_1

	arg_22_0.spineAnimUI:SetAction(arg_22_1, arg_22_2)

	return
end

function var_0_0.SetActionCallBack(arg_23_0, arg_23_1)
	arg_23_0._spineAnimUI:SetActionCallBack(arg_23_1)

	return
end

function var_0_0.setActionNormal(arg_24_0)
	arg_24_0:SetAction("normal", 0)

	return
end

function var_0_0.SetSpCarAction(arg_25_0, arg_25_1)
	arg_25_0.spineAnimUI:SetActionCallBack(function(arg_26_0)
		if arg_26_0 == "finish" then
			arg_25_0.spineAnimUI:SetActionCallBack(nil)
			arg_25_0:setActionNormal()

			if arg_25_1 then
				arg_25_1()
			end
		end

		return
	end)
	arg_25_0:SetAction("action", 0)

	return
end

function var_0_0.SetSpTrackId(arg_27_0, arg_27_1)
	arg_27_0.spTrackId = arg_27_1

	return
end

function var_0_0.GetSpTrackId(arg_28_0)
	return arg_28_0.spTrackId
end

function var_0_0.SetSpCarState(arg_29_0, arg_29_1)
	arg_29_0.spCarState = arg_29_1

	return
end

function var_0_0.GetSpCarState(arg_30_0)
	return arg_30_0.spCarState
end

function var_0_0.Clear(arg_31_0)
	return
end

function var_0_0.Dispose(arg_32_0)
	if arg_32_0.carCarshList then
		for iter_32_0, iter_32_1 in pairs(arg_32_0.carCarshList) do
			if iter_32_1 ~= nil then
				iter_32_1:Clear()
			end
		end
	end

	arg_32_0.carCarshList = {}

	if arg_32_0._tf then
		destroy(arg_32_0._tf)

		arg_32_0._tf = nil
	end

	arg_32_0.playingAction = nil

	if arg_32_0.spineAnimUI then
		arg_32_0.spineAnimUI:SetActionCallBack(nil)

		arg_32_0.spineAnimUi = nil
	end

	arg_32_0.target = nil

	return
end

return var_0_0
