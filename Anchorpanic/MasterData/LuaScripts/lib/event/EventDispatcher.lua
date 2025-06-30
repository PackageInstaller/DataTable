--[[
-----------------------------------------------------
@filename       : EventDispatcher
@Description    : 事件适配器
@date           : 2018-10-18
@Author         : lize
@copyright      : (LY) 2018 雷焰网络
-----------------------------------------------------
]]

module('lib.event.EventDispatcher', Class.impl())

--构造
function ctor(self)
	self._inDispatching = false
end
--析构
function dtor(self)
	
end

function addEventListener(self, etype, func, listener)
	if not etype then
		logError("监听事件类型 etype 为nil")
		return
	end
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
	-- if self._inDispatching == true then
	-- 	if self._delEvents then
	-- 		for i, v in pairs(self._delEvents) do
	-- 			if v.etype==etype and v.listener==listener and v.func==func then
	-- 				table.remove(self._delEvents, i)
	-- 				return
	-- 			end
	-- 		end
	-- 	end
	-- end
	for _, _func in ipairs(self._events[etype] [listener]) do
		if(_func == func) then
			return
		end
	end
	
	table.insert(self._events[etype] [listener], func)
end 

function removeAllEvent(self, listener)
	if self._inDispatching == true then
		if not self._delEvents then
			self._delEvents = {}
			if(self._events)then
				for etype,v in pairs(self._events) do
					local dict = v[etype]
					if dict then
						local funcList = dict[listener]
						if funcList then
							for _,func in ipairs(funcList) do
								table.insert(self._delEvents, {etype = etype, listener = listener, func = func})
							end
						end
					end
				end
			end
		else
			for etype,v in pairs(self._events) do
				local dict = v[etype]
				if dict then
					local funcList = dict[listener]
					if funcList then
						for _,func in ipairs(funcList) do
							for _,v in ipairs(self._delEvents) do
								if v.etype~=etype or v.listener~=listener or v.func~=func then
									table.insert(self._delEvents, {etype = etype, listener = listener, func = func})
								end
							end
						end
					end
				end
			end
		end
	else
		if(self._events)then
			for k,v in pairs(self._events) do
				local dict = v[k]
				if dict then
					dict[listener] = nil
				end
			end
		end
	end
end

function removeEventListener(self, etype, func, listener)
	-- if self._inDispatching == true then
	-- 	if self._events and self._events[etype] then
	-- 		if not self._delEvents then
	-- 			self._delEvents = {}
	-- 		end
	-- 		table.insert(self._delEvents, {etype=etype,func=func})
	-- 	end 
	-- else
	-- 	if self._events and self._events[etype] then
	-- 		self._events[etype][func] = nil
	-- 	end 
	-- end 

	if self._inDispatching == true then
		if self._events and self._events[etype] then
			if not self._delEvents then
				self._delEvents = {}
			end
			for _,v in ipairs(self._delEvents) do
				if v.etype==etype and v.listener==listener and v.func==func then
					return
				end
			end
			table.insert(self._delEvents, {etype = etype, listener = listener, func = func})
		end
	else
		if self._events and self._events[etype] and self._events[etype] [listener] then
			for i, _func in pairs(self._events[etype] [listener]) do
				if(_func == func) then
					table.remove(self._events[etype] [listener], i)
					return
				end
			end
		end
	end
end 

function dispatchEvent(self, etype, event) 
	self:checkDelEvents()

    if(subPack and subPack.SubDownLoadController and subPack.SubDownLoadController:checkEventNameDownLoadState(etype, event))then
        return
    end

	local oldInDispatching = self._inDispatching;
	self._inDispatching = true
	-- if self._events and self._events[etype] then 
	-- 	for func, listener in pairs(self._events[etype]) do
	-- 		func(listener, event, self,func)
	-- 	end
	-- end
	-- self._inDispatching = oldInDispatching
	
	if self._events and self._events[etype] then
		for listener, funcList in pairs(self._events[etype]) do
			for _, func in pairs(funcList) do

				local _isDel = false
				if  self._delEvents then
					for _,v in ipairs(self._delEvents) do
						if v.etype==etype and v.listener==listener and v.func==func then
							_isDel = true
						end
					end
				end
				
				if not _isDel then
					func(listener, event, self, func)
				end
			end
		end
	end
	self._inDispatching = oldInDispatching
end

function hasEventListener(self, etype, func, listener)
	self:checkDelEvents()

	-- if self._events and self._events[etype] and self._events[etype][func] then
	-- 	return true
	-- else
	-- 	return false
	-- end

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
	-- if self._delEvents then
	-- 	for _, v in ipairs(self._delEvents) do
	-- 		self._events[v.etype][v.func] = nil
	-- 	end
	-- 	self._delEvents = nil
	-- end
	if self._delEvents then
		for _, v in pairs(self._delEvents) do
			if(self._events[v.etype] [v.listener]) then
				local count = #self._events[v.etype] [v.listener]
				for i = count, 1, - 1 do
					if(self._events[v.etype] [v.listener] [i] == v.func) then
						table.remove(self._events[v.etype] [v.listener], i)
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