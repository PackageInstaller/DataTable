local this = class("moduleGameActivityKiboBattle", G_UIModuleBase)
local _GameEventTpl = L_GameTpl:getGameEventsTpl()
local enumActivity = {
  None = 0,
  Lock = 1,
  Doing = 2,
  Done = 3
}

function this.bind()
  return {
    txt_date = "",
    txt_desc = "",
    reward_list = {
      moduleName = "modulePages/cellIconBag"
    },
    go_lock_btn = false,
    go_search_btn = false,
    reward = {
      moduleName = "pages/gameAct/moduleGameActivityReward"
    },
    img_bg_RB = true,
    img_bg_RB_Mobile = false,
    condition_list = {
      moduleName = "pages/gameAct/cellLockCondition"
    }
  }
end

function this.methods()
  return {
    onClick_help = function(self)
      if math.isEmpty(self.helpGroupId) then
        return
      end
      L_UI:open("pageCommonIntroduction", {
        groupId = self.helpGroupId
      })
    end,
    onClick_lock = function(self)
    end,
    onClick_search = function(self)
      local tpl = _GameEventTpl:getTplById(self.data.id)
      local taskConfId = _GameEventTpl:getGuideTaskId(tpl)
      local taskFinish = false
      if taskConfId ~= nil and taskConfId ~= 0 then
        taskFinish = AzurWorld.TaskMgr:IsFinishTask(taskConfId)
        if taskFinish then
          local eventTpl = _GameEventTpl:getTplById(self.data.id)
          local jumpTo = _GameEventTpl:getCommonJump(eventTpl)
          if jumpTo then
            L_JumpMgr:jumpTo(jumpTo)
          end
        else
          L_UI:open("pageTask", {taskId = taskConfId})
        end
      else
        errorf("活动" .. "配置中找不到指引任务 活动id: " .. self.data.id, 2)
      end
      local gameEventData = L_GameEventStore:getGameEventData(self.data.id)
      if gameEventData:IsConditionComplete() then
        AzurWorld.RedDotMgr:MarkNew(string.format(L_ReddotManager.DotDef.GameAct_Events_Kibo_Battle, L_GameEventStore.kiboBattleRedConfig[1]))
        AzurWorld.RedDotMgr:MarkDirty(string.format(L_ReddotManager.DotDef.GameAct_Events, self.data.id))
        if self.bindComponents ~= nil and L_CommonUtil.isValid(self.bindComponents.reddotnew) then
          self.bindComponents.reddotnew.gameObject:SetActive(false)
        end
        L_GameEventStore:changeRedDot()
      end
      if taskFinish then
        AzurWorld.RedDotMgr:MarkNew(string.format(L_ReddotManager.DotDef.GameAct_Events_Kibo_Battle, L_GameEventStore.kiboBattleRedConfig[2]))
        AzurWorld.RedDotMgr:MarkDirty(string.format(L_ReddotManager.DotDef.GameAct_Events, self.data.id))
        if self.bindComponents ~= nil and L_CommonUtil.isValid(self.bindComponents.reddotnew) then
          self.bindComponents.afterReddotNormal.gameObject:SetActive(false)
        end
        L_GameEventStore:changeRedDot()
      end
    end,
    onClick_back = function(self)
    end
  }
end

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {
    id = 0,
    startTime = 0,
    endTime = 0,
    desc = "",
    title = "",
    special_content = "",
    lock_content = "",
    lock_statue = enumActivity.None
  }
end

function this:open()
  L_GameEventStore:listenCallFunc(L_GameEventStore.event.gameEventReward, self.refreshByData, self)
  local isSuperWidthScene = C_ResolutionUtility.CheckSuperWidthScreen()
  if L_DeviceTpl:getIsPc() then
    self.bind.img_bg_RB = true
    self.bind.img_bg_RB_Mobile = false
    self.bind.img_bg_RB = not isSuperWidthScene
  else
    self.bind.img_bg_RB = false
    self.bind.img_bg_RB_Mobile = true
  end
end

function this:close()
  L_GameEventStore:unListenCallFunc(L_GameEventStore.event.gameEventReward, self.refreshByData)
end

function this:setActId(id)
  self.data.id = id
  self:initData(id)
end

function this:initData(id)
  local gameEventData = L_GameEventStore:getGameEventData(id)
  if not gameEventData then
    errorf("活动", "没有找到对应id的活动数据 id: " .. id)
    return
  end
  local tpl = _GameEventTpl:getTplById(self.data.id)
  self.helpGroupId = _GameEventTpl:getHelp(tpl)
  self:refreshView()
  self:refreshLockBtn(not gameEventData:IsConditionComplete())
  self:refreshLockCondition(id)
  self.modules.reward:initRewardData(self.data.id)
  self.endTime = C_CommonTimerMgr.GetEndTime(_GameEventTpl:getTimeLimit(tpl))
  self:refreshTime(L_TimeUtil.getLeftTimeFormatString(self.endTime))
  self.timer = L_GameTimer.repeated(1, self.repeatShowTime, self)
  local taskId = _GameEventTpl:getGuideTaskId(tpl)
  local taskFinish = false
  if taskId ~= nil and taskId ~= 0 then
    taskFinish = AzurWorld.TaskMgr:IsFinishTask(taskId)
  end
  local data = L_GameTpl:getGameEventsKiboDuelTpl():getData()
  local allPass = true
  for i, v in pairs(data) do
    if v.groupId == self.data.id and not L_PetDuelStore:getIsSuccess(v.kiboDuelId) then
      allPass = false
      break
    end
  end
  self:refreshRedDot(gameEventData:IsConditionComplete(), taskFinish, allPass)
