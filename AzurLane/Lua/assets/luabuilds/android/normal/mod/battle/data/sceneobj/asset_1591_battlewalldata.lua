ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle

class = var_0_10003
var_0_2.BattleWallData = var_0_10003("BattleWallData")
var_0.Battle.BattleWallData.__name = "BattleWallData"

local var_0_3 = var_0.Battle.BattleWallData

var_0_3.CLD_OBJ_TYPE_BULLET = 1
var_0_3.CLD_OBJ_TYPE_SHIP = 2

function var_0_3.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0._id = arg_1_1
	arg_1_0._host = arg_1_2
	arg_1_0._cldFun = arg_1_3
	arg_1_0._cldBox = arg_1_4
	arg_1_0._cldOffset = arg_1_5

	arg_1_0:InitCldComponent()

	return
end

function var_0_3.InitCldComponent(arg_2_0)
	local var_2_0 = arg_2_0._cldBox
	local var_2_1 = arg_2_0._cldOffset

	if var_2_0.range then
		arg_2_0._cldComponent = var_0.Battle.BattleColumnCldComponent.New(var_2_0.range, 5, var_2_1[1], var_2_1[3])
	else
		arg_2_0._cldComponent = var_0.Battle.BattleCubeCldComponent.New(var_2_0[1], var_2_0[2], var_2_0[3], var_2_1[1], var_2_1[3])
	end

	local var_2_2 = {
		type = var_0_1.CldType.WALL,
		UID = arg_2_0:GetUniqueID(),
		func = arg_2_0:GetCldFunc()
	}
	local var_2_3 = arg_2_0._cldComponent

	var_4.SetCldData(var_2_3, var_2_2)

	local var_2_4 = arg_2_0._cldComponent

	var_4.SetActive(var_2_4, true)
	arg_2_0:SetCldObjType()

	return
end

function var_0_3.IsActive(arg_3_0)
	local var_3_0 = arg_3_0._host

	return var_1.IsWallActive(var_3_0)
end

function var_0_3.DeactiveCldBox(arg_4_0)
	local var_4_0 = arg_4_0._cldComponent

	var_1.SetActive(var_4_0, false)

	return
end

function var_0_3.GetCldBox(arg_5_0)
	local var_5_0 = arg_5_0._cldComponent

	return var_1.GetCldBox(var_5_0, arg_5_0:GetPosition())
end

function var_0_3.GetCldData(arg_6_0)
	local var_6_0 = arg_6_0._cldComponent

	return var_1.GetCldData(var_6_0)
end

function var_0_3.GetBoxSize(arg_7_0)
	local var_7_0 = arg_7_0._cldComponent

	return var_1.GetCldBoxSize(var_7_0)
end

function var_0_3.GetHost(arg_8_0)
	return arg_8_0._host
end

function var_0_3.GetIFF(arg_9_0)
	local var_9_0 = arg_9_0:GetHost()

	return var_1.GetIFF(var_9_0)
end

function var_0_3.GetPosition(arg_10_0)
	local var_10_0 = arg_10_0:GetHost()

	return var_1.GetPosition(var_10_0)
end

function var_0_3.GetUniqueID(arg_11_0)
	return arg_11_0._id
end

function var_0_3.GetCldFunc(arg_12_0)
	return arg_12_0._cldFun
end

function var_0_3.SetCldObjType(arg_13_0, arg_13_1)
	arg_13_0._cldObjType = arg_13_1 or var_0_3.CLD_OBJ_TYPE_BULLET

	return
end

function var_0_3.GetCldObjType(arg_14_0)
	return arg_14_0._cldObjType
end

return
