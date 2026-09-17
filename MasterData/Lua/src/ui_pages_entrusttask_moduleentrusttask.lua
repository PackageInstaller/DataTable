local cls = class("moduleEntrustTask", G_UIModuleBase)
local _dungeonEntrustTagTpl = L_GameTpl:getDungeonEntrustTagTpl()
local _dungeonEntrustTpl = L_GameTpl:getDungeonEntrustTpl()
local _dungeonEntrustRewardTpl = L_GameTpl:getDungeonEntrustRewardTpl()
local _taskTpl = L_GameTpl:getTaskTpl()
local _dungeonEntrustTypeTpl = L_GameTpl:getDungeonEntrustTypeTpl()
local L_EntrustStore = _ENV.L_EntrustStore
local AzurWorld = _ENV.AzurWorld
local tinsert = table.insert
local _taskTargetCache = {}
local _taskTargetCacheBuilt = false
local _modeStaticCache = {}
local _tabList = {}

local function getModeStaticInfo()
  local cache = _modeStaticCache[1]
  if cache then
    return cache
  end
  cache = {}
  local modeInfo = _dungeonEntrustTpl:getInfoByDifficulty()
  if modeInfo then
    for _, groupData in ipairs(modeInfo) do
      local group = {
        groupId = groupData.groupId,
        levelInfos = {}
      }
      for _, levelData_readonly in ipairs(groupData.levelInfos) do
        local tpl = _dungeonEntrustTpl:getTplById(levelData_readonly.id)
        local tags
        if tpl then
          tags = _dungeonEntrustTpl:getTag(tpl)
        end
        tinsert(group.levelInfos, {
          id = levelData_readonly.id,
          areaId = levelData_readonly.areaId,
          tags = tags,
          tpl = tpl
        })
      end
      tinsert(cache, group)
    end
  end
  _modeStaticCache[1] = cache
  return cache
end

local function rebuildTaskTargetCache()
  _taskTargetCache = {}
  _taskTargetCacheBuilt = true
  local taskList = AzurWorld.TaskMgr:GetTraceTaskList()
  if not taskList or taskList.Count == 0 then
    return
  end
  local taskTraceInfos = AzurWorld.TaskMgr:GetAllTaskTraceInfos()
  if not taskTraceInfos then
    return
  end
  if taskList.Count > 0 then
    for i = 0, taskList.Count - 1 do
      local traceTaskId = taskList[i]
      for taskId, traceInfoList in pairs(taskTraceInfos) do
        if traceInfoList and traceTaskId == taskId then
          local count = traceInfoList.Count
          for i = 0, count - 1 do
            local traceInfo = traceInfoList[i]
            if traceInfo and traceInfo.GetConditions then
              local conditions = traceInfo:GetConditions()
              local d = conditions[0]
              if conditions and conditions.Count >= 2 and conditions[0] == 13044 then
                local targetId = conditions[1]
                if targetId ~= nil and _taskTargetCache[targetId] == nil then
                  local tabType
                  local data = _taskTpl:getTplById(taskId)
                  if data then
                    tabType = data.tabType
                  end
                  _taskTargetCache[targetId] = {
                    isTarget = true,
                    taskId = taskId,
                    tabType = tabType
                  }
                end
              end
            end
          end
        end
      end
    end
  end
end

local RewardBoxEnum = {
  HasReward = "UI/Atlas/EntrustTask/tex_dungeonentrust_icon_bx_box_01.png",
  NoReward = "UI/Atlas/EntrustTask/tex_dungeonentrust_icon_bx_box_02.png"
}
local RewardStarEnum = {
  HasReward = "UI/Atlas/EntrustTask/tex_dungeonentrust_icon_bx_Star_01.png",
  NoReward = "UI/Atlas/EntrustTask/tex_dungeonentrust_icon_bx_Star_02.png"
}

