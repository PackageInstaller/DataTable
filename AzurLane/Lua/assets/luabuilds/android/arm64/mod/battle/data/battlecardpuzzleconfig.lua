ys.Battle.BattleCardPuzzleConfig = ys.Battle.BattleCardPuzzleConfig or {}
ys.Battle.BattleCardPuzzleConfig.baseEnergyGenerateSpeedPerSecond = 1
ys.Battle.BattleCardPuzzleConfig.baseEnergyInitial = 5
ys.Battle.BattleCardPuzzleConfig.BASE_MAX_HAND = 6
ys.Battle.BattleCardPuzzleConfig.moveCardGenerateSpeedPerSecond = 0.5
ys.Battle.BattleCardPuzzleConfig.BASE_MAX_MOVE = 30
ys.Battle.BattleCardPuzzleConfig.BASE_MOVE_ID = 20001
ys.Battle.BattleCardPuzzleConfig.CustomAttrInitList = {
	CardComboMin = 0,
	CardComboMax = 50
}
ys.Battle.BattleCardPuzzleConfig.FleetAttrClamp = {
	CardCombo = {
		min = "CardComboMin",
		max = "CardComboMax"
	}
}
ys.Battle.BattleCardPuzzleConfig.FleetIconRegisterAttr = {
	CardCombo = 202,
	CardAntiaircraft = 202
}
ys.Battle.BattleCardPuzzleConfig.FleetIconRegisterBuff = {
	[530050] = 202
}

return
