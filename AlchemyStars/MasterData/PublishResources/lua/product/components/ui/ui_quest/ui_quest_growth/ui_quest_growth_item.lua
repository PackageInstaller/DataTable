_class("UIQuestGrowthItem", UICustomWidget)
UIQuestGrowthItem = UIQuestGrowthItem

function UIQuestGrowthItem:_GetComponents()
  self._questBGList = self:GetUIComponent("UISelectObjectPath", "v")
  self._questListAnim = self:GetUIComponent("Animation", "v")
  self._stage1GO = self:GetGameObject("stage1")
  self._stage2GO = self:GetGameObject("stage2")
  self._stage1rGO = self:GetGameObject("stage1r")
  self._stage2rGO = self:GetGameObject("stage2r")
  self._featherPool = self:GetUIComponent("UISelectObjectPath", "featherPool")
  self._featherPoolGo = self:GetGameObject("featherPool")
  self._stageProgressTxt = self:GetUIComponent("UILocalizationText", "stageProgressTxt")
  self._featherImage = self:GetUIComponent("Image", "bigAwardImgValue")
  self._selectedDayGO = self:GetGameObject("selectedDay")
  self._selectedGoalGO = self:GetGameObject("selectedGoal")
  self._selectedDayTxt = self:GetUIComponent("Text", "day")
  self._selectedGoalTxt = self:GetUIComponent("Text", "goal")
  self._stageBG = self:GetGameObject("stageBG")
  self._stage1Tab = self:GetGameObject("stage1Tab")
  self._stage2Tab = self:GetGameObject("stage2Tab")
  self._stage1txt = self:GetUIComponent("UILocalizationText", "stage1txt")
  self._stage2txt = self:GetUIComponent("UILocalizationText", "stage2txt")
  self._stage1red = self:GetGameObject("stage1red")
  self._stage2red = self:GetGameObject("stage2red")
  self._stage2lock = self:GetGameObject("stage2lock")
  self._selectedDayRed = self:GetGameObject("dayRed")
  self._selectedGoalRed = self:GetGameObject("goalRed")
  self._selectedDayBG = self:GetGameObject("dayBG")
  self._selectedDayBGDone = self:GetGameObject("dayBGDone")
  self._selectedGoalBG = self:GetGameObject("goalBG")
  self._selectedGoalBGDone = self:GetGameObject("goalBGDone")
  self._unselectedOldday = self:GetGameObject("oldday")
  self._unselectedOlddayred = self:GetGameObject("olddayRed")
  self._unselectedOlddaybg = self:GetGameObject("olddayBG")
  self._unselectedOlddaybgDone = self:GetGameObject("olddayBGDone")
  self._unselectedDayGo = self:GetGameObject("UnselectedDay")
  self._unselectedDayTxt = self:GetUIComponent("Text", "oldday")
  self._unselectedDayGo:SetActive(false)
  self._selectedDayCanvasGroup = self:GetUIComponent("CanvasGroup", "selectedDay")
  self._unselectedDayCanvasGroup = self:GetUIComponent("CanvasGroup", "UnselectedDay")
  self._unselectedungoal = self:GetGameObject("ungoal")
  self._unselectedungoalRed = self:GetGameObject("ungoalRed")
  self._unselectedungoalBG = self:GetGameObject("ungoalBG")
  self._unselectedungoalBGDone = self:GetGameObject("ungoalBGDone")
  self._unselectedGoaGo = self:GetGameObject("unselectedGoal")
  self._unselectedGoaTxt = self:GetUIComponent("Text", "ungoal")
  self._unselectedGoaGo:SetActive(false)
  self._selectedGoalCanvasGroup = self:GetUIComponent("CanvasGroup", "selectedGoal")
  self._unselectedGoalCanvasGroup = self:GetUIComponent("CanvasGroup", "unselectedGoal")
end

