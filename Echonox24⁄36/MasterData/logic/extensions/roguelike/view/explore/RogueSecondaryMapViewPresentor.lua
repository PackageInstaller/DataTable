-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueSecondaryMapViewPresentor.lua

module("logic.extensions.roguelike.view.explore.RogueSecondaryMapViewPresentor", package.seeall)

local M = class("RogueSecondaryMapViewPresentor", ViewPresentor)
local Urls = {}

table.insert(Urls, ResName.Rungroupexplore_run_group_main_view)
table.insert(Urls, IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Dice))

function M:dependWhatResources()
	return Urls
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueMapRoomView.New())

	return views
end

return M
