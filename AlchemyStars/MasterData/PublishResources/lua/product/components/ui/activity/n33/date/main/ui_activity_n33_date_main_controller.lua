_class("UIActivityN33DateMainController", UIController)
UIActivityN33DateMainController = UIActivityN33DateMainController
local ARCH_LEVEL_MIN_CONST = 1
local ARCH_LEVEL_MAX_CONST = 4
local COIN_MAX_CONST = 9999999

function UIActivityN33DateMainController:LoadDataOnEnter(TT, res, uiParams)
  self._firstStoryID = 50570001
  self._finalStoryID = 50570002
  local campaign = UIActivityCampaign:New()
  campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N33, ECampaignN33ComponentID.ECAMPAIGN_N33_SIMULATION_OPERATION)
  if res and not res:GetSucc() then
    return
  end
  if not campaign then
    res:SetSucc(false)
    return
  end
  local localProcess = campaign:GetLocalProcess()
  if not localProcess then
    res:SetSucc(false)
    return
  end
  local compInfo = campaign:GetComponentInfo(ECampaignN33ComponentID.ECAMPAIGN_N33_SIMULATION_OPERATION)
  if table.count(compInfo.arch_infos) == 0 then
    ToastManager.ShowToast(StringTable.Get("str_n33_date_unlock"))
    res:SetSucc(false)
    return
  end
  campaign:ReLoadCampaignInfo_Force(TT, res)
  self._activityConst = UIActivityN33DateData:New(campaign)
end

function UIActivityN33DateMainController:OnShow(uiParams)
  UIActivityCustomHelper.SetNewFlagStatus("ACTIVITY_NEW" .. ECampaignType.CAMPAIGN_TYPE_N33 .. ECampaignN33ComponentID.ECAMPAIGN_N33_SIMULATION_OPERATION)
  self:AddEventListener()
  self:_GetComponent()
  self:_Init()
  self:_PlayInAnim()
  self.openUI = true
end

function UIActivityN33DateMainController:_GetComponent()
  self.moneyBg = self:GetGameObject("moneyBg")
  self.bgNodeTransform = self:GetGameObject("bgNode"):GetComponent(typeof(UnityEngine.RectTransform))
  self._archNodePool = self:GetUIComponent("UISelectObjectPath", "BuildingNode")
  self._petNode = self:GetUIComponent("UISelectObjectPath", "petNode")
  self._moneyNum = self:GetUIComponent("UILocalizationText", "moneyNum")
  self._outputNum = self:GetUIComponent("UILocalizationText", "outputNum")
  self._buildTransform = self:GetUIComponent("Transform", "BuildingNode")
  self._petTransform = self:GetUIComponent("Transform", "BuildingNode")
  self._maskTransform = self:GetUIComponent("Transform", "selectMask")
  self._moneyIcon = self:GetUIComponent("RawImageLoader", "moneyIcon")
  self._anim = self:GetGameObject():GetComponent("Animation")
  self.tipsText = self:GetUIComponent("UILocalizationText", "tipsText")
  self.centerTransform = self:GetGameObject("center"):GetComponent(typeof(UnityEngine.RectTransform))
  self._selectMaskObj = self:GetGameObject("selectMask")
  local filterContent = self:GetUIComponent("UISelectObjectPath", "filter")
  self._filter = filterContent:SpawnObject("UIActivityN33DateMainFilter")
  local btns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  self._backBtn = btns:SpawnObject("UICommonTopButton")
  self._backBtn:SetData(function()
    if self._activityConst:CheckSimulationOperationIsOver() then
      ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
      self:SwitchState(UIStateType.UIActivityN33MainController)
      return
    end
    self:SwitchState(UIStateType.UIActivityN33MainController)
  end, function()
    if self._activityConst:CheckSimulationOperationIsOver() then
      ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
      self:SwitchState(UIStateType.UIActivityN33MainController)
      return
    end
    self:ShowDialog("UIIntroLoader", "UIN33DateIntro")
  end, nil, false, nil)
end

function UIActivityN33DateMainController:_Init()
  if not UIActivityN33DateHelper.CheckFirstStoryIsPlay() then
    self:ShowDialog("UIStoryController", self._firstStoryID, function()
      UIActivityN33DateHelper.CancelFirstStoryPlay()
    end)
  end
  self.isAllArchFullLv = self:GetIsAllArchFullLv()
  self:PlayArchFullLvStory()
  self.allArchConfig = ComponentSimulationOperationConfig:New()
  self._currentTimeEvent = GameGlobal.Timer():AddEventTimes(60000, TimerTriggerCount.Infinite, self.OnOneSecondUpdate, self)
  self.focusScaleNum = 1.5
  self.focusTagPos = Vector2(-282, 41)
  self.focusTime = 1
  self:CreateAllArchItems()
  self:RefreshCoinData()
  self:CreateAllPetItems()
  self.tipsText:SetText(StringTable.Get("str_n33_date_tips_1"))