function UIQuestGrowthItem:OnShow(uiParams)
  self._questListGO = self:GetGameObject("v")
  self._questListInitLocalPos = self._questListGO.transform.localPosition
  self._transition = self:GetUIComponent("ATransitionComponent", "UIQuestGrowthItem")
  self._anim = self:GetUIComponent("Animation", "UIQuestGrowthItem")
  self._canvasGroup = self:GetUIComponent("CanvasGroup", "UIQuestGrowthItem")
  self._canvasGroup.blocksRaycasts = false
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UIQuestGrowthItem:OnHide()
  self:DetachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
  if self._event then
    GameGlobal.RealTimer():CancelEvent(self._event)
    self._event = nil
  end
end

function UIQuestGrowthItem:OnClose()
  self._isOpen = false
  if self._event then
    GameGlobal.RealTimer():CancelEvent(self._event)
    self._event = nil
  end
  self._anim.enabled = true
  self._anim:Stop()
  self._canvasGroup.alpha = 0
  self._canvasGroup.blocksRaycasts = false
end

function UIQuestGrowthItem:RefrenshList(anim, switchDayOrGoal)
  self:_SetTabSelect(self._tabIndex or self._questModule:GetLatestIndex_QuestGrowthTab())
  self:_Refresh_TabBtn()
  self:_Refresh_DayBtn()
  self:_Refresh_GoalBtn()
  self:StartTask(function(TT)
    self:_Refresh_QuestList(TT, anim)
  end)
  self:_Refresh_Feather(anim and not switchDayOrGoal)
end

function UIQuestGrowthItem:SetData(type)
  self._canvasGroup.alpha = 1
  self._transition:PlayEnterAnimation(true)
  self._canvasGroup.blocksRaycasts = true
  self._isOpen = true
  self:_GetComponents()
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._petModule = GameGlobal.GetModule(PetModule)
  self._questModule = GameGlobal.GetModule(QuestModule)
  self._type = type
  self:_SetDayBtn()
  self:_SetGoalBtn()
  self:RefrenshList(true)
end

function UIQuestGrowthItem:_Refresh_TabBtn()
  local lock = self._questModule:CheckQuestIILock(1)
  self._stage2lock:SetActive(lock)
  self._stage1red:SetActive(self._questModule:GetGrowthRedPointNum() > 0)
  self._stage2red:SetActive(0 < self._questModule:GetStage2GrowthRedPointNum())
end

function UIQuestGrowthItem:_SetTabSelect(index)
  if self._tabIndex == index then
    return
  end
  self._tabIndex = index
  self._stage1GO:SetActive(index == 1)
  self._stage1rGO:SetActive(index == 1)
  self._stage2GO:SetActive(index == 2)
  self._stage2rGO:SetActive(index == 2)
  if index == 1 then
    self._stageBG.transform:DOMove(self._stage1Tab.transform.position, 0.2)
    self._stage1txt.color = Color.white
    self._stage2txt.color = Color(0.29411764705882354, 0.2901960784313726, 0.2901960784313726, 1)
    self:_SetDaySelect(self._dayIndex or self._questModule:GetLatestIndex_QuestGrowthDay())
  else
    self._stageBG.transform:DOMove(self._stage2Tab.transform.position, 0.2)
    self._stage2txt.color = Color.white
    self._stage1txt.color = Color(0.29411764705882354, 0.2901960784313726, 0.2901960784313726, 1)
    self:_SetGoalSelect(self._goalIndex or self._questModule:GetLatestIndex_QuestGrowthGoal())
  end
end

function UIQuestGrowthItem:_SetDayBtn()
  local cfgs = Cfg.cfg_quest_growth_day({})
  self._dayBtns = UIWidgetHelper.SpawnObjects(self, "_dayBtns", "UIQuestGrowthTabBtn", #cfgs)
  for i, v in ipairs(self._dayBtns) do
    local lock = self._questModule:CheckQuestLock(i)
    local done = self._questModule:IsGrowthQuestAllTaken(true, i)
    v:SetData(i, lock, done, function(index)
      AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSwitch)
      if self:_SetDaySelect(index) then
        self:RefrenshList(true, true)
      end
    end, function(index)
      AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSwitch)
      UIWidgetHelper.SetAnimationPlay(v, "anim", "uieff_Quest_GrowthDayItem_Lock")
      ToastManager.ShowToast(StringTable.Get("str_quest_base_growth_login_and_open", index))
    end)
  end
