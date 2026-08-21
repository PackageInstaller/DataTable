_class("UIActiveVarInfo", UIController)
UIActiveVarInfo = UIActiveVarInfo

function UIActiveVarInfo:Constructor()
end

function UIActiveVarInfo:OnShow(uiParams)
  local posSource = uiParams[1]
  local forceTipsStr = uiParams[2]
  local pos = posSource + Vector3(0, 5, 0)
  local tr = self:GetUIComponent("RectTransform", "tr")
  tr.position = pos
  self._text = self:GetUIComponent("UILocalizationText", "txt")
  if self._text then
    if forceTipsStr then
      self._text:SetText(StringTable.Get(forceTipsStr))
    else
      self._text:SetText(StringTable.Get("str_battle_bianti_info"))
    end
  end
end

function UIActiveVarInfo:BgOnClick(go)
  self:CloseDialog()
end
