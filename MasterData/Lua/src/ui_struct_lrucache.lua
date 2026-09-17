local this = class("lruCache")

function this:ctor(maxCount, removeCall)
  self.factor = 1.2
  self.removeCall = removeCall
  self:reset()
  self:setMaxCount(maxCount)
end

function this:setMaxCount(maxCount)
  self.maxCount = math.clamp(maxCount or 50, 1)
  self.limit = math.ceil(self.factor * self.maxCount)
end

function this:setRemoveCall(removeCall)
  self.removeCall = removeCall
end

function this:reset()
  self.dic = {}
  if self.link then
    self.link:reset()
  else
    self.link = L_Struct.getDoubleLink()
  end
end

function this:dispose()
  if self.removeCall then
    for _, v in pairs(self.dic) do
      self.removeCall(v.key, v.value)
    end
  end
  self:reset()
end

function this:add(key, value)
  local node = self.dic[key]
  if node then
    self.link:nodeRemove(node)
    self.link:nodeHeadInsert(node)
    node.value = value
  else
    local minus = self:getCount() - self.limit
    if 0 <= minus then
      self:triggerGarbage(minus)
    end
    local node = {key = key, value = value}
    self.dic[key] = self.link:nodeHeadInsert(node)
  end
end

function this:get(key)
  local node = self.dic[key]
  if node then
    self.link:nodeRemove(node)
    self.link:nodeHeadInsert(node)
  end
  return node and node.value
end

function this:first()
  local node = self.link:getFirst()
  if node then
    return node.key, node.value
  end
end

function this:_get(key)
  local node = self.dic[key]
  return node and node.value
end

function this:triggerGarbage()
  local minus = self.limit - self.maxCount
  local souMinus = minus
  local last = self.link:getLast()
  while 0 < minus and last do
    local needRemove = self.removeCall == nil or self.removeCall(last.key, last.value)
    if needRemove then
      self:remove(last.key)
      minus = minus - 1
    end
    if last.pre ~= self.link.head then
      last = last.pre
    else
      last = nil
    end
  end
  if souMinus == minus then
    local maxCount = math.ceil(self.maxCount * 1.5)
    self:setMaxCount(maxCount)
  end
end

function this:remove(key)
  local node = self.dic[key]
  if node then
    self.dic[key] = nil
    self.link:nodeRemove(node)
  end
  return node
end

function this:getCount()
  return self.link.count
end

return this
