-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/view/ToolTipsD6ViewPresentor.lua

module("logic.extensions.tooltips.view.ToolTipsD6ViewPresentor", package.seeall)

local M = class("ToolTipsD6ViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Tips_d6_detail_tips,
		IconLoader.getSpriteAtlasUrl(IconType.Skinlib),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Backpack)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ToolTipsMaskComp.New())
	table.insert(views, ToolTipsD6Comp.New())
	table.insert(views, ToolTipsLimitInScreenComp.New())

	return views
end

function M:onClickOutside()
	ViewMgr.instance:close(ViewName.ToolTipsD6View)
end

return M
