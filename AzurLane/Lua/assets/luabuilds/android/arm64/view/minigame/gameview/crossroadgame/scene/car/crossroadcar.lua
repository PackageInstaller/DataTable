class = var_0_10000

local var_0_0 = var_0_10000("CrossRoadCar")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0._tf = arg_1_1
	arg_1_0._runningData = arg_1_4
	arg_1_0.id = arg_1_2.id
	arg_1_0.trackId = arg_1_3
	arg_1_0.carMsg = arg_1_2
	arg_1_0.speed = arg_1_2.speed
	arg_1_0.width = arg_1_2.width
	arg_1_0.length = arg_1_2.length

	local var_1_0 = arg_1_0._tf

	arg_1_0.spineTF = var_5.Find(var_1_0, "spine")
	GetComponent = var_5
	arg_1_0.spineAnimUI = var_5(arg_1_0.spineTF, "SpineAnimUI")
	CrossRoadGameConst = var_5
	arg_1_0.playingStatus = var_5.CAR_STATE.showBack
	CrossRoadGameConst = var_5
	arg_1_0.playingTrack = var_5.BACK_ROAD_NAME
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
	local var_2_1 = arg_2_0._tf.rect

	return var_2_0.x - var_2_1.width / 2, var_2_0.y, var_2_0.x + var_2_1.width / 2, var_2_0.y + var_2_1.height
end

function var_0_0.SetParent(arg_3_0, arg_3_1)
	setParent = var_1_10002

	var_1_10002(arg_3_0._tf, arg_3_1, false)

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

	local var_8_0 = arg_8_0._tf.localScale.x
	local var_8_1 = arg_8_1
	local var_8_2 = arg_8_1.SetScale

	Vector3 = var_1_10006

	var_8_2(var_8_1, var_1_10006(-1 / var_8_0, 1 / var_8_0, 1))

	local var_8_3 = arg_8_1:GetPosition()
	local var_8_4 = arg_8_0._tf.anchoredPosition
	local var_8_5 = arg_8_1
	local var_8_6 = arg_8_1.SetPosition

	Vector2 = var_8

	var_8_6(var_8_5, var_8(var_8_3.x - var_8_4.x, 0))

	table = var_8_6

	var_8_6.insert(arg_8_0.carCarshList, arg_8_1)

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
	setActive = var_1_10002

	var_1_10002(arg_15_0._tf, arg_15_1)

	return
end

function var_0_0.SetState(arg_16_0, arg_16_1)
	arg_16_0.playingStatus = arg_16_1

	return
end

function var_0_0.GetSpeed(arg_17_0)
	local var_17_0 = arg_17_0._runningData
	local var_17_1 = var_1.GetRoundCnt(var_17_0)

	math = var_1_10002

	local var_17_2 = var_1_10002.min
	local var_17_3 = var_17_1

	CrossRoadGameConst = var_1_10005

	local var_17_4

	if var_17_2(var_17_3, #var_1_10005.CAR_SPEED_SCALE) < 1 then
		var_17_4 = 0
	else
		CrossRoadGameConst = var_17_4
		var_17_4 = var_17_4.CAR_SPEED_SCALE[var_2]
	end

	return arg_17_0.speed * (1 + var_17_4)
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

	local var_22_0 = arg_22_0.spineAnimUI

	var_3.SetAction(var_22_0, arg_22_1, arg_22_2)

	return
end

function var_0_0.SetActionCallBack(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0._spineAnimUI

	var_2.SetActionCallBack(var_23_0, arg_23_1)

	return
end

function var_0_0.setActionNormal(arg_24_0)
	arg_24_0:SetAction("normal", 0)

	return
end

function var_0_0.SetSpCarAction(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0.spineAnimUI

	var_2.SetActionCallBack(var_25_0, function(arg_26_0)
		if arg_26_0 == "finish" then
			local var_26_0 = arg_25_0.spineAnimUI

			var_1.SetActionCallBack(var_26_0, nil)

			local var_26_1 = arg_25_0

			var_1.setActionNormal(var_26_1)

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
		pairs = var_1

		for iter_32_0, iter_32_1 in var_1(arg_32_0.carCarshList) do
			if iter_32_1 ~= nil then
				iter_32_1:Clear()
			end
		end
	end

	arg_32_0.carCarshList = {}

	if arg_32_0._tf then
		destroy = var_1

		var_1(arg_32_0._tf)

		arg_32_0._tf = nil
	end

	arg_32_0.playingAction = nil

	if arg_32_0.spineAnimUI then
		local var_32_0 = arg_32_0.spineAnimUI

		var_1.SetActionCallBack(var_32_0, nil)

		arg_32_0.spineAnimUi = nil
	end

	arg_32_0.target = nil

	return
end

return var_0_0
