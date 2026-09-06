-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/BattleViewSelectUnitPresentor.lua

module("logic.extensions.battle.view.BattleViewSelectUnitPresentor", package.seeall)

local BattleViewSelectUnitPresentor = class("BattleViewSelectUnitPresentor", ViewPresentor)

function BattleViewSelectUnitPresentor:attachToWhichRoot()
	return ViewRootType.HudTop
end

function BattleViewSelectUnitPresentor:dependWhatResources()
	return {
		"ui/views/battle/battleselectunit.prefab"
	}
end

function BattleViewSelectUnitPresentor:buildViews()
	local views = {}
	local battleView = BattleViewSelectUnit.New()

	table.insert(views, battleView)

	return views
end

return BattleViewSelectUnitPresentor
