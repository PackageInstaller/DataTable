_class("UIQuestController", UIController)
UIQuestController = UIQuestController
local ClientQuestType = {
  QT_None = 0,
  QT_Main = 1,
  QT_Daily = 2,
  QT_Branch = 3,
  QT_Growth = 4,
  QT_Achieve = 5,
  QT_Season = 10001
}
_enum("ClientQuestType", ClientQuestType)

function UIQuestController:LoadDataOnEnter(TT, res, uiParams)
  self._canShare = self:GetModule(ShareModule):CanShare()
  local questModule = self:GetModule(QuestModule)
  questModule:CalReqQuestDailyRefreshTime(TT)
  questModule:CalcRedPoint()
  self._showSeasonTab = false
  self._seasonModule = GameGlobal.GetModule(SeasonModule)
  local seasonid = self._seasonModule:GetCurSeasonID()
  if seasonid and 0 < seasonid then
    local className, prefabName = UISeasonHelper.GetCurSeasonQuestContent()
    if className then
      local resSeason = self._seasonModule:ForceRequestCurSeasonData(TT)
      if resSeason:GetSucc() then
        local component = self._seasonModule:GetCurSeasonQuestComponent()
        if component then
          local isOpen = component:ComponentIsOpen()
          if isOpen then
            self._showSeasonTab = true
          end
        end
      end
    end
  end
  res:SetSucc(true)
end

function UIQuestController:OnShow(uiParams)
  self._goTab = {}
  self._controllerTab = {}
  self._first = 1
  self._storyItem = nil
  self._dailyItem = nil
  self._sideItem = nil
  self._growthItem = nil
  self._achieveItem = nil
  self:_GetComponents()
  self:AttachEvent(GameEventType.ChangeQuestController, self.ChangeQuestController)
  self:AttachEvent(GameEventType.QuestUpdate, self.QuestUpdate)
  self:AttachEvent(GameEventType.QuestAwardItemClick, self.QuestAwardItemClick)
  self:AttachEvent(GameEventType.QuestGotoRefresh, self.GotoRefresh)
  self:AttachEvent(GameEventType.SeasonQuestCloseCB, self.SeasonQuestCloseCB)
  self._cfg_type = Cfg.cfg_quest_main_type({})
  self._type_open_state = {}
  self:_CheckQuestOpenState()
  self._currrentIndex = 1
  self._params = nil
  if uiParams[1] then
    self._currrentType = uiParams[1]
    local questModule = self:GetModule(QuestModule)
    if self._currrentType == ClientQuestType.QT_Growth and not questModule:IsGrowthVisible() then
      if table.count(self._type_open_state) > 0 then
        self._currrentType = self._type_open_state[self._currrentIndex].ClientType
      end
    else
      self._params = uiParams[2]
      for i = 1, table.count(self._type_open_state) do
        if self._currrentType == self._type_open_state[i].ClientType then
          self._currrentIndex = i
          break
        end
      end
    end
  elseif table.count(self._type_open_state) > 0 then
    self._currrentType = self._type_open_state[self._currrentIndex].ClientType
  end
  self._rtTexGo = self:GetGameObject("RtTex")
  local cachFunc = uiParams[3]
  if cachFunc then
    self.rectTex = cachFunc()
  end
  if self.rectTex == nil then
    self._rtTexGo:SetActive(false)
  else
    self._rtTexGo:SetActive(true)
    local isRt = UIWidgetHelper.SetRawImageTexture(self, "RtTex", self.rectTex)
  end
  self:_OnValue()
  self:StartTask(self._ShowLock, self)
end

function UIQuestController:_ShowLock(TT)
  self:Lock("UIQuestController.Show")
  YIELD(TT, 500)
  self:UnLock("UIQuestController.Show")
end

function UIQuestController:OnHide()
  self:DetachEvent(GameEventType.ChangeQuestController, self.ChangeQuestController)
  self:DetachEvent(GameEventType.QuestUpdate, self.QuestUpdate)
  self:DetachEvent(GameEventType.QuestAwardItemClick, self.QuestAwardItemClick)
  self:UnLock("LoadSeasonQuestData")
