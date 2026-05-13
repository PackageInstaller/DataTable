local List = class("List")

function List:ctor(...)
  self.elements = {}
end

function List:sort(func)
  table.sort(self.elements, func)
end

function List:add(pos, ...)
  local args = {
    ...
  }
  self:addTable(pos, args)
end

function List:addTable(pos, t)
  pos = pos or #self.elements + 1
  for i, v in pairs(t) do
    table.insert(self.elements, pos, v)
    pos = pos + 1
  end
end

function List:at(pos)
  return self.elements[pos]
end

function List:toTable()
  return self.elements
end

function List:clear()
  self.elements = {}
end

function List:back()
  return self.elements[#self.elements]
end

function List:front()
  return self.elements[1]
end

function List:pushBack(...)
  local args = {
    ...
  }
  for i = 1, #args do
    table.insert(self.elements, args[i])
  end
end

function List:popBack()
  if #self.elements ~= 0 then
    local ele = self.elements[#self.elements]
    table.remove(self.elements)
    return ele
  end
  return nil
end

function List:pushFront(...)
  local args = {
    ...
  }
  local pos = 1
  for i = 1, #args do
    table.insert(self.elements, pos, args[i])
    pos = pos + 1
  end
end

function List:popFront()
  if self.elements[1] then
    local ele = self.elements[1]
    table.remove(self.elements, 1)
    return ele
  end
  return nil
end

function List:remove(pos)
  if pos and self.elements[pos] then
    table.remove(self.elements, pos)
  else
    cclog("element is not exist!")
  end
end

function List:removeByFunc(ele, func)
  for i, v in pairs(self.elements) do
    if func(ele, v) then
      table.remove(self.elements, i)
      break
    end
  end
end

function List:clear()
  self.elements = {}
end

function List:count()
  return #self.elements
end

function List:empty()
  return #self.elements == 0
end

function List:pairs()
  return pairs(self.elements)
end

function List:print()
  for i, v in pairs(self.elements) do
    cclog(i, v)
  end
end

function List:push(ele)
  self:pushFront(ele)
end

function List:pop()
  return self:popFront()
end

function List:top()
  return self:front()
end

return List
