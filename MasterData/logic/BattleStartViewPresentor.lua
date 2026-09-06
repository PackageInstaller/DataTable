-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/BattleStartViewPresentor.lua

module("logic.extensions.battle.view.BattleStartViewPresentor", package.seeall)

local BattleStartViewPresentor = class("BattleStartViewPresentor", ViewWithGuidePresentor)

function BattleStartViewPresentor:attachToWhichRoot()
	return ViewRootType.HudTop
end

function BattleStartViewPresentor:dependWhatResources()
	return {
		CommonResPath.BattleStart
	}
end

function BattleStartViewPresentor:buildViews()
	local views = {}
	local battleView = BattleStartView.New()

	table.insert(views, battleView)

	return views
end

return BattleStartViewPresentor
