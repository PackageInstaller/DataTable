ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleBuffDiva", var_0.Battle.BattleBuffEffect)

var_0.Battle.BattleBuffDiva = var_0_1
var_0_1.__name = "BattleBuffDiva"

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_1.onInitGame(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = var_0.Battle.BattleDataProxy.GetInstance()
	local var_2_1 = var_3.GetBGMList(var_2_0)

	math = var_1_10004

	local var_2_2 = var_2_1[var_1_10004.random(#var_2_1)]

	pg = var_2_0

	local var_2_3 = var_2_0.BgmMgr.GetInstance()
	local var_2_4 = var_5.Push

	BattleScene = var_1_10008

	var_2_4(var_2_3, var_1_10008.__cname, var_2_2)

	return
end

function var_0_1.onTrigger(arg_3_0)
	local var_3_0 = var_0.Battle.BattleDataProxy.GetInstance()
	local var_3_1 = var_1.GetBGMList(var_3_0, true)

	math = var_1_10002

	local var_3_2 = var_3_1[var_1_10002.random(#var_3_1)]

	pg = var_3_0

	local var_3_3 = var_3_0.BgmMgr.GetInstance()
	local var_3_4 = var_3.Push

	BattleScene = var_1_10006

	var_3_4(var_3_3, var_1_10006.__cname, var_3_2)

	return
end

return
