local UpdateBeat = NewClass("UpdateBeat")

function UpdateBeat:ctor()
  self.tempList = {}
  self.updateHandles = {}
end

function UpdateBeat:Add(handle, target)
  if self:Existes(handle, target) then
    return
  end
  table.insert(self.updateHandles, {handler = handle, target = target})
end

function UpdateBeat:Update(deltaTime)
  table.clear(self.tempList)
  table.mergeWithoutGc(self.tempList, self.updateHandles)
  for i = 1, #self.tempList do
    if self.tempList[i].handler then
      if self.tempList[i].target then
        self.tempList[i].handler(self.tempList[i].target, deltaTime)
      else
        self.tempList[i].handler(deltaTime)
      end
    end
  end
end

function UpdateBeat:Existes(handle, target)
  for i = 1, #self.updateHandles do
    if self.updateHandles[i].handler == handle and self.updateHandles[i].target == target then
      return true
    end
  end
  return false
end

function UpdateBeat:Remove(handle, target)
  for i = 1, #self.updateHandles do
    if self.updateHandles[i].handler == handle and self.updateHandles[i].target == target then
      table.remove(self.updateHandles, i)
      return
    end
  end
end

UpdateBeat.Instance = UpdateBeat()
return UpdateBeat
