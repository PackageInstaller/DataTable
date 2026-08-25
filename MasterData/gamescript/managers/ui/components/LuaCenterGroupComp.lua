local LuaCenterGroupComp = NewClass("LuaCenterGroupComp")
local Vector3 = CS.UnityEngine.Vector3
local GameObject = CS.UnityEngine.GameObject

function LuaCenterGroupComp:ctor(container)
  self.container = container
  self.containerTf = container.transform
  self.firstChildGameObj = self.containerTf:GetChild(0).gameObject
end

function LuaCenterGroupComp:CreateChild(index)
  local gameObject
  local childCount = self.containerTf.childCount
  if index <= childCount then
    gameObject = self.containerTf:GetChild(index - 1).gameObject
  else
    gameObject = GameObject.Instantiate(self.firstChildGameObj, self.containerTf)
  end
  gameObject:SetActive(true)
  return gameObject
end

function LuaCenterGroupComp:Reset()
  local childCount = self.containerTf.childCount
  for i = 0, childCount - 1 do
    local child = self.containerTf:GetChild(i)
    child.gameObject:SetActive(false)
  end
end

function LuaCenterGroupComp:HorizontalCenterChildren(childWidth, childSpace)
  local visibleChildList = {}
  local childCount = self.containerTf.childCount
  for i = 0, childCount - 1 do
    local child = self.containerTf:GetChild(i)
    if child.gameObject.activeSelf then
      table.insert(visibleChildList, child)
    end
  end
  childWidth = childWidth or 100
  childSpace = childSpace or 10
  local contentWidth = childWidth * #visibleChildList + childSpace * (#visibleChildList - 1)
  local offset = (0 - contentWidth) / 2
  local gap = childWidth + childSpace
  for i = 1, #visibleChildList do
    local child = visibleChildList[i]
    local childPos = child.localPosition
    child.localPosition = Vector3(offset + gap * (i - 1) + childWidth * 0.5, childPos.y, childPos.z)
  end
end

return LuaCenterGroupComp
