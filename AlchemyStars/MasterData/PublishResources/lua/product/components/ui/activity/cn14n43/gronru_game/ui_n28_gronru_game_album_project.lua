_class("UIN28GronruGameAlbumProject", UICustomWidget)
UIN28GronruGameAlbumProject = UIN28GronruGameAlbumProject

function UIN28GronruGameAlbumProject:Constructor()
end

function UIN28GronruGameAlbumProject:OnShow(uiParams)
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self._txtSubName = self:GetUIComponent("UILocalizationText", "txtSubName")
  self._uiNormal = self:GetUIComponent("Image", "uiNormal")
  self._uiHighlight = self:GetUIComponent("Image", "uiHighlight")
  self._uiRed = self:View():GetUIComponent("UISelectObjectPath", "uiRed")
  self._animation = self:GetUIComponent("Animation", "animation")
end

function UIN28GronruGameAlbumProject:OnHide()
end

function UIN28GronruGameAlbumProject:BtnProjectOnClick(go)
  if self._cfg.OpenType == UIN28GronruPlatformType.Album_Project_Alarm then
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N28BounceEmptyFolder)
  elseif self._cfg.OpenType == UIN28GronruPlatformType.Album_Project_Adventure then
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N28BounceFolder)
  end
  self:StartTask(function(TT)
    self:Lock("UIN28GronruGameAlbumProject:BtnProjectOnClick")
    if self._cfg.OpenType == UIN28GronruPlatformType.Album_Project_Alarm then
      self._animation:Play("UIN28GronruGameAlbumProject_alarm")
      YIELD(TT, 433)
    elseif self._cfg.OpenType == UIN28GronruPlatformType.Album_Project_Adventure then
      self._animation:Play("UIN28GronruGameAlbumProject_click")
      YIELD(TT, 433)
      self:RootUIOwner():ShowGameAdventure()
    end
    self._parent:OpenProject(self._cfg)
    self:RootUIOwner():BrowserPath(false, StringTable.Get(self._cfg.Name))
    self:UnLock("UIN28GronruGameAlbumProject:BtnProjectOnClick")
  end)
end

function UIN28GronruGameAlbumProject:Flush(parent, cfg)
  self._parent = parent
  self._cfg = cfg
  self._txtName:SetText(StringTable.Get(cfg.Name))
  self._txtSubName:SetText(StringTable.Get(cfg.SubName))
  self:ShowRed(false)
  self:SetHighlight(self._cfg.OpenType == UIN28GronruPlatformType.Album_Project_Adventure)
end

function UIN28GronruGameAlbumProject:SetHighlight(inShow)
  self._uiNormal.gameObject:SetActive(not inShow)
  self._uiHighlight.gameObject:SetActive(inShow)
end

function UIN28GronruGameAlbumProject:ShowRed(inShow)
  self._uiRed.gameObject:SetActive(inShow)
  if inShow then
    self._uiRed:SpawnOneObject("ManualLoad0")
  end
end
