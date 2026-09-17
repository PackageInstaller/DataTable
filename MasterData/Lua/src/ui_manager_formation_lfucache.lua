local lfuCache = class("lfuCache")

function lfuCache:ctor(capacity)
  assert(type(capacity) == "number" and 0 < capacity, "capacity must be positive number")
  self.capacity = capacity
  self.map = {}
  self.size = 0
  self._tick = 0
  self.excludes = {}
end

function lfuCache:SetExcludes(list)
  self.excludes = {}
  if not list then
    return
  end
  if 0 < #list then
    for _, id in ipairs(list) do
      self.excludes[id] = true
    end
  else
    for id, v in pairs(list) do
      if v then
        self.excludes[id] = true
      end
    end
  end
end

function lfuCache:_nextTick()
  self._tick = self._tick + 1
  return self._tick
end

function lfuCache:Use(id)
  if id == nil then
    return nil
  end
  local entry = self.map[id]
  local now = self:_nextTick()
  if entry then
    entry.count = entry.count + 1
    entry.last = now
    return nil
  end
  self.size = self.size + 1
  if self.size > self.capacity then
    local evicted = self:_evictOne()
    self.map[id] = {count = 1, last = now}
    return evicted
  end
  self.map[id] = {count = 1, last = now}
  return nil
end

function lfuCache:Add(id, initialCount)
  if id == nil then
    return nil
  end
  if self.map[id] then
    self.map[id].last = self:_nextTick()
    return nil
  end
  local now = self:_nextTick()
  self.map[id] = {
    count = initialCount or 1,
    last = now
  }
  self.size = self.size + 1
  if self.size > self.capacity then
    return self:_evictOne()
  end
  return nil
end

function lfuCache:Dec(id, n)
  if id == nil then
    return
  end
  local entry = self.map[id]
  if not entry then
    return
  end
  n = n or 1
  entry.count = entry.count - n
  if entry.count <= 0 then
    self.map[id] = nil
    self.size = self.size - 1
  end
end

function lfuCache:Remove(id)
  if id == nil then
    return
  end
  if self.map[id] then
    self.map[id] = nil
    self.size = self.size - 1
  end
end

function lfuCache:GetEvictCandidate()
  if self.size == 0 then
    return nil
  end
  local minCount, oldestTick, candidate
  for id, entry in pairs(self.map) do
    if not self.excludes[id] and (minCount == nil or minCount > entry.count or entry.count == minCount and oldestTick > entry.last) then
      minCount = entry.count
      oldestTick = entry.last
      candidate = id
    end
  end
  return candidate
end

function lfuCache:_evictOne()
  local evictId = self:GetEvictCandidate()
  if evictId ~= nil then
    self.map[evictId] = nil
    self.size = self.size - 1
  end
  return evictId
end

function lfuCache:Clear()
  self.map = {}
  self.size = 0
  self._tick = 0
  self.excludes = {}
end

function lfuCache:DebugPrint()
  local list = {}
  for id, e in pairs(self.map) do
    table.insert(list, {
      id = id,
      count = e.count,
      last = e.last,
      excl = self.excludes[id]
    })
  end
  table.sort(list, function(a, b)
    if a.count ~= b.count then
      return a.count < b.count
    end
    return a.last < b.last
  end)
  local s = {}
  for _, v in ipairs(list) do
    table.insert(s, string.format("%s(c=%d,l=%d)%s", tostring(v.id), v.count, v.last, v.excl and "[X]" or ""))
  end
  printf("lfu:", table.concat(s, " | "))
end

return lfuCache
