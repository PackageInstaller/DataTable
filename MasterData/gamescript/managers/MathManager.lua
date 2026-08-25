local MathManager, Super = System.NewClass("MathManager", Manager)

function MathManager:ctor()
  Super.ctor(self)
end

function MathManager:Awake()
  Super.Awake(self)
  self.instanceId = 0
end

function MathManager:GetInstanceId()
  self.instanceId = self.instanceId + 1
  return self.instanceId
end

function MathManager:RondomFromList(list)
  local count = #list
  math.randomseed(os.time() + self:GetInstanceId())
  return list[math.random(1, count)]
end

function MathManager:RandomNumFromList(list, num)
  if nil == num then
    num = 1
  end
  local keys = {}
  local countNum = #list
  if num >= countNum then
    for key, value in ipairs(list) do
      table.insert(keys, value)
    end
    return keys
  end
  while num > #keys do
    local count = #list
    math.randomseed(os.time() + self:GetInstanceId())
    local index = math.random(1, count)
    local i = list[index]
    if not SystemUtils.Contain(keys, i) then
      table.insert(keys, i)
      table.remove(list, index)
    end
  end
  return keys
end

function MathManager:OnDestroy()
  Super.OnDestroy(self)
end

return MathManager
