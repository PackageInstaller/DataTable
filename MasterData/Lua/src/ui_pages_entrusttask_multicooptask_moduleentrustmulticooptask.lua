local this = class("moduleEntrustMultiCoopTask", G_UIModuleBase)
local _trainTaskTpl = L_GameTpl:getTrainTaskTpl()
local _dungeonCrisisCrusadeTpl = L_GameTpl:getDungeonCrisisCrusadeTpl()
local _dungeonCrisisCrusadeDiffTagTpl = L_GameTpl:getDungeonCrisisCrusadeDiffTagTpl()
local DUNGEONCOSTNORMAL_RESOURCE_BAR_ITEM_TPL_ID = 411
local DUNGEONCOSTSPECIAL_RESOURCE_BAR_ITEM_TPL_ID = 412
local DUNGEON_ENTRUST_ENTRANCE_PAGE_NAME = "pageDungeonEntrustEntrance"
local ENTRUST_TASK_ENTRANCE_PAGE_NAME = "pageEntrustTaskEntrance"
local C_DUNGEON_ENTRUST_TIMELINE = CS.Azur.Gameplay.Timeline.DungeonEntrustTimeline

local function getTimelineControl(self)
  if self.parent and self.parent.timelineControl then
    return self.parent.timelineControl
  end
  if self.timelineControl then
    return self.timelineControl
  end
  local entrancePage = L_UI:getPage(ENTRUST_TASK_ENTRANCE_PAGE_NAME)
  if entrancePage and entrancePage.timelineControl then
    return entrancePage.timelineControl
  end
  return nil
end

local function setDungeonEntrustEntranceTimelineVisible(visible)
  local page = C_UIMgr.GetPage(DUNGEON_ENTRUST_ENTRANCE_PAGE_NAME)
  if not page then
    return
  end
  local getModuleGeneric = xlua.get_generic_method(page:GetType(), "GetModule")
  local getModule = getModuleGeneric(C_DUNGEON_ENTRUST_TIMELINE)
  local timeline = getModule(page)
  if not timeline then
    return
  end
  timeline:SetVisible(visible)
end

function this.bind()
  return {
    selectId_taskDiff = 1,
    list_trainTaskType = {
      moduleName = "pages/entrustTask/multiCoopTask/cellEntrustTaskDiffFilterTabItem"
    },
    list_trainTask = {
      moduleName = "pages/entrustTask/multiCoopTask/cellEntrustMultiCoopTask"
    },
    moduleEntrustLevelDetails = {
      moduleName = "pages/entrustTask/multiCoopTask/moduleEntrustMultiCoopDetails"
    },
    module_currency = {
      moduleName = "modulePages/moduleCurrency"
    },
    localPosition_diffContent = nil
  }
end

function this.methods()
  return {
    onSelectTabId_trainTaskType = function(self, id)
      if id == self._selectDifficultyIndex then
        return
      end
      self._selectDifficultyIndex = id
      self:clearDifficultyTab()
      if self.isInitSwitch then
        self:refreshTrainTaskType()
      else
        self:refreshTrainTaskType(true, false)
      end
      C_AudioManager.Play("Play_SFX_System_UI_EnTrust_Tab_Pencil")
    end,
    onClick_enterShop = function(self)
      local entrustShopId = L_GameConstTpl:getData("DUNGEON_SHOPGROUPID", L_Const.GameTplType.int)
      local timelineControl = getTimelineControl(self)
      if timelineControl then
        timelineControl:stopTimeline()
        timelineControl:setCameraTimelineActive(false)
        timelineControl:setTimelineActive(false)
      end
      setDungeonEntrustEntranceTimelineVisible(false)
      L_JumpMgr:jumpTo(entrustShopId)
    end
  }
end

