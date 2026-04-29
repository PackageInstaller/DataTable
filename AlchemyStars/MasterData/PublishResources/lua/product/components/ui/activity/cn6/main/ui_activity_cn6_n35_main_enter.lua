_class("UICN6N35MainEnter", UICustomWidget)
UICN6N35MainEnter = UICN6N35MainEnter

function UICN6N35MainEnter:OnShow(uiParams)
  self._new = self:GetGameObject("new")
  self._red = self:GetGameObject("red")
  self._tipspanel1 = self:GetGameObject("tipspanel1")
  self._tipspanel2 = self:GetGameObject("tipspanel2")
  self._tipspanel3 = self:GetGameObject("tipspanel3")
  self._tipspanel1:SetActive(false)
  self._tipspanel2:SetActive(false)
  self._tipspanel3:SetActive(false)
  self._red:SetActive(false)
  self:AttachEvent(GameEventType.OnCN6N35MainQuit, self.FlushNewRed)
  self._activityConst = UIActivityCustomConst:New(self:GetCampaignType(), self:GetComponentIds())
  self:RequestCampaign()
end

function UICN6N35MainEnter:OnHide()
  self:DetachEvent(GameEventType.OnCN6N35MainQuit, self.FlushNewRed)
end

function UICN6N35MainEnter:GetEntryNewIgnore()
  local componentIds = {}
  componentIds[#componentIds + 1] = ECampaignCN6ComponentID.ECAMPAIGN_N6_CUMULATIVE_LOGIN
  componentIds[#componentIds + 1] = ECampaignCN6ComponentID.ECAMPAIGN_N6_LINE_MISSION
  componentIds[#componentIds + 1] = ECampaignCN6ComponentID.ECAMPAIGN_N6_PERSON_PROCESS
  return componentIds
end

function UICN6N35MainEnter:GetEntryRedIgnore()
  local componentIds = {}
  componentIds[#componentIds + 1] = ECampaignCN6ComponentID.ECAMPAIGN_N6_HEIXIA
  return componentIds
end

function UICN6N35MainEnter:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_INLAND_N6
end

function UICN6N35MainEnter:GetComponentIds()
  local componentIds = {}
  componentIds[#componentIds + 1] = ECampaignCN6ComponentID.ECAMPAIGN_N6_CUMULATIVE_LOGIN
  componentIds[#componentIds + 1] = ECampaignCN6ComponentID.ECAMPAIGN_N6_SHOP
  componentIds[#componentIds + 1] = ECampaignCN6ComponentID.ECAMPAIGN_N6_LINE_MISSION
  componentIds[#componentIds + 1] = ECampaignCN6ComponentID.ECAMPAIGN_N6_DIFFICULT_MISSION
  componentIds[#componentIds + 1] = ECampaignCN6ComponentID.ECAMPAIGN_N6_SMELTITEM
  componentIds[#componentIds + 1] = ECampaignCN6ComponentID.ECAMPAIGN_N6_PERSON_PROCESS
  componentIds[#componentIds + 1] = ECampaignCN6ComponentID.ECAMPAIGN_N6_HEIXIA
  return componentIds
end

function UICN6N35MainEnter:SetData(sampleInfo, controller)
  local sampleInfo = sampleInfo
  self:SetData_uiMainLobbyController(controller)
end

function UICN6N35MainEnter:SetData_uiMainLobbyController(controller)
  self._uiMainLobbyController = controller
end

function UICN6N35MainEnter:RequestCampaign()
  self:StartTask(function(TT)
    local lockName = "UICN6N35MainEnterRequestCampaign"
    self:Lock(lockName)
    local res = AsyncRequestRes:New()
    res:SetSucc(true)
    self._activityConst:LoadData(TT, res)
    self:Flush()
    self:FlushNewRed()
    self:UnLock(lockName)
  end, self)
end

function UICN6N35MainEnter:Flush()
  self._tipspanel1:SetActive(false)
  self._tipspanel2:SetActive(false)
  self._tipspanel3:SetActive(false)
  local status, time
  status, time = self._activityConst:GetComponentStatus(ECampaignCN6ComponentID.ECAMPAIGN_N6_HEIXIA)
  if status == ActivityComponentStatus.Open then
    self._tipspanel3:SetActive(true)
    return
  end
  status, time = self._activityConst:GetComponentStatus(ECampaignCN6ComponentID.ECAMPAIGN_N6_DIFFICULT_MISSION)
  if status == ActivityComponentStatus.Open then
    self._tipspanel2:SetActive(true)
    return
  end
  status, time = self._activityConst:GetComponentStatus(ECampaignCN6ComponentID.ECAMPAIGN_N6_SHOP)
  if status == ActivityComponentStatus.Open then
    self._tipspanel1:SetActive(true)
    return
  end
end

function UICN6N35MainEnter:FlushNewRed()
  self._new:SetActive(false)
  self._red:SetActive(false)
  if self._activityConst:IsShowEntryNew(self:GetEntryNewIgnore()) then
    self._new:SetActive(true)
    return
  end
  if self._activityConst:IsShowEntryRed(self:GetEntryRedIgnore()) then
    self._red:SetActive(true)
  end
end

function UICN6N35MainEnter:BtnOnClick(go)
  GameGlobal.TaskManager():StartTask(self.Enter, self)
end

function UICN6N35MainEnter:Enter(TT)
  self:Lock("UICN6N35MainEnter_Enter")
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._activityConst:LoadData(TT, res)
  if res and not res:GetSucc() then
    local campModule = GameGlobal.GetModule(CampaignModule)
    campModule:CheckErrorCode(res.m_result, self._activityConst:GetCampaignId(), nil, nil)
    self:UnLock("UICN6N35MainEnter_Enter")
    return
  end
  if self._uiMainLobbyController then
    self._uiMainLobbyController._screenShot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self._uiMainLobbyController:GetName())
    local rt = self._uiMainLobbyController._screenShot:RefreshBlurTexture()
    local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
    self:StartTask(function(TT)
      YIELD(TT)
      UnityEngine.Graphics.Blit(rt, cache_rt)
      self:ShowDialog("UIActivityCN6N35MainController", cache_rt, true)
    end)
  else
    self:ShowDialog("UIActivityCN6N35MainController", nil, true)
  end
  self:UnLock("UICN6N35MainEnter_Enter")
end
