-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/handbook/RogueHandBookMonsterViewPresentor.lua

module("logic.extensions.roguelike.view.explore.handbook.RogueHandBookMonsterViewPresentor", package.seeall)

local M = class("RogueHandBookMonsterViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungrouphandbook_run_group_moster_tips,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Dice)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueHandBookMonsterView.New())

	return views
end

return M
