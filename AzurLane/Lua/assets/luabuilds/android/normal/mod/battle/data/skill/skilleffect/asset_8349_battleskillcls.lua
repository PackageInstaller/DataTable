ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleSkillCLS", var_0.Battle.BattleSkillEffect)

var_0.Battle.BattleSkillCLS = var_0_1
var_0_1.__name = "BattleSkillCLS"
var_0_1.TYPE_BULLET = 1
var_0_1.TYPE_AIRCRAFT = 2
var_0_1.TYPE_MINION = 3
var_0_1.TYPE_AOE = 4

function var_0_1.Ctor(arg_1_0, arg_1_1)
	local var_1_0 = var_0_1.super.Ctor
	local var_1_1 = arg_1_0
	local var_1_2 = arg_1_1

	lv = var_1_10005

	var_1_0(var_1_1, var_1_2, var_1_10005)

	local var_1_3

	if not arg_1_0._tempData.arg_list.typeList then
		var_1_3 = {}
	end

	arg_1_0._clsTypeList = var_1_3

	return
end

function var_0_1.DoDataEffect(arg_2_0, arg_2_1)
	arg_2_0:doCls(arg_2_1)

	return
end

function var_0_1.DoDataEffectWithoutTarget(arg_3_0, arg_3_1)
	arg_3_0:doCls(arg_3_1)

	return
end

function var_0_1.doCls(arg_4_0, arg_4_1)
	local var_4_0 = var_0.Battle.BattleDataProxy.GetInstance()
	local var_4_1 = arg_4_1
	local var_4_2 = arg_4_1.GetIFF(var_4_1) * -1

	ipairs = var_4_1

	for iter_4_0, iter_4_1 in var_4_1(arg_4_0._clsTypeList) do
		if iter_4_1 == var_0_1.TYPE_BULLET then
			var_4_0:CLSBullet(var_4_2)
		elseif iter_4_1 == var_0_1.TYPE_AIRCRAFT then
			var_4_0:CLSAircraft(var_4_2)
		elseif iter_4_1 == var_0_1.TYPE_MINION then
			var_4_0:CLSMinion()
		elseif iter_4_1 == var_0_1.TYPE_AOE then
			var_4_0:CLSAOE()
		end
	end

	return
end

return
