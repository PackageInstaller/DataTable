local N16HardLevelItemState = {
  Normal = 1,
  Lock = 2,
  Pass = 3
}
_enum("N16HardLevelItemState", N16HardLevelItemState)
_class("UIN16HardLevelItem", Object)
UIN16HardLevelItem = UIN16HardLevelItem

function UIN16HardLevelItem:Constructor(uiview)
  self._view = uiview
  self._normal = self._view:GetUIComponent("Image", "normal")
  self._press = self._view:GetUIComponent("Image", "press")
  self._pass = self._view:GetUIComponent("Image", "pass")
  self._img = self._view:GetUIComponent("Image", "img")
  self._way = self._view:GetGameObject("way")
  self._close = self._view:GetUIComponent("Image", "close")
  self._name = self._view:GetUIComponent("UILocalizationText", "name")
  self._animation = self._view:GetUIComponent("Animation", "anim")
  self._localPos = self._view.transform.localPosition:Clone()
end

function UIN16HardLevelItem:OnHide()
  if self._animOpenTimer then
    GameGlobal.Timer():CancelEvent(self._animOpenTimer)
    self._animOpenTimer = nil
  end
  if self._animPassTimer then
    GameGlobal.Timer():CancelEvent(self._animPassTimer)
    self._animPassTimer = nil
  end
  self._EMIMat = nil
end

function UIN16HardLevelItem:SetData(idx, cfg, passInfo, cur, atlas)
  self._isHard = 6 < idx
  local levelCfg = UIN16HardLevel.LevelCfg[idx]
  self._normal.sprite = atlas:GetSprite(levelCfg.normal)
  self._pass.sprite = atlas:GetSprite(levelCfg.close)
  self._close.sprite = atlas:GetSprite(levelCfg.close)
  self._press.sprite = atlas:GetSprite(levelCfg.press)
  self._img.sprite = atlas:GetSprite(levelCfg.img)
  if idx < cur then
    if not passInfo then
      Log.exception("没有通关信息：", idx)
    end
    self:SetUiState(N16HardLevelItemState.Pass)
  elseif cur < idx then
    self:SetUiState(N16HardLevelItemState.Lock)
  else
    self:SetUiState(N16HardLevelItemState.Normal)
  end
  local missionCfg = Cfg.cfg_campaign_mission[cfg.CampaignMissionId]
  self._name:SetText(StringTable.Get(missionCfg.Name))
end

function UIN16HardLevelItem:SetUiState(uiState)
  self._pass.gameObject:SetActive(false)
  self._close.gameObject:SetActive(false)
  self:SetGray(false, self._normal)
  self:SetGray(false, self._img)
  if N16HardLevelItemState.Normal == uiState then
    self._normal.gameObject:SetActive(true)
  elseif N16HardLevelItemState.Lock == uiState then
    self._close.gameObject:SetActive(true)
    self:SetGray(true, self._normal)
    self:SetGray(true, self._img)
  elseif N16HardLevelItemState.Pass == uiState then
    self._pass.gameObject:SetActive(true)
  end
end

function UIN16HardLevelItem:LocalPosition()
  return self._localPos
end

function UIN16HardLevelItem:Anim_Pass()
  self._animPassTimer = GameGlobal.Timer():AddEvent(333, function()
    self:SetUiState(N16HardLevelItemState.Pass)
  end)
end

function UIN16HardLevelItem:Anim_Open()
  self._animOpenTimer = GameGlobal.Timer():AddEvent(500, function()
    self:SetUiState(N16HardLevelItemState.Normal)
  end)
end

function UIN16HardLevelItem:Anim_In()
end

function UIN16HardLevelItem:SetGray(gray, image)
  self._EMIMat = UnityEngine.Material:New(image.material)
  image.material = self._EMIMat
  if gray then
    image.material:SetFloat("_LuminosityAmount", 1)
  else
    image.material:SetFloat("_LuminosityAmount", 0)
  end
end
