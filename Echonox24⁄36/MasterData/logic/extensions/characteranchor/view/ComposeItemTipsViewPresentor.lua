-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characteranchor/view/ComposeItemTipsViewPresentor.lua

module("logic.extensions.characteranchor.view.ComposeItemTipsViewPresentor", package.seeall)

local M = class("ComposeItemTipsViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Tips_item_detail_tips,
		ResName.Common_path_get_item,
		IconLoader.getSpriteAtlasUrl(IconType.Skinlib)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ToolTipsMaskComp.New())
	table.insert(views, ToolTipsItemHeadComp.New())
	table.insert(views, ToolTipsHardSetPosComp.New())
	table.insert(views, ToolTipsGetWaysComp.New())
	table.insert(views, ToolTipsUseBtnComp.New())

	return views
end

return M