end

function UIQuestGrowthItem:_Refresh_DayBtn()
  if self._dayBtns then
    for i, v in ipairs(self._dayBtns) do
      local red = self._questModule:GetGrowthRedPointNum(i)
      v:GetGameObject("red"):SetActive(0 < red)
      if v:IsLock() and not self._questModule:CheckQuestLock(i) then
        v:Unlock()
      end
      if not v:IsDone() and self._questModule:IsGrowthQuestAllTaken(true, i) then
        v:Done()
      end
      if i == self._dayIndex then
        local red = self._questModule:GetGrowthRedPointNum(i)
        self._selectedDayRed:SetActive(0 < red)
        local done = self._questModule:IsGrowthQuestAllTaken(true, i)
        self._selectedDayBG:SetActive(not done)
        self._selectedDayBGDone:SetActive(done)
      end
    end
  end
end

function UIQuestGrowthItem:_SetDaySelect(index)
  if self._dayIndex == index then
    return false
  end
  if not self._dayIndex then
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self:GetGameObject("_dayBtns").transform)
  end
  if self._dayIndex ~= nil then
    self:_SetUnDaySelect(self._dayIndex)
  end
  self._dayIndex = index
  self._selectedDayGO:SetActive(false)
  self._selectedDayGO:SetActive(true)
  local pos = self._dayBtns[index]:GetGameObject().transform.position
  self._selectedDayGO.transform.position = pos
  self.doTe1 = self._selectedDayGO.transform:DOMoveX(self._dayBtns[index]:GetGameObject().transform.position.x, 0.35)
  self._selectedDayTxt.text = index
  local red = self._questModule:GetGrowthRedPointNum(index)
  self._selectedDayRed:SetActive(0 < red)
  return true
end

function UIQuestGrowthItem:_SetUnDaySelect(index)
  self._unselectedDayGo:SetActive(false)
  self._unselectedDayGo:SetActive(true)
  self._dayBtns[index]:UnSelect()
  self._unselectedDayGo.transform.position = self._dayBtns[index]:GetGameObject().transform.position
  self._unselectedDayTxt.text = index
  local red = self._questModule:GetGrowthRedPointNum(index)
  self._unselectedOlddayred:SetActive(0 < red)
  local done = self._questModule:IsGrowthQuestAllTaken(false, index)
  self._unselectedOlddaybg:SetActive(not done)
  self._unselectedOlddaybgDone:SetActive(done)
end

function UIQuestGrowthItem:_SetGoalBtn()
  local cfgs = Cfg.cfg_quest_growth_goal({})
  self._goalBtns = UIWidgetHelper.SpawnObjects(self, "_goalBtns", "UIQuestGrowthTabBtn", #cfgs)
  for i, v in ipairs(self._goalBtns) do
    local lock = self._questModule:CheckQuestIILock(i)
    local done = self._questModule:IsGrowthQuestAllTaken(false, i)
    v:SetData(i, lock, done, function(index)
      AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSwitch)
      if self:_SetGoalSelect(index) then
        self:RefrenshList(true, true)
      end
    end, function(index)
      AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSwitch)
      UIWidgetHelper.SetAnimationPlay(v, "anim", "uieff_Quest_GrowthDayItem_Lock")
      ToastManager.ShowToast(StringTable.Get("str_quest_base_growth_tab_goal_lock"))
    end)
  end
end

function UIQuestGrowthItem:_Refresh_GoalBtn()
  if self._goalBtns then
    for i, v in ipairs(self._goalBtns) do
      local red = self._questModule:GetStage2GrowthRedPointNum(i)
      v:GetGameObject("red"):SetActive(0 < red)
      if v:IsLock() and not self._questModule:CheckQuestIILock(i) then
        v:Unlock()
      end
      if not v:IsDone() and self._questModule:IsGrowthQuestAllTaken(false, i) then
        v:Done()
      end
      if i == self._goalIndex then
        local red = self._questModule:GetStage2GrowthRedPointNum(i)
        self._selectedGoalRed:SetActive(0 < red)
        local done = self._questModule:IsGrowthQuestAllTaken(false, i)
        self._selectedGoalBG:SetActive(not done)
        self._selectedGoalBGDone:SetActive(done)
      end
    end
  end
