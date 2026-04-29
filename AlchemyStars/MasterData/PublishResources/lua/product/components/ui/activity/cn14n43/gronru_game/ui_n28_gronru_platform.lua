_class("UIN28GronruPlatform", UIController)
UIN28GronruPlatform = UIN28GronruPlatform
local UIN28GronruPlatformType = {
  Album_Page_Empty = 1,
  Album_Page_Game = 2,
  Album_Project_Alarm = 1,
  Album_Project_Adventure = 2,
  Adventure_Steam_Game = 1,
  Adventure_Steam_Community = 2,
  Adventure_Page_Error = 1,
  Adventure_Page_Entrance = 2,
  Adventure_Page_Forum = 3,
  Forum_Comment_Agree = 1,
  Forum_Comment_Disagree = 2,
  Forum_Layout_Short = 1,
  Forum_Layout_Long = 2
}
_enum("UIN28GronruPlatformType", UIN28GronruPlatformType)

function UIN28GronruPlatform:Constructor()
end

function UIN28GronruPlatform:LoadDataOnEnter(TT, res, uiParams)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  local campaignModule = self:GetModule(CampaignModule)
  self._campaignModule = campaignModule
  self._campaign = UIActivityCampaign.New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N28_MINI_GAME, ECampaignN28MiniGameComponentID.ECAMPAIGN_BOUNCE_MISSION)
  self._localProcess = self._campaign:GetLocalProcess()
  if not self._localProcess then
    return
  end
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  self._componentInfo = self._campaign:GetComponentInfo(ECampaignN28MiniGameComponentID.ECAMPAIGN_BOUNCE_MISSION)
  local sample = self._campaign:GetSample()
  self._endTime = sample.end_time
  self._animationPlayIn = false
end

function UIN28GronruPlatform:OnShow(uiParams)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._Refresh)
  self._arrowPage = self:GetUIComponent("Image", "arrowPage")
  self._arrowProject = self:GetUIComponent("Image", "arrowProject")
  self._txtBrowserPage = self:GetUIComponent("UILocalizationText", "txtBrowserPage")
  self._txtBrowserProject = self:GetUIComponent("UILocalizationText", "txtBrowserProject")
  self._uiGameAlbum = self:GetUIComponent("UISelectObjectPath", "uiGameAlbum")
  self._uiGameAdventure = self:GetUIComponent("UISelectObjectPath", "uiGameAdventure")
  self._uiWidgetAlbum = self._uiGameAlbum:SpawnObject("UIN28GronruGameAlbum")
  self._uiWidgetAdventure = self._uiGameAdventure:SpawnObject("UIN28GronruGameAdventure")
  self._animation = self:GetUIComponent("Animation", "animation")
  self._atlas = self:GetAsset("UIN28GronruGame.spriteatlas", LoadType.SpriteAtlas)
  self:AttachEvent(GameEventType.ActivityCloseEvent, self.OnActivityCloseEvent)
  self._animation:Play("UIN28GronruPlatform_in")
  self._animationPlayIn = false
  self:ShowGameAdventure()
  self:ShowGameAlbum()
  local backToAdventure = uiParams[1]
  if backToAdventure then
    self:ShowGameAdventure()
  end
  self.hideCallFun = uiParams[2]
end

function UIN28GronruPlatform:OnHide()
  self:DetachEvent(GameEventType.AfterUILayerChanged, self._Refresh)
  if self.hideCallFun then
    self.hideCallFun()
  end
end

function UIN28GronruPlatform:BtnCloseOnClick(go)
  self:CloseDialog()
end

function UIN28GronruPlatform:BtnReturnOnClick(go)
  if self:CheckActivityOver() then
    return
  end
  self:ShowGameAlbum()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N28BounceFolder)
end

function UIN28GronruPlatform:OnActivityCloseEvent(id)
  self._campaignModule:ShowErrorToast(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED, true)
end

function UIN28GronruPlatform:ShowGameAlbum()
  self._uiGameAlbum:Engine().gameObject:SetActive(true)
  self._uiGameAdventure:Engine().gameObject:SetActive(false)
  self._uiWidgetAlbum = self._uiGameAlbum:SpawnObject("UIN28GronruGameAlbum")
  self._uiWidgetAlbum:Flush()
end

function UIN28GronruPlatform:ShowGameAdventure()
  self._uiGameAlbum:Engine().gameObject:SetActive(false)
  self._uiGameAdventure:Engine().gameObject:SetActive(true)
  self._uiWidgetAdventure = self._uiGameAdventure:SpawnObject("UIN28GronruGameAdventure")
  self._uiWidgetAdventure:Flush()
  self._uiWidgetAdventure:SetCheckActivityOverFun(function()
    return self:CheckActivityOver()
  end)
end

function UIN28GronruPlatform:BrowserPath(isPage, txtPathName)
  if isPage then
    self._arrowPage.gameObject:SetActive(txtPathName ~= nil)
    self._txtBrowserPage.gameObject:SetActive(txtPathName ~= nil)
    if txtPathName ~= nil then
      self._txtBrowserPage:SetText(txtPathName)
    end
  else
    self._arrowProject.gameObject:SetActive(txtPathName ~= nil)
    self._txtBrowserProject.gameObject:SetActive(txtPathName ~= nil)
    if txtPathName ~= nil then
      self._txtBrowserProject:SetText(txtPathName)
    end
  end
end

function UIN28GronruPlatform:GetSpriteAtlas()
  return self._atlas
end

function UIN28GronruPlatform:GetDefaultProject()
  return self._uiWidgetAlbum:GetDefaultProject()
end

function UIN28GronruPlatform:GetMissionComponent()
  return self._localProcess:GetComponent(ECampaignN28MiniGameComponentID.ECAMPAIGN_BOUNCE_MISSION)
end

function UIN28GronruPlatform:PlayAnimation(animName, duration, cbComplete)
  local lockName = "UIN28GronruPlatform:PlayAnimation_" .. animName
  TaskManager:GetInstance():StartTask(function(TT)
    self:Lock(lockName)
    self._animation:Play(animName)
    self._animationPlayIn = true
    YIELD(TT, duration)
    self:UnLock(lockName)
    if cbComplete then
      cbComplete()
    end
  end)
end

function UIN28GronruPlatform:_Refresh(bo)
  local topDepth = GameGlobal.UIStateManager().uiControllerManager:TopDepth()
  if topDepth == self:GetDepth() and self:CheckActivityOver() then
    return
  end
  if topDepth == self:GetDepth() and self._animationPlayIn then
    self._uiWidgetAdventure:Flush()
    self._animation:Play("UIN28GronruPlatform_in")
    self._animationPlayIn = false
  end
end

function UIN28GronruPlatform:CheckActivityOver()
  local closeTime = self._endTime
  local nowtime = self._svrTimeModule:GetServerTime() * 0.001
  if closeTime < nowtime then
    self:CloseDialog()
    return true
  end
  return false
end
