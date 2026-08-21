local var_0_0 = class("CookGameChar")
local var_0_1 = 20
local var_0_2 = 3

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._gameData = arg_1_2
	arg_1_0._event = arg_1_3
	arg_1_0._animTf = findTF(arg_1_0._tf, "mask/anim")
	arg_1_0._animator = GetComponent(findTF(arg_1_0._tf, "mask/anim"), typeof(Animator))
	arg_1_0._animImage = GetComponent(findTF(arg_1_0._tf, "mask/anim"), typeof(Image))
	arg_1_0._dftEvent = GetComponent(findTF(arg_1_0._tf, "mask/anim"), typeof(DftAniEvent))

	arg_1_0._dftEvent:SetStartEvent(function(arg_2_0)
		if arg_1_0._serveFunc then
			arg_1_0._serveFunc()

			arg_1_0._serveFunc = nil

			pg.CriMgr.GetInstance():PlaySoundEffect_V3(CookGameConst.sound_serve)
		end

		return
	end)
	arg_1_0._dftEvent:SetEndEvent(function(arg_3_0)
		arg_1_0:endEventHandle()

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
			setActive(findTF(arg_4_0._tf, "effectW"), false)
			setActive(findTF(arg_4_0._tf, "effectW"), true)
		else
			setActive(findTF(arg_4_0._tf, "effectE"), false)
			setActive(findTF(arg_4_0._tf, "effectE"), true)
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

		arg_4_0._event:emit(CookGameView.EXTEND_EVENT)
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
	arg_6_0._offset = arg_6_1.battleData.offset or Vector2(0, 0)
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
				var_10_1 = arg_10_0._animDatas[iter_10_0].runtimeAnimator
			end
		end

		if var_10_1 then
			arg_10_0._activeAniamtorName = var_10_0
			arg_10_0._animator.runtimeAnimatorController = var_10_1

			setActive(arg_10_0._animTf, false)

			if arg_10_0.chacheSprite then
				arg_10_0._animImage.sprite = arg_10_0.chacheSprite
			end

			setActive(arg_10_0._animTf, true)
		else
			print("警告 找不到aniamtor ：" .. var_10_0)
		end
	end

	return
end

function var_0_0.getAnimatorName(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6)
	return arg_11_5 and arg_11_1 .. "_L" .. arg_11_2 .. "_R" .. arg_11_3 or arg_11_6 and arg_11_1 .. "_" .. "L" .. arg_11_2 .. "_" .. arg_11_4 or arg_11_1 .. "_" .. "L" .. arg_11_2
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
		setActive(findTF(arg_14_0._cakeData.tf, "select"), false)

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
		setActive(findTF(arg_16_0._judgeData.tf, "select"), false)

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

		if arg_21_0._tf.parent:InverseTransformPoint(arg_21_0._cakeData.tf.position).x < arg_21_0._tf.anchoredPosition.x then
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

	if arg_22_0._judgeData.judge:isInServe() or var_22_0:isInTrigger() or arg_22_0.cakeNum == 0 then
		arg_22_0:clearJudge()

		return
	end

	local var_22_1 = arg_22_0._tf.parent:InverseTransformPoint(arg_22_0._judgeData.tf.position).x

	if var_22_1 < arg_22_0._tf.anchoredPosition.x then
		arg_22_0.directX = -1
		arg_22_0.directY = -1
	else
		arg_22_0.directX = 1
		arg_22_0.directY = -1
	end

	local var_22_2 = var_22_0:getWantedCake()
	local var_22_3 = arg_22_0.leftCakeId

	arg_22_0.serveRight = false

	if arg_22_0._doubleAble then
		if arg_22_0.leftCakeId == var_22_2 then
			arg_22_0.useL = true
			arg_22_0.useR = false
			var_22_3 = arg_22_0.leftCakeId
			arg_22_0.leftCakeId = arg_22_0.rightCakeId
			arg_22_0.rightCakeId = 0
			arg_22_0.serveRight = true
		elseif arg_22_0.rightCakeId == var_22_2 then
			arg_22_0.useL = false
			arg_22_0.useR = true
			var_22_3 = arg_22_0.rightCakeId
			arg_22_0.rightCakeId = 0
			arg_22_0.serveRight = true
		else
			arg_22_0.useL = true
			arg_22_0.useR = false
			var_22_3 = arg_22_0.leftCakeId
			arg_22_0.leftCakeId = arg_22_0.rightCakeId
			arg_22_0.rightCakeId = 0
		end

		if var_22_3 == var_22_2 then
			arg_22_0.rightCakeIndex = arg_22_0.rightCakeIndex + 1
		end
	elseif arg_22_0._speedAble then
		if var_22_2 == arg_22_0.leftCakeId then
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
		if var_22_2 == arg_22_0.leftCakeId then
			arg_22_0.serveRight = true
			arg_22_0.serveWrong = false
		else
			arg_22_0.serveRight = false
			arg_22_0.serveWrong = true
		end

		arg_22_0.leftCakeId = 0
	else
		if var_22_2 == arg_22_0.leftCakeId then
			arg_22_0.serveRight = true
		end

		arg_22_0.leftCakeId = 0
	end

	if not arg_22_0.serveRight and arg_22_0._charData.battleData.cake_allow then
		arg_22_0.serveRight = true
	end

	if not arg_22_0._charData.battleData.weight then
		-- block empty
	end

	local var_22_5 = var_22_0:getPuzzleCamp()

	arg_22_0.puzzleDouble = false
	arg_22_0.puzzleReject = false

	if var_22_5 then
		if arg_22_0._camp == var_22_5 then
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

		pg.CriMgr.GetInstance():PlaySoundEffect_V3(CookGameConst.sound_speed_up)
	end

	if arg_22_0.serveRight then
		arg_22_0.rightCakeIndex = arg_22_0.rightCakeIndex + 1
		arg_22_0.seriesRightIndex = arg_22_0.seriesRightIndex + 1

		if arg_22_0.seriesRightIndex > CookGameConst.added_max then
			arg_22_0.seriesRightIndex = CookGameConst.added_max
		end
	else
		arg_22_0.seriesRightIndex = 0
	end

	arg_22_0.triggerPuzzle = false

	if arg_22_0._charData.battleData.puzzle and arg_22_0.serveRight then
		arg_22_0.triggerPuzzle = math.random(1, 100) <= CookGameConst.puzzle_rate
	end

	arg_22_0:checkEffectInServe()

	arg_22_0.serveCakeId = var_22_3
	arg_22_0._serveFresh = true

	var_22_0:readyServe({
		parameter = arg_22_0:getParameter(),
		battleData = arg_22_0._charData.battleData,
		judgeData = arg_22_0._judgeData
	})

	if arg_22_0._acAble then
		local var_22_6 = arg_22_0:getAcCakeData(var_22_0)

		function arg_22_0._serveFunc()
			arg_22_0._event:emit(CookGameView.AC_CAKE_EVENT, var_22_6)

			return
		end

		pg.CriMgr.GetInstance():PlaySoundEffect_V3(CookGameConst.sound_ac)
	else
		function arg_22_0._serveFunc()
			var_22_0:serve()

			return
		end
	end

	arg_22_0:updateAnimatorParame()
	arg_22_0:startServeCake()

	return
end

function var_0_0.getAcCakeData(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0._tf.parent:InverseTransformPoint(arg_25_1:getAcTargetTf().position)

	var_25_0.y = arg_25_0.serveRight and var_25_0.y or var_25_0.y + 50

	local var_25_1 = arg_25_0.directX == 1 and arg_25_0._tf.parent:InverseTransformPoint(findTF(arg_25_0._tf, "acR").position) or arg_25_0._tf.parent:InverseTransformPoint(findTF(arg_25_0._tf, "acL").position)

	;({
		cakeId = arg_25_0.serveCakeId,
		startPos = var_25_1,
		targetPos = var_25_0
	}).callback = function()
		arg_25_1:serve()

		return
	end

	return {
		cakeId = arg_25_0.serveCakeId,
		startPos = var_25_1,
		targetPos = var_25_0
	}
end

function var_0_0.getParameter(arg_27_0)
	local var_27_0 = arg_27_0._charData.battleData.weight or 0

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
	local var_28_2 = Vector3(1, 1, 1)

	if arg_28_0._scoreAdded and arg_28_0.serveRight then
		local var_28_3 = arg_28_0.seriesRightIndex == 0 and 1 or arg_28_0.seriesRightIndex > #var_28_0 and #var_28_0 or arg_28_0.seriesRightIndex

		var_28_1 = var_28_0[var_28_3]
	elseif arg_28_0.triggerPuzzle then
		var_28_1 = var_28_0[1]
		var_28_2 = (arg_28_0._isPartner or arg_28_0._isPlayer) and Vector3(1, 1, 1) or Vector3(-1, 1, 1)
	end

	arg_28_0._effectContent = arg_28_0._effectContent or findTF(arg_28_0._tf, "effect")

	if var_28_1 then
		local var_28_4 = findTF(arg_28_0._effectContent, var_28_1)

		var_28_4.localScale = var_28_2

		GetComponent(findTF(var_28_4, "anim"), typeof(DftAniEvent)):SetEndEvent(function(arg_29_0)
			setActive(var_28_4, false)

			return
		end)
		setActive(var_28_4, true)
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

	setActive(arg_34_0._tf, arg_34_0._isActive)

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
	arg_41_0._velocity = Vector2(arg_41_1 * arg_41_0._baseSpeed * (1 + arg_41_0.speedNum / 3), arg_41_2 * arg_41_0._baseSpeed * (1 + arg_41_0.speedNum / 3))

	if not arg_41_0._isPlayer and not arg_41_0._isPartner then
		arg_41_0._velocity = Vector2(arg_41_0._velocity.x * 0.9, arg_41_0._velocity.y * 0.9)
	end

	local var_41_0 = math.rad2Deg * arg_41_3
	local var_41_1 = arg_41_1 > 0 and 1 or -1
	local var_41_2 = arg_41_2 > 0 and 1 or -1

	if math.abs(math.rad2Deg * arg_41_3) <= var_0_1 then
		var_41_2 = 0
	elseif var_41_0 > var_0_1 and 90 - math.abs(var_41_0) <= var_0_1 then
		var_41_1 = 0
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
			local var_45_3 = arg_45_0:getPos()

			var_45_3.x = var_45_3.x + arg_45_0._velocity.x * arg_45_0.deltaTime
			var_45_3.y = var_45_3.y + arg_45_0._velocity.y * arg_45_0.deltaTime

			local var_45_4 = arg_45_0._targetPos.x - var_45_3.x >= 0 and 1 or -1
			local var_45_5 = arg_45_0._targetPos.y - var_45_3.y >= 0 and 1 or -1
			local var_45_6 = arg_45_0:getPos()

			var_45_6.x = var_45_1 == (arg_45_0._targetPos.x - var_45_3.x >= 0 and 1 or -1) and var_45_6.x + arg_45_0._velocity.x * arg_45_0.deltaTime or arg_45_0._targetPos.x
			var_45_6.y = var_45_2 == var_45_5 and var_45_6.y + arg_45_0._velocity.y * arg_45_0.deltaTime or arg_45_0._targetPos.y

			if arg_45_0._acAble and arg_45_0._judgeData and math.sqrt(math.pow(arg_45_0._targetPos.x - var_45_6.x, 2) + math.pow(arg_45_0._targetPos.y - var_45_6.y, 2)) <= CookGameConst.ac_dictance then
				arg_45_0:stopMove()
				arg_45_0:clearJudge()

				return
			end

			arg_45_0._tf.anchoredPosition = var_45_6

			if var_45_1 ~= var_45_4 and var_45_1 ~= var_45_4 then
				arg_45_0:stopMove()
			elseif math.abs(arg_45_0._targetPos.x - var_45_6.x) < 5 and math.abs(arg_45_0._targetPos.y - var_45_6.y) < 5 then
				arg_45_0:stopMove()
			end
		else
			local var_45_7 = arg_45_0:getPos()

			arg_45_0._tf.anchoredPosition.x = arg_45_0._tf.anchoredPosition.x + arg_45_0._velocity.x * arg_45_0.deltaTime
			arg_45_0._tf.anchoredPosition.y = arg_45_0._tf.anchoredPosition.y + arg_45_0._velocity.y * arg_45_0.deltaTime
			arg_45_0._tf.anchoredPosition = arg_45_0._tf.anchoredPosition
		end
	end

	return
end

function var_0_0.extend(arg_46_0)
	if not arg_46_0.activing and not arg_46_0.clearing then
		arg_46_0.extendFlag = false
		arg_46_0.activing = true
		arg_46_0.sendExtend = true

		pg.CriMgr.GetInstance():PlaySoundEffect_V3(CookGameConst.sound_marcopolo_skill)
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

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(CookGameConst.sound_pickup)
	arg_50_0:setTrigger("pickup", true)

	arg_50_0.activing = true

	return
end

function var_0_0.setParent(arg_51_0, arg_51_1, arg_51_2)
	arg_51_0._tf.anchoredPosition = arg_51_2.init_pos
	arg_51_0._tf.name = arg_51_2.tf_name

	setParent(arg_51_0._tf, (findTF(arg_51_1, arg_51_2.parent)))
	setActive(arg_51_0._tf, true)

	arg_51_0.initPos = arg_51_2.init_pos
	arg_51_0._bound = findTF(arg_51_1, "scene_background/" .. arg_51_2.bound)

	return
end

function var_0_0.getTf(arg_52_0)
	return arg_52_0._tf
end

function var_0_0.getOffset(arg_53_0)
	return arg_53_0._offset
end

function var_0_0.getCakeIds(arg_54_0)
	if arg_54_0.leftCakeId > 0 then
		table.insert({}, arg_54_0.leftCakeId)
	end

	if arg_54_0.rightCakeId > 0 then
		table.insert({}, arg_54_0.rightCakeId)
	end

	return {}
end

function var_0_0.isPlayer(arg_55_0, arg_55_1)
	setActive(findTF(arg_55_0._tf, "player"), arg_55_1)

	arg_55_0._isPlayer = arg_55_1
	arg_55_0._camp = arg_55_0._isPlayer and CookGameConst.camp_player or CookGameConst.camp_enemy

	return
end

function var_0_0.isPartner(arg_56_0, arg_56_1)
	arg_56_0._isPartner = arg_56_1
	arg_56_0._camp = arg_56_0._isPartner and CookGameConst.camp_player or CookGameConst.camp_enemy

	return
end

function var_0_0.getCamp(arg_57_0)
	return arg_57_0._camp
end

function var_0_0.setBool(arg_58_0, arg_58_1, arg_58_2)
	arg_58_0._animator:SetBool(arg_58_1, arg_58_2)

	return
end

function var_0_0.setTrigger(arg_59_0, arg_59_1, arg_59_2)
	if arg_59_2 then
		arg_59_0._animator:SetTrigger(arg_59_1)
	else
		arg_59_0._animator:ResetTrigger(arg_59_1)
	end

	return
end

function var_0_0.setInteger(arg_60_0, arg_60_1, arg_60_2)
	arg_60_0._animator:SetInteger(arg_60_1, arg_60_2)

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
	arg_61_0:clearVelocity()
	setActive(findTF(arg_61_0._tf, "effectW"), false)
	setActive(findTF(arg_61_0._tf, "effectE"), false)

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
