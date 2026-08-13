class = var_0_10000

local var_0_0 = var_0_10000("CookGameJudge")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0._tf = arg_1_1
	arg_1_0._judgeDatas = arg_1_3
	arg_1_0._gameData = arg_1_4
	arg_1_0._event = arg_1_5
	arg_1_0._index = arg_1_2
	findTF = var_1_10006
	arg_1_0.wantedTf = var_1_10006(arg_1_0._tf, "wanted")
	findTF = var_6
	arg_1_0.smokeTf = var_6(arg_1_0._tf, "wanted/smoke")
	GetComponent = var_6
	findTF = var_8

	local var_1_0 = var_8(arg_1_0._tf, "mask/anim")

	typeof = var_9
	DftAniEvent = var_11
	arg_1_0.dftEvent = var_6(var_1_0, var_9(var_11))

	local var_1_1 = arg_1_0.dftEvent

	var_6.SetEndEvent(var_1_1, function(arg_2_0)
		local var_2_0 = arg_1_0

		var_1.onAniEnd(var_2_0)

		return
	end)

	GetComponent = var_6
	findTF = var_1_1

	local var_1_2 = var_1_1(arg_1_0._tf, "mask/anim")

	typeof = var_9
	Animator = var_11
	arg_1_0.animator = var_6(var_1_2, var_9(var_11))
	onButton = var_6

	local var_1_3 = arg_1_0._event

	findTF = var_9

	local var_1_4 = var_9(arg_1_0._tf, "collider")

	local function var_1_5()
		if arg_1_0.clickCallback then
			arg_1_0.clickCallback()
		end

		return
	end

	SFX_CANCEL = var_11

	var_6(var_1_3, var_1_4, var_1_5, var_11)

	return
end

function var_0_0.clear(arg_4_0)
	arg_4_0._puzzleTime = nil
	arg_4_0._puzzleWeight = nil
	arg_4_0._puzzleCamp = nil
	arg_4_0.cakeId = 1
	arg_4_0.inTrigger = false
	arg_4_0.serveData = nil
	arg_4_0.serveCallback = nil

	arg_4_0:updateWanted(nil)
	arg_4_0:showCard(nil)

	setActive = var_1

	var_1(arg_4_0.wantedTf, false)

	setActive = var_1

	var_1(arg_4_0._tf, false)

	local var_4_0 = arg_4_0:getAnimData(arg_4_0.cakeId)

	arg_4_0.animator.runtimeAnimatorController = var_4_0.runtimeAnimator

	arg_4_0:select(false)

	return
end

function var_0_0.start(arg_5_0)
	arg_5_0:clear()

	setActive = var_1

	var_1(arg_5_0._tf, true)

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.updateWanted

	math = var_4

	var_5_1(var_5_0, var_4.random(1, arg_5_0._gameData.cake_num))

	return
end

function var_0_0.step(arg_6_0, arg_6_1)
	if arg_6_0.wantedCakeTime and arg_6_0.wantedCakeTime > 0 then
		arg_6_0.wantedCakeTime = arg_6_0.wantedCakeTime - arg_6_1

		if arg_6_0.wantedCakeTime <= 0 then
			arg_6_0.wantedCakeTime = nil

			local var_6_0 = arg_6_0
			local var_6_1 = arg_6_0.updateWanted

			math = var_1_10005

			var_6_1(var_6_0, var_1_10005.random(1, arg_6_0._gameData.cake_num))
		end
	end

	if arg_6_0._puzzleTime then
		arg_6_0._puzzleTime = arg_6_0._puzzleTime - arg_6_1

		if arg_6_0._puzzleTime <= 0 then
			arg_6_0._puzzleTime = nil
			arg_6_0._puzzleCamp = nil
			arg_6_0._puzzleWeight = nil

			arg_6_0:showCard(false)
		end
	end

	if arg_6_0.readyServeTime and arg_6_0.readyServeTime > 0 then
		arg_6_0.readyServeTime = arg_6_0.readyServeTime - arg_6_1

		if arg_6_0.readyServeTime <= 0 then
			arg_6_0.readyServeTime = nil
			arg_6_0.serveData = nil
			arg_6_0.serveCallback = nil
		end
	end

	return
end

function var_0_0.destroy(arg_7_0)
	return
end

function var_0_0.changeSpeed(arg_8_0, arg_8_1)
	arg_8_0.animator.speed = arg_8_1

	return
end

function var_0_0.onAniEnd(arg_9_0)
	arg_9_0.inTrigger = false

	if arg_9_0.freshWanted then
		arg_9_0.freshWanted = false
		arg_9_0.wantedCakeTime = nil

		local var_9_0 = arg_9_0
		local var_9_1 = arg_9_0.updateWanted

		math = var_1_10004

		var_9_1(var_9_0, var_1_10004.random(1, arg_9_0._gameData.cake_num))
	end

	return
