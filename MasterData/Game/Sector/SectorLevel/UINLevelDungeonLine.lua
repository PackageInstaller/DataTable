local UINLevelDungeonLine = class("UINLevelDungeonLine", UIBaseNode)
local base = UIBaseNode

function UINLevelDungeonLine:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINLevelDungeonLine:InitLevelDungeonLine(startPos, angle, length)
  self.transform.localPosition = startPos
  self.transform.localEulerAngles = Vector3.New(0, 0, angle)
  local sizeDelta = self.transform.sizeDelta
  sizeDelta.x = length
  self.transform.sizeDelta = sizeDelta
end

return UINLevelDungeonLine
