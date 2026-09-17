local this = class("moduleActivityScenario", G_UIModuleBase)
local _GameEventTpl = L_GameTpl:getGameEventsTpl()

function this.bind()
  return {
    activeLock = false,
    activeSuperWidth = false,
    textDesc = "",
    text_left_time = "",
    condition_list = {
      moduleName = "pages/gameAct/cellLockCondition"
    },
    listReward = {
      moduleName = "modulePages/cellIconBag"
    },
    active_modulePTShop = false,
    modulePTShop = {
      moduleName = "pages/gameAct/moduleActivityPTShopButton"
    }
  }
end

function this.methods()
  return {
    OnClick_Go = function(self)
      if AzurWorld.TaskMgr:IsFinishTask(self.taskId) then
        self:clearPreTaskReddot()
        L_UI:open("pageActivityScenarioMain", {
          actId = self.actId
        })
      else
        local _taskTpl = L_GameTpl:getTaskTpl()
        local tpl = _taskTpl:getTplById(self.taskId)
        local title = tpl and _taskTpl:getName(tpl) or ""
        L_GameUtil.showCommonTip({
          txtContent = L_WordsTpl:getValue("gameevents_cul_task_unlock_tips", {
            [0] = title
          }),
          confirmCallback = function()
            L_Net:sendMessage(MsgGenCode.CSProtoCampaignCreate, {group_id = 905, difficulty = 1})
          end
        })
      end
    end,
    OnClick_help = function(self)
      if math.isEmpty(self.helpGroupId) then
        return
      end
      L_UI:open("pageCommonIntroduction", {
        groupId = self.helpGroupId
      })
    end,
    OnClick_reward = function(self)
      L_UI:open("PageScenarioSoulEssenceReward")
    end,
    OnClick_task = function(self)
      L_UI:open("pageScenarioQuestReward")
    end
  }
end

function this:setActId(id)
  self.actId = id
  self:init()
end

function this:init()
  self.tpl = _GameEventTpl:getTplById(self.actId)
  self.data = L_GameEventStore:getGameEventData(self.actId)
  self.bind.textMissionName = L_Lang:get(_GameEventTpl:getName(self.tpl))
  self.bind.textDesc = L_Lang:get(_GameEventTpl:getDesc(self.tpl))
  self:setupConditions()
  self:setupRewards()
  self.helpGroupId = _GameEventTpl:getHelp(self.tpl)
  self.taskId = _GameEventTpl:getGuideTaskId(self.tpl)
  self:refreshGoBtnReddot()
  self.bind.activeSuperWidth = C_AppConfigManager.IsPcPlatformForUI and C_ResolutionUtility.CheckSuperWidthScreen()
end

function this:setPtShopButton(ptShopId, ptCurrencyId, ptCurrencyMax)
  self.bind.active_modulePTShop = true
  self.modules.modulePTShop:setActData(self.actId, ptShopId, ptCurrencyId, ptCurrencyMax)
end

function this:setPtShopButtonTime(startTime, endTime)
  self.modules.modulePTShop:setPtShopTime(startTime, endTime)
end

function this:setupConditions()
  local conditions = _GameEventTpl:getCondition(self.tpl)
  local lockState = false
  self.bind.condition_list:clear()
  if conditions then
    for i, v in ipairs(conditions) do
      if not L_ConditionManager:singleIsComplete(v) then
        lockState = true
        local data = {}
        table.insert(data, {
          lockParam = {
            _GameEventTpl:getLockJump(self.tpl)[i]
          },
          txt_lockDesc = L_Lang:get(_GameEventTpl:getLockText(self.tpl)[i])
        })
        self.bind.condition_list:insert_array(data)
      end
    end
  end
  self.bind.activeLock = lockState
end

function this:setupRewards()
  local rewards = _GameEventTpl:getRewardShow(self.tpl)
  if rewards then
    local rewardsData = L_DataUtil.parseRewardConfig(rewards)
    local sortReward = self:sortRewardList(rewardsData)
    self.bind.listReward:clear()
    self.bind.listReward:insert_array(sortReward)
  end
end

function this:sortRewardList(rewardsData)
  local result = {}
  if 1 < #rewardsData then
    for i, v in pairs(rewardsData) do
      local item = L_ItemTplManager:getItemConfig(v.itemType, v.itemId)
      table.insert(result, {
        itemType = v.itemType,
        itemId = v.itemId,
        itemNumTxt = tostring(v.itemNum),
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

function this:preOpen(options)
  self.isUnlock = false
end

function this:close()
  self:unregisterGoBtnReddot()
end

function this:refreshGoBtnReddot()
  if not self.isBind then
    return
  end
  if not self.bindComponents or not self.bindComponents.transGoBtn then
    return
  end
  local reddotKey = string.format(L_ReddotManager.DotDef.GameAct_Scenario_PreTask, self.actId)
  L_ReddotManager:registerDynamicReddot(self.bindComponents.transGoBtn, reddotKey)
  L_ReddotManager:setDirty(L_ReddotManager.DotDef.GameAct_Scenario_PreTask, true)
end

function this:unregisterGoBtnReddot()
  if not self.actId then
    return
  end
  if not self.bindComponents or not self.bindComponents.transGoBtn then
    return
  end
  local reddotKey = string.format(L_ReddotManager.DotDef.GameAct_Scenario_PreTask, self.actId)
  L_ReddotManager:unregisterDynamicReddot(self.bindComponents.transGoBtn, reddotKey)
end

function this:clearPreTaskReddot()
  local gameEventData = L_GameEventStore:getGameEventData(self.actId)
  if gameEventData then
    local gameEvent = gameEventData:getGameEvent()
    if gameEvent and gameEvent.clearScenarioPreTaskReddot then
      gameEvent:clearScenarioPreTaskReddot()
    end
  end
  self:refreshGoBtnReddot()
end

function this:setPTShopReddotState(isShowReddot)
  self.modules.modulePTShop:setReddotState(isShowReddot)
end

return this
