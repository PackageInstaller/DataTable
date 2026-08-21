_class("UIN34MainEnter", UICustomWidget)
UIN34MainEnter = UIN34MainEnter

function UIN34MainEnter:OnShow(uiParams)
  self._new = self:GetGameObject("new")
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
end

function UIN34MainEnter:OnHide()
end

function UIN34MainEnter:GetEntryNewIgnore()
  local componentIds = {}
  componentIds[#componentIds + 1] = ECampaignN34ComponentID.ECAMPAIGN_N34_CUMULATIVE_LOGIN
  componentIds[#componentIds + 1] = ECampaignN34ComponentID.ECAMPAIGN_N34_POWER2ITEM
  componentIds[#componentIds + 1] = ECampaignN34ComponentID.ECAMPAIGN_N34_QUEST
  return componentIds
end

function UIN34MainEnter:GetEntryRedIgnore()
  local componentIds = {}
  return componentIds
end

function UIN34MainEnter:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N34
end

function UIN34MainEnter:GetComponentIds()
  local componentIds = {}
  componentIds[#componentIds + 1] = ECampaignN34ComponentID.ECAMPAIGN_N34_CUMULATIVE_LOGIN
  componentIds[#componentIds + 1] = ECampaignN34ComponentID.ECAMPAIGN_N34_POWER2ITEM
  componentIds[#componentIds + 1] = ECampaignN34ComponentID.ECAMPAIGN_N34_SURVEY
  componentIds[#componentIds + 1] = ECampaignN34ComponentID.ECAMPAIGN_N34_DISPATCH
  componentIds[#componentIds + 1] = ECampaignN34ComponentID.ECAMPAIGN_N34_QUEST
  return componentIds
end

function UIN34MainEnter:SetData_uiMainLobbyController(controller)
  self._uiMainLobbyController = controller
end

function UIN34MainEnter:RequestCampaign()
  self:StartTask(function(TT)
    local lockName = "UIN34MainEnterRequestCampaign"
    self:Lock(lockName)
    local res = AsyncRequestRes:New()
    res:SetSucc(true)
    self._activityConst:LoadData(TT, res)
    self:Flush()
    self:FlushNewRed()
    self:UnLock(lockName)
  end, self)
end

function UIN34MainEnter:Flush()
  self._tipspanel1:SetActive(false)
  self._tipspanel2:SetActive(false)
  self._tipspanel3:SetActive(false)
  local status, time = self._activityConst:GetComponentStatus(ECampaignN34ComponentID.ECAMPAIGN_N34_SURVEY)
  if status == ActivityComponentStatus.Open then
    self._tipspanel1:SetActive(true)
  end
  status, time = self._activityConst:GetComponentStatus(ECampaignN34ComponentID.ECAMPAIGN_N34_DISPATCH)
  if status == ActivityComponentStatus.Open then
    self._tipspanel2:SetActive(true)
    return
  end
end

function UIN34MainEnter:FlushNewRed()
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

function UIN34MainEnter:BtnOnClick(go)
  GameGlobal.TaskManager():StartTask(self.Enter, self)
end

function UIN34MainEnter:Enter(TT)
  self:Lock("UIN34MainEnter_Enter")
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._activityConst:LoadData(TT, res)
  if res and not res:GetSucc() then
    local campModule = GameGlobal.GetModule(CampaignModule)
    campModule:CheckErrorCode(res.m_result, self._activityConst:GetCampaignId(), nil, nil)
    self:UnLock("UIN34MainEnter_Enter")
    return
  end
  if self._uiMainLobbyController then
    self._uiMainLobbyController._screenShot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self._uiMainLobbyController:GetName())
    local rt = self._uiMainLobbyController._screenShot:RefreshBlurTexture()
    local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
    self:StartTask(function(TT)
      YIELD(TT)
      UnityEngine.Graphics.Blit(rt, cache_rt)
      self:SwitchState(UIStateType.UIActivityN34MainController, cache_rt, true)
    end)
  else
    self:SwitchState(UIStateType.UIActivityN34MainController, nil, true)
  end
  self:UnLock("UIN34MainEnter_Enter")
end
