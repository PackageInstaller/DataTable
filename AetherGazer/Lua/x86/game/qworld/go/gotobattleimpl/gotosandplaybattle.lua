GotoBattleBase = import("game.qworld.go.gotoBattleImpl.GotoBattleBase")

local var_0_0 = class("GotoSandPlayBattle", GotoBattleBase)

function var_0_0.GetStageData(arg_1_0)
	return (BattleStageFactory.Produce(arg_1_0:GetStageType(), arg_1_0:GetStageId()))
end

return var_0_0
