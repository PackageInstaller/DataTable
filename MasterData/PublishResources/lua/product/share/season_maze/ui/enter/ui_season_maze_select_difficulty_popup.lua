_class("UISeasonMazeSelectDifficultyPopup", UIController)
UISeasonMazeSelectDifficultyPopup = UISeasonMazeSelectDifficultyPopup

function UISeasonMazeSelectDifficultyPopup:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonMazeSelectDifficultyPopup:OnShow(uiParams)
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  self:InitWidget()
  self:InitUI()
  self:Lock("UISeasonMazeSelectDifficultyPopup_EnterAni")
  self:StartTask(function(TT)
    YIELD(TT, 500)
    self:UnLock("UISeasonMazeSelectDifficultyPopup_EnterAni")
    self:_CheckGuide()
  end)
end

function UISeasonMazeSelectDifficultyPopup:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUIShare.UISeasonMazeSelectDifficultyPopup)
end

function UISeasonMazeSelectDifficultyPopup:InitWidget()
  self.backBtns = UIWidgetHelper.SpawnObject(self, "backBtns", "UINewCommonTopButton")
  self.titleText = self:GetUIComponent("RawImageLoader", "TitleText")
  self.bossRedPoint = self:GetUIComponent("UISelectObjectPath", "BossRedPoint")
  self.adventurePool = self:GetUIComponent("UISelectObjectPath", "AdventurePool")
  self.adventurePoolRectTf = self:GetUIComponent("RectTransform", "AdventurePool")
  self.centerAnchorRectTf = self:GetUIComponent("RectTransform", "CenterAnchor")
  self.LeftChangeBtnObj = self:GetGameObject("LeftChangeBtn")
  self.RightChangeBtnObj = self:GetGameObject("RightChangeBtn")
  self._dynamicList = self:GetUIComponent("UIDynamicScrollView", "ScrollView")
  self.contentRectTf = self:GetUIComponent("RectTransform", "Content")
  self._scrollView = self:GetUIComponent("ScrollRect", "ScrollView")
  self._scrollView:DOHorizontalNormalizedPos(0, 0.1, false)
  self._grid = self:GetUIComponent("GridLayoutGroup", "AdventurePool")
  self.etl = UICustomUIEventListener.Get(self._scrollView.gameObject)
  self:RegUIEventTriggerListener(function(ped)
    self:OnBeginDrag(ped)
  end, function(ped)
    self:OnDrag(ped)
  end, function(ped)
    self:OnEndDrag(ped)
  end)
  local delta = self.adventurePoolRectTf.anchoredPosition
  delta.x = self.centerAnchorRectTf.rect.width / 2
  self.curHalfX = delta.x
  self.adventurePoolRectTf.anchoredPosition = delta
  self.adventurePoolRectTf.sizeDelta = Vector2(self.centerAnchorRectTf.rect.width, self.adventurePoolRectTf.sizeDelta.y)
  local ceil = self._grid.cellSize
  ceil.x = self.centerAnchorRectTf.rect.width
  self._grid.cellSize = ceil
  self._anim = self:GetUIComponent("Animation", "anim")
end

