ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleLockTag = var_0_10002("BattleLockTag")
var_0.Battle.BattleLockTag.__name = "BattleLockTag"

local var_0_2 = var_0.Battle.BattleLockTag

function var_0_2.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._markGO = arg_1_1
	arg_1_0._markTF = arg_1_1.transform

	local var_1_0 = arg_1_0._markTF

	arg_1_0._controller = var_3.GetComponent(var_1_0, "LockTag")
	arg_1_0._flag = true

	return
end

function var_0_2.Mark(arg_2_0, arg_2_1)
	pg = var_1_10002

	local var_2_0 = var_1_10002.TimeMgr.GetInstance()

	arg_2_0._markTime = var_2.GetCombatTime(var_2_0)
	arg_2_0._requiredTime = arg_2_1
	SetActive = var_2

	var_2(arg_2_0._markGO, true)

	arg_2_0._controller.enabled = true

	return
end

function var_0_2.Update(arg_3_0, arg_3_1)
	if (arg_3_1 - arg_3_0._markTime) / arg_3_0._requiredTime >= 1 and arg_3_0._flag then
		local var_3_0 = arg_3_0._controller

		var_4.SetRate(var_3_0, 1)

		arg_3_0._controller.enabled = false

		local var_3_1 = arg_3_0._markTF
		local var_3_2 = var_4.GetComponent

		typeof = var_7
		Animator = var_1_10009
		var_3_2(var_3_1, var_7(var_1_10009)).enabled = true
		arg_3_0._flag = false
	elseif arg_3_0._flag then
		local var_3_3 = arg_3_0._controller

		var_4.SetRate(var_3_3, var_3)
	end

	return
end

function var_0_2.SetPosition(arg_4_0, arg_4_1)
	arg_4_0._markTF.position = arg_4_1

	return
end

function var_0_2.SetTagCount(arg_5_0, arg_5_1)
	arg_5_0._controller.count = arg_5_1

	return
end

function var_0_2.Dispose(arg_6_0)
	Object = var_1_10001

	var_1_10001.Destroy(arg_6_0._markGO)

	return
end

return
