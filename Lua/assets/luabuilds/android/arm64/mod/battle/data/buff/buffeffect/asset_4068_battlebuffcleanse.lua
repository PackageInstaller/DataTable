ys = ys or {}

local BattleBuffCleanse = class("BattleBuffCleanse", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffCleanse = BattleBuffCleanse
BattleBuffCleanse.__name = "BattleBuffCleanse"

function BattleBuffCleanse:Ctor(arg_1_1)
	BattleBuffCleanse.super.Ctor(self, arg_1_1)

	return
end

function BattleBuffCleanse:SetArgs(arg_2_1, arg_2_2)
	self._buffIDList = self._tempData.arg_list.buff_id_list
	self._check_target = self._tempData.arg_list.check_target
	self._minTargetNumber = self._tempData.arg_list.minTargetNumber or 0
	self._maxTargetNumber = self._tempData.arg_list.maxTargetNumber or 10000

	return
end

function BattleBuffCleanse:onTrigger(arg_3_1, arg_3_2, arg_3_3)
	BattleBuffCleanse.super.onTrigger(self, arg_3_1, arg_3_2, arg_3_3)

	if self._check_target then
		local var_3_0 = #self:getTargetList(arg_3_1, self._check_target, self._tempData.arg_list, arg_3_3)

		if var_3_0 >= self._minTargetNumber and var_3_0 <= self._maxTargetNumber then
			for iter_3_0, iter_3_1 in ipairs(self._buffIDList) do
				arg_3_1:RemoveBuff(iter_3_1)
			end
		end
	else
		for iter_3_2, iter_3_3 in ipairs(self._buffIDList) do
			arg_3_1:RemoveBuff(iter_3_3)
		end
	end

	return
end

return
