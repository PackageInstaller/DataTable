_class("UISeasonMazeBanPetCellItem", UICustomWidget)
UISeasonMazeBanPetCellItem = UISeasonMazeBanPetCellItem

function UISeasonMazeBanPetCellItem:OnShow()
  self:InitWidget()
end

function UISeasonMazeBanPetCellItem:InitWidget()
  self._seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  self._uiSeasonMazeModule = self._seasonMazeModule.uiModule
  self._infoGen = self:GetUIComponent("UISelectObjectPath", "info")
  self._infoGo = self:GetGameObject("info")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._manualBanLayerGo = self:GetGameObject("ManualBanLayer")
  self._rotateBanLayerGo = self:GetGameObject("RotateBanLayer")
  self._addLayerGo = self:GetGameObject("AddLayer")
  self._lockLayerGo = self:GetGameObject("LockLayer")
  self._disableLayerGo = self:GetGameObject("DisableLayer")
  self._lockText = self:GetUIComponent("UILocalizationText", "LockText")
end

function UISeasonMazeBanPetCellItem:SetData(cellIndex, pet, isManual, isRotate, isLockByBank, unlockBankLevel, isInDiscovery, clickCb)
  self._cellIndex = cellIndex
  self._pet = pet
  self._isManual = isManual
  self._isRotate = isRotate
  self._isLockByBank = isLockByBank
  self._unlockBankLevel = unlockBankLevel
  self._isInDiscovery = isInDiscovery
  self._showAdd = false
  if not self._pet and self._isManual and not self._isLockByBank then
    self._showAdd = true
  end
  self._clickCb = clickCb
  self:Flush()
end

function UISeasonMazeBanPetCellItem:Flush()
  self._infoGo:SetActive(false)
  self._manualBanLayerGo:SetActive(false)
  self._rotateBanLayerGo:SetActive(false)
  self._addLayerGo:SetActive(false)
  self._lockLayerGo:SetActive(false)
  self._disableLayerGo:SetActive(false)
  if self._pet then
    self._infoGo:SetActive(true)
    self._heartItem = self._infoGen:SpawnObject("UISeasonMazeBanPetHeartItem")
    self._heartItem:SetData(self._pet, function(id)
    end, false, false, TeamOpenerType.SeasonMaze, PetSkinEffectPath.CARD_PET_LIST, false, false)
    if self._isManual then
      self._manualBanLayerGo:SetActive(true)
    elseif self._isRotate then
      self._rotateBanLayerGo:SetActive(true)
    end
  elseif self._showAdd then
    self._addLayerGo:SetActive(true)
  elseif self._isLockByBank then
    self._lockLayerGo:SetActive(true)
    self._lockText:SetText(StringTable.Get("str_season_maze_ban_pet_tips2", self._unlockBankLevel))
  end
  if self._isManual and not self._isLockByBank and self._isInDiscovery then
    self._disableLayerGo:SetActive(true)
  end
end

function UISeasonMazeBanPetCellItem:CellBtnOnClick(go)
  if self._clickCb then
    self._clickCb(self._cellIndex)
  end
end

function UISeasonMazeBanPetCellItem:AddLayerOnClick(go)
  if self._clickCb then
    self._clickCb(self._cellIndex)
  end
end