function UISeasonMazeSelectDifficultyPopup:InitUI()
  self:_InitBackBtn()
  self.seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  self.seasonMazeObj = self.seasonMazeModule:CurSeasonObj()
  self.cmptInfo = self.seasonMazeObj:GetComponentInfo(ECCampaignSeasonMazeComponentID.SEASON_MAZE)
  self.cmptId = self.seasonMazeObj:GetMazeComponent():GetComponentCfgId()
  self.cfgs = Cfg.cfg_component_season_maze({
    ComponentID = self.cmptId
  })
  self.cfgs = self:_SortCfg(self.cfgs)
  self.hard_completeInfo = self.cmptInfo.hard_num
  self.curSelectHard = #self.hard_completeInfo
  if self.curSelectHard == 0 then
    self.curSelectHard = 1
  end
  if #self.hard_completeInfo > 0 then
    local curHard = self.hard_completeInfo[#self.hard_completeInfo]
    if 0 < curHard.vic_count then
      self.curSelectHard = self.curSelectHard + 1
      if self.curSelectHard > table.count(self.cfgs) then
        self.curSelectHard = table.count(self.cfgs)
      end
    end
  end
  self.selectCfg = self.cfgs[self.curSelectHard]
  self.adventureItemPools = self.adventurePool:SpawnObjects("UISeasonMazeSingleAdvenItem", table.count(self.cfgs))
  self.curValue = 0
  self.singleValue = 1 / (table.count(self.cfgs) - 1)
  self.curValue = self.singleValue * (self.curSelectHard - 1)
  self._itemCountPerRow = 1
  self._dynamicListSize = table.count(self.cfgs)
  self.contentRectTf.sizeDelta = Vector2((self._dynamicListSize - 1) * self.centerAnchorRectTf.rect.width, 0)
  self._scrollView:DOHorizontalNormalizedPos(self.curValue, 0, false)
  self:RefreshCurDiff()
  if self.taskId == nil then
    self:RefreshItemTask()
  end
end

function UISeasonMazeSelectDifficultyPopup:OnHide()
  if self.taskId then
    GameGlobal.TaskManager():KillTask(self.taskId)
    self.taskId = nil
  end
end

function UISeasonMazeSelectDifficultyPopup:RefreshItemTask()
  self.taskId = self:StartTask(function(TT)
    while true do
      for i = 1, #self.adventureItemPools do
        local item = self.adventureItemPools[i]
        if not GameGlobal.UIStateManager():IsShow("UISeasonMazePetsTeamsPrimary") then
          item:RefreshItemTask()
        end
      end
      YIELD(TT, 1000)
    end
  end)
end

function UISeasonMazeSelectDifficultyPopup:_SortCfg(items)
  table.sort(items, function(a, b)
    return a.Hard < b.Hard
  end)
  return items
end

function UISeasonMazeSelectDifficultyPopup:OnBeginDrag(ped)
end

function UISeasonMazeSelectDifficultyPopup:OnDrag(ped)
end

function UISeasonMazeSelectDifficultyPopup:OnEndDrag(ped)
  local totalHard = table.count(self.cfgs)
  local hoPos = self._scrollView.horizontalNormalizedPosition
  local curOriginPos = self.singleValue * (self.curSelectHard - 1)
  local halfSingleValue = self.singleValue / 4
  if self.curSelectHard == 1 then
    local delatPos = hoPos - curOriginPos
    if 0 < delatPos then
      local add = math.floor(delatPos / halfSingleValue)
      self.curSelectHard = self.curSelectHard + 1
      if totalHard < self.curSelectHard then
        self.curSelectHard = totalHard
      end
      self:RefreshCurDiff()
    end
    self:RefreshCurDiff()
    return
  end
  if self.curSelectHard == totalHard then
    local delatPos = curOriginPos - hoPos
    if 0 < delatPos then
      local delta = math.floor(delatPos / halfSingleValue)
      if 0 < delta then
        self.curSelectHard = self.curSelectHard - 1
        if totalHard < self.curSelectHard then
          self.curSelectHard = totalHard
        end
        self:RefreshCurDiff()
      end
      self:RefreshCurDiff()
    end
    return
  end
  local delatPos = hoPos - curOriginPos
  if 0 < delatPos then
    local add = math.floor(delatPos / halfSingleValue)
    if 0 < add then
      self.curSelectHard = self.curSelectHard + 1
      if totalHard < self.curSelectHard then
        self.curSelectHard = totalHard
      end
      if self.curSelectHard < 1 then
        self.curSelectHard = 1
      end
      self:RefreshCurDiff()
    end
  elseif delatPos < 0 then
    local delta = math.ceil(delatPos / halfSingleValue)
    if delta < 0 then
      self.curSelectHard = self.curSelectHard - 1
      if totalHard < self.curSelectHard then
        self.curSelectHard = totalHard
      end
      if self.curSelectHard < 1 then
        self.curSelectHard = 1
      end
      self:RefreshCurDiff()
    end
  end
  self:RefreshCurDiff()
end

function UISeasonMazeSelectDifficultyPopup:RegUIEventTriggerListener(onBeginDrag, onDrag, onEndDrag)
  self:AddUICustomEventListener(self.etl, UIEvent.BeginDrag, onBeginDrag)
  self:AddUICustomEventListener(self.etl, UIEvent.Drag, onDrag)
  self:AddUICustomEventListener(self.etl, UIEvent.EndDrag, onEndDrag)
end

function UISeasonMazeSelectDifficultyPopup:_InitBackBtn()
  self.backBtns:SetData(function()
    self._anim:Play("uieffanim_UISeasonMazeSelectDifficultyPopup_out")
    self._timerHandler = GameGlobal.Timer():AddEventTimes(200, TimerTriggerCount.Once, function()
      self:CloseDialog()
    end)
  end, function()
    UISeasonMazeModule.OpenHelpUI(UISeasonMazeHelperTabIndex.Temp3, 1)
  end, nil, false, nil, false, nil)
end

function UISeasonMazeSelectDifficultyPopup:_InitDynamicList()
  self._dynamicList:InitListView(self._dynamicListSize, function(scrollView, index)
    return self:_SpawnListItem(scrollView, index)
  end)
end

function UISeasonMazeSelectDifficultyPopup:_SpawnListItem(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("AdventurePool")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UISeasonMazeSingleAdvenItem", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local listItem = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    self:_SetListItemData(listItem, itemIndex)
  end
  return item
end

function UISeasonMazeSelectDifficultyPopup:_SetListItemData(listItem, index)
  local hardInfo = self.cmptInfo.hard_num
  local info = self.cfgs[index]
  listItem:GetGameObject():SetActive(true)
  if info ~= nil then
    listItem:SetData(index, hardInfo, self.cfgs[index], self.cfgs)
  end
end

function UISeasonMazeSelectDifficultyPopup:RefreshCurDiff()
  local hardInfo = self.cmptInfo.hard_num
  local curOpenHard = table.count(self.cmptInfo.hard_num)
  if curOpenHard == 0 then
    curOpenHard = 1
  end
  if self.cmptInfo.hard_num then
    local curHard = self.cmptInfo.hard_num[curOpenHard]
    if curHard ~= nil and 0 < curHard.vic_count then
      curOpenHard = curOpenHard + 1
      if curOpenHard > table.count(self.cfgs) then
        curOpenHard = table.count(self.cfgs)
      end
    end
  end
  self.selectCfg = self.cfgs[self.curSelectHard]
  for i = 1, #self.adventureItemPools do
    local item = self.adventureItemPools[i]
    item:SetData(i, hardInfo, self.cfgs[i], self.cfgs, function(ped)
      self:OnBeginDrag(ped)
    end, function(ped)
      self:OnDrag(ped)
    end, function(ped)
      self:OnEndDrag(ped)
    end)
  end
  self.curValue = self.singleValue * (self.curSelectHard - 1)
  self._scrollView:DOHorizontalNormalizedPos(self.curValue, 0.25, false)
  self.LeftChangeBtnObj:SetActive(true)
  self.RightChangeBtnObj:SetActive(true)
  if self.curSelectHard == 1 then
    self.LeftChangeBtnObj:SetActive(false)
  end
  local hardSize = #self.cfgs
  if self.curSelectHard == hardSize then
    self.RightChangeBtnObj:SetActive(false)
  end
end

function UISeasonMazeSelectDifficultyPopup:LeftChangeBtnOnClick(go)
  local hardSize = #self.cfgs
  if self.curSelectHard == 1 then
    return
  end
  if hardSize == 1 then
    return
  end
  self.curSelectHard = self.curSelectHard - 1
  self:RefreshCurDiff()
end

function UISeasonMazeSelectDifficultyPopup:RightChangeBtnOnClick(go)
  local hardSize = #self.cfgs
  if self.curSelectHard == hardSize then
    return
  end
  if hardSize == 1 then
    return
  end
  self.curSelectHard = self.curSelectHard + 1
  self:RefreshCurDiff()
end

function UISeasonMazeSelectDifficultyPopup:BgOnClick(go)
  self:CloseDialog()
end

function UISeasonMazeSelectDifficultyPopup:_ReqSelectDiff(TT, diff)
end
