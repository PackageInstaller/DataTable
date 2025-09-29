-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewsetting/BattleSettingViewPresentor.lua

module("logic.extensions.battle.viewsetting.BattleSettingViewPresentor", package.seeall)

local BattleSettingViewPresentor = class("BattleSettingViewPresentor", ViewPresentor)

function BattleSettingViewPresentor:dependWhatResources()
	return {
		ResName.Battle_battle_setting_tips
	}
end

function BattleSettingViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BattleSettingViewPresentor:buildViews()
	local views = {}

	table.insert(views, BlurBgView.New("common_blur_rt"))
	table.insert(views, BattleSettingView.New())

	return views
end

return BattleSettingViewPresentor
