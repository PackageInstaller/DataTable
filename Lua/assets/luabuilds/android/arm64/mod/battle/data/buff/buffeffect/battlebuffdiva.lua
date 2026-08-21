ys = ys or {}

local var_0_0 = class("BattleBuffDiva", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffDiva = var_0_0
var_0_0.__name = "BattleBuffDiva"

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_0.onInitGame(arg_2_0, arg_2_1, arg_2_2)
	local var_2_9000
	local var_2_0 = var_0.Battle.BattleDataProxy.GetInstance()
	local var_2_1 = var_2_0.GetBGMList(var_2_9000)

	pg.BgmMgr.GetInstance().Push(var_2_0, BattleScene.__cname, var_2_1[math.random(#var_2_1)])

	return
end

function var_0_0.onTrigger(arg_3_0)
	local var_3_9000
	local var_3_0 = var_0.Battle.BattleDataProxy.GetInstance()
	local var_3_1 = var_3_0.GetBGMList(var_3_9000, true)

	pg.BgmMgr.GetInstance().Push(var_3_0, BattleScene.__cname, var_3_1[math.random(#var_3_1)])

	return
end

return
