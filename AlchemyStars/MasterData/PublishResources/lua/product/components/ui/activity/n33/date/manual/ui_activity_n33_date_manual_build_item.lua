_class("UIActivityN33DateManualBuildItem", UICustomWidget)
UIActivityN33DateManualBuildItem = UIActivityN33DateManualBuildItem

function UIActivityN33DateManualBuildItem:Constructor()
  self._isRead = false
end

function UIActivityN33DateManualBuildItem:OnShow()
  self._atlas = self:GetAsset("UIN33Date.spriteatlas", LoadType.SpriteAtlas)
  self:_GetComponent()
end

function UIActivityN33DateManualBuildItem:_GetComponent()
  self._buildingImg = self:GetUIComponent("Image", "buildingImg")
  self._title = self:GetUIComponent("UILocalizationText", "title")
  self._intro = self:GetUIComponent("UILocalizationText", "intro")
  self._awardListContent = self:GetUIComponent("UISelectObjectPath", "awardList")
  self._bg = self:GetUIComponent("Image", "bg")
  self._doneIconObj = self:GetGameObject("doneIcon")
  self._lockIconObj = self:GetGameObject("lockIcon")
  self._conditionsObj = self:GetGameObject("conditions")
  self._storyBtnObj = self:GetGameObject("StoryBtn")
  self._selfObj = self:GetGameObject("anim")
  self._inviteBtnObj = self:GetGameObject("InviteBtn")
  self._buildingImgObj = self:GetGameObject("buildingImg")
  self._conditions = {}
  local condition1, condition2 = {}, {}
  condition1.item = self:GetGameObject("conditionItem1")
  condition1.gou = self:GetGameObject("gou1")
  condition1.txt = self:GetUIComponent("UILocalizationText", "conditionTxt1")
  condition2.item = self:GetGameObject("conditionItem2")
  condition2.gou = self:GetGameObject("gou2")
  condition2.txt = self:GetUIComponent("UILocalizationText", "conditionTxt2")
  self._conditions[1] = condition1
  self._conditions[2] = condition2
end

function UIActivityN33DateManualBuildItem:SetData(cfg, data, isShowInvite, storyClickCallback, inviteClickCallback)
  self._cfg = cfg
  self._activityConst = data
  self._isShowInvite = isShowInvite
  self._storyClickCallback = storyClickCallback
  self._inviteClickCallback = inviteClickCallback
  self:_Init()
end

function UIActivityN33DateManualBuildItem:_Init()
  local conditionIsOver = self._activityConst:CheckStoryConditionIsOver(self._cfg.ID)
  self._isRead = self._activityConst:CheckStoryIsRead(self._cfg.ID)
  self._buildingImg.sprite = self._atlas:GetSprite(self._cfg.EventIcon)
  self._intro:SetText(StringTable.Get(self._cfg.EventOverTxt))
  self._bg.sprite = self._atlas:GetSprite("N33_glyh_di04")
  self._doneIconObj:SetActive(self._isRead)
  self._lockIconObj:SetActive(not conditionIsOver)
  self._buildingImgObj:SetActive(conditionIsOver)
  self._storyBtnObj:SetActive(self._isRead)
  if conditionIsOver and self._isRead then
    self._title:SetText(StringTable.Get(self._cfg.EventTitle))
    self._inviteBtnObj:SetActive(false)
  elseif conditionIsOver and not self._isRead then
    self._title:SetText(StringTable.Get(self._cfg.EventTitle))
    self._inviteBtnObj:SetActive(true)
  elseif not conditionIsOver then
    self._title:SetText("???")
    self._inviteBtnObj:SetActive(false)
    self._bg.sprite = self._atlas:GetSprite("N33_glyh_di07")
  end
  local preStoryIds = self._cfg.PreStory
  if preStoryIds then
    local preStoryId = preStoryIds[1]
    self._conditions[1].item:SetActive(true)
    local preIsRead = self._activityConst:CheckStoryIsRead(preStoryId)
    self._conditions[1].gou:SetActive(preIsRead)
    local preStoryCfg = Cfg.cfg_component_simulation_operation_story[preStoryId]
    self._conditions[1].txt:SetText(StringTable.Get("str_n33_date_manual_lock_tip", StringTable.Get(preStoryCfg.EventTitle)))
  else
    self._conditions[1].item:SetActive(false)
  end
  local preBuildConditions = self._cfg.PreCondition
  if preBuildConditions then
    self._conditions[2].item:SetActive(true)
    local preBuildCondition = preBuildConditions[1]
    local id = preBuildCondition[1]
    local needLevel = preBuildCondition[2]
    local isLevelGet = self._activityConst:CheckBuildGetLevel(id, needLevel)
    self._conditions[2].gou:SetActive(isLevelGet)
    local buildCfg = Cfg.cfg_component_simulation_operation({ArchitectureId = id, Level = needLevel})[1]
    local name = StringTable.Get(buildCfg.MapName)
    self._conditions[2].txt:SetText(StringTable.Get("str_n33_date_arch_info_key15", name, needLevel))
  else
    self._conditions[2].item:SetActive(false)
  end
  self._awardList = self._awardListContent:SpawnObjects("UIActivityN33RewardItem", #self._cfg.Rewards)
  for i, awardItem in pairs(self._awardList) do
    local item = self._cfg.Rewards[i]
    awardItem:SetRewardData_Item(item, self._isRead, self._activityConst)
  end
  if not self._isShowInvite then
    self._inviteBtnObj:SetActive(false)
  end
end

function UIActivityN33DateManualBuildItem:GetIsRead()
  return self._isRead
end

function UIActivityN33DateManualBuildItem:SetActive(isActive)
  self._selfObj:SetActive(isActive)
end

function UIActivityN33DateManualBuildItem:StoryBtnOnClick()
  if self._activityConst:CheckSimulationOperationIsOver() then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIActivityN33MainController)
    return
  end
  if self._storyClickCallback then
    self._storyClickCallback()
  end
  self:ShowDialog("UIStoryController", self._cfg.StoryID)
end

function UIActivityN33DateManualBuildItem:SubmitSimulationOperationStory(TT)
  local comp = self._activityConst:GetComponent()
  local archId = 1
  local cfgs = Cfg.cfg_component_simulation_operation({})
  for _, cfg in pairs(cfgs) do
    if table.icontains(cfg.StoryList, self._cfg.ID) then
      archId = cfg.ArchitectureId
      break
    end
  end
  local res = AsyncRequestRes:New()
  local ret, rewards = comp:HandleSubmitSimulationOperationStory(TT, res, archId, self._cfg.ID, false)
  if res:GetSucc() then
    self:ShowDialog("UIGetItemController", rewards, function()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnInviteEventEnd)
    end)
  else
    Log.fatal("剧情完成失败")
  end
end

function UIActivityN33DateManualBuildItem:InviteBtnOnClick()
  if self._activityConst:CheckSimulationOperationIsOver() then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIActivityN33MainController)
    return
  end
  self:StartTask(function(TT)
    if self._inviteClickCallback then
      self._inviteClickCallback()
      YIELD(TT, 500)
    end
    self:ShowDialog("UIActivityN33DateInviteController", self._cfg, true, function()
      self:StartTask(self.SubmitSimulationOperationStory, self)
    end)
  end)
end
