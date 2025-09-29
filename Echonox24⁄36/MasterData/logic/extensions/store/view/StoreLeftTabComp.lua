-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/StoreLeftTabComp.lua

module("logic.extensions.store.view.StoreLeftTabComp", package.seeall)

local M = class("StoreLeftTabComp", LeftTabComp)

function M:_buildTab(tabGo)
	local tabInfo = M.super._buildTab(self, tabGo)

	goutil.setActive(tabInfo.redPointWeakly.gameObject, true)
	goutil.setActive(tabInfo.redPointSubRootNum, false)
	goutil.setActive(tabInfo.redPointSubRootStrong, false)
	goutil.setActive(tabInfo.redPointRoot, false)

	return tabInfo
end

return M
