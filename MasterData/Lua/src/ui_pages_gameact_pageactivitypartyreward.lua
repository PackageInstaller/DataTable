local this = class("pageActivityPartyReward", G_UIPageBase)
local _GameEventRewardGroupTpl = L_GameTpl:getGameEventsRewardGroupTpl()
local _GameEventRewardTpl = L_GameTpl:getGameEventsRewardTpl()
local _PartyGameTpl = L_GameTpl:getGameEventsPartygameTpl()
local wordsTpl = L_GameTpl:getWordsTpl()
local TabPageType = {Level = 1, Star = 2}

local function setGoActive(target, active)
  if not target then
    return
  end
  local go = target.gameObject or target
  if go and go.SetActive then
    go:SetActive(active == true)
  end
end

local function findChildByNameDeep(root, targetName)
  if not root or string.isEmpty(targetName) then
    return nil
  end
  local direct = root:Find(targetName)
  if direct then
    return direct
  end
  local queue = {root}
  local index = 1
  while index <= #queue do
    local node = queue[index]
    index = index + 1
    for i = 0, node.childCount - 1 do
      local child = node:GetChild(i)
      if child.name == targetName then
        return child
      end
      table.insert(queue, child)
    end
  end
  return nil
end

local function shallowCopyTable(source)
  if type(source) ~= "table" then
    return source
  end
  local target = {}
  for k, v in pairs(source) do
    target[k] = v
  end
  return target
end

local function buildPartyRewardDisplayList(itemList, activityId)
  local claimRewardIds = {}
  local displayList = {}
  for _, reward in ipairs(itemList or {}) do
    if reward.reward_state == L_Const.ActivityRewardState.ARS_FINISH then
      table.insert(claimRewardIds, reward.reward_id)
    end
  end
  for _, reward in ipairs(itemList or {}) do
    local rewardItem = shallowCopyTable(reward)
    rewardItem.reward_group_id = activityId
    rewardItem.partyRewardUsePageClaim = true
    rewardItem.partyRewardClaimIds = claimRewardIds
    table.insert(displayList, rewardItem)
  end
  return displayList
end

local function setTabCellSelected(cell, isSelected)
  if not (cell and cell.gameObject) or not cell.gameObject.transform then
    return false
  end
  local root = cell.gameObject.transform
  local selectedGo = findChildByNameDeep(root, "CheckmarkRoot")
  local unselectedGo = findChildByNameDeep(root, "Background")
  if not selectedGo and not unselectedGo then
    return false
  end
  if selectedGo then
    setGoActive(selectedGo, isSelected)
  end
  if unselectedGo then
    setGoActive(unselectedGo, not isSelected)
  end
  return true
end

local function bindTabCellDirectPointerClick(owner, cell, clickHandler)
  if not (owner and cell and cell.gameObject) or not clickHandler then
    return false
  end
  if cell._partyRewardDirectClickBound then
    return true
  end
  local ok, eventTrigger = pcall(function()
    local trigger = cell.gameObject:GetComponent(typeof(Unity.EventSystems.EventTrigger))
    trigger = trigger or cell.gameObject:AddComponent(typeof(Unity.EventSystems.EventTrigger))
    return trigger
  end)
  if not ok or not eventTrigger then
    return false
  end
  local entry = Unity.EventSystems.EventTrigger.Entry()
  entry.eventID = Unity.EventSystems.EventTriggerType.PointerClick
  entry.callback = Unity.EventSystems.EventTrigger.TriggerEvent()
  entry.callback:AddListener(function(eventData)
    if not (owner and L_CommonUtil.isValid(owner.gameObject) and cell) or not L_CommonUtil.isValid(cell.gameObject) then
      return
    end
    local cellId
    if type(cell.bind) == "function" then
      local bindData = cell:bind()
      cellId = bindData and bindData.id
    elseif type(cell.bind) == "table" then
      cellId = cell.bind.id
    end
    if cellId then
      clickHandler(cellId)
    end
  end)
  eventTrigger.triggers:Add(entry)
  cell._partyRewardDirectClickBound = true
  return true
end

