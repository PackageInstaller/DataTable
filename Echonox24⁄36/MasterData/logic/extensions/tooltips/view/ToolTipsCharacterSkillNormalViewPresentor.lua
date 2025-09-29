-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/view/ToolTipsCharacterSkillNormalViewPresentor.lua

module("logic.extensions.tooltips.view.ToolTipsCharacterSkillNormalViewPresentor", package.seeall)

local M = class("ToolTipsCharacterSkillNormalViewPresentor", ToolTipsCharacterSkillDetailViewPresentor)

function M:buildViews()
	local views = {}

	self._clickView = ToolTipsPointerDownHandlerComp.New()

	table.insert(views, self._clickView)
	table.insert(views, ToolTipsCharacterSkillComp.New())
	table.insert(views, ToolTipsLimitInScreenComp.New())

	return views
end

return M