end

function UIActivityN33DateMainController:AddEventListener()
  self:AttachEvent(GameEventType.OnInviteEventEnd, self.OnInviteEventEnd)
  self:AttachEvent(GameEventType.OnN33PickUpCoin, self._OnN33PickUpCoin)
  self:AttachEvent(GameEventType.OnN33UpgradeArch, self._OnN33UpgradeArch)
  self:AttachEvent(GameEventType.OnN33FocusTag, self._OnN33FocusTag)
  self:AttachEvent(GameEventType.OnDateFilterClick, self._OnDateFilterClick)
  self:AttachEvent(GameEventType.OnN33ForceRefMapArch, self.OnOneSecondUpdate)
  self:AttachEvent(GameEventType.OnN33UpgradeRewardOver, self.OnOnN33UpgradeRewardOver)
end

function UIActivityN33DateMainController:OnInviteEventEnd()
  self:CheckGuide()
  self:_Init()
end

function UIActivityN33DateMainController:RefreshCoinData()
  self._moneyIcon:LoadImage("icon_item_3000328")
  self.moneyBg:SetActive(not self.isAllArchFullLv)
  if self.isAllArchFullLv then
    return
  end
  local itemModule = GameGlobal.GetModule(ItemModule)
  local coinCount = itemModule:GetItemCount(RoleAssetID.RoleAssetSimulationOperationCoin)
  if coinCount > COIN_MAX_CONST then
    coinCount = COIN_MAX_CONST .. "+"
  end
  self._moneyNum:SetText(tostring(coinCount))
  local rateSum = 0
  local archInfos = self._activityConst:GetArchInfos()
  for key, v in pairs(archInfos) do
    local archCfg = self.allArchConfig:GetBuildingAllLvInfo(v.arch_id)
    local currArchCfg = archCfg[v.level]
    rateSum = rateSum + currArchCfg.Rate
  end
  self._outputNum:SetText(StringTable.Get("str_n33_date_arch_info_key9", rateSum * 60))
end

function UIActivityN33DateMainController:CreateAllArchItems()
  local archInfos = self._activityConst:GetArchInfos()
  local count = table.count(archInfos)
  self._archNodePool:SpawnObjects("UIActivityN33BuildingItem", count)
  local nodes = self._archNodePool:GetAllSpawnList()
  for i = 1, #nodes do
    nodes[i]:SetVisible(false)
  end
  self.archItemPool = {}
  local index = 1
  for k, v in pairs(archInfos) do
    if v.arch_id == 5011002 then
      local archCfg = self.allArchConfig:GetBuildingAllLvInfo(v.arch_id)
      self:CreateArchItem(nodes[index], v.arch_id, archInfos, archCfg)
      self.archItemPool[index] = nodes[index]
      index = index + 1
    end
  end
  for k, v in pairs(archInfos) do
    if v.arch_id ~= 5011002 then
      local archCfg = self.allArchConfig:GetBuildingAllLvInfo(v.arch_id)
      self:CreateArchItem(nodes[index], v.arch_id, archInfos, archCfg)
      self.archItemPool[index] = nodes[index]
      index = index + 1
    end
  end
end

function UIActivityN33DateMainController:RefreshArchItem()
  local archInfos = self._activityConst:GetArchInfos()
  for key, v in pairs(self.archItemPool) do
    v:RefreshData(archInfos, self.isAllArchFullLv)
  end
  self:RefreshCoinData()
end

function UIActivityN33DateMainController:CreateArchItem(uiNode, archID, serverData, archCfg)
  uiNode:SetData(archID, serverData, archCfg, self.isAllArchFullLv, self._activityConst)
  if self._type ~= UIActivityN33DateMainFilterType.Pet then
    uiNode:PlayAnim(true)
  end
end

function UIActivityN33DateMainController:_OnDateFilterClick(type)
  if type == UIActivityN33DateMainFilterType.All then
    self._buildTransform:SetSiblingIndex(1)
    self._petTransform:SetSiblingIndex(0)
    self._maskTransform:SetSiblingIndex(2)
    self._selectMaskObj:SetActive(false)
    self:PlayArchAnim(ArchAnimType.TypeIn)
  elseif type == UIActivityN33DateMainFilterType.Build then
    self._buildTransform:SetSiblingIndex(0)
    self._petTransform:SetSiblingIndex(2)
    self._maskTransform:SetSiblingIndex(1)
    self._selectMaskObj:SetActive(true)
    self:PlayArchAnim(ArchAnimType.TypeIn)
  elseif type == UIActivityN33DateMainFilterType.Pet then
    self._buildTransform:SetSiblingIndex(2)
    self._petTransform:SetSiblingIndex(0)
    self._maskTransform:SetSiblingIndex(1)
    self._selectMaskObj:SetActive(true)
    self:PlayArchAnim(ArchAnimType.TypeOut)
  end
  self._type = type
