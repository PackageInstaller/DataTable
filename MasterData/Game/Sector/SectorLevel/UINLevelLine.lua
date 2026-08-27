local UINLevelLine = class("UINLevelLine", UIBaseNode)
local base = UIBaseNode
local eLevelLineType = require("Game.Sector.Enum.eLevelLineType")

function UINLevelLine:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINLevelLine:InitLevelLine(lineType, startPos, angle, length)
  self.transform.localPosition = startPos
  self.transform.localEulerAngles = Vector3.New(0, 0, angle)
  self.length = length
  self:RefreshLevelLineState(lineType)
end

function UINLevelLine:RefreshLevelLineState(lineType)
  self.ui.img_lineItem.enabled = true
  if lineType == eLevelLineType.BetweenLevel then
    self.ui.fill.gameObject:SetActive(true)
    self:__SetLength(self.length, self.ui.maxWidth, 0)
    self.ui.img_lineItem.color = Color.New(1, 1, 1, 0.9)
  elseif lineType == eLevelLineType.BetweenLevelFull then
    self.ui.fill.gameObject:SetActive(true)
    self:__SetLength(self.length, self.ui.maxWidth, 1)
    self.ui.img_lineItem.enabled = false
  elseif lineType == eLevelLineType.Decorate then
    self.ui.fill.gameObject:SetActive(false)
    self:__SetLength(self.ui.maxLength, self.ui.minWidth)
  elseif lineType == eLevelLineType.StoryLine then
    self.ui.fill.gameObject:SetActive(false)
  end
end

function UINLevelLine:__SetLength(length, width, fillAmount)
  local sizeDelta = self.transform.sizeDelta
  sizeDelta.x = length
  sizeDelta.y = width
  self.transform.sizeDelta = sizeDelta
  if fillAmount ~= nil then
    sizeDelta.x = length * fillAmount
    sizeDelta.y = width + (self.ui.addWidth or 2)
    self.ui.fill.transform.sizeDelta = sizeDelta
  end
end

function UINLevelLine:OnDelete()
  base.OnDelete(self)
end

return UINLevelLine
