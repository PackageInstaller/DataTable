_class("UIActivityGraveRobberMainController", UIController)
UIActivityGraveRobberMainController = UIActivityGraveRobberMainController

function UIActivityGraveRobberMainController:_GetLineMissionComponent()
  local cmptId = ECampaignGrassComponentID.ECAMPAIGN_GRASS_MISSION
  return self._campaign:GetComponent(cmptId)
end

function UIActivityGraveRobberMainController:_GetLineMissionComponentInfo()
  local cmptId = ECampaignGrassComponentID.ECAMPAIGN_GRASS_MISSION
  return self._campaign:GetComponentInfo(cmptId)
end

function UIActivityGraveRobberMainController:_GetComponents()
  self._GoBtn = self:GetGameObject("GoBtn")
  self._StayBtn = self:GetGameObject("StayBtn")
end

function UIActivityGraveRobberMainController:LoadDataOnEnter(TT, res, uiParams)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_GRASS, ECampaignGrassComponentID.ECAMPAIGN_GRASS_MISSION)
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  self._campaign:ClearCampaignNew(TT)
end

function UIActivityGraveRobberMainController:OnShow(uiParams)
  self:_AttachEvents()
  self._isOpen = true
  self:_GetComponents()
  self:_SetRemainingTime()
  self:_SetProgress()
  self:_SetRewardPool()
  self:_SetGoBtn()
  self:_CheckRedPointAll()
end

function UIActivityGraveRobberMainController:OnHide()
  self:_DetachEvents()
  self._isOpen = false
end

function UIActivityGraveRobberMainController:_SetBg(idx)
  local url = UIActivityHelper.GetCampaignMainBg(self._campaign, idx)
  self:GetGameObject("mainBg"):SetActive(url ~= nil)
  if url then
    local mainBg = self:GetUIComponent("RawImageLoader", "mainBg")
    mainBg:LoadImage(url)
  end
end

function UIActivityGraveRobberMainController:_SetRemainingTime()
  local componentInfo = self:_GetLineMissionComponentInfo()
  local remainingTimePool = self:GetUIComponent("UISelectObjectPath", "RemainingTimePool")
  self._remainingTime = remainingTimePool:SpawnObject("UIActivityCommonRemainingTime")
  self._remainingTime:SetCustomTimeStr({
    day = "str_activity_common_day",
    hour = "str_activity_common_hour",
    min = "str_activity_common_minute",
    zero = "str_activity_grass_escape_after_lt_m",
    over = "str_activity_grass_escape_after_lt_m"
  })
  local endTime = componentInfo.m_close_time
  self._remainingTime:SetData(endTime, nil, nil)
end

function UIActivityGraveRobberMainController:_SetProgress()
  local txtProgress = self:GetUIComponent("UILocalizationText", "_txtProgress")
  local txtProgress2 = self:GetUIComponent("UILocalizationText", "_txtProgress2")
  local component = self:_GetLineMissionComponent()
  local clear, all = component:GetClearProgress()
  txtProgress:SetText(clear)
  txtProgress2:SetText(string.format("/%s", all))
end

function UIActivityGraveRobberMainController:_SetRewardPool()
  local sop = self:GetUIComponent("UISelectObjectPath", "_rewardPool")
  sop:SpawnObjects("UIActivityGraveRobberItemIcon", 4)
  local list = sop:GetAllSpawnList()
  local rewards = Cfg.cfg_grave_robber_rewards
  for i = 1, #list do
    local roleAsset = RoleAsset:New()
    roleAsset.assetid = rewards[i].AssetidID
    list[i]:SetData(i, roleAsset, function(matid, pos)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityQuestAwardItemClick, matid, pos)
    end)
  end
end

function UIActivityGraveRobberMainController:_SetGoBtn()
  local component = self:_GetLineMissionComponent()
  local clear, all = component:GetClearProgress()
  local canChallenge = clear ~= all
  self._GoBtn:SetActive(canChallenge)
  self._StayBtn:SetActive(not canChallenge)
end

function UIActivityGraveRobberMainController:GoBtnOnClick(go)
  Log.info("UIActivityGraveRobberMainController:GoBtnOnClick")
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  if not self._campaign:CheckComponentOpen(ECampaignGrassComponentID.ECAMPAIGN_GRASS_MISSION) then
    local result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_COMPONENT_UNLOCK
    campaignModule:ShowErrorToast(result, true)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityCloseEvent, self._campaign._id)
    return
  end
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local grassData = campaignModule:GetGraveRobberData()
  local canPlay = grassData:GetCanPlayNodesCount()
  if canPlay == 0 then
    local str = StringTable.Get("str_activity_grass_escape_battle3")
    ToastManager.ShowToast(str)
  else
    self.grassData = GameGlobal.GetModule(CampaignModule):GetGraveRobberData()
    if self.grassData:IsOpenGraveRobber() and self.grassData:HasCanPlayNode() then
      DiscoveryData.EnterStateUIDiscovery(7, nil)
    else
      DiscoveryData.EnterStateUIDiscovery(1)
    end
  end
end

function UIActivityGraveRobberMainController:ExitBgOnClick(go)
  Log.info("UIActivityGraveRobberMainController:ExitBgOnClick")
  self:CloseDialog()
end

function UIActivityGraveRobberMainController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  self:AttachEvent(GameEventType.ActivityQuestAwardItemClick, self._OnActivityQuestAwardItemClick)
end

function UIActivityGraveRobberMainController:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  self:DetachEvent(GameEventType.ActivityQuestAwardItemClick, self._OnActivityQuestAwardItemClick)
end

function UIActivityGraveRobberMainController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIActivityGraveRobberMainController:_OnComponentStepChange(campaign_id, component_id, component_step)
  if self._campaign and self._campaign._id == campaign_id then
    self:_CheckRedPointAll()
  end
end

function UIActivityGraveRobberMainController:_CheckRedPointAll()
end

function UIActivityGraveRobberMainController:_CheckRedPoint(obj, ...)
  local bShow = self._campaign:CheckComponentRed(...)
  obj:SetActive(bShow)
end

function UIActivityGraveRobberMainController:_OnActivityQuestAwardItemClick(matid, pos)
  if not self._tips then
    local itemInfoPool = self:GetUIComponent("UISelectObjectPath", "itemInfoPool")
    self._tips = itemInfoPool:SpawnObject("UISelectInfo")
  end
  if self._tips then
    self._tips:SetData(matid, pos)
  end
end