function cls.bind()
  return {
    module_tabList = {
      moduleName = "pages/entrustTask/moduleEntrustTaskFilterTabList"
    },
    moduleEntrustLevelDetails = {
      moduleName = "pages/entrustTask/moduleEntrustLevelDetails"
    },
    moduleEntrustAreaList = {
      moduleName = "pages/entrustTask/moduleEntrustAreaList"
    },
    moduleEntrustAreaTag = {
      moduleName = "pages/entrustTask/moduleEntrustAreaChange"
    },
    table_allTaskList = {
      moduleName = "pages/entrustTask/cellEntrustTaskGroup"
    },
    table_filterTaskList = {
      moduleName = "pages/entrustTask/cellEntrustTask"
    },
    moduleTalentReward = {
      moduleName = "pages/common/modules/moduleRewardTipBtn"
    },
    img_rewardBox = "",
    img_rewardStar = "",
    txt_starNum = "",
    active_numBg = true,
    go_allTaskList = false,
    go_filterTaskList = false,
    active_areaTag = true,
    active_rewardBtn = true
  }
end

function cls.methods()
  return {
    onClick_openBox = function(self)
      self:onBtnOpenBox()
    end
  }
end

function cls:toBind(uiBinding)
  cls.super.toBind(self, uiBinding)
end

function cls:open()
  L_EntrustStore:listenCallFunc(L_EntrustStore.event.entrustRewardRefresh, self.onEvent_entrustRewardRefresh, self)
  L_EntrustStore:listenCallFunc(L_EntrustStore.event.entrustLevelSelect, self.onEvent_entrustLevelSelect, self)
  self.selectFilterType = 6
  self.selectDifficultyIndex = 1
  self.groupFolder = {}
  self.isInit = false
  self:initTabList()
  self:refreshBoxInfo()
  self.modules.moduleEntrustAreaTag:setPage(self)
end

function cls:initTabList()
  local tabList = {}
  for index, tpl in ipairs(_dungeonEntrustTagTpl:getShowData()) do
    local tagId = _dungeonEntrustTagTpl:getId(tpl)
    if self:checkHaveDataByTagId(tagId) then
      table.insert(tabList, tagId)
    end
  end
  self.modules.module_tabList:setData(tabList, function(tabId)
    local tpl = _dungeonEntrustTagTpl:getTplById(tabId)
    if not tpl then
      return
    end
    self.selectFilterType = tabId
    self:updateEntrustTaskList(self.lastSelectType ~= tabId)
    self.lastSelectType = tabId
    self.isInit = true
  end, 1)
  _tabList = tabList
  self:updateEntrustTaskList(true)
end

function cls:updateEntrustTaskList(bChangeTab)
  if self:checkIsMainTaskTargetFilter() then
    self.bind.active_areaTag = true
    self:refreshShow(self.areaId, bChangeTab)
  else
    self.bind.active_areaTag = false
    self:refreshShow(0, bChangeTab)
  end
end

function cls:refreshBoxInfo()
  local tpl = _dungeonEntrustTypeTpl:getTplById(L_Const.EntrustTypeEnum.AreaEntrust)
  if tpl and _dungeonEntrustTypeTpl:getStarRewardIsShow(tpl) == 0 then
    self.bind.active_rewardBtn = false
    return
  end
  self.bind.active_rewardBtn = true
  local curStarNum = L_EntrustStore:getEntrustStarNumByDifficulty(L_Const.EntrustTypeEnum.AreaEntrust, self.selectDifficultyIndex)
  local firstRewardStarNum, rewardId = L_EntrustStore:getFirstCanReceiveStarNum(L_Const.EntrustTypeEnum.AreaEntrust, self.selectDifficultyIndex)
  local canReceiveReward = curStarNum >= firstRewardStarNum and 0 < rewardId
  self.modules.moduleTalentReward:refreshState(canReceiveReward)
  L_ReddotManager:registerReddot(self.bindComponents.reddot_starReward, L_ReddotManager.DotDef.EntrustStarReward)
  if canReceiveReward then
  else
    self.bind.txt_starNum = string.format("%s/%s", curStarNum, firstRewardStarNum)
  end
  self.modules.moduleTalentReward:setStarImage(canReceiveReward and RewardStarEnum.HasReward or RewardStarEnum.NoReward)
  self.modules.moduleTalentReward:setBoxImage(canReceiveReward and RewardBoxEnum.HasReward or RewardBoxEnum.NoReward)
  self.bindComponents.rewardBtn.legacyAnimationTriggers.normalTrigger = canReceiveReward and "anim_entrust_normal_full" or "anim_entrust_normal"
  self.bindComponents.rewardBtn.legacyAnimationTriggers.highlightedTrigger = canReceiveReward and "anim_entrust_hover_full" or "anim_entrust_hover"
  self.bindComponents.rewardBtn.legacyAnimationTriggers.selectedTrigger = canReceiveReward and "anim_entrust_Selected_full" or "anim_entrust_Selected"
