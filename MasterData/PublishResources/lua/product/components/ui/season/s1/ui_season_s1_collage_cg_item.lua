_class("UISeasonS1CollageCGItem", UICustomWidget)
UISeasonS1CollageCGItem = UISeasonS1CollageCGItem

function UISeasonS1CollageCGItem:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonS1CollageCGItem:InitWidget()
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.cgName = self:GetUIComponent("RollingText", "cgName")
  self.unlock = self:GetGameObject("Unlock")
  self.lock = self:GetGameObject("Lock")
  self.condition = self:GetUIComponent("RollingText", "condition")
  self.new = self:GetGameObject("new")
  self._share = self:GetGameObject("Share")
  self._shareAward = self:GetUIComponent("UILocalizationText", "ShareAward")
  self._anim = self:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
end

function UISeasonS1CollageCGItem:SetData(data, onClick)
  self._data = data
  self._onClick = onClick
  if not self._data:IsValid() then
    Log.exception("cg未到解锁时间无法显示:", self._data:ID())
  end
  self:SetNew(self._data:IsNew())
  local cfg = Cfg.cfg_cg_book[self._data:ID()]
  if self._data:IsUnlock() then
    self.unlock:SetActive(true)
    self.lock:SetActive(false)
    self.icon:LoadImage(cfg.SeasonPreview)
    self.cgName:RefreshText(StringTable.Get(cfg.PreviewTitle))
  else
    self.unlock:SetActive(false)
    self.lock:SetActive(true)
    self.condition:RefreshText(StringTable.Get(cfg.UnLockDes))
  end
  self:ResetShareState()
end

function UISeasonS1CollageCGItem:SetNew(new)
  self.new:SetActive(new)
end

function UISeasonS1CollageCGItem:RootOnClick(go)
  self._onClick(self._data)
end

function UISeasonS1CollageCGItem:ResetShareState()
  self._share:SetActive(self._data:CanShare())
  if self._data:CanShare() then
    self._shareAward:SetText(StringTable.Get("str_season_share_award_tip", self._data:ShareAwardCount()))
  end
end

function UISeasonS1CollageCGItem:PlayExitAnim()
  self._anim:Play("uieffanim_UISeasonS1CollageCGItem_out")
end
