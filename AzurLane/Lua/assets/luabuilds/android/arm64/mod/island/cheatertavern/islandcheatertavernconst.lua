local var_0_0 = class("IslandCheaterTavernConst")

var_0_0.ChangeDressType = {
	InRoom = 1,
	OutRoom = 2
}
var_0_0.SceneRoomType = {
	MatchInfoRoom = 2,
	CustomRoom = 1,
	LoadRoom = 3
}
var_0_0.PlayerOperateType = {
	Shoot = 3,
	Query = 2,
	PutCard = 1
}
var_0_0.PlayerCurrentOperateType = {
	ShootByOwn = 5,
	PutCardOrQuery = 2,
	Query = 3,
	PutCard = 1,
	ShootByOther = 4
}
var_0_0.cardNumEveryRound = 5
var_0_0.putCardMaxEverRound = 3
var_0_0.deskTableId = 10110005
var_0_0.deskCharIdList = {
	10110001,
	10110002,
	10110003,
	10110004
}
var_0_0.seatRotatonY = {
	-90,
	0,
	90,
	180
}
var_0_0.changeSeat = false
var_0_0.currentMainSeat = 4
var_0_0.moveToTableTime = 1
var_0_0.mainCardRoation = 5
var_0_0.mainCardSpace = 0
var_0_0.putCardTest = false
var_0_0.hudHeight = 1.78
var_0_0.quesAnimionTotalFrame = 100
var_0_0.quesAnimionshowEffectFrame = 15
var_0_0.quesAnimionUnshowEffectFrame = 60
var_0_0.cardOffsetToCamara = 0.8
var_0_0.cardWidth = 0.115
var_0_0.cardSpace = -0.02
var_0_0.cardRoationOffset = 5
var_0_0.horOffset = 1.4
var_0_0.verOffset = 1.1
var_0_0.turnCircleCount = 3
var_0_0.firstTurnTime = 3
var_0_0.afterTurnTime = 3
var_0_0.qusanimationTime = 2
var_0_0.turnCardTime = 3
var_0_0.SettlementType = {
	ByFinal = 2,
	ByScore = 1
}
var_0_0.winAnimationTime = 3.33
var_0_0.putCountMax = 3
var_0_0.FlipCardTime = 0.5
var_0_0.cardCeilOffset = 0.1

return var_0_0
