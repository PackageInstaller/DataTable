_class("UIN38HardLevelItem", UICustomWidget)
UIN38HardLevelItem = UIN38HardLevelItem

function UIN38HardLevelItem:Constructor(uiview)
  self._view = uiview
  self:OnShow()
end

function UIN38HardLevelItem:OnShow()
  self._normal = self._view:GetUIComponent("Image", "normal")
  self._pass = self._view:GetUIComponent("Image", "pass")
  self._close = self._view:GetUIComponent("Image", "close")
  self._name = self._view:GetUIComponent("UILocalizationText", "name")
  self._titleBg = self._view:GetUIComponent("Image", "TitleBg")
  self._lockimg = self._view:GetUIComponent("Image", "lockimg")
  self._hadimg = self._view:GetUIComponent("Image", "hadimg")
  self._progressValue = self._view:GetUIComponent("UILocalizationText", "ProgressValue")
end

function UIN38HardLevelItem:SetData(isBlack, index, cfg, componentInfo, atlas, data)
  self._isBlack = isBlack
  self._index = index
  self._cfg = cfg
  self._componentInfo = componentInfo
  self._atlas = atlas
  self._isUnlock = false
  if self._isBlack then
    local cupDatas = data:GetCupDatas()
    local completeCupCount = data:GetCompleteCupCount()
    self._progressValue:SetText(completeCupCount .. "/" .. #cupDatas)
    local passInfo = self._componentInfo.infos
    if passInfo[cfg.CampaignMissionId] then
      self._isUnlock = true
      self._pass.gameObject:SetActive(completeCupCount == #cupDatas)
      self._close.gameObject:SetActive(false)
    elseif self._cfg.NeedMissionId == 0 or self._cfg.NeedMissionId > 0 and passInfo[self._cfg.NeedMissionId] then
      self._isUnlock = true
      self._normal.gameObject:SetActive(true)
      self._pass.gameObject:SetActive(false)
      self._close.gameObject:SetActive(false)
    else
      self._pass.gameObject:SetActive(false)
      self._close.gameObject:SetActive(true)
    end
    local missionCfg = Cfg.cfg_difficulty_parent_mission[cfg.CampaignMissionId]
    self._name:SetText(StringTable.Get(missionCfg.Name))
  else
    local passInfo = self._componentInfo.m_pass_mission_info
    if passInfo[cfg.CampaignMissionId] then
      self._pass.gameObject:SetActive(true)
      self._close.gameObject:SetActive(false)
    elseif cfg.NeedMissionId == 0 or cfg.NeedMissionId > 0 and passInfo[cfg.NeedMissionId] then
      self._normal.gameObject:SetActive(true)
      self._pass.gameObject:SetActive(false)
      self._close.gameObject:SetActive(false)
    else
      self._pass.gameObject:SetActive(false)
      self._close.gameObject:SetActive(true)
    end
    local missionCfg = Cfg.cfg_campaign_mission[cfg.CampaignMissionId]
    self._name:SetText(StringTable.Get(missionCfg.Name))
  end
end

function UIN38HardLevelItem:IsUnlock()
  return self._isUnlock
end
