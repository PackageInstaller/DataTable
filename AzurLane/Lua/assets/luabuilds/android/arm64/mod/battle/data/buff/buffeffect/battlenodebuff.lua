ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
class = ys

local var_0_1 = "BattleNodeBuff"

ys = var_0_10003

local var_0_2 = var_0(var_0_1, var_0_10003.Battle.BattleBuffEffect)

ys = var_0_10001
var_0_10001.Battle.BattleNodeBuff = var_0_2
var_0_2.__name = "BattleNodeBuff"

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._rate = arg_2_0._tempData.arg_list.rate

	return
end

function var_0_2.onFire(arg_3_0, arg_3_1, arg_3_2)
	ys = var_1_10003

	if not var_1_10003.Battle.BattleFormulas.IsHappen(arg_3_0._rate) then
		return
	end

	local var_3_0 = arg_3_0._tempData.arg_list.node
	local var_3_1 = var_3.weapon

	ys = var_1_10006

	local var_3_2 = var_1_10006.Battle.BattleDataProxy.GetInstance()
	local var_3_3 = var_6.GetSeqCenter(var_3_2)

	ipairs = var_1_10007

	for iter_3_0, iter_3_1 in var_1_10007(arg_3_1:GetAutoWeapons()) do
		if iter_3_1:GetWeaponId() == var_3_1 then
			local var_3_4 = var_3_3
			local var_3_5 = var_3_3.NewSeq(var_3_4, "buff" .. arg_3_0._id)

			ys = var_1_10013
			var_1_10013 = var_1_10013.Battle.NodeData.New(arg_3_1, {
				weapon = iter_3_1
			}, var_3_5)
			pg = var_3_4

			local var_3_6 = var_3_4.NodeMgr.GetInstance()
			local var_3_7 = var_14.GenNode
			local var_3_8 = var_1_10013

			pg = var_1_10018

			var_3_7(var_3_6, var_3_8, var_1_10018.BattleNodesCfg[var_3_0], var_3_5)

			break
		end
	end

	return
end

return