end

function cls:checkIsSpecialFilter()
  local cfg = _dungeonEntrustTagTpl:getTplById(self.selectFilterType)
  return _dungeonEntrustTagTpl:checkIsSpecial(cfg)
end

function cls:initGroupTask(bChangeTab)
  local modeInfo = _dungeonEntrustTpl:getInfoByDifficulty()
  if self:checkIsSpecialFilter() then
    self.bind.go_allTaskList = true
    self.bind.go_filterTaskList = false
    self.bindComponents.scroll_taskListAnim:Rewind()
    self.bindComponents.scroll_taskListAnim:Play()
    
    local function onClick_select(cell)
      if self.groupFolder[cell.bind.groupId] then
        self.groupFolder[cell.bind.groupId] = not self.groupFolder[cell.bind.groupId]
      else
        self.groupFolder[cell.bind.groupId] = true
      end
      L_EntrustStore:call(L_EntrustStore.event.entrustTaskGroupFolder, cell.bind.groupId, self.groupFolder[cell.bind.groupId])
    end
    
    self.allInfo = {}
    local index = 1
    for _, v in ipairs(modeInfo) do
      local levelInfo = {}
      for _, v1 in ipairs(v.levelInfos) do
        if L_EntrustStore:checkEntrustLevelShow(v1.id) then
          table.insert(levelInfo, v1)
        end
      end
      if 0 < #levelInfo then
        table.insert(self.allInfo, {
          index = index,
          levelInfos = levelInfo,
          groupId = v.groupId,
          bFold = self.groupFolder[v.groupId],
          cbk = onClick_select
        })
        index = index + 1
      end
    end
    self:getInitSelectEntrustId()
    for _, v in ipairs(self.allInfo) do
      v.selectEntrustTaskId = self.selectEntrustTaskId
    end
    self.bind.table_allTaskList:clear()
    self.bind.table_allTaskList:insert_array(self.allInfo)
    self:refreshSelectLevelDetails(bChangeTab)
    return
  end
  self.bind.go_allTaskList = false
  self.bind.go_filterTaskList = true
  self.bindComponents.scroll_filtertaskListAnim:Rewind()
  self.bindComponents.scroll_filtertaskListAnim:Play()
  
  local function onClick_select(cell)
    local bUnlock = L_EntrustStore:checkEntrustLevelUnlock(cell.bind.levelId)
    if not bUnlock then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_cellPetDuelLevel"))
      return
    end
    if self.selectEntrustTaskId ~= cell.bind.levelId then
      self.selectEntrustTaskId = cell.bind.levelId
      for i = 1, #self.bind.table_filterTaskList do
        self.bind.table_filterTaskList:change(i, {
          selectEntrustTaskId = self.selectEntrustTaskId
        })
      end
      self:refreshSelectLevelDetails(false, true)
    end
  end
  
  self.filterInfo = {}
  local index = 1
  for _, v in ipairs(modeInfo) do
    for _, v1 in ipairs(v.levelInfos) do
      if L_EntrustStore:checkEntrustLevelShow(v1.id) then
        local cfg = _dungeonEntrustTpl:getTplById(v1.id)
        local tag = _dungeonEntrustTpl:getTag(cfg)
        if tag then
          for _, v in ipairs(tag) do
            if v == self.selectFilterType then
              table.insert(self.filterInfo, {
                index = index,
                levelId = v1.id,
                cbk = onClick_select
              })
              index = index + 1
              break
            end
          end
        end
      end
    end
  end
  table.sort(self.filterInfo, function(a, b)
    local isCompleteA, strTipsA = L_EntrustStore:checkEntrustLevelUnlock(a.levelId)
    local isCompleteB, strTipsB = L_EntrustStore:checkEntrustLevelUnlock(b.levelId)
    if isCompleteA and not isCompleteB then
      return true
    end
    if not isCompleteA and isCompleteB then
      return false
    end
    return a.index < b.index
  end)
  index = 1
  for _, v in ipairs(self.filterInfo) do
    v.index = index
    index = index + 1
  end
  self:getInitSelectEntrustId()
  for _, v in ipairs(self.filterInfo) do
    v.selectEntrustTaskId = self.selectEntrustTaskId
  end
  self.bind.table_filterTaskList:clear()
  self.bind.table_filterTaskList:insert_array(self.filterInfo)
  self:refreshSelectLevelDetails(bChangeTab)
