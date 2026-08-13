ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle

class = var_0_10003
var_0_2.BattleSkillAddFleetBuff = var_0_10003("BattleSkillAddFleetBuff", var_0.Battle.BattleSkillEffect)
var_0.Battle.BattleSkillAddFleetBuff.__name = "BattleSkillAddFleetBuff"

local var_0_3 = var_0.Battle.BattleSkillAddFleetBuff

function var_0_3.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_3.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._fleetBuffID = arg_1_0._tempData.arg_list.fleet_buff_id

	return
end

function var_0_3.DoDataEffect(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_2:IsAlive() and arg_2_2:GetUnitType() == var_0_1.UnitType.PLAYER_UNIT then
		local var_2_0 = var_0.Battle.BattleFleetBuffUnit.New(arg_2_0._fleetBuffID)
		local var_2_1 = arg_2_2:GetFleetVO()

		var_4.AttachFleetBuff(var_2_1, var_2_0)
	end

	return
end

return
