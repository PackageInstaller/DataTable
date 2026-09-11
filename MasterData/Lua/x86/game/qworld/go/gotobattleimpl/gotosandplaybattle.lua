GotoBattleBase = import("game.qworld.go.gotoBattleImpl.GotoBattleBase")

local GotoSandPlayBattle = class("GotoSandPlayBattle", GotoBattleBase)

function GotoSandPlayBattle:GetStageData()
	return (BattleStageFactory.Produce(self:GetStageType(), self:GetStageId()))
end

return GotoSandPlayBattle
