ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleCardPuzzleFleetBuffEffect = var_0_10002("BattleCardPuzzleFleetBuffEffect")
var_0.Battle.BattleCardPuzzleFleetBuffEffect.__name = "BattleCardPuzzleFleetBuffEffect"

local var_0_2 = var_0.Battle.BattleUnitEvent
local var_0_3 = var_0.Battle.BattleFleetBuffEffect

var_0_3.FX_TYPE_NOR = 0
var_0_3.FX_TYPE_MOD_ATTR = 1

function var_0_3.Ctor(arg_1_0, arg_1_1)
	Clone = var_1_10002
	arg_1_0._tempData = var_1_10002(arg_1_1)
	arg_1_0._type = arg_1_0._tempData.type

	arg_1_0:SetActive()

	return
end

function var_0_3.GetEffectType(arg_2_0)
	return var_0_3.FX_TYPE_NOR
end

function var_0_3.SetArgs(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._cardPuzzleComponent = arg_3_1
	arg_3_0._fleetBuff = arg_3_2

	return
end

function var_0_3.Trigger(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0[arg_4_1](arg_4_0, arg_4_2)

	return
end

function var_0_3.onAttach(arg_5_0)
	arg_5_0:onTrigger()

	return
end

function var_0_3.onRemove(arg_6_0)
	arg_6_0:onTrigger()

	return
end

function var_0_3.onUpdate(arg_7_0, arg_7_1)
	if arg_7_0._tempData.arg_list.INR then
		local var_7_0 = arg_7_0._tempData.arg_list.INR

		if not arg_7_0._lastTimeStamp or var_7_0 < arg_7_1 - arg_7_0._lastTimeStamp then
			arg_7_0:onTrigger()

			arg_7_0._lastTimeStamp = arg_7_1
		end
	else
		arg_7_0:onTrigger()
	end

	return
end

function var_0_3.onPlus(arg_8_0)
	arg_8_0:onTrigger()

	return
end

function var_0_3.onDeduct(arg_9_0)
	arg_9_0:onTrigger()

	return
end

function var_0_3.onStartGame(arg_10_0)
	arg_10_0:onTrigger()

	return
end

function var_0_3.IsActive(arg_11_0)
	return arg_11_0._isActive
end

function var_0_3.SetActive(arg_12_0)
	arg_12_0._isActive = true

	return
end

function var_0_3.NotActive(arg_13_0)
	arg_13_0._isActive = false

	return
end

function var_0_3.Clear(arg_14_0)
	return
end

function var_0_3.Dispose(arg_15_0)
	return
end

return
