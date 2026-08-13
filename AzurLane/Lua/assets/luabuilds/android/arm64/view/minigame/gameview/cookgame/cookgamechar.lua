class = var_0_10000

local var_0_0 = var_0_10000("CookGameChar")
local var_0_1 = 20
local var_0_2 = 3

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._gameData = arg_1_2
	arg_1_0._event = arg_1_3
	findTF = var_1_10004
	arg_1_0._animTf = var_1_10004(arg_1_0._tf, "mask/anim")
	GetComponent = var_4
	findTF = var_6

	local var_1_0 = var_6(arg_1_0._tf, "mask/anim")

	typeof = var_7
	Animator = var_9
	arg_1_0._animator = var_4(var_1_0, var_7(var_9))
	GetComponent = var_4
	findTF = var_1_0

	local var_1_1 = var_1_0(arg_1_0._tf, "mask/anim")

	typeof = var_7
	Image = var_9
	arg_1_0._animImage = var_4(var_1_1, var_7(var_9))
	GetComponent = var_4
	findTF = var_1_1

	local var_1_2 = var_1_1(arg_1_0._tf, "mask/anim")

	typeof = var_7
	DftAniEvent = var_9
	arg_1_0._dftEvent = var_4(var_1_2, var_7(var_9))

	local var_1_3 = arg_1_0._dftEvent

	var_4.SetStartEvent(var_1_3, function(arg_2_0)
		if arg_1_0._serveFunc then
			arg_1_0._serveFunc()

			local var_2_0 = arg_1_0

			var_2_0._serveFunc = nil
			pg = var_2_0

			local var_2_1 = var_2_0.CriMgr.GetInstance()
			local var_2_2 = var_1.PlaySoundEffect_V3

			CookGameConst = var_2_10004

			var_2_2(var_2_1, var_2_10004.sound_serve)
		end

		return
	end)

	local var_1_4 = arg_1_0._dftEvent

	var_4.SetEndEvent(var_1_4, function(arg_3_0)
		local var_3_0 = arg_1_0

		var_1.endEventHandle(var_3_0)

		return
	end)

	return
end

function var_0_0.endEventHandle(arg_4_0)
	if arg_4_0.activing then
		arg_4_0.activing = false
		arg_4_0.activingTime = nil
	end

	if arg_4_0.timeToEventHandle and arg_4_0.timeToEventHandle > 0 then
		arg_4_0.timeToEventHandle = nil
	end

	if arg_4_0._serveSpeed then
		if arg_4_0.directX == -1 then
			setActive = var_1
			findTF = var_1_10003

			var_1(var_1_10003(arg_4_0._tf, "effectW"), false)

			setActive = var_1
			findTF = var_1_10003

			var_1(var_1_10003(arg_4_0._tf, "effectW"), true)
		else
			setActive = var_1
			findTF = var_1_10003

			var_1(var_1_10003(arg_4_0._tf, "effectE"), false)

			setActive = var_1
			findTF = var_3

			var_1(var_3(arg_4_0._tf, "effectE"), true)
		end

		arg_4_0._serveSpeed = false
	end

	if arg_4_0._serveFresh then
		arg_4_0._serveFresh = false
		arg_4_0.cakeNum = arg_4_0.cakeNum - 1

		if arg_4_0.cakeNum < 0 then
			arg_4_0.cakeNum = 0
		end

		arg_4_0:clearJudge()
		arg_4_0:updateCharAniamtor()
		arg_4_0:updateAnimatorParame()
	elseif arg_4_0.sendExtend then
		arg_4_0.sendExtend = false

		local var_4_0 = arg_4_0._event
		local var_4_1 = var_1.emit

		CookGameView = var_1_10004

		var_4_1(var_4_0, var_1_10004.EXTEND_EVENT)
	end

	arg_4_0:setTrigger("clear", true)

	arg_4_0.clearing = true

	return
end

function var_0_0.changeSpeed(arg_5_0, arg_5_1)
	arg_5_0._animator.speed = arg_5_1

	return
end

