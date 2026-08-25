local Channel = System.NewClass("Channel")

function Channel:ctor()
  self.list = {}
  self.cos = {}
end

function Channel:Push(data)
  table.insert(self.list, data)
  if #self.cos > 0 then
    local co = table.pop(self.cos)
    Coroutine.Resume(co)
  end
end

function Channel:Pop()
  local ret
  repeat
    if 0 == #self.list then
      local co = coroutine.running()
      table.insert(self.cos, co)
      Coroutine.Yield()
    end
  until #self.list > 0
  ret = table.pop(self.list)
  return ret
end

function Channel:IsEmpty()
  return #self.list <= 0
end

function Channel:Clear()
  self.list = {}
end

return Channel
