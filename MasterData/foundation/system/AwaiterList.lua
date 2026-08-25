local AwaiterList = System.NewClass("AwaiterList")

function AwaiterList:ctor()
  self.waiting = false
  self.awaiters = {}
end

function AwaiterList:Reset()
  self.waiting = false
  self:Recycle()
end

function AwaiterList:Add()
  if not self.waiting then
    local awaiter = Awaiter.Get()
    table.insert(self.awaiters, awaiter)
    return awaiter
  end
end

function AwaiterList:WhenAll()
  self.waiting = true
  do return Awaiter.WhenAll end
  return Awaiter.WhenAll, self.awaiters
end

function AwaiterList:Recycle()
  for idx = #self.awaiters, 1, -1 do
    self.awaiters[idx]:Recycle()
    table.remove(self.awaiters, idx)
  end
end

return AwaiterList