end

function cls:initArea(options)
  self.areaId = options.areaTplId
end

function cls:refreshShow(areaTplId, bchangeTab)
  if self:checkIsMainTaskTargetFilter() then
    self.areaId = areaTplId
  else
    self.areaId = 0
  end
  self:refreshGroupTask(bchangeTab)
end

function cls:getTrackedItemScrollIndex()
  if not self.selectEntrustTaskId then
    return nil
  end
  local currentIndex = 0
  for i = 1, #self.allInfo do
    local groupInfo = self.allInfo[i]
    currentIndex = currentIndex + 1
    if not groupInfo.bFold then
      for j = 1, #groupInfo.levelInfos do
        local levelInfo = groupInfo.levelInfos[j]
        currentIndex = currentIndex + 1
        if levelInfo.id == self.selectEntrustTaskId and levelInfo.isTaskTarget then
          return currentIndex
        end
      end
    end
  end
  return nil
end

function cls:findTrackedTaskInfo()
  if not self.selectEntrustTaskId then
    return nil
  end
  local parentIndex = 0
  for i = 1, #self.allInfo do
    local groupInfo = self.allInfo[i]
    parentIndex = parentIndex + 1
    if not groupInfo.bFold then
      for j = 1, #groupInfo.levelInfos do
        local levelInfo = groupInfo.levelInfos[j]
        local isUnlock = L_EntrustStore:checkEntrustLevelUnlock(levelInfo.id)
        if levelInfo.id == self.selectEntrustTaskId and levelInfo.isTaskTarget and isUnlock then
          return parentIndex, j, groupInfo, levelInfo
        end
      end
    end
  end
  return nil
end

function cls:findParentIndexAndChildIndexById(id)
  if not id then
    return nil
  end
  local parentIndex = 0
  local groupInfo, levelInfo
  for i = 1, #self.allInfo do
    groupInfo = self.allInfo[i]
    parentIndex = parentIndex + 1
    if not groupInfo.bFold then
      for j = 1, #groupInfo.levelInfos do
        levelInfo = groupInfo.levelInfos[j]
        if levelInfo.id == self.selectEntrustTaskId then
          return parentIndex, j, groupInfo, levelInfo
        end
      end
    end
  end
  return nil
end

