-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/tab/LeftTabListCellMO.lua

module("logic.common.viewlib.tab.LeftTabListCellMO", package.seeall)

local M = class("LeftTabListCellMO")

function M:ctor(params)
	self._tabName = params.tabName or ""
	self._tabIcon = params.tabIcon
	self._iconType = params.iconType
	self._redDotKeyList = params.redDotKeyList
	self._redDotParentKeyLsit = params.redDotParentKeyLsit
end

function M:getTabName()
	return self._tabName
end

function M:getTabIcon()
	return self._tabIcon
end

function M:getIconType()
	return self._iconType
end

function M:getRedDotKeyList()
	return self._redDotKeyList
end

function M:getRedDotParentKeyList()
	return self._redDotParentKeyLsit
end

return M
