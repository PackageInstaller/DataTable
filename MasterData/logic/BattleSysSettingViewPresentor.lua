-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/BattleSysSettingViewPresentor.lua

module("logic.extensions.battle.view.BattleSysSettingViewPresentor", package.seeall)

local BattleSysSettingViewPresentor = class("BattleSysSettingViewPresentor", ViewPresentor)

function BattleSysSettingViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BattleSysSettingViewPresentor:dependWhatResources()
	return {
		"ui/views/battle/battle_syssetting.prefab"
	}
end

function BattleSysSettingViewPresentor:buildViews()
	return {
		BattleSysSettingView.New()
	}
end

return BattleSysSettingViewPresentor
