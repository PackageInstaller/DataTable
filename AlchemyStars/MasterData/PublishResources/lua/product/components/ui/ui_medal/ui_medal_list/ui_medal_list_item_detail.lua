_class("UIMedalListItemDetail", UICustomWidget)
UIMedalListItemDetail = UIMedalListItemDetail

function UIMedalListItemDetail:OnShow(uiParams)
  self:InitWidget()
  self._atlas = self:GetAsset("UIMedal.spriteatlas", LoadType.SpriteAtlas)
  self._disCoveryData = GameGlobal.GetModule(MissionModule):GetDiscoveryData()
end

function UIMedalListItemDetail:InitWidget()
  self.medalIcon = self:GetUIComponent("Image", "medalIcon")
  self.medalName = self:GetUIComponent("UILocalizationText", "medalName")
  self.noReceive = self:GetGameObject("noReceive")
  self.txtProgressStatus = self:GetUIComponent("UILocalizationText", "txtProgressStatus")
  self.txUnlockDesc = self:GetUIComponent("UILocalizationText", "txUnlockDesc")
  self.txtProgressDetail = self:GetUIComponent("UILocalizationText", "txtProgressDetail")
  self.progressImageRt = self:GetUIComponent("RectTransform", "progressImage")
  self.txtMedalDesc = self:GetUIComponent("UILocalizationText", "txtMedalDesc")
  self.receiveIcon = self:GetGameObject("receiveIcon")
  self.progress = self:GetGameObject("progress")
  self._ani = self:GetUIComponent("Animation", "_ani")
end

function UIMedalListItemDetail:SetData(itemData)
  local isRecevie = itemData:IsReceive()
  self.noReceive:SetActive(not isRecevie)
  self.receiveIcon:SetActive(isRecevie)
  self.progress:SetActive(false)
  local cfgMedal = itemData:GetTempl()
  local cfgItem = itemData:GetTemplateItem()
  self.medalIcon.sprite = self._atlas:GetSprite(cfgMedal.Icon)
  self.medalIcon:SetNativeSize()
  self.medalName:SetText(StringTable.Get(cfgItem.Name))
  self.txtMedalDesc:SetText(StringTable.Get(cfgItem.RpIntro))
  if isRecevie then
    self.txtProgressStatus:SetText(StringTable.Get("str_medal_unlocked"))
    self.txUnlockDesc:SetText(StringTable.Get(cfgMedal.GetPathDesc))
  elseif itemData:IsFunctionLock() then
    self.txtProgressStatus:SetText(StringTable.Get("str_medal_lock"))
    self.txUnlockDesc:SetText(StringTable.Get(cfgMedal.UnlockDesc))
  else
    self.txtProgressStatus:SetText(StringTable.Get("str_medal_progress"))
    self.txUnlockDesc:SetText(StringTable.Get(cfgMedal.GetPathDesc))
    local showProgress = cfgMedal.IsAutoTake
    self.progress:SetActive(showProgress)
    if showProgress then
      local p, curInfo, totalInfo = itemData:GetProgress()
      self.progressImageRt.localScale = Vector3(p, 1, 1)
      local strTable = {}
      table.insert(strTable, "<color=#ffffff/>")
      table.insert(strTable, curInfo)
      table.insert(strTable, "</color>/")
      table.insert(strTable, totalInfo)
      self.txtProgressDetail:SetText(table.concat(strTable))
    end
  end
  self._ani:Play("uieff_UIMedalListItemDetail_in")
end
