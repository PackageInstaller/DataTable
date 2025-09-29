-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/view/ToolTipsCenterViewPresentor.lua

module("logic.extensions.tooltips.view.ToolTipsCenterViewPresentor", package.seeall)

local M = class("ToolTipsCenterViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Tips_item_detail_tips,
		ResName.Common_path_get_item,
		IconLoader.getSpriteAtlasUrl(IconType.Skinlib),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ToolTipsMaskComp.New())
	table.insert(views, ToolTipsItemHeadComp.New())
	table.insert(views, ToolTipsGetWaysComp.New())
	table.insert(views, ToolTipsCenterViewComp.New())

	return views
end

return M
