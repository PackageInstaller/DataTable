_class("UIBuildInfoItem", UICustomWidget)
UIBuildInfoItem = UIBuildInfoItem

function UIBuildInfoItem:OnShow(uiParams)
  self._homelandModule = GameGlobal.GetModule(HomelandModule)
  self._selectedGo = self:GetGameObject("Selected")
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._nameLabel = self:GetUIComponent("UILocalizationText", "Name")
  self._redGo = self:GetGameObject("Red")
  self._btnUseGo = self:GetGameObject("BtnUse")
  self._btnUseingGo = self:GetGameObject("BtnUseing")
  self._btnUnGetGo = self:GetGameObject("BtnUnGet")
  self._btnUnGetImg = self:GetUIComponent("RawImage", "BtnUnGet")
  self._EMIMat = UnityEngine.Material:New(self._btnUnGetImg.material)
  local texture = self._btnUnGetImg.material.mainTexture
  self._btnUnGetImg.material = self._EMIMat
  self._btnUnGetImg.material.mainTexture = texture
  self._btnUnGetImg.material:SetFloat("_LuminosityAmount", 1)
  self._btnUnGetGo:SetActive(false)
  self._btnUnGetGo:SetActive(true)
end

function UIBuildInfoItem:OnHide()
  self._EMIMat = nil
end

function UIBuildInfoItem:GetSkinId()
  return self._skinId
end

function UIBuildInfoItem:Refresh(buildInfo, build, skinId)
  self._skinId = skinId
  self._build = build
  self._buildId = self._build:GetBuildId()
  self._buildPstId = self._build:GetBuildPstId()
  self._buildInfo = buildInfo
  self._hasSkin = self._homelandModule:HasBuildSkin(self._skinId)
  local cfg = Cfg.cfg_item_architecture_skin[self._skinId]
  self._selectedGo:SetActive(false)
  self._iconLoader:LoadImage(cfg.SkinIcon)
  self._nameLabel:SetText(StringTable.Get(cfg.SkinName))
  self:RefreshRedStatus()
  self:RefreshBtnStatus()
  self._level = cfg.Level
  self._useConditionDes = StringTable.Get(cfg.UseCondition)
end

function UIBuildInfoItem:RefreshRedStatus()
  if self._hasSkin then
    self._redGo:SetActive(self._homelandModule:HasSkinRedPointBySkinId(self._skinId))
  else
    self._redGo:SetActive(false)
  end
end

function UIBuildInfoItem:RefreshBtnStatus()
  self._btnUnGetGo:SetActive(false)
  self._btnUseingGo:SetActive(false)
  self._btnUseGo:SetActive(false)
  local currentSkinId = self._homelandModule:GetCurrentBuildSkin(self._buildId, self._buildPstId)
  if self._hasSkin then
    if currentSkinId == self._skinId then
      self._btnUseingGo:SetActive(true)
    else
      self._btnUseGo:SetActive(true)
    end
  else
    self._btnUnGetGo:SetActive(true)
  end
end

function UIBuildInfoItem:SetSelectStatus(status)
  self._selectedGo:SetActive(status)
end

function UIBuildInfoItem:SetRedNewStatus()
  local redStatus = self._homelandModule:HasSkinRedPointBySkinId(self._skinId)
  if redStatus then
    GameGlobal.TaskManager():StartTask(function(TT)
      self._homelandModule:SetSkinRedPointStatus(TT, self._skinId)
    end)
  end
end

function UIBuildInfoItem:BtnOnClick()
  self:SetRedNewStatus()
  self._redGo:SetActive(false)
  self._buildInfo:SelectItem(self)
end

function UIBuildInfoItem:BtnUseOnClick()
  GameGlobal.TaskManager():StartTask(self.UseSkinCoro, self)
end

function UIBuildInfoItem:UseSkinCoro(TT)
  local homeLandLevel = self._homelandModule:GetHomelandLevel()
  if homeLandLevel < self._level then
    ToastManager.ShowToast(self._useConditionDes)
    return
  end
  self:Lock("UIBuildInfoItem_UseSkinCoro")
  local ret = self._homelandModule:SetCurrentBuildSkin(TT, self._buildPstId, self._skinId)
  if ret:GetSucc() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ResetOneBuilding, self._build:GetBuildPstId(), true)
    self._buildInfo:Refresh()
    self:BtnOnClick()
  else
    Log.error("change build skin failed ", ret:GetResult())
  end
  self:UnLock("UIBuildInfoItem_UseSkinCoro")
end

function UIBuildInfoItem:BtnUnGetOnClick()
  self:ShowDialog("UIBuildSkinTips", self._skinId)
end
