ys = ys or {}

local BattleBuffCancelBuff = class("BattleBuffCancelBuff", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffCancelBuff = BattleBuffCancelBuff
BattleBuffCancelBuff.__name = "BattleBuffCancelBuff"

function BattleBuffCancelBuff:Ctor(arg_1_1)
	BattleBuffCancelBuff.super.Ctor(self, arg_1_1)

	return
end

function BattleBuffCancelBuff:SetArgs(arg_2_1, arg_2_2)
	self._buff_id = self._tempData.arg_list.buff_id
	self._count = self._tempData.arg_list.count or 31
	self._delay = self._tempData.arg_list.delay

	return
end

function BattleBuffCancelBuff:onTrigger(arg_3_1, arg_3_2, arg_3_3)
	BattleBuffCancelBuff.super.onTrigger(self, arg_3_1, arg_3_2, attach)

	self._count = self._count - 1

	if self._count <= 0 then
		arg_3_2:SetToCancel(self._delay)
	end

	return
end

return
