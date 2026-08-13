class = var_0_10000

local var_0_0 = var_0_10000("PacGameRole")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._roleData = arg_1_2
	arg_1_0._tf.name = arg_1_2.name
	arg_1_0._autoState = arg_1_2.auto_state
	arg_1_0._enemyFlag = arg_1_2.enemy
	arg_1_0._bound = arg_1_2.bound

	local var_1_0

	if not arg_1_2.rate or not arg_1_2.rate then
		var_1_0 = 0
	end

	arg_1_0._rate = var_1_0
	arg_1_0._rateCount = 0
	arg_1_0._halfBound = {
		arg_1_0._bound[1] / 2,
		arg_1_0._bound[2] / 2
	}
	GetComponent = var_3
	findTF = var_1_10005
	arg_1_0._spineAnimUI = var_3(var_1_10005(arg_1_0._tf, "spine"), "SpineAnimUI")
	arg_1_0._direct = {
		0,
		0
	}
	arg_1_0._rushState = false
	arg_1_0._rushTime = nil
	Vector2 = var_3
	arg_1_0._position = var_3(0, 0)
	arg_1_0._speed = arg_1_2.speed
	arg_1_0._rushSpeed = arg_1_2.rush_speed
	arg_1_0._anchoredPosition = arg_1_0._tf.anchoredPosition
	arg_1_0._roads = {}
	arg_1_0._targetHistory = {}
	arg_1_0._targetHistoryCount = 0
	arg_1_0._isPlayer = false
	GetComponent = var_3

	local var_1_1 = arg_1_0._tf

	typeof = var_6
	Animator = var_8
	arg_1_0._animator = var_3(var_1_1, var_6(var_8))
	findTF = var_3
	arg_1_0._directArrowTf = var_3(arg_1_0._tf, "player_arrow")

	arg_1_0:setActionNormal()

	return
end

function var_0_0.SetPlayer(arg_2_0, arg_2_1)
	arg_2_0._isPlayer = arg_2_1

	return
end

function var_0_0.Step(arg_3_0, arg_3_1)
	arg_3_0._deltaTime = arg_3_1

	local var_3_0 = arg_3_0._animator
	local var_3_1 = var_2.GetBool(var_3_0, "flash")
	local var_3_2 = false

	if arg_3_0._rushTime and arg_3_0._rushTime >= 0 then
		if arg_3_0._rushTime <= 3 then
			var_3_2 = true
		end

		arg_3_0._rushTime = arg_3_0._rushTime - arg_3_1

		if arg_3_0._rushTime < 0 then
			arg_3_0:SetRush(false, nil)

			arg_3_0._rushTime = nil
		end
	end

	if var_3_1 ~= var_3_2 then
		local var_3_3 = arg_3_0._animator

		var_4.SetBool(var_3_3, "flash", var_3_2)
	end

	if arg_3_0._backStartStepTime and arg_3_0._backStartStepTime >= 0 then
		arg_3_0._backStartStepTime = arg_3_0._backStartStepTime - arg_3_1

		if arg_3_0._backStartStepTime < 0 then
			arg_3_0:SetAction("normal", 0)
			arg_3_0:SetBackStart(false)

			arg_3_0._backStartStepTime = nil
		end
	end

	return
end

function var_0_0.GetSpeed(arg_4_0)
	if arg_4_0._rushState then
		return arg_4_0._rushSpeed
	elseif arg_4_0:GetBackStart() then
		return arg_4_0._speed * 4
	end

	if arg_4_0._isPlayer then
		return arg_4_0._speed
	end

	local var_4_0 = arg_4_0._speed + arg_4_0._rate * arg_4_0._rateCount

	PacGameConst = var_2

	if var_2.enemy_max_speed <= var_4_0 then
		PacGameConst = var_2

		local var_4_1

		if not var_2.enemy_max_speed then
			var_4_1 = var_4_0
		end

		return var_4_1
	end
end

function var_0_0.SetRateAdd(arg_5_0)
	arg_5_0._rateCount = arg_5_0._rateCount + 1

	return
end

function var_0_0.SetStartIndex(arg_6_0, arg_6_1)
	arg_6_0._startIndex = arg_6_1

	return
end

function var_0_0.GetStartIndex(arg_7_0)
	return arg_7_0._startIndex
end

function var_0_0.SetParent(arg_8_0, arg_8_1)
	setParent = var_1_10002

	var_1_10002(arg_8_0._tf, arg_8_1)

	return
end

function var_0_0.GetParent(arg_9_0)
	return arg_9_0._tf.parent
end

function var_0_0.SetPosition(arg_10_0, arg_10_1)
	arg_10_0._tf.anchoredPosition = arg_10_1
	arg_10_0._anchoredPosition = arg_10_0._tf.anchoredPosition

	return
end

