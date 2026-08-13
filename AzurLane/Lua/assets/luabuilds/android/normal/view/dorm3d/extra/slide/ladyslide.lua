class = var_0_10000

local var_0_0 = var_0_10000("LadySlide")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0.id = arg_1_1
	arg_1_0.ladyEnv = arg_1_2
	arg_1_0._tf = arg_1_2.lady

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_6.GetComponent

	typeof = var_1_10008
	Animator = var_1_10009
	arg_1_0.animator = var_1_1(var_1_0, var_1_10008(var_1_10009))
	arg_1_0.commandConfig = arg_1_3
	arg_1_0.defaultPoint = arg_1_4
	pg = var_6
	arg_1_0.ladderTime = var_6.dorm3d_minigame_slide[arg_1_1].ladder_time
	pg = var_6
	arg_1_0.moveSpeed = var_6.dorm3d_minigame_slide[arg_1_1].move_speed
	arg_1_0.onPlayVFX = arg_1_5

	return
end

function var_0_0.Reset(arg_2_0)
	arg_2_0._tf.localPosition = arg_2_0.defaultPoint.position
	arg_2_0._tf.localRotation = arg_2_0.defaultPoint.rotation

	local var_2_0 = arg_2_0.ladyEnv
	local var_2_1 = var_1.PlaySingleAction

	SlideConst = var_1_10003

	var_2_1(var_2_0, var_1_10003.IDLE_ANIM)

	return
end

function var_0_0.StartMove(arg_3_0)
	arg_3_0:Cancel()

	arg_3_0.curIndex = 1
	arg_3_0.curState = nil
	arg_3_0.inProgress = true

	local var_3_0 = arg_3_0.ladyEnv

	var_1.SetCollisible(var_3_0, false)

	local var_3_1 = arg_3_0.ladyEnv

	var_1.EnableCharacterTransparency(var_3_1, true)

	local var_3_2 = arg_3_0.ladyEnv

	var_1.BlockCanWatch(var_3_2, true)

	return
end

function var_0_0.EndMove(arg_4_0)
	arg_4_0.curIndex = nil
	arg_4_0.curState = nil
	arg_4_0.inProgress = false

	local var_4_0 = arg_4_0.ladyEnv

	var_1.SetCollisible(var_4_0, true)

	local var_4_1 = arg_4_0.ladyEnv

	var_1.EnableCharacterTransparency(var_4_1, false)

	local var_4_2 = arg_4_0.ladyEnv

	var_1.BlockCanWatch(var_4_2, false)
	arg_4_0:Reset()

	return
end

function var_0_0.OnUpdate(arg_5_0)
	if not arg_5_0.inProgress or arg_5_0.curIndex > #arg_5_0.commandConfig then
		return
	end

	local var_5_0 = arg_5_0.commandConfig[arg_5_0.curIndex]

	if not arg_5_0.curState then
		arg_5_0:EnterState(var_5_0.type, var_5_0)
	elseif arg_5_0:Check(var_5_0) then
		arg_5_0.curIndex = arg_5_0.curIndex + 1

		if arg_5_0.curIndex > #arg_5_0.commandConfig then
			arg_5_0:ExitState(arg_5_0.curState)
			arg_5_0:EndMove()

			return
		end

		if arg_5_0.commandConfig[arg_5_0.curIndex].type ~= arg_5_0.curState then
			arg_5_0:ExitState(arg_5_0.curState)
		end

		arg_5_0:EnterState(var_5_0.type, var_5_0)
	end

	arg_5_0:UpdateState(var_5_0)

	return
end

function var_0_0.Check(arg_6_0, arg_6_1)
	local function var_6_0(arg_7_0, arg_7_1)
		local var_7_0 = arg_7_0.position - arg_7_1.position

		var_7_0.y = 0

		return var_7_0.magnitude <= 0.1
	end

	switch = var_1_10003

	local var_6_1 = arg_6_0.curState
	local var_6_2 = {}

	SlideConst = var_1_10006
	var_6_2[var_1_10006.COMMAND_TYPE.WALK] = function()
		return var_6_0(arg_6_1.target, arg_6_0._tf)
	end
	SlideConst = var_6
	var_6_2[var_6.COMMAND_TYPE.LADDER] = function()
		return var_6_0(arg_6_1.target, arg_6_0._tf)
	end
	SlideConst = var_6
	var_6_2[var_6.COMMAND_TYPE.SLIDE] = function()
		return arg_6_1.target.position.y >= arg_6_0._tf.position.y
	end
	SlideConst = var_6
	var_6_2[var_6.COMMAND_TYPE.TELEPORT] = function()
		return true
	end
	SlideConst = var_6
	var_6_2[var_6.COMMAND_TYPE.ANIM] = function()
		local var_12_0 = arg_6_0.animator

		if var_0.IsInTransition(var_12_0, arg_6_0.ladyEnv.ladyAnimBaseLayerIndex) then
			return false
		end

		local var_12_1 = arg_6_0.animator

		return var_0.GetCurrentAnimatorStateInfo(var_12_1, arg_6_0.ladyEnv.ladyAnimBaseLayerIndex).normalizedTime >= 1
	end
	SlideConst = var_6
	var_6_2[var_6.COMMAND_TYPE.ANIM_MOVE_ROTATE] = function()
		return arg_6_0.walkWithRotateTime >= arg_6_1.time
	end

	return var_1_10003(var_6_1, var_6_2)
