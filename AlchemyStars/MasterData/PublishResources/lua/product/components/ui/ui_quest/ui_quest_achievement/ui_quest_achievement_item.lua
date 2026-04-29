_class("UIQuestAchievementItem", UICustomWidget)
UIQuestAchievementItem = UIQuestAchievementItem

function UIQuestAchievementItem:OnShow(uiParams)
  self._transition = self:GetUIComponent("ATransitionComponent", "UIQuestAchievementItem")
  self._anim = self:GetUIComponent("Animation", "UIQuestAchievementItem")
  self._canvasGroup = self:GetUIComponent("CanvasGroup", "UIQuestAchievementItem")
  self._canvasGroup.blocksRaycasts = false
  self:AttachEvent(GameEventType.QuestUpdate, self.QuestUpdate)
  self:AttachEvent(GameEventType.OnAchievePointFinish, self.QuestUpdate)
  self:AttachEvent(GameEventType.RolePropertyChanged, self.QuestUpdate)
  self._questModule = GameGlobal.GetModule(QuestModule)
  self._itemCountPerRow = 1
  self._enum = 0
  self._allEnum = 1
  self._startEnum = self._allEnum
  self:AttachEvents()
end

function UIQuestAchievementItem:QuestUpdate()
  if self._isOpen then
    self:_InitAchTypePool()
    self:RefreshTypeRate()
    self:AchievePointRed()
    self:RefreshPointAward()
  end
end

function UIQuestAchievementItem:SetData(type)
  if self._listInitAnimateTask then
    GameGlobal.TaskManager():KillTask(self._listInitAnimateTask)
  end
  self._canvasGroup.blocksRaycasts = true
  self._canvasGroup.alpha = 1
  self._transition:PlayEnterAnimation(true)
  self._isIntro = not self._isOpen
  self._isOpen = true
  self:_GetComponents()
  self._type = type
  self._cfg_quest_achieve_type = Cfg.cfg_quest_achieve_type({})
  if self._cfg_quest_achieve_type == nil then
    Log.fatal("[quest] error --> _cfg_quest_achieve_type is nil !")
    return
  end
  self:_OnValue()
  self._listInitAnimateTask = GameGlobal.TaskManager():StartTask(function(TT)
    YIELD(TT, 500)
    self._isIntro = false
  end)
end

function UIQuestAchievementItem:OnHide()
  self:RemoveEvents()
end

function UIQuestAchievementItem:CheckRedState(enum)
  local redInfo = self._questModule:GetAchRedPoint()
  return redInfo[enum]
end

function UIQuestAchievementItem:_GetComponents()
  self._detailGo = self:GetGameObject("detailGo")
  self._allGo = self:GetGameObject("allGo")
  self._achPointRedPoint = self:GetGameObject("red")
  self._detailScrollView = self:GetUIComponent("UIDynamicScrollView", "taskDetailList")
  self._achTypePool = self:GetUIComponent("UISelectObjectPath", "achTypePool")
  self._achieveTopTypePool = self:GetUIComponent("UISelectObjectPath", "achieveTopTypePool")
  self._allViewFillAmont = self:GetUIComponent("Image", "allViewFillAmont")
  self._allViewValue = self:GetUIComponent("UILocalizationText", "allViewValue")
  self._allViewValue2 = self:GetUIComponent("UILocalizedTMP", "allViewValue2")
  self._pointAwardItemGo = self:GetGameObject("pointAwardPool")
  local pointAwardPool = self:GetUIComponent("UISelectObjectPath", "pointAwardPool")
  self._pointAwardItem = pointAwardPool:SpawnObject("UIQuestSideAwardItem")
  self._typeRateValTex = self:GetUIComponent("UILocalizationText", "typeRateValTex")
  self._typeRateImg = self:GetUIComponent("Image", "typeRateImg")
  self._pointAwardComplete = self:GetGameObject("AwardComplete")
end

function UIQuestAchievementItem:GetCanCollectQuestByAchieveEnum()
  local ret = {}
  local achieveList = self:GetList()
  for key, value in pairs(achieveList) do
    if value.status == QuestStatus.QUEST_Completed then
      table.insert(ret, value)
    end
  end
  return ret
end

function UIQuestAchievementItem:TypeAllBtnOnClick(go)
  local list = self:GetCanCollectQuestByAchieveEnum()
  if list and next(list) then
    self:Lock("UIQuestAchievementItem:TypeAllBtnOnClick")
    GameGlobal.TaskManager():StartTask(self.OnTypeAllBtnOnClick, self, list)
  else
    Log.debug("###[UIQuestAchievementItem] no collect achieve quest!")
  end
