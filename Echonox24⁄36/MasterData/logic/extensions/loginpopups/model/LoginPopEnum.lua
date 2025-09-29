-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/loginpopups/model/LoginPopEnum.lua

module("logic.extensions.loginpopups.model.LoginPopEnum", package.seeall)

local LoginPopEnum = {}

LoginPopEnum.PopType = {
	NormalAct = 100,
	Sign = 2,
	SeasonReset = 4,
	MonthCard = 1,
	MonthSign = 5,
	LoginOfSeven = 3,
	FirstCharge = 6
}
LoginPopEnum.PopCode = {
	[LoginPopEnum.PopType.MonthCard] = 100001,
	[LoginPopEnum.PopType.Sign] = 100002,
	[LoginPopEnum.PopType.LoginOfSeven] = 100003,
	[LoginPopEnum.PopType.SeasonReset] = 100004,
	[LoginPopEnum.PopType.NormalAct] = 200000,
	[LoginPopEnum.PopType.MonthSign] = 100005,
	[LoginPopEnum.PopType.FirstCharge] = 100006
}
LoginPopEnum.Type = {
	Day = 1,
	Normal = 0
}
LoginPopEnum.LOGIN_POP_UP_KEY = "loginPopUpsKey"

return LoginPopEnum
