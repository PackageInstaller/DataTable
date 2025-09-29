-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewfullscreenwarn/BattleFullScreenWarnViewPresentor.lua

module("logic.extensions.battle.viewfullscreenwarn.BattleFullScreenWarnViewPresentor", package.seeall)

local BattleFullScreenWarnViewPresentor = class("BattleFullScreenWarnViewPresentor", ViewPresentor)

BattleFullScreenWarnViewPresentor.MainUrl = BattleResourceName.UIFullScreenWarn

function BattleFullScreenWarnViewPresentor:dependWhatResources()
	return {
		BattleFullScreenWarnViewPresentor.MainUrl
	}
end

function BattleFullScreenWarnViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BattleFullScreenWarnViewPresentor:buildViews()
	local views = {}

	table.insert(views, BattleFullScreenWarnView.New())

	return views
end

return BattleFullScreenWarnViewPresentor