function cls:refreshGroupTask(bChangeTab)
  local areaTplId = self.areaId
  if areaTplId == 0 then
    areaTplId = nil
  end
  self.bind.go_allTaskList = true
  self.bind.go_filterTaskList = false
  self.bindComponents.scroll_taskListAnim:Rewind()
  self.bindComponents.scroll_taskListAnim:Play()
  
  local function onClick_select_group(cell)
    if self.groupFolder[cell.bind.groupId] then
      self.groupFolder[cell.bind.groupId] = not self.groupFolder[cell.bind.groupId]
    else
      self.groupFolder[cell.bind.groupId] = true
    end
    L_EntrustStore:call(L_EntrustStore.event.entrustTaskGroupFolder, cell.bind.groupId, self.groupFolder[cell.bind.groupId])
    self.bindComponents.taskList_scroll:RefreshCells()
  end
  
  self.allInfo = {}
  local groupIndex = 1
  local modeInfo = getModeStaticInfo()
  local isSpecialFilter = self:checkIsSpecialFilter()
  local isTaskTargetFilter = self:checkIsTaskTargetFilter()
  local finishedCache = {}
  for _, groupData in ipairs(modeInfo) do
    local groupLevelInfos = {}
    for _, levelStatic in ipairs(groupData.levelInfos) do
      local levelId = levelStatic.id
      if L_EntrustStore:checkEntrustLevelShow(levelId) then
        local tpl = levelStatic.tpl
        local shouldAdd = false
        local tags = levelStatic.tags
        if isSpecialFilter then
          shouldAdd = true
        elseif isTaskTargetFilter then
        elseif tags then
          for _, tagId in ipairs(tags) do
            if tagId == self.selectFilterType then
              shouldAdd = true
              break
            end
          end
        end
        if shouldAdd and areaTplId and levelStatic.areaId ~= areaTplId then
          shouldAdd = false
        end
        if shouldAdd then
          local isTaskTarget, taskId = self:checkIsTaskTarget(tpl)
          local cacheEntry = _taskTargetCache[levelId]
          local taskType
          if isTaskTarget then
            if cacheEntry and cacheEntry.tabType ~= nil then
              taskType = cacheEntry.tabType
            elseif taskId then
              local data = _taskTpl:getTplById(taskId)
              if data then
                taskType = data.tabType
              end
            end
          end
          local uiLevelData = {
            id = levelId,
            areaId = levelStatic.areaId,
            isTaskTarget = isTaskTarget,
            taskType = taskType,
            tags = tags
          }
          tinsert(groupLevelInfos, uiLevelData)
        end
      end
    end
    if 0 < #groupLevelInfos then
      for _, v in ipairs(groupLevelInfos) do
        v.isUnlock = L_EntrustStore:checkEntrustLevelUnlock(v.id)
      end
      table.sort(groupLevelInfos, function(a, b)
        if a.isUnlock and not b.isUnlock then
          return true
        end
        if not a.isUnlock and b.isUnlock then
          return false
        end
        return a.id < b.id
      end)
      local number = 0
      for _, v in ipairs(groupLevelInfos) do
        if v.isUnlock then
          v.need_show_lock_bg = false
          v.lock_bg_length = 0
        else
          v.need_show_lock_bg = true
          v.lock_bg_length = #groupLevelInfos - number
          break
        end
        number = number + 1
      end
      tinsert(self.allInfo, {
        index = groupIndex,
        levelInfos = groupLevelInfos,
        groupId = groupData.groupId,
        bFold = self.groupFolder[groupData.groupId],
        cbk = onClick_select_group
      })
      groupIndex = groupIndex + 1
    end
  end
  local selectEntrustTaskId
  for i = 1, #self.allInfo do
    local groupInfo = self.allInfo[i]
    for j = 1, #groupInfo.levelInfos do
      local levelInfo = groupInfo.levelInfos[j]
      if levelInfo.isTaskTarget and levelInfo.isUnlock then
        selectEntrustTaskId = levelInfo.id
        self.groupFolder[groupInfo.groupId] = false
        groupInfo.bFold = false
        break
      end
    end
    if selectEntrustTaskId then
      break
    end
  end
  if not selectEntrustTaskId then
    for i = 1, #self.allInfo do
      local levelInfos = self.allInfo[i].levelInfos
      for j = 1, #levelInfos do
        local levelInfo = levelInfos[j]
        local levelId = levelInfo.id
        if levelInfo.isUnlock then
          local bFinished = finishedCache[levelId]
          if bFinished == nil then
            bFinished = L_EntrustStore:checkEntrustLevelSuc(levelId)
            finishedCache[levelId] = bFinished
          end
          if not bFinished then
            selectEntrustTaskId = levelId
            break
          end
        end
      end
      if selectEntrustTaskId then
        break
      end
    end
  end
  if not selectEntrustTaskId then
    for i = #self.allInfo, 1, -1 do
      local levelInfos = self.allInfo[i].levelInfos
      for j = #levelInfos, 1, -1 do
        local levelInfo = levelInfos[j]
        if levelInfo.isUnlock then
          selectEntrustTaskId = levelInfo.id
          break
        end
      end
      if selectEntrustTaskId then
        break
      end
    end
  end
  self.selectEntrustTaskId = selectEntrustTaskId
  for _, v in ipairs(self.allInfo) do
    v.selectEntrustTaskId = self.selectEntrustTaskId
  end
  for i = 1, #self.bind.table_allTaskList do
    local Cell = self.bind.table_allTaskList:getItemCls(i)
    if Cell then
      Cell:setFolder(true)
    end
  end
  self.bind.table_allTaskList:clear()
  self.bind.table_allTaskList:insert_array(self.allInfo)
  local parentIndex, childIndex = self:findTrackedTaskInfo()
  self:scrollToNew(parentIndex, childIndex)
  self:refreshSelectLevelDetails(bChangeTab)
end

