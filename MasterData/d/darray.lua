require "class"

local DArray = class('DArray')

function DArray:ctor()
	self.m_list = {}
	self.tail = 0
	self.head = 0

	-- local function addOperator(arr)
	-- 	local meta = getmetatable(arr)
	-- 	local sourcIndex = meta.__index
	-- 	meta.__index = function (table, key)
	-- 		local find
	-- 		if type(sourcIndex) == "function" then
	-- 			find = sourcIndex(arr, key)
	-- 		else
	-- 			find = sourcIndex[key]
	-- 		end

	-- 		if find then
	-- 			return find
	-- 		end

	-- 		print("---", table, key)
	-- 		return table.m_list[key]
	-- 	end
	-- end

	-- addOperator(self)
end


function DArray:length()
	return self.tail - self.head
end
DArray.size = DArray.length
DArray.count = DArray.length

function DArray:empty()
	return self:length() == 0
end

function DArray:iterator()
	local s, e = self.head - 1, self.tail
	return function ()
		s = s + 1
		if s >= e then return nil end
		return self.m_list[s]
	end
end


function DArray:indexOf(obj)
	local len = self:length()
	if len == 0 then return -1 end
	for i = 0, len - 1 do
		local v = self.m_list[i]
		if v == obj then return i end		
	end
	return -1
end

function DArray:splice(nStart, nCount, ...)
	local tb, ins = {}, {...}
	local nLen = self:length()
	if nLen == 0 then
		for k, v in pairs(ins) do
			self:push(v)
		end
		return nil
	end
	local s, e = self.head, self.head + nStart
	e = e >= self.head + nLen and self.head + nLen or e
	while s < e do
		tb[s] = self.m_list[s]
		s = s + 1
	end

	for k, v in pairs(ins) do
		tb[s] = v
		s = s + 1
	end

	e = e + nCount
	while e < self.head + nLen do
		tb[s] = self.m_list[e]
		s = s + 1
		e = e + 1
	end
	self.m_list = tb
	self.tail = self.tail + #ins - nCount
end

function DArray:insertAt(nIndex, obj)
	self:splice(nIndex, 0, obj)
end

function DArray:push(obj)
	return self:pushBack(obj)
end

function DArray:pushFront(obj)
	if not obj then return end
	if instanceOf(obj) == 'DArray' then
		local nLen = obj:length()
		for v in obj:iterator() do
			self.head = self.head - 1
			self.m_list[self.head] = v
		end	
	else
		self.head = self.head - 1
		self.m_list[self.head] = obj
	end
	return obj
end

function DArray:pushBack(obj)
	if not obj then return end
	if instanceOf(obj) == 'DArray' then
		for v in obj:iterator() do
			self.m_list[self.tail] = v
			self.tail = self.tail + 1
		end	
	else
		self.m_list[self.tail] = obj
		self.tail = self.tail + 1
	end
	return obj
end

function DArray:assign(obj)
	self:clear()
	if instanceOf(obj) == 'DArray' then
		for v in obj:iterator() do
			self.m_list[self.tail] = v
			self.tail = self.tail + 1
		end	
	else
		self.m_list[self.tail] = obj
		self.tail = self.tail + 1
	end
	return obj
end

function DArray:pop()
	return self:popFront()
end

function DArray:popFront()
	if self.head >= self.tail then return nil end
	local obj = self.m_list[self.head]
	self.m_list[self.head] = nil
	self.head = self.head + 1
	return obj
end

function DArray:popBack()
	if self.head >= self.tail then return nil end
	local obj = self.m_list[self.tail - 1]
	self.m_list[self.tail - 1] = nil
	self.tail = self.tail - 1
	return obj
end

function DArray:front()
	return self.m_list[self.head]
end

function DArray:back()
	return self.m_list[self.tail - 1]
end

function DArray:getObjectAt(nIndex)
	return self.m_list[self.head + nIndex]
end

function DArray:objectAt(nIndex)
	return self.m_list[self.head + nIndex]
end

function DArray:removeObjectAt(nIndex)
	self:splice(nIndex, 1)
end

function DArray:removeObject(obj)
	local nIndex = self:indexOf(obj)
	if nIndex ~= -1 then
		self:splice(nIndex, 1)
	end
end

function DArray:removeObjects(...)
	for i,v in ipairs(arg) do
		self:removeObject(v)
	end
end

function DArray:removeif(func)
	local toRemove = {}
	for v in self:iterator() do
		if func(v) then
			table.insert(toRemove, v)
		end
	end

	self:removeObjects(unpack(toRemove))
end

function DArray:clear()
	--self:splice(1, self:length())
	self.m_list = {}
	self.tail = 0
	self.head = 0
end

function DArray:swap(i, j)
	local x = self.m_list[self.head + i]
	local y = self.m_list[self.head + j]
	self.m_list[self.head + i], self.m_list[self.head + j] = y, x
end

function DArray:qsort(p, r, cmp)
	local function partition(arr, p, r, cmp)
		local x = arr:getObjectAt(r)
		local i = p - 1
		if cmp then
			for j = p, r - 1 do
				if cmp(arr:getObjectAt(j), x) then
					i = i + 1
					arr:swap(i, j)
				end
			end
		elseif not cmp then
			for j = p, r - 1 do
				if arr:getObjectAt(j) <= x then
					i = i + 1
					arr:swap(i, j)
				end
			end
		end
		arr:swap(i + 1, r)
		return i + 1
	end
	if p < r then
		local q = partition(self, p, r, cmp)
		self:qsort(p, q - 1, cmp)
		self:qsort(q + 1, r, cmp)
	end
end

function DArray:sort(cmp)
	self:qsort(self.head, self.tail - 1, cmp)
end

-- 冒泡排序
function DArray:bbsort(cmp)
	local cnt = self:length()
	for i = 0, cnt - 2 do
		for j = 0, cnt - 2 - i do
			if not cmp(self:getObjectAt(j), self:getObjectAt(j + 1)) then
				self:swap(j, j + 1)
			end
		end
	end
end

function DArray:shuffle()
	local size = self:size()
	if size < 2 then return end

	local nRandomIdx = 1
	local endIdx = self.tail - 1
	for i = self.head, endIdx do 
		if i ~= endIdx then
			nRandomIdx = math.random(i + 1, endIdx) 
			self:swap(i, nRandomIdx)
		end
	end
end

-- dd = DArray:new()
-- dd2 = DArray:new()

-- tb = {
-- 	{ a = 2, b = "m"},
-- 	{ a = 3, b = "n"},
-- 	{ a = 4, b = "k"},
-- 	{ a = 5, b = "l"},
-- }

-- for i,v in ipairs(tb) do
-- 	dd:push(v)
-- end

-- dd:removeif(function (v)
-- 	if v.a > 3 then
-- 		return true
-- 	end
-- end)

-- print(dd[0].a)
-- -- dd:splice(0, 2, 5, 6, 7)

-- for i in dd:iterator() do
-- 	print(i.a)
-- end


return DArray