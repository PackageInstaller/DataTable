local UINTroopItem = class("UINTroopItem", UIBaseNode)
local base = UIBaseNode

function UINTroopItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self.OnClickSeleteTroop)
  self._isCalcutedPower = false
end

function UINTroopItem:InitTroopItem(fmtId, selectEvent, idOffset, index)
  self.id = fmtId
  self.idOffset = idOffset
  self.selectEvent = selectEvent
  self.index = index
  local formationData = PlayerDataCenter.formationDic[self.id]
  if formationData == nil then
    self:RefreshTroopName()
  else
    self:RefreshTroopName(formationData.name)
  end
end

function UINTroopItem:RefreshTroopName(name)
  if string.IsNullOrEmpty(name) then
    self.ui.tex_TeamName:SetIndex(0, tostring(self.id - self.idOffset))
  else
    self.ui.tex_TeamName.text.text = name
  end
end

function UINTroopItem:OnClickSeleteTroop()
  if self.selectEvent ~= nil then
    self.selectEvent(self.id, self.index)
  end
end

function UINTroopItem:RefreshPower(ftpower, benchPower)
  local benchPow = benchPower == nil and 0 or benchPower
  self._isCalcutedPower = true
  self.ui.tex_MainTP.text = tostring(ftpower)
  self.ui.tex_BenchTP.text = tostring(benchPow)
end

function UINTroopItem:IsCalcutedPower()
  return self._isCalcutedPower
end

function UINTroopItem:OnDelete()
  base.OnDelete(self)
end

return UINTroopItem
