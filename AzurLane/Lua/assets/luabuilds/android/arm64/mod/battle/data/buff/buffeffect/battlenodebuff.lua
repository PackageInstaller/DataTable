ys = ys or {}

local var_0_0 = class("BattleNodeBuff", ys.Battle.BattleBuffEffect)

ys.Battle.BattleNodeBuff = var_0_0
var_0_0.__name = "BattleNodeBuff"

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_0.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._rate = arg_2_0._tempData.arg_list.rate

	return
end

function var_0_0.onFire(arg_3_0, arg_3_1, arg_3_2)
	if not ys.Battle.BattleFormulas.IsHappen(arg_3_0._rate) then
		return
	end

	local var_3_0 = arg_3_0._tempData.arg_list.weapon
	local var_3_1 = ys.Battle.BattleDataProxy.GetInstance():GetSeqCenter()

	for iter_3_0, iter_3_1 in ipairs(arg_3_1:GetAutoWeapons()) do
		if iter_3_1:GetWeaponId() == var_3_0 then
			local var_3_2 = var_3_1:NewSeq("buff" .. arg_3_0._id)

			pg.NodeMgr.GetInstance():GenNode(ys.Battle.NodeData.New(arg_3_1, {
				weapon = iter_3_1
			}, var_3_2), pg.BattleNodesCfg[arg_3_0._tempData.arg_list.node], var_3_2)

			break
		end
	end

	return
end

return
