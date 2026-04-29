_class("UISailingRewardsController", UIController)
UISailingRewardsController = UISailingRewardsController

function UISailingRewardsController:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISailingRewardsController:OnShow(uiParams)
  self:InitWidget()
  self:_InitScrollPos()
  self:AddListener()
end

function UISailingRewardsController:OnHide()
  self._matRes = {}
end

function UISailingRewardsController:InitWidget()
  self._module = self:GetModule(SailingMissionModule)
  self._petModule = self:GetModule(PetModule)
  self._curSelectedCfgID = -1
  local backBtns = self:GetUIComponent("UISelectObjectPath", "_backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:CloseDialog()
  end, nil, nil, false)
  self.uISailingRewardsController = self:GetGameObject("UISailingRewardsController")
  self._rewardList = self:GetUIComponent("UIDynamicScrollView", "RewardsListView")
  self._rewardListRect = self:GetUIComponent("RectTransform", "RewardsListView")
  self._rewardContentRect = self:GetUIComponent("RectTransform", "Content")
  self._scrollRect = self:GetUIComponent("ScrollRect", "RewardsListView")
  self._scrollRect.onValueChanged:AddListener(function()
    self:OnScrollRectChange()
  end)
  self._rewardViewportRect = self:GetUIComponent("RectTransform", "Viewport")
  self._collectAllBtn = self:GetUIComponent("Button", "CollectAllRewardsBtn")
  self._rewardsTitleTmp = self:GetUIComponent("UILocalizedTMP", "RewardsTitle")
  self._matRes = {}
  self:SetFontMat(self._rewardsTitleTmp, "sailing_reward_title_mat.mat")
  self._moreTipsGo = self:GetGameObject("MoreTipsArea")
  self._moreTipsGo:SetActive(false)
  self._isMoreTipsShowing = false
  self._moreTipsAreaOffSet = 120
  self:_InitData()
  self:_InitRewardList()
  self:_InitBanner()
  self:CheckCollectAllRewardsBtnState()
end

function UISailingRewardsController:SetFontMat(lable, resname)
  local res = ResourceManager:GetInstance():SyncLoadAsset(resname, LoadType.Mat)
  table.insert(self._matRes, res)
  if not res then
    return
  end
  local obj = res.Obj
  local mat = lable.fontMaterial
  lable.fontMaterial = obj
  lable.fontMaterial:SetTexture("_MainTex", mat:GetTexture("_MainTex"))
end

function UISailingRewardsController:OnScrollRectChange()
  if self._totalShowCount then
    local cellHeight = 111
    local curY = self._rewardContentRect.localPosition.y
    local showAreaHeight = self._rewardViewportRect.rect.height
    local totalHeight = self._rewardContentRect.sizeDelta.y - 50
    if totalHeight <= showAreaHeight + curY then
      self:_ShowMoreTips(true)
    else
      self:_ShowMoreTips(false)
    end
  end
end

function UISailingRewardsController:_ShowMoreTips(bShow)
  if self._hasMoreCell and self._isMoreTipsShowing ~= bShow then
    self._isMoreTipsShowing = bShow
    self._moreTipsGo:SetActive(bShow)
  end
end

function UISailingRewardsController:AddListener()
  self:AttachEvent(GameEventType.SailingOnProgressRewardCellSelect, self.OnSailingOnProgressRewardCellSelect)
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
  self:AttachEvent(GameEventType.SailingOnProgressRewardBannerClick, self.OnSailingOnProgressRewardBannerClick)
end

function UISailingRewardsController:_InitScrollPos()
  local firstItemIndex = self:_GetFirstShowItemIndex()
  if firstItemIndex < 0 then
    firstItemIndex = 0
  end
  self:_MoveScrollToItemIndex(firstItemIndex)
end

function UISailingRewardsController:_MoveScrollToItemIndex(itemIndex)
  self._rewardList:MovePanelToItemIndex(itemIndex, 0)
  self._rewardList:FinishSnapImmediately()
end

function UISailingRewardsController:_GetFirstShowItemIndex()
  local cellIndex = 1
  local canReceiveIndex = -1
  local lastReceivedIndex = -1
  for index, value in ipairs(self._data.cells) do
    if value:CanReceive() then
      canReceiveIndex = index
      break
    elseif value:IsReceived() then
      lastReceivedIndex = index
    end
  end
  if 0 < canReceiveIndex then
    cellIndex = canReceiveIndex
  elseif 0 < lastReceivedIndex then
    cellIndex = lastReceivedIndex
  end
  return cellIndex - 1
