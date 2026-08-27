local base = UIBaseNode
local UINCSRankRoundTogItem = class("UINCSRankRoundTogItem", base)

function UINCSRankRoundTogItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_Round, self, self._OnValueChange)
end

function UINCSRankRoundTogItem:InitCSRankRoundTogItem(roundData, clickFunc)
  self._roundData = roundData
  local roundId = roundData:GetCsRankRoundId()
  self.ui.tex_Name:SetIndex(0, tostring(roundId))
  self._clickFunc = clickFunc
end

function UINCSRankRoundTogItem:SetCSRankRoundTogItemOn()
  self.ui.tog_Round.isOn = true
end

function UINCSRankRoundTogItem:_OnValueChange(isOn)
  self.ui.tex_Name.text.color = self.ui.color_Name[isOn and 1 or 2]
  self.ui.img_bg.color = self.ui.color_Bg[isOn and 1 or 2]
  if isOn and self._clickFunc then
    self._clickFunc(self._roundData)
  end
end

function UINCSRankRoundTogItem:OnDelete()
  base.OnDelete(self)
end

return UINCSRankRoundTogItem
