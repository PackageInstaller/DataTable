ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConfig
local var_0_2 = ys.Battle.BattleFleetCardPuzzleCardManageComponent

ys.Battle.BattleCardPuzzleWave = class("BattleCardPuzzleWave", ys.Battle.BattleWaveInfo)
ys.Battle.BattleCardPuzzleWave.__name = "BattleCardPuzzleWave"

local var_0_3 = ys.Battle.BattleCardPuzzleWave

function ys.Battle.BattleCardPuzzleWave.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleCardPuzzleWave:SetWaveData(arg_2_1)
	var_0_3.super.SetWaveData(self, arg_2_1)

	self._cardID = self._param.card_id
	self._moveTo = self._param.move_to
	self._moveOP = self._param.move_op or var_0_2.FUNC_NAME_ADD
	self._op = self._param.shuffle or 1

	return
end

function ys.Battle.BattleCardPuzzleWave:DoWave()
	var_0_3.super.DoWave(self)

	local var_3_0 = var_0_0.Battle.BattleDataProxy.GetInstance():GetFleetByIFF(var_0_1.FRIENDLY_CODE)
	local var_3_1 = var_3_0:GetCardPuzzleComponent()
	local var_3_2 = var_3_1:GetCardPileByIndex(self._moveTo)

	var_3_0[self._moveOP](var_3_2, (var_3_1:GenerateCard(self._cardID)))

	if self._op == 1 then
		var_3_2:Shuffle()
	end

	self:doPass()

	return
end

return
