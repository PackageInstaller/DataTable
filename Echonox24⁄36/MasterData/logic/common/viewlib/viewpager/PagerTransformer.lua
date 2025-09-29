-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/viewpager/PagerTransformer.lua

module("logic.common.viewlib.viewpager.PagerTransformer", package.seeall)

local M = class("PagerTransformer")

function M:ctor()
	self._viewPager = false
end

function M:internal_build()
	self:onCreate()
end

function M:internal_destroy()
	self:onDestroy()

	self._viewPager = false
end

function M:setViewPager(viewPager)
	self._viewPager = viewPager
end

function M:onCreate()
	return
end

function M:onDestroy()
	return
end

function M:transfromIn(view)
	return
end

function M:transfromOut(view)
	return
end

function M:notifyTransformInFinish()
	self._viewPager:onTransformInFinish()
end

function M:notifyTransformOutFinish()
	self._viewPager:onTransformOutFinish()
end

return M
