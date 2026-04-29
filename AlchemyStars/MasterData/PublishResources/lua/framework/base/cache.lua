_class("Cache", Object)
Cache = Cache

function Cache:Constructor(num)
  self.queue = {}
  self.objs = {}
  self.objkeys = {}
  self.limitn = num
  self.hit = 0
  self.total = 0
end

function Cache:Push(key, obj)
  local oldobj = self.objs[key]
  if oldobj then
    assert(nil, "push same key obj : " .. key)
    self.objkeys[oldobj] = nil
    table.removev(self.queue, oldobj)
    return
  end
  self.objs[key] = obj
  table.insert(self.queue, obj)
  local len = #self.queue
  self.objkeys[obj] = key
  if len > self.limitn then
    local robj = table.remove(self.queue, 1)
    local rkey = self.objkeys[robj]
    self.objkeys[robj] = nil
    self.objs[rkey] = nil
    robj:Dispose()
  end
end

function Cache:Pop(key)
  self.total = self.total + 1
  local obj = self.objs[key]
  if not obj then
    return
  end
  self.objs[key] = nil
  table.removev(self.queue, obj)
  self.objkeys[obj] = nil
  self.hit = self.hit + 1
  return obj
end

function Cache:GetObjs()
  return self.objs
end

function Cache:Info()
  Log.sys("hit:", self.hit, "total:", self.total, "percent:", self.hit == 0 and 0 or self.hit * 100 / self.total)
  Log.sys("hide uis-----------------------------")
  for uiname, ui in next, self:GetObjs() do
    Log.sys(uiname .. " ", ui)
  end
end
