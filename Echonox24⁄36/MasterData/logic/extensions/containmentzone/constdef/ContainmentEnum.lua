-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/constdef/ContainmentEnum.lua

module("logic.extensions.containmentzone.constdef.ContainmentEnum", package.seeall)

local ContainmentEnum = {}

ContainmentEnum.billBoardName = {
	[0] = "tip_protomer_default_touch_1",
	"tip_protomer_default_touch_2",
	"tip_protomer_default_touch_3",
	"tip_protomer_default_touch_4",
	"tip_protomer_default_touch_5",
	"tip_protomer_default_touch_6",
	"tip_protomer_default_touch_7",
	"tip_protomer_default_touch_8",
	"tip_protomer_default_touch_9",
	"tip_protomer_default_touch_10",
	"tip_protomer_default_touch_11",
	"tip_protomer_default_touch_12"
}
ContainmentEnum.billBoardIcon = {
	[0] = "1901001_01",
	"1901001_02",
	"1901001_03",
	"1901001_04",
	"1901001_05",
	"1901001_06",
	"1901001_07",
	"1901001_08",
	"1901001_09",
	"1901001_10",
	"1901001_11",
	"1901001_12"
}
ContainmentEnum.ModuleEnhanceEffId = {
	EchoEffMaxUpGrade = 3,
	PresureMaxUpGrade = 1,
	DmgManageMaxUpGrade = 2,
	ResearchLvBaseUpGrade = 4
}
ContainmentEnum.ModuleLockTyp = {
	isUpgrade = 3,
	CanUpgrade = 2,
	Lock = 1
}
ContainmentEnum.ProtomerInfoMsgTyp = {
	ManagementNotice = 4,
	ResearchLog = 6,
	SpecialPower = 5,
	Story = 7,
	RoomRequire = 2,
	BaseMsg = 1,
	AttrPreference = 3
}
ContainmentEnum.ProtomerInfoMsgTitle = {
	"tip_protomer_info_tab_title_1",
	"tip_protomer_info_tab_title_2",
	"tip_protomer_info_tab_title_3",
	"tip_protomer_info_tab_title_4",
	"tip_protomer_info_tab_title_5",
	"tip_protomer_info_tab_title_6",
	"tip_protomer_info_tab_title_7"
}
ContainmentEnum.ProtomerInfoUnlockCondition = {
	Default = 0,
	ByFinishReport = 3,
	ByPoint = 2,
	ByLevel = 1,
	ByFailReport = 4
}
ContainmentEnum.Preferen2CharacterQua = {
	2,
	1,
	5,
	3,
	4,
	6
}
ContainmentEnum.moduleTypBase = 0
ContainmentEnum.moduleTypPrimary = 1
ContainmentEnum.moduleTypAdvanced = 2
ContainmentEnum.billBoardCount = 12
ContainmentEnum.maxRoomCount = 6
ContainmentEnum.maxReportDmgLevel = 8
ContainmentEnum.heroMoodGreen = 75
ContainmentEnum.heroMoodYellow = 50
ContainmentEnum.heroMoodYellow = 25

return ContainmentEnum