function var_0_0.setData(arg_6_0, arg_6_1)
	if not arg_6_1 then
		arg_6_0:setCharActive(false)

		return
	end

	arg_6_0:setCharActive(true)

	arg_6_0._charData = arg_6_1
	arg_6_0._doubleAble = arg_6_1.battleData.double_able
	arg_6_0._speedAble = arg_6_1.battleData.speed_able
	arg_6_0._speedMax = arg_6_1.battleData.speed_max
	arg_6_0._acAble = arg_6_1.battleData.ac_able
	arg_6_0._skills = arg_6_1.battleData.skills
	arg_6_0._baseSpeed = arg_6_1.battleData.base_speed
	arg_6_0._scoreAdded = arg_6_1.battleData.score_added
	arg_6_0._name = arg_6_1.battleData.name
	arg_6_0._animDatas = arg_6_1.animDatas
	arg_6_0._randomScore = arg_6_1.battleData.random_score
	arg_6_0._doubleIndex = 1

	local var_6_0

	if not arg_6_1.battleData.offset then
		Vector2 = var_6_0
		var_6_0 = var_6_0(0, 0)
	end

	arg_6_0._offset = var_6_0
	arg_6_0.extendFlag = false

	if arg_6_0._charData.battleData.extend and (arg_6_0._isPlayer or arg_6_0._isPartner) then
		arg_6_0.extendFlag = true
	end

	return
end

function var_0_0.readyStart(arg_7_0)
	arg_7_0:clear()

	if arg_7_0._isActive then
		arg_7_0:updateCharAniamtor()
	end

	return
end

function var_0_0.start(arg_8_0)
	return
end

function var_0_0.step(arg_9_0, arg_9_1)
	arg_9_0.deltaTime = arg_9_1

	if arg_9_0._velocity then
		arg_9_0:move()
	end

	if arg_9_0.timeToEventHandle then
		arg_9_0.timeToEventHandle = arg_9_0.timeToEventHandle - arg_9_1

		if arg_9_0.timeToEventHandle <= 0 then
			arg_9_0.timeToEventHandle = nil

			arg_9_0:endEventHandle()
		end
	end

	if arg_9_0.activingTime and arg_9_0.activingTime > 0 then
		arg_9_0.activingTime = arg_9_0.activingTime - arg_9_0.deltaTime

		if arg_9_0.activingTime <= 0 then
			arg_9_0.activingTime = 0

			if arg_9_0.activing then
				arg_9_0.activing = false

				if arg_9_0._serveFresh then
					arg_9_0._serveFresh = false
					arg_9_0.cakeNum = arg_9_0.cakeNum - 1

					if arg_9_0.cakeNum < 0 then
						arg_9_0.cakeNum = 0
					end

					arg_9_0:clearJudge()
					arg_9_0:updateCharAniamtor()
					arg_9_0:updateAnimatorParame()
				end

				arg_9_0:setTrigger("clear", true)
			end
		end
	end

	if arg_9_0._gameData.gameTime < arg_9_0._gameData.time_up and arg_9_0.extendFlag then
		arg_9_0:extend()
	end

	arg_9_0.clearing = false

	return
end

function var_0_0.updateCharAniamtor(arg_10_0)
	local var_10_0 = arg_10_0:getAnimatorName(arg_10_0._name, arg_10_0.leftCakeId, arg_10_0.rightCakeId, arg_10_0.speedNum, arg_10_0._doubleAble, arg_10_0._speedAble)

	if arg_10_0._activeAniamtorName ~= var_10_0 then
		arg_10_0.chacheSprite = arg_10_0._animImage.sprite

		local var_10_1

		for iter_10_0 = 1, #arg_10_0._animDatas do
			if arg_10_0._animDatas[iter_10_0].name == var_10_0 then
				var_10_1 = var_7.runtimeAnimator
			end
		end

		local var_10_2

		if var_10_1 then
			arg_10_0._activeAniamtorName = var_10_0
			var_10_2 = arg_10_0._animator
			var_10_2.runtimeAnimatorController = var_10_1
			setActive = var_10_2

			var_10_2(arg_10_0._animTf, false)

			if arg_10_0.chacheSprite then
				var_10_2 = arg_10_0._animImage
				var_10_2.sprite = arg_10_0.chacheSprite
			end

			setActive = var_10_2

			var_10_2(arg_10_0._animTf, true)
		else
			print = var_10_2

			var_10_2("警告 找不到aniamtor ：" .. var_10_0)
		end
	end

	return
end

function var_0_0.getAnimatorName(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6)
	local var_11_0

	if arg_11_5 then
		var_11_0 = arg_11_1 .. "_L" .. arg_11_2 .. "_R" .. arg_11_3
	elseif arg_11_6 then
		var_11_0 = arg_11_1 .. "_" .. "L" .. arg_11_2 .. "_" .. arg_11_4
	else
		var_11_0 = arg_11_1 .. "_" .. "L" .. arg_11_2
	end

	return var_11_0
end

function var_0_0.setCake(arg_12_0, arg_12_1)
	arg_12_0._cakeData = arg_12_1

	arg_12_0:clearJudge()
	arg_12_0:clearTargetPos()

	return
end