end

function UIActivityN33DateMainController:CreateAllPetItems()
  local list = self._activityConst:GetMapShowPetList()
  self._petPoints = self._petNode:SpawnObjects("UIActivityN33DateMainPetItem", table.count(list))
  for i, v in pairs(self._petPoints) do
    v:SetData(list[i], self._activityConst, function(item)
      local cfg = item:GetConfig()
      self:ShowDialog("UIActivityN33DatePetController", cfg, self._activityConst)
    end)
  end
end

function UIActivityN33DateMainController:_Close(TT, cb)
  if cb then
    cb()
  end
end

function UIActivityN33DateMainController:LineLevelBtnOnClick()
  if self._activityConst:CheckSimulationOperationIsOver() then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIActivityN33MainController)
    return
  end
  self:StartTask(self._Close, self, function()
    self:ShowDialog("UIActivityN33LevelController", 1, true)
  end)
end

function UIActivityN33DateMainController:ManualBtnOnClick()
  if self._activityConst:CheckSimulationOperationIsOver() then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIActivityN33MainController)
    return
  end
  self:ShowDialog("UIActivityN33DateManualController", self._activityConst)
end

function UIActivityN33DateMainController:StoryBtnOnClick()
  if self._activityConst:CheckSimulationOperationIsOver() then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIActivityN33MainController)
    return
  end
  self:ShowDialog("UIStoryController", self._firstStoryID, function()
  end)
end

function UIActivityN33DateMainController:_PlayEndStory()
  self:ShowDialog("UIStoryController", self._finalStoryID, function()
    self:StartTask(function(TT)
      local comp = self._activityConst:GetComponent()
      local res = AsyncRequestRes:New()
      local ret, rewards = comp:HandleSubmitSimulationOperationStory(TT, res, 0, self._finalStoryID, true)
      if res:GetSucc() then
      else
        Log.fatal("最终剧情完成失败")
      end
    end, self)
  end)
end

function UIActivityN33DateMainController:OnOnN33UpgradeRewardOver()
  self:PlayArchFullLvStory()
end

function UIActivityN33DateMainController:OnOneSecondUpdate()
  if not self.openUI then
    return
  end
  if self.oneSecondUpdateTask then
    GameGlobal.TaskManager():KillTask(self.oneSecondUpdateTask)
    self.oneSecondUpdateTask = nil
  end
  self.oneSecondUpdateTask = self:StartTask(function(TT)
    self._activityConst:OneSecondUpdate_GetArchInfos(TT, function()
      if self.openUI then
        self:RefreshArchItem()
        self:CheckGuide()
      end
    end)
    self.oneSecondUpdateTask = nil
  end, self)
end

function UIActivityN33DateMainController:_OnN33FocusTag(focusTagPos)
end

function UIActivityN33DateMainController:_OnN33PickUpCoin(archID)
  self:StartTask(function(TT)
    self._activityConst:OneSecondUpdate_PickUpCoin(TT, archID, function()
      self._anim:Play("uieffanim_UIActivityN33DateMainController_gather")
      self:RefreshArchItem()
    end)
  end, self)
end

function UIActivityN33DateMainController:_OnN33UpgradeArch(archID)
  self:StartTask(function(TT)
    self._activityConst:OneSecondUpdate_UpgradeArch(TT, archID, function(rewards)
      self.isAllArchFullLv = self:GetIsAllArchFullLv()
      self:RefreshArchItem()
      self:CreateAllPetItems()
      local archInfos = self._activityConst:GetArchInfos()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnN33RefArchUI, archInfos)
      self:ShowUpgradeArchReward(archID, rewards)
      AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N15RaffleSucc)
    end)
  end, self)
end

function UIActivityN33DateMainController:ShowUpgradeArchReward(archID, rewards)
  local archInfos = self._activityConst:GetArchInfos()
  local currArchLv = ARCH_LEVEL_MIN_CONST
  for key, info in pairs(archInfos) do
    if info.arch_id == archID then
      currArchLv = info.level
      break
    end
  end
  self:ShowDialog(UIStateType.UIActivityN33ArchUpgradeReward, archID, currArchLv, rewards, self._activityConst)
end

function UIActivityN33DateMainController:GetIsAllArchFullLv()
  local archInfos = self._activityConst:GetArchInfos()
  for key, info in pairs(archInfos) do
    if info.level < ARCH_LEVEL_MAX_CONST then
      return false
    end
  end
  return true
