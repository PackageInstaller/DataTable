-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewvs/BattleVsViewPresentor.lua

module("logic.extensions.battle.viewvs.BattleVsViewPresentor", package.seeall)

local BattleVsViewPresentor = class("BattleVsViewPresentor", ViewPresentor)

BattleVsViewPresentor.MainUrl = BattleResourceName.UIVs

function BattleVsViewPresentor:dependWhatResources()
	return {
		BattleVsViewPresentor.MainUrl
	}
end

function BattleVsViewPresentor:attachToWhichRoot()
	return ViewRootType.Hud
end

function BattleVsViewPresentor:buildViews()
	local views = {}

	table.insert(views, BattleVsView.New())

	return views
end

return BattleVsViewPresentor
