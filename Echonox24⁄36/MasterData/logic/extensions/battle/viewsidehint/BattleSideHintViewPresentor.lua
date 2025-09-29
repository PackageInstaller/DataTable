-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewsidehint/BattleSideHintViewPresentor.lua

module("logic.extensions.battle.viewsidehint.BattleSideHintViewPresentor", package.seeall)

local BattleSideHintViewPresentor = class("BattleSideHintViewPresentor", ViewPresentor)

function BattleSideHintViewPresentor:dependWhatResources()
	return {
		ResName.Battle_battle_side_hint_tips
	}
end

function BattleSideHintViewPresentor:attachToWhichRoot()
	return ViewRootType.NotifyTop
end

function BattleSideHintViewPresentor:buildViews()
	local views = {}

	table.insert(views, BattleSideHintView.New())

	return views
end

return BattleSideHintViewPresentor
