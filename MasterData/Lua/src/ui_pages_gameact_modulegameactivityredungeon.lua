local this = class("moduleGameActivityRedungeon", G_UIModuleBase)
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
    },
    active_modulePTShop = false,
    modulePTShop = {
      moduleName = "pages/gameAct/moduleActivityPTShopButton"
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
    onClick_search = function(self)
      local tpl = _GameEventTpl:getTplById(self.data.id)
      local taskConfId = _GameEventTpl:getGuideTaskId(tpl)
      local taskFinish = false
      if taskConfId ~= nil and taskConfId ~= 0 then
        taskFinish = AzurWorld.TaskMgr:IsFinishTask(taskConfId)
        if taskFinish then
          L_UI:open("PageGameActRedungeonLevel")
        else
          L_UI:open("pageTask", {taskId = taskConfId})
        end
      else
        L_UI:open("PageGameActRedungeonLevel")
      end
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
  local isCondition = gameEventData:IsConditionComplete()
  self:refreshLockBtn(not isCondition)
  self:refreshLockCondition(id)
  self.modules.reward:initRewardData(self.data.id)
  self.endTime = C_CommonTimerMgr.GetEndTime(_GameEventTpl:getTimeLimit(tpl))
  self:refreshTime(L_TimeUtil.getLeftTimeFormatString(self.endTime))
  self.timer = L_GameTimer.repeated(1, self.repeatShowTime, self)
  self:refreshRedDot()
end

function this:setPtShopButton(ptShopId, ptCurrencyId, ptCurrencyMax)
  self.bind.active_modulePTShop = true
  self.modules.modulePTShop:setActData(self.data.id, ptShopId, ptCurrencyId, ptCurrencyMax)
end

function this:setPtShopButtonTime(startTime, endTime)
  self.modules.modulePTShop:setPtShopTime(startTime, endTime)
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

function this:refreshRedDot()
  if self.bindComponents == nil or L_CommonUtil.isValid(self.bindComponents.reddotnew) == false then
    return
  end
  local redDot = false
  if not self.isShowReddot then
    local gameEvent = L_GameEventStore:getGameEventData(self.data.id):getGameEvent()
    if gameEvent ~= nil then
      redDot = gameEvent:getRedState()
    end
  else
    redDot = self.isShowReddot
  end
  self.bindComponents.reddotnew.gameObject:SetActive(redDot)
end

function this:setRewardReddotState(isShowReddot, isRewardReddot)
  self.isShowReddot = isShowReddot
  self:refreshRedDot()
  self.modules.reward:setReddotState(isRewardReddot)
end

function this:setPTShopReddotState(isShowReddot)
  self.modules.modulePTShop:setReddotState(isShowReddot)
end

return this
