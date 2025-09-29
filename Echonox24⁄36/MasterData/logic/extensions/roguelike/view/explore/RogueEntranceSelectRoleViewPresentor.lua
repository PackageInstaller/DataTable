-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueEntranceSelectRoleViewPresentor.lua

module("logic.extensions.roguelike.view.explore.RogueEntranceSelectRoleViewPresentor", package.seeall)

local M = class("RogueEntranceSelectRoleViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungroupother_run_group_select_charater_view,
		ResName.Rungroupother_rungroup_btn_go,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Dice)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueEntranceSelectRoleView.New())
	table.insert(views, TitleView.New():blockOrgBtn(true, true, false))

	return views
end

return M
