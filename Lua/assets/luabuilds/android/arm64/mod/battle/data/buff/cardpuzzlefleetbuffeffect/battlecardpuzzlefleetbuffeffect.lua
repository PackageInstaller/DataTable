ys = ys or {}
ys.Battle.BattleCardPuzzleFleetBuffEffect = class("BattleCardPuzzleFleetBuffEffect")
ys.Battle.BattleCardPuzzleFleetBuffEffect.__name = "BattleCardPuzzleFleetBuffEffect"

local var_0_1 = ys.Battle.BattleFleetBuffEffect

ys.Battle.BattleFleetBuffEffect.FX_TYPE_NOR = 0
ys.Battle.BattleFleetBuffEffect.FX_TYPE_MOD_ATTR = 1

function ys.Battle.BattleFleetBuffEffect.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tempData = Clone(arg_1_1)
	arg_1_0._type = arg_1_0._tempData.type

	arg_1_0:SetActive()

	return
end

function ys.Battle.BattleFleetBuffEffect.GetEffectType(arg_2_0)
	return var_0_1.FX_TYPE_NOR
end

function ys.Battle.BattleFleetBuffEffect.SetArgs(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._cardPuzzleComponent = arg_3_1
	arg_3_0._fleetBuff = arg_3_2

	return
end

function ys.Battle.BattleFleetBuffEffect.Trigger(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0[arg_4_1](arg_4_0, arg_4_2)

	return
end

function ys.Battle.BattleFleetBuffEffect.onAttach(arg_5_0)
	arg_5_0:onTrigger()

	return
end

function ys.Battle.BattleFleetBuffEffect.onRemove(arg_6_0)
	arg_6_0:onTrigger()

	return
end

function ys.Battle.BattleFleetBuffEffect.onUpdate(arg_7_0, arg_7_1)
	if arg_7_0._tempData.arg_list.INR then
		if not arg_7_0._lastTimeStamp or arg_7_0._tempData.arg_list.INR < arg_7_1 - arg_7_0._lastTimeStamp then
			arg_7_0:onTrigger()

			arg_7_0._lastTimeStamp = arg_7_1
		end
	else
		arg_7_0:onTrigger()
	end

	return
end

function ys.Battle.BattleFleetBuffEffect.onPlus(arg_8_0)
	arg_8_0:onTrigger()

	return
end

function ys.Battle.BattleFleetBuffEffect.onDeduct(arg_9_0)
	arg_9_0:onTrigger()

	return
end

function ys.Battle.BattleFleetBuffEffect.onStartGame(arg_10_0)
	arg_10_0:onTrigger()

	return
end

function ys.Battle.BattleFleetBuffEffect.IsActive(arg_11_0)
	return arg_11_0._isActive
end

function ys.Battle.BattleFleetBuffEffect.SetActive(arg_12_0)
	arg_12_0._isActive = true

	return
end

function ys.Battle.BattleFleetBuffEffect.NotActive(arg_13_0)
	arg_13_0._isActive = false

	return
end

function ys.Battle.BattleFleetBuffEffect.Clear(arg_14_0)
	return
end

function ys.Battle.BattleFleetBuffEffect.Dispose(arg_15_0)
	return
end

return