end

function UIQuestAchievementItem:OnTypeAllBtnOnClick(TT, list)
  local idList = {}
  for key, value in pairs(list) do
    table.insert(idList, value.quest_id)
  end
  Log.debug("###[UIQuestAchievementItem] OnTypeAllBtnOnClick count:", #idList)
  local res, msg = self._questModule:TakeOneKeyReward(TT, QuestType.QT_None, idList)
  self:UnLock("UIQuestAchievementItem:TypeAllBtnOnClick")
  if res:GetSucc() then
    if self.uiOwner == nil then
      return
    end
    local tempPets = {}
    local pets = msg.rewards
    self._tempMsgRewards = msg.rewards
    if 0 < #pets then
      for i = 1, #pets do
        local ispet = GameGlobal.GetModule(PetModule):IsPetID(pets[i].assetid)
        if ispet then
          table.insert(tempPets, pets[i])
        end
      end
    end
    if 0 < #tempPets then
      self:ShowDialog("UIPetObtain", tempPets, function()
        GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIPetObtainCloseInQuest, QuestType.QT_Achieve + 10000)
      end)
    elseif 0 < table.count(msg.rewards) then
      self:ShowDialog("UIGetItemController", msg.rewards, function()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, QuestType.QT_Achieve + 10000)
      end)
    else
      local tips = StringTable.Get("str_physicalpower_error_phy_add_full")
      ToastManager.ShowToast(tips)
    end
  else
    local result = res:GetResult()
    Log.error("###[UIQuestAchievementItem] TakeOneKeyReward fail,result:", result)
  end
end

function UIQuestAchievementItem:AllBtnOnClick()
  self._allGo:SetActive(true)
  self._detailGo:SetActive(false)
  self._enum = self._allEnum
  self:PlayTypesAnim()
end

function UIQuestAchievementItem:ShowInfoOfEnum(enum, startAnim)
  if self._enum == enum then
    if startAnim then
      self._allGo:SetActive(false)
      self._allGo:SetActive(true)
      self:PlayTypesAnim()
    end
    return
  end
  self._enum = enum
  if self._enum == self._allEnum then
    self._allGo:SetActive(false)
    self._allGo:SetActive(true)
    self._detailGo:SetActive(false)
    self:RefreshPointAward()
    self:PlayTypesAnim()
  else
    self._allGo:SetActive(false)
    self._detailGo:SetActive(true)
    self._playAnim = true
    self:_RefrenshDetailScrollView(true)
    self:RefreshTopTypePool()
    self:RefreshTypeRate()
  end
end

function UIQuestAchievementItem:RefreshPointAward()
  local achievePointCfg = Cfg.cfg_achieve_reward({})
  local id
  for index, value in ipairs(achievePointCfg) do
    local got = self._questModule:IsGotAchPointReward(value.ID)
    if not got then
      id = value.ID
      break
    end
  end
  self._pointAwardItemGo:SetActive(id ~= nil)
  local allViewType = self._cfg_quest_achieve_type[self._allEnum].BigTypeEnum
  local allViewNowValue, allViewAllValue = self:GetCountByType(allViewType)
  if id then
    local cfg_award = achievePointCfg[id]
    local itemid = cfg_award.Reward[1][1]
    local cfg_item = Cfg.cfg_item[itemid]
    local params = {}
    params.quality = cfg_item.Color
    params.icon = cfg_item.Icon
    params.text = cfg_award.Reward[1][2]
    allViewAllValue = cfg_award.AchPoint
    self._pointAwardItem:SetData(itemid, params, function(matid, pos)
      self:PointItemClick(matid, pos)
    end)
    self._pointAwardComplete:SetActive(allViewNowValue >= allViewAllValue)
  end
  local rate = allViewNowValue / allViewAllValue
  if 1 < rate then
    rate = 1
  end
  self._allViewFillAmont.fillAmount = rate
  self._allViewValue:SetText(allViewNowValue)
  self._allViewValue2:SetText("/" .. allViewAllValue)
end

function UIQuestAchievementItem:PointItemClick(matid, pos)
  local achievePointCfg = Cfg.cfg_achieve_reward({})
  local id
  for index, value in ipairs(achievePointCfg) do
    local got = self._questModule:IsGotAchPointReward(value.ID)
    if not got then
      id = value.ID
      break
    end
  end
  local allViewType = self._cfg_quest_achieve_type[self._allEnum].BigTypeEnum
  local allViewNowValue, allViewAllValue = self:GetCountByType(allViewType)
  if id then
    local cfg_award = achievePointCfg[id]
    allViewAllValue = cfg_award.AchPoint
    if allViewNowValue >= allViewAllValue then
      self:QuickGetAchievePoint(id)
      return
    end
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.QuestAwardItemClick, matid, pos)
end

