local UpdaterList = System.NewClass("UpdaterList", SafeList)

function UpdaterList:Update()
  if next(self._removedItems) ~= nil or nil ~= next(self._addedItems) then
    self:_syncAddedRemovedItems()
  end
  for i, item in pairs(self._items) do
    if self._removedItems[item] == nil then
      LuaProfiler.Begin(item.__name)
      item:Update(item)
      LuaProfiler.End()
    end
  end
end

return UpdaterList
