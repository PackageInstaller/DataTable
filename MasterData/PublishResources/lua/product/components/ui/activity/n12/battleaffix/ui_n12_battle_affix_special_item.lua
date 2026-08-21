_class("UIN12BattleAffixSpecialItem", UICustomWidget)
UIN12BattleAffixSpecialItem = UIN12BattleAffixSpecialItem

function UIN12BattleAffixSpecialItem:OnShow(uiParams)
  self:_GetComponent()
end

function UIN12BattleAffixSpecialItem:_GetComponent()
  self._text = self:GetUIComponent("UILocalizationText", "Text")
end

function UIN12BattleAffixSpecialItem:SetData(levelType, index)
  local str = ""
  if index == 0 then
    str = StringTable.Get("str_n12_challenge_diff")
    if levelType == N12LevelType.Challenge then
      str = str .. StringTable.Get("str_n12_challenge_diff_desc")
    end
  elseif index == 2 then
    str = StringTable.Get("str_n12_affix_effect")
    if levelType == N12LevelType.Challenge then
      str = str .. StringTable.Get("str_n12_affix_effect_desc")
    end
  end
  self._text:SetText(str)
end