end

function UIQuestController:GotoRefresh()
  self:_OnValue()
end

function UIQuestController:ChangeQuestController(uiParams)
  for i = 1, table.count(self._type_open_state) do
    if uiParams == self._type_open_state[i].ClientType then
      self:_ItemClick(i, uiParams)
      return
    end
  end
  Log.error("jump error , target is not open !")
end

function UIQuestController:QuestUpdate()
  self._controllerTab[self._currrentType]:RefrenshList()
end

function UIQuestController:QuestAwardItemClick(matid, pos)
  self._selectInfo:SetData(matid, pos)
end

function UIQuestController:SetBackBtnActive(active)
  self._backBtnsGo:SetActive(active)
end

function UIQuestController:_GetComponents()
  self._detailPool = self:GetUIComponent("UISelectObjectPath", "detailPool")
  self._detailPoolGo = self:GetGameObject("detailPool")
  self._detailPoolGrid = self:GetUIComponent("GridLayoutGroup", "detailPool")
  self._canvasGroup = self:GetUIComponent("CanvasGroup", "Center")
  self._itemInfo = self:GetUIComponent("UISelectObjectPath", "itemInfo")
  self._selectInfo = self._itemInfo:SpawnObject("UISelectInfo")
  local backBtns = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self._backBtnsGo = self:GetGameObject("backBtns")
  self._backBtns = backBtns:SpawnObject("UINewCommonTopButton")
  self._backBtns:SetData(function()
    self:CloseDialog()
  end)
  self._safeArea = self:GetUIComponent("RectTransform", "SafeArea")
  self._canvas = self._safeArea.parent:GetComponent("RectTransform")
  local safesize = self._canvas.rect.size
  safesize.x = safesize.x * (self._safeArea.anchorMax.x - self._safeArea.anchorMin.x)
  safesize.x = safesize.x + 1
  safesize.y = safesize.y + 1
  self._cellSize = safesize
  self._pools = self:GetUIComponent("UISelectObjectPath", "pools")
  self:_InitTypeComponents()
  self._backGrabScreen = self:GetGameObject("backGrabScreen")
  self._backGrabScreen:SetActive(true)
end

function UIQuestController:_InitTypeComponents()
  self._dailyTypeGrid = self:GetUIComponent("GridLayoutGroup", "dailyTypePool")
  self._dailyTypePool = self:GetUIComponent("UISelectObjectPath", "dailyTypePool")
  self._dailyItem = self._dailyTypePool:SpawnObject("UIQuestDailyItem")
  self._dailyTypeGo = self:GetGameObject("dailyTypePool")
  self._goTab[ClientQuestType.QT_Daily] = self._dailyTypeGo
  self._controllerTab[ClientQuestType.QT_Daily] = self._dailyItem
  self._storyTypeGrid = self:GetUIComponent("GridLayoutGroup", "dailyTypePool")
  self._storyTypePool = self:GetUIComponent("UISelectObjectPath", "storyTypePool")
  self._storyItem = self._storyTypePool:SpawnObject("UINewQuestStoryItem")
  self._storyTypeGo = self:GetGameObject("storyTypePool")
  self._goTab[ClientQuestType.QT_Main] = self._storyTypeGo
  self._controllerTab[ClientQuestType.QT_Main] = self._storyItem
  self._sideTypeGrid = self:GetUIComponent("GridLayoutGroup", "dailyTypePool")
  self._sideTypePool = self:GetUIComponent("UISelectObjectPath", "sideTypePool")
  self._sideItem = self._sideTypePool:SpawnObject("UIQuestSideItem")
  self._sideTypeGo = self:GetGameObject("sideTypePool")
  self._goTab[ClientQuestType.QT_Branch] = self._sideTypeGo
  self._controllerTab[ClientQuestType.QT_Branch] = self._sideItem
  self._growthTypeGrid = self:GetUIComponent("GridLayoutGroup", "dailyTypePool")
  self._growthTypePool = self:GetUIComponent("UISelectObjectPath", "growthTypePool")
  self._growthItem = self._growthTypePool:SpawnObject("UIQuestGrowthItem")
  self._growthTypeGo = self:GetGameObject("growthTypePool")
  self._goTab[ClientQuestType.QT_Growth] = self._growthTypeGo
  self._controllerTab[ClientQuestType.QT_Growth] = self._growthItem
  self._achieveTypeGrid = self:GetUIComponent("GridLayoutGroup", "dailyTypePool")
  self._achieveTypePool = self:GetUIComponent("UISelectObjectPath", "achieveTypePool")
  self._achieveItem = self._achieveTypePool:SpawnObject("UIQuestAchievementItem")
  self._achieveTypeGo = self:GetGameObject("achieveTypePool")
  self._goTab[ClientQuestType.QT_Achieve] = self._achieveTypeGo
  self._controllerTab[ClientQuestType.QT_Achieve] = self._achieveItem
  if self._showSeasonTab then
    self._seasonTypePool = self:GetUIComponent("UISelectObjectPath", "seasonTypePool")
    self._seasonItem = self._seasonTypePool:SpawnObject("UIQuestSeasonItem")
    self._seasonTypeGo = self:GetGameObject("seasonTypePool")
    self._goTab[ClientQuestType.QT_Season] = self._seasonTypeGo
    self._controllerTab[ClientQuestType.QT_Season] = self._seasonItem
  end
