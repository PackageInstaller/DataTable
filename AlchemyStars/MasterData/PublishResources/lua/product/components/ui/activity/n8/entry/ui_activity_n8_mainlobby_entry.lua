_class("UIActivityN8MainLobbyEntry", UICustomWidget)
UIActivityN8MainLobbyEntry = UIActivityN8MainLobbyEntry

function UIActivityN8MainLobbyEntry:OnShow(uiParams)
  self:_AttachEvents()
  self._newdotType = RedDotType.RDT_N8_FUNCTION_NEW
  self._reddotType = RedDotType.RDT_N8_ENTRY_REDDOT
  self:_LoadCampaignInfo(false, ECampaignType.CAMPAIGN_TYPE_N8)
end

function UIActivityN8MainLobbyEntry:OnHide()
  self:_DetachEvents()
end

function UIActivityN8MainLobbyEntry:SetData_uiMainLobbyController(controller)
  self._uiMainLobbyController = controller
end

function UIActivityN8MainLobbyEntry:_LoadCampaignInfo(isLocal, camType)
  self._campaign = UIActivityCampaign:New()
  if isLocal then
    self._campaign:LoadCampaignInfo_Local(camType)
    self:_CheckPoint()
  else
    GameGlobal.TaskManager():StartTask(function(TT)
      local lockName = "UIActivityMainLobbyEntry_LoadCampaignInfo"
      self:Lock(lockName)
      local res = AsyncRequestRes:New()
      self._campaign:LoadCampaignInfo(TT, res, camType)
      self:_CheckPoint()
      self:UnLock(lockName)
    end)
  end
end

function UIActivityN8MainLobbyEntry:EntryBtnOnClick(go)
  if self._uiMainLobbyController then
    self._uiMainLobbyController._screenShot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self._uiMainLobbyController:GetName())
    local rt = self._uiMainLobbyController._screenShot:RefreshBlurTexture()
    local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
    self:StartTask(function(TT)
      YIELD(TT)
      UnityEngine.Graphics.Blit(rt, cache_rt)
      self:SwitchState(UIStateType.UIActivityN8MainController, cache_rt)
    end)
  else
    self:SwitchState(UIStateType.UIActivityN8MainController)
  end
end

function UIActivityN8MainLobbyEntry:_AttachEvents()
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  self:AttachEvent(GameEventType.QuestUpdate, self._OnQuestUpdate)
end

function UIActivityN8MainLobbyEntry:_DetachEvents()
  self:DetachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  self:DetachEvent(GameEventType.QuestUpdate, self._OnQuestUpdate)
end

function UIActivityN8MainLobbyEntry:_OnComponentStepChange(campaign_id, component_id, component_step)
  if self._campaign and self._campaign._id == campaign_id then
    self:_CheckPoint()
  end
end

function UIActivityN8MainLobbyEntry:_OnQuestUpdate()
  self:_CheckPoint()
end

function UIActivityN8MainLobbyEntry:_CheckPoint()
  if self._newdotType or self._reddotType then
    self:_CheckPoint_RedDotModule()
    return
  end
  local newObj = self:GetGameObject("new")
  local redObj = self:GetGameObject("red")
  local new = UIActivityHelper.CheckCampaignSampleNewPoint(self._campaign)
  local red = UIActivityHelper.CheckCampaignSampleRedPoint(self._campaign)
  UIActivityHelper.SetWidgetNewAndRed(newObj, new, redObj, red)
end

function UIActivityN8MainLobbyEntry:_CheckPoint_RedDotModule()
  GameGlobal.TaskManager():StartTask(function(TT)
    local checkList = {}
    checkList[#checkList + 1] = self._newdotType
    checkList[#checkList + 1] = self._reddotType
    local redDotModule = GameGlobal.GetModule(RedDotModule)
    local results = redDotModule:RequestRedDotStatus(TT, checkList)
    local newObj = self:GetGameObject("new")
    local redObj = self:GetGameObject("red")
    local new = results[self._newdotType]
    local red = results[self._reddotType]
    UIActivityHelper.SetWidgetNewAndRed(newObj, new, redObj, red)
  end)
end
