_class("UIBuildInfo", UIController)
UIBuildInfo = UIBuildInfo

function UIBuildInfo:LoadDataOnEnter(TT, res, uiParams)
  self._homelandModule = GameGlobal.GetModule(HomelandModule)
end

function UIBuildInfo:OnShow(uiParams)
  self._build = uiParams[1]
  self._nameLabel = self:GetUIComponent("UILocalizationText", "Name")
  self._unLockPanel = self:GetGameObject("UnLockPanel")
  self._conditionLabel = self:GetUIComponent("UILocalizationText", "Condition")
  self._desLabel = self:GetUIComponent("UILocalizationText", "Des")
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._skinItemLoader = self:GetUIComponent("UISelectObjectPath", "Skin")
  self._btnInfo = self:GetGameObject("BtnInfo")
  self._conditionRollingText = self:GetUIComponent("RollingText", "Condition")
  self._currentItem = nil
  self._currentSkin = self._homelandModule:GetCurrentBuildSkin(self._build:GetBuildId(), self._build:GetBuildPstId())
  self:Refresh()
end

function UIBuildInfo:OnHide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.RefreshInteractUI)
end

function UIBuildInfo:SelectItem(currentItem)
  if self._currentItem == currentItem then
    return
  end
  if self._currentItem then
    self._currentItem:SetSelectStatus(false)
  end
  self._currentItem = currentItem
  if self._currentItem then
    self._currentItem:SetSelectStatus(true)
  end
  self._currentSkin = self._currentItem:GetSkinId()
  self:RefreshCurrentSkinInfo()
end

function UIBuildInfo:Refresh()
  self._btnInfo:SetActive(self._build._buildType ~= 502 and self._build._buildType ~= 503)
  self._currentItem = nil
  self:RefreshCurrentSkinInfo()
  local skins = self._homelandModule:GetBuildSkinIds(self._build:GetBuildId())
  self._skinItemLoader:SpawnObjects("UIBuildInfoItem", #skins)
  local items = self._skinItemLoader:GetAllSpawnList()
  for i = 1, #skins do
    items[i]:Refresh(self, self._build, skins[i])
  end
end

function UIBuildInfo:RefreshCurrentSkinInfo()
  local skinId = self._currentSkin
  if skinId <= 0 then
    return
  end
  local cfg = Cfg.cfg_item_architecture_skin[skinId]
  self._nameLabel:SetText(StringTable.Get(cfg.SkinName))
  self._iconLoader:LoadImage(cfg.SkinIcon)
  self._desLabel:SetText(StringTable.Get(cfg.Des))
  if self._homelandModule:HasBuildSkin(skinId) then
    self._unLockPanel:SetActive(false)
  else
    self._unLockPanel:SetActive(true)
    self._conditionRollingText:RefreshText(StringTable.Get(cfg.UnLockCondition, cfg.Level))
    self._conditionLabel:SetText(StringTable.Get(cfg.UnLockCondition, cfg.Level))
  end
end

function UIBuildInfo:BtnReturnOnClick(go)
  self:CloseDialog()
end

function UIBuildInfo:BtnInfoOnClick(go)
  if self._build:GetBuildType() == ArchitectureSubType.Wishing_Pool then
    self:ShowDialog("UIHomeHelpController", "UIBuildWishingPool")
    return
  end
  self:ShowDialog("UIHomeHelpController", "UIBuildInfo")
end
