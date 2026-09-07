ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleCommand = class("BattleCommand", ys.MVC.Command)
ys.Battle.BattleCommand.__name = "BattleCommand"

function ys.Battle.BattleCommand.Ctor(arg_1_0)
	var_0_0.Battle.BattleCommand.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleCommand:Initialize()
	var_0_0.Battle.BattleCommand.super.Initialize(self)

	self._dataProxy = self._state:GetProxyByName(var_0_0.Battle.BattleDataProxy.__name)

	self:InitProtocol()
	self:InitBattleEvent()

	return
end

function ys.Battle.BattleCommand:StartBattle()
	self._state:Active()

	return
end

function ys.Battle.BattleCommand.InitProtocol(arg_4_0)
	return
end

function ys.Battle.BattleCommand.InitBattleEvent(arg_5_0)
	return
end

return
