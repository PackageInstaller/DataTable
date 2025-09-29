-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/hacktool/RogueHackToolSelectRoleViewPresentor.lua

module("logic.extensions.roguelike.view.explore.hacktool.RogueHackToolSelectRoleViewPresentor", package.seeall)

local M = class("RogueHackToolSelectRoleViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungroupother_run_group_select_charater_view,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Dice)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueHackToolSelectRoleView.New())

	return views
end

return M
