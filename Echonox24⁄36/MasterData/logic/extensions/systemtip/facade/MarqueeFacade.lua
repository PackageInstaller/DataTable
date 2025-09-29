-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/systemtip/facade/MarqueeFacade.lua

module("logic.extensions.systemtip.facade.MarqueeFacade", package.seeall)

local M = class("MarqueeFacade", BaseFacade)

function M:ctor()
	self._marqueeView = false
end

function M:init()
	ViewMgr.instance:openSpecialView(ViewName.MarqueeView)
end

function M:registered(view)
	self._marqueeView = view
end

function M:unregistered()
	self._marqueeView = false
end

function M:showMarquee(data)
	if self._marqueeView then
		self._marqueeView:showMarquee(data)
	end
end

function M:getPlayState()
	if self._marqueeView then
		return self._marqueeView:getPlayState()
	end
end

function M:hideMarquee()
	if self._marqueeView then
		self._marqueeView:hideMarquee()
	end
end

M.instance = M.New()

return M
