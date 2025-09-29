-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/viewpager/FragmentView.lua

module("logic.common.viewlib.viewpager.FragmentView", package.seeall)

local M = class("FragmentView")

M.mainGO = false
M.params = false
M.destroy = false
M.getViewPager = false

function M:setParams(...)
	self.params = ... and {
		...
	} or false
end

return M
