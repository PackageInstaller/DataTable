ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleCommand = var_0_10002("BattleCommand", var_0.MVC.Command)
var_0.Battle.BattleCommand.__name = "BattleCommand"

function var_0.Battle.BattleCommand.Ctor(arg_1_0)
	var_0.Battle.BattleCommand.super.Ctor(arg_1_0)

	return
end

function var_0.Battle.BattleCommand.Initialize(arg_2_0)
	var_0.Battle.BattleCommand.super.Initialize(arg_2_0)

	local var_2_0 = arg_2_0._state

	arg_2_0._dataProxy = var_1.GetProxyByName(var_2_0, var_0.Battle.BattleDataProxy.__name)

	arg_2_0:InitProtocol()
	arg_2_0:InitBattleEvent()

	return
end

function var_0.Battle.BattleCommand.StartBattle(arg_3_0)
	local var_3_0 = arg_3_0._state

	var_1.Active(var_3_0)

	return
end

function var_0.Battle.BattleCommand.InitProtocol(arg_4_0)
	return
end

function var_0.Battle.BattleCommand.InitBattleEvent(arg_5_0)
	return
end

return
