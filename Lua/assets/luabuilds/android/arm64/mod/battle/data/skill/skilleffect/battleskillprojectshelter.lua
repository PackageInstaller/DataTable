ys = ys or {}

local var_0_0 = ys.Battle.BattleEvent
local var_0_1 = ys.Battle.BattleConfig
local var_0_2 = class("BattleSkillProjectShelter", ys.Battle.BattleSkillEffect)

ys.Battle.BattleSkillProjectShelter = var_0_2
var_0_2.__name = "BattleSkillProjectShelter"

function var_0_2.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_2.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._duration = arg_1_0._tempData.arg_list.duration
	arg_1_0._offset = arg_1_0._tempData.arg_list.offset
	arg_1_0._fxID = arg_1_0._tempData.arg_list.effect
	arg_1_0._box = arg_1_0._tempData.arg_list.box
	arg_1_0._count = arg_1_0._tempData.arg_list.count

	return
end

function var_0_2.DoDataEffect(arg_2_0, arg_2_1)
	local var_2_0 = var_0.Battle.BattleDataProxy.GetInstance()
	local var_2_1 = var_2_0:SpawnShelter(arg_2_0._box, arg_2_0._duration)
	local var_2_2 = arg_2_1:GetIFF()

	if var_2_2 == var_0_1.FOE_CODE then
		arg_2_0._offset[1] = arg_2_0._offset[1] * -1
	end

	local var_2_3 = arg_2_1:GetPosition() + BuildVector3(arg_2_0._offset)

	var_2_1:SetIFF(var_2_2)
	var_2_1:SetArgs(arg_2_0._count, arg_2_0._duration, arg_2_0._box, var_2_3, arg_2_0._fxID)
	var_2_1:SetStartTimeStamp(pg.TimeMgr.GetInstance():GetCombatTime())
	var_2_0:DispatchEvent(var_0.Event.New(var_0_0.ADD_SHELTER, {
		shelter = var_2_1
	}))

	return
end

function var_0_2.DataEffectWithoutTarget(arg_3_0, arg_3_1)
	arg_3_0:DoDataEffect(arg_3_1)

	return
end

return