end

function var_0_0.UpdateState(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1.target

	switch = var_1_10003

	local var_14_1 = arg_14_0.curState
	local var_14_2 = {}

	SlideConst = var_1_10006
	var_14_2[var_1_10006.COMMAND_TYPE.WALK] = function()
		local var_15_0 = arg_14_0.ladyEnv

		var_0.MoveToTarget(var_15_0, var_14_0.position, arg_14_0.moveSpeed)

		return
	end
	SlideConst = var_6
	var_14_2[var_6.COMMAND_TYPE.LADDER] = function()
		local var_16_0 = arg_14_0
		local var_16_1 = arg_14_0.ladderMoveTime

		Time = var_2_10002
		var_16_0.ladderMoveTime = var_16_1 + var_2_10002.deltaTime
		math = var_16_0

		local var_16_2 = var_16_0.min(arg_14_0.ladderMoveTime / arg_14_0.ladderTime, 1)
		local var_16_3 = arg_14_0._tf
		local var_16_4 = arg_14_0.ladderStartPos
		local var_16_5 = arg_14_0.ladderForward

		SlideConst = var_2_10004

		local var_16_6 = var_16_4 + var_16_5 * (var_2_10004.LADDER_DISPLACEMENT.z * var_16_2)

		Vector3 = var_3

		local var_16_7 = var_3.up

		SlideConst = var_4
		var_16_3.localPosition = var_16_6 + var_16_7 * (var_4.LADDER_DISPLACEMENT.y * var_16_2)

		if var_16_2 >= 1 then
			arg_14_0.ladderMoveTime = 0
			arg_14_0.ladderStartPos = arg_14_0._tf.localPosition
		end

		return
	end
	SlideConst = var_6
	var_14_2[var_6.COMMAND_TYPE.SLIDE] = function()
		local var_17_0 = arg_14_0
		local var_17_1 = arg_14_0.slideMoveTime

		Time = var_2_10002
		var_17_0.slideMoveTime = var_17_1 + var_2_10002.deltaTime

		local var_17_2 = arg_14_0.slideMoveTime

		SlideConst = var_1

		local var_17_3 = var_17_2 * var_1.SLIDE_GRAVITY
		local var_17_4 = arg_14_0.slideTotalDelta.normalized * var_17_3
		local var_17_5 = arg_14_0.ladyEnv.characterController
		local var_17_6 = var_3.Move

		Time = var_2_10005

		var_17_6(var_17_5, var_17_4 * var_2_10005.deltaTime)

		return
	end
	SlideConst = var_6
	var_14_2[var_6.COMMAND_TYPE.TELEPORT] = function()
		arg_14_0._tf.localPosition = var_14_0.position
		arg_14_0._tf.localRotation = var_14_0.rotation

		return
	end
	SlideConst = var_6
	var_14_2[var_6.COMMAND_TYPE.ANIM] = function()
		return
	end
	SlideConst = var_6
	var_14_2[var_6.COMMAND_TYPE.ANIM_MOVE_ROTATE] = function()
		local var_20_0 = arg_14_0
		local var_20_1 = arg_14_0.walkWithRotateTime

		Time = var_2_10002
		var_20_0.walkWithRotateTime = var_20_1 + var_2_10002.deltaTime
		math = var_20_0

		local var_20_2 = var_20_0.min(arg_14_0.walkWithRotateTime / arg_14_1.time, 1)
		local var_20_3 = arg_14_0._tf

		Quaternion = var_2
		var_20_3.localRotation = var_2.Slerp(arg_14_0.cacheRotation, arg_14_1.target.rotation, var_20_2)

		local var_20_4 = arg_14_0._tf

		Vector3 = var_2
		var_20_4.localPosition = var_2.Lerp(arg_14_0.cachePosition, arg_14_1.target.position, var_20_2)

		return
	end

	var_1_10003(var_14_1, var_14_2)

	return
end

function var_0_0.EnterState(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_2:HasEffect() then
		local var_21_0, var_21_1 = arg_21_2:GetEffect()

		LeanTween = var_1_10005
		var_1_10005 = var_1_10005.delayedCall
		var_1_10006 = var_21_0
		System = var_1_10007
		arg_21_0.vfxLTId = var_1_10005(var_1_10006, var_1_10007.Action(function()
			arg_21_0.onPlayVFX(var_21_1)

			return
		end)).uniqueId
	end

	local var_21_2

	if arg_21_2:HasWet() then
		local var_21_3

		var_21_2, var_21_3 = arg_21_2:GetWet()
		LeanTween = var_1_10005

		local var_21_4 = var_1_10005.delayedCall

		var_1_10006 = var_21_2
		System = var_1_10007
		arg_21_0.wetLTId = var_21_4(var_1_10006, var_1_10007.Action(function()
			local var_23_0 = arg_21_0

			var_0.ShowWetness(var_23_0, var_21_3)

			return
		end)).uniqueId
	end

	switch = var_21_2

	local var_21_5 = arg_21_1
	local var_21_6 = {}

	SlideConst = var_1_10006
	var_21_6[var_1_10006.COMMAND_TYPE.WALK] = function()
		local var_24_0 = arg_21_0.ladyEnv
		local var_24_1 = var_0.PlaySingleAction

		SlideConst = var_2_10002

		local var_24_2 = var_2_10002.WALK_ANIM
		local var_24_3
		local var_24_4 = arg_21_2

		var_24_1(var_24_0, var_24_2, var_24_3, var_4.GetFadeInTime(var_24_4))

		arg_21_0.ladyEnv.characterController.enabled = true

		return
	end
	SlideConst = var_6
	var_21_6[var_6.COMMAND_TYPE.LADDER] = function()
		local var_25_0 = arg_21_0.ladyEnv
		local var_25_1 = var_0.PlaySingleAction

		SlideConst = var_2_10002

		local var_25_2 = var_2_10002.LADDER_ANIM
		local var_25_3
		local var_25_4 = arg_21_2

		var_25_1(var_25_0, var_25_2, var_25_3, var_4.GetFadeInTime(var_25_4))

		local var_25_5 = arg_21_2.target.position - arg_21_0._tf.position

		var_25_5.y = 0

		local var_25_6 = var_25_5.sqrMagnitude

		if 0 < var_25_6 then
			local var_25_7 = arg_21_0._tf

			Quaternion = var_3

			local var_25_8 = var_3.LookRotation
			local var_25_9 = var_25_5.normalized

			Vector3 = var_25_4
			var_25_7.rotation = var_25_8(var_25_9, var_25_4.up)
		end

		arg_21_0.ladderMoveTime = 0
		arg_21_0.ladderStartPos = arg_21_0._tf.localPosition
		arg_21_0.ladderForward = arg_21_0._tf.forward

		return
	end
	SlideConst = var_6
	var_21_6[var_6.COMMAND_TYPE.SLIDE] = function()
		arg_21_0.ladyEnv.characterController.enabled = true

		local var_26_0 = arg_21_0.ladyEnv
		local var_26_1 = var_0.PlaySingleAction

		SlideConst = var_2_10002

		local var_26_2 = var_2_10002.SLIDE_ANIM
		local var_26_3
		local var_26_4 = arg_21_2

		var_26_1(var_26_0, var_26_2, var_26_3, var_4.GetFadeInTime(var_26_4))

		local var_26_5 = (arg_21_2.target.position - arg_21_0._tf.position).sqrMagnitude

		if 0 < var_26_5 then
			local var_26_6 = arg_21_0._tf

			Quaternion = var_3

			local var_26_7 = var_3.LookRotation
			local var_26_8 = var_1.normalized

			Vector3 = var_26_4
			var_26_6.rotation = var_26_7(var_26_8, var_26_4.up)
		end

		arg_21_0.slideMoveTime = 0
		arg_21_0.slideTotalDelta = arg_21_2.target.position - arg_21_0._tf.localPosition

		return
	end
	SlideConst = var_6
	var_21_6[var_6.COMMAND_TYPE.TELEPORT] = function()
		return
	end
	SlideConst = var_6
	var_21_6[var_6.COMMAND_TYPE.ANIM] = function()
		local var_28_0 = arg_21_0.ladyEnv
		local var_28_1 = var_0.PlaySingleAction
		local var_28_2 = arg_21_2.anim
		local var_28_3
		local var_28_4 = arg_21_2

		var_28_1(var_28_0, var_28_2, var_28_3, var_4.GetFadeInTime(var_28_4))

		return
	end
	SlideConst = var_6
	var_21_6[var_6.COMMAND_TYPE.ANIM_MOVE_ROTATE] = function()
		local var_29_0 = arg_21_0.ladyEnv
		local var_29_1 = var_0.PlaySingleAction
		local var_29_2 = arg_21_2.anim
		local var_29_3
		local var_29_4 = arg_21_2

		var_29_1(var_29_0, var_29_2, var_29_3, var_4.GetFadeInTime(var_29_4))

		arg_21_0.cacheRotation = arg_21_0._tf.localRotation
		arg_21_0.cachePosition = arg_21_0._tf.localPosition
		arg_21_0.walkWithRotateTime = 0

		return
	end

	var_21_2(var_21_5, var_21_6)

	arg_21_0.curState = arg_21_1

	return
end

function var_0_0.ExitState(arg_30_0, arg_30_1)
	switch = var_1_10002

	local var_30_0 = arg_30_0.curState
	local var_30_1 = {}

	SlideConst = var_1_10005
	var_30_1[var_1_10005.COMMAND_TYPE.WALK] = function()
		arg_30_0.ladyEnv.characterController.enabled = false

		return
	end
	SlideConst = var_5
	var_30_1[var_5.COMMAND_TYPE.LADDER] = function()
		arg_30_0.ladderMoveTime = nil
		arg_30_0.ladderStartPos = nil
		arg_30_0.ladderForward = nil

		return
	end
	SlideConst = var_5
	var_30_1[var_5.COMMAND_TYPE.SLIDE] = function()
		arg_30_0.ladyEnv.characterController.enabled = false

		local var_33_0 = arg_30_0._tf.rotation.eulerAngles
		local var_33_1 = arg_30_0._tf

		Quaternion = var_2_10002
		var_33_1.rotation = var_2_10002.Euler(0, var_33_0.y, var_33_0.z)
		arg_30_0.slideMoveTime = nil
		arg_30_0.slideTotalDelta = nil

		return
	end
	SlideConst = var_5
	var_30_1[var_5.COMMAND_TYPE.TELEPORT] = function()
		return
	end
	SlideConst = var_5
	var_30_1[var_5.COMMAND_TYPE.ANIM] = function()
		return
	end
	SlideConst = var_5
	var_30_1[var_5.COMMAND_TYPE.ANIM_MOVE_ROTATE] = function()
		return
	end

	var_1_10002(var_30_0, var_30_1)

	arg_30_0.curState = nil

	return
end

function var_0_0.ShowWetness(arg_37_0, arg_37_1)
	if arg_37_0.wetTimer then
		var_1_10003 = arg_37_0.wetTimer

		var_2.Stop(var_1_10003)
	end

	local var_37_0 = 0

	Timer = var_1_10003
	arg_37_0.wetTimer = var_1_10003.New(function()
		local var_38_0 = var_37_0

		SlideConst = var_2_10001

		local var_38_1

		if var_2_10001.WET_FADE_IN_TIME <= var_38_0 then
			var_38_1 = arg_37_0.wetTimer

			var_0.Stop(var_38_1)

			arg_37_0.wetTimer = nil

			return
		end

		var_37_0 = var_37_0 + 0.016666666666666666

		local var_38_2 = var_37_0

		SlideConst = var_38_1

		local var_38_3 = var_38_2 / var_38_1.WET_FADE_IN_TIME

		if not arg_37_1 then
			var_38_3 = 1 - var_38_3
		end

		math = var_1

		local var_38_4 = var_1.min(var_38_3, 1)

		math = var_1

		local var_38_5 = var_1.max(var_38_4, 0)

		GraphicsInterface = var_1

		local var_38_6 = var_1.Instance
		local var_38_7 = var_1.SetWetness

		go = var_3

		var_38_7(var_38_6, var_3(arg_37_0._tf), var_38_5)

		return
	end, 0.016666666666666666, -1)

	local var_37_1 = arg_37_0.wetTimer

	var_3.Start(var_37_1)

	return
end

function var_0_0.Cancel(arg_39_0)
	if arg_39_0.vfxLTId then
		LeanTween = var_1

		var_1.cancel(arg_39_0.vfxLTId)

		arg_39_0.vfxLTId = nil
	end

	if arg_39_0.wetLTId then
		LeanTween = var_1

		var_1.cancel(arg_39_0.wetLTId)

		arg_39_0.wetLTId = nil
	end

	if arg_39_0.wetTimer then
		local var_39_0 = arg_39_0.wetTimer

		var_1.Stop(var_39_0)

		arg_39_0.wetTimer = nil
	end

	GraphicsInterface = var_1

	local var_39_1 = var_1.Instance
	local var_39_2 = var_1.SetWetness

	go = var_1_10003

	var_39_2(var_39_1, var_1_10003(arg_39_0._tf), 0)

	return
end

function var_0_0.Dispose(arg_40_0)
	arg_40_0:Cancel()

	local var_40_0 = arg_40_0.ladyEnv

	var_1.SetCollisible(var_40_0, true)

	local var_40_1 = arg_40_0.ladyEnv

	var_1.EnableCharacterTransparency(var_40_1, false)

	local var_40_2 = arg_40_0.ladyEnv

	var_1.BlockCanWatch(var_40_2, false)

	return
end

return var_0_0
