ys = ys or {}

local var_0_0 = class("BattleSkillCLS", ys.Battle.BattleSkillEffect)

ys.Battle.BattleSkillCLS = var_0_0
var_0_0.__name = "BattleSkillCLS"
var_0_0.TYPE_BULLET = 1
var_0_0.TYPE_AIRCRAFT = 2
var_0_0.TYPE_MINION = 3
var_0_0.TYPE_AOE = 4

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, lv)

	arg_1_0._clsTypeList = arg_1_0._tempData.arg_list.typeList or {}

	return
end

function var_0_0.DoDataEffect(arg_2_0, arg_2_1)
	arg_2_0:doCls(arg_2_1)

	return
end

function var_0_0.DoDataEffectWithoutTarget(arg_3_0, arg_3_1)
	arg_3_0:doCls(arg_3_1)

	return
end

function var_0_0.doCls(arg_4_0, arg_4_1)
	local var_4_0 = var_0.Battle.BattleDataProxy.GetInstance()
	local var_4_1 = arg_4_1:GetIFF() * -1

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._clsTypeList) do
		if iter_4_1 == var_0_0.TYPE_BULLET then
			var_4_0:CLSBullet(var_4_1)
		elseif iter_4_1 == var_0_0.TYPE_AIRCRAFT then
			var_4_0:CLSAircraft(var_4_1)
		elseif iter_4_1 == var_0_0.TYPE_MINION then
			var_4_0:CLSMinion()
		elseif iter_4_1 == var_0_0.TYPE_AOE then
			var_4_0:CLSAOE()
		end
	end

	return
end

return
