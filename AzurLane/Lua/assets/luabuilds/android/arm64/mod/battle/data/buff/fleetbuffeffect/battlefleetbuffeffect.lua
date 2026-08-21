ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleFleetBuffEffect = class("BattleFleetBuffEffect")
ys.Battle.BattleFleetBuffEffect.__name = "BattleFleetBuffEffect"

function ys.Battle.BattleFleetBuffEffect.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tempData = Clone(arg_1_1)
	arg_1_0._type = arg_1_0._tempData.type

	arg_1_0:SetActive()

	return
end

function ys.Battle.BattleFleetBuffEffect.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._fleetVO = arg_2_1
	arg_2_0._fleetBuff = arg_2_2

	return
end

function ys.Battle.BattleFleetBuffEffect.Trigger(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0[arg_3_1](arg_3_0, arg_3_2, arg_3_3, arg_3_4)

	return
end

function ys.Battle.BattleFleetBuffEffect.onAttach(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:onTrigger(arg_4_1, arg_4_2)

	return
end

function ys.Battle.BattleFleetBuffEffect.onRemove(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0:onTrigger(arg_5_1, arg_5_2)

	return
end

function ys.Battle.BattleFleetBuffEffect.onUpdate(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:onTrigger(arg_6_1, arg_6_2)

	return
end

function ys.Battle.BattleFleetBuffEffect.onStack(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0:onTrigger(arg_7_1, arg_7_2)

	return
end

function ys.Battle.BattleFleetBuffEffect.getTargetList(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0
	local var_8_1 = arg_8_1:GetUnitList()[1]

	for iter_8_0, iter_8_1 in ipairs(arg_8_2) do
		var_8_0 = var_0_0.Battle.BattleTargetChoise[iter_8_1](var_8_1, arg_8_3, var_8_0)
	end

	return var_8_0
end

function ys.Battle.BattleFleetBuffEffect.IsActive(arg_9_0)
	return arg_9_0._isActive
end

function ys.Battle.BattleFleetBuffEffect.SetActive(arg_10_0)
	arg_10_0._isActive = true

	return
end

function ys.Battle.BattleFleetBuffEffect.NotActive(arg_11_0)
	arg_11_0._isActive = false

	return
end

function ys.Battle.BattleFleetBuffEffect.Clear(arg_12_0)
	return
end

function ys.Battle.BattleFleetBuffEffect.Dispose(arg_13_0)
	return
end

return
