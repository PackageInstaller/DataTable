local this = class("moduleActivityEntrance", G_UIModuleBase)
local _entrustEventTpl = L_GameTpl:getGameEventsEntrustEnterTpl()

function this.bind()
  return {
    go_module = true,
    cell_list = {
      moduleName = "pages/gameAct/cellActivityEntrance"
    },
    active_cells = false
  }
end

function this.methods()
  return {}
end

function this:open()
  L_GameEventStore:listenCallFunc(L_GameEventStore.event.gameEventEnd, self.endActivity, self)
  self:initData()
  local dataList = self:createEntranceDataList()
  self:refreshModuleState(dataList)
  self:refreshEntranceListUI(dataList)
end

function this:close()
  L_GameEventStore:unListenCallFunc(L_GameEventStore.event.gameEventEnd, self.endActivity)
end

function this:initData()
  self.entrance_activityId_list = {}
  local events = _entrustEventTpl:getEventEntrusts()
  for k, v in pairs(events) do
    table.insert(self.entrance_activityId_list, _entrustEventTpl:getId(v))
  end
  self.redDotFucMap = {
    [20001] = this.kiboBattleActivityRedDot
  }
end

function this:createEntranceDataList()
  local dataList = {}
  if self.entrance_activityId_list ~= nil then
    for _, activityId in pairs(self.entrance_activityId_list) do
      if self:isActivityEntranceUnlock(activityId) then
        local data = self:createEntranceData(activityId)
        table.insert(dataList, data)
      end
    end
  end
  return dataList
end

function this:createEntranceData(activityId)
  local data = {
    activityId = activityId,
    redDotFuc = self.redDotFucMap[activityId] or function()
      return false
    end,
    onEnter = handler(self, self.onEntrustBtnClick)
  }
  printf("活动入口", "生成入口数据活动id " .. activityId)
  return data
end

function this:refreshModuleState(dataList)
  local dataList = self.entrance_activityId_list
  if dataList == nil or #dataList == 0 then
    self.bind.go_module = false
  else
    self.bind.go_module = true
  end
end

function this:refreshEntranceListUI(data)
  if data == nil or #data == 0 then
    self.bind.cell_list:clear()
    return
  end
  self.bind.cell_list:clear()
  self.bind.cell_list:insert_array(data)
end

function this:isActivityEntranceUnlock(activityId)
  if L_GameEventStore:getGameEventData(activityId) == nil then
    errorf("活动入口", "活动ID" .. activityId .. "不存在")
    return false
  end
  return L_GameEventStore:getGameEventData(activityId):isFinishGuideTask() and L_GameEventStore:getGameEventData(activityId):isShow()
end

function this:kiboBattleActivityRedDot()
  local kiboBattleActivityId = 20001
  local singleEventRedDot = false
  local data = L_GameEventStore:getGameEventData(kiboBattleActivityId)
  if not data then
    return false
  end
  local gameEvent = data:getGameEvent()
  if gameEvent ~= nil then
    singleEventRedDot = gameEvent:hasRewardNewData(kiboBattleActivityId)
  end
  local redState = this:kiboBattleActivityRedState(kiboBattleActivityId)
  return redState or singleEventRedDot
end

function this:kiboBattleActivityRedState(activityId)
  local duelTpl = L_GameTpl:getGameEventsKiboDuelTpl()
  local data = duelTpl:getData()
  local duelList = {}
  for _, item in pairs(data) do
    local tpl = duelTpl:getTplById(_)
    if duelTpl:getGroupId(tpl) == activityId then
      table.insert(duelList, item.id)
    end
  end
  for _, id in pairs(duelList) do
    if not L_ReddotManager:haveNew(L_ReddotManager.DotDef.GameAct_Events_Battle, id) then
      return true
    end
  end
  return false
end

function this:endActivity()
  self:initData()
  local dataList = self:createEntranceDataList()
  self:refreshModuleState(dataList)
  self:refreshEntranceListUI(dataList)
end

function this:setUIActive(isActive)
  self.bind.active_cells = isActive
end

function this:onEntrustBtnClick(pageName)
  if self.enterHandler then
    self.enterhandler(pageName)
  else
    L_UI:open(pageName)
  end
end

function this:setEnterHandler(enterHandler)
  self.enterHandler = enterHandler
end

return this
