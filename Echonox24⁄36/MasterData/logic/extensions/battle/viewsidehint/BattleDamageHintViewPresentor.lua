-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewsidehint/BattleDamageHintViewPresentor.lua

module("logic.extensions.battle.viewsidehint.BattleDamageHintViewPresentor", package.seeall)

local BattleDamageHintViewPresentor = class("BattleDamageHintViewPresentor", ViewPresentor)

function BattleDamageHintViewPresentor:dependWhatResources()
	return {
		ResName.Battle_damage_hint
	}
end

function BattleDamageHintViewPresentor:attachToWhichRoot()
	return ViewRootType.NotifyTop
end

function BattleDamageHintViewPresentor:buildViews()
	local views = {}

	table.insert(views, BattleDamageHintView.New())

	return views
end

return BattleDamageHintViewPresentor
