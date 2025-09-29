-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/view/ToolTipsFurnitureDetailViewPresentor.lua

module("logic.extensions.tooltips.view.ToolTipsFurnitureDetailViewPresentor", package.seeall)

local M = class("ToolTipsFurnitureDetailViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Tips_furniture_detail_tips,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Room)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ToolTipsMaskComp.New())
	table.insert(views, ToolTipsFurnitureDetailView.New())

	return views
end

return M