function this:open()
  self._selectDifficultyIndex = self:calFitDiffLevel()
  self:unListenMultiEvent()
  self._onEvent_specialMultiCoopEntrustGetHandle = self._onEvent_specialMultiCoopEntrustGetHandle or handler(self, self.onSpecialMultiCoopEntrustRefresh)
  C_MultiEvent.instance:Listen(C_EMultiEvent.MultiLimitChange, self._onEvent_specialMultiCoopEntrustGetHandle)
  self:initModule()
end

function this:close()
  self:unListenMultiEvent()
end

function this:unListenMultiEvent()
  if self._onEvent_specialMultiCoopEntrustGetHandle ~= nil then
    C_MultiEvent.instance:Cancel(C_EMultiEvent.MultiLimitChange, self._onEvent_specialMultiCoopEntrustGetHandle)
  end
  self._onEvent_specialMultiCoopEntrustGetHandle = nil
end

function this:initModule()
  self.isInitSwitch = true
  self:refreshTrainTaskTypeList()
  self.bind.selectId_taskDiff = self._selectDifficultyIndex
  self.bind.localPosition_diffContent = L_Vector3.new(0, 30 * self._selectDifficultyIndex, 0)
  self:initSpecialEntrustList()
  self:refreshTrainTaskType()
  self.isInitSwitch = false
  self:refreshTeamState()
  self:clearDifficultyTab()
end

function this:clearDifficultyTab()
  for i = 1, #self.bind.list_trainTask do
    local data = self.bind.list_trainTaskType:getItemCls(i)
    if data ~= nil then
      local iter_id = data:getId()
      if iter_id == self._selectDifficultyIndex then
        data:clearRedPoint()
      end
    end
  end
end

function this:initCurrencyList()
  self.modules.module_currency:refreshResByResBarTplIdList({DUNGEONCOSTSPECIAL_RESOURCE_BAR_ITEM_TPL_ID, DUNGEONCOSTNORMAL_RESOURCE_BAR_ITEM_TPL_ID})
end

function this:refreshTrainTaskTypeList()
  local dataList = {}
  local data = _dungeonCrisisCrusadeDiffTagTpl:getData()
  for i, v in ipairs(data) do
    table.insert(dataList, {
      id = v.id
    })
  end
  self.bind.list_trainTaskType:freshAll(dataList)
end

function this:refreshTrainTaskType(bChangeTab, bChangeLevel)
  self:refreshTaskList(bChangeTab)
  self:refreshSelectLevelDetails(bChangeTab, bChangeLevel)
end

function this:refreshTaskList(bChangeTab)
  local function onClick_select(cell)
    if self.selectEntrustTaskId == cell.bind.levelId then
      return
    end
    local bUnlock = L_MultiDungeonStore:getMultiDungeonIsUnlock(cell.bind.levelId)
    if not bUnlock then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_cellPetDuelLevel"))
      return
    end
    self.selectEntrustTaskId = cell.bind.levelId
    for i = 1, #self.bind.list_trainTask do
      self.bind.list_trainTask:change(i, {
        selectEntrustTaskId = self.selectEntrustTaskId
      })
    end
    self:refreshSelectLevelDetails(false, true)
  end
  
  local data = _dungeonCrisisCrusadeTpl:getTplListByDiffTag(self._selectDifficultyIndex)
  self.taskList = {}
  for _, v in ipairs(data) do
    local isSpecial = self:checkIsSpecial(v.id)
    local isShow = self:checkIsSpecialShow(v.id)
    local isSpecialShow = isSpecial and isShow
    if L_MultiDungeonStore:getMultiDungeonIsShown(v.id) and (not isSpecial or isSpecialShow) then
      table.insert(self.taskList, {
        levelId = v.id,
        curRoomLevelId = self.curRoomLevelId,
        callback = onClick_select
      })
    end
  end
  table.sort(self.taskList, function(a, b)
    local isUnlockA, strTipsA = L_MultiDungeonStore:getMultiDungeonIsUnlock(a.levelId)
    local isUnlockB, strTipsB = L_MultiDungeonStore:getMultiDungeonIsUnlock(b.levelId)
    local scoreA = L_MultiDungeonStore:getMultiDungeonPassScore(a.levelId)
    local scoreB = L_MultiDungeonStore:getMultiDungeonPassScore(b.levelId)
    if isUnlockA and not isUnlockB then
      return true
    end
    if not isUnlockA and isUnlockB then
      return false
    end
    if scoreA ~= scoreB then
      return scoreA < scoreB
    end
    if a.sortId ~= b.sortId then
      return a.sortId < b.sortId
    end
    if a.difficulty ~= b.difficulty then
      return a.difficulty < b.difficulty
    end
    return a.levelId < b.levelId
  end)
  if #self.taskList ~= 0 then
    self.selectEntrustTaskId = self.taskList[1].levelId
  end
  if not bChangeTab and self.curRoomLevelId ~= 0 then
    self.selectEntrustTaskId = self.curRoomLevelId
  end
  if self.jumpTargetLevelId and self.jumpTargetLevelId ~= 0 then
    self.selectEntrustTaskId = self.jumpTargetLevelId
    self.jumpTargetLevelId = 0
  end
  for _, v in ipairs(self.taskList) do
    v.selectEntrustTaskId = self.selectEntrustTaskId
  end
  self.bind.list_trainTask:clear()
  self.bind.list_trainTask:insert_array(self.taskList)
  self.bindComponents.anim_taskList:Stop()
  self.bindComponents.anim_taskList:Rewind()
  self.bindComponents.anim_taskList:Play("anim_entrust_challenge_list_in")
  self:refreshTaskListLockHeight()