end

function UISailingRewardsController:_GetItemIndexByCfgID(cfgID)
  local cellIndex = 1
  for index, value in ipairs(self._data.cells) do
    if value._cfgID == cfgID then
      cellIndex = index
      break
    end
  end
  return cellIndex - 1
end

function UISailingRewardsController:ShowItemInfo(matid, pos)
  local showPet = true
  UIWidgetHelper.SetAwardItemTips(self, "_itemInfo", matid, pos, showPet)
end

function UISailingRewardsController:CheckCollectAllRewardsBtnState()
  local cfgIDList = {}
  local cfgs = Cfg.cfg_sailing_reward({})
  local progress = self._module:GetHistoryProgress()
  local receivedRewardList = self._module:GetReceivedReward()
  local dicReceivedReward = {}
  for _, v in ipairs(receivedRewardList) do
    dicReceivedReward[v] = v
  end
  for cfgID, v in ipairs(cfgs) do
    if progress >= v.ExplorationProgress and dicReceivedReward[v.ID] == nil then
      table.insert(cfgIDList, cfgID)
    end
  end
  if 0 < #cfgIDList then
    self._collectAllBtn.interactable = true
  else
    self._collectAllBtn.interactable = false
  end
end

function UISailingRewardsController:CollectAllRewardsBtnOnClick(go)
  local cfgIDList = {}
  local cfgs = Cfg.cfg_sailing_reward({})
  local progress = self._module:GetHistoryProgress()
  local receivedRewardList = self._module:GetReceivedReward()
  local dicReceivedReward = {}
  for _, v in ipairs(receivedRewardList) do
    dicReceivedReward[v] = v
  end
  for cfgID, v in ipairs(cfgs) do
    if progress >= v.ExplorationProgress and dicReceivedReward[v.ID] == nil then
      table.insert(cfgIDList, cfgID)
    end
  end
  if 0 < #cfgIDList then
    self:GetReward(cfgIDList)
  else
  end
end

function UISailingRewardsController:_CalcTotalShowCount()
  local totalShowCount = 0
  local chapterID = self._module:GetChallengeLayerID()
  local allChapter = Cfg.cfg_sailing_layer({})
  for k, v in pairs(allChapter) do
    if chapterID >= v.ID then
      local cfgMissionList = v.SailingMissionList
      local countMission = #cfgMissionList
      totalShowCount = totalShowCount + countMission
    end
  end
  local extraCellCount = 0
  local customCfg = Cfg.cfg_sailing_reward_custom[1]
  if customCfg and customCfg.ExtraCellCount then
    extraCellCount = customCfg.ExtraCellCount
  end
  totalShowCount = totalShowCount + extraCellCount
  return totalShowCount
end

function UISailingRewardsController:_InitData()
  self._data = {}
  self._data.cells = {}
  if self._module then
    self._totalShowCount = self:_CalcTotalShowCount()
    local cfgs = Cfg.cfg_sailing_reward({})
    local progress = self._module:GetHistoryProgress()
    local receivedRewardList = self._module:GetReceivedReward()
    local dicReceivedReward = {}
    for _, v in ipairs(receivedRewardList) do
      dicReceivedReward[v] = v
    end
    for index, v in ipairs(cfgs) do
      if index > self._totalShowCount then
        self._hasMoreCell = true
        break
      end
      local state = ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_LOCK
      if progress >= v.ExplorationProgress then
        if dicReceivedReward[v.ID] == nil then
          state = ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_CAN_RECV
        else
          state = ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_RECVED
        end
      else
        state = ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_LOCK
      end
      local isSpecial = false
      if v.IsSpecial and v.IsSpecial == 1 then
        isSpecial = true
      end
      local cellData = DSailingProgressRewardsCell:New()
      cellData._state = state
      cellData._isSpecial = isSpecial
      cellData._progressNum = v.ExplorationProgress
      cellData._cfgID = v.ID
      cellData._items = {}
      for rewardIndex, rewardValue in ipairs(v.Rewards) do
        local itemInfo = RoleAsset:New()
        itemInfo.assetid = rewardValue[1]
        itemInfo.count = rewardValue[2]
        table.insert(cellData._items, itemInfo)
      end
      table.insert(self._data.cells, cellData)
    end
    table.sort(self._data.cells, function(e1, e2)
      return e1._progressNum < e2._progressNum
    end)
  end
