ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConst

ys.Battle.BattleWallData = class("BattleWallData")
ys.Battle.BattleWallData.__name = "BattleWallData"

local var_0_2 = ys.Battle.BattleWallData

ys.Battle.BattleWallData.CLD_OBJ_TYPE_BULLET = 1
ys.Battle.BattleWallData.CLD_OBJ_TYPE_SHIP = 2

function ys.Battle.BattleWallData.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0._id = arg_1_1
	arg_1_0._host = arg_1_2
	arg_1_0._cldFun = arg_1_3
	arg_1_0._cldBox = arg_1_4
	arg_1_0._cldOffset = arg_1_5

	arg_1_0:InitCldComponent()

	return
end

function ys.Battle.BattleWallData.InitCldComponent(arg_2_0)
	arg_2_0._cldComponent = arg_2_0._cldBox.range and var_0_0.Battle.BattleColumnCldComponent.New(arg_2_0._cldBox.range, 5, arg_2_0._cldOffset[1], arg_2_0._cldOffset[3]) or var_0_0.Battle.BattleCubeCldComponent.New(arg_2_0._cldBox[1], arg_2_0._cldBox[2], arg_2_0._cldBox[3], arg_2_0._cldOffset[1], arg_2_0._cldOffset[3])

	arg_2_0._cldComponent:SetCldData({
		type = var_0_1.CldType.WALL,
		UID = arg_2_0:GetUniqueID(),
		func = arg_2_0:GetCldFunc()
	})
	arg_2_0._cldComponent:SetActive(true)
	arg_2_0:SetCldObjType()

	return
end

function ys.Battle.BattleWallData.IsActive(arg_3_0)
	return arg_3_0._host:IsWallActive()
end

function ys.Battle.BattleWallData.DeactiveCldBox(arg_4_0)
	arg_4_0._cldComponent:SetActive(false)

	return
end

function ys.Battle.BattleWallData.GetCldBox(arg_5_0)
	return arg_5_0._cldComponent:GetCldBox(arg_5_0:GetPosition())
end

function ys.Battle.BattleWallData.GetCldData(arg_6_0)
	return arg_6_0._cldComponent:GetCldData()
end

function ys.Battle.BattleWallData.GetBoxSize(arg_7_0)
	return arg_7_0._cldComponent:GetCldBoxSize()
end

function ys.Battle.BattleWallData.GetHost(arg_8_0)
	return arg_8_0._host
end

function ys.Battle.BattleWallData.GetIFF(arg_9_0)
	return arg_9_0:GetHost():GetIFF()
end

function ys.Battle.BattleWallData.GetPosition(arg_10_0)
	return arg_10_0:GetHost():GetPosition()
end

function ys.Battle.BattleWallData.GetUniqueID(arg_11_0)
	return arg_11_0._id
end

function ys.Battle.BattleWallData.GetCldFunc(arg_12_0)
	return arg_12_0._cldFun
end

function ys.Battle.BattleWallData.SetCldObjType(arg_13_0, arg_13_1)
	arg_13_0._cldObjType = arg_13_1 or var_0_2.CLD_OBJ_TYPE_BULLET

	return
end

function ys.Battle.BattleWallData.GetCldObjType(arg_14_0)
	return arg_14_0._cldObjType
end

return