end

function this:calFitDiffLevel()
  local dif = self:getMultiDungeonRoomLevelDiff()
  if self.jumpTargetLevelId and self.jumpTargetLevelId ~= 0 then
    dif = _dungeonCrisisCrusadeTpl:getDifficulty(_dungeonCrisisCrusadeTpl:getTplById(self.jumpTargetLevelId))
  end
  if dif ~= 0 then
    return dif
  end
  local data = _dungeonCrisisCrusadeDiffTagTpl:getData()
  local fitDiffLevel = 1
  for i, v in ipairs(data) do
    local tpl = _dungeonCrisisCrusadeDiffTagTpl:getTplById(v.id)
    local unlockLevel = _dungeonCrisisCrusadeDiffTagTpl:getUnlockLevel(tpl)
    local playerInfo = L_PlayerStore:getPlayerBaseInfo()
    local lv, isMaxLv = L_FriendStore:getPlayerLevel(playerInfo)
    if unlockLevel > lv then
      return fitDiffLevel
    else
      fitDiffLevel = i
    end
  end
  return fitDiffLevel
end

function this:getMultiDungeonRoomLevelDiff()
  local dungeonId = C_MultiTeam.GetDungeonId()
  local curRoomLevel = _dungeonCrisisCrusadeTpl:getLevelIdByDungeonId(dungeonId)
  if curRoomLevel == 0 then
    return 0
  end
  self.curRoomLevelId = curRoomLevel
  local dif = _dungeonCrisisCrusadeTpl:getDifficulty(_dungeonCrisisCrusadeTpl:getTplById(curRoomLevel))
  return dif
end

function this:getInitSelectEntrustId()
  self.selectEntrustTaskId = nil
  for i = 1, #self.taskList do
    local bUnlock = L_EntrustStore:checkEntrustLevelUnlock(self.taskList[i].levelId)
    local bFinished = L_EntrustStore:checkEntrustLevelSuc(self.taskList[i].levelId)
    if bUnlock and not bFinished then
      self.selectEntrustTaskId = self.filterInfo[i].levelId
      return
    end
  end
  if not self.selectEntrustTaskId then
    for i = #self.taskList, 1, -1 do
      local bUnlock = L_EntrustStore:checkEntrustLevelUnlock(self.filterInfo[i].levelId)
      if bUnlock then
        self.selectEntrustTaskId = self.filterInfo[i].levelId
        return
      end
    end
  end
  if not self.selectEntrustTaskId then
    errorf("该难度下没有任何可选任务 difficulty = " .. tostring(self._selectDifficultyIndex))
  end
