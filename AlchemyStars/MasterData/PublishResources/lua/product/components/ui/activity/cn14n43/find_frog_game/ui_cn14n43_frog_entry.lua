_class("UICN14N43FrogEntry", UISideEnterCenterContentBase)
UICN14N43FrogEntry = UICN14N43FrogEntry

function UICN14N43FrogEntry:Constructor()
  self.CollectFrogData = {}
  self.CollectSeverMark = 0
  self.RecycleFrogNum = 0
  self.ShowFrogMax = 4
  self.CanRecycleFrog = true
  self.FrogNumMax = 0
  self.RewardFrogID = 0
  self.isReceiveFinalFrog = false
  self.FrogPosDiffX = 817
  self.FrogItemList = {}
  self.FallSpeed = 3500
end

function UICN14N43FrogEntry:DoInit()
  self.FrogNumMax = table.count(Cfg.cfg_frog_info())
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._campaignModule = self:GetModule(CampaignModule)
  self._campaign = self._data
  local sample = self._campaign:GetSample()
  self._endTime = sample.end_time
  self._localProcess = self._campaign:GetLocalProcess()
  self._personProgressComponent = self._localProcess:GetComponent(ECampaignCollectFrogComponentID.ECAMPAIGN_COLLECT_FROG_PERSON_PROCESS)
  self.cmpInfo = self._personProgressComponent:ComponentInfo()
  self:AttachEvent(GameEventType.AfterUILayerChanged, self.AfterUILayerChanged)
  local getRewards = self.cmpInfo.m_received_progress
  for k, v in pairs(getRewards) do
    if v == self.FrogNumMax then
      self.isReceiveFinalFrog = true
    end
  end
  self:_CollectFrogFormatData()
  self.CollectSeverMark = self.cmpInfo.m_mark
  self.RecycleFrogNum = self.cmpInfo.m_mark_else
  Log.debug("[Frog]   CollectSeverMark:", self.CollectSeverMark, ", self.RecycleFrogNum:", self.RecycleFrogNum)
end

function UICN14N43FrogEntry:DoShow()
  self.CanRecycleFrog = true
  self:StartTask(function(TT)
    self._campaign:ClearCampaignNew(TT)
  end)
  self:_GetComponents()
  self:_InitFrogReward()
  self.taskId = self:StartTask(function(TT)
    while true do
      self:_OnValue()
      YIELD(TT, 1000)
    end
  end)
  self:_InitFrogNode()
  local rewards = self.cmpInfo.m_progress_rewards
  local getRewards = self.cmpInfo.m_received_progress
  local isReceived = false
  for k, v in pairs(rewards) do
    if k ~= self.FrogNumMax and k <= self.RecycleFrogNum then
      local b = false
      for key, value in pairs(getRewards) do
        if value == k then
          b = true
        end
      end
      if not b then
        isReceived = true
        break
      end
    end
  end
  if isReceived then
    GameGlobal.TaskManager():StartTask(function(TT)
      local res = UIStateSwitchReq:New()
      res:SetSucc(true)
      local reward = self._personProgressComponent:HandleOneKeyReceiveRewards(TT, res)
      UIActivityHelper.ShowUIGetRewards(reward)
    end)
  end
  self:_RefUI()
end

function UICN14N43FrogEntry:DoHide()
  if self.taskId then
    GameGlobal.TaskManager():KillTask(self.taskId)
    self.taskId = nil
  end
  if self.taskId2 then
    GameGlobal.TaskManager():KillTask(self.taskId2)
    self.taskId2 = nil
  end
  if self.taskId3 then
    GameGlobal.TaskManager():KillTask(self.taskId3)
    self.taskId3 = nil
  end
end

function UICN14N43FrogEntry:DoDestroy()
  UICN14N43FrogEntry.super:Dispose()
  if self.taskId then
    GameGlobal.TaskManager():KillTask(self.taskId)
    self.taskId = nil
  end
  if self.taskId2 then
    GameGlobal.TaskManager():KillTask(self.taskId2)
    self.taskId2 = nil
  end
  if self.taskId3 then
    GameGlobal.TaskManager():KillTask(self.taskId3)
    self.taskId3 = nil
  end
