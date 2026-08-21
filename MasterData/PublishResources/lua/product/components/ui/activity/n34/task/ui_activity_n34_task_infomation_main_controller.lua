_class("UIActivityN34TaskInfomationMainController", UIController)
UIActivityN34TaskInfomationMainController = UIActivityN34TaskInfomationMainController
local RewardState = {
  Unlock = 1,
  CanGet = 2,
  Got = 3
}
_enum("RewardState", RewardState)

function UIActivityN34TaskInfomationMainController:LoadDataOnEnter(TT, res, uiParams)
  self._itemModule = GameGlobal.GetModule(ItemModule)
  self._backBtn = self:GetUIComponent("UISelectObjectPath", "BackBtn")
  self._commonTopBtn = self._backBtn:SpawnObject("UICommonTopButton")
  self._commonTopBtn:SetData(function()
    self:CloseDialog()
  end, nil, nil, false)
  self._activityConst = UIActivityCustomConst:New(self:GetCampaignType(), self:GetComponentIds())
  self._activityConst:LoadData(TT, res)
  if res and not res:GetSucc() then
    local campModule = GameGlobal.GetModule(CampaignModule)
    campModule:CheckErrorCode(res.m_result, self._activityConst:GetCampaignId(), nil, nil)
  end
  self._questComponent = self._activityConst:GetComponent(ECampaignN34ComponentID.ECAMPAIGN_N34_QUEST)
  self._component, self._componentInfo = self._activityConst:GetComponent(ECampaignN34ComponentID.ECAMPAIGN_N34_SURVEY)
end

function UIActivityN34TaskInfomationMainController:OnShow()
  self._animClip = {
    [1] = {
      "uieff_UIActivityN34TaskInfomationMainController_in",
      667
    },
    [2] = {
      "uieff_UIActivityN34TaskInfomationMainController_in",
      700
    },
    [3] = {
      "uieff_UIActivityN34TaskInfomationMainController_in",
      700
    },
    [4] = {
      "uieff_UIActivityN34TaskInfomationMainController_in",
      700
    },
    [5] = {
      "uieff_UIActivityN34TaskInfomationMainController_in",
      700
    }
  }
  self:GetComponents()
  self:Init()
  self:PlayAnimCoro(1)
  self:AttachEvent(GameEventType.OnN34SurveyEvaluateFinish, self.RefreshRewardItem)
end

function UIActivityN34TaskInfomationMainController:OnHide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnN34TaskRefreshEvent)
end

function UIActivityN34TaskInfomationMainController:GetComponents()
  self._spine = self:GetUIComponent("SpineLoader", "spine")
  self._rewardImage = self:GetUIComponent("Image", "reward")
  self._plotBtn = self:GetGameObject("Plot")
  self._rewardRedPoint = self:GetGameObject("rewardRedPoint")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._items = {}
  self._itemWeights = {}
  self._itemsStar = {}
  local len = #self:GetSurveyCfg()
  for i = 1, len do
    self._items[i] = self:GetUIComponent("UISelectObjectPath", "item" .. i)
  end
  for i = 1, len do
    self._itemsStar[i] = self:GetGameObject("star" .. i)
  end
  self._atlas = self:GetAsset("UIN34Task.spriteatlas", LoadType.SpriteAtlas)
end

function UIActivityN34TaskInfomationMainController:Init()
  self._rewardRedPoint:SetActive(false)
  self:RefreshRewardItem()
  for index, value in ipairs(self._items) do
    local sp = value:SpawnObject("UIActivityN34TaskInfomationItem")
    sp:SetData(self:GetSurveyCfg(index), self._itemModule, self._component, self._componentInfo)
    table.insert(self._itemWeights, sp)
    local cfg = self:GetSurveyCfg(index)
    local count = self._itemModule:GetItemCount(cfg.TrustItem)
    self._itemsStar[index]:SetActive(count >= cfg.TrustTotal)
    self:PlayAnimCoro(index + 1)
  end
  self._spine:LoadSpine("n34_g_leiting_spine_idle")
end

function UIActivityN34TaskInfomationMainController:RefreshRewardItem()
  local rewardstate = self:CheckItemState()
  local allFinish = self:CheckAllFinish()
  if rewardstate == RewardState.CanGet and allFinish then
    self._rewardImage.sprite = self._atlas:GetSprite("n34_dc_reward1")
    self._plotBtn:SetActive(false)
    self._rewardRedPoint:SetActive(true)
  elseif rewardstate == RewardState.Unlock then
    self._rewardImage.sprite = self._atlas:GetSprite("n34_dc_reward2")
    self._plotBtn:SetActive(false)
    self._rewardRedPoint:SetActive(false)
  elseif rewardstate == RewardState.Got then
    self._rewardImage.sprite = self._atlas:GetSprite("n34_dc_reward3")
    self._plotBtn:SetActive(true)
    self._rewardRedPoint:SetActive(false)
  end