local function bindCommonTabModuleClicks(owner, moduleTab, clickHandler, retryCount)
  if not (owner and moduleTab and moduleTab.bind and moduleTab.bind.list_tab) or not clickHandler then
    return
  end
  local missingCell = false
  local hasBoundClick = false
  for index = 1, #moduleTab.bind.list_tab do
    local cell = moduleTab.bind.list_tab:getItemCls(index)
    if cell and cell.gameObject then
      if bindTabCellDirectPointerClick(owner, cell, clickHandler) then
        hasBoundClick = true
      end
      local tabItem = cell.gameObject:GetComponent(typeof(CS.Lens.Framework.UI.LTabItem))
      if tabItem and not cell._partyRewardClickBound then
        tabItem.onClick:AddListener(function()
          if owner and L_CommonUtil.isValid(owner.gameObject) and cell and L_CommonUtil.isValid(cell.gameObject) then
            local cellId
            if type(cell.bind) == "function" then
              local bindData = cell:bind()
              cellId = bindData and bindData.id
            elseif type(cell.bind) == "table" then
              cellId = cell.bind.id
            end
            if cellId then
              clickHandler(cellId)
            end
          end
        end)
        cell._partyRewardClickBound = true
        hasBoundClick = true
      elseif tabItem then
        hasBoundClick = true
      end
    else
      missingCell = true
    end
  end
  if (missingCell or not hasBoundClick) and (retryCount or 0) < 5 then
    Timer.once(0, function()
      if owner and L_CommonUtil.isValid(owner.gameObject) then
        bindCommonTabModuleClicks(owner, moduleTab, clickHandler, (retryCount or 0) + 1)
      end
    end, owner, owner and owner.gameObject)
  end
end

local function syncCommonTabModuleCells(owner, moduleTab, tabList, selectId, retryCount)
  if not (moduleTab and moduleTab.bind and moduleTab.bind.list_tab) or not tabList then
    return
  end
  local missingCell = false
  for index, info in ipairs(tabList) do
    local cell = moduleTab.bind.list_tab:getItemCls(index)
    if cell then
      local bindData
      if type(cell.bind) == "function" then
        bindData = cell:bind()
      elseif type(cell.bind) == "table" then
        bindData = cell.bind
      end
      if bindData then
        bindData.id = info.id
        bindData.name = info.name or ""
        bindData.isShow = info.isNew or false
        bindData.active_lock = info.active_lock or false
        bindData.reddotKey = info.reddotKey or nil
        bindData.isLast = info.isLast or false
        bindData.tabId = info.id
        bindData.txt_selectName = info.name or ""
        bindData.txt_unSelectName = info.name or ""
        if cell.refresh then
          cell:refresh()
        elseif cell.RefreshReddot then
          cell:RefreshReddot(info.isNew or false)
        end
      else
        missingCell = true
      end
    else
      missingCell = true
    end
  end
  local targetSelectId = selectId or tabList[1] and tabList[1].id or -1
  if moduleTab.setSelectTabId then
    moduleTab:setSelectTabId(targetSelectId)
  else
    local moduleBindData = type(moduleTab.bind) == "function" and moduleTab:bind() or moduleTab.bind
    if moduleBindData then
      moduleBindData.selectTab = targetSelectId
    end
  end
  if missingCell and (retryCount or 0) < 5 then
    Timer.once(0, function()
      if owner and L_CommonUtil.isValid(owner.gameObject) then
        syncCommonTabModuleCells(owner, moduleTab, tabList, selectId, (retryCount or 0) + 1)
      end
    end, owner, owner and owner.gameObject)
  end
end

local function syncCommonTabModuleVisualState(owner, moduleTab, tabList, selectId, retryCount)
  if not (moduleTab and moduleTab.bind and moduleTab.bind.list_tab) or not tabList then
    return
  end
  local missingCell = false
  local hasVisualState = false
  for index, info in ipairs(tabList) do
    local cell = moduleTab.bind.list_tab:getItemCls(index)
    if cell then
      if setTabCellSelected(cell, info.id == selectId) then
        hasVisualState = true
      end
    else
      missingCell = true
    end
  end
  if (missingCell or not hasVisualState) and (retryCount or 0) < 5 then
    Timer.once(0, function()
      if owner and L_CommonUtil.isValid(owner.gameObject) then
        syncCommonTabModuleVisualState(owner, moduleTab, tabList, selectId, (retryCount or 0) + 1)
      end
    end, owner, owner and owner.gameObject)
  end
end

local function ensureManualCommonTabModule(owner, bindKey)
  local moduleTab = owner and owner.modules and owner.modules[bindKey] or nil
  if moduleTab and moduleTab.uiBinding and moduleTab.bind and moduleTab.bind.list_tab then
    return moduleTab
  end
  return nil
end

local function resetPageRuntimeState(owner)
  owner._bottomAreaRefsReady = false
  owner._scorePanelGo = nil
  owner._subTabGo = nil
  owner._pcListGo = nil
  owner._mobileListGo = nil
  owner._claimRequestPending = false
  owner._pendingClaimKey = nil
end

function this.bind()
  return {
    reward_item_list = {
      moduleName = "pages/gameAct/cellActivityPartyRewardItem"
    },
    star_item_list = {
      moduleName = "pages/gameAct/cellActivityPartyRewardItem"
    },
    reward_item_listMobile = {
      moduleName = "pages/gameAct/cellActivityPartyRewardItem"
    },
    module_subTab = {
      moduleName = "pages/common/modules/moduleCommonTab"
    },
    total_score = "",
    max_score = "",
    score_tip = "",
    show_score_panel = false,
    show_sub_tab = false,
    module_commonTop = {
      moduleName = "pages/common/modules/moduleCommonTab"
    },
    selectId = 0,
    selectSubId = 0,
    go_LineLevel = false,
    go_LineStar = false,
    gb_reward_item_list = false,
    gb_star_item_list = false
  }
end

function this.methods()
  return {
    onRewardItemClick = function(self, rewardId)
      self:onRewardItemClick(rewardId)
    end,
    onClick_back = function(self)
      self:escHandle()
    end,
    onClick_home = function(self)
      L_UI:backToRoot()
    end
  }
end

function this:close(options)
  L_GameEventStore:unListenCallFunc(L_GameEventStore.event.gameEventSync, self.refreshByData)
  L_GameEventStore:unListenCallFunc(L_GameEventStore.event.gameEventReward, self.refreshByData)
  L_GameEventStore:unListenCallFunc(L_GameEventStore.event.gameEventEnd, self.endActivity)
  resetPageRuntimeState(self)
  self:resetGlobalTopBar()
end

function this:open(options)
  self.isPc = L_DeviceTpl:getIsPc()
  if not options or not options.id then
    return
  end
  resetPageRuntimeState(self)
  self.activityId = options.id
  self.mainTabSelectId = TabPageType.Level
  self.subTabSelectId = 0
  L_GameEventStore:listenCallFunc(L_GameEventStore.event.gameEventSync, self.refreshByData, self)
  L_GameEventStore:listenCallFunc(L_GameEventStore.event.gameEventEnd, self.endActivity, self)
  L_GameEventStore:listenCallFunc(L_GameEventStore.event.gameEventReward, self.refreshByData, self)
  local gameEventData = L_GameEventStore:getGameEventData(self.activityId)
  self.reward_state_list = gameEventData and (gameEventData:getRewardStateList() or {}) or {}
  self:initUIData()
  self:initTopBar()
  self:initGlobalTopBar()
  self:refreshScoreInfo()
  self:refreshMainTab()
  self:updateBottomAreaState()
  self:onMainTabChange(1)
end

function this:GetRewardGroupCfg(tabType)
  local data = L_GameTpl:getGameEventsRewardGroupTpl():getData()
  for _, info in pairs(data or {}) do
    if info.type == tabType then
      return info
    end
  end
  return nil
end

function this:refreshMainTab()
  local tabList = {
    {
      id = TabPageType.Level,
      name = self:GetRewardGroupCfg(TabPageType.Level).name,
      isNew = self:hasNewRewardInMainTab(TabPageType.Level)
    },
    {
      id = TabPageType.Star,
      name = self:GetRewardGroupCfg(TabPageType.Star).name,
      isNew = self:hasNewRewardInMainTab(TabPageType.Star)
    }
  }
  local moduleTab = ensureManualCommonTabModule(self, "module_commonTop") or self.modules and self.modules.module_commonTop or nil
  if moduleTab and moduleTab.initData then
    moduleTab:initData(tabList, function(id)
      self:onMainTabChange(id)
    end, self.mainTabSelectId or 1)
    syncCommonTabModuleCells(self, moduleTab, tabList, self.mainTabSelectId or 1)
    syncCommonTabModuleVisualState(self, moduleTab, tabList, self.mainTabSelectId or 1)
    if moduleTab.setSelectTabId then
      moduleTab:setSelectTabId(self.mainTabSelectId or 1)
    end
    self._refreshMainTabRetry = 0
  else
    self._refreshMainTabRetry = (self._refreshMainTabRetry or 0) + 1
    if self._refreshMainTabRetry <= 8 then
      Timer.once(0, function()
        if L_CommonUtil.isValid(self.gameObject) then
          self:refreshMainTab()
        end
      end, self, self.gameObject)
    end
  end
end

function this:onMainTabChange(mainTabId)
  self.mainTabSelectId = mainTabId
  if self.mainTabSelectId == TabPageType.Level then
    self.bind.gb_star_item_list = false
    self.bind.gb_reward_item_list = true
  else
    self.bind.gb_reward_item_list = false
    self.bind.gb_star_item_list = true
  end
  local moduleTab = ensureManualCommonTabModule(self, "module_commonTop") or self.modules and self.modules.module_commonTop or nil
  if moduleTab and moduleTab.setSelectTabId then
    moduleTab:setSelectTabId(mainTabId)
  end
  syncCommonTabModuleVisualState(self, moduleTab, {
    {id = 1},
    {id = 2}
  }, mainTabId)
  self.bind.go_LineLevel = false
  self.bind.go_LineStar = false
  if mainTabId == 1 then
    self.subTabSelectId = 0
    self.bind.go_LineLevel = true
  else
    self.bind.go_LineStar = true
  end
  self:setSubTabModuleActive(mainTabId == 2)
  self:updateBottomAreaState()
  if mainTabId == 2 then
    Timer.once(0, function()
      if self and L_CommonUtil.isValid(self.gameObject) then
        self:refreshSubTab()
        if self.sub_tab_list and #self.sub_tab_list > 0 then
          local subTabId = self.subTabSelectId
          if not self.sub_tab_to_item_map[subTabId] then
            subTabId = self.sub_tab_list[1]
          end
          self:onSubTabChange(subTabId)
        else
          self:refreshRewardItemList(mainTabId, nil)
        end
      end
    end, self, self.gameObject)
  else
    self:refreshRewardItemList(mainTabId)
  end
  self:refreshRedDot()
end

function this:refreshSubTab()
  local subTabModule = ensureManualCommonTabModule(self, "module_subTab") or self.modules and self.modules.module_subTab or nil
  local firstSubTabId = self.sub_tab_list and self.sub_tab_list[1] or nil
  if not firstSubTabId then
    self.subTabSelectId = 0
    self:updateBottomAreaState()
    self:refreshRewardItem({})
    return
  end
  local currentSubTabId = self.subTabSelectId
  if not currentSubTabId or not self.sub_tab_to_item_map[currentSubTabId] then
    currentSubTabId = firstSubTabId
  end
  self.subTabSelectId = currentSubTabId
  self:updateBottomAreaState()
  local selectIndex = 1
  local tabList = {}
  
  local function createItemCall(cell)
    self:onCreateItemCall(cell)
  end
  
  for index, subTabId in ipairs(self.sub_tab_list) do
    local tpl = _GameEventRewardGroupTpl:getTplById(subTabId)
    local name = tpl and _GameEventRewardGroupTpl:getName(tpl) or tostring(subTabId)
    table.insert(tabList, {
      id = subTabId,
      name = name,
      isNew = self:hasNewRewardInSubTab(subTabId),
      itemCreateCall = createItemCall
    })
    if subTabId == currentSubTabId then
      selectIndex = index
    end
  end
  if subTabModule and subTabModule.initData then
    subTabModule:initData(tabList, function(id)
      self:onSubTabChange(id)
    end, selectIndex)
    local selectedSubTabId = tabList[selectIndex] and tabList[selectIndex].id or currentSubTabId
    syncCommonTabModuleCells(self, subTabModule, tabList, selectedSubTabId)
    syncCommonTabModuleVisualState(self, subTabModule, tabList, selectedSubTabId)
    bindCommonTabModuleClicks(self, subTabModule, function(id)
      self:onSubTabChange(id)
    end)
    if subTabModule.setSelectTabId then
      subTabModule:setSelectTabId(selectedSubTabId)
    end
    self._refreshSubTabRetry = 0
  else
    self._refreshSubTabRetry = (self._refreshSubTabRetry or 0) + 1
    if self._refreshSubTabRetry <= 8 then
      Timer.once(0, function()
        if self and L_CommonUtil.isValid(self.gameObject) then
          self:refreshSubTab()
        end
      end, self, self.gameObject)
    end
  end
  self:refreshRewardItemList(self.mainTabSelectId, currentSubTabId)
end

function this:onCreateItemCall(cell)
  local taskList = self.sub_tab_to_item_map[cell.bind.id] or {}
  local completeCount = 0
  for _, info in pairs(taskList) do
    if info.reward_state == L_Const.ActivityRewardState.ARS_REWARDED then
      completeCount = completeCount + 1
    end
  end
  local str = completeCount .. "/" .. #taskList
  local root = cell.gameObject.transform
  local txt_NumNode1 = findChildByNameDeep(root, "CheckmarkRoot/txt_NumSel")
  local txt_NumNode2 = findChildByNameDeep(root, "Background/txt_Num")
  local txt = txt_NumNode1.gameObject:GetComponent(typeof(C_LTextMeshProUGUI))
  txt.text = str
  local txt = txt_NumNode2.gameObject:GetComponent(typeof(C_LTextMeshProUGUI))
  txt.text = str
end

function this:onSubTabChange(subTabId)
  self.subTabSelectId = subTabId
  local subTabModule = ensureManualCommonTabModule(self, "module_subTab") or self.modules and self.modules.module_subTab or nil
  if subTabModule and subTabModule.setSelectTabId then
    subTabModule:setSelectTabId(subTabId)
  end
  if self.sub_tab_list and #self.sub_tab_list > 0 then
    local tabList = {}
    for _, id in ipairs(self.sub_tab_list) do
      table.insert(tabList, {id = id})
    end
    syncCommonTabModuleVisualState(self, subTabModule, tabList, subTabId)
  end
  self:updateBottomAreaState()
  self:refreshRewardItemList(self.mainTabSelectId, subTabId)
  self:refreshRedDot()
end

function this:refreshRewardItemList(mainTabId, subTabId)
  local item_tmp_list
  if mainTabId == TabPageType.Level then
    item_tmp_list = self.main_tab_to_item_map[mainTabId]
  else
    item_tmp_list = subTabId and self.sub_tab_to_item_map[subTabId] or self.main_tab_to_item_map[2]
  end
  for _, info in pairs(item_tmp_list or {}) do
    info.itemStype = mainTabId
  end
  if item_tmp_list then
    local item_list = self:sortRewardItemList(item_tmp_list)
    self:refreshRewardItem(item_list)
  else
    self:refreshRewardItem({})
  end
end

function this:refreshScoreInfo()
  local totalScore = 0
  local maxScore = 0
  local geData = L_GameEventStore:getGameEventData(self.activityId)
  if geData and geData.getGameEvent then
    local ge = geData:getGameEvent()
    local serverData = ge and ge.getData and ge:getData() or nil
    if serverData then
      totalScore = tonumber(serverData.score) or 0
      maxScore = tonumber(serverData.scoreLimit) or tonumber(serverData.score_limit) or 0
    end
  end
  self.bind.total_score = tostring(totalScore)
  self.bind.max_score = tostring(maxScore)
  self.bind.score_tip = wordsTpl:getTplById("ui_partygame_cumulative_point_tips")
end

function this:showRewardResult(rspData)
  if not rspData or not rspData.rewards then
    return
  end
  local rewards = require("ui.manager.reward.rewardData").new()
  rewards.rewardShowType = L_Const.rewardShowType.full
  local data = L_DataUtil.parseRewardConfig(rspData.rewards, true, true)
  rewards:constructList(data)
  L_RewardManager:ShowReward(rewards)
end

function this:claimRewardsByIds(claimRewardIds, reason)
  if type(claimRewardIds) ~= "table" or #claimRewardIds <= 0 then
    return
  end
  local idsKey = table.concat(claimRewardIds, ",")
  if self._claimRequestPending and self._pendingClaimKey == idsKey then
    return
  end
  self._claimRequestPending = true
  self._pendingClaimKey = idsKey
  L_GameEventStore:req_CsProtoActivityReward(self.activityId, claimRewardIds, function(rspData)
    self:showRewardResult(rspData)
  end)
end

function this:hookRewardItemClaimProxy(listModule, retryCount)
  if not listModule then
    return
  end
  local expectedCount = #self:getCurrentPageRewards()
  if expectedCount <= 0 then
    return
  end
  local missingCell = false
  for index = 1, expectedCount do
    local cell = listModule:getItemCls(index)
    if cell then
      function cell.receivedAllRewards()
        self:claimCurrentPageAllRewards("cellProxy")
      end
    else
      missingCell = true
    end
  end
  if missingCell and (retryCount or 0) < 5 then
    Timer.once(0, function()
      if self and L_CommonUtil.isValid(self.gameObject) then
        self:hookRewardItemClaimProxy(listModule, (retryCount or 0) + 1)
      end
    end, self, self.gameObject)
  end
end

function this:onRewardItemClick(rewardId)
  self:claimCurrentPageAllRewards("pageButton")
end

function this:getCurrentPageRewards()
  local mainTabId = self.mainTabSelectId
  if mainTabId == 1 then
    return self.main_tab_to_item_map[mainTabId] or {}
  else
    local subTabId = self.subTabSelectId
    return subTabId and self.sub_tab_to_item_map[subTabId] or self.main_tab_to_item_map[2] or {}
  end
end

function this:claimCurrentPageAllRewards(reason)
  local currentRewards = self:getCurrentPageRewards()
  local claimRewardIds = {}
  for _, reward in ipairs(currentRewards) do
    if reward.reward_state == L_Const.ActivityRewardState.ARS_FINISH then
      table.insert(claimRewardIds, reward.reward_id)
    end
  end
  if #claimRewardIds <= 0 then
    return
  end
  self:claimRewardsByIds(claimRewardIds, reason or "currentPage")
end

function this:initTopBar()
end

function this:ensureBottomAreaRefs()
  if self._bottomAreaRefsReady then
    return
  end
  self._bottomAreaRefsReady = true
  self._scorePanelGo = not self._scorePanelGo and self.gameObject and findChildByNameDeep(self.gameObject.transform, "bg_level_left")
  self._subTabGo = not self._subTabGo and self.gameObject and findChildByNameDeep(self.gameObject.transform, "moduleCommonSubTopTab")
  local pcList = self.bind and self.bind.reward_item_list or nil
  local mobileList = self.bind and self.bind.reward_item_listMobile or nil
  self._pcListGo = self._pcListGo or pcList and (pcList.gameObject or pcList)
  self._mobileListGo = self._mobileListGo or mobileList and (mobileList.gameObject or mobileList)
end

function this:updateBottomAreaState()
  self:ensureBottomAreaRefs()
  local isScoreTab = self.mainTabSelectId == 1
  local hasSubTab = self.sub_tab_list and #self.sub_tab_list > 0
  local showSubTab = not isScoreTab and hasSubTab
  self.bind.show_score_panel = isScoreTab
  self.bind.show_sub_tab = showSubTab
  setGoActive(self._scorePanelGo, isScoreTab)
  setGoActive(self._subTabGo, showSubTab)
  if self.isPc then
  else
  end
end

function this:setSubTabModuleActive(isActive)
  self:ensureBottomAreaRefs()
  local subTabModule = self.modules and self.modules.module_subTab or nil
  if subTabModule and subTabModule.gameObject then
    subTabModule.gameObject:SetActive(isActive)
  end
  setGoActive(self._subTabGo, isActive)
end

function this:initGlobalTopBar()
  if not C_IntegrateMgr or not C_IntegrateMgr.TopBarModule then
    return
  end
  local topBar = C_IntegrateMgr.TopBarModule
  if topBar.SetTopBarCloseFunc then
    topBar:SetTopBarCloseFunc(handler(self, self.escHandle))
  end
  if topBar.SetTopBarMainBtnFunc then
    topBar:SetTopBarMainBtnFunc(function()
      L_UI:backToRoot()
    end)
  end
  if topBar.SetTopBarMainBtnVisible then
    topBar:SetTopBarMainBtnVisible(true)
  end
end

function this:resetGlobalTopBar()
  if not C_IntegrateMgr or not C_IntegrateMgr.TopBarModule then
    return
  end
  local topBar = C_IntegrateMgr.TopBarModule
  if topBar.SetTopBarMainBtnVisible then
    topBar:SetTopBarMainBtnVisible(false)
  end
end

function this:initUIData()
  self.main_tab_to_item_map = {
    [1] = {},
    [2] = {}
  }
  self.sub_tab_to_item_map = {}
  local groupedRewards = {}
  local groupedShowTypeList = {}
  for _, reward in pairs(self.reward_state_list) do
    local showType = reward.reward_show_type or 0
    if not groupedRewards[showType] then
      groupedRewards[showType] = {}
      table.insert(groupedShowTypeList, showType)
    end
    table.insert(groupedRewards[showType], reward)
  end
  table.sort(groupedShowTypeList, function(a, b)
    return a < b
  end)
  local scoreShowType = self:detectScoreShowType(groupedRewards, groupedShowTypeList)
  local currentScore = self:getPartyServerScore()
  for _, showType in ipairs(groupedShowTypeList) do
    local rewardList = groupedRewards[showType] or {}
    local normalizedRewardList = {}
    for _, reward in ipairs(rewardList) do
      local rewardItem = shallowCopyTable(reward)
      if showType == scoreShowType and rewardItem.reward_state ~= L_Const.ActivityRewardState.ARS_REWARDED then
        local tpl = _GameEventRewardTpl:getTplById(rewardItem.reward_id)
        local targetScore = tpl and tonumber(_GameEventRewardTpl:getPara(tpl)) or 0
        if 0 < targetScore then
          rewardItem.reward_state = currentScore >= targetScore and L_Const.ActivityRewardState.ARS_FINISH or L_Const.ActivityRewardState.ARS_NONE
        end
      end
      table.insert(normalizedRewardList, rewardItem)
    end
    if showType == scoreShowType then
      for _, reward in ipairs(normalizedRewardList) do
        table.insert(self.main_tab_to_item_map[1], reward)
      end
    else
      self.sub_tab_to_item_map[showType] = normalizedRewardList
      for _, reward in ipairs(normalizedRewardList) do
        table.insert(self.main_tab_to_item_map[2], reward)
      end
    end
  end
  self.main_tab_list = {1, 2}
  self.sub_tab_list = {}
  for subTabId, _ in pairs(self.sub_tab_to_item_map) do
    table.insert(self.sub_tab_list, subTabId)
  end
  table.sort(self.sub_tab_list, function(a, b)
    return a < b
  end)
end

function this:detectScoreShowType(groupedRewards, groupedShowTypeList)
  if groupedRewards[1] then
    return 1
  end
  for _, showType in ipairs(groupedShowTypeList or {}) do
    local groupTpl = _GameEventRewardGroupTpl:getTplById(showType)
    if groupTpl.type == TabPageType.Level then
      return showType
    end
  end
  return groupedShowTypeList and groupedShowTypeList[1] or nil
end

function this:getPartyServerScore()
  local geData = L_GameEventStore:getGameEventData(self.activityId)
  if not geData or not geData.getGameEvent then
    return 0
  end
  local ge = geData:getGameEvent()
  local serverData = ge and ge.getData and ge:getData() or nil
  return tonumber(serverData and serverData.score) or 0
end

function this:hasNewRewardInMainTab(mainTabId)
  local rewards = mainTabId == 1 and self.main_tab_to_item_map[1] or self:getAllTaskRewards()
  if not rewards then
    return false
  end
  for _, reward in pairs(rewards) do
    if reward.reward_state == L_Const.ActivityRewardState.ARS_FINISH then
      return true
    end
  end
  return false
end

function this:hasNewRewardInSubTab(subTabId)
  local rewards = self.sub_tab_to_item_map[subTabId]
  if not rewards then
    return false
  end
  for _, reward in pairs(rewards) do
    if reward.reward_state == L_Const.ActivityRewardState.ARS_FINISH then
      return true
    end
  end
  return false
end

function this:getAllTaskRewards()
  local allTaskRewards = {}
  for _, rewards in pairs(self.sub_tab_to_item_map) do
    for _, reward in pairs(rewards) do
      table.insert(allTaskRewards, reward)
    end
  end
  return allTaskRewards
end

function this:sortRewardItemList(itemList)
  local statePriority = {
    [L_Const.ActivityRewardState.ARS_FINISH] = 1,
    [L_Const.ActivityRewardState.ARS_NONE] = 2,
    [L_Const.ActivityRewardState.ARS_REWARDED] = 3
  }
  local sorted = {}
  for _, item in pairs(itemList) do
    table.insert(sorted, item)
  end
  table.sort(sorted, function(a, b)
    local pa = statePriority[a.reward_state] or 99
    local pb = statePriority[b.reward_state] or 99
    if pa ~= pb then
      return pa < pb
    end
    return (a.reward_id or 0) < (b.reward_id or 0)
  end)
  return sorted
end

function this:refreshByData()
  self._claimRequestPending = false
  self._pendingClaimKey = nil
  local gameEventData = L_GameEventStore:getGameEventData(self.activityId)
  self.reward_state_list = gameEventData and (gameEventData:getRewardStateList() or {}) or {}
  self:initUIData()
  self:refreshScoreInfo()
  self:refreshMainTab()
  self:updateBottomAreaState()
  local mainTabId = self.mainTabSelectId
  if mainTabId ~= 1 and mainTabId ~= 2 then
    mainTabId = 1
  end
  if mainTabId == 2 then
    self:refreshSubTab()
    local subTabId = self.subTabSelectId
    if not self.sub_tab_to_item_map[subTabId] then
      subTabId = self.sub_tab_list[1]
    end
    self:onSubTabChange(subTabId)
  else
    self:refreshRewardItemList(mainTabId)
  end
  self:refreshRedDot()
end

function this:endActivity(eventID)
  if eventID == self.activityId then
    L_UI:close("pageActivityPartyReward")
  end
end

function this:refreshRewardItem(item_list)
  item_list = item_list or {}
  self:updateBottomAreaState()
  local displayList = buildPartyRewardDisplayList(item_list, self.activityId)
  local currentScore = self.mainTabSelectId == 1 and self:getPartyServerScore() or 0
  for _, rewardItem in ipairs(displayList) do
    local tpl = rewardItem.reward_id and _GameEventRewardTpl:getTplById(rewardItem.reward_id) or nil
    local rewardShowList = tpl and (_GameEventRewardTpl:getRewardShow(tpl) or {}) or {}
    local rewardTitle = tpl and (_GameEventRewardTpl:getDescription(tpl) or "") or ""
    local rewardShowType = tpl and _GameEventRewardTpl:getShowType(tpl) or rewardItem.reward_show_type
    local rewardGroupId = tpl and _GameEventRewardTpl:getGroupId(tpl) or rewardItem.reward_group_id
    local targetValue = tpl and tonumber(_GameEventRewardTpl:getPara(tpl)) or 0
    rewardItem.txt_title = rewardTitle
    rewardItem.partyRewardRewardShowList = rewardShowList
    rewardItem.partyRewardShowType = rewardShowType
    rewardItem.partyRewardTargetValue = targetValue
    rewardItem.partyRewardTplGroupId = rewardGroupId
    if 0 < targetValue then
      local currentValue = self.mainTabSelectId == 1 and currentScore or tonumber(rewardItem.reward_val) or 0
      local progressCurrent = math.min(math.max(currentValue, 0), targetValue)
      rewardItem.partyRewardShowProgressText = 1
      rewardItem.partyRewardProgressCurrent = progressCurrent
      rewardItem.partyRewardProgressMax = targetValue
      rewardItem.mintxt = tostring(progressCurrent)
      rewardItem.maxtxt = tostring(targetValue)
    else
      rewardItem.partyRewardShowProgressText = 0
      rewardItem.partyRewardProgressCurrent = nil
      rewardItem.partyRewardProgressMax = nil
      rewardItem.mintxt = ""
      rewardItem.maxtxt = ""
    end
  end
  local targetList = self:GetShowRewardList()
  local mobileList = self.bind.reward_item_listMobile
  targetList:clear()
  targetList:insert_array(displayList)
  self:hookRewardItemClaimProxy(targetList)
end

function this:refreshRedDot()
  local mainTabModule = self.modules and self.modules.module_commonTop or nil
  if not mainTabModule or not mainTabModule.refreshReddot then
    return
  end
  for _, tab in ipairs(self.main_tab_list or {}) do
    mainTabModule:refreshReddot(tab, self:hasNewRewardInMainTab(tab))
  end
end

function this:escHandle()
  L_UI:close(self.pageName)
end

function this:GetShowRewardList()
  if self.mainTabSelectId == TabPageType.Level then
    return self.bind.reward_item_list
  end
  return self.bind.star_item_list
end

return this
