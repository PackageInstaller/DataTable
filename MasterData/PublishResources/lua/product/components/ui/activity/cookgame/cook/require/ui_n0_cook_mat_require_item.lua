_class("UIN0CookMatRequireItem", UICustomWidget)
UIN0CookMatRequireItem = UIN0CookMatRequireItem

function UIN0CookMatRequireItem:Constructor()
  self._task = nil
  self._callback = nil
  self._component = nil
  self._delayTime = 50
end

function UIN0CookMatRequireItem:OnShow(uiParams)
  self:_GetComponents()
end

function UIN0CookMatRequireItem:_GetComponents()
  self._rewardContent = self:GetUIComponent("UISelectObjectPath", "rewardContent")
  self._slider = self:GetUIComponent("Slider", "taskInfoSlider")
  self._percentParent = self:GetUIComponent("RectTransform", "percentParent")
  self._percent1 = self:GetUIComponent("UILocalizationText", "percent1")
  self._taskTitle = self:GetUIComponent("UILocalizationText", "taskInfoTitle")
  self._taskBtnObj = self:GetGameObject("taskBtn")
  self._taskBtnUnFishedObj = self:GetGameObject("taskBtn-unFinish")
  self._taskBtnReceivedObj = self:GetGameObject("taskBtn-received")
end

function UIN0CookMatRequireItem:SetData(task, component, campaign, componentId, index, callback, itemClickCall)
  self._itemClickCall = itemClickCall
  self._task = task
  self._component = component
  self._campaign = campaign
  self._index = index
  local cfgs = Cfg.cfg_component_newyear_dinner_task({
    ComponentID = componentId,
    TaskID = self._task.task_id
  })
  self._taskCfg = cfgs[1]
  self._callback = callback
  local delayTime = (index - 1) * self._delayTime
  self:_SetAnimation(delayTime)
  self:_InitData()
end

function UIN0CookMatRequireItem:_InitData()
  local reward = self._rewardContent:SpawnObject("UIN0CookRewardItem")
  local id = self._taskCfg.Reward[1][1]
  local num = self._taskCfg.Reward[1][2]
  reward:SetData(id, num, function(tplId, pos)
    if self._itemClickCall then
      self._itemClickCall(tplId, pos)
    end
  end)
  self._percent1:SetText(self._task.cur_progress .. "/" .. self._task.total_progress)
  self._slider.value = self._task.cur_progress / self._task.total_progress
  self._taskTitle:SetText(StringTable.Get(self._taskCfg.Sescribe))
  self._taskBtnObj:SetActive(false)
  self._taskBtnUnFishedObj:SetActive(false)
  self._taskBtnReceivedObj:SetActive(false)
  if self._task.status == NewYearDinner_Status.E_NewYearDinner_Status_LOCK then
  elseif self._task.status == NewYearDinner_Status.E_NewYearDinner_Status_UN_FINISH then
    self._taskBtnUnFishedObj:SetActive(true)
  elseif self._task.status == NewYearDinner_Status.E_NewYearDinner_Status_CAN_RECV then
    self._taskBtnObj:SetActive(true)
  elseif self._task.status == NewYearDinner_Status.E_NewYearDinner_Status_RECVED then
    self._taskBtnReceivedObj:SetActive(true)
  end
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._percentParent)
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._percentParent)
end

function UIN0CookMatRequireItem:TaskBtnOnClick()
  if self._task.status == NewYearDinner_Status.E_NewYearDinner_Status_CAN_RECV then
    self:StartTask(self._TaskBtnClick, self)
  else
    Log.fatal("不可领取：", self._task.status)
  end
end

function UIN0CookMatRequireItem:_TaskBtnClick(TT)
  local res = AsyncRequestRes:New()
  local result, rewards = self._component:HandleNewYearDinnerReward(TT, res, NewYearDinner_Reward_Type.E_NewYearDinner_Reward_Task, self._task.task_id)
  if res and res:GetSucc() then
    self:ShowDialog("UIGetItemController", rewards)
    self._taskBtnObj:SetActive(false)
    self._taskBtnReceivedObj:SetActive(true)
    if self._callback then
      self._callback()
    end
  else
    local result = self._campaign:CheckComponentOpenClientError(ECCampaignInlandDinnerComponentID.ECAMPAIGN_INLAND_DINNER)
    self._campaign:CheckErrorCode(result)
    Log.fatal("美食活动任务领取失败：", res:GetResult())
  end
end

function UIN0CookMatRequireItem:_SetAnimation(delay)
  UIWidgetHelper.PlayAnimationInSequence(self, "anim", "anim", "uieff_N0_CookMatRequireItem", delay, 500, nil)
end
