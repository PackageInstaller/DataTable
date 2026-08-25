local Vector3Pool, Super = System.NewClass("Vector3Pool")
local Vector3 = CS.UnityEngine.Vector3

function Vector3Pool:ctor()
end

function Vector3Pool:Reserve(size)
  self.buffer = {}
  self.size = size
  for i = 1, size do
    self.buffer[i] = Vector3(0, 0, 0)
  end
  self.index = 1
end

function Vector3Pool:Push(vec3)
  if self.index > 1 then
    self.index = self.index - 1
    self.buffer[self.index] = vec3
  end
end

function Vector3Pool:PushList(vec3List)
  for i = 1, #vec3List do
    self:Push(vec3List[i])
  end
end

function Vector3Pool:Pop()
  if self.index > self.size then
    do return Vector3, 0, 0 end
    return Vector3, 0, 0, 0
  end
  local value = self.buffer[self.index]
  self.buffer[self.index] = nil
  self.index = self.index + 1
  return value
end

function Vector3Pool:Clear()
  self.buffer = {}
  self.index = 1
  self.size = 0
end

Vector3Pool.Instance = Vector3Pool()
return Vector3Pool
