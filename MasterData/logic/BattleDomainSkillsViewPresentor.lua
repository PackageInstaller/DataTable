-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/BattleDomainSkillsViewPresentor.lua

module("logic.extensions.battle.view.BattleDomainSkillsViewPresentor", package.seeall)

local BattleDomainSkillsViewPresentor = class("BattleDomainSkillsViewPresentor", ViewPresentor)

function BattleDomainSkillsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BattleDomainSkillsViewPresentor:dependWhatResources()
	return {
		"ui/views/battle/battledomainskillsview.prefab"
	}
end

function BattleDomainSkillsViewPresentor:buildViews()
	local views = {}
	local battleView = BattleDomainSkillsView.New()

	table.insert(views, battleView)

	return views
end

return BattleDomainSkillsViewPresentor
