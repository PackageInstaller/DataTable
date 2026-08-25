local UICompCopyBattleStatisticBattleTypeOption, Super = NewViewComponent("UICompCopyBattleStatisticBattleTypeOption")

function UICompCopyBattleStatisticBattleTypeOption:ctor(uiNode, view, label, battleIndex, selectedBattleIndex, onPick)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Pvp_Item_SeasonResource(uiNode)
  self._label = label or ""
  self._battleIndex = tonumber(battleIndex) or 0
  self._selectedBattleIndex = tonumber(selectedBattleIndex) or 0
  self._onPick = onPick
end

function UICompCopyBattleStatisticBattleTypeOption:OnEnterComponent()
  self:Refresh(self._label, self._battleIndex, self._selectedBattleIndex, self._onPick)
  local clickBtn = self.ui.Btn_Select or self.ui.Btn_Click
  if clickBtn then
    self:AddButtonClickListener(clickBtn, System.fn(self, self._OnClick))
  end
end

function UICompCopyBattleStatisticBattleTypeOption:Refresh(label, battleIndex, selectedBattleIndex, onPick)
  self._label = label or ""
  self._battleIndex = tonumber(battleIndex) or 0
  self._selectedBattleIndex = tonumber(selectedBattleIndex) or 0
  self._onPick = onPick
  local labelNode = self.ui.Label_Season or self.ui.Text_Name
  self:SetText(labelNode, self._label)
  local isSel = self._battleIndex == self._selectedBattleIndex
  if labelNode then
    self:SetTextColorType(labelNode, isSel and CommonDefine.ColorType.Light or CommonDefine.ColorType.Dark)
  end
end

function UICompCopyBattleStatisticBattleTypeOption:_OnClick()
  if self._onPick then
    self._onPick(self._battleIndex)
  end
end

return UICompCopyBattleStatisticBattleTypeOption