end

function UIActivityN34TaskInfomationMainController:Refresh()
  for index, value in ipairs(self._itemWeights) do
    value:Refresh()
  end
end

function UIActivityN34TaskInfomationMainController:CheckAllFinish()
  if not self._component then
    return false
  end
  return #self._componentInfo.info.pet_unlock >= #self:GetSurveyCfg()
end

function UIActivityN34TaskInfomationMainController:CheckItemState()
  local questModule = GameGlobal.GetModule(QuestModule)
  local cfg = Cfg.cfg_global.survey_main_task_id
  local mainTaskId
  if cfg and cfg.IntValue then
    mainTaskId = cfg.IntValue
  end
  local state = RewardState.Unlock
  local quest = questModule:GetQuest(mainTaskId)
  local qState = self._questComponent:CheckCampaignQuestStatus(quest:QuestInfo())
  if qState == CampaignQuestStatus.CQS_Taken then
    state = RewardState.Got
  elseif qState == CampaignQuestStatus.CQS_Completed then
    state = RewardState.CanGet
  end
  return state
end

function UIActivityN34TaskInfomationMainController:RewardOnClick()
  local cfg = Cfg.cfg_global.survey_main_task_id
  local mainTaskId
  if cfg and cfg.IntValue then
    mainTaskId = cfg.IntValue
  end
  if not mainTaskId then
    return
  end
  local allFinish = self:CheckAllFinish()
  if allFinish and self:CheckItemState() == RewardState.CanGet then
    self:StartTask(function(TT)
      local asyncRes = AsyncRequestRes:New()
      local ret, rewards = self._questComponent:HandleQuestTake(TT, asyncRes, mainTaskId)
      if asyncRes:GetSucc() then
        self:ShowRewards(rewards, function()
          self:RefreshRewardItem()
          self:_ShowFinalStory()
        end)
      end
    end)
  else
    local questModule = GameGlobal.GetModule(QuestModule)
    local quest = questModule:GetQuest(mainTaskId)
    local awards = quest._questInfo.rewards
    self:ShowDialog("UIActivityN34TaskInfomationAwards", awards)
  end
end

function UIActivityN34TaskInfomationMainController:ShowRewards(rewards, onFinish)
  local petIdList = {}
  local petModule = GameGlobal.GetModule(PetModule)
  for _, reward in pairs(rewards) do
    if petModule:IsPetID(reward.assetid) then
      table.insert(petIdList, reward)
    end
  end
  
  local function showItem()
    self:ShowDialog("UIGetItemController", rewards, onFinish)
  end
  
  if table.count(petIdList) > 0 then
    self:ShowDialog("UIPetObtain", petIdList, function()
      GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
      showItem()
    end)
    return
  end
  showItem()
end

function UIActivityN34TaskInfomationMainController:CloseOnClick()
  self:CloseDialog()
end

function UIActivityN34TaskInfomationMainController:GetSurveyCfg(index)
  if index then
    return Cfg.cfg_component_survey[index]
  end
  return Cfg.cfg_component_survey({})
end

function UIActivityN34TaskInfomationMainController:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N34
end

function UIActivityN34TaskInfomationMainController:GetComponentIds()
  local componentIds = {}
  componentIds[#componentIds + 1] = ECampaignN34ComponentID.ECAMPAIGN_N34_SURVEY
  componentIds[#componentIds + 1] = ECampaignN34ComponentID.ECAMPAIGN_N34_QUEST
  return componentIds
end

function UIActivityN34TaskInfomationMainController:PlayAnimCoro(index, callback)
  self:StartTask(function(TT)
    self:Lock("UIActivityN34TaskInfomationMainController:PlayAnimCoro")
    self._anim:Play(self._animClip[index][1])
    YIELD(TT, self._animClip[index][2])
    if callback then
      callback()
    end
    self:UnLock("UIActivityN34TaskInfomationMainController:PlayAnimCoro")
  end, self)
end

function UIActivityN34TaskInfomationMainController:_ShowFinalStory()
  local cfg = Cfg.cfg_n34_final_story[1]
  self:ShowDialog("UIStoryController", cfg.StoryID)
end

function UIActivityN34TaskInfomationMainController:PlotOnClick()
  self:_ShowFinalStory()
end
