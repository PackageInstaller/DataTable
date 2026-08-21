ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleBuffAirStrikeCoolDown = class("BattleBuffAirStrikeCoolDown", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffAirStrikeCoolDown.__name = "BattleBuffAirStrikeCoolDown"

local var_0_1 = ys.Battle.BattleBuffAirStrikeCoolDown

function ys.Battle.BattleBuffAirStrikeCoolDown.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffAirStrikeCoolDown.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._rant = arg_2_0._tempData.arg_list.rant or 10000

	return
end

function ys.Battle.BattleBuffAirStrikeCoolDown.onTrigger(arg_3_0, arg_3_1)
	var_0_1.super.onTrigger(arg_3_0, arg_3_1, buff, attach)

	if var_0_0.Battle.BattleFormulas.IsHappen(arg_3_0._rant) then
		local var_3_0 = arg_3_1:GetAirAssistQueue():GetQueueHead()

		if var_3_0 then
			var_3_0:QuickCoolDown()
		end
	end

	return
end

return
