_class("UINP6LobbyEntry", UICustomWidget)
UINP6LobbyEntry = UINP6LobbyEntry

function UINP6LobbyEntry:OnShow(uiParams)
  self:InitWidget()
  local playerID = GameGlobal.GameLogic():GetOpenId()
  self._localkey = "UINP6LobbyEntry_" .. playerID
  self._isNew = LocalDB.GetInt(self._localkey, 0) ~= 1
  if self._isNew then
    self.new:SetActive(true)
    self.red:SetActive(false)
  else
    self.new:SetActive(false)
    self:StartTask(self.SetRed, self)
  end
end

function UINP6LobbyEntry:InitWidget()
  self.new = self:GetGameObject("new")
  self.red = self:GetGameObject("red")
end

function UINP6LobbyEntry:SetData()
end

function UINP6LobbyEntry:clickAreaOnClick(go)
  if self._isNew then
    LocalDB.SetInt(self._localkey, 1)
  end
  self:Shot(function(rt)
    self:SwitchState(UIStateType.UIActivityN6, rt)
  end)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N6Switch)
end

function UINP6LobbyEntry:Dispose()
  if self._shot then
    self._shot:CleanRenderTexture()
    self._shot = nil
  end
  UINP6LobbyEntry.super:Dispose()
end

function UINP6LobbyEntry:Shot(callback)
  self._shot = self:GetUIComponent("H3DUIBlurHelper", "screenShot")
  self._shot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera("UIMainLobbyController")
  local shotRect = self:GetUIComponent("RectTransform", "screenShot")
  self._shot.width = shotRect.rect.width
  self._shot.height = shotRect.rect.height
  self._shot.blurTimes = 0
  self._shot:CleanRenderTexture()
  self._rt = self._shot:RefreshBlurTexture()
  local cacheRt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
  local rt = self._shot:RefreshBlurTexture()
  self:StartTask(function(TT)
    self:Lock("UINP6LobbyEntry_Shot")
    YIELD(TT)
    UnityEngine.Graphics.Blit(rt, cacheRt)
    if callback then
      callback(cacheRt)
    end
    self:UnLock("UINP6LobbyEntry_Shot")
  end)
end

function UINP6LobbyEntry:SetRed(TT)
  self.red:SetActive(false)
  local module = self:GetModule(CampaignModule)
  local res = AsyncRequestRes:New()
  if not self._battlepassCampaign then
    self._battlepassCampaign = UIActivityCampaign:New()
    self._battlepassCampaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_BATTLEPASS)
  end
  if UIActivityHelper.CheckCampaignSampleRedPoint(self._battlepassCampaign) then
    self.red:SetActive(true)
    return
  end
  if not self._np6 then
    self._np6 = UIActivityCampaign:New()
    self._np6:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_HALLOWEEN, ECampaignN6ComponentID.ECAMPAIGN_N6_QUEST, ECampaignN6ComponentID.ECAMPAIGN_N6_CUMULATIVE_LOGIN, ECampaignN6ComponentID.ECAMPAIGN_N6_LINE_MISSION, ECampaignN6ComponentID.ECAMPAIGN_N6_LINE_MISSION_FIXTEAM, ECampaignN6ComponentID.ECAMPAIGN_N6_STORY)
  end
  local red = self._np6:CheckComponentRed(ECampaignN6ComponentID.ECAMPAIGN_N6_BUILD, ECampaignN6ComponentID.ECAMPAIGN_N6_QUEST, ECampaignN6ComponentID.ECAMPAIGN_N6_CUMULATIVE_LOGIN, ECampaignN6ComponentID.ECAMPAIGN_N6_LINE_MISSION_FIXTEAM, ECampaignN6ComponentID.ECAMPAIGN_N6_STORY)
  if red then
    self.red:SetActive(true)
    return
  end
end