end

function UICN14N43FrogEntry:_GetComponents()
  self._remainTime = self:GetUIComponent("UILocalizationText", "RemainTimeText")
  self._remainTime2 = self:GetUIComponent("UILocalizationText", "RemainTimeText2")
  self._TestTips = self:GetUIComponent("UILocalizationText", "TestTips")
  self._frogNode = self:GetUIComponent("UISelectObjectPath", "FrogNode")
  self._finalFrogNode = self:GetGameObject("FinalFrog")
  self._finalFrog = self:GetUIComponent("UISelectObjectPath", "FinalFrog")
  self._mark = self:GetGameObject("Mark")
  self._frog0 = self:GetGameObject("Frog0")
  self._shou = self:GetGameObject("shou")
  self._eff = self:GetGameObject("EffAnim")
  self._receiveNode = self:GetGameObject("ReceiveNode")
  self._EffAnim = self:GetUIComponent("Animation", "EffAnim")
  self._RootAnim = self:GetUIComponent("Animation", "RootAnim")
  self._ReceiveOver = self:GetGameObject("ReceiveOver")
  self._frogName = self:GetUIComponent("UILocalizationText", "FrogName")
  for i = 1, self.FrogNumMax do
    self["_getRewardNode" .. i] = self:GetGameObject("GetRewardNode" .. i)
    self["_rewardNum" .. i] = self:GetUIComponent("UILocalizationText", "RewardNum" .. i)
    self["_rewardIcon" .. i] = self:GetUIComponent("RawImageLoader", "RewardIcon" .. i)
    self["_rewardAnim" .. i] = self:GetUIComponent("Animation", "RewardNode" .. i)
  end
  self.RecycleArea = self:GetUIComponent("RectTransform", "RecycleArea")
end

function UICN14N43FrogEntry:_OnValue()
  if self._remainTime then
    local curTime = self._svrTimeModule:GetServerTime() * 0.001
    local endTime = self._endTime
    if curTime < endTime then
      self._remainTime:SetText(StringTable.Get("str_activity_common_remainingtime_3", ""))
      self._remainTime2:SetText(UIActivityHelper.GetFormatTimerStr(endTime - curTime))
      self._remainTime2.gameObject:SetActive(true)
    else
      self._remainTime:SetText(StringTable.Get("str_activity_common_state_over"))
      self._remainTime2.gameObject:SetActive(false)
    end
  end
end

function UICN14N43FrogEntry:AfterUILayerChanged()
  self:_OnValue()
end

function UICN14N43FrogEntry:_CollectFrogFormatData()
  self.CollectFrogData = {}
  local mark = self.cmpInfo.m_mark
  for i = self.FrogNumMax, 1, -1 do
    self.CollectFrogData[i] = mark & 1
    mark = mark >> 1
  end
end

function UICN14N43FrogEntry:_InitFrogNode()
  local showNum = 0
  for i = 1, self.FrogNumMax do
    if self.CollectFrogData[i] == 1 then
      showNum = showNum + 1
    end
  end
  if self.RecycleFrogNum < self.FrogNumMax then
    self._RootAnim:Play("effanim_UICN14N43FrogEntry_in")
    self._EffAnim:Play("effanim_UICN14N43FrogEntry_eff_in")
  else
    self._eff:SetActive(false)
  end
  self:_AddProgress()
  showNum = showNum - self.RecycleFrogNum
  local b = showNum == 0 and self.FrogNumMax > self.RecycleFrogNum
  self._frog0:SetActive(b)
  self._shou:SetActive(0 < showNum)
  self._mark:SetActive(self.FrogNumMax > self.RecycleFrogNum)
  self._receiveNode:SetActive(self.RecycleFrogNum > self.FrogNumMax and not self.isReceiveFinalFrog)
  self.FrogItemList = {}
  self._frogNode:ClearWidgets()
  local items = self._frogNode:SpawnObjects("UICN14N43Frog", showNum)
  local camera = GameGlobal.UIStateManager():GetControllerCamera("UISideEnterCenterController")
  for i = 1, showNum do
    local item = items[i]
    item:SetDragData(camera, self.RecycleArea)
    item:SetPos(Vector3((i - 1) * self.FrogPosDiffX, -400, 0))
    item:SetData(false, i, function(idx)
      self:_ClickFrog(idx)
    end)
    if i > self.ShowFrogMax then
      item:SetActive(false)
    end
    table.insert(self.FrogItemList, item)
  end
