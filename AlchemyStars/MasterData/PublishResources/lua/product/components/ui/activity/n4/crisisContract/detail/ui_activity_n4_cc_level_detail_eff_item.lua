_class("UIActivityN4CCLevelDetailEffItem", UICustomWidget)
UIActivityN4CCLevelDetailEffItem = UIActivityN4CCLevelDetailEffItem

function UIActivityN4CCLevelDetailEffItem:OnShow(uiParams)
  self:InitWidget()
end

function UIActivityN4CCLevelDetailEffItem:InitWidget()
  self.txt = self:GetUIComponent("UILocalizationText", "txt")
  self.imgEmpty = self:GetGameObject("imgEmpty")
  self.imgLock = self:GetGameObject("imgLock")
  self.select = self:GetGameObject("select")
end

function UIActivityN4CCLevelDetailEffItem:SetData(effId, bLock, clickCb)
  self._isLock = bLock ~= nil
  self.clickCb = clickCb
  self.imgLock:SetActive(self._isLock)
  self.imgEmpty:SetActive(effId == nil and not self._isLock)
  self.select:SetActive(effId ~= nil)
  if effId then
    local cfg = Cfg.cfg_affix[effId]
    if cfg then
      local str = UIActivityN4CCHelper.GetAffixDesc(cfg, "ffdf31")
      self.txt:SetText(str)
    end
  end
end

function UIActivityN4CCLevelDetailEffItem:BtnOnClick(go)
  if not self._isLock and self.clickCb then
    self.clickCb()
  end
end
