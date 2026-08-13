ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleDataFunction
local var_0_2 = var_0.Battle.BattleConst
local var_0_3 = var_0.Battle.BattleFormulas
local var_0_4 = var_0.Battle.BattleAttr
local var_0_5 = var_0.Battle.BattleConfig
local var_0_6 = var_0.Battle.BattleUnitEvent
local var_0_7 = var_0.Battle.UnitState

class = var_0_10008

local var_0_8 = var_0_10008("BattleMinionUnit", var_0.Battle.BattleEnemyUnit)

var_0.Battle.BattleMinionUnit = var_0_8
var_0_8.__name = "BattleMinionUnit"

function var_0_8.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_8.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function var_0_8.GetUnitType(arg_2_0)
	return var_0_2.UnitType.MINION_UNIT
end

function var_0_8.SetMaster(arg_3_0, arg_3_1)
	arg_3_0._master = arg_3_1

	return
end

function var_0_8.InheritMasterAttr(arg_4_0)
	var_0_4.SetMinionAttr(arg_4_0)
	var_0_4.InitDOTAttr(arg_4_0._attr, arg_4_0._tmpData)
	arg_4_0:setStandardLabelTag()

	return
end

function var_0_8.SetTemplate(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._tmpID = arg_5_1
	arg_5_0._tmpData = var_0_1.GetMonsterTmpDataFromID(arg_5_0._tmpID)

	arg_5_0:configWeaponQueueParallel()
	arg_5_0:InitCldComponent()

	return
end

function var_0_8.IsShowHPBar(arg_6_0)
	return false
end

function var_0_8.GetMaster(arg_7_0)
	return arg_7_0._master
end

function var_0_8.DispatchVoice(arg_8_0)
	return
end

function var_0_8.Retreat(arg_9_0)
	var_0_8.super.Retreat(arg_9_0)
	arg_9_0:SetDeathReason(var_0_2.UnitDeathReason.LEAVE)
	arg_9_0:DeacActionClear()

	local var_9_0 = arg_9_0._battleProxy

	var_1.KillUnit(var_9_0, arg_9_0:GetUniqueID())

	return
end

return