function UIQuestAchievementItem:QuickGetAchievePoint(id)
  GameGlobal.GetModule(PetModule):GetAllPetsSnapshoot()
  self:Lock("UIQuestAchievementItem:QuickGetAchievePoint")
  self:StartTask(self.OnQuickGetAchievePoint, self, id)
end

function UIQuestAchievementItem:OnQuickGetAchievePoint(TT, id)
  local res, msg = self._questModule:TakeAchReward(TT, id)
  self:UnLock("UIQuestAchievementItem:QuickGetAchievePoint")
  if self.uiOwner == nil then
    return
  end
  if res:GetSucc() then
    local tempPets = {}
    local pets = msg.rewards
    self._tempMsgRewards = msg.rewards
    if 0 < #pets then
      for i = 1, #pets do
        local ispet = GameGlobal.GetModule(PetModule):IsPetID(pets[i].assetid)
        if ispet then
          table.insert(tempPets, pets[i])
        end
      end
    end
    if 0 < #tempPets then
      self:ShowDialog("UIPetObtain", tempPets, function()
        GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIPetObtainCloseInQuest, QuestType.QT_Achieve + 100, id)
      end)
    else
      self:ShowDialog("UIGetItemController", msg.rewards, function()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, QuestType.QT_Achieve + 100, id)
      end)
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnAchievePointFinish)
  else
    Log.fatal("###questModule:TakeAchReward - res:", res:GetResult(), " -id --> ", id)
  end
end

function UIQuestAchievementItem:RefreshTypeRate()
  local nowValue, allValue = self:GetCountByType(self._enum)
  self._typeRateValTex:SetText("<color=#bc9a70>" .. nowValue .. "</color>/" .. allValue)
  local rate
  if allValue == 0 then
    rate = 0
  else
    rate = nowValue / allValue
  end
  self._typeRateImg.fillAmount = rate
end

function UIQuestAchievementItem:RefreshTopTypePool()
  local pools = self._achieveTopTypePool:GetAllSpawnList()
  for key, value in pairs(pools) do
    value:Select(self._enum)
  end
end

function UIQuestAchievementItem:_InitDetailScrollView()
  self._detailScrollView:InitListView(0, function(scrollView, index)
    return self:_OnInitDetailScrollView(scrollView, index)
  end)
end

function UIQuestAchievementItem:GetList()
  local qlbt = self:GetQuestList()
  local tempList = {}
  for i = 1, table.count(qlbt) do
    local quest = qlbt[i]:QuestInfo()
    if quest.AchieveType == self._enum then
      table.insert(tempList, quest)
    end
  end
  return tempList
end

function UIQuestAchievementItem:GetQuestList()
  local taskList = self._questModule:GetQuestByQuestType(self._type)
  local taskListT = {}
  for i = 1, #taskList do
    local quest = taskList[i]:QuestInfo()
    if quest.status ~= QuestStatus.QUEST_NotStart then
      table.insert(taskListT, taskList[i])
    end
  end
  return taskListT
end

function UIQuestAchievementItem:_OnInitDetailScrollView(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIQuestAchievementLatelyAchieveItem", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local heartItem = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    self:_ShowAchieveItem(heartItem, itemIndex)
  end
  return item
end

function UIQuestAchievementItem:_ShowAchieveItem(heartItem, itemIndex)
  local data = self._questDataList[itemIndex]
  heartItem:GetGameObject():SetActive(true)
  if data ~= nil then
    heartItem:SetData(itemIndex, data, function(questInfo)
      self:_AchievementClick(questInfo.quest_id)
    end, function(matid, pos)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.QuestAwardItemClick, matid, pos)
    end, nil, self._playAnim)
  end
end

function UIQuestAchievementItem:_AchievementClick(id)
  self:Lock("UIQuestGet")
  GameGlobal.GetModule(PetModule):GetAllPetsSnapshoot()
  self:StartTask(self._OnGet, self, id)
end

function UIQuestAchievementItem:OnUIPetObtainCloseInQuest(type)
  if self._isOpen and type == QuestType.QT_Achieve then
    self:ShowDialog("UIGetItemController", self._tempMsgRewards, function()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, QuestType.QT_Achieve)
    end)
  end