function var_0_0.getCake(arg_13_0)
	return arg_13_0._cakeData
end

function var_0_0.clearCake(arg_14_0)
	if arg_14_0._cakeData then
		setActive = var_1
		findTF = var_1_10003

		var_1(var_1_10003(arg_14_0._cakeData.tf, "select"), false)

		arg_14_0._cakeData = nil
	end

	return
end

function var_0_0.setJudge(arg_15_0, arg_15_1)
	arg_15_0._judgeData = arg_15_1

	arg_15_0:clearCake()
	arg_15_0:clearTargetPos()

	return
end

function var_0_0.clearJudge(arg_16_0)
	if arg_16_0._judgeData then
		setActive = var_1
		findTF = var_1_10003

		var_1(var_1_10003(arg_16_0._judgeData.tf, "select"), false)

		arg_16_0._judgeData = nil
	end

	return
end

function var_0_0.getJudgeData(arg_17_0)
	return arg_17_0._judgeData
end

function var_0_0.setTargetPos(arg_18_0, arg_18_1)
	arg_18_0._targetPos = arg_18_1

	arg_18_0:clearVelocity()

	return
end

function var_0_0.stopMove(arg_19_0)
	arg_19_0:clearTargetPos()
	arg_19_0:clearVelocity()
	arg_19_0:updateAnimatorParame()

	if not arg_19_0.activing then
		if arg_19_0._cakeData then
			arg_19_0:pickupCake()
		elseif arg_19_0._judgeData then
			arg_19_0:readyServeCake()
		end
	else
		arg_19_0:clearCake()
		arg_19_0:clearJudge()
	end

	return
end

function var_0_0.getJudge(arg_20_0)
	if arg_20_0._judgeData then
		return arg_20_0._judgeData.judge
	end

	return nil
end

function var_0_0.pickupCake(arg_21_0)
	if arg_21_0._cakeData then
		local var_21_0 = arg_21_0._cakeData.id
		local var_21_1 = arg_21_0._cakeData.tf
		local var_21_2 = arg_21_0._tf.parent

		if var_3.InverseTransformPoint(var_21_2, var_21_1.position).x < arg_21_0._tf.anchoredPosition.x then
			arg_21_0.directX = -1
			arg_21_0.directY = -1
		else
			arg_21_0.directX = 1
			arg_21_0.directY = -1
		end

		if arg_21_0._doubleAble then
			if arg_21_0.cakeNum == 0 then
				arg_21_0.leftCakeId = var_21_0
				arg_21_0.rightCakeId = 0
				arg_21_0.cakeNum = 1
				arg_21_0.useL = true
				arg_21_0.useR = false
			elseif arg_21_0.cakeNum == 1 then
				arg_21_0.cakeNum = 2
				arg_21_0.rightCakeId = var_21_0
				arg_21_0.useL = false
				arg_21_0.useR = true
			elseif arg_21_0.cakeNum == 2 then
				if arg_21_0._doubleIndex % 2 == 0 then
					arg_21_0.leftCakeId = var_21_0
					arg_21_0.useL = true
					arg_21_0.useR = false
				else
					arg_21_0.rightCakeId = var_21_0
					arg_21_0.useL = false
					arg_21_0.useR = true
				end

				arg_21_0._doubleIndex = arg_21_0._doubleIndex + 1
			end
		else
			arg_21_0.leftCakeId = var_21_0
			arg_21_0.cakeNum = 1
		end

		if arg_21_0._pickupFull and arg_21_0:isFullCakes() then
			arg_21_0:setPickupFull(false)
		end

		arg_21_0:updateCharAniamtor()
		arg_21_0:updateAnimatorParame()
		arg_21_0:clearCake()
		arg_21_0:pickup()
	end

	return
end

