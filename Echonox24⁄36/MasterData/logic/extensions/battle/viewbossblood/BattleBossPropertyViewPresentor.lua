-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewbossblood/BattleBossPropertyViewPresentor.lua

module("logic.extensions.battle.viewbossblood.BattleBossPropertyViewPresentor", package.seeall)

local BattleBossPropertyViewPresentor = class("BattleBossPropertyViewPresentor", ViewPresentor)

BattleBossPropertyViewPresentor.MainUrl = BattleResourceName.UIBossBloodBar

function BattleBossPropertyViewPresentor:dependWhatResources()
	return {
		BattleBossPropertyViewPresentor.MainUrl
	}
end

function BattleBossPropertyViewPresentor:attachToWhichRoot()
	return ViewRootType.Hud
end

function BattleBossPropertyViewPresentor:buildViews()
	local views = {}

	table.insert(views, BattleBossPropertyView.New())

	return views
end

return BattleBossPropertyViewPresentor