end

function UIQuestGrowthItem:_SetGoalSelect(index)
  if self._goalIndex == index then
    return false
  end
  if not self._goalIndex then
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self:GetGameObject("_goalBtns").transform)
  end
  if self._goalIndex ~= nil then
    self:_SetUnGoalSelect(self._goalIndex)
  end
  self._goalIndex = index
  self._selectedGoalGO.transform.position = self._goalBtns[index]:GetGameObject().transform.position
  self._selectedGoalTxt.text = index
  local red = self._questModule:GetStage2GrowthRedPointNum(index)
  self._selectedGoalRed:SetActive(0 < red)
  self._selectedGoalCanvasGroup.alpha = 0
  self._selectedGoalCanvasGroup:DOFade(1, 0.5)
  return true
end

function UIQuestGrowthItem:_SetUnGoalSelect(index)
  self._unselectedGoaGo:SetActive(true)
  self._unselectedGoaGo.transform.position = self._goalBtns[index]:GetGameObject().transform.position
  self._unselectedGoaTxt.text = index
  self._goalBtns[index]:UnSelect()
  local red = self._questModule:GetStage2GrowthRedPointNum(index)
  self._unselectedungoalRed:SetActive(0 < red)
  local done = self._questModule:IsGrowthQuestAllTaken(true, index)
  self._unselectedungoalBG:SetActive(not done)
  self._unselectedungoalBGDone:SetActive(done)
  self._unselectedGoalCanvasGroup.alpha = 1
  self._unselectedGoalCanvasGroup:DOFade(0, 0.55)
end

function UIQuestGrowthItem:_Refresh_QuestList(TT, anim)
  self._questListGO.transform.localPosition = self._questListInitLocalPos
  local list = {
    self._questModule:GetQuestByDayIndex(self._dayIndex),
    self._questModule:GetQuestIIByStage(self._goalIndex)
  }
  local tempList = list[self._tabIndex]
  local awardQuestList = {
    tempList[10],
    tempList[11],
    tempList[12]
  }
  local questIndexDic = {}
  questIndexDic[tempList[10]] = 1
  questIndexDic[tempList[11]] = 2
  questIndexDic[tempList[12]] = 3
  table.sort(awardQuestList, function(a, b)
    local aStatus = a:Status()
    local bStatus = b:Status()
    if aStatus == bStatus then
      return a:QuestInfo().LayoutIdx < b:QuestInfo().LayoutIdx
    elseif aStatus == QuestStatus.QUEST_Completed then
      return true
    elseif bStatus == QuestStatus.QUEST_Completed then
      return false
    else
      return aStatus < bStatus
    end
  end)
  if anim then
    self._questListAnim:Stop()
  end
  self._questBGList:AsyncSpawnObjects(TT, "UIQuestGrowthQuestBGItem", 3)
  local questBGs = self._questBGList:GetAllSpawnList()
  for index, ui in ipairs(questBGs) do
    local quest = awardQuestList[index]
    local sortedId = questIndexDic[quest]
    ui:Flush(TT, sortedId, tempList, function()
      self:RefrenshList(anim)
    end, anim)
  end
  if anim then
    self._questListAnim:Play("uieffanim_UIQuestGrowthQuestBGItem_in")
  end
end