end

function UIQuestController:_CheckQuestOpenState()
  local module = GameGlobal.GetModule(QuestModule)
  if module == nil then
    Log.fatal("[quest] error --> module is nil !")
    return
  end
  for i = 1, table.count(self._cfg_type) do
    if self._cfg_type[i].ClientType == ClientQuestType.QT_Season then
      if self._showSeasonTab then
        table.insert(self._type_open_state, self._cfg_type[i])
      end
    elseif module:CheckQuestTypeUnlock(self._cfg_type[i].RealType) then
      if self._cfg_type[i].RealType == QuestType.QT_Growth then
        if module:IsGrowthVisible() then
          table.insert(self._type_open_state, self._cfg_type[i])
        end
      elseif self._cfg_type[i].RealType == QuestType.QT_Branch then
        local taskList = module:GetQuestByQuestType(self._cfg_type[i].RealType)
        local taskListT = {}
        for i = 1, #taskList do
          local quest = taskList[i]:QuestInfo()
          if quest.status ~= QuestStatus.QUEST_NotStart then
            table.insert(taskListT, taskList[i])
          end
        end
        if 0 < #taskListT then
          table.insert(self._type_open_state, self._cfg_type[i])
        end
      else
        table.insert(self._type_open_state, self._cfg_type[i])
      end
    end
  end
end

function UIQuestController:_OnValue()
  self._pools:SpawnObjects("UIQuestTypeBtnItem", table.count(self._type_open_state))
  self._type_btns = self._pools:GetAllSpawnList()
  for i = 1, table.count(self._type_open_state) do
    self._type_btns[i]:SetData(i, self._type_open_state[i], function(idx, type)
      self:_ItemClick(idx, type)
    end)
  end
  self:_ShowInfo()
end

function UIQuestController:_ItemClick(idx, type)
  if idx == self._currrentIndex then
    return
  end
  if type == ClientQuestType.QT_Season then
    self:Lock("LoadSeasonQuestData")
    GameGlobal.TaskManager():StartTask(self.LoadSeasonQuestData, self, idx, type)
  else
    self:ShowClickInfo(idx, type)
  end
end

function UIQuestController:ShowClickInfo(idx, type)
  if self._currrentIndex ~= 0 then
    self._type_btns[self._currrentIndex]:Select(false)
  end
  self._controllerTab[self._currrentType]:OnClose()
  self._currrentIndex = idx
  self._currrentType = type
  self:_ShowInfo()
  self:_ShowShareBtn()
end

