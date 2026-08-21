_class("UITreasureBoard", UIController)
UITreasureBoard = UITreasureBoard

function UITreasureBoard:Constructor()
end

function UITreasureBoard:OnShow(uiParams)
  local tipsid = uiParams[1]
  local cfg = Cfg.cfg_homeland_treasure_board_tips[tipsid]
  local txt = StringTable.Get(cfg.Text)
  self._txtInfo = self:GetUIComponent("UILocalizationText", "info")
  self._txtInfo:SetText(txt)
end

function UITreasureBoard:CloseOnClick()
  self:CloseDialog()
end
