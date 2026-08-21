_class("UITacticDiffBtn", UICustomWidget)
UITacticDiffBtn = UITacticDiffBtn

function UITacticDiffBtn:OnShow(uiParams)
  self:InitWidget()
end

function UITacticDiffBtn:InitWidget()
  self.text = self:GetUIComponent("UILocalizationText", "Text")
  self.btn = self:GetUIComponent("Button", "btn")
end

function UITacticDiffBtn:SetData(diff, onSelect)
  local texts = {
    "str_aircraft_tactic_difficulty1",
    "str_aircraft_tactic_difficulty2",
    "str_aircraft_tactic_difficulty3"
  }
  self.text:SetText(StringTable.Get(texts[diff]))
  self._onClick = onSelect
  self._diff = diff
  self:OnSelect(false)
end

function UITacticDiffBtn:OnSelect(select)
  self.btn.interactable = select
  if select then
    self.text.color = Color.black
  else
    self.text.color = Color(0.5529411764705883, 0.5725490196078431, 0.611764705882353)
  end
end

function UITacticDiffBtn:btnOnClick()
  self._onClick(self._diff)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N8DefaultClick)
end
