_class("UIN28GronruGameRewards", UIController)
UIN28GronruGameRewards = UIN28GronruGameRewards

function UIN28GronruGameRewards:Constructor()
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._loginModule = self:GetModule(LoginModule)
end

function UIN28GronruGameRewards:LoadDataOnEnter(TT, res)
  self._campaign = UIActivityCampaign:New()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N28_MINI_GAME, ECampaignN28MiniGameComponentID.ECAMPAIGN_BOUNCE_MISSION)
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  local campaignModule = self:GetModule(CampaignModule)
  self._campaignModule = campaignModule
  local sample = self._campaign:GetSample()
  self._endTime = sample.end_time
  self._component = self._campaign:GetComponent(ECampaignN28MiniGameComponentID.ECAMPAIGN_BOUNCE_MISSION)
  self._componentInfo = self._campaign:GetComponentInfo(ECampaignN28MiniGameComponentID.ECAMPAIGN_BOUNCE_MISSION)
  local openTime = self._componentInfo.m_unlock_time
  local closeTime = self._endTime
  local nowtime = self._svrTimeModule:GetServerTime() / 1000
  if openTime > nowtime then
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_NO_OPEN
    campaignModule:ShowErrorToast(res.m_result, true)
    return
  end
  if closeTime < nowtime then
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED
    campaignModule:ShowErrorToast(res.m_result, true)
    return
  end
end

function UIN28GronruGameRewards:OnShow(uiParams)
  self._levelId = uiParams[1]
  self._stageCfg = uiParams[2]
  self._missionId = self._stageCfg.CampaignMissionId
  self._entiesCfg = Cfg.cfg_component_bounce_mission_enties({})
  UIN28GronruGameConst.SetSelectLevel(self._missionId)
  self:InitWidget()
  self:Flush()
end

function UIN28GronruGameRewards:OnHide()
end

function UIN28GronruGameRewards:InitWidget()
  self._atlas = self:GetAsset("UIN28Minigame.spriteatlas", LoadType.SpriteAtlas)
  self._content = self:GetUIComponent("UISelectObjectPath", "content")
  self._titleText = self:GetUIComponent("Image", "titleText")
  self._anim = self:GetUIComponent("Animation", "anim")
end

function UIN28GronruGameRewards:Flush()
  local count = self._stageCfg.Enties ~= nil and #self._stageCfg.Enties or 0
  local items = self._content:SpawnObjects("UIN28GronruGameRewardItem", count)
  for index, value in ipairs(items) do
    value:SetData(self._stageCfg.Enties[index], self:_GetServerData(), self._stageCfg, self._entiesCfg[self._stageCfg.Enties[index]], self._atlas, self)
  end
  self._titleText.sprite = self._atlas:GetSprite("N28_yrj_junei_icon0" .. self._stageCfg.ID)
  self._titleText:SetNativeSize()
end

function UIN28GronruGameRewards:ShowToast(str)
  ToastManager.ShowToast(StringTable.Get(str))
end

function UIN28GronruGameRewards:StartBtnOnClick(go)
  if self:CheckActivityOver() then
    return
  end
  self:StartAnim()
end

function UIN28GronruGameRewards:PlayMissionStory(index)
  if self:CheckActivityOver() then
    return
  end
  local db = UIN28GronruGameLocalDb:New()
  db:ViewedMission(self._levelId)
  local maxScore = 0
  if self._componentInfo.m_pass_mission_info and self._componentInfo.m_pass_mission_info[self._missionId] then
    maxScore = self._componentInfo.m_pass_mission_info[self._missionId].max_record
  end
  self:CloseDialog()
  local roleId = self._loginModule:GetRoleShowID()
  local key = index
  if UIN28GronruGameConst.CheckStoryLocalDb(roleId, key, true) then
    self:ShowDialog("UIBounceMainController", self._levelId, UIN28GronruGameConst.GetSelectPlayer(), maxScore)
    return
  end
  local storyId = self._stageCfg.PreStoryId
  if storyId then
    GameGlobal.GetModule(StoryModule):StartStory(storyId, function()
      UIN28GronruGameConst.SetStoryLocalDb(roleId, key, true)
      self:ShowDialog("UIBounceMainController", self._levelId, UIN28GronruGameConst.GetSelectPlayer(), maxScore)
    end)
  else
    self:ShowDialog("UIBounceMainController", self._levelId, UIN28GronruGameConst.GetSelectPlayer(), maxScore)
  end
end

function UIN28GronruGameRewards:BackBtnOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N28BoucneInfo)
  self:CloseDialog()
end

function UIN28GronruGameRewards:_GetServerData()
  if not self._componentInfo.m_pass_mission_info then
    return
  end
  for key, value in pairs(self._componentInfo.m_pass_mission_info) do
    if value.mission_id == self._stageCfg.CampaignMissionId then
      return value
    end
  end
  return
end

function UIN28GronruGameRewards:RecieveRewards(missionId, entityId)
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local resp
    res, resp = self._component:HandleBounceMissionGetReward(TT, res, missionId, entityId)
    if res and res:GetSucc() then
      self:ShowDialog("UIGetItemController", resp.reward)
      self:Flush()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnN28ActivityMinigameGetReward)
    end
  end)
end

function UIN28GronruGameRewards:StartAnim()
  self:StartTask(function(TT)
    self:Lock("UIN28GronruGameRewards:StartAnim")
    self._anim:Play("uieff_UIN28GronruGameRewards_start")
    YIELD(TT, 200)
    self:PlayMissionStory(self._levelId)
    self:UnLock("UIN28GronruGameRewards:StartAnim")
  end)
end

function UIN28GronruGameRewards:CheckActivityOver()
  local closeTime = self._endTime
  local nowtime = self._svrTimeModule:GetServerTime() * 0.001
  if closeTime < nowtime then
    self:CloseDialog()
    return true
  end
  return false
end
