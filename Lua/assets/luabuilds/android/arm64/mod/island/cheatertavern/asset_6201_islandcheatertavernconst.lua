local IslandCheaterTavernConst = class("IslandCheaterTavernConst")

IslandCheaterTavernConst.ChangeDressType = {
	InRoom = 1,
	OutRoom = 2
}
IslandCheaterTavernConst.SceneRoomType = {
	MatchInfoRoom = 2,
	CustomRoom = 1,
	LoadRoom = 3
}
IslandCheaterTavernConst.PlayerOperateType = {
	Shoot = 3,
	Query = 2,
	PutCard = 1
}
IslandCheaterTavernConst.PlayerCurrentOperateType = {
	ShootByOwn = 5,
	PutCardOrQuery = 2,
	Query = 3,
	PutCard = 1,
	ShootByOther = 4
}
IslandCheaterTavernConst.cardNumEveryRound = 5
IslandCheaterTavernConst.putCardMaxEverRound = 3
IslandCheaterTavernConst.deskTableId = 10110005
IslandCheaterTavernConst.deskCharIdList = {
	10110001,
	10110002,
	10110003,
	10110004
}
IslandCheaterTavernConst.seatRotatonY = {
	-90,
	0,
	90,
	180
}
IslandCheaterTavernConst.changeSeat = false
IslandCheaterTavernConst.currentMainSeat = 4
IslandCheaterTavernConst.moveToTableTime = 1
IslandCheaterTavernConst.mainCardRoation = 5
IslandCheaterTavernConst.mainCardSpace = 0
IslandCheaterTavernConst.putCardTest = false
IslandCheaterTavernConst.hudHeight = 1.78
IslandCheaterTavernConst.quesAnimionTotalFrame = 100
IslandCheaterTavernConst.quesAnimionshowEffectFrame = 15
IslandCheaterTavernConst.quesAnimionUnshowEffectFrame = 60
IslandCheaterTavernConst.cardOffsetToCamara = 0.8
IslandCheaterTavernConst.cardWidth = 0.115
IslandCheaterTavernConst.cardSpace = -0.02
IslandCheaterTavernConst.cardRoationOffset = 5
IslandCheaterTavernConst.horOffset = 1.4
IslandCheaterTavernConst.verOffset = 1.1
IslandCheaterTavernConst.turnCircleCount = 3
IslandCheaterTavernConst.firstTurnTime = 3
IslandCheaterTavernConst.afterTurnTime = 3
IslandCheaterTavernConst.qusanimationTime = 2
IslandCheaterTavernConst.turnCardTime = 3
IslandCheaterTavernConst.SettlementType = {
	ByFinal = 2,
	ByScore = 1
}
IslandCheaterTavernConst.winAnimationTime = 3.33
IslandCheaterTavernConst.putCountMax = 3
IslandCheaterTavernConst.FlipCardTime = 0.5
IslandCheaterTavernConst.cardCeilOffset = 0.1

return IslandCheaterTavernConst
