local this = class("moduleEntrustTrainTask", G_UIModuleBase)
local _trainTaskTpl = L_GameTpl:getTrainTaskTpl()

function this.bind()
  return {
    selectId_trainTaskType = L_Const.trainTaskType.dungeon,
    list_trainTaskType = {
      moduleName = "pages/entrustTask/cellEntrustTaskFilterTabItem"
    },
    list_trainTask = {
      moduleName = "pages/entrustTask/trainTask/cellTrainTask"
    },
    moduleDetail = {
      moduleName = "pages/entrustTask/moduleEntrustLevelDetails"
    }
  }
end

function this.methods()
  return {
    onSelectTabId_trainTaskType = function(self, type)
      if type == self._selectType then
        return
      end
      self._selectType = type
      C_AudioManager.Play("Play_SFX_System_UI_EnTrust_Tab_Pencil")
      Timer.once(0.133, function()
        if not self.isBind then
          return
        end
        self:refreshTrainTaskType()
        self.lastSelectType = self._selectType
      end)
    end,
    list_trainTask = {
      onClick_select = function(self, bind)
        if self._selectTaskId == bind.taskId then
          return
        end
        local tpl = _trainTaskTpl:getTplById(bind.taskId)
        local conditionGroup = _trainTaskTpl:getUnlockCondition(tpl)
        if not L_ConditionManager:isComplete(conditionGroup) then
          return
        end
        self._selectTaskId = bind.taskId
        Timer.once(0.066, function()
          if not self.isBind then
            return
          end
          self:setTaskListSelect()
          self:refreshInfo()
          self.lastSelectType = self._selectType
        end)
      end
    }
  }
end

function this:open()
  self._selectType = L_Const.trainTaskType.dungeon
  self:initModule()
end

function this:setSelectType(selectType)
  if selectType then
    self._selectType = selectType
    Timer.once(0.133, function()
      if not self.isBind then
        return
      end
      self:refreshTrainTaskType()
    end)
  end
end

function this:close()
end

function this:initModule()
  self:refreshTrainTaskTypeList()
  self:refreshTrainTaskType()
end

function this:refreshTrainTaskTypeList()
  local dataList = {
    L_Const.trainTaskType.dungeon,
    L_Const.trainTaskType.hero,
    L_Const.trainTaskType.kiBoDuel
  }
  local temp = {}
  for i, v in pairs(dataList) do
    table.insert(temp, {type = v})
  end
  self.bind.list_trainTaskType:freshAll(temp)
end

function this:refreshTrainTaskType()
  self.bind.selectId_trainTaskType = self._selectType
  self._selectTaskId = nil
  self:refreshTaskList()
  self:refreshInfo()
end

function this:refreshTaskList()
  local data = _trainTaskTpl:getTplListByTrainTaskType(self._selectType)
  local isMale = L_PlayerStore:getSex() == L_Const.sexType.male
  local temp = {}
  for i, v in pairs(data) do
    local tempTaskId = _trainTaskTpl:getTaskid(v)
    if (tempTaskId ~= 16 or not isMale) and (tempTaskId ~= 31 or isMale) then
      table.insert(temp, {
        taskId = tempTaskId,
        sortId = _trainTaskTpl:getSortId(v)
      })
    end
  end
  table.sort(temp, function(a, b)
    local aComplete = L_EntrustStore:getIsTrainTaskCompleted(a.taskId)
    local bComplete = L_EntrustStore:getIsTrainTaskCompleted(b.taskId)
    if not aComplete and bComplete then
      return false
    end
    if aComplete and not bComplete then
      return true
    end
    return a.sortId < b.sortId
  end)
  self.bind.list_trainTask:clear()
  if 0 < #temp then
    self._selectTaskId = self._selectTaskId or temp[1].taskId
    self.bind.list_trainTask:insert_array(temp)
    self:setTaskListSelect()
    self:refreshTaskListLockHeight()
    self.bindComponents.anim_taskList:Stop()
    self.bindComponents.anim_taskList:Rewind()
    self.bindComponents.anim_taskList:Play("anim_entrust_challenge_list_in")
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
    local taskId = cell.bind.taskId
    local tpl_task = _trainTaskTpl:getTplById(taskId)
    local lock = not L_ConditionManager:isComplete(_trainTaskTpl:getUnlockCondition(tpl_task))
    if lock then
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

function this:refreshInfo()
  if math.isEmpty(self._selectTaskId) then
    return
  end
  local moduleEntrustLevelDetails = self.modules.moduleDetail
  moduleEntrustLevelDetails:initTrainTaskDetails(self._selectType, self._selectTaskId, self.lastSelectType == self._selectType)
end

function this:activate()
  self:open()
  self:openModules()
  self:show()
  self:showModules()
  C_AudioManager.Play("Play_SFX_System_UI_EnTrust_Tab_Pencil")
  self.lastSelectType = self._selectType
end

function this:deActivate()
  self:hide()
  self:hideModules()
  self:close()
  self:closeModules()
end

return this
