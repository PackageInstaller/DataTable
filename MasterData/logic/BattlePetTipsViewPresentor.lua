-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/BattlePetTipsViewPresentor.lua

module("logic.extensions.battle.view.BattlePetTipsViewPresentor", package.seeall)

local BattlePetTipsViewPresentor = class("BattlePetTipsViewPresentor", ViewPresentor)

function BattlePetTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.NotifyTop
end

function BattlePetTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/battle/battlepettips.prefab"
	}
end

function BattlePetTipsViewPresentor:buildViews()
	local views = {}
	local battleView = BattlePetTipsView.New()

	table.insert(views, battleView)

	return views
end

return BattlePetTipsViewPresentor
