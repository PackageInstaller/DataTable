local var_0_0 = class("IslandCheaterTavernTableUnit", import(".IslandSceneUnit"))

function var_0_0.OnAttach(arg_1_0, arg_1_1)
	var_0_0.super.OnAttach(arg_1_0, arg_1_1)

	arg_1_0.tf = tf(arg_1_1)
	arg_1_0.animator = arg_1_0.tf:GetComponent(typeof(UnityEngine.Animator))

	bindComponent(arg_1_0, arg_1_1)

	arg_1_0.decorationAnimator = arg_1_0.decorationtf:GetComponent(typeof(UnityEngine.Animator))

	setActive(arg_1_0.trunTalbeTip, false)
	setActive(arg_1_0.boomShoot, false)

	return
end

function var_0_0.OnDetach(arg_2_0)
	bindComponent(arg_2_0, arg_2_0.tf, true)
	var_0_0.super.OnDetach(arg_2_0)

	return
end

function var_0_0.OnFirstTakeShootTip(arg_3_0, arg_3_1)
	setActive(arg_3_0.trunTalbeTip, true)
	arg_3_0.animator:SetTrigger("open")
	arg_3_0.decorationAnimator:SetTrigger("open")
	arg_3_0:InitRotationBySeat(arg_3_1)
	arg_3_0:InitBombId({})

	return
end

function var_0_0.InitBombId(arg_4_0, arg_4_1)
	for iter_4_0 = 1, 6 do
		setActive(arg_4_0["bombId" .. tostring(iter_4_0)], ((function(arg_5_0)
			for iter_5_0, iter_5_1 in ipairs(arg_4_1) do
				if iter_5_1 == arg_5_0 then
					return true
				end
			end

			return false
		end)(iter_4_0)))
	end

	return
end