end

function UIQuestAchievementItem:AttachEvents()
  self:AttachEvent(GameEventType.RolePropertyChanged, self._OnRedChanged)
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
  self:AttachEvent(GameEventType.OnUIPetObtainCloseInQuest, self.OnUIPetObtainCloseInQuest)
end

function UIQuestAchievementItem:RemoveEvents()
  self:DetachEvent(GameEventType.RolePropertyChanged, self._OnRedChanged)
  self:DetachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
  self:DetachEvent(GameEventType.OnUIPetObtainCloseInQuest, self.OnUIPetObtainCloseInQuest)
end

function UIQuestAchievementItem:OnUIGetItemCloseInQuest(type)
  if self._isOpen and type == QuestType.QT_Achieve then
    self:RefrenshList()
  end
end

function UIQuestAchievementItem:_OnGet(TT, id)
  local res, msg = self._questModule:TakeQuestReward(TT, id)
  self:UnLock("UIQuestGet")
  if self.uiOwner == nil then
    return
  end
  if res:GetSucc() then
    local tempPets = {}
    local pets = msg.rewards
    self._tempMsgRewards = msg.rewards
    if 0 < #pets then
      for i = 1, #pets do
        local ispet = GameGlobal.GetModule(PetModule):IsPetID(pets[i].assetid)
        if ispet then
          table.insert(tempPets, pets[i])
        end
      end
    end
    if 0 < #tempPets then
      self:ShowDialog("UIPetObtain", tempPets, function()
        GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIPetObtainCloseInQuest, QuestType.QT_Achieve)
      end)
    else
      self:ShowDialog("UIGetItemController", msg.rewards, function()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, QuestType.QT_Achieve)
      end)
    end
  end
end

function UIQuestAchievementItem:GetCountByType(enum)
  local cur, total, taken = self._questModule:GetAchieveCount(enum)
  return taken, total
end

function UIQuestAchievementItem:_InitAchTypePool()
  local tempTab = {}
  for i = 1, #self._cfg_quest_achieve_type do
    if i ~= self._allEnum then
      table.insert(tempTab, self._cfg_quest_achieve_type[i])
    end
  end
  local count = table.count(tempTab)
  self._achTypePool:SpawnObjects("UIQuestAchievementAchieveTypeItem", count)
  local items = self._achTypePool:GetAllSpawnList()
  for i = 1, count do
    local name = tempTab[i].BigTypeName
    local type = tempTab[i].BigTypeEnum
    local nowValue, allValue = self:GetCountByType(type)
    local sprite = tempTab[i].Icon
    local yieldTime
    if i <= 3 then
      yieldTime = 0
    else
      yieldTime = 50
    end
    items[i]:SetData(type, sprite, name, nowValue, allValue, function(enum)
      self:OnTypeBtnClick(enum)
    end)
  end
end

function UIQuestAchievementItem:PlayTypesAnim()
  local tempTab = {}
  for i = 1, #self._cfg_quest_achieve_type do
    if i ~= self._allEnum then
      table.insert(tempTab, self._cfg_quest_achieve_type[i])
    end
  end
  local count = table.count(tempTab)
  local items = self._achTypePool:GetAllSpawnList()
  for i = 1, count do
    local yieldTime
    if i <= 3 then
      yieldTime = 0
    else
      yieldTime = 100
    end
    items[i]:PlayAnim(yieldTime)
  end
end

function UIQuestAchievementItem:OnTypeBtnClick(enum)
  self:ShowInfoOfEnum(enum)
end

function UIQuestAchievementItem:OnClose()
  self._isOpen = false
  self._anim:Stop()
  self._canvasGroup.alpha = 0
  self._canvasGroup.blocksRaycasts = false
end

function UIQuestAchievementItem:_OnValue()
  self:_InitAchTypePool()
  self:InitAchTopTypePool()
  self:_InitDetailScrollView()
  self:ShowInfoOfEnum(self._startEnum, true)
  self:AchievePointRed()
end

function UIQuestAchievementItem:InitAchTopTypePool()
  local tempTab = {}
  for i = 1, #self._cfg_quest_achieve_type do
    if i ~= self._allEnum then
      table.insert(tempTab, self._cfg_quest_achieve_type[i])
    end
  end
  local count = table.count(tempTab)
  self._achieveTopTypePool:SpawnObjects("UIQuestAchievementTypeListItem", count)
  local items = self._achieveTopTypePool:GetAllSpawnList()
  for i = 1, count do
    local name = tempTab[i].BigTypeNameSpace
    local type = tempTab[i].BigTypeEnum
    local sprite1 = tempTab[i].Icon1
    local sprite2 = tempTab[i].Icon2
    items[i]:SetData(type, sprite1, sprite2, name, function(enum)
      self:OnTypeBtnClick(enum)
    end)
  end
