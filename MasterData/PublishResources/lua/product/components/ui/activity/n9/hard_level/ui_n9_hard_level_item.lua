local N9HardLevelItemState = {
  Normal = 1,
  Lock = 2,
  Pass = 3
}
_enum("N9HardLevelItemState", N9HardLevelItemState)
_class("UIN9HardLevelItem", Object)
UIN9HardLevelItem = UIN9HardLevelItem

function UIN9HardLevelItem:Constructor(uiview)
  self._view = uiview
  self._normal = self._view:GetUIComponent("Image", "normal")
  self._press = self._view:GetUIComponent("Image", "press")
  self._pass = self._view:GetUIComponent("Image", "pass")
  self._way = self._view:GetGameObject("way")
  self._close = self._view:GetUIComponent("Image", "close")
  self._name = self._view:GetUIComponent("UILocalizationText", "name")
  self._nameRoot = self._view:GetGameObject("nameRoot")
  self._eff = self._view:GetGameObject("eff")
  self._animation = self._view:GetUIComponent("Animation", "anim")
  self._localPos = self._view.transform.localPosition:Clone()
end

function UIN9HardLevelItem:OnHide()
  if self._animOpenTimer then
    GameGlobal.Timer():CancelEvent(self._animOpenTimer)
    self._animOpenTimer = nil
  end
  if self._animPassTimer then
    GameGlobal.Timer():CancelEvent(self._animPassTimer)
    self._animPassTimer = nil
  end
end

function UIN9HardLevelItem:SetData(idx, cfg, passInfo, cur, atlas)
  self._isHard = 6 < idx
  local levelCfg = UIN9HardLevel.LevelCfg[idx]
  self._normal.sprite = atlas:GetSprite(levelCfg.normal)
  self._pass.sprite = atlas:GetSprite(levelCfg.close)
  self._close.sprite = atlas:GetSprite(levelCfg.close)
  self._press.sprite = atlas:GetSprite(levelCfg.press)
  if idx < cur then
    if not passInfo then
      Log.exception("没有通关信息：", idx)
    end
    self:SetUiState(N9HardLevelItemState.Pass)
  elseif cur < idx then
    self:SetUiState(N9HardLevelItemState.Lock)
  else
    self:SetUiState(N9HardLevelItemState.Normal)
  end
  local missionCfg = Cfg.cfg_campaign_mission[cfg.CampaignMissionId]
  self._name:SetText(StringTable.Get(missionCfg.Name))
  self._nameRoot:SetActive(true)
end

function UIN9HardLevelItem:SetUiState(uiState)
  self._normal.gameObject:SetActive(false)
  self._pass.gameObject:SetActive(false)
  self._close.gameObject:SetActive(false)
  self._eff:SetActive(false)
  if N9HardLevelItemState.Normal == uiState then
    self._normal.gameObject:SetActive(true)
    self._eff:SetActive(self._isHard)
  elseif N9HardLevelItemState.Lock == uiState then
    self._close.gameObject:SetActive(true)
  elseif N9HardLevelItemState.Pass == uiState then
    self._pass.gameObject:SetActive(true)
  end
end

function UIN9HardLevelItem:LocalPosition()
  return self._localPos
end

function UIN9HardLevelItem:Anim_Pass()
  self._animation:Play("uieff_Hard_Pass")
  self._animPassTimer = GameGlobal.Timer():AddEvent(333, function()
    self:SetUiState(N9HardLevelItemState.Pass)
  end)
end

function UIN9HardLevelItem:Anim_Open()
  self._animation:Play("uieff_Hard_Open")
  self._animOpenTimer = GameGlobal.Timer():AddEvent(500, function()
    self:SetUiState(N9HardLevelItemState.Normal)
  end)
end

function UIN9HardLevelItem:Anim_In()
  self._animation:Play("uieff_Hard_Node_In")
end
