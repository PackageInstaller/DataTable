-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/signin/util/WelfareSigninEnum.lua

module("logic.extensions.signin.util.WelfareSigninEnum", package.seeall)

local WelfareSigninEnum = {}

WelfareSigninEnum.ActTyp = {
	DailySignIn = 0,
	NotDefine = 999,
	SevenDaySignIn = 1
}
WelfareSigninEnum.QualityName = {
	"pz_lv",
	"pz_lv",
	"pz_lan",
	"pz_zi",
	"pz_huang"
}
WelfareSigninEnum.SevenSignInRewardType = {
	Important = 2,
	Normal = 1
}
WelfareSigninEnum.DailySignActId = 0

return WelfareSigninEnum
