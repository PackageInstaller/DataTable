-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/judgesystem/RogueEventSelectRoleViewPresentor.lua

module("logic.extensions.roguelike.view.judgesystem.RogueEventSelectRoleViewPresentor", package.seeall)

local M = class("RogueEventSelectRoleViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungroupjudgement_select_character_challenge_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueEventSelectRoleView.New())

	return views
end

return M
