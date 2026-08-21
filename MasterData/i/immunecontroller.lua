require "class"
---@class ImmuneController
local ImmuneController = class("ImmuneController")

function ImmuneController:ctor(source)
	self._source = source
	self._immuneList = {}
end

function ImmuneController:setImmuneList(type, list)
	if (self._immuneList[type]) then
		self._immuneList[type] = tablex.combine(self._immuneList[type], list)
		self._immuneList[type] = tablex.distinct(self._immuneList[type])
	else
		self._immuneList[type] = list
	end
end

function ImmuneController:getImmuneList(type)
	return self._immuneList[type] or {}
end

return ImmuneController