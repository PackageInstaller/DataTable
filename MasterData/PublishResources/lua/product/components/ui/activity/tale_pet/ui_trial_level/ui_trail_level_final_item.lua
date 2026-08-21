_class("UITrailLevelFinalItem", UICustomWidget)
UITrailLevelFinalItem = UITrailLevelFinalItem

function UITrailLevelFinalItem:OnShow()
  self._nameLabel = self:GetUIComponent("UILocalizationText", "Name")
  self._nameBgLabel = self:GetUIComponent("UILocalizationText", "NameBg")
  self._bossBgLabel = self:GetUIComponent("UILocalizationText", "BossBg")
  self._bossLabel = self:GetUIComponent("UILocalizationText", "Boss")
  self._statusGo = self:GetGameObject("Status")
  self._go = self:GetGameObject("Go")
  self._redGo = self:GetGameObject("Red")
end

function UITrailLevelFinalItem:Refresh(levelData)
  if levelData == nil then
    self._go:SetActive(false)
    return
  end
  self._go:SetActive(true)
  self._levelData = levelData
  self._nameLabel:SetText(self._levelData:GetName())
  self._nameBgLabel:SetText(self._levelData:GetName())
  self._levelId = self._levelData:GetId()
  local cfg = Cfg.cfg_tale_stage[self._levelId]
  self._bossLabel:SetText(StringTable.Get(cfg.MonsterName))
  self._bossBgLabel:SetText(StringTable.Get(cfg.MonsterName))
  self._statusGo:SetActive(false)
  self._redGo:SetActive(false)
  if self:IsLock() then
  elseif self._levelData:IsComplete() then
    self._statusGo:SetActive(true)
  else
    self._redGo:SetActive(true)
  end
end

function UITrailLevelFinalItem:BgOnClick()
  if self:IsLock() then
    ToastManager.ShowToast(StringTable.Get("str_tale_pet_trail_level_level_un_open"))
    return
  end
  self:ShowDialog("UITrailLevelDetail", self._levelData:GetId())
end

function UITrailLevelFinalItem:IsLock()
  local talePetModule = GameGlobal.GetModule(TalePetModule)
  return not talePetModule:HasOpenFinalLevel()
end
