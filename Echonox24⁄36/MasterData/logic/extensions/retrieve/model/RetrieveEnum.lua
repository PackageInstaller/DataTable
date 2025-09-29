-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/model/RetrieveEnum.lua

module("logic.extensions.retrieve.model.RetrieveEnum", package.seeall)

local RetrieveEnum = {}

RetrieveEnum.SceneNameMap = {
	Show = "sx-map410_chouka_selection_b@h",
	Result = "sx-map410_chouka_selection_c@h",
	Main = "sx-map410_chouka_selection_a@h"
}
RetrieveEnum.RandomPick = -1
RetrieveEnum.LotteryType = {
	OptionalCard = 2,
	OptionalEcho = 4,
	CommonCard = 1,
	CommonEcho = 3
}
RetrieveEnum.LotterySimpleType = {
	Card = 1,
	Echo = 2
}
RetrieveEnum.LotteryNum = {
	Ten = 10,
	One = 1
}
RetrieveEnum.ShowLotteryCamera = {
	YuanJing = 1,
	JinJing = 2
}
RetrieveEnum.ShowRoleType = {
	Lottery = 1,
	Other = 2
}
RetrieveEnum.AudioPackage = {
	Random = 2,
	Normal = 1
}
RetrieveEnum.ScenePickerKey = "RetrieveScenePickerKey"
RetrieveEnum.RTCameraTrack = "RTCameraTrack"
RetrieveEnum.EventStopped = "Stopped"
RetrieveEnum.LotteryEnterShowUI = "LotteryEnterShowUI"

return RetrieveEnum
