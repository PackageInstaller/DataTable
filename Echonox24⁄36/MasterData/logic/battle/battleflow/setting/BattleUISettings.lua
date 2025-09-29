-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/setting/BattleUISettings.lua

module("logic.battle.battleflow.setting.BattleUISettings", package.seeall)

local BattleUISettings = {}
local kWhiteSettingCO = BattleUISettingCO.New()

kWhiteSettingCO.sceneUIBloodColor = "#FFFFFF"
kWhiteSettingCO.sceneUIBloodHeadColor = "#FFFFFF"
kWhiteSettingCO.uiBloodColor = "#FFFFFF"
kWhiteSettingCO.uiBloodBgColor = "#878787"
kWhiteSettingCO.nameBgColor = "#60656E"
kWhiteSettingCO.nameColor = "#ADADAD"
kWhiteSettingCO.relationType = BattleEnum.CampRelation.SAME

local kRedSettingCO = BattleUISettingCO.New()

kRedSettingCO.sceneUIBloodColor = "#fd0c11"
kRedSettingCO.sceneUIBloodHeadColor = "#bf4141"
kRedSettingCO.uiBloodColor = "#fd0c10"
kRedSettingCO.uiBloodBgColor = "#8F3834"
kRedSettingCO.nameBgColor = "#763534"
kRedSettingCO.nameColor = "#C9323B"
kRedSettingCO.relationType = BattleEnum.CampRelation.ENEMY

local kBlueSettingCO = BattleUISettingCO.New()

kBlueSettingCO.sceneUIBloodColor = "#82D8C3"
kBlueSettingCO.sceneUIBloodHeadColor = "#A5A5A5"
kBlueSettingCO.uiBloodColor = "#4481CD"
kBlueSettingCO.uiBloodBgColor = "#D4FA27"
kBlueSettingCO.nameBgColor = "#345976"
kBlueSettingCO.nameColor = "#52B7EB"
kBlueSettingCO.relationType = BattleEnum.CampRelation.NORMAL

local kGreenSettingCO = BattleUISettingCO.New()

kGreenSettingCO.sceneUIBloodColor = "#37b788"
kGreenSettingCO.sceneUIBloodHeadColor = "#4dbf95"
kGreenSettingCO.uiBloodColor = "#6BE35B"
kGreenSettingCO.uiBloodBgColor = "#25603D"
kGreenSettingCO.nameBgColor = "#25603D"
kGreenSettingCO.nameColor = "#6BE35B"
kGreenSettingCO.relationType = BattleEnum.CampRelation.FRIEND
BattleUISettings.WhiteSetting = kWhiteSettingCO
BattleUISettings.RedSetting = kRedSettingCO
BattleUISettings.BlueSetting = kBlueSettingCO
BattleUISettings.GreenSetting = kGreenSettingCO

local kCampId2SettingCO = {}

function BattleUISettings.clearAllSettings()
	BattleTableUtil.clearTable(kCampId2SettingCO)
end

function BattleUISettings.setCampSettingCO(campId, settingCO)
	kCampId2SettingCO[campId] = settingCO
end

function BattleUISettings.getCampSettingCO(campId)
	local settingCO = kCampId2SettingCO[campId]

	if not settingCO then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("BattleUISettings::cannot find setting config for campId[%s]", campId))
		end

		return BattleUISettings.BlueSetting
	end

	return settingCO
end

return BattleUISettings
