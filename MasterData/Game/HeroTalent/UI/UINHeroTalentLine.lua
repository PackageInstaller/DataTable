local UINHeroTalentLine = class("UINHeroTalentLine", UIBaseNode)
local base = UIBaseNode
local unValidAlpha = 0.1
local dottedLineAlpha = 0.5

function UINHeroTalentLine:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINHeroTalentLine:SetHeroTalentLine(startPos, endPos)
  self.transform.localPosition = startPos
  local offsetVec = endPos - startPos
  local z = Vector2.Angle(Vector2.right, offsetVec)
  z = offsetVec.y > 0 and z or -z
  self.transform.localEulerAngles = Vector3.New(0, 0, z)
  self.transform.pivot = Vector2.New(0, 0.5)
  self.transform.sizeDelta = Vector2.New(Vector3.Distance(startPos, endPos), 4)
end

function UINHeroTalentLine:RefreshHeroTalentLine(valid, isDottedLine)
  self.ui.img_Line:SetIndex(isDottedLine and 1 or 0)
  local color = self.ui.img.color
  if not valid then
    color.a = unValidAlpha
  elseif isDottedLine then
    color.a = dottedLineAlpha
  else
    color.a = 1
  end
  self.ui.img.color = color
end

return UINHeroTalentLine
