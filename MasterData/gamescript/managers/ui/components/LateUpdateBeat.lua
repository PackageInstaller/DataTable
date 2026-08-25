local LateUpdateBeat = NewClass("LateUpdateBeat")

function LateUpdateBeat:ctor()
  self.tempList = {}
  self.lateUpdateHandles = {}
end

function LateUpdateBeat:Add(handle, target)
  if self:Existes(handle, target) then
    return
  end
  table.insert(self.lateUpdateHandles, {handler = handle, target = target})
end

function LateUpdateBeat:LateUpdate()
  table.clear(self.tempList)
  table.mergeWithoutGc(self.tempList, self.lateUpdateHandles)
  for i = 1, #self.tempList do
    if self.tempList[i].handler then
      if self.tempList[i].target then
        self.tempList[i].handler(self.tempList[i].target)
      else
        self.tempList[i].handler()
      end
    end
  end
end

function LateUpdateBeat:Existes(handle, target)
  for i = 1, #self.lateUpdateHandles do
    if self.lateUpdateHandles[i].handler == handle and self.lateUpdateHandles[i].target == target then
      return true
    end
  end
  return false
end

function LateUpdateBeat:Remove(handle, target)
  for i = 1, #self.lateUpdateHandles do
    if self.lateUpdateHandles[i].handler == handle and self.lateUpdateHandles[i].target == target then
      table.remove(self.lateUpdateHandles, i)
      return
    end
  end
end

LateUpdateBeat.Instance = LateUpdateBeat()
return LateUpdateBeat