function UIQuestController:LoadSeasonQuestData(TT, idx, type)
  local succ = true
  self:UnLock("LoadSeasonQuestData")
  if succ then
    if not self._seasonModule then
      self._seasonModule = GameGlobal.GetModule(SeasonModule)
    end
    local seasonid = self._seasonModule:GetCurSeasonID()
    local component = self._seasonModule:GetCurSeasonQuestComponent()
    local isOpen = false
    if component then
      isOpen = component:ComponentIsOpen()
    end
    if 0 < seasonid and isOpen then
      Log.debug("###[UIQuestController] _ItemClick season type is open !")
    else
      Log.debug("###[UIQuestController] _ItemClick season type is close !")
      self:SeasonQuestCloseCB()
      return
    end
    self:ShowClickInfo(idx, type)
  else
    local tips = StringTable.Get("str_activity_common_notice_content")
    ToastManager.ShowToast(tips)
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIQuestController:SeasonQuestCloseCB()
  local tips = StringTable.Get("str_activity_error_109")
  ToastManager.ShowToast(tips)
  self._type_open_state = {}
  self._showSeasonTab = false
  self:_CheckQuestOpenState()
  self:_OnValue()
end

function UIQuestController:ChangeCanvasGroup()
  self:Lock("UIQuestControllerChangeCanvasGroup")
  self._canvasGroup:DOFade(0, 0.082):OnComplete(function()
    self._canvasGroup:DOFade(1, 0.082):OnComplete(function()
      self:UnLock("UIQuestControllerChangeCanvasGroup")
    end)
  end)
end

function UIQuestController:_ShowInfo()
  if self._currrentIndex ~= 0 then
    self._type_btns[self._currrentIndex]:Select(true)
    if self._currrentType == ClientQuestType.QT_Season then
      self:GetModule(QuestModule):SetSeasonNew()
      self._type_btns[self._currrentIndex]:CheckQuestRedPoint()
    end
  end
  self:_ItemActiveAndHide()
  local realType = self._type_open_state[self._currrentIndex].RealType
  self._controllerTab[self._currrentType]:SetData(realType)
  if realType == 3 then
    self._backGrabScreen:SetActive(false)
  else
    self._backGrabScreen:SetActive(true)
  end
end

function UIQuestController:_ItemActiveAndHide()
end

function UIQuestController:GetQuestStoryListItem(index)
  if self._storyItem then
    return nil
  else
    return nil
  end
end

function UIQuestController:GetQuestStoryScroll()
  if self._storyItem then
    return nil
  else
    return nil
  end
end

function UIQuestController:GetQuestStoryDetailItemGet()
  if self._storyItem then
    return self._storyItem:GetGuideFirstItemBtn(true)
  else
    return nil
  end
end

function UIQuestController:GetQuestStoryDetailItemGoto()
  if self._storyItem then
    return self._storyItem:GetGuideFirstGoToBtn()
  else
    return nil
  end
end

function UIQuestController:GetQuestTypeBtn(questType)
  if self._type_btns then
    for index, value in ipairs(self._type_btns) do
      if value._type == questType then
        return value:GetGameObject("bg")
      end
    end
    return nil
  else
    return nil
  end
end

function UIQuestController:GetQuestSideTypeGotoBtn(questId)
  if self._sideItem then
    for index, item in ipairs(self._sideItem._items) do
      if item._data.quest_id == questId then
        return item:GetGameObject("GoTo")
      end
    end
    return nil
  else
    return nil
  end
end

function UIQuestController:GetQuestGrowthTypeLook()
  if self._growthItem then
    return self._growthItem:GetGameObject("look")
  else
    return nil
  end
end

function UIQuestController:GetQuestGrowthAward(index)
  if self._growthItem then
    return self._growthItem:GetAward(index)
  else
    return nil
  end
end

function UIQuestController:_ShowShareBtn()
  local show = self._currrentType == ClientQuestType.QT_Achieve and self._canShare
  if show then
    self._backBtns:SetData(function()
      self:CloseDialog()
    end, nil, nil, nil, nil, true, function()
      self:ShowDialog("UIQuestAchievementShare")
    end)
  else
    self._backBtns:SetData(function()
      self:CloseDialog()
    end)
  end
end
