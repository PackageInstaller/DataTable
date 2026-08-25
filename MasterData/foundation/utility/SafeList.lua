local config = require("Vue.reactivity.config")
local __DEV__ = config.__DEV__
local next, pairs, ipairs, tinsert, tremove = next, pairs, ipairs, table.insert, table.remove
local SafeList = System.NewClass("SafeList")

function SafeList:ctor(removedName)
  self._items = {}
  self._removedName = removedName
  self._dirtyRemoved = false
  self._pending = 0
end

function SafeList:pushPending()
  self._pending = self._pending + 1
end

function SafeList:popPending()
  self._pending = self._pending - 1
  if 0 == self._pending and self._dirtyRemoved then
    self._dirtyRemoved = false
    local removedName = self._removedName
    for i = #self._items, 1, -1 do
      local item = self._items[i]
      if item[removedName] then
        tremove(self._items, i)
      end
    end
  end
end

function SafeList:removeItem(item)
  item[self._removedName] = true
  self._dirtyRemoved = true
end

function SafeList:getIsEmpty()
  return 0 == #self._items
end

function SafeList:getCount()
  return #self._items
end

function SafeList:Add(value)
  if __DEV__ then
    for i = #self._items, 1, -1 do
      local item = self._items[i]
      if item == value then
        Logger.Error("对象被重复添加", value)
      end
    end
  end
  value[self._removedName] = false
  table.insert(self._items, value)
end

function SafeList:Remove(value)
  self:pushPending()
  self:removeItem(value)
  self:popPending()
end

function SafeList:Clear()
  self:pushPending()
  local removedName = self._removedName
  for i = 1, #self._items do
    local item = self._items[i]
    if not item[removedName] then
      self:removeItem(item)
    end
  end
  self:popPending()
end

function SafeList:ForEach(updater)
  self:pushPending()
  local removedName = self._removedName
  for i = 1, #self._items do
    local item = self._items[i]
    if not item[removedName] then
      updater(item)
    end
  end
  self:popPending()
end

function SafeList:Update(dt)
  self:pushPending()
  local removedName = self._removedName
  for i = 1, #self._items do
    local item = self._items[i]
    if not item[removedName] then
      item:Update(dt)
    end
  end
  self:popPending()
end

function SafeList:Find(predicate, arg1, T1)
  self:pushPending()
  local removedName = self._removedName
  for i = 1, #self._items do
    local item = self._items[i]
    if not item[removedName] and predicate(item, arg1) then
      self:popPending()
      return item
    end
  end
  self:popPending()
  return nil
end

function SafeList:Finds(predicate, arg1, T1)
  self:pushPending()
  local items = {}
  local removedName = self._removedName
  for i = 1, #self._items do
    local item = self._items[i]
    if not item[removedName] and predicate(item, arg1) then
      table.insert(items, item)
    end
  end
  self:popPending()
  return items
end

function SafeList:Destroy(destroy)
  self:pushPending()
  local removedName = self._removedName
  for i = #self._items, 1, -1 do
    local item = self._items[i]
    if not item[removedName] then
      destroy(item)
    end
  end
  self:popPending()
end

return SafeList
