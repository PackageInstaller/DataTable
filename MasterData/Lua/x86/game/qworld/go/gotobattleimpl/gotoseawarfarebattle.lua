GotoBattleBase = import("game.qworld.go.gotoBattleImpl.GotoBattleBase")

local GotoSeaWarfareBattle = class("GotoSeaWarfareBattle", GotoBattleBase)

function GotoSeaWarfareBattle:GetStageData()
	local var_1_0 = BattleStageFactory.Produce(self:GetStageType(), self:GetStageId())

	var_1_0:SetSeaWarfareStageID(SeaWarfareTools.GetSeaWarfareStageID(self:GetStageId()))

	return var_1_0
end

return GotoSeaWarfareBattle
