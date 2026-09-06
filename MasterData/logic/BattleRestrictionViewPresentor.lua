-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/BattleRestrictionViewPresentor.lua

module("logic.extensions.battle.view.BattleRestrictionViewPresentor", package.seeall)

local BattleRestrictionViewPresentor = class("BattleRestrictionViewPresentor", GuideViewPresentor)

function BattleRestrictionViewPresentor:attachToWhichRoot()
	return ViewRootType.HudTop
end

function BattleRestrictionViewPresentor:dependWhatResources()
	return {
		"ui/views/guide/battlerestriction.prefab"
	}
end

function BattleRestrictionViewPresentor:buildViews()
	local views = {}
	local battleView = BattleRestrictionView.New()

	table.insert(views, battleView)

	return views
end

return BattleRestrictionViewPresentor