end

function UICN14N43FrogEntry:_AddProgress()
  local serverP = self.cmpInfo.m_current_progress
  local clintP = self.RecycleFrogNum
  local addNum = clintP - serverP
  if addNum <= 0 then
    return
  end
  Log.debug("[Frog]   _AddProgress:", addNum)
  for i = 1, addNum do
    GameGlobal.TaskManager():StartTask(function(TT)
      local res = UIStateSwitchReq:New()
      res:SetSucc(true)
      self._personProgressComponent:HandlePersonProgressCollect(TT, res, 1, self.CollectSeverMark, self.RecycleFrogNum)
    end)
  end
end

function UICN14N43FrogEntry:_RefFrogReward()
  for i = 1, self.FrogNumMax do
    self["_getRewardNode" .. i]:SetActive(i <= self.RecycleFrogNum)
    if i == self.FrogNumMax and not self.isReceiveFinalFrog then
      self["_getRewardNode" .. i]:SetActive(false)
    end
  end
end

function UICN14N43FrogEntry:_InitFrogReward()
  local rewards = self.cmpInfo.m_progress_rewards
  for k, v in pairs(rewards) do
    local reward = v[1]
    local conf = Cfg.cfg_item[reward.assetid]
    self["_rewardIcon" .. k]:LoadImage(conf.Icon)
    self["_rewardNum" .. k]:SetText(reward.count)
    if k == self.FrogNumMax then
      self._frogName:SetText(StringTable.Get(conf.Name))
      self.RewardFrogID = reward.assetid
    end
  end
end

function UICN14N43FrogEntry:_ClickFrog(idx)
  if not self.CanRecycleFrog then
    return
  end
  idx = 1
  self:_PlayInWater(idx)
end

function UICN14N43FrogEntry:_PlayInWater(idx)
  self.CanRecycleFrog = false
  for i = 1, #self.FrogItemList do
    local isShow = i <= self.ShowFrogMax + 1
    self.FrogItemList[i]:SetActive(isShow)
  end
  local fristFrog = self.FrogItemList[idx]
  self.taskId2 = GameGlobal.TaskManager():StartTask(function(TT)
    fristFrog:PlayInWater()
    if self.RecycleFrogNum + 1 == self.FrogNumMax then
      self._shou:SetActive(false)
    end
    YIELD(TT, 30)
    self._EffAnim:Play("effanim_UICN14N43FrogEntry_eff_start")
    YIELD(TT, 900)
    self._EffAnim:Play("effanim_UICN14N43FrogEntry_eff_in")
    fristFrog:SetActive(false)
    table.removev(self.FrogItemList, self.FrogItemList[idx])
    for i = 1, #self.FrogItemList do
      local f = self.FrogItemList[i]
      local go = f:GetGameObject()
      go:SetActive(false)
      go:SetActive(true)
      go.transform:DOLocalMoveX((i - 1) * self.FrogPosDiffX, 0.66)
      f:ChangeIdx(i - 1)
      f:PlayMoveEff()
    end
    self.RecycleFrogNum = self.RecycleFrogNum + 1
    self:_PlayInWaterOver()
    YIELD(TT, 666)
    self.CanRecycleFrog = true
  end)
end

