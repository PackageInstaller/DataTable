-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/view/ToolTipsEchoViewPresentor.lua

module("logic.extensions.tooltips.view.ToolTipsEchoViewPresentor", package.seeall)

local M = class("ToolTipsEchoViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Carryitem_echo_detail_view,
		IconLoader.getSpriteAtlasUrl(IconType.Skinlib),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem_Com)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ToolTipsEchoComp.New())

	return views
end

function M:onClickOutside()
	ViewMgr.instance:close(ViewName.ToolTipsEchoView)
end

return M