function cls:InternalScrollTo(parentIndex, childIndex)
  if parentIndex and childIndex then
    if not self.isBind then
      return
    end
    Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.root)
    local parentCell = self.bind.table_allTaskList:getItemCls(parentIndex)
    if not (parentCell and parentCell.gameObject) or not L_CommonUtil.isValid(parentCell.gameObject) then
      print("警告: 无法获取到父Cell，索引: " .. parentIndex)
      return
    end
    local childCell = parentCell:getChildItem(childIndex)
    if not childCell then
      print("警告: 无法从父Cell中获取子项，父索引: " .. parentIndex .. ", 子索引: " .. childIndex)
      return
    end
    local childGameObject = childCell.gameObject
    if not childGameObject or not L_CommonUtil.isValid(childGameObject) then
      print("警告: 无法从父Cell中获取子项GameObject，父索引: " .. parentIndex .. ", 子索引: " .. childIndex)
      return
    end
    local scrollRect = self.bindComponents.taskList_scroll
    local childRectTransform = childGameObject.transform
    local parentRectTransform = parentCell.gameObject.transform
    local parentLocalPos = parentRectTransform.anchoredPosition
    local childLocalPos = childRectTransform.anchoredPosition
    local childHeight = childRectTransform.rect.height
    local childPivot = childRectTransform.pivot
    local pivotToTopEdgeOffset = childHeight * (1 - childPivot.y)
    local childTopEdgeInParentY = childLocalPos.y + pivotToTopEdgeOffset
    local finalTopEdgeY = parentLocalPos.y + childTopEdgeInParentY
    local paddingTop = 20
    local targetContentY = -finalTopEdgeY + paddingTop
    local contentRect = scrollRect.content
    local contentHeight = contentRect.rect.height
    local viewportHeight = scrollRect.viewport.rect.height
    if contentHeight > viewportHeight then
      local maxScrollY = contentHeight - viewportHeight
      targetContentY = math.min(targetContentY, maxScrollY)
      targetContentY = math.max(targetContentY, 0)
    else
      targetContentY = 0
    end
    Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(contentRect)
    local newPos = contentRect.anchoredPosition
    newPos.y = targetContentY
    contentRect.anchoredPosition = newPos
    print("滚动到任务，ID: " .. tostring(self.selectEntrustTaskId) .. L_WordsTpl:getValue("residual_code_moduleentrusttask_01") .. parentIndex .. ", 子索引: " .. childIndex)
  end
end

function cls:scrollToNew(parentIndex, childIndex)
  if not parentIndex then
    return
  end
  if self.bindComponents and self.bindComponents.taskList_scroll then
    self.waitForJump = true
    self.cacheJumpParentIndex = parentIndex
    self.cacheJumpChildIndex = childIndex
    self.jumpHandle = handler(self, self.JumpToTargetAfterAllLoaded)
    self.bindComponents.taskList_scroll.refreshCellsFinish = self.jumpHandle
    local animName = "anim_entrust_challenge_list_in"
    local animationClip = self.bindComponents.scroll_taskListAnim:GetClip(animName)
    if animationClip then
      local animComp = self.bindComponents.scroll_taskListAnim
      local state = animComp.get_Item and animComp:get_Item(animName)
      if state then
        state.time = animationClip.length
      end
    end
    self.bindComponents.scroll_taskListAnim:Stop()
    self.bindComponents.taskList_scroll:FocusItemIndex(parentIndex - 1)
  end
end

function cls:JumpToTargetAfterAllLoaded()
  if not self or not self.waitForJump then
    return
  end
  self.waitForJump = false
  self:InternalScrollTo(self.cacheJumpParentIndex, self.cacheJumpChildIndex)
end

function cls:checkIsTaskTargetFilter()
  local cfg = _dungeonEntrustTagTpl:getTplById(self.selectFilterType)
  if cfg then
    local isTarget, id = _dungeonEntrustTagTpl:checkIsTaskTarget(cfg)
    return isTarget
  end
  return false
end

function cls:checkIsMainTaskTargetFilter()
  local cfg = _dungeonEntrustTagTpl:getTplById(self.selectFilterType)
  if cfg then
    local isTarget, id = _dungeonEntrustTagTpl:checkIsMainTask(cfg)
    return isTarget
  end
  return false
end

function cls:checkIsTaskTarget(tpl)
  local targetId = _dungeonEntrustTpl:getId(tpl)
  if not targetId then
    return false, -1
  end
  local cacheEntry = _taskTargetCache[targetId]
  if cacheEntry ~= nil then
    if cacheEntry.isTarget then
      return true, cacheEntry.taskId
    else
      return false, -1
    end
  end
  if not _taskTargetCacheBuilt then
    rebuildTaskTargetCache()
    cacheEntry = _taskTargetCache[targetId]
    if cacheEntry ~= nil then
      if cacheEntry.isTarget then
        return true, cacheEntry.taskId
      else
        return false, -1
      end
    end
  end
  _taskTargetCache[targetId] = {isTarget = false, taskId = -1}
  return false, -1
