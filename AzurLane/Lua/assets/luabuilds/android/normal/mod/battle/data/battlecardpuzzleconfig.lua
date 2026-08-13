ys = var_0_10000

local var_0_0 = var_0_10000.Battle

ys = var_0_10001

local var_0_1

if not var_0_10001.Battle.BattleCardPuzzleConfig then
	var_0_1 = {}
end

var_0_0.BattleCardPuzzleConfig = var_0_1
ys = var_0_0

local var_0_2 = var_0_0.Battle.BattleCardPuzzleConfig

var_0_2.baseEnergyGenerateSpeedPerSecond = 1
var_0_2.baseEnergyInitial = 5
var_0_2.BASE_MAX_HAND = 6
var_0_2.moveCardGenerateSpeedPerSecond = 0.5
var_0_2.BASE_MAX_MOVE = 30
var_0_2.BASE_MOVE_ID = 20001
var_0_2.CustomAttrInitList = {
	CardComboMin = 0,
	CardComboMax = 50
}
var_0_2.FleetAttrClamp = {
	CardCombo = {
		min = "CardComboMin",
		max = "CardComboMax"
	}
}
var_0_2.FleetIconRegisterAttr = {
	CardCombo = 202,
	CardAntiaircraft = 202
}
var_0_2.FleetIconRegisterBuff = {
	[530050] = 202
}

return