function var_0_0.SetScale(arg_11_0, arg_11_1)
	arg_11_0._tf.localScale = arg_11_1

	return
end

function var_0_0.SetGridIndex(arg_12_0, arg_12_1)
	arg_12_0._gridIndex = arg_12_1

	if arg_12_0:GetBackStart() and arg_12_0._gridIndex == arg_12_0._startIndex then
		arg_12_0._backStartStepTime = 5
	end

	return
end

function var_0_0.GetGridIndex(arg_13_0)
	return arg_13_0._gridIndex
end

function var_0_0.GetGridIndexNext(arg_14_0)
	if arg_14_0:HasTarget() then
		math = var_1

		local var_14_0 = var_1.abs(arg_14_0._target.x - arg_14_0._tf.anchoredPosition.x)

		math = var_1_10002

		if var_14_0 + var_1_10002.abs(arg_14_0._target.y - arg_14_0._tf.anchoredPosition.y) >= arg_14_0._halfBound[1] then
			return arg_14_0._gridIndex
		elseif var_14_0 >= arg_14_0._halfBound[1] then
			return arg_14_0._gridIndex
		elseif var_2 >= arg_14_0._halfBound[2] then
			return arg_14_0._gridIndex
		end

		return arg_14_0._targetIndex
	end

	return arg_14_0._gridIndex
end

function var_0_0.HasTarget(arg_15_0)
	return arg_15_0._target ~= nil
end

function var_0_0.SetBackStart(arg_16_0, arg_16_1)
	arg_16_0._setBackToStart = arg_16_1

	return
end

function var_0_0.GetBackStart(arg_17_0)
	return arg_17_0._setBackToStart
end

function var_0_0.MoveTo(arg_18_0, arg_18_1)
	arg_18_0._targetHistoryCount = arg_18_0._targetHistoryCount + 1
	table = var_2

	var_2.insert(arg_18_0._targetHistory, arg_18_1)
	arg_18_0:SetPosition(arg_18_1)

	return
end

function var_0_0.GetMove(arg_19_0)
	return arg_19_0._move
end

function var_0_0.GetTarget(arg_20_0)
	return arg_20_0._target
end

function var_0_0.SetRoads(arg_21_0, arg_21_1)
	arg_21_0._roads = arg_21_1

	return
end

function var_0_0.GetRoads(arg_22_0)
	return arg_22_0._roads
end

function var_0_0.PopRoad(arg_23_0)
	if #arg_23_0._roads >= 0 then
		table = var_1

		return var_1.remove(arg_23_0._roads, 1)
	end

	return nil
end

function var_0_0.SetRoadBack(arg_24_0, arg_24_1)
	arg_24_0._roadBack = arg_24_1

	return
end

function var_0_0.GetRoadBack(arg_25_0)
	return arg_25_0._roadBack
end