end

function cls:getInitSelectEntrustId()
  self.selectEntrustTaskId = nil
  for i = 1, #self.allInfo do
    local groupInfo = self.allInfo[i]
    for j = 1, #groupInfo.levelInfos do
      local levelInfo = groupInfo.levelInfos[j]
      if levelInfo.isTaskTarget then
        self.selectEntrustTaskId = levelInfo.id
        self.groupFolder[groupInfo.groupId] = false
        groupInfo.bFold = false
        return
      end
    end
  end
  if not self.selectEntrustTaskId then
    for i = 1, #self.allInfo do
      local levelInfos = self.allInfo[i].levelInfos
      for j = 1, #levelInfos do
        local levelId = levelInfos[j].id
        local bUnlock = L_EntrustStore:checkEntrustLevelUnlock(levelId)
        local bFinished = L_EntrustStore:checkEntrustLevelSuc(levelId)
        if bUnlock and not bFinished then
          self.selectEntrustTaskId = levelId
          return
        end
      end
    end
  end
  if not self.selectEntrustTaskId then
    for i = #self.allInfo, 1, -1 do
      local levelInfos = self.allInfo[i].levelInfos
      for j = #levelInfos, 1, -1 do
        local levelId = levelInfos[j].id
        local bUnlock = L_EntrustStore:checkEntrustLevelUnlock(levelId)
        if bUnlock then
          self.selectEntrustTaskId = levelId
          return
        end
      end
    end
  end
end

function cls:setSelectEntrustTask(id)
  local tpl = _dungeonEntrustTpl:getTplById(id)
  local tags = _dungeonEntrustTpl:getTag(tpl)
  local selectId = 1
  if tags then
    local isSelect = false
    for _, tagId in ipairs(tags) do
      if tagId == self.selectFilterType then
        isSelect = true
        break
      end
    end
    selectId = not isSelect and tags[1] and tags[1] or selectId
  end
  self.modules.module_tabList:setSelectTabId(selectId)
  self.selectEntrustTaskId = id
  for i = 1, #self.bind.table_allTaskList do
    self.bind.table_allTaskList:change(i, {
      selectEntrustTaskId = self.selectEntrustTaskId
    })
  end
  local parentIndex, childIndex = self:findParentIndexAndChildIndexById(id)
  self:scrollToNew(parentIndex, childIndex)
  self:refreshSelectLevelDetails(false, true)
end

function cls:refreshSelectLevelDetails(bChangeTab, bChangeLevel)
  local moduleEntrustLevelDetails = self.modules.moduleEntrustLevelDetails
  if not self.selectEntrustTaskId then
    moduleEntrustLevelDetails:setShow(false)
    return
  end
  moduleEntrustLevelDetails:setShow(true)
  moduleEntrustLevelDetails:initAreaEntrustDetails(self.selectEntrustTaskId, bChangeTab, bChangeLevel, true)
end

function cls:onEvent_entrustLevelSelect(levelId)
  if self.selectEntrustTaskId == levelId then
    return
  end
  self.selectEntrustTaskId = levelId
  for i = 1, #self.bind.table_allTaskList do
    self.bind.table_allTaskList:change(i, {
      selectEntrustTaskId = self.selectEntrustTaskId
    })
  end
  self:refreshSelectLevelDetails(false, true)
end

function cls:onEvent_entrustRewardRefresh()
  self:refreshBoxInfo()
end

function cls:onBtnOpenBox()
  self.bind.active_bg = true
  Timer.once(0.4, function()
    self.bind.active_bg = false
    local curStarNum = L_EntrustStore:getEntrustStarNumByDifficulty(L_Const.EntrustTypeEnum.AreaEntrust, self.selectDifficultyIndex)
    local rewardIdList = L_EntrustStore:getCanReceiveRewardIdList(L_Const.EntrustTypeEnum.AreaEntrust, curStarNum, self.selectDifficultyIndex)
    if rewardIdList then
      L_EntrustStore:req_getEntrustReward(rewardIdList)
      return
    end
    local list, index = self:getRewardList()
    L_UI:open("pageCommonRewardsTip", {
      title = L_WordsTpl:getValue("ui_common_rewardlist_title_entrust"),
      module_list = list,
      selectIndex = index
    })
  end, self, self.gameObject)
