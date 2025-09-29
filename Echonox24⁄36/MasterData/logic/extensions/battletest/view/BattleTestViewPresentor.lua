-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battletest/view/BattleTestViewPresentor.lua

module("logic.extensions.battletest.view.BattleTestViewPresentor", package.seeall)

local BattleTestViewPresentor = class("BattleTestViewPresentor", ViewPresentor)

function BattleTestViewPresentor:dependWhatResources()
	return {
		ResName.Battletest_battletest
	}
end

function BattleTestViewPresentor:attachToWhichRoot()
	return ViewRootType.Top
end

function BattleTestViewPresentor:buildViews()
	local views = {}

	table.insert(views, BattleTestView.New())

	return views
end

return BattleTestViewPresentor
