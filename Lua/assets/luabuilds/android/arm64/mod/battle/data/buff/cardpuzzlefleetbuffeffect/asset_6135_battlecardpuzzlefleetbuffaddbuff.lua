ys = ys or {}

local var_0_0 = ys
local BattleCardPuzzleFleetBuffAddBuff = class("BattleCardPuzzleFleetBuffAddBuff", ys.Battle.BattleFleetBuffEffect)

ys.Battle.BattleCardPuzzleFleetBuffAddBuff = BattleCardPuzzleFleetBuffAddBuff
BattleCardPuzzleFleetBuffAddBuff.__name = "BattleCardPuzzleFleetBuffAddBuff"

function BattleCardPuzzleFleetBuffAddBuff:Ctor(arg_1_1)
	self._tempData = Clone(arg_1_1)

	self:SetActive()

	return
end

function BattleCardPuzzleFleetBuffAddBuff:SetArgs(arg_2_1, arg_2_2)
	BattleCardPuzzleFleetBuffAddBuff.super.SetArgs(self, arg_2_1, arg_2_2)

	self._buffID = self._tempData.arg_list.buff_id
	self._targetFilter = self._tempData.arg_list.target
	self._targetParam = self._tempData.arg_list.target_param

	local var_2_0 = self._tempData.arg_list.caster or TeamType.TeamPos.LEADER

	self._caster = var_0_0.Battle.BattleTargetChoise.TargetFleetIndex(nil, {
		fleetPos = var_2_0
	})[1]

	return
end

function BattleCardPuzzleFleetBuffAddBuff:onTrigger()
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(self._targetFilter) do
		var_3_0 = var_0_0.Battle.BattleTargetChoise[iter_3_1](self._caster, self._targetParam, var_3_0)
	end

	for iter_3_2, iter_3_3 in ipairs(var_3_0) do
		iter_3_3:AddBuff((var_0_0.Battle.BattleBuffUnit.New(self._buffID)))
	end

	return
end

return
