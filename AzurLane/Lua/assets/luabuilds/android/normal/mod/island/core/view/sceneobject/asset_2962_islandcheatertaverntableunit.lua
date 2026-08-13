class = var_0_10000

local var_0_0 = "IslandCheaterTavernTableUnit"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandSceneUnit"))
local var_0_2 = 180

function var_0_1.OnAttach(arg_1_0, arg_1_1)
	var_0_1.super.OnAttach(arg_1_0, arg_1_1)

	tf = var_2
	arg_1_0.tf = var_2(arg_1_1)

	local var_1_0 = arg_1_0.tf
	local var_1_1 = var_2.GetComponent

	typeof = var_4
	UnityEngine = var_1_10005
	arg_1_0.animator = var_1_1(var_1_0, var_4(var_1_10005.Animator))
	bindComponent = var_2

	var_2(arg_1_0, arg_1_1)

	local var_1_2 = arg_1_0.decorationtf
	local var_1_3 = var_2.GetComponent

	typeof = var_4
	UnityEngine = var_5
	arg_1_0.decorationAnimator = var_1_3(var_1_2, var_4(var_5.Animator))
	setActive = var_2

	var_2(arg_1_0.trunTalbeTip, false)

	setActive = var_2

	var_2(arg_1_0.boomShoot, false)

	return
end

function var_0_1.OnDetach(arg_2_0)
	bindComponent = var_1_10001

	var_1_10001(arg_2_0, arg_2_0.tf, true)
	var_0_1.super.OnDetach(arg_2_0)

	return
end

function var_0_1.OnFirstTakeShootTip(arg_3_0, arg_3_1)
	setActive = var_1_10002

	var_1_10002(arg_3_0.trunTalbeTip, true)

	local var_3_0 = arg_3_0.animator

	var_2.SetTrigger(var_3_0, "open")

	local var_3_1 = arg_3_0.decorationAnimator

	var_2.SetTrigger(var_3_1, "open")
	arg_3_0:InitRotationBySeat(arg_3_1)
	arg_3_0:InitBombId({})

	return
end

function var_0_1.InitBombId(arg_4_0, arg_4_1)
	local function var_4_0(arg_5_0)
		ipairs = var_2_10001

		for iter_5_0, iter_5_1 in var_2_10001(arg_4_1) do
			if iter_5_1 == arg_5_0 then
				return true
			end
		end

		return false
	end

	for iter_4_0 = 1, 6 do
		local var_4_1 = var_4_0(iter_4_0)

		setActive = var_8

		local var_4_2 = "bombId"

		tostring = var_1_10010

		var_8(arg_4_0[var_4_2 .. var_1_10010(iter_4_0)], var_4_1)
	end

	return
end

