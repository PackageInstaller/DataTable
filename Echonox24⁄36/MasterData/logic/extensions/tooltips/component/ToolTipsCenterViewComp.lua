-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/component/ToolTipsCenterViewComp.lua

module("logic.extensions.tooltips.component.ToolTipsCenterViewComp", package.seeall)

local M = class("ToolTipsCenterViewComp", ViewComponent)

function M:buildUI()
	local maskGo = self:getGo("4&empty_mask_tips_29887572")
	local passEvent = maskGo:GetComponent(ComponentType.PassEvent)

	passEvent.isPassEvent = false
end

function M:onEnter()
	return
end

function M:onEnterFinished()
	local info = self:getFirstParam()

	ViewMgr.instance:open(ViewName.ToolTipsCurrencyView, info)
	GlobalDispatcher:dispatchEvent(EventType.TIPS_CHANGE_ENABLE_EVENT, true, self._viewPresentor:getViewName())
end

function M:onExit()
	ViewMgr.instance:close(ViewName.ToolTipsCurrencyView)
end

return M
