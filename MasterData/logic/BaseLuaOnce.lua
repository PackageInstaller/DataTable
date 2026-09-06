-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/component/BaseLuaOnce.lua

module("logic.extensions.common.component.BaseLuaOnce", package.seeall)

local BaseLuaOnce = class("BaseLuaOnce")

function BaseLuaOnce:ctor(go)
	self.mainGO = go.gameObject

	self:buildUI()
	self:bindEvents()
end

function BaseLuaOnce:buildUI()
	return
end

function BaseLuaOnce:bindEvents()
	return
end

function BaseLuaOnce:unbindEvents()
	return
end

function BaseLuaOnce:OnDestroy()
	self:onExit()
	self:unbindEvents()
end

function BaseLuaOnce:onEnter()
	return
end

function BaseLuaOnce:onExit()
	self:_removeAllGEvent()
end

function BaseLuaOnce:getGo(goPath)
	return goutil.findChild(self.mainGO, goPath)
end

function BaseLuaOnce:getBtn(goPath)
	return GameUtil.asBtn(self:getGo(goPath))
end

function BaseLuaOnce:getText(goPath)
	return goutil.findChildTextComponent(self.mainGO, goPath)
end

function BaseLuaOnce:getInput(goPath)
	return Framework.InputFieldAdapter.GetFrom(self.mainGO, goPath)
end

function BaseLuaOnce:getTxt(goPath)
	return goutil.findChildTextComponent(self.mainGO, goPath)
end

function BaseLuaOnce:addGEvent(eventName, handler, handlerObj, priority)
	self.__eventList = self.__eventList or {}
	handlerObj = handlerObj or self
	priority = priority or NotifyPriority.Normal

	local obj = {}

	obj.eventName = eventName
	obj.handler = handler
	obj.handlerObj = handlerObj

	table.insert(self.__eventList, obj)
	GlobalDispatcher:addListener(eventName, handler, handlerObj, priority)
end

function BaseLuaOnce:_removeAllGEvent()
	if self.__eventList then
		for i, obj in ipairs(self.__eventList) do
			GlobalDispatcher:removeListener(obj.eventName, obj.handler, obj.handlerObj)
		end

		self.__eventList = nil
	end
end

return BaseLuaOnce
