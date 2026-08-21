_class("UIN31MainEnter", UICustomWidget)
UIN31MainEnter = UIN31MainEnter

function UIN31MainEnter:OnShow(uiParams)
  self._new = self:GetGameObject("new")
  self._red = self:GetGameObject("red")
  self._red = self:GetGameObject("red")
  self._tipspanel1 = self:GetGameObject("tipspanel1")
  self._tipspanel2 = self:GetGameObject("tipspanel2")
  self._tipspanel3 = self:GetGameObject("tipspanel3")
  self._tipspanel1:SetActive(false)
  self._tipspanel2:SetActive(false)
  self._tipspanel3:SetActive(false)
  self._red:SetActive(false)
  self._activityConst = UIActivityCustomConst:New(self:GetCampaignType(), self:GetComponentIds())
  self:RequestCampaign()
  self:AttachEvent(GameEventType.AfterUILayerChanged, self.AfterUILayerChanged)
end

function UIN31MainEnter:OnHide()
  self:DetachEvent(GameEventType.AfterUILayerChanged, self.AfterUILayerChanged)
end

function UIN31MainEnter:GetEntryNewIgnore()
  local componentIds = {}
  componentIds[#componentIds + 1] = ECampaignN31ComponentID.ECAMPAIGN_N31_CUMULATIVE_LOGIN
  componentIds[#componentIds + 1] = ECampaignN31ComponentID.ECAMPAIGN_N31_POWER2ITEM
  componentIds[#componentIds + 1] = ECampaignN31ComponentID.ECAMPAIGN_N31_SHOP
  return componentIds
end

function UIN31MainEnter:GetEntryRedIgnore()
  local componentIds = {}
  componentIds[#componentIds + 1] = ECampaignN31ComponentID.ECAMPAIGN_N31_POWER2ITEM
  return componentIds
end

function UIN31MainEnter:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N31
end

function UIN31MainEnter:GetComponentIds()
  local componentIds = {}
  componentIds[#componentIds + 1] = ECampaignN31ComponentID.ECAMPAIGN_N31_CUMULATIVE_LOGIN
  componentIds[#componentIds + 1] = ECampaignN31ComponentID.ECAMPAIGN_N31_POWER2ITEM
  componentIds[#componentIds + 1] = ECampaignN31ComponentID.ECAMPAIGN_N31_LINE_MISSION
  componentIds[#componentIds + 1] = ECampaignN31ComponentID.ECAMPAIGN_N31_DIFFICULT_MISSION
  componentIds[#componentIds + 1] = ECampaignN31ComponentID.ECAMPAIGN_N31_SHOP
  return componentIds
end

function UIN31MainEnter:SetData_uiMainLobbyController(controller)
  self._uiMainLobbyController = controller
end

function UIN31MainEnter:RequestCampaign()
  self:StartTask(function(TT)
    local lockName = "UIN31MainEnterRequestCampaign"
    self:Lock(lockName)
    local res = AsyncRequestRes:New()
    res:SetSucc(true)
    self._activityConst:LoadData(TT, res)
    self:Flush()
    self:FlushNewRed()
    self:UnLock(lockName)
  end, self)
end

function UIN31MainEnter:Flush()
  self._tipspanel1:SetActive(false)
  self._tipspanel2:SetActive(false)
  self._tipspanel3:SetActive(false)
  local status, time = self._activityConst:GetComponentStatus(ECampaignN31ComponentID.ECAMPAIGN_N31_DIFFICULT_MISSION)
  if status == ActivityComponentStatus.Open then
    self._tipspanel2:SetActive(true)
    return
  end
  status, time = self._activityConst:GetComponentStatus(ECampaignN31ComponentID.ECAMPAIGN_N31_LINE_MISSION)
  if status == ActivityComponentStatus.Open then
    self._tipspanel1:SetActive(true)
    return
  end
end

function UIN31MainEnter:FlushNewRed()
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

function UIN31MainEnter:BtnOnClick(go)
  GameGlobal.TaskManager():StartTask(self.Enter, self)
end

function UIN31MainEnter:Enter(TT)
  self:Lock("UIN31MainEnter_Enter")
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._activityConst:LoadData(TT, res)
  if res and not res:GetSucc() then
    local campModule = GameGlobal.GetModule(CampaignModule)
    campModule:CheckErrorCode(res.m_result, self._activityConst:GetCampaignId(), nil, nil)
    self:UnLock("UIN31MainEnter_Enter")
    return
  end
  if self._uiMainLobbyController then
    self._uiMainLobbyController._screenShot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self._uiMainLobbyController:GetName())
    local rt = self._uiMainLobbyController._screenShot:RefreshBlurTexture()
    local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
    self:StartTask(function(TT)
      YIELD(TT)
      UnityEngine.Graphics.Blit(rt, cache_rt)
      self:SwitchState(UIStateType.UIActivityN31MainController, cache_rt, true)
    end)
  else
    self:SwitchState(UIStateType.UIActivityN31MainController, nil, true)
  end
  self:UnLock("UIN31MainEnter_Enter")
end

function UIN31MainEnter:AfterUILayerChanged()
  self:FlushNewRed()
end
