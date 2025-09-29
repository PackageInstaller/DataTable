-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/constdef/HouseMainEnum.lua

module("logic.extensions.housemain.constdef.HouseMainEnum", package.seeall)

local HouseMainEnum = {}

HouseMainEnum.StoreyName = {
	"tip_house_storey_name_1",
	"tip_house_storey_name_2",
	"tip_house_storey_name_3",
	"tip_house_storey_name_4"
}
HouseMainEnum.StoreyPointPos = {
	-30,
	-54,
	-73,
	-88
}
HouseMainEnum.RingAnglePerUnitFactor = {
	1.25,
	0.9,
	0.8,
	0.8
}
HouseMainEnum.RoomOpenTyp = {
	OpenUnActive = 4,
	OpenLock = 2,
	UnOpen = 1,
	OpenActive = 3
}
HouseMainEnum.RoomOpenTypStr = {
	[HouseMainEnum.RoomOpenTyp.UnOpen] = "未开放",
	[HouseMainEnum.RoomOpenTyp.OpenLock] = "未解锁,未激活",
	[HouseMainEnum.RoomOpenTyp.OpenActive] = "已解锁，已激活",
	[HouseMainEnum.RoomOpenTyp.OpenUnActive] = "已解锁，未激活"
}
HouseMainEnum.State = {
	FailReportReplay = 3,
	ExploreMode = 6,
	FocusRoom = 2,
	EditFurniture = 4,
	ViewMode = 5,
	Normal = 1
}
HouseMainEnum.BackLogTyp = {
	tradePriceChange = 3,
	spLivingRoomRemain = 5,
	tradeGoodsFull = 2,
	tradeOrderFull = 1,
	failReportNum = 4
}
HouseMainEnum.HarvestTyp = {
	Supervisor = 2,
	HoldReport = 1,
	Manufacturing = 3
}
HouseMainEnum.SignMark = {
	TradeOrderFull = 4,
	TradePriceChange = 2,
	SpLivingRoom = 5,
	TradeStorageFull = 1,
	HoldReportFail = 3
}
HouseMainEnum.SignMarkObjName = {
	[HouseMainEnum.SignMark.HoldReportFail] = "sign1",
	[HouseMainEnum.SignMark.TradeOrderFull] = "sign2",
	[HouseMainEnum.SignMark.TradeStorageFull] = "sign3",
	[HouseMainEnum.SignMark.TradePriceChange] = "sign4",
	[HouseMainEnum.SignMark.SpLivingRoom] = "sign5"
}
HouseMainEnum.AtmosphereShowOrder = {
	HouseExtension_pb.Atmosphere.ECOLOGY,
	HouseExtension_pb.Atmosphere.SCIENCE,
	HouseExtension_pb.Atmosphere.AMUSEMENT,
	HouseExtension_pb.Atmosphere.HOUSE_INSPIRATION,
	HouseExtension_pb.Atmosphere.LIVE
}
HouseMainEnum.AtmosphereName = {
	[HouseExtension_pb.Atmosphere.ECOLOGY] = "tip_house_atmosphere_name_1",
	[HouseExtension_pb.Atmosphere.SCIENCE] = "tip_house_atmosphere_name_2",
	[HouseExtension_pb.Atmosphere.AMUSEMENT] = "tip_house_atmosphere_name_3",
	[HouseExtension_pb.Atmosphere.HOUSE_INSPIRATION] = "tip_house_atmosphere_name_4",
	[HouseExtension_pb.Atmosphere.LIVE] = "tip_house_atmosphere_name_5"
}
HouseMainEnum.RoomTypName = {
	[HouseEnum.RoomType.Supervisor] = "tip_house_roomtype_name_1",
	[HouseEnum.RoomType.Trading] = "tip_house_roomtype_name_2",
	[HouseEnum.RoomType.Manufacturing] = "tip_house_roomtype_name_3",
	[HouseEnum.RoomType.Shelter] = "tip_house_roomtype_name_4",
	[HouseEnum.RoomType.Living] = "tip_house_roomtype_name_5"
}
HouseMainEnum.TaskTyp = {
	BuildAchievement = 2,
	Daily = 1
}
HouseMainEnum.TaskState = {
	Finish = 3,
	Running = 1,
	CanReceived = 2
}
HouseMainEnum.HeroThoughtEduState = {
	RefuseWork = 3,
	CanWork = 1,
	CanEdu = 2
}
HouseMainEnum.ServerScheduleTime = 60
HouseMainEnum.RoomActiveMoneyShowType = {
	[1101] = CommEnum.MoneyShowType.HouseRoomActiveShowType1,
	[1102] = CommEnum.MoneyShowType.HouseRoomActiveShowType1,
	[1103] = CommEnum.MoneyShowType.HouseRoomActiveShowType1,
	[1104] = CommEnum.MoneyShowType.HouseRoomActiveShowType2,
	[1105] = CommEnum.MoneyShowType.HouseRoomActiveShowType2,
	[1106] = CommEnum.MoneyShowType.HouseRoomActiveShowType3,
	[1201] = CommEnum.MoneyShowType.HouseRoomActiveShowType1,
	[1202] = CommEnum.MoneyShowType.HouseRoomActiveShowType1,
	[1204] = CommEnum.MoneyShowType.HouseRoomActiveShowType1,
	[1205] = CommEnum.MoneyShowType.HouseRoomActiveShowType1,
	[1206] = CommEnum.MoneyShowType.HouseRoomActiveShowType1,
	[1208] = CommEnum.MoneyShowType.HouseRoomActiveShowType1,
	[1209] = CommEnum.MoneyShowType.HouseRoomActiveShowType1,
	[1210] = CommEnum.MoneyShowType.HouseRoomActiveShowType1,
	[1212] = CommEnum.MoneyShowType.HouseRoomActiveShowType1,
	[1301] = CommEnum.MoneyShowType.HouseRoomActiveShowType1,
	[1302] = CommEnum.MoneyShowType.HouseRoomActiveShowType1,
	[1303] = CommEnum.MoneyShowType.HouseRoomActiveShowType2,
	[1304] = CommEnum.MoneyShowType.HouseRoomActiveShowType2,
	[1305] = CommEnum.MoneyShowType.HouseRoomActiveShowType2,
	[1306] = CommEnum.MoneyShowType.HouseRoomActiveShowType2,
	[1307] = CommEnum.MoneyShowType.HouseRoomActiveShowType2,
	[1308] = CommEnum.MoneyShowType.HouseRoomActiveShowType2,
	[1309] = CommEnum.MoneyShowType.HouseRoomActiveShowType3,
	[1310] = CommEnum.MoneyShowType.HouseRoomActiveShowType3,
	[1311] = CommEnum.MoneyShowType.HouseRoomActiveShowType3,
	[1312] = CommEnum.MoneyShowType.HouseRoomActiveShowType3,
	[1313] = CommEnum.MoneyShowType.HouseRoomActiveShowType3,
	[1314] = CommEnum.MoneyShowType.HouseRoomActiveShowType3,
	[1315] = CommEnum.MoneyShowType.HouseRoomActiveShowType3,
	[1316] = CommEnum.MoneyShowType.HouseRoomActiveShowType3,
	[1317] = CommEnum.MoneyShowType.HouseRoomActiveShowType3,
	[1318] = CommEnum.MoneyShowType.HouseRoomActiveShowType3,
	[1401] = CommEnum.MoneyShowType.HouseRoomActiveShowType1,
	[1402] = CommEnum.MoneyShowType.HouseRoomActiveShowType1,
	[1403] = CommEnum.MoneyShowType.HouseRoomActiveShowType1,
	[1404] = CommEnum.MoneyShowType.HouseRoomActiveShowType2,
	[1405] = CommEnum.MoneyShowType.HouseRoomActiveShowType2,
	[1406] = CommEnum.MoneyShowType.HouseRoomActiveShowType3,
	[1407] = CommEnum.MoneyShowType.HouseRoomActiveShowType3,
	[1408] = CommEnum.MoneyShowType.HouseRoomActiveShowType3
}

return HouseMainEnum
