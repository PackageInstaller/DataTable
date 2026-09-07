ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleBuffManualTorpedoCoolDown = class("BattleBuffManualTorpedoCoolDown", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffManualTorpedoCoolDown.__name = "BattleBuffManualTorpedoCoolDown"

local var_0_1 = ys.Battle.BattleBuffManualTorpedoCoolDown

function ys.Battle.BattleBuffManualTorpedoCoolDown.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffManualTorpedoCoolDown:SetArgs(arg_2_1, arg_2_2)
	self._rant = self._tempData.arg_list.rant or 10000

	return
end

function ys.Battle.BattleBuffManualTorpedoCoolDown:onTrigger(arg_3_1)
	var_0_1.super.onTrigger(self, arg_3_1, buff, attach)

	if var_0_0.Battle.BattleFormulas.IsHappen(self._rant) then
		local var_3_0 = arg_3_1:GetTorpedoQueue():GetQueueHead()

		if var_3_0 then
			var_3_0:QuickCoolDown()
		end
	end

	return
end

return