function var_0_0.readyServeCake(arg_22_0)
	local var_22_0 = arg_22_0._judgeData.judge

	if var_1.isInServe(var_22_0) or var_1:isInTrigger() or arg_22_0.cakeNum == 0 then
		arg_22_0:clearJudge()

		return
	end

	local var_22_1 = arg_22_0._judgeData.tf
	local var_22_2 = arg_22_0._tf.parent

	if var_3.InverseTransformPoint(var_22_2, var_22_1.position).x < arg_22_0._tf.anchoredPosition.x then
		arg_22_0.directX = -1
		arg_22_0.directY = -1
	else
		arg_22_0.directX = 1
		arg_22_0.directY = -1
	end

	local var_22_3 = var_1:getWantedCake()
	local var_22_4 = arg_22_0.leftCakeId

	arg_22_0.serveRight = false

	if arg_22_0._doubleAble then
		if arg_22_0.leftCakeId == var_22_3 then
			arg_22_0.useL = true
			arg_22_0.useR = false
			var_22_4 = arg_22_0.leftCakeId
			arg_22_0.leftCakeId = arg_22_0.rightCakeId
			arg_22_0.rightCakeId = 0
			arg_22_0.serveRight = true
		elseif arg_22_0.rightCakeId == var_22_3 then
			arg_22_0.useL = false
			arg_22_0.useR = true
			var_22_4 = arg_22_0.rightCakeId
			arg_22_0.rightCakeId = 0
			arg_22_0.serveRight = true
		else
			arg_22_0.useL = true
			arg_22_0.useR = false
			var_22_4 = arg_22_0.leftCakeId
			arg_22_0.leftCakeId = arg_22_0.rightCakeId
			arg_22_0.rightCakeId = 0
		end

		if var_22_4 == var_22_3 then
			arg_22_0.rightCakeIndex = arg_22_0.rightCakeIndex + 1
		end
	elseif arg_22_0._speedAble then
		if var_22_3 == arg_22_0.leftCakeId then
			if arg_22_0.speedNum < arg_22_0._speedMax then
				arg_22_0.speedNum = arg_22_0.speedNum + 1
			end

			arg_22_0.serveRight = true
			arg_22_0.serveWrong = false
		else
			arg_22_0.serveRight = false
			arg_22_0.serveWrong = true
			arg_22_0.speedNum = 0
		end

		arg_22_0.directX = -1 * arg_22_0.directX
		arg_22_0.leftCakeId = 0
	elseif arg_22_0._scoreAdded or arg_22_0._randomScore then
		if var_22_3 == arg_22_0.leftCakeId then
			arg_22_0.serveRight = true
			arg_22_0.serveWrong = false
		else
			arg_22_0.serveRight = false
			arg_22_0.serveWrong = true
		end

		arg_22_0.leftCakeId = 0
	else
		if var_22_3 == arg_22_0.leftCakeId then
			arg_22_0.serveRight = true
		end

		arg_22_0.leftCakeId = 0
	end

	if not arg_22_0.serveRight and arg_22_0._charData.battleData.cake_allow then
		arg_22_0.serveRight = true
	end

	if not arg_22_0._charData.battleData.weight then
		local var_22_5 = 0
	end

	local var_22_6 = var_1
	local var_22_7 = var_1.getPuzzleCamp(var_22_6)

	arg_22_0.puzzleDouble = false
	arg_22_0.puzzleReject = false

	if var_22_7 then
		if arg_22_0._camp == var_22_7 then
			arg_22_0.serveRight = true
			arg_22_0.puzzleDouble = true
			arg_22_0.serveWrong = false
		else
			arg_22_0.serveRight = false
			arg_22_0.serveWrong = true
			arg_22_0.puzzleReject = true
		end
	end

	if arg_22_0._speedAble and arg_22_0.serveRight then
		arg_22_0._serveSpeed = true
		pg = var_8

		local var_22_8 = var_8.CriMgr.GetInstance()
		local var_22_9 = var_8.PlaySoundEffect_V3

		CookGameConst = var_1_10011

		var_22_9(var_22_8, var_1_10011.sound_speed_up)
	end

	if arg_22_0.serveRight then
		arg_22_0.rightCakeIndex = arg_22_0.rightCakeIndex + 1
		arg_22_0.seriesRightIndex = arg_22_0.seriesRightIndex + 1

		local var_22_10 = arg_22_0.seriesRightIndex

		CookGameConst = var_22_6

		if var_22_6.added_max < var_22_10 then
			CookGameConst = var_22_10
			arg_22_0.seriesRightIndex = var_22_10.added_max
		end
	else
		arg_22_0.seriesRightIndex = 0
	end

	arg_22_0.triggerPuzzle = false

	if arg_22_0._charData.battleData.puzzle and arg_22_0.serveRight then
		math = var_8

		local var_22_11 = var_8.random(1, 100)

		CookGameConst = var_22_6
		arg_22_0.triggerPuzzle = var_22_11 <= var_22_6.puzzle_rate
	end

	arg_22_0:checkEffectInServe()

	arg_22_0.serveCakeId = var_22_4
	arg_22_0._serveFresh = true

	local var_22_12 = {
		parameter = arg_22_0:getParameter(),
		battleData = arg_22_0._charData.battleData,
		judgeData = arg_22_0._judgeData
	}

	var_1:readyServe(var_22_12)

	if arg_22_0._acAble then
		local var_22_13 = arg_22_0:getAcCakeData(var_1)

		function arg_22_0._serveFunc()
			local var_23_0 = arg_22_0._event
			local var_23_1 = var_0.emit

			CookGameView = var_2_10003

			var_23_1(var_23_0, var_2_10003.AC_CAKE_EVENT, var_22_13)

			return
		end

		pg = var_10

		local var_22_14 = var_10.CriMgr.GetInstance()
		local var_22_15 = var_10.PlaySoundEffect_V3

		CookGameConst = var_1_10013

		var_22_15(var_22_14, var_1_10013.sound_ac)
	else
		function arg_22_0._serveFunc()
			local var_24_0 = var_0

			var_0.serve(var_24_0)

			return
		end
	end

	arg_22_0:updateAnimatorParame()
	arg_22_0:startServeCake()

	return
