local this = {}
local _iTaskTpl = L_GameTpl:getIconographyTaskTpl()
local isInit = false

function this:req_CSProtoGetCatalogInfo(callback)
end

function this:rsp_syncPetCatalog(data)
  for i, v in pairs(data) do
    if not self.data.setHasInitSync then
      self.data.petCatalogMap[v] = 3
    elseif self.data.petCatalogMap[v] and self.data.petCatalogMap[v] == 1 then
      self.data.petCatalogMap[v] = 3
    elseif not self.data.petCatalogMap[v] then
      self.data.petCatalogMap[v] = 1
    end
  end
  self:call(self.event.refreshCatalog)
end

function this:rsp_syncPetCatalogTask(data)
  local handbook = data.infos
  if handbook then
    self:registerRedDot()
    for i, v in pairs(handbook) do
      local petId = v.pet_id
      local playModule = L_WorldManager:getCurModule()
      local needFlyMsg = playModule == L_Const.worldModule.main and self.data.setCatalogHasInitSync
      local oldLv, oldExp, oldTaskCnt
      local cntChange = {}
      local isNew = true
      if self.data.petCatalog[petId] then
        oldTaskCnt = {}
        for _, tData in pairs(self.data.petCatalog[petId].tasks) do
          oldTaskCnt[tData.task_id] = tData.count
        end
        oldLv = self.data.petCatalog[petId].lv
        oldExp = self.data.petCatalog[petId].exp
        table.clear(self.data.petCatalog[petId])
        isNew = false
      elseif self.data.setCatalogHasInitSync then
        oldLv = 1
        oldExp = 0
        local key = "petCatalogNew" .. tostring(petId)
        L_CommonUtil.setLocalValue(key, true)
        self.data.cachedPetCatalogNew[key] = true
      end
      local tasks = {}
      for _, t in ipairs(v.tasks or {}) do
        table.insert(tasks, {
          task_id = t.task_id,
          count = t.count,
          complete = t.complete
        })
        if isNew then
          table.insert(cntChange, {
            task_id = t.task_id,
            new = t.count,
            old = 0
          })
        elseif oldTaskCnt and oldTaskCnt[t.task_id] and t.count ~= oldTaskCnt[t.task_id] then
          table.insert(cntChange, {
            task_id = t.task_id,
            new = t.count,
            old = oldTaskCnt[t.task_id]
          })
        elseif oldTaskCnt and not oldTaskCnt[t.task_id] then
          local oldTaskId
          for tid, tCnt in pairs(oldTaskCnt) do
            local tempId = tid
            while _iTaskTpl:getTplById(tempId).nextTaskId ~= 0 do
              tempId = _iTaskTpl:getTplById(tempId).nextTaskId
              if tempId == t.task_id then
                oldTaskId = tid
                break
              end
            end
          end
          local taskTpl = _iTaskTpl:getTplById(oldTaskId)
          local target = taskTpl.taskcondition[#taskTpl.taskcondition] or 1
          table.insert(cntChange, {
            task_id = oldTaskId,
            new = target,
            old = oldTaskCnt[oldTaskId]
          })
        end
      end
      local petCatalogInfo = {}
      petCatalogInfo.lv = v.lv
      petCatalogInfo.exp = v.exp
      petCatalogInfo.colors = v.colors
      petCatalogInfo.tasks = tasks
      petCatalogInfo.rewardedLv = v.rewarded_lv
      petCatalogInfo.starColors = v.colorfuls
      petCatalogInfo.reportRewardTimes = v.report_reward_times
      self.data.petCatalog[petId] = petCatalogInfo
      self:refreshRewardInfo(petId, v.lv or 0, v.rewarded_lv or 0)
      self:calcPetAttr(petId)
      if 0 < #cntChange and oldLv and oldLv < v.lv then
        L_CommonUtil.setLocalValue("petCatalogTask" .. tostring(petId), true)
      end
      if needFlyMsg and 0 < #cntChange then
        local taskId = cntChange[1].task_id
        local isGetPet = self:_isGetPet(taskId)
        local taskTpl = L_GameTpl:getIconographyTaskTpl():getTplById(taskId)
        local target = taskTpl.taskcondition[#taskTpl.taskcondition] or 1
        local oldTaskTxt = L_Config:provider(taskTpl.taskname) .. " [" .. cntChange[1].old .. "/" .. tostring(target) .. "]"
        local newTaskTxt = L_Config:provider(taskTpl.taskname) .. " [" .. cntChange[1].new .. "/" .. tostring(target) .. "]"
        if oldLv and oldLv < v.lv then
          self:_tryShowPetCatalogTip({
            petId = petId,
            isTaskChange = true,
            isExpChange = true,
            isLvChange = true,
            oldTaskTxt = oldTaskTxt,
            newTaskTxt = newTaskTxt,
            oldExp = oldExp,
            newExp = v.exp,
            oldLv = oldLv,
            catalogLv = v.lv,
            taskId = taskId,
            isGetPet = isGetPet
          })
        elseif oldExp and oldExp < v.exp then
          self:_tryShowPetCatalogTip({
            petId = petId,
            isTaskChange = true,
            isExpChange = true,
            oldTaskTxt = oldTaskTxt,
            newTaskTxt = newTaskTxt,
            oldExp = oldExp,
            newExp = v.exp,
            oldLv = oldLv,
            taskId = taskId,
            isGetPet = isGetPet
          })
        else
          self:_tryShowPetCatalogTip({
            petId = petId,
            isTaskChange = true,
            oldTaskTxt = oldTaskTxt,
            newTaskTxt = newTaskTxt,
            taskId = taskId,
            isGetPet = isGetPet,
            oldExp = oldExp,
            oldLv = oldLv
          })
        end
      end
    end
  end
end

function this:registerRedDot()
  if isInit then
    return
  end
  isInit = true
  AzurWorld.RedDotMgr:RegistRedDot(L_ReddotManager.DotDef.PetCatalog, nil, function()
    return self:checkCanGetReward()
  end, false, L_SystemConst.enum.petCatalog)
end

function this:refreshRewardInfo(petId, lv, rewardedLv)
  if rewardedLv < lv and 0 < rewardedLv then
    local targetInfo = self.data.waitGetRewardInfo[petId] or {petId = petId}
    targetInfo.petId = petId
    targetInfo.lv = lv
    targetInfo.rewardedLv = rewardedLv
    self.data.waitGetRewardInfo[petId] = targetInfo
    self.data.canGetReward = true
    AzurWorld.RedDotMgr:MarkDirty(L_ReddotManager.DotDef.PetCatalog)
    L_ReddotManager:setDirty(L_ReddotManager.DotDef.PetCatalog, true)
  end
end

function this:_isGetPet(taskId)
  return _iTaskTpl:getTplById(taskId).taskcondition[1] == 13050
end

function this:_tryShowPetCatalogTip(tipInfo)
  C_MJLog.LogDebug("[@]图鉴左插入口", C_ELogModule.Lua)
  if not tipInfo.isGetPet then
    C_MJLog.LogDebug("[@]图鉴左插直接播", C_ELogModule.Lua)
    AzurWorld.FlymsgManager:Enqueue(L_ShowQueueConst.flyMsgType.petCatalog, tipInfo)
    return
  end
  C_MJLog.LogDebug("[@]图鉴左插排队，readyCnt=true", C_ELogModule.Lua)
  self.data.readyTipInfo = tipInfo
  self.data.catalogFlyReadyCnt = true
end

function this:_triggerCommonGetPet(pet, isNew)
  C_MJLog.LogDebug("[@]星结左插", C_ELogModule.Lua)
  if not self.data.catalogFlyReadyCnt then
    C_MJLog.LogDebug("[@]没有图鉴左插排队", C_ELogModule.Lua)
    if not isNew then
      C_MJLog.LogDebug("[@]非第一次，播星结左插", C_ELogModule.Lua)
      AzurWorld.FlymsgManager:Enqueue(L_ShowQueueConst.flyMsgType.getPet, pet)
    end
  else
    C_MJLog.LogDebug("[@]图鉴左插排队的现在播", C_ELogModule.Lua)
    local readyId = self.data.readyTipInfo.petId
    if readyId == pet.id then
      self.data.readyTipInfo.pet = pet
      C_MJLog.LogInfo("ShowPetCatalogTip isGetPet", C_ELogModule.Lua)
      AzurWorld.FlymsgManager:Enqueue(L_ShowQueueConst.flyMsgType.petCatalog, self.data.readyTipInfo)
    else
      C_MJLog.LogInfo("PetGuid not match. readyId = " .. tostring(readyId) .. "  getId = " .. tostring(pet.id), C_ELogModule.Lua)
      self.data.readyTipInfo = nil
    end
    self.data.catalogFlyReadyCnt = false
  end
end

return this
