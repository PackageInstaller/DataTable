local LuaLayoutComp = NewClass("LuaLayoutComp")
local Vector3 = CS.UnityEngine.Vector3
local GameObject = CS.UnityEngine.GameObject
local VectorFar = Vector3(9999, 9999, 9999)

function LuaLayoutComp:ctor(container, templateGo, childSpace)
  self.container = container
  self.containerTf = container.transform
  self.templateGo = templateGo or self.containerTf:GetChild(0).gameObject
  self:InitChildSize(templateGo)
  self.childSpace = childSpace
  self.usingGoList = {}
  self.idleGoList = {}
  table.insert(self.idleGoList, self.templateGo)
end

function LuaLayoutComp:InitChildSize(templateGo)
  local size = templateGo.transform.sizeDelta
  self.childWidth, self.childHeight = size.x, size.y
end

function LuaLayoutComp:CreateChild(index)
  local go = table.remove(self.idleGoList, #self.idleGoList)
  if go then
    table.insert(self.usingGoList, go)
    return go
  end
  go = GameObject.Instantiate(self.firstChildGameObj, self.containerTf)
  table.insert(self.usingGoList, go)
  return go
end

function LuaLayoutComp:Reset()
  for i = #self.usingGoList, 1, -1 do
    local go = table.remove(self.usingGoList, i)
    go.transform.localPosition = VectorFar
    table.insert(self.idleGoList, go)
  end
end

function LuaLayoutComp:HorizontalCenterChildren()
end

function LuaLayoutComp:HorizontalRightChildren()
end

function LuaLayoutComp:HorizontalLeftChildren()
end

return LuaLayoutComp
