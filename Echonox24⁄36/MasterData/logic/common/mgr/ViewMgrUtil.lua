-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/mgr/ViewMgrUtil.lua

module("logic.common.mgr.ViewMgrUtil", package.seeall)

local ViewMgrUtil = {}

function ViewMgrUtil.hideAllView()
	local backStack = ViewMgr.instance._viewMgrImpl._backStack
	local backSize = backStack:getSize()

	while backSize > 0 do
		local itemInfo = backStack:getDataByIndex(backSize)

		if itemInfo and ViewMgr.instance:isOpen(itemInfo.viewName) then
			ViewMgr.instance:close(itemInfo.viewName, false, WindowType.WindowCloseReasonType.QuickCloseType, true)
		end

		backSize = backSize - 1
	end
end

return ViewMgrUtil
