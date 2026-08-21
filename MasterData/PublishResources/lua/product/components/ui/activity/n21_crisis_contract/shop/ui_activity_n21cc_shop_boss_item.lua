_class("UIActivityN21CCShopBossItem", UICustomWidget)
UIActivityN21CCShopBossItem = UIActivityN21CCShopBossItem

function UIActivityN21CCShopBossItem:OnShow()
  self._nameLabel = self:GetUIComponent("UILocalizationText", "Name")
  self._scoreLabel = self:GetUIComponent("UILocalizationText", "Score")
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._lock = self:GetGameObject("Lock")
  self._selected = self:GetGameObject("Selected")
  self._scoreIcon = self:GetGameObject("ScoreIcon")
  self._name = self:GetGameObject("Name")
  self._score = self:GetGameObject("Score")
  self._go = self:GetGameObject()
end

function UIActivityN21CCShopBossItem:OnHide()
end

function UIActivityN21CCShopBossItem:Refresh(bossData, callback)
  if bossData == nil then
    self._go:SetActive(false)
    return
  end
  self._go:SetActive(true)
  self._bossData = bossData
  self._callback = callback
  if bossData:IsOpen() then
    self._scoreIcon:SetActive(true)
    self._name:SetActive(true)
    self._score:SetActive(true)
    self._iconLoader:LoadImage(bossData:GetBossSmallIcon())
    self._scoreLabel:SetText(bossData:GetTotalScore())
    self._nameLabel:SetText(bossData:GetBossName())
    self._lock:SetActive(false)
  else
    self._scoreIcon:SetActive(false)
    self._name:SetActive(false)
    self._score:SetActive(false)
    self._lock:SetActive(true)
    self._iconLoader:LoadImage("n21_wjyz_lb_di07")
  end
  self:SetSelectStatus(false)
end

function UIActivityN21CCShopBossItem:GetBossData()
  return self._bossData
end

function UIActivityN21CCShopBossItem:SetSelectStatus(status)
  self._selected:SetActive(status)
end

function UIActivityN21CCShopBossItem:BtnOnClick()
  if not self._bossData then
    return
  end
  if not self._bossData:IsOpen() then
    ToastManager.ShowToast(StringTable.Get("str_n20_crisis_contract_boss_item_lock_tips"))
    return
  end
  if self._callback then
    self._callback(self)
  end
end
