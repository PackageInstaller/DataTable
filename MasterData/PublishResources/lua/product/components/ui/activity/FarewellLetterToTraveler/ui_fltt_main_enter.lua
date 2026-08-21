_class("UIFLTTMainEnter", UICustomWidget)
UIFLTTMainEnter = UIFLTTMainEnter

function UIFLTTMainEnter:OnShow(uiParams)
  self._activityConst = UIActivityCustomConst:New(self:GetCampaignType(), self:GetComponentIds())
  self:RequestCampaign()
end

function UIFLTTMainEnter:OnHide()
end

function UIFLTTMainEnter:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_FLTT
end

function UIFLTTMainEnter:GetComponentIds()
  local componentIds = {}
  componentIds[#componentIds + 1] = ECampaignFLTTComponentID.ECAMPAIGN_FLTT_LINE_MISSION
  return componentIds
end

function UIFLTTMainEnter:SetData_uiMainLobbyController(controller)
  self._uiMainLobbyController = controller
end

function UIFLTTMainEnter:RequestCampaign()
  self:StartTask(function(TT)
    local lockName = "UIFLTTMainEnterRequestCampaign"
    self:Lock(lockName)
    local res = AsyncRequestRes:New()
    res:SetSucc(true)
    self._activityConst:LoadData(TT, res)
    self:UnLock(lockName)
  end, self)
end

function UIFLTTMainEnter:BtnOnClick(go)
  GameGlobal.TaskManager():StartTask(self.Enter, self)
end

function UIFLTTMainEnter:Enter(TT)
  self:Lock("UIFLTTMainEnter_Enter")
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._activityConst:LoadData(TT, res)
  if res and not res:GetSucc() then
    local campModule = GameGlobal.GetModule(CampaignModule)
    campModule:CheckErrorCode(res.m_result, self._activityConst:GetCampaignId(), nil, nil)
    self:UnLock("UIFLTTMainEnter_Enter")
    return
  end
  if self._uiMainLobbyController then
    self._uiMainLobbyController._screenShot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self._uiMainLobbyController:GetName())
    local rt = self._uiMainLobbyController._screenShot:RefreshBlurTexture()
    local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
    self:StartTask(function(TT)
      YIELD(TT)
      UnityEngine.Graphics.Blit(rt, cache_rt)
      self:SwitchState(UIStateType.UIFLTTMainController, cache_rt, true)
    end)
  else
    self:SwitchState(UIStateType.UIFLTTMainController, nil, true)
  end
  self:UnLock("UIFLTTMainEnter_Enter")
end