function UIQuestGrowthItem:_Refresh_Feather(anim)
  local hadTexs = {
    self._questModule:GetFeatherCount(),
    self._questModule:GetStage2FeatherCount()
  }
  local hadTex = hadTexs[self._tabIndex]
  local maxVals = {
    Cfg.cfg_global.GrowthQuestCount.IntValue,
    Cfg.cfg_global.GrowthQuestCount2.IntValue
  }
  local maxValue = maxVals[self._tabIndex]
  local cfg_feather = Cfg.cfg_quest_growth_feather({
    QuestStage = self._tabIndex
  })
  if cfg_feather then
    local count = #cfg_feather
    self._featherImage.fillAmount = hadTex / maxValue
    self._stageProgressTxt:SetText(hadTex .. "/" .. maxValue)
    local rect = self._featherPoolGo:GetComponent("RectTransform")
    local width = rect.sizeDelta.x
    self._featherPool:SpawnObjects("UIQuestGrowthFeatherItem", count)
    self._featherItems = self._featherPool:GetAllSpawnList()
    local lastWidth = 0
    for i = 1, count do
      local needCount = cfg_feather[i].NeedCount
      local itemWidth = width / maxValue * needCount
      local reward = cfg_feather[i].Reward
      local id = reward[1][1]
      local rewardCount = reward[1][2]
      local showAnimDelay = 0.055 * (i - 1)
      self._featherItems[i]:SetData(self._tabIndex, cfg_feather[i].ID, itemWidth, lastWidth, id, rewardCount, needCount, hadTex, showAnimDelay, anim)
      lastWidth = itemWidth
    end
  end
end

function UIQuestGrowthItem:_ClearNew(index)
  if index == 2 then
    local new = self._questModule:GetNewPoint(QuestType.QT_Growth)
    if new then
      self._questModule:SetGrowthNewPoint()
    end
  end
end

function UIQuestGrowthItem:lookOnClick()
  local id = self._bigAwardPetID
  Log.info("UIQuestGrowthItem:lookOnClick() id = ", id)
  if id then
    local itemModule = self:GetModule(ItemModule)
    if itemModule:IsChoosePetGift(id) then
      self:ShowDialog("UIPetBackPackBox", id, true)
    else
      self:ShowDialog("UIShopPetDetailController", id)
    end
  end
end

function UIQuestGrowthItem:Stage1AwardBtnOnClick()
  local id = Cfg.cfg_global.UIQuestGrowthLookIcon.IntValue
  self:ShowDialog("UIShopPetDetailController", id)
end

function UIQuestGrowthItem:Stage2AwardBtnOnClick()
  local id = Cfg.cfg_global.UIQuestGrowthLookIcon_2.IntValue
  self:ShowDialog("UIPetBackPackBox", id, true)
end

function UIQuestGrowthItem:Stage1btnOnClick()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSwitch)
  if self._tabIndex == 1 then
    return
  end
  self:_SetTabSelect(1)
  self:RefrenshList(true)
  self:_ClearNew(1)
end

function UIQuestGrowthItem:Stage2btnOnClick()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSwitch)
  if self._tabIndex == 2 then
    return
  end
  self:_ClearNew(2)
  if self._questModule:CheckQuestIILock(1) then
    ToastManager.ShowToast(StringTable.Get("str_quest_base_growth_tab_btn_lock"))
    return
  end
  self:_SetTabSelect(2)
  self:RefrenshList(true)
end

function UIQuestGrowthItem:OnUIGetItemCloseInQuest(type)
  if self._isOpen then
    self:RefrenshList()
  end
end

function UIQuestGrowthItem:getOnClick()
  self:Lock("UIQuestGet")
  GameGlobal.GetModule(PetModule):GetAllPetsSnapshoot()
  self:StartTask(self.OngetOnClick, self)
end

function UIQuestGrowthItem:OngetOnClick(TT)
  local petquest = self._questModule:GetQuestByDay(0)
  local res, msg = self._questModule:TakeQuestReward(TT, petquest[0]:QuestInfo().quest_id)
  self:UnLock("UIQuestGet")
  if self.uiOwner == nil then
    return
  end
  if res:GetSucc() then
    local rewards = msg.rewards
    self:ShowDialog("UIPetObtain", rewards, function()
      GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
      self:ShowDialog("UIGetItemController", rewards, function()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, QuestType.QT_Growth)
      end)
    end)
  end
end

function UIQuestGrowthItem:GetAward(index)
  return self.awards and self.awards[index] and self.awards[index]:GetGameObject("bg")
end