end

function var_0_0.getAcCakeData(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_1:getAcTargetTf()
	local var_25_1 = arg_25_0._tf.parent
	local var_25_2 = var_3.InverseTransformPoint(var_25_1, var_25_0.position)

	if arg_25_0.serveRight then
		var_25_2.y = var_25_2.y
	else
		var_25_2.y = var_25_2.y + 50
	end

	local var_25_3

	if arg_25_0.directX == 1 then
		local var_25_4 = arg_25_0._tf.parent
		local var_25_5 = var_5.InverseTransformPoint

		findTF = var_1_10008
		var_25_3 = var_25_5(var_25_4, var_1_10008(arg_25_0._tf, "acR").position)
	else
		local var_25_6 = arg_25_0._tf.parent
		local var_25_7 = var_5.InverseTransformPoint

		findTF = var_1_10008
		var_25_3 = var_25_7(var_25_6, var_1_10008(arg_25_0._tf, "acL").position)
	end

	local function var_25_8()
		local var_26_0 = arg_25_1

		var_0.serve(var_26_0)

		return
	end

	return {
		cakeId = arg_25_0.serveCakeId,
		startPos = var_25_3,
		targetPos = var_25_2,
		callback = var_25_8
	}
end

function var_0_0.getParameter(arg_27_0)
	local var_27_0

	if not arg_27_0._charData.battleData.weight then
		var_27_0 = 0
	end

	return {
		cakeId = arg_27_0.serveCakeId,
		right_index = arg_27_0.rightCakeIndex,
		series_right_index = arg_27_0.seriesRightIndex,
		camp = arg_27_0._camp,
		puzzle_double = arg_27_0.puzzleDouble,
		puzzleReject = arg_27_0.puzzleReject,
		puzzle = arg_27_0.triggerPuzzle,
		weight = var_27_0,
		right_flag = arg_27_0.serveRight
	}
end

function var_0_0.checkEffectInServe(arg_28_0)
	local var_28_0 = arg_28_0._charData.battleData.effect
	local var_28_1

	Vector3 = var_1_10003

	local var_28_2 = var_1_10003(1, 1, 1)

	if arg_28_0._scoreAdded and arg_28_0.serveRight then
		local var_28_3

		if arg_28_0.seriesRightIndex == 0 then
			var_28_3 = 1
		elseif arg_28_0.seriesRightIndex > #var_28_0 then
			var_28_3 = #var_28_0
		else
			var_28_3 = arg_28_0.seriesRightIndex
		end

		var_28_1 = var_28_0[var_28_3]
	elseif arg_28_0.triggerPuzzle then
		var_28_1 = var_28_0[1]

		if arg_28_0._isPartner or arg_28_0._isPlayer then
			Vector3 = var_4
			var_28_2 = var_4(1, 1, 1)
		else
			Vector3 = var_4
			var_28_2 = var_4(-1, 1, 1)
		end
	end

	if not arg_28_0._effectContent then
		findTF = var_4
		arg_28_0._effectContent = var_4(arg_28_0._tf, "effect")
	end

	if var_28_1 then
		findTF = var_4

		local var_28_4 = var_4(arg_28_0._effectContent, var_28_1)

		findTF = var_5

		local var_28_5

		var_28_5, GetComponent = var_5(var_28_4, "anim"), var_6
		typeof = var_1_10009
		DftAniEvent = var_1_10011

		local var_28_6 = var_6(var_28_5, var_1_10009(var_1_10011))

		var_28_4.localScale = var_28_2

		var_28_6:SetEndEvent(function(arg_29_0)
			setActive = var_2_10001

			var_2_10001(var_28_4, false)

			return
		end)

		setActive = var_7

		var_7(var_28_4, true)
	end

	return
end

function var_0_0.getId(arg_30_0)
	return arg_30_0._charData.battleData.id
end

function var_0_0.getDoubleAble(arg_31_0)
	return arg_31_0._doubleAble
end

function var_0_0.setPetFlag(arg_32_0, arg_32_1)
	arg_32_0._isPet = arg_32_1

	return
end

function var_0_0.getpetFlag(arg_33_0)
	return arg_33_0._isPet
end

function var_0_0.setCharActive(arg_34_0, arg_34_1)
	arg_34_0._isActive = arg_34_1
	setActive = var_1_10002

	var_1_10002(arg_34_0._tf, arg_34_0._isActive)

	return
end

function var_0_0.getCharActive(arg_35_0)
	return arg_35_0._isActive
end

function var_0_0.isFullCakes(arg_36_0)
	if arg_36_0._doubleAble and arg_36_0.cakeNum == 2 then
		return true
	elseif not arg_36_0._doubleAble and arg_36_0.cakeNum == 1 then
		return true
	end

	return false
end

function var_0_0.getPickupFull(arg_37_0)
	return arg_37_0._pickupFull
end

function var_0_0.setPickupFull(arg_38_0, arg_38_1)
	arg_38_0._pickupFull = arg_38_1

	return
end

function var_0_0.getTargetPos(arg_39_0)
	return arg_39_0._targetPos
end

function var_0_0.clearTargetPos(arg_40_0)
	arg_40_0._targetPos = nil

	return
end

function var_0_0.setVelocity(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	Vector2 = var_1_10004
	arg_41_0._velocity = var_1_10004(arg_41_1 * arg_41_0._baseSpeed * (1 + arg_41_0.speedNum / 3), arg_41_2 * arg_41_0._baseSpeed * (1 + arg_41_0.speedNum / 3))

	if not arg_41_0._isPlayer and not arg_41_0._isPartner then
		Vector2 = var_4
		arg_41_0._velocity = var_4(arg_41_0._velocity.x * 0.9, arg_41_0._velocity.y * 0.9)
	end

	math = var_4

	local var_41_0 = var_4.rad2Deg * arg_41_3
	local var_41_1 = arg_41_1 > 0 and 1 or -1
	local var_41_2 = arg_41_2 > 0 and 1 or -1

	math = var_7

	if var_7.abs(var_41_0) <= var_0_1 then
		var_41_2 = 0
	elseif var_0_1 < var_41_0 then
		math = var_7

		if 90 - var_7.abs(var_41_0) <= var_0_1 then
			var_41_1 = 0
		end
	end

	arg_41_0.directX = var_41_1
	arg_41_0.directY = var_41_2
	arg_41_0.run = true
	arg_41_0.idle = false

	arg_41_0:updateAnimatorParame()

	return
end

function var_0_0.updateAnimatorParame(arg_42_0)
	arg_42_0:setInteger("x", arg_42_0.directX)
	arg_42_0:setInteger("y", arg_42_0.directY)
	arg_42_0:setBool("run", arg_42_0.run)
	arg_42_0:setBool("idle", arg_42_0.idle)
	arg_42_0:setInteger("num", arg_42_0.cakeNum)

	if arg_42_0._doubleAble then
		arg_42_0:setBool("L", arg_42_0.useL)
		arg_42_0:setBool("R", arg_42_0.useR)
	end

	if arg_42_0._speedAble then
		arg_42_0:setInteger("speed_lv", arg_42_0.speedNum)
		arg_42_0:setTrigger("serve_right", arg_42_0.serveRight)
		arg_42_0:setTrigger("serve_wrong", arg_42_0.serveWrong)
	end

	if arg_42_0._randomScore then
		arg_42_0:setTrigger("serve_right", arg_42_0.serveRight)
		arg_42_0:setTrigger("serve_wrong", arg_42_0.serveWrong)
	end

	if arg_42_0._scoreAdded then
		arg_42_0:setTrigger("serve_right", arg_42_0.serveRight == true)
		arg_42_0:setTrigger("serve_wrong", arg_42_0.serveWrong == true)
		arg_42_0:setBool("server_a", arg_42_0.seriesRightIndex <= 2)
		arg_42_0:setBool("server_b", arg_42_0.seriesRightIndex > 2)
	end

	return
end

function var_0_0.getVelocity(arg_43_0)
	return arg_43_0._velocity
end

function var_0_0.clearVelocity(arg_44_0)
	arg_44_0._velocity = nil
	arg_44_0.run = false
	arg_44_0.idle = true

	return
end

function var_0_0.move(arg_45_0)
	if arg_45_0:isActiving() then
		return
	end

	if arg_45_0._velocity then
		if arg_45_0._targetPos then
			local var_45_0 = arg_45_0:getPos()
			local var_45_1 = arg_45_0._targetPos.x - var_45_0.x >= 0 and 1 or -1
			local var_45_2 = arg_45_0._targetPos.y - var_45_0.y >= 0 and 1 or -1

			var_4.x = arg_45_0:getPos().x + arg_45_0._velocity.x * arg_45_0.deltaTime
			var_4.y = var_4.y + arg_45_0._velocity.y * arg_45_0.deltaTime

			local var_45_3 = arg_45_0._targetPos.x - var_4.x >= 0 and 1 or -1
			local var_45_4 = arg_45_0._targetPos.y - var_4.y >= 0 and 1 or -1
			local var_45_5 = arg_45_0
			local var_45_6 = arg_45_0.getPos(var_45_5)

			if var_45_1 == var_45_3 then
				var_45_6.x = var_45_6.x + arg_45_0._velocity.x * arg_45_0.deltaTime
			else
				var_45_6.x = arg_45_0._targetPos.x
			end

			if var_45_2 == var_45_4 then
				var_45_6.y = var_45_6.y + arg_45_0._velocity.y * arg_45_0.deltaTime
			else
				var_45_6.y = arg_45_0._targetPos.y
			end

			if arg_45_0._acAble and arg_45_0._judgeData then
				math = var_8

				local var_45_7 = var_8.sqrt

				math = var_1_10010

				local var_45_8 = var_1_10010.pow(arg_45_0._targetPos.x - var_45_6.x, 2)

				math = var_1_10011

				local var_45_9 = var_45_7(var_45_8 + var_1_10011.pow(arg_45_0._targetPos.y - var_45_6.y, 2))

				CookGameConst = var_45_5

				if var_45_9 <= var_45_5.ac_dictance then
					arg_45_0:stopMove()
					arg_45_0:clearJudge()

					return
				end
			end

			local var_45_10 = arg_45_0._tf

			var_45_10.anchoredPosition = var_45_6

			if var_45_1 ~= var_45_3 and var_45_1 ~= var_45_3 then
				arg_45_0:stopMove()
			else
				math = var_45_10

				if var_45_10.abs(arg_45_0._targetPos.x - var_45_6.x) < 5 then
					math = var_8

					if var_8.abs(arg_45_0._targetPos.y - var_45_6.y) < 5 then
						arg_45_0:stopMove()
					end
				end
			end
		else
			local var_45_11 = arg_45_0:getPos()

			var_2.x = arg_45_0._tf.anchoredPosition.x + arg_45_0._velocity.x * arg_45_0.deltaTime
			var_2.y = var_2.y + arg_45_0._velocity.y * arg_45_0.deltaTime
			arg_45_0._tf.anchoredPosition = var_2
		end
	end

	return
end

function var_0_0.extend(arg_46_0)
	if not arg_46_0.activing and not arg_46_0.clearing then
		arg_46_0.extendFlag = false
		arg_46_0.activing = true
		arg_46_0.sendExtend = true
		pg = var_1

		local var_46_0 = var_1.CriMgr.GetInstance()
		local var_46_1 = var_1.PlaySoundEffect_V3

		CookGameConst = var_1_10004

		var_46_1(var_46_0, var_1_10004.sound_marcopolo_skill)
		arg_46_0:setTrigger("Extend", true)

		arg_46_0.timeToEventHandle = var_0_2
	end

	return
end

function var_0_0.isActiving(arg_47_0)
	return arg_47_0.activing
end

function var_0_0.getPos(arg_48_0)
	return arg_48_0._tf.anchoredPosition
end

function var_0_0.startServeCake(arg_49_0)
	if arg_49_0.activing then
		return
	end

	arg_49_0.activing = true
	arg_49_0.activingTime = 3

	arg_49_0:setTrigger("server", true)

	return
end

function var_0_0.pickup(arg_50_0)
	if arg_50_0.activing then
		return
	end

	pg = var_1

	local var_50_0 = var_1.CriMgr.GetInstance()
	local var_50_1 = var_1.PlaySoundEffect_V3

	CookGameConst = var_1_10004

	var_50_1(var_50_0, var_1_10004.sound_pickup)
	arg_50_0:setTrigger("pickup", true)

	arg_50_0.activing = true

	return
end

function var_0_0.setParent(arg_51_0, arg_51_1, arg_51_2)
	findTF = var_1_10003

	local var_51_0 = var_1_10003(arg_51_1, arg_51_2.parent)

	arg_51_0._tf.anchoredPosition = arg_51_2.init_pos

	local var_51_1 = arg_51_0._tf

	var_51_1.name = arg_51_2.tf_name
	setParent = var_51_1

	var_51_1(arg_51_0._tf, var_51_0)

	setActive = var_51_1

	var_51_1(arg_51_0._tf, true)

	arg_51_0.initPos = arg_51_2.init_pos
	findTF = var_4
	arg_51_0._bound = var_4(arg_51_1, "scene_background/" .. arg_51_2.bound)

	return
end

function var_0_0.getTf(arg_52_0)
	return arg_52_0._tf
end

function var_0_0.getOffset(arg_53_0)
	return arg_53_0._offset
end

function var_0_0.getCakeIds(arg_54_0)
	local var_54_0 = {}

	if arg_54_0.leftCakeId > 0 then
		table = var_2

		var_2.insert(var_54_0, arg_54_0.leftCakeId)
	end

	if arg_54_0.rightCakeId > 0 then
		table = var_2

		var_2.insert(var_54_0, arg_54_0.rightCakeId)
	end

	return var_54_0
end

function var_0_0.isPlayer(arg_55_0, arg_55_1)
	setActive = var_1_10002
	findTF = var_1_10004

	var_1_10002(var_1_10004(arg_55_0._tf, "player"), arg_55_1)

	arg_55_0._isPlayer = arg_55_1

	if arg_55_0._isPlayer then
		CookGameConst = var_2
		arg_55_0._camp = var_2.camp_player
	else
		CookGameConst = var_2
		arg_55_0._camp = var_2.camp_enemy
	end

	return
end

function var_0_0.isPartner(arg_56_0, arg_56_1)
	arg_56_0._isPartner = arg_56_1

	if arg_56_0._isPartner then
		CookGameConst = var_2
		arg_56_0._camp = var_2.camp_player
	else
		CookGameConst = var_2
		arg_56_0._camp = var_2.camp_enemy
	end

	return
end

function var_0_0.getCamp(arg_57_0)
	return arg_57_0._camp
end

function var_0_0.setBool(arg_58_0, arg_58_1, arg_58_2)
	local var_58_0 = arg_58_0._animator

	var_3.SetBool(var_58_0, arg_58_1, arg_58_2)

	return
end

function var_0_0.setTrigger(arg_59_0, arg_59_1, arg_59_2)
	if arg_59_2 then
		local var_59_0 = arg_59_0._animator

		var_3.SetTrigger(var_59_0, arg_59_1)
	else
		local var_59_1 = arg_59_0._animator

		var_3.ResetTrigger(var_59_1, arg_59_1)
	end

	return
end

function var_0_0.setInteger(arg_60_0, arg_60_1, arg_60_2)
	local var_60_0 = arg_60_0._animator

	var_3.SetInteger(var_60_0, arg_60_1, arg_60_2)

	return
end

function var_0_0.clear(arg_61_0)
	arg_61_0.leftCakeId = 0
	arg_61_0.rightCakeId = 0
	arg_61_0._serveSpeed = false
	arg_61_0.cakeNum = 0
	arg_61_0.speedNum = 1
	arg_61_0._speedRate = 1
	arg_61_0.directX = 0
	arg_61_0.directY = -1
	arg_61_0.activing = false
	arg_61_0.scoreAdded = false
	arg_61_0._tf.anchoredPosition = arg_61_0.initPos
	arg_61_0.useL = true
	arg_61_0.useR = false
	arg_61_0.rightCakeIndex = 0
	arg_61_0.seriesRightIndex = 0

	arg_61_0:clearCake()
	arg_61_0:clearJudge()
	arg_61_0:clearTargetPos()

	local var_61_0 = arg_61_0

	arg_61_0.clearVelocity(var_61_0)

	setActive = var_1
	findTF = var_61_0

	var_1(var_61_0(arg_61_0._tf, "effectW"), false)

	setActive = var_1
	findTF = var_3

	var_1(var_3(arg_61_0._tf, "effectE"), false)

	if arg_61_0._animator and arg_61_0._animator.runtimeAnimatorController then
		arg_61_0:setInteger("x", 0)
		arg_61_0:setInteger("y", -1)
		arg_61_0:setInteger("num", 0)
		arg_61_0:setBool("idle", true)
		arg_61_0:setBool("run", false)
		arg_61_0:setBool("L", false)
		arg_61_0:setBool("R", false)
		arg_61_0:setTrigger("server", false)
		arg_61_0:setTrigger("pickup", false)
		arg_61_0:setTrigger("serve_right", false)
		arg_61_0:setTrigger("serve_wrong", false)
		arg_61_0:setInteger("speed_lv", 0)
	end

	arg_61_0._pickupFull = false

	return
end

return var_0_0
