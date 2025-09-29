-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/setting/SettingConst.lua

module("logic.extensions.mainui.view.setting.SettingConst", package.seeall)

local M = {}

M.kBattleAnimationQuality = "BattleAnimationQuality"
M.kAutoEnd = "AutoEnd"
M.kClickEnsure = "ClickEnsure"
M.kDoubleClickStandby = "DoubleClickStandby"
M.kAutoShowDangerous = "AutoShowDangerous"
M.kTargetPrediction = "TargetPrediction"
M.kSimpleSkillCast = "SimpleSkillCast"
M.kNoneTarget = "NoneTarget"
M.kSpeedAdjust = "SpeedAdjust"
M.kResolutionRatioQuality = "ResolutionRatioQuality"
M.kGraphicsQuality = "GraphicsQuality"
M.kEffectQuality = "EffectQuality"
M.kGameFrame = "GameFrame"
M.kGameAntialiasing = "GameAntialiasing"
M.kGameHDR = "GameHDR"
M.KBattleShake = "BattleShake"

local KLevelNum = {
	Level5 = 5,
	Level3 = 3,
	Level4 = 4,
	Level1 = 1,
	Level2 = 2
}
local KSettingLevel = {
	High = 3,
	Mid = 2,
	Low = 1
}
local KFrameNumber = {
	Frame60 = 2,
	Frame30 = 1
}

M.KFrameNumberValue = {
	[KFrameNumber.Frame30] = 30,
	[KFrameNumber.Frame60] = 60
}
M.FrameSetting = {
	[KLevelNum.Level1] = {
		ResolutionRatio = KSettingLevel.Low,
		EffectsLevel = KSettingLevel.Low,
		FrameNumber = KFrameNumber.Frame30
	},
	[KLevelNum.Level2] = {
		ResolutionRatio = KSettingLevel.Mid,
		EffectsLevel = KSettingLevel.Low,
		FrameNumber = KFrameNumber.Frame30
	},
	[KLevelNum.Level3] = {
		ResolutionRatio = KSettingLevel.Mid,
		EffectsLevel = KSettingLevel.Mid,
		FrameNumber = KFrameNumber.Frame30
	},
	[KLevelNum.Level4] = {
		ResolutionRatio = KSettingLevel.High,
		EffectsLevel = KSettingLevel.High,
		FrameNumber = KFrameNumber.Frame60
	}
}

return M