end

function UISailingRewardsController:_RefreshDataState()
  local progress = self._module:GetHistoryProgress()
  local receivedRewardList = self._module:GetReceivedReward()
  local dicReceivedReward = {}
  for _, v in ipairs(receivedRewardList) do
    dicReceivedReward[v] = v
  end
  if self._data and self._data.cells then
    local cellsData = self._data.cells
    for i, cellData in ipairs(cellsData) do
      local state = ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_LOCK
      if progress >= cellData._progressNum then
        if dicReceivedReward[cellData._cfgID] == nil then
          state = ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_CAN_RECV
        else
          state = ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_RECVED
        end
      else
        state = ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_LOCK
      end
      cellData._state = state
    end
  end
end

function UISailingRewardsController:_InitRewardList()
  self._rewardList:InitListView(#self._data.cells, function(scrollview, index)
    return self:_OnGetRewardCell(scrollview, index)
  end)
  if self._hasMoreCell then
    local curSize = self._rewardViewportRect.sizeDelta
    self._rewardViewportRect.sizeDelta = Vector2(curSize.x, curSize.y - self._moreTipsAreaOffSet)
  end
end

function UISailingRewardsController:_OnGetRewardCell(scrollview, index)
  local item = scrollview:NewListViewItem("CellItem")
  local cellPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    cellPool:SpawnObjects("UISailingProgressRewardsCell", 1)
  end
  local rowList = cellPool:GetAllSpawnList()
  local itemWidget = rowList[1]
  if itemWidget then
    local itemIndex = index + 1
    local cellData = self._data.cells[itemIndex]
    itemWidget:InitData(cellData, self._cfg_cell_data, function(matid, pos)
      self:ShowItemInfo(matid, pos)
    end, function(cfgIDList)
      self:GetReward(cfgIDList)
    end)
    if cellData and cellData._cfgID == self._curSelectedCfgID then
      itemWidget:SetSelected(true)
    else
      itemWidget:SetSelected(false)
    end
    if itemIndex > #self._data.cells then
      itemWidget:GetGameObject():SetActive(false)
    else
    end
  end
  return item
end

function UISailingRewardsController:OnSailingOnProgressRewardCellSelect(cfgID)
  self._curSelectedCfgID = cfgID
end

function UISailingRewardsController:OnSailingOnProgressRewardBannerClick(cfgID)
  local tarItemIndex = self:_GetItemIndexByCfgID(cfgID)
  if tarItemIndex < 0 then
    tarItemIndex = 0
  end
  self:_MoveScrollToItemIndex(tarItemIndex)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SailingOnProgressRewardCellSelect, cfgID)
end

function UISailingRewardsController:GetReward(cfgIDList)
  self:Lock("UISailingRewardsController:GetReward")
  self:StartTask(self.OnGetReward, self, cfgIDList)
end

function UISailingRewardsController:OnGetReward(TT, cfgIDList)
  if self._module then
    local asyncRes, rewards = self._module:HandleReceiveRewards(TT, cfgIDList)
    self:UnLock("UISailingRewardsController:GetReward")
    if asyncRes == nil then
      return
    end
    if asyncRes:GetSucc() then
      if rewards ~= nil and 0 < #rewards then
        self:_ShowRewards(rewards, cfgIDList)
      end
    else
      Log.info("UISailingRewardsController getReward fail")
    end
    self:_RefreshDataState()
    self:CheckCollectAllRewardsBtnState()
  end
end

function UISailingRewardsController:_ShowRewards(awards, cfgIDList)
  UIActivityHelper.ShowUIGetRewards(awards)
  self._waitRefreshGetRewards = cfgIDList
end

function UISailingRewardsController:OnUIGetItemCloseInQuest(type)
  self:_RefreshOnGetReward()
  if self._waitRefreshGetRewards then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.SailingGetProgressReward, self._waitRefreshGetRewards)
    self._waitRefreshGetRewards = nil
  end
end

function UISailingRewardsController:_RefreshOnGetReward()
end

function UISailingRewardsController:_InitBanner()
  local bannerGen = self:GetUIComponent("UISelectObjectPath", "BannerRoot")
  self._bannerWidget = bannerGen:SpawnObject("UISailingRewardBanner")
  self._bannerWidget:SetData()
end

function UISailingRewardsController:OnUpdate(deltaTimeMS)
  if self._bannerWidget then
    self._bannerWidget:OnUpdate(deltaTimeMS)
  end
end
