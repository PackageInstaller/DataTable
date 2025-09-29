-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/constdef/SeasonEnum.lua

module("logic.extensions.season.constdef.SeasonEnum", package.seeall)

RewardStatus = {
	VipActive = 3,
	AllActive = 2,
	Finished = 4,
	None = 1
}
VipStatus = {
	Vip2 = 2,
	Vip1 = 1,
	None = 0
}
TaskType = {
	dayOnce = 100039,
	Fixed = 100033,
	Unlimited = 100031,
	Weekly = 100032
}
QualityToItemBg = {
	[GameEnum.QualityEnum.S] = "fcpy_cheng",
	[GameEnum.QualityEnum.A] = "fcpy_zi",
	[GameEnum.QualityEnum.B] = "fcpy_lan",
	[GameEnum.QualityEnum.C] = "fcpy_lv",
	[GameEnum.QualityEnum.D] = "fcpy_hui"
}
ClockAnim = {
	Loop = "secret_clock_loop",
	Close = "secret_clock_end",
	Idle = "secret_clock_idle",
	Open = "secret_clock_start"
}
ClockAction = {
	Exchange = 3,
	Mount = 1,
	ExchangeWithSelf = 4,
	Unmount = 2
}
