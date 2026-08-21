ys = ys or {}

local var_0_0 = ys.Battle.BattleDataFunction
local var_0_1 = ys.Battle.BattleConst
local var_0_3 = ys.Battle.BattleAttr
local var_0_7 = class("BattleMinionUnit", ys.Battle.BattleEnemyUnit)

ys.Battle.BattleMinionUnit = var_0_7
var_0_7.__name = "BattleMinionUnit"

function var_0_7.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_7.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function var_0_7.GetUnitType(arg_2_0)
	return var_0_1.UnitType.MINION_UNIT
end

function var_0_7.SetMaster(arg_3_0, arg_3_1)
	arg_3_0._master = arg_3_1

	return
end

function var_0_7.InheritMasterAttr(arg_4_0)
	var_0_3.SetMinionAttr(arg_4_0)
	var_0_3.InitDOTAttr(arg_4_0._attr, arg_4_0._tmpData)
	arg_4_0:setStandardLabelTag()

	return
end

function var_0_7.SetTemplate(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._tmpID = arg_5_1
	arg_5_0._tmpData = var_0_0.GetMonsterTmpDataFromID(arg_5_0._tmpID)

	arg_5_0:configWeaponQueueParallel()
	arg_5_0:InitCldComponent()

	return
end

function var_0_7.IsShowHPBar(arg_6_0)
	return false
end

function var_0_7.GetMaster(arg_7_0)
	return arg_7_0._master
end

function var_0_7.DispatchVoice(arg_8_0)
	return
end

function var_0_7.Retreat(arg_9_0)
	var_0_7.super.Retreat(arg_9_0)
	arg_9_0:SetDeathReason(var_0_1.UnitDeathReason.LEAVE)
	arg_9_0:DeacActionClear()
	arg_9_0._battleProxy:KillUnit(arg_9_0:GetUniqueID())

	return
end

return