end

function cls:close(options)
  self.waitForJump = false
  self.cacheJumpParentIndex = nil
  self.cacheJumpChildIndex = nil
  _taskTargetCache = {}
  _modeStaticCache = {}
  _taskTargetCacheBuilt = false
  if self.timer then
    Timer.remove(self.timer)
    self.timer = nil
  end
  L_TimerManager:clearTimer(self)
  L_EntrustStore:unListenCallFunc(L_EntrustStore.event.entrustRewardRefresh, self.onEvent_entrustRewardRefresh, self)
  L_EntrustStore:unListenCallFunc(L_EntrustStore.event.entrustLevelSelect, self.onEvent_entrustLevelSelect, self)
  cls.super.close(self, options)
end

function cls:unBind()
  cls.super.unBind(self)
end

function cls:activate()
  self:open()
  self:openModules()
  self:show()
  self:showModules()
end

function cls:deActivate()
  self:hide()
  self:hideModules()
  self:close()
  self:closeModules()
end

function cls:checkHaveData(aeraId)
  local modeInfo = _dungeonEntrustTpl:getInfoByDifficulty()
  for _, groupData in ipairs(modeInfo) do
    for _, levelData_readonly in ipairs(groupData.levelInfos) do
      if L_EntrustStore:checkEntrustLevelShow(levelData_readonly.id) then
        local tpl = _dungeonEntrustTpl:getTplById(levelData_readonly.id)
        local id = _dungeonEntrustTpl:getAreaIdByTpl(tpl)
        if id == aeraId then
          return true
        end
      end
    end
  end
  return false
end

function cls:checkHaveDataByTagId(tagId)
  local modeInfo = _dungeonEntrustTpl:getInfoByDifficulty()
  for _, groupData in ipairs(modeInfo) do
    for _, levelData_readonly in ipairs(groupData.levelInfos) do
      if L_EntrustStore:checkEntrustLevelShow(levelData_readonly.id) then
        local tpl = _dungeonEntrustTpl:getTplById(levelData_readonly.id)
        local tags = _dungeonEntrustTpl:getTag(tpl)
        for k, v in pairs(tags) do
          if tagId == v then
            return true
          end
        end
      end
    end
  end
  return false
end

function cls:getRewardList()
  local list = {}
  local modeInfo = _dungeonEntrustRewardTpl:getInfoByDifficulty(L_Const.EntrustTypeEnum.AreaEntrust, self.selectDifficultyIndex) or {}
  local _, canReceiveRewardId = L_EntrustStore:getFirstCanReceiveStarNum(L_Const.EntrustTypeEnum.AreaEntrust, self.selectDifficultyIndex)
  local selectRewardIndex = 1
  for index, v in ipairs(modeInfo) do
    local cfg = _dungeonEntrustRewardTpl:getTplById(v.id)
    local reward = _dungeonEntrustRewardTpl:getReward(cfg)
    local received = L_EntrustStore:checkEntrustRewardReceived(v.id)
    local starNum = string.format("x%s", _dungeonEntrustRewardTpl:getStarNum(cfg))
    local rewardItems = {}
    for i = 1, #reward do
      local item = L_ItemTplManager:getItemConfig(reward[i].itemType, reward[i].itemId)
      table.insert(rewardItems, {
        itemType = item.itemType,
        itemId = item.itemId,
        num = reward[i].itemNum,
        received = received
      })
    end
    local isActive = canReceiveRewardId == v.id
    if isActive then
      selectRewardIndex = index
    end
    table.insert(list, {
      isStar = true,
      number = starNum,
      rewardList = rewardItems,
      isSelect = isActive
    })
  end
  return list, selectRewardIndex
end

function cls:setSelectTab(tabId)
  local tpl = _dungeonEntrustTagTpl:getTplById(tabId)
  if not tpl then
    return
  end
  local containValue = false
  for k, v in pairs(_tabList) do
    if tabId == v then
      containValue = true
      break
    end
  end
  tabId = containValue and tabId or _tabList[1]
  self.modules.module_tabList:setSelectTabId(tabId)
  self.selectFilterType = tabId
  self:updateEntrustTaskList(self.isInit)
  self.isInit = true
end

return cls
