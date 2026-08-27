local UINCharDunShopVer2Line = class("UINCharDunShopVer2Line", UIBaseNode)
local base = UIBaseNode

function UINCharDunShopVer2Line:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINCharDunShopVer2Line:InitCharDunShopVer2LineHorize(length, reverse, startScore, endScore)
  self:__SetData(startScore, endScore)
  local scale = self.transform.localScale
  scale.x = reverse and -1 or 1
  self.transform.localScale = scale
  local sizeDelta = self.transform.sizeDelta
  sizeDelta.x = length
  self.transform.sizeDelta = sizeDelta
end

function UINCharDunShopVer2Line:InitCharDunShopVer2LineVertial(length, reverse, startScore, endScore)
  self:__SetData(startScore, endScore)
  local scale = self.transform.localScale
  scale.y = reverse and -1 or 1
  self.transform.localScale = scale
  local sizeDelta = self.transform.sizeDelta
  sizeDelta.y = length
  self.transform.sizeDelta = sizeDelta
end

function UINCharDunShopVer2Line:__SetData(startScore, endScore)
  self._startScore = startScore
  self._endScore = endScore
  self._diffScore = self._endScore - self._startScore
end

function UINCharDunShopVer2Line:RefreshCharDunShopVer2Line(score)
  local diff = score - self._startScore
  self.ui.fill.fillAmount = diff / self._diffScore
end

return UINCharDunShopVer2Line