end

function this:refreshView()
  local tpl = _GameEventTpl:getTplById(self.data.id)
  local desc = _GameEventTpl:getDesc(tpl)
  self:refreshDesc(desc)
  local rewards = _GameEventTpl:getRewardShow(tpl)
  local rewardsData = L_DataUtil.parseRewardConfig(rewards)
  self:refreshRewardList(rewardsData)
end

function this:sortRewardList(rewardsData)
  local result = {}
  if 1 < #rewardsData then
    for i, v in pairs(rewardsData) do
      local item = L_ItemTplManager:getItemConfig(v.itemType, v.itemId)
      table.insert(result, {
        itemType = v.itemType,
        itemId = v.itemId,
        itemNum = v.itemNum,
        quality = item.quality or 0
      })
    end
    table.sort(result, function(a, b)
      if a.quality == b.quality then
        if a.itemType == b.itemType then
          return a.itemId < b.itemId
        else
          return a.itemType < b.itemType
        end
      else
        return a.quality > b.quality
      end
    end)
    return result
  else
    return rewardsData
  end
end

function this:repeatShowTime()
  local isChange, str = L_TimeUtil.tryGetLeftTimeFormatString(self.endTime, 1)
  if isChange then
    self:refreshTime(str)
  end
end

function this:refreshTime(time)
  self.bind.txt_date = time
end

function this:refreshDate()
  local tpl = _GameEventTpl:getTplById(self.data.id)
  local startTime = L_TimeUtil.getDisplayTimeCustom(C_CommonTimerMgr.GetStartTime(_GameEventTpl:getTimeLimit(tpl)), "!%m.%d")
  local endTime = L_TimeUtil.getDisplayTimeCustom(C_CommonTimerMgr.GetEndTime(_GameEventTpl:getTimeLimit(tpl)), "!%m.%d")
  local startMonth = startTime:sub(1, 2)
  local endMonth = endTime:sub(1, 2)
  local startDate = startTime:sub(4, 5)
  local endDate = endTime:sub(4, 5)
  local cleanStartMonth = startMonth:gsub("^0", "")
  local cleanEndMonth = endMonth:gsub("^0", "")
  self.bind.txt_date = cleanStartMonth .. "." .. startDate .. "-" .. cleanEndMonth .. "." .. endDate
end

function this:refreshLockBtn(isLock)
  self.bind.go_lock_btn = isLock
  self.bind.go_search_btn = not isLock
end

function this:refreshDesc(desc)
  self.bind.txt_desc = desc
end

function this:refreshRewardList(reward_list)
  if reward_list ~= nil then
    self.bind.reward_list:clear()
    self.bind.reward_list:insert_array(reward_list)
  end
end

function this:refreshRedDot(isCompleted, isTaskFinish, allPass)
  if self.bindComponents == nil or L_CommonUtil.isValid(self.bindComponents.reddotnew) == false then
    return
  end
  if isCompleted and not allPass and not AzurWorld.RedDotMgr:HaveNew(string.format(L_ReddotManager.DotDef.GameAct_Events_Kibo_Battle, L_GameEventStore.kiboBattleRedConfig[1])) then
    self.bindComponents.reddotnew.gameObject:SetActive(true)
  else
    self.bindComponents.reddotnew.gameObject:SetActive(false)
  end
  if isTaskFinish and not allPass and not AzurWorld.RedDotMgr:HaveNew(string.format(L_ReddotManager.DotDef.GameAct_Events_Kibo_Battle, L_GameEventStore.kiboBattleRedConfig[2])) then
    self.bindComponents.afterReddotNormal.gameObject:SetActive(true)
  else
    self.bindComponents.afterReddotNormal.gameObject:SetActive(false)
  end
end

function this:refreshLockCondition(id)
  local gameEventData = L_GameEventStore:getGameEventData(id)
  if gameEventData:IsConditionComplete() == false then
    local tpl = _GameEventTpl:getTplById(self.data.id)
    local conditions = _GameEventTpl:getCondition(tpl)
    self.bind.condition_list:clear()
    for i, v in ipairs(conditions) do
      if not L_ConditionManager:singleIsComplete(v) then
        local data = {}
        table.insert(data, {
          lockParam = {
            _GameEventTpl:getLockJump(tpl)[i]
          },
          txt_lockDesc = L_Lang:get(_GameEventTpl:getLockText(tpl)[i])
        })
        self.bind.condition_list:insert_array(data)
      end
    end
  end
end

function this:refreshByData()
  self.modules.reward:initRewardData(self.data.id)
end

return this