end

function UIQuestAchievementItem:AchievePointRed()
  local achPointRedPoint = self._questModule:GetUnReceivedAchRewardsBoxNum() > 0
  self._achPointRedPoint:SetActive(achPointRedPoint)
end

function UIQuestAchievementItem:_OnRedChanged()
  if self._isOpen then
    self:AchievePointRed()
  end
end

function UIQuestAchievementItem:RefrenshList(movePos)
  if self._enum ~= self._allEnum then
    self._questModule:SetSortDirty(self._type)
    self:_RefrenshDetailScrollView(movePos)
  end
end

function UIQuestAchievementItem:_RefrenshDetailScrollView(movePos)
  self._questDataList = self:GetList()
  self._questDataListCount = table.count(self._questDataList)
  local contentPos = self._detailScrollView.ScrollRect.content.localPosition
  self._detailScrollView:SetListItemCount(self._questDataListCount)
  self._detailScrollView:MovePanelToItemIndex(0, 0)
  if not movePos then
    self._detailScrollView.ScrollRect:StopMovement()
    self._detailScrollView.ScrollRect.content.localPosition = contentPos
  end
  self._playAnim = false
end

function UIQuestAchievementItem:OpenAchieveMentPointOnClick()
  self:ShowDialog("UIQuestAchievementPointAwardsController")
end

function UIQuestAchievementItem:AllGetBtnOnClick()
  local list = {}
  local quests = self._questModule:GetQuestByQuestType(QuestType.QT_Achieve)
  for _, quest in ipairs(quests) do
    local qinfo = quest:QuestInfo()
    if qinfo.status == QuestStatus.QUEST_Completed then
      table.insert(list, qinfo)
    end
  end
  if list and next(list) then
    self:Lock("AllGetBtnOnClick")
    self:StartTask(self._OnAllGet, self, list)
  else
    Log.debug("###[UIQuestAchievementItem] no quest complete !")
  end
end

function UIQuestAchievementItem:_OnAllGet(TT, list)
  local idList = {}
  for key, value in pairs(list) do
    table.insert(idList, value.quest_id)
  end
  Log.debug("###[UIQuestAchievementItem] OnTypeAllBtnOnClick count:", #idList)
  local res, msg = self._questModule:TakeOneKeyReward(TT, QuestType.QT_None, idList)
  self:UnLock("AllGetBtnOnClick")
  if res:GetSucc() then
    if self.uiOwner == nil then
      return
    end
    local tempPets = {}
    local pets = msg.rewards
    self._tempMsgRewards = msg.rewards
    if msg.rewards and table.count(msg.rewards) > 0 then
      self:ShowDialog("UIQuestAchievementFinishList", list, function()
        if 0 < #pets then
          for i = 1, #pets do
            local ispet = GameGlobal.GetModule(PetModule):IsPetID(pets[i].assetid)
            if ispet then
              table.insert(tempPets, pets[i])
            end
          end
        end
        if 0 < #tempPets then
          self:ShowDialog("UIPetObtain", tempPets, function()
            GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
            GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIPetObtainCloseInQuest, QuestType.QT_Achieve + 10000)
          end)
        elseif 0 < table.count(msg.rewards) then
          self:ShowDialog("UIGetItemController", msg.rewards, function()
            GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, QuestType.QT_Achieve + 10000)
          end)
        else
          local tips = StringTable.Get("str_physicalpower_error_phy_add_full")
          ToastManager.ShowToast(tips)
        end
      end)
    else
      do
        local tips = StringTable.Get("str_physicalpower_error_phy_add_full")
        ToastManager.ShowToast(tips)
      end
    end
  else
    local result = res:GetResult()
    Log.error("###[UIQuestAchievementItem] AllGetBtnOnClick fail,result:", result)
  end
end

function UIQuestAchievementItem:OnUIPetObtainCloseInQuest(type)
  if type == QuestType.QT_Achieve + 10000 then
    self:ShowDialog("UIGetItemController", self._tempMsgRewards, function()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, QuestType.QT_Achieve + 10000)
    end)
  end
end

function UIQuestAchievementItem:OnUIGetItemCloseInQuest(type)
  if type == QuestType.QT_Achieve + 10000 then
    self:RefrenshList()
  end
end
