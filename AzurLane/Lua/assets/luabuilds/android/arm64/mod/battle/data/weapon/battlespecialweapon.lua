ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleSpecialWeapon", var_0.Battle.BattleWeaponUnit)

var_0.Battle.BattleSpecialWeapon = var_0_1
var_0_1.__name = "BattleSpecialWeapon"

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	return
end

function var_0_1.CheckPreCast(arg_2_0)
	local var_2_0 = arg_2_0._dataProxy
	local var_2_1 = var_1.GetSeqCenter(var_2_0)

	if not arg_2_0._tmpData.bullet_ID[1] then
		arg_2_0._castInfo = {
			weapon = arg_2_0
		}

		return true
	end

	local var_2_2 = var_2_1
	local var_2_3 = var_2_1.NewSeq(var_2_2, "precast")
	local var_2_4 = var_0.Battle.NodeData.New(arg_2_0._host, {
		weapon = arg_2_0
	}, var_2_3)

	pg = var_2_2

	local var_2_5 = var_2_2.NodeMgr.GetInstance()
	local var_2_6 = var_5.GenNode
	local var_2_7 = var_2_4

	pg = var_1_10009

	var_2_6(var_2_5, var_2_7, var_1_10009.BattleNodesCfg[var_2], var_2_3)

	if var_2_4:GetData().targets[1] == nil then
		return false
	end

	arg_2_0._castInfo = var_5

	return true
end

function var_0_1.Fire(arg_3_0)
	assert = var_1_10001

	var_1_10001(arg_3_0._castInfo ~= nil, "需要指定施法信息，有特殊需求可默认指定为{ weapon = self }")

	local var_3_0 = arg_3_0._dataProxy
	local var_3_1 = var_1.GetSeqCenter(var_3_0)
	local var_3_2 = arg_3_0._tmpData.bullet_ID[1]
	local var_3_3 = arg_3_0._castInfo
	local var_3_4 = var_3_1
	local var_3_5 = var_3_1.NewSeq(var_3_4, "cast")
	local var_3_6 = var_0.Battle.NodeData.New(arg_3_0._host, var_3_3, var_3_5)

	pg = var_3_4

	local var_3_7 = var_3_4.NodeMgr.GetInstance()
	local var_3_8 = var_6.GenNode
	local var_3_9 = var_3_6

	pg = var_1_10010

	var_3_8(var_3_7, var_3_9, var_1_10010.BattleNodesCfg[arg_3_0._tmpData.barrage_ID[1]], var_3_5)

	local var_3_10 = arg_3_0._host

	var_6.SetCurNodeList(var_3_10, var_3_6:GetAllSeq())

	arg_3_0._currentState = arg_3_0.STATE_ATTACK
	arg_3_0._castInfo = nil

	arg_3_0:CheckAndShake()
	var_3_5:Add(var_0.Battle.CallbackNode.New(function()
		local var_4_0 = arg_3_0

		var_0.EnterCoolDown(var_4_0)

		return
	end))

	return true
end

return
