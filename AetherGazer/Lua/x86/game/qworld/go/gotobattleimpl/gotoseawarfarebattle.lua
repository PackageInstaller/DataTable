GotoBattleBase = import("game.qworld.go.gotoBattleImpl.GotoBattleBase")

local var_0_0 = class("GotoSeaWarfareBattle", GotoBattleBase)

function var_0_0.GetStageData(arg_1_0)
	local var_1_0 = BattleStageFactory.Produce(arg_1_0:GetStageType(), arg_1_0:GetStageId())

	var_1_0:SetSeaWarfareStageID(SeaWarfareTools.GetSeaWarfareStageID(arg_1_0:GetStageId()))

	return var_1_0
end

return var_0_0
