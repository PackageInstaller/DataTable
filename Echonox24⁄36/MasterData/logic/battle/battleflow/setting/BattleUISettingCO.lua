-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/setting/BattleUISettingCO.lua

module("logic.battle.battleflow.setting.BattleUISettingCO", package.seeall)

local BattleUISettingCO = class("BattleUISettingCO")

BattleUISettingCO.sceneUIBloodColor = "#FFFFFF"
BattleUISettingCO.sceneUIBloodHeadColor = "#FFFFFF"
BattleUISettingCO.uiBloodColor = "#FFFFFF"
BattleUISettingCO.uiBloodBgColor = "#FFFFFF"
BattleUISettingCO.nameBgColor = "FFFFFF"
BattleUISettingCO.nameColor = "#FFFFFF"
BattleUISettingCO.propertyUIUrl = BattleResourceName.UIUnitPropertyTop
BattleUISettingCO.propertyBottomUIUrl = BattleResourceName.UIUnitPropertyBottom
BattleUISettingCO.bossPropertyUIUrl = BattleResourceName.UIBossProperty
BattleUISettingCO.bossPropertyBottomUIUrl = BattleResourceName.UIBossPropertyBottom

function BattleUISettingCO:ctor()
	return
end

return BattleUISettingCO