end

function this:setTaskListSelect()
  for i, v in pairs(self.modules.list_trainTask) do
    local cell = v
    cell:setSelect(cell.bind.taskId == self._selectTaskId)
  end
end

function this:refreshTaskListLockHeight()
  local lockCount = 0
  local firstLockCell
  for i, v in pairs(self.modules.list_trainTask) do
    local cell = v
    local unlock, strTips = L_MultiDungeonStore:getMultiDungeonIsUnlock(v.bind.levelId)
    if not unlock then
      if lockCount == 0 then
        firstLockCell = cell
      end
      lockCount = lockCount + 1
      cell:hideMask()
    elseif 0 < lockCount then
      firstLockCell:adjustLockMaskHeight(lockCount)
      lockCount = 0
      firstLockCell = nil
    end
  end
  if 0 < lockCount and firstLockCell then
    firstLockCell:adjustLockMaskHeight(lockCount)
  end
end

function this:refreshSelectLevel(levelId)
  self.curRoomLevelId = levelId
  for i = 1, #self.bind.list_trainTask do
    self.bind.list_trainTask:change(i, {
      curRoomLevelId = self.curRoomLevelId
    })
  end
  local tpl = _dungeonCrisisCrusadeTpl:getTplById(levelId)
  if tpl ~= nil then
    local targetDiff = _dungeonCrisisCrusadeTpl:getDifficulty(tpl)
    if self._selectDifficultyIndex ~= targetDiff then
      self.isInitSwitch = true
      self.bind.selectId_taskDiff = targetDiff
      self._selectDifficultyIndex = targetDiff
      self.isInitSwitch = false
    else
      self.selectEntrustTaskId = self.curRoomLevelId
      for i = 1, #self.bind.list_trainTask do
        self.bind.list_trainTask:change(i, {
          selectEntrustTaskId = self.curRoomLevelId
        })
      end
      self:refreshSelectLevelDetails()
    end
  end
end

function this:refreshSelectLevelDetails(bChangeTab, bChangeLevel)
  local _moduleEntrustLevelDetails = self.modules.moduleEntrustLevelDetails
  if not self.selectEntrustTaskId then
    _moduleEntrustLevelDetails:setShow(false)
    C_MJLog.LogDebug("测试数据 刷新右边页签为空", C_ELogModule.Home)
    return
  end
  
  local function callback(levelId, isSwitch)
    self.curRoomLevelId = levelId
    for i = 1, #self.bind.list_trainTask do
      self.bind.list_trainTask:change(i, {
        curRoomLevelId = self.curRoomLevelId
      })
    end
    local tpl = _dungeonCrisisCrusadeTpl:getTplById(levelId)
    if isSwitch and tpl ~= nil then
      local targetDiff = _dungeonCrisisCrusadeTpl:getDifficulty(tpl)
      if self._selectDifficultyIndex ~= targetDiff then
        self.isInitSwitch = true
        self.bind.selectId_taskDiff = targetDiff
        self._selectDifficultyIndex = targetDiff
        self.isInitSwitch = false
      else
        self.selectEntrustTaskId = self.curRoomLevelId
        for i = 1, #self.bind.list_trainTask do
          self.bind.list_trainTask:change(i, {
            selectEntrustTaskId = self.curRoomLevelId
          })
        end
        self:refreshSelectLevelDetails()
      end
    end
  end
  
  if self.lastSelectEntrustTaskId ~= nil and self.selectEntrustTaskId ~= nil then
    C_MJLog.LogDebug("测试数据 刷新右边页签刷新 上次task id " .. self.lastSelectEntrustTaskId .. "当前task id" .. self.selectEntrustTaskId, C_ELogModule.Home)
  end
  if self.lastSelectEntrustTaskId ~= self.selectEntrustTaskId then
    self.lastSelectEntrustTaskId = self.selectEntrustTaskId
    C_MJLog.LogDebug("测试数据 最后刷新右边页签 id" .. self.selectEntrustTaskId, C_ELogModule.Home)
    _moduleEntrustLevelDetails:setShow(true)
    _moduleEntrustLevelDetails:initMultiCoopEntrustDetails(self.selectEntrustTaskId, bChangeTab, bChangeLevel, callback)
  end