function UICN14N43FrogEntry:_PlayInWaterOver()
  GameGlobal.TaskManager():StartTask(function(TT)
    local res = UIStateSwitchReq:New()
    res:SetSucc(true)
    local response = self._personProgressComponent:HandlePersonProgressCollect(TT, res, 1, self.CollectSeverMark, self.RecycleFrogNum)
    if not response then
      return
    end
    if self.RecycleFrogNum == self.FrogNumMax then
      self:_ShowFinalFrog(true)
    else
      self:_ReceiveRewards()
      self:_RefUI()
    end
  end)
end

function UICN14N43FrogEntry:_RefUI()
  self._TestTips:SetText(self.RecycleFrogNum .. "/" .. self.FrogNumMax)
  self:_RefFrogReward()
  if self.RecycleFrogNum == self.FrogNumMax then
    self:_ShowFinalFrog(false)
  end
  local showNum = 0
  for i = 1, self.FrogNumMax do
    if self.CollectFrogData[i] == 1 then
      showNum = showNum + 1
    end
  end
  showNum = showNum - self.RecycleFrogNum
  local b = showNum == 0 and self.FrogNumMax > self.RecycleFrogNum
  self._frog0:SetActive(b)
  self._shou:SetActive(0 < showNum)
  self._ReceiveOver:SetActive(self.isReceiveFinalFrog)
  if self.isReceiveFinalFrog then
    self._finalFrog:SpawnObjects("UICN14N43Frog", 1)
    self._finalFrogNode:SetActive(true)
  end
end

function UICN14N43FrogEntry:_ReceiveRewards()
  local rewards = self.cmpInfo.m_progress_rewards
  local progress = 0
  for k, v in pairs(rewards) do
    if k == self.RecycleFrogNum then
      progress = k
      break
    end
  end
  if progress == 0 then
    return
  end
  self.taskId3 = GameGlobal.TaskManager():StartTask(function(TT)
    if progress ~= self.FrogNumMax then
      self["_rewardAnim" .. progress]:Play("effanim_UICN14N43FrogEntry_go")
    end
    YIELD(TT, 250)
    local res = UIStateSwitchReq:New()
    res:SetSucc(true)
    local reward = self._personProgressComponent:HandleReceiveReward(TT, res, progress)
    UIActivityHelper.ShowUIGetRewards(reward)
  end)
end

function UICN14N43FrogEntry:_ShowFinalFrog(showAnim)
  if self.isReceiveFinalFrog then
    return
  end
  self._receiveNode:SetActive(true)
  self._mark:SetActive(false)
  self._finalFrogNode:SetActive(true)
  local items = self._finalFrog:SpawnObjects("UICN14N43Frog", 1)
  local final = items[1]
  if showAnim then
    final:PlayOutWater()
  end
  self._EffAnim:Play("effanim_UICN14N43FrogEntry_eff_out")
end

function UICN14N43FrogEntry:IntroBtnOnClick(go)
  if self:CheckActivityOver() then
    return
  end
  self:ShowDialog(UIStateType.UICN14N43FrogIntro)
end

function UICN14N43FrogEntry:DetailBtnOnClick(go)
  self:ShowDialog("UIShopPetDetailController", self.RewardFrogID)
end

function UICN14N43FrogEntry:ReceiveNodeOnClick(go)
  if self.isReceiveFinalFrog then
    return
  end
  self.isReceiveFinalFrog = true
  self._receiveNode:SetActive(false)
  self._mark:SetActive(false)
  self._finalFrogNode:SetActive(true)
  self:_ReceiveRewards()
  self:_RefUI()
  self["_rewardAnim" .. self.FrogNumMax]:Play("effanim_UICN14N43FrogEntry_go")
end

function UICN14N43FrogEntry:CheckActivityOver()
  local curTime = self._svrTimeModule:GetServerTime() * 0.001
  local endTime = self._endTime
  if curTime < endTime then
    return false
  else
    ToastManager.ShowToast(StringTable.Get("str_activity_common_notice_content"))
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityCloseEvent, self._campaign._id)
    return true
  end
end
