_class("UIXH1HardLevelItem", Object)
UIXH1HardLevelItem = UIXH1HardLevelItem

function UIXH1HardLevelItem:Constructor(uiview)
  self._view = uiview
  self._normal = self._view:GetUIComponent("Image", "normal")
  self._pass = self._view:GetGameObject("pass")
  self._way = self._view:GetGameObject("way")
  self._close = self._view:GetUIComponent("Image", "close")
  self._name = self._view:GetUIComponent("UILocalizationText", "name")
  self._nameRoot = self._view:GetGameObject("nameRoot")
  self._animation = self._view:GetUIComponent("Animation", "anim")
  self._localPos = self._view.transform.localPosition:Clone()
end

function UIXH1HardLevelItem:SetData(idx, cfg, passInfo, cur, atlas)
  local levelCfg = UIXH1HardLevel.LevelCfg[idx]
  self._normal.sprite = atlas:GetSprite(levelCfg.normal)
  self._close.sprite = atlas:GetSprite(levelCfg.close)
  if idx < cur then
    if not passInfo then
      Log.exception("没有通关信息：", idx)
    end
    self._normal.gameObject:SetActive(false)
    self._pass:SetActive(true)
    self._close.gameObject:SetActive(false)
    self._way:SetActive(true)
  elseif cur < idx then
    self._normal.gameObject:SetActive(false)
    self._pass:SetActive(false)
    self._close.gameObject:SetActive(true)
    self._way:SetActive(false)
  else
    self._normal.gameObject:SetActive(true)
    self._pass:SetActive(false)
    self._close.gameObject:SetActive(false)
    self._way:SetActive(true)
  end
  local missionCfg = Cfg.cfg_campaign_mission[cfg.CampaignMissionId]
  self._name:SetText(StringTable.Get(missionCfg.Name))
  self._nameRoot:SetActive(idx <= cur)
end

function UIXH1HardLevelItem:LocalPosition()
  return self._localPos
end

function UIXH1HardLevelItem:Anim_Pass()
  self._animation:Play("uieff_Activity_Summer1_Hard_Pass")
end

function UIXH1HardLevelItem:Anim_Open()
  self._animation:Play("uieff_Activity_Summer1_Hard_Open")
end
