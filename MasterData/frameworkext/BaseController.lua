-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/lmvc/controller/BaseController.lua

module("frameworkext.lmvc.config.BaseController", package.seeall)

local BaseController = class("BaseController")

function BaseController:ctor()
	return
end

function BaseController:setExtDispatcher(extDispatcher)
	self._localDispatcher = extDispatcher
end

function BaseController:onInit()
	return
end

function BaseController:onReset()
	return
end

function BaseController:registerNotify(name, handler, handlerObj, priority)
	GlobalDispatcher:addListener(name, handler, handlerObj)
end

function BaseController:unregisterNotify(name, handler, handlerObj)
	GlobalDispatcher:removeListener(name, handler, handlerObj)
end

function BaseController:notify(name, ...)
	GlobalDispatcher:dispatch(name, ...)
end

function BaseController:registerLocalNotify(name, handler, handlerObj, priority)
	self._localDispatcher:addListener(name, handler, handlerObj)
end

function BaseController:unregisterLocalNotify(name, handler, handlerObj)
	self._localDispatcher:removeListener(name, handler, handlerObj)
end

function BaseController:localNotify(name, ...)
	self._localDispatcher:dispatch(name, ...)
end

return BaseController