end

function this:refreshTeamState()
  local isInATeam = C_MultiTeam.IsInMultiTeam()
  if isInATeam then
    local dungeonId = C_MultiTeam.GetDungeonId()
    local levelId = _dungeonCrisisCrusadeTpl:getLevelIdByDungeonId(dungeonId)
    self.curRoomLevelId = levelId
  else
    self.curRoomLevelId = 0
  end
  for i = 1, #self.bind.list_trainTask do
    self.bind.list_trainTask:change(i, {
      curRoomLevelId = self.curRoomLevelId
    })
  end
end

function this:refreshState()
  self:refreshTeamState()
  self.modules.moduleEntrustLevelDetails:getTeamState()
end

function this:setTimelineControl(timelineControl)
  self.timelineControl = timelineControl
end

function this:checkIsSpecial(levelId)
  local dungeonEntrustCfg = _dungeonCrisisCrusadeTpl:getTplById(levelId)
  return _dungeonCrisisCrusadeTpl:getEntrustType(dungeonEntrustCfg) == 2
end

function this:checkIsSpecialShow(levelId)
  if not self.specialEntrustList then
    return false
  end
  for i, v in ipairs(self.specialEntrustList) do
    if levelId == v then
      return true
    end
  end
  return false
end

function this:onSpecialMultiCoopEntrustRefresh(isActive, data)
  local is_Active = data:GetBool(0)
  local dungeonId = data:GetInt(1)
  local specialIevelId = _dungeonCrisisCrusadeTpl:getLevelIdByDungeonId(dungeonId)
  if is_Active then
    table.insert(self.specialEntrustList, specialIevelId)
    C_MJLog.LogDebug("测试数据 惊喜副本id " .. specialIevelId .. "添加惊喜副本", C_ELogModule.Home)
  else
    C_MJLog.LogDebug("测试数据 惊喜副本id " .. specialIevelId .. "取消惊喜副本", C_ELogModule.Home)
    for i = 1, #self.specialEntrustList do
      if self.specialEntrustList[i] == specialIevelId then
        table.remove(self.specialEntrustList, i)
        if self.selectEntrustTaskId == specialIevelId then
          local index = 1
          if #self.taskList ~= 0 then
            for i = 1, #self.taskList do
              if self.taskList[i].levelId ~= specialIevelId then
                index = i
                break
              end
            end
            self.selectEntrustTaskId = self.taskList[index].levelId
            C_MJLog.LogDebug("测试数据 取消惊喜副本之后 选择副本的id是 " .. self.selectEntrustTaskId, C_ELogModule.Home)
            for i = 1, #self.bind.list_trainTask do
              self.bind.list_trainTask:change(i, {
                selectEntrustTaskId = self.selectEntrustTaskId
              })
            end
            self:refreshSelectLevelDetails()
          end
        end
      end
    end
  end
  self:refreshTaskList()
end

function this:initSpecialEntrustList()
  local _specialEntrustList = C_MultiTeam.GetLimiteEntrust()
  self.specialEntrustList = {}
  for i = 0, _specialEntrustList.Count - 1 do
    local specialIevelId = _dungeonCrisisCrusadeTpl:getLevelIdByDungeonId(_specialEntrustList[i])
    if specialIevelId ~= 0 then
      table.insert(self.specialEntrustList, specialIevelId)
    end
  end
end

function this:activate(options)
  self.jumpTargetLevelId = options.jumpTargetLevel
  self:open()
  C_AudioManager.Play("Play_SFX_System_UI_EnTrust_Tab_Pencil")
end

function this:deActivate()
  self:hide()
end

return this
