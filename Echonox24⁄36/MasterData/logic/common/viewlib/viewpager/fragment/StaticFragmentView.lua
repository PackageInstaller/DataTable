-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/viewpager/fragment/StaticFragmentView.lua

module("logic.common.viewlib.viewpager.fragment.StaticFragmentView", package.seeall)

local M = class("StaticFragmentView", FragmentView)

function M:buildUI()
	return
end

function M:destroyUI()
	return
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:ctor(mainGO)
	self.mainGO = mainGO
	self._registry = false
	self._viewPager = false
end

function M:destroy()
	self:unbindEvents()
	self:destroyUI()

	self._registry = false
	self._viewPager = false
	self.mainGO = false
end

function M:internal_buildUI(registry)
	self._registry = registry

	self:buildUI()
	self:bindEvents()
end

function M:setViewPager(viewPager)
	self._viewPager = viewPager
end

return M
