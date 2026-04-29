_class("UILuckLandWordItem", UICustomWidget)
UILuckLandWordItem = UILuckLandWordItem

function UILuckLandWordItem:OnShow(uiParams)
  self:_InitWidget()
end

function UILuckLandWordItem:_InitWidget()
  self._desc = self:GetUIComponent("UILocalizationText", "Desc")
end

function UILuckLandWordItem:SetData(index, id)
  self._index = index
  self._wordCfg = Cfg.cfg_luckland_client_word[id]
  self._desc:SetText(StringTable.Get(self._wordCfg.Name))
end