end

function UIActivityN33DateMainController:PlayHideAnim(callback)
  self:StartTask(function(TT)
    for key, v in pairs(self.archItemPool) do
      v:PlayAnim(false)
    end
    YIELD(TT, 400)
    if callback then
      callback()
    end
  end, self)
end

function UIActivityN33DateMainController:PlayArchAnim(animType)
  if not self.archItemPool then
    return
  end
  self:StartTask(function(TT)
    if animType == ArchAnimType.TypeIn or animType == ArchAnimType.TypeOut then
      for key, v in pairs(self.archItemPool) do
        v:PlayAnim_InfoBubble(animType == ArchAnimType.TypeIn and true or false)
      end
    elseif animType == ArchAnimType.TypeOutIn then
      for key, v in pairs(self.archItemPool) do
        v:PlayAnim_InfoBubble(false)
      end
      YIELD(TT, 400)
      for key, v in pairs(self.archItemPool) do
        v:PlayAnim_InfoBubble(true)
      end
    end
  end, self)
end

function UIActivityN33DateMainController:PlayArchFullLvStory()
  local isAllArchFullLv = self:GetIsAllArchFullLv()
  if not isAllArchFullLv then
    return
  end
  if self._activityConst:GetIsPlayFinalStory() then
    return
  end
  self:_PlayEndStory()
end

function UIActivityN33DateMainController:OnHide()
  self.openUI = false
  if self._currentTimeEvent then
    GameGlobal.Timer():CancelEvent(self._currentTimeEvent)
    self._currentTimeEvent = nil
  end
  self:DetachEvent(GameEventType.OnN33PickUpCoin, self._OnN33PickUpCoin)
  self:DetachEvent(GameEventType.OnN33UpgradeArch, self._OnN33UpgradeArch)
  self:DetachEvent(GameEventType.OnN33FocusTag, self._OnN33FocusTag)
  self:DetachEvent(GameEventType.OnN33ForceRefMapArch, self.OnOneSecondUpdate)
  self:DetachEvent(GameEventType.OnN33UpgradeRewardOver, self.OnOnN33UpgradeRewardOver)
  if self.oneSecondUpdateTask then
    GameGlobal.TaskManager():KillTask(self.oneSecondUpdateTask)
    self.oneSecondUpdateTask = nil
  end
end

function UIActivityN33DateMainController:_PlayInAnim()
  self:StartTask(function(TT)
    self:Lock("uieffanim_UIActivityN33DateMainController_in")
    self._anim:Play("uieffanim_UIActivityN33DateMainController_in")
    YIELD(TT, 1000)
    self:UnLock("uieffanim_UIActivityN33DateMainController_in")
    self:CheckGuide()
  end, self)
end

function UIActivityN33DateMainController:CheckGuide()
  local guideModule = GameGlobal.GetModule(GuideModule)
  if not guideModule:IsGuideDone(123002) then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIActivityN33DateMainController1)
  elseif not guideModule:IsGuideDone(123006) then
    self._filter:FilterAll()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIActivityN33DateMainController2)
  elseif not guideModule:IsGuideDone(123008) then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIActivityN33DateMainController3)
  end
end

function UIActivityN33DateMainController:GetFirstDialogBtn()
  local nodes = self._archNodePool:GetAllSpawnList()
  local node = nodes[1]
  return node:GetReceiveCoinBtn()
end

function UIActivityN33DateMainController:GetSecondDialogBtn()
  local nodes = self._archNodePool:GetAllSpawnList()
  local node = nodes[2]
  return node:GetReceiveCoinBtn()
end

function UIActivityN33DateMainController:GetThirdDialogBtn()
  local nodes = self._archNodePool:GetAllSpawnList()
  local node = nodes[3]
  return node:GetReceiveCoinBtn()
end

function UIActivityN33DateMainController:GetFourthDialogBtn()
  local nodes = self._archNodePool:GetAllSpawnList()
  local node = nodes[4]
  return node:GetReceiveCoinBtn()
end

function UIActivityN33DateMainController:GetFifthDialogBtn()
  local nodes = self._archNodePool:GetAllSpawnList()
  local node = nodes[4]
  return node:GetOpenInfoBtn()
end

function UIActivityN33DateMainController:GetSixthDialogBtn()
  local helpBtn = self._backBtn.view:GetGameObject("ButtonHelp")
  return helpBtn
end

function UIActivityN33DateMainController:GetSeventhDialogBtn()
  local nodes = self._petNode:GetAllSpawnList()
  for _, v in pairs(nodes) do
    if v:CheckID(1602061) then
      return v.view:GetGameObject("petIcon")
    end
  end
end