function var_0_1.GetPrevIds(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = {}

	for iter_6_0 = 1, arg_6_3 do
		local var_6_1 = (arg_6_2 - iter_6_0 - 1) % arg_6_1 + 1

		var_6_0[#var_6_0 + 1] = var_6_1
	end

	return var_6_0
end

function var_0_1.InitRotationBySeat(arg_7_0, arg_7_1)
	IslandCheaterTavernConst = var_1_10002

	local var_7_0 = var_1_10002.seatRotatonY[arg_7_1] - 90
	local var_7_1 = arg_7_0.tableRoot.transform

	Vector3 = var_1_10005
	var_7_1.localEulerAngles = var_1_10005(0, var_7_0, 0)

	local var_7_2 = arg_7_0.centerRoot

	Vector3 = var_5

	local var_7_3 = 0

	IslandCheaterTavernConst = var_7
	var_7_2.localEulerAngles = var_5(var_7_3, var_7.seatRotatonY[arg_7_1], 0)

	return
end

function var_0_1.OnShoot(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	if arg_8_1 and arg_8_4 == 1 then
		setActive = var_1_10006

		var_1_10006(arg_8_0.trunTalbeTip, false)

		arg_8_0.firstTakeShoot = true
	else
		var_1_10007 = arg_8_0.animator

		var_6.SetTrigger(var_1_10007, "open")

		var_1_10007 = arg_8_0.decorationAnimator

		var_6.SetTrigger(var_1_10007, "open")

		arg_8_0.shootOpenTime = 0
		var_1_10007 = arg_8_0

		arg_8_0.InitRotationBySeat(var_1_10007, arg_8_2)

		var_1_10007 = arg_8_0

		local var_8_0 = arg_8_0.GetPrevIds(var_1_10007, 6, arg_8_3, arg_8_4 - 1)

		arg_8_0:InitBombId(var_8_0)
	end

	arg_8_0.curBombId = arg_8_3
	arg_8_0.hasBombCount = arg_8_4
	arg_8_0.gotShoot = arg_8_5

	if arg_8_0.hasBombCount == 1 then
		IslandCheaterTavernConst = var_6
		arg_8_0.rotateDuration = var_6.firstTurnTime

		local var_8_1 = arg_8_0.turntabletf

		Vector3 = var_1_10007
		var_8_1.localEulerAngles = var_1_10007(0, 0, 0)
		arg_8_0.endRotationY = -60 * (arg_8_0.curBombId - 1)
		IslandCheaterTavernConst = var_6
		arg_8_0.rotateTotalAngle = var_6.turnCircleCount * 360 + arg_8_0.endRotationY
		arg_8_0.rotateStartEuler = arg_8_0.turntabletf.localEulerAngles
	else
		local var_8_2 = arg_8_0.curBombId - 1 == 0 and 6 or var_8_2
		local var_8_3 = -60 * (var_8_2 - 1)
		local var_8_4 = arg_8_0.turntabletf

		Vector3 = var_1_10009
		var_8_4.localEulerAngles = var_1_10009(0, var_8_3, 0)
		IslandCheaterTavernConst = var_8_4
		arg_8_0.rotateDuration = var_8_4.afterTurnTime
		arg_8_0.stepStartY = arg_8_0.turntabletf.localEulerAngles.y
		arg_8_0.stepTargetY = arg_8_0.stepStartY - 60
	end

	return
end

function var_0_1.OnUpdate(arg_9_0)
	local var_9_0 = false

	if arg_9_0.shootOpenTime ~= nil then
		local var_9_1 = arg_9_0.shootOpenTime

		Time = var_1_10003
		arg_9_0.shootOpenTime = var_9_1 + var_1_10003.deltaTime

		local var_9_2 = arg_9_0.shootOpenTime

		if 0.2 <= var_9_2 then
			var_9_0 = true
			arg_9_0.shootOpenTime = nil
		end
	end

	if arg_9_0.firstTakeShoot then
		var_9_0 = true
		arg_9_0.firstTakeShoot = false
	end

	if var_9_0 then
		arg_9_0.rotateTime = 0

		if arg_9_0.hasBombCount == 1 then
			arg_9_0.isRotating = true
		else
			arg_9_0.trunToNextBomb = true
		end
	end

	if arg_9_0.isRotating then
		local var_9_3 = arg_9_0.rotateTime

		Time = var_1_10003
		arg_9_0.rotateTime = var_9_3 + var_1_10003.deltaTime
		Mathf = var_2

		local var_9_4 = var_2.Clamp01(arg_9_0.rotateTime / arg_9_0.rotateDuration)

		Mathf = var_1_10003
		var_1_10003 = var_1_10003.SmoothStep(0, 1, var_9_4)

		local var_9_5 = arg_9_0.rotateStartEuler.y + arg_9_0.rotateTotalAngle * var_1_10003
		local var_9_6 = arg_9_0.turntabletf

		Vector3 = var_6
		var_9_6.localEulerAngles = var_6(arg_9_0.rotateStartEuler.x, var_9_5, arg_9_0.rotateStartEuler.z)

		if var_9_4 >= 1 then
			arg_9_0.isRotating = false

			local var_9_7 = arg_9_0.turntabletf

			Vector3 = var_6
			var_9_7.localEulerAngles = var_6(arg_9_0.rotateStartEuler.x, arg_9_0.rotateStartEuler.y + arg_9_0.endRotationY, arg_9_0.rotateStartEuler.z)

			if arg_9_0.gotShoot then
				setActive = var_5

				var_5(arg_9_0.boomShoot, true)

				onDelayTick = var_5

				var_5(function()
					IsNil = var_2_10000

					if var_2_10000(arg_9_0.boomShoot) then
						return
					end

					setActive = var_0

					var_0(arg_9_0.boomShoot, false)

					local var_10_0 = arg_9_0.animator

					var_0.SetTrigger(var_10_0, "close")

					local var_10_1 = arg_9_0.decorationAnimator

					var_0.SetTrigger(var_10_1, "close")

					return
				end, 1)
			else
				setActive = var_5

				var_5(arg_9_0.noGotShoot, true)

				setActive = var_5

				local var_9_8 = "bombId"

				tostring = var_7

				var_5(arg_9_0[var_9_8 .. var_7(arg_9_0.curBombId)], true)

				onDelayTick = var_5

				var_5(function()
					IsNil = var_2_10000

					if var_2_10000(arg_9_0.noGotShoot) then
						return
					end

					setActive = var_0

					var_0(arg_9_0.noGotShoot, false)

					local var_11_0 = arg_9_0.animator

					var_0.SetTrigger(var_11_0, "close")

					local var_11_1 = arg_9_0.decorationAnimator

					var_0.SetTrigger(var_11_1, "close")

					return
				end, 1)
			end
		end
	end

	if arg_9_0.trunToNextBomb then
		local var_9_9 = arg_9_0.rotateTime

		Time = var_1_10003
		arg_9_0.rotateTime = var_9_9 + var_1_10003.deltaTime
		Mathf = var_2

		local var_9_10 = var_2.Clamp01(arg_9_0.rotateTime / arg_9_0.rotateDuration)

		Mathf = var_3

		local var_9_11 = var_3.SmoothStep(0, 1, var_9_10)

		Mathf = var_4

		local var_9_12 = var_4.LerpAngle(arg_9_0.stepStartY, arg_9_0.stepTargetY, var_9_11)
		local var_9_13 = arg_9_0.turntabletf

		Vector3 = var_6
		var_9_13.localEulerAngles = var_6(0, var_9_12, 0)

		if var_9_10 >= 1 then
			local var_9_14 = arg_9_0.turntabletf

			Vector3 = var_6
			var_9_14.localEulerAngles = var_6(0, arg_9_0.stepTargetY, 0)

			if arg_9_0.gotShoot then
				setActive = var_5

				var_5(arg_9_0.boomShoot, true)

				onDelayTick = var_5

				var_5(function()
					IsNil = var_2_10000

					if var_2_10000(arg_9_0.boomShoot) then
						return
					end

					setActive = var_0

					var_0(arg_9_0.boomShoot, false)

					local var_12_0 = arg_9_0.animator

					var_0.SetTrigger(var_12_0, "close")

					local var_12_1 = arg_9_0.decorationAnimator

					var_0.SetTrigger(var_12_1, "close")

					return
				end, 1)
			else
				setActive = var_5

				var_5(arg_9_0.noGotShoot, true)

				setActive = var_5

				local var_9_15 = "bombId"

				tostring = var_7

				var_5(arg_9_0[var_9_15 .. var_7(arg_9_0.curBombId)], true)

				onDelayTick = var_5

				var_5(function()
					IsNil = var_2_10000

					if var_2_10000(arg_9_0.noGotShoot) then
						return
					end

					setActive = var_0

					var_0(arg_9_0.noGotShoot, false)

					local var_13_0 = arg_9_0.animator

					var_0.SetTrigger(var_13_0, "close")

					local var_13_1 = arg_9_0.decorationAnimator

					var_0.SetTrigger(var_13_1, "close")

					return
				end, 1)
			end

			arg_9_0.trunToNextBomb = false
		end
	end

	return
end

return var_0_1
