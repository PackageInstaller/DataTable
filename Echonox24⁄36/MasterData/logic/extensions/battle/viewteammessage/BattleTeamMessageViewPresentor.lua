-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewteammessage/BattleTeamMessageViewPresentor.lua

module("logic.extensions.battle.viewteammessage.BattleTeamMessageViewPresentor", package.seeall)

local BattleTeamMessageViewPresentor = class("BattleTeamMessageViewPresentor", ViewPresentor)

function BattleTeamMessageViewPresentor:dependWhatResources()
	return {
		ResName.Battle_battle_team_message_tips,
		ViewlibResPath.HeroHeadItem
	}
end

function BattleTeamMessageViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BattleTeamMessageViewPresentor:buildViews()
	local views = {}

	table.insert(views, BattleTeamMessageView.New())

	return views
end

return BattleTeamMessageViewPresentor