function var_0_0.GetPrevIds(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	for iter_6_0 = 1, arg_6_3 do
		({})[#{} + 1] = (arg_6_2 - iter_6_0 - 1) % arg_6_1 + 1
	end

	return {}
end

function var_0_0.InitRotationBySeat(arg_7_0, arg_7_1)
	arg_7_0.tableRoot.transform.localEulerAngles = Vector3(0, IslandCheaterTavernConst.seatRotatonY[arg_7_1] - 90, 0)
	arg_7_0.centerRoot.localEulerAngles = Vector3(0, IslandCheaterTavernConst.seatRotatonY[arg_7_1], 0)

	return
end

function var_0_0.OnShoot(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	if arg_8_1 and arg_8_4 == 1 then
		setActive(arg_8_0.trunTalbeTip, false)

		arg_8_0.firstTakeShoot = true
	else
		arg_8_0.animator:SetTrigger("open")
		arg_8_0.decorationAnimator:SetTrigger("open")

		arg_8_0.shootOpenTime = 0

		arg_8_0:InitRotationBySeat(arg_8_2)
		arg_8_0:InitBombId((arg_8_0:GetPrevIds(6, arg_8_3, arg_8_4 - 1)))
	end

	arg_8_0.curBombId = arg_8_3
	arg_8_0.hasBombCount = arg_8_4
	arg_8_0.gotShoot = arg_8_5

	if arg_8_0.hasBombCount == 1 then
		arg_8_0.rotateDuration = IslandCheaterTavernConst.firstTurnTime
		arg_8_0.turntabletf.localEulerAngles = Vector3(0, 0, 0)
		arg_8_0.endRotationY = -60 * (arg_8_0.curBombId - 1)
		arg_8_0.rotateTotalAngle = IslandCheaterTavernConst.turnCircleCount * 360 + arg_8_0.endRotationY
		arg_8_0.rotateStartEuler = arg_8_0.turntabletf.localEulerAngles
	else
		local var_8_0 = arg_8_0.curBombId - 1

		if arg_8_0.curBombId - 1 == 0 then
			var_8_0 = 6
		end

		arg_8_0.turntabletf.localEulerAngles = Vector3(0, -60 * (var_8_0 - 1), 0)
		arg_8_0.rotateDuration = IslandCheaterTavernConst.afterTurnTime
		arg_8_0.stepStartY = arg_8_0.turntabletf.localEulerAngles.y
		arg_8_0.stepTargetY = arg_8_0.stepStartY - 60
	end

	return
end

function var_0_0.OnUpdate(arg_9_0)
	local var_9_0 = false

	if arg_9_0.shootOpenTime ~= nil then
		arg_9_0.shootOpenTime = arg_9_0.shootOpenTime + Time.deltaTime

		if arg_9_0.shootOpenTime >= 0.2 then
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
		arg_9_0.rotateTime = arg_9_0.rotateTime + Time.deltaTime

		local var_9_1 = Mathf.Clamp01(arg_9_0.rotateTime / arg_9_0.rotateDuration)

		arg_9_0.turntabletf.localEulerAngles = Vector3(arg_9_0.rotateStartEuler.x, arg_9_0.rotateStartEuler.y + arg_9_0.rotateTotalAngle * Mathf.SmoothStep(0, 1, var_9_1), arg_9_0.rotateStartEuler.z)

		if var_9_1 >= 1 then
			arg_9_0.isRotating = false
			arg_9_0.turntabletf.localEulerAngles = Vector3(arg_9_0.rotateStartEuler.x, arg_9_0.rotateStartEuler.y + arg_9_0.endRotationY, arg_9_0.rotateStartEuler.z)

			if arg_9_0.gotShoot then
				setActive(arg_9_0.boomShoot, true)
				onDelayTick(function()
					if IsNil(arg_9_0.boomShoot) then
						return
					end

					setActive(arg_9_0.boomShoot, false)
					arg_9_0.animator:SetTrigger("close")
					arg_9_0.decorationAnimator:SetTrigger("close")

					return
				end, 1)
			else
				setActive(arg_9_0.noGotShoot, true)
				setActive(arg_9_0["bombId" .. tostring(arg_9_0.curBombId)], true)
				onDelayTick(function()
					if IsNil(arg_9_0.noGotShoot) then
						return
					end

					setActive(arg_9_0.noGotShoot, false)
					arg_9_0.animator:SetTrigger("close")
					arg_9_0.decorationAnimator:SetTrigger("close")

					return
				end, 1)
			end
		end
	end

	if arg_9_0.trunToNextBomb then
		arg_9_0.rotateTime = arg_9_0.rotateTime + Time.deltaTime

		local var_9_2 = Mathf.Clamp01(arg_9_0.rotateTime / arg_9_0.rotateDuration)

		arg_9_0.turntabletf.localEulerAngles = Vector3(0, Mathf.LerpAngle(arg_9_0.stepStartY, arg_9_0.stepTargetY, (Mathf.SmoothStep(0, 1, var_9_2))), 0)

		if var_9_2 >= 1 then
			arg_9_0.turntabletf.localEulerAngles = Vector3(0, arg_9_0.stepTargetY, 0)

			if arg_9_0.gotShoot then
				setActive(arg_9_0.boomShoot, true)
				onDelayTick(function()
					if IsNil(arg_9_0.boomShoot) then
						return
					end

					setActive(arg_9_0.boomShoot, false)
					arg_9_0.animator:SetTrigger("close")
					arg_9_0.decorationAnimator:SetTrigger("close")

					return
				end, 1)
			else
				setActive(arg_9_0.noGotShoot, true)
				setActive(arg_9_0["bombId" .. tostring(arg_9_0.curBombId)], true)
				onDelayTick(function()
					if IsNil(arg_9_0.noGotShoot) then
						return
					end

					setActive(arg_9_0.noGotShoot, false)
					arg_9_0.animator:SetTrigger("close")
					arg_9_0.decorationAnimator:SetTrigger("close")

					return
				end, 1)
			end

			arg_9_0.trunToNextBomb = false
		end
	end

	return
end

return var_0_0
