_class("UIEliminateLevelIntroItem", UICustomWidget)
UIEliminateLevelIntroItem = UIEliminateLevelIntroItem

function UIEliminateLevelIntroItem:Constructor()
end

function UIEliminateLevelIntroItem:OnShow(uiParams)
  self:_GetComponents()
end

function UIEliminateLevelIntroItem:_GetComponents()
  self._introTxt = self:GetUIComponent("UILocalizationText", "introTxt")
end

function UIEliminateLevelIntroItem:SetData(wordID)
  local wordCfg = Cfg.cfg_word_buff[wordID]
  self._introTxt:SetText(StringTable.Get(wordCfg.Desc))
end
