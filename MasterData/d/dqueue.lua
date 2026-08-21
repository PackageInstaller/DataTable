require "class"

local DQueue = class('DQueue')

function DQueue:ctor()
   self.first = 0
   self.last = -1
end


function DQueue:pushFront(value)
   self.first = self.first - 1
   self[self.first] = value
end

function DQueue:pushBack(value)
   self.last = self.last + 1
   self[self.last] = value
end

function DQueue:front()
   if self:empty() then
      return
   end

   return self[self.first]
end

function DQueue:back()
   if self:empty() then
      return
   end

   return self[self.last]
end

function DQueue:popFront()
   local first = self.first
   if self:empty() then
      return
   end

   local value = self[first]
   self[first] = nil
   self.first = first + 1
   return value
end

function DQueue:popBack()
   local last=self.last
   if self:empty() then
      return
   end
   local value = self[last]
   self[last] = nil
   self.last = last - 1
   return value
end

function DQueue:empty()
   return self.first > self.last
end

function DQueue:size()
   return self.last - self.first + 1
end

-- simple implement
function DQueue:clear()
   while self:popFront() do

   end
end

function DQueue:clone()
   local q = DQueue:new()
   local idx = self.first

   while idx <= self.last do
      q:pushBack(self[idx])
      idx = idx + 1
   end

   return q
end

-- local d = DQueue:new()
-- d:pushBack(3)
-- d:pushBack(5)
-- d:pushBack(8)

-- print(string.rep("-", 50))

-- local dd = d:clone()
-- d:popBack()
-- for i=1,3 do
--    print(dd:popFront())
-- end

return DQueue