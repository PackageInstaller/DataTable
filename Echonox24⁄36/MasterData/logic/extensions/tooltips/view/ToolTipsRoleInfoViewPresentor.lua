-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/view/ToolTipsRoleInfoViewPresentor.lua

module("logic.extensions.tooltips.view.ToolTipsRoleInfoViewPresentor", package.seeall)

local M = class("ToolTipsRoleInfoViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Tips_role_info_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ToolTipsMaskComp.New())
	table.insert(views, ToolTipsHardSetPosComp.New())
	table.insert(views, ToolTipsRoleInfoComp.New())

	return views
end

function M:onClickOutside()
	ViewMgr.instance:close(ViewName.ToolTipsRoleInfoViewPresentor)
end

return M