function var_0_0.SetTarget(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	if arg_26_1 then
		arg_26_0._target = arg_26_1
		arg_26_0._targetIndex = arg_26_2
		arg_26_0._move = arg_26_3
		arg_26_0._targetDirect = arg_26_4
		arg_26_0._targetHistory = {}
		arg_26_0._targetHistoryCount = 0

		arg_26_0:setActionByDirect(arg_26_4)

		if arg_26_0._isPlayer then
			arg_26_0:setDirectArrow(arg_26_4)
		end
	else
		arg_26_0._target = nil
		arg_26_0._targetIndex = nil
		arg_26_0._move = nil
		arg_26_0._targetDirect = nil
		arg_26_0._targetHistory = {}
		arg_26_0._targetHistoryCount = 0

		arg_26_0:setActionByDirect(arg_26_0._direct)
	end

	return
end

function var_0_0.GetTargetHistoryCount(arg_27_0)
	return arg_27_0._targetHistoryCount
end

function var_0_0.GetTargetDirect(arg_28_0)
	return arg_28_0._targetDirect
end

function var_0_0.GetTargetIndex(arg_29_0)
	return arg_29_0._targetIndex
end

function var_0_0.GetAutoState(arg_30_0)
	return arg_30_0._autoState
end

function var_0_0.SetActive(arg_31_0, arg_31_1)
	setActive = var_1_10002

	var_1_10002(arg_31_0._tf, arg_31_1)

	return
end

function var_0_0.SetAction(arg_32_0, arg_32_1, arg_32_2)
	if arg_32_0._playingAction == arg_32_1 then
		return
	end

	arg_32_0._playingAction = arg_32_1

	local var_32_0 = arg_32_0._spineAnimUI

	var_3.SetAction(var_32_0, arg_32_1, arg_32_2)

	return
end

function var_0_0.SetActionCallBack(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0._spineAnimUI

	var_2.SetActionCallBack(var_33_0, arg_33_1)

	return
end

function var_0_0.SetRush(arg_34_0, arg_34_1, arg_34_2)
	print = var_1_10003

	var_1_10003("角色开始冲刺")

	arg_34_0._rushState = arg_34_1
	arg_34_0._rushTime = arg_34_2

	arg_34_0:reflashAniamtion()

	return
end

function var_0_0.GetRush(arg_35_0)
	return arg_35_0._rushState
end

function var_0_0.GetPosition(arg_36_0)
	return arg_36_0._anchoredPosition
end

function var_0_0.SetDirect(arg_37_0, arg_37_1)
	arg_37_1 = arg_37_1 or {
		0,
		0
	}
	arg_37_0._direct = arg_37_1

	if not arg_37_0:HasTarget() then
		arg_37_0:setActionByDirect(arg_37_0._direct)
	end

	return
end

function var_0_0.GetDirect(arg_38_0)
	return arg_38_0._direct
end

function var_0_0.SetAsLastSibling(arg_39_0)
	if arg_39_0._tf then
		local var_39_0 = arg_39_0._tf

		var_1.SetAsLastSibling(var_39_0)
	end

	return
end

function var_0_0.Dispose(arg_40_0)
	if arg_40_0._tf then
		destroy = var_1

		var_1(arg_40_0._tf)

		arg_40_0._tf = nil
	end

	arg_40_0._roleData = nil
	arg_40_0._playingAction = nil

	if arg_40_0._spineAnimUI then
		local var_40_0 = arg_40_0._spineAnimUI

		var_1.SetActionCallBack(var_40_0, nil)

		arg_40_0._spineAnimUI = nil
	end

	arg_40_0._target = nil
	arg_40_0._roads = {}

	return
end

function var_0_0.setDirectArrow(arg_41_0, arg_41_1)
	setActive = var_1_10002
	findTF = var_1_10004

	var_1_10002(var_1_10004(arg_41_0._tf, "bg/L"), false)

	setActive = var_1_10002
	findTF = var_4

	var_1_10002(var_4(arg_41_0._tf, "bg/R"), false)

	setActive = var_1_10002
	findTF = var_4

	var_1_10002(var_4(arg_41_0._tf, "bg/T"), false)

	setActive = var_1_10002
	findTF = var_4

	var_1_10002(var_4(arg_41_0._tf, "bg/B"), false)

	if arg_41_1[1] == 1 then
		setActive = var_2
		findTF = var_4

		var_2(var_4(arg_41_0._tf, "bg/R"), true)
	elseif arg_41_1[1] == -1 then
		setActive = var_2
		findTF = var_4

		var_2(var_4(arg_41_0._tf, "bg/L"), true)
	elseif arg_41_1[2] == 1 then
		setActive = var_2
		findTF = var_4

		var_2(var_4(arg_41_0._tf, "bg/T"), true)
	elseif arg_41_1[2] == -1 then
		setActive = var_2
		findTF = var_4

		var_2(var_4(arg_41_0._tf, "bg/B"), true)
	end

	return
end

function var_0_0.reflashAniamtion(arg_42_0)
	if arg_42_0._targetDirect then
		arg_42_0:setActionByDirect(arg_42_0._targetDirect)
	elseif arg_42_0._direct then
		arg_42_0:setActionByDirect(arg_42_0._direct)
	end

	return
end

function var_0_0.setActionByDirect(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_0:getDirectActionName(arg_43_1)
	local var_43_1

	if arg_43_0:GetBackStart() then
		var_43_1 = "hang"
	elseif var_43_0 then
		arg_43_0._idleAction = "idle_" .. var_43_0
		var_43_1 = arg_43_0._rushState and "rush_" .. var_43_0 or "run_" .. var_43_0
	end

	if var_43_1 then
		if var_43_1 and var_43_1 ~= arg_43_0._playingAction then
			arg_43_0:SetAction(var_43_1, 0)
		end
	elseif arg_43_0._isPlayer and arg_43_0._idleAction and arg_43_0._idleAction ~= arg_43_0._playingAction then
		arg_43_0:SetAction(arg_43_0._idleAction, 0)
	end

	return
end

function var_0_0.SetHangAction(arg_44_0)
	arg_44_0:SetAction("hang", 0)

	return
end

function var_0_0.getDirectActionName(arg_45_0, arg_45_1)
	local var_45_0

	if arg_45_1[1] ~= 0 then
		var_45_0 = arg_45_1[1] > 0 and "right" or "left"
	elseif arg_45_1[2] ~= 0 then
		var_45_0 = arg_45_1[2] > 0 and "up" or "down"
	end

	return var_45_0
end

function var_0_0.setActionNormal(arg_46_0)
	arg_46_0:SetAction("normal", 0)

	return
end

function var_0_0.GetEnemyFlag(arg_47_0)
	return arg_47_0._enemyFlag
end

return var_0_0
