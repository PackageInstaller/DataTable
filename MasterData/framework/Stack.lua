-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/framework/datastruct/Stack.lua

module("framework.datastruct.Stack", package.seeall)

local Stack = class("Stack")

function Stack:ctor()
	self._stack = {}
end

function Stack:push(data)
	table.insert(self._stack, data)
end

function Stack:peek()
	if #self._stack == 0 then
		return nil
	end

	return self._stack[#self._stack]
end

function Stack:pop()
	if #self._stack == 0 then
		return nil
	end

	return table.remove(self._stack, #self._stack)
end

function Stack:isEmpty()
	return #self._stack == 0
end

function Stack:clear()
	self._stack = {}
end

return Stack
