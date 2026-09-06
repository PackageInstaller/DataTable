-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqigod/data/AoqiGodEnum.lua

module("logic.extensions.aoqigod.data.AoqiGodEnum", package.seeall)

local AoqiGodEnum = {}

AoqiGodEnum.SortTypes_LeftTime = 1
AoqiGodEnum.SortTypes_HelperNum = 2
AoqiGodEnum.SortTypes_ScoreNum = 3
AoqiGodEnum.SortTypes_CharmNum = 4
AoqiGodEnum.SortNames = {
	[AoqiGodEnum.SortTypes_LeftTime] = "剩余时间",
	[AoqiGodEnum.SortTypes_HelperNum] = "帮打人数",
	[AoqiGodEnum.SortTypes_ScoreNum] = "大神积分",
	[AoqiGodEnum.SortTypes_CharmNum] = "魅力值"
}
AoqiGodEnum.SortTypeList = {
	AoqiGodEnum.SortTypes_LeftTime,
	AoqiGodEnum.SortTypes_HelperNum,
	AoqiGodEnum.SortTypes_ScoreNum,
	AoqiGodEnum.SortTypes_CharmNum
}
AoqiGodEnum.SortValues = {
	[AoqiGodEnum.SortTypes_LeftTime] = {
		ArraySort.NONE,
		ArraySort.DESCENDING,
		-1
	},
	[AoqiGodEnum.SortTypes_HelperNum] = {
		ArraySort.NONE,
		ArraySort.DESCENDING,
		-1
	},
	[AoqiGodEnum.SortTypes_ScoreNum] = {
		ArraySort.NONE,
		ArraySort.DESCENDING,
		-1
	},
	[AoqiGodEnum.SortTypes_CharmNum] = {
		ArraySort.NONE,
		ArraySort.DESCENDING,
		-1
	}
}
AoqiGodEnum.ClgStates_Empty = "Empty"
AoqiGodEnum.ClgStates_NotAccepted = "NotAccepted"
AoqiGodEnum.ClgStates_Doing = "Doing"
AoqiGodEnum.ClgStates_Fail = "Fail"
AoqiGodEnum.ClgStates_Success = "Success"

return AoqiGodEnum