end

function var_0_0.getIndex(arg_10_0)
	return arg_10_0._index
end

function var_0_0.getTf(arg_11_0)
	return arg_11_0._tf
end

function var_0_0.trigger(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if arg_12_0.inTrigger then
		print = var_5

		var_5("评委已有状态")

		return
	end

	Vector3 = var_5

	local var_12_0 = var_5(1, 1, 1)

	arg_12_0.inTrigger = true

	local var_12_2

	if arg_12_0.cakeId ~= arg_12_1 then
		arg_12_0.cakeId = arg_12_1

		local var_12_1 = arg_12_0:getAnimData(arg_12_0.cakeId)

		var_12_2 = arg_12_0.animator
		var_12_2.runtimeAnimatorController = var_12_1.runtimeAnimator
	end

	local var_12_3 = arg_12_0.animator

	var_6.SetBool(var_12_3, "AC", arg_12_3 or false)

	local var_12_4 = arg_12_0.animator

	var_6.SetBool(var_12_4, "right", arg_12_2 or false)

	local var_12_5 = arg_12_0.animator

	var_6.SetBool(var_12_5, "bk", arg_12_4 or false)

	local var_12_6 = arg_12_0.animator

	var_6.SetBool(var_12_6, "reject", arg_12_0._puzzleCamp and true or false)

	local var_12_7

	if arg_12_0._puzzleCamp and not arg_12_2 then
		var_12_7 = arg_12_0._puzzleCamp
		CookGameConst = var_12_2

		if var_12_7 == var_12_2.camp_player then
			Vector3 = var_12_7
			var_12_0 = var_12_7(-1, 1, 1)
		else
			Vector3 = var_12_7
			var_12_0 = var_12_7(1, 1, 1)
		end
	end

	findTF = var_12_7
	var_12_7(arg_12_0._tf, "mask").localScale = var_12_0

	local var_12_8 = arg_12_0.animator

	var_6.SetTrigger(var_12_8, "trigger")

	if arg_12_2 then
		arg_12_0:updateWanted()

		arg_12_0.freshWanted = true
		arg_12_0.wantedCakeTime = 3
	end

	return
end

function var_0_0.readyServe(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_0.serveCallback then
		arg_13_0.serveCallback(false)
	end

	arg_13_0.serveData = arg_13_1
	arg_13_0.readyServeTime = 4
	arg_13_0.serveCallback = arg_13_2

	if arg_13_0.serveData.battleData.cake_allow and arg_13_0.wantedCake ~= arg_13_0.serveData.parameter.cakeId then
		if not arg_13_0._puzzleTime then
			setActive = var_3

			var_3(arg_13_0.smokeTf, false)

			setActive = var_3

			var_3(arg_13_0.smokeTf, true)

			arg_13_0.wantedCake = arg_13_0.serveData.parameter.cakeId

			arg_13_0:showCake(arg_13_0.wantedCake)
		elseif arg_13_0._puzzleCamp ~= arg_13_0.serveData.parameter.camp and arg_13_0.serveData.parameter.weight > arg_13_0._puzzleWeight then
			setActive = var_3

			var_3(arg_13_0.smokeTf, false)

			setActive = var_3

			var_3(arg_13_0.smokeTf, true)

			arg_13_0.wantedCake = arg_13_0.serveData.parameter.cakeId

			arg_13_0:showCake(arg_13_0.wantedCake)
		end
	end

	return
end

function var_0_0.setWantedImg(arg_14_0)
	return
end

function var_0_0.serve(arg_15_0)
	if not arg_15_0.serveData then
		return
	end

	if (not arg_15_0.wantedCake or arg_15_0.inTrigger) and arg_15_0.serveCallback then
		arg_15_0.serveCallback(false)
	end

	local var_15_0 = arg_15_0.serveData.parameter.cakeId
	local var_15_1 = arg_15_0.serveData.battleData.ac_able
	local var_15_2 = arg_15_0.serveData.judgeData.acPos
	local var_15_3 = arg_15_0.serveData.battleData.id
	local var_15_4 = arg_15_0.serveData.parameter.right_index
	local var_15_5 = arg_15_0.serveData.parameter.right_flag
	local var_15_6 = arg_15_0.serveData.parameter.rate
	local var_15_7 = arg_15_0.serveData.parameter.weight

	if not var_15_0 then
		print = var_1_10009

		var_1_10009("cakeId 不能为nil")

		return
	end

	local var_15_8 = var_15_1 and true or false
	local var_15_9 = false

	if var_15_8 then
		local var_15_10 = arg_15_0._tf.parent

		if var_15_2.y > arg_15_0._tf.anchoredPosition.y then
			var_15_9 = true
		end
	end

	local var_15_11 = 1

	if arg_15_0._puzzleCamp and arg_15_0.serveData.parameter.camp == arg_15_0._puzzleCamp then
		var_15_11 = 2
	elseif arg_15_0._puzzleCamp and arg_15_0.serveData.parameter.camp ~= arg_15_0._puzzleCamp then
		var_15_11 = 0
	end

	if arg_15_0.serveData.parameter.puzzle then
		arg_15_0:setPuzzle(arg_15_0.serveData.parameter.camp, arg_15_0.serveData.battleData.weight)
	end

	local var_15_12

	if not arg_15_0._puzzleWeight then
		var_15_12 = 0
	end

	arg_15_0:trigger(var_15_0, var_15_5, var_15_8, var_15_9)

	local var_15_13 = arg_15_0._event
	local var_15_14 = var_14.emit

	CookGameView = var_17

	var_15_14(var_15_13, var_17.SERVE_EVENT, {
		serveData = arg_15_0.serveData,
		pos = arg_15_0._tf.position,
		right = var_15_5,
		rate = var_15_11,
		weight = var_15_12
	})

	arg_15_0.serveData = nil
	arg_15_0.serveCallback = nil
	arg_15_0.readyServeTime = nil

	return
end

function var_0_0.setPuzzle(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0._puzzleCamp = arg_16_1
	arg_16_0._puzzleWeight = arg_16_2
	CookGameConst = var_1_10003
	arg_16_0._puzzleTime = var_1_10003.puzzle_time

	arg_16_0:showCard(true)

	return
end

function var_0_0.showCard(arg_17_0, arg_17_1)
	setActive = var_1_10002
	findTF = var_1_10004

	var_1_10002(var_1_10004(arg_17_0.wantedTf, "Card"), arg_17_1)
	arg_17_0:showCake(nil)

	return
end

function var_0_0.isInServe(arg_18_0)
	return arg_18_0.serveData
end

function var_0_0.isInTrigger(arg_19_0)
	return arg_19_0.inTrigger
end

function var_0_0.getPuzzleCamp(arg_20_0)
	return arg_20_0._puzzleCamp
end

function var_0_0.getWantedCake(arg_21_0)
	return arg_21_0.wantedCake
end

function var_0_0.updateWanted(arg_22_0, arg_22_1)
	if arg_22_0.wantedCake ~= arg_22_1 and arg_22_1 then
		arg_22_0:showCake(arg_22_1)
	end

	if arg_22_1 and 0 < arg_22_1 then
		setActive = var_2

		var_2(arg_22_0.wantedTf, true)

		arg_22_0.wantedCake = arg_22_1
		arg_22_0.wantedCakeTime = nil
	else
		setActive = var_2

		var_2(arg_22_0.wantedTf, false)
	end

	return
end

function var_0_0.showCake(arg_23_0, arg_23_1)
	arg_23_1 = arg_23_1 or arg_23_0.wantedCake

	for iter_23_0 = 1, arg_23_0._gameData.cake_num do
		setActive = var_1_10006
		findTF = var_1_10008

		var_1_10006(var_1_10008(arg_23_0.wantedTf, "cake_" .. iter_23_0), not arg_23_0._puzzleTime and iter_23_0 == arg_23_1)
	end

	return
end

function var_0_0.setFrontContainer(arg_24_0, arg_24_1)
	arg_24_0._frontTf = arg_24_1

	if arg_24_0._frontTf then
		SetParent = var_2

		var_2(arg_24_0.wantedTf, arg_24_0._frontTf, true)
	end

	return
end

function var_0_0.getPos(arg_25_0)
	return arg_25_0._tf.anchoredPosition()
end

function var_0_0.getLeftTf(arg_26_0)
	findTF = var_1_10001

	return var_1_10001(arg_26_0._tf, "leftPos")
end

function var_0_0.getRightTf(arg_27_0)
	findTF = var_1_10001

	return var_1_10001(arg_27_0._tf, "rightPos")
end

function var_0_0.select(arg_28_0, arg_28_1)
	setActive = var_1_10002
	findTF = var_1_10004

	var_1_10002(var_1_10004(arg_28_0._tf, "select"), arg_28_1)

	return
end

function var_0_0.setClickCallback(arg_29_0, arg_29_1)
	arg_29_0.clickCallback = arg_29_1

	return
end

function var_0_0.getAcTargetTf(arg_30_0)
	findTF = var_1_10001

	return var_1_10001(arg_30_0._tf, "acTarget")
end

function var_0_0.getAnimData(arg_31_0, arg_31_1)
	for iter_31_0 = 1, #arg_31_0._judgeDatas do
		if arg_31_0._judgeDatas[iter_31_0].data.cake_id == arg_31_1 then
			return var_6
		end
	end

	return nil
end

return var_0_0
