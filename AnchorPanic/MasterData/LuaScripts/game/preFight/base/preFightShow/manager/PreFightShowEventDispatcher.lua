--[[-----------------------------------------------------
@filename       : EventDispatcher
@Description    : 事件适配器
@date           : 2018-10-18
@Author         : lize
@copyright      : (LY) 2018 雷焰网络
-----------------------------------------------------
]]
module('preFight.ShowEventDispatcher', Class.impl())

--构造
function ctor(self)
	self._inDispatching = false
end
--析构
function dtor(self)
	
end

function addEventListener(self, etype, func, listener)
	
	self:checkDelEvents()
	
	if not self._events then
		self._events = {}
	end
	
	if not self._events[etype] then
		self._events[etype] = {}
	end
	
	if not self._events[etype] [listener] then
		self._events[etype] [listener] = {}
	end
	
	for _, _func in pairs(self._events[etype] [listener]) do
		if(_func == func) then
			return
		end
	end
	
	table.insert(self._events[etype] [listener], func)
end

function removeEventListener(self, etype, func, listener)
	if self._inDispatching == true then
		if self._events and self._events[etype] then
			if not self._delEvents then
				self._delEvents = {}
			end
			table.insert(self._delEvents, {etype = etype, listener = listener, func = func})
		end
	else
		if self._events and self._events[etype] and self._events[etype] [listener] then
			for i, _func in pairs(self._events[etype] [listener]) do
				if(_func == func) then
					table.remove(self._events[etype] [listener], i, func)
					return
				end
			end
		end
	end
end

function dispatchEvent(self, etype, argsTable)
	if self._delEvents then
		self:checkDelEvents()
	end
	
	local oldInDispatching = self._inDispatching;
	self._inDispatching = true
	if self._events and self._events[etype] then
		for listener, funcList in pairs(self._events[etype]) do
			for _, func in pairs(funcList) do
				func(listener, argsTable, self, func)
			end
		end
	end
	self._inDispatching = oldInDispatching
end

function hasEventListener(self, etype, func, listener)
	self:checkDelEvents()
	
	if self._events and self._events[etype] and self._events[etype] [listener] then
		for i, _func in pairs(self._events[etype] [listener]) do
			if(_func == func) then
				return true
			end
		end
	else
		return false
	end
end

function checkDelEvents(self)
	if self._delEvents then
		for _, v in pairs(self._delEvents) do
			if(self._events[v.etype] [v.listener]) then
				local count = #self._events[v.etype] [v.listener]
				for i = count, 1, - 1 do
					if(self._events[v.etype] [v.listener] [i] == v.func) then
						table.remove(self._events[v.etype] [v.listener], i, v.func)
						break
					end
				end
			end
		end
		self._delEvents = nil
	end
end

function removeAllEventListener(self)
	self._delEvents = nil
	self._events = nil
end

return _M 
 
--[[ 替换语言包自动生成，请勿修改！
]]
