ys = ys or {}

local BattleNodeBuff = class("BattleNodeBuff", ys.Battle.BattleBuffEffect)

ys.Battle.BattleNodeBuff = BattleNodeBuff
BattleNodeBuff.__name = "BattleNodeBuff"

function BattleNodeBuff:Ctor(arg_1_1)
	BattleNodeBuff.super.Ctor(self, arg_1_1)

	return
end

function BattleNodeBuff:SetArgs(arg_2_1, arg_2_2)
	self._rate = self._tempData.arg_list.rate

	return
end

function BattleNodeBuff:onFire(arg_3_1, arg_3_2)
	if not ys.Battle.BattleFormulas.IsHappen(self._rate) then
		return
	end

	local var_3_0 = self._tempData.arg_list.weapon
	local var_3_1 = ys.Battle.BattleDataProxy.GetInstance():GetSeqCenter()

	for iter_3_0, iter_3_1 in ipairs(arg_3_1:GetAutoWeapons()) do
		if iter_3_1:GetWeaponId() == var_3_0 then
			local var_3_2 = var_3_1:NewSeq("buff" .. self._id)

			pg.NodeMgr.GetInstance():GenNode(ys.Battle.NodeData.New(arg_3_1, {
				weapon = iter_3_1
			}, var_3_2), pg.BattleNodesCfg[self._tempData.arg_list.node], var_3_2)

			break
		end
	end

	return
end

return
