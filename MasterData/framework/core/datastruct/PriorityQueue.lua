-- chunkname: @framework/core/datastruct/PriorityQueue.lua

module("framework.core.datastruct.PriorityQueue", package.seeall)

local PriorityQueue = class("PriorityQueue")

function PriorityQueue:ctor(compareFunc)
	self._compareFunc = compareFunc
	self._dataList = {}
	self._markRemoveDict = {}
	self._removeCount = 0
end

function PriorityQueue:getFirst()
	self:_disposeMarkRemove()

	return self._dataList[1]
end

function PriorityQueue:getFirstAndRemove()
	self:_disposeMarkRemove()

	local first = self._dataList[1]
	local len = #self._dataList

	self._dataList[1] = self._dataList[len]
	self._dataList[len] = nil

	self:_sink(1)

	return first
end

function PriorityQueue:add(data)
	local newLen = #self._dataList + 1

	self._dataList[newLen] = data

	self:_float(newLen)
end

function PriorityQueue:getSize()
	return #self._dataList - self._removeCount
end

function PriorityQueue:markRemove(checkRemoveFunc)
	for i, data in ipairs(self._dataList) do
		local hasMarkRemove = self._markRemoveDict[data]

		if not hasMarkRemove and checkRemoveFunc(data) then
			local dataType = type(data)
			local isDataRef = dataType == "table" or dataType == "userdata" or dataType == "function"

			if not isDataRef then
				logWarn("PriorityQueue mark remove warnning, type = " .. dataType .. ", value = " .. tostring(data))
			end

			local removeData = isDataRef and data or {
				data
			}

			self._dataList[i] = removeData
			self._markRemoveDict[removeData] = true
			self._removeCount = self._removeCount + 1
		end
	end
end

function PriorityQueue:_sink(index)
	local len = #self._dataList

	while len >= 2 * index do
		local childIndex = 2 * index

		if len >= childIndex + 1 and not self._compareFunc(self._dataList[childIndex], self._dataList[childIndex + 1]) then
			childIndex = childIndex + 1
		end

		if self._compareFunc(self._dataList[index], self._dataList[childIndex]) then
			break
		end

		self:_swap(index, childIndex)

		index = childIndex
	end
end

function PriorityQueue:_float(index)
	while index > 1 do
		local parentIndex = bit.rshift(index, 1)

		if not self._compareFunc(self._dataList[index], self._dataList[parentIndex]) then
			break
		end

		self:_swap(index, parentIndex)

		index = parentIndex
	end
end

function PriorityQueue:_swap(index1, index2)
	self._dataList[index1] = self._dataList[index2]
	self._dataList[index2] = self._dataList[index1]
end

function PriorityQueue:_disposeMarkRemove()
	while #self._dataList > 0 and self._markRemoveDict[self._dataList[1]] do
		self._markRemoveDict[self._dataList[1]] = nil
		self._removeCount = self._removeCount - 1

		local len = #self._dataList

		self._dataList[1] = self._dataList[len]
		self._dataList[len] = nil

		self:_sink(1)
	end
end

return PriorityQueue
