local var_0_0 = class("GuildDynamicBgPathGrid")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.canWalk = arg_1_1.canWalk
	arg_1_0.position = arg_1_1.position
	arg_1_0.sizeDelta = arg_1_1.sizeDelta
	arg_1_0.startPosOffset = arg_1_1.startPosOffset
	arg_1_0.lockCnt = 0
	arg_1_0.localPosition = arg_1_0.startPosOffset + Vector3(arg_1_0.position.x * arg_1_0.sizeDelta.x, arg_1_0.position.y * arg_1_0.sizeDelta.y, 0)
	arg_1_0.centerPosition = Vector3(arg_1_0.localPosition.x + arg_1_0.sizeDelta.x / 2, arg_1_0.localPosition.y + arg_1_0.sizeDelta.y / 2)

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
	return arg_5_0.canWalk and not arg_5_0:IsLock()
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
	return {
		Vector2(arg_10_0.position.x, arg_10_0.position.y + 1),
		Vector2(arg_10_0.position.x, arg_10_0.position.y - 1),
		Vector2(arg_10_0.position.x + 1, arg_10_0.position.y),
		(Vector2(arg_10_0.position.x - 1, arg_10_0.position.y))
	}
end

return var_0_0
