class = var_0_10000

local var_0_0 = var_0_10000("GuildDynamicBgPathGrid")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.canWalk = arg_1_1.canWalk
	arg_1_0.position = arg_1_1.position
	arg_1_0.sizeDelta = arg_1_1.sizeDelta
	arg_1_0.startPosOffset = arg_1_1.startPosOffset
	arg_1_0.lockCnt = 0

	local var_1_0 = arg_1_0.startPosOffset

	Vector3 = var_1_10003
	arg_1_0.localPosition = var_1_0 + var_1_10003(arg_1_0.position.x * arg_1_0.sizeDelta.x, arg_1_0.position.y * arg_1_0.sizeDelta.y, 0)
	Vector3 = var_2
	arg_1_0.centerPosition = var_2(arg_1_0.localPosition.x + arg_1_0.sizeDelta.x / 2, arg_1_0.localPosition.y + arg_1_0.sizeDelta.y / 2)

	return
end

function var_0_0.GetPosition(arg_2_0)
	return arg_2_0.position
end

function var_0_0.GetLocalPosition(arg_3_0)
	return arg_3_0.localPosition
end

function var_0_0.GetCenterPosition(arg_4_0)
	return arg_4_0.centerPosition
end

function var_0_0.CanWalk(arg_5_0)
	local var_5_0

	if arg_5_0.canWalk then
		var_5_0 = not arg_5_0:IsLock()
	end

	return var_5_0
end

function var_0_0.Lock(arg_6_0)
	arg_6_0.lockCnt = arg_6_0.lockCnt + 1

	return
end

function var_0_0.Unlock(arg_7_0)
	if arg_7_0.lockCnt > 0 then
		arg_7_0.lockCnt = arg_7_0.lockCnt - 1
	end

	return
end

function var_0_0.UnlockAll(arg_8_0)
	arg_8_0.lockCnt = 0

	return
end

function var_0_0.IsLock(arg_9_0)
	return arg_9_0.lockCnt > 0
end

function var_0_0.GetAroundGrids(arg_10_0)
	local var_10_0 = arg_10_0.position

	Vector2 = var_1_10002

	local var_10_1 = var_1_10002(var_10_0.x, var_10_0.y + 1)

	Vector2 = var_3

	local var_10_2 = var_3(var_10_0.x, var_10_0.y - 1)

	Vector2 = var_4

	local var_10_3 = var_4(var_10_0.x + 1, var_10_0.y)

	Vector2 = var_5

	local var_10_4 = var_5(var_10_0.x - 1, var_10_0.y)

	return {
		var_10_1,
		var_10_2,
		var_10_3,
		var_10_4
	}
end

return var_0_0
