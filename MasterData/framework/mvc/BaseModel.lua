-- chunkname: @framework/mvc/BaseModel.lua

module("framework.mvc.BaseModel", package.seeall)

local BaseModel = class("BaseModel")

function BaseModel:ctor()
	self._idCounter = 1
	self._list = {}
	self._dict = {}
end

function BaseModel:onInit()
	return
end

function BaseModel:reInit()
	return
end

function BaseModel:reInitInternal()
	self:clear()
	self:reInit()
end

function BaseModel:clear()
	self._idCounter = 1
	self._list = {}
	self._dict = {}
end

function BaseModel:getList()
	return self._list
end

function BaseModel:getDict()
	return self._dict
end

function BaseModel:getCount()
	return #self._list
end

function BaseModel:getById(id)
	return self._dict[id]
end

function BaseModel:getByIndex(index)
	return self._list[index]
end

function BaseModel:getIndex(mo)
	return tabletool.indexOf(self._list, mo)
end

function BaseModel:sort(sortFunction)
	table.sort(self._list, sortFunction)
end

function BaseModel:addList(list)
	for i, mo in ipairs(list) do
		self:_fillMOId(mo)

		if self._dict[mo.id] then
			local existIndex = tabletool.indexOf(self._list, mo)

			if existIndex then
				self._list[existIndex] = mo
			else
				for j, existMO in ipairs(self._list) do
					if existMO.id == mo.id then
						self._list[j] = mo

						break
					end
				end

				logError("mo.id duplicated, type = " .. (mo.__cname or "nil") .. ", id = " .. mo.id)
			end
		else
			table.insert(self._list, mo)
		end

		self._dict[mo.id] = mo
	end
end

function BaseModel:setList(list)
	self._list = {}
	self._dict = {}

	self:addList(list)
end

function BaseModel:addAt(mo, index)
	self:_fillMOId(mo)

	if self._dict[mo.id] then
		local existIndex = tabletool.indexOf(self._list, mo)

		if existIndex then
			self._list[existIndex] = mo
		else
			logError("mo in dict, but not in list: " .. cjson.encode(mo))
		end

		logWarn(string.format("%s:addAt(mo, %d) fail, mo.id = %d has exist, cover origin data", self.__cname, index, mo.id))
	else
		table.insert(self._list, index, mo)
	end

	self._dict[mo.id] = mo
end

function BaseModel:addAtFirst(mo)
	self:addAt(mo, 1)
end

function BaseModel:addAtLast(mo)
	self:addAt(mo, #self._list + 1)
end

function BaseModel:removeAt(index)
	if index > #self._list then
		return nil
	end

	local mo = table.remove(self._list, index)

	if mo then
		self._dict[mo.id] = nil
	end

	return mo
end

function BaseModel:removeFirst()
	return self:removeAt(1)
end

function BaseModel:removeLast()
	return self:removeAt(#self._list)
end

function BaseModel:remove(mo)
	local index = tabletool.indexOf(self._list, mo)

	if index then
		return self:removeAt(index)
	end
end

function BaseModel:_fillMOId(mo)
	if not mo.id then
		while self._dict[self._idCounter] do
			self._idCounter = self._idCounter + 1
		end

		mo.id = self._idCounter
		self._idCounter = self._idCounter + 1
	end
end

return BaseModel
