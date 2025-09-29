-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueSelectRoleViewPresentor.lua

module("logic.extensions.roguelike.view.explore.RogueSelectRoleViewPresentor", package.seeall)

local M = class("RogueSelectRoleViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungroupexplore_run_group_select_charater_view,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Dice)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueSelectRoleView.New())

	return views
end

return M
