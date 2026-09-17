local this = class("pageGameActivityReward", G_UIPageBase)
local _GameEventRewardGroupTpl = L_GameTpl:getGameEventsRewardGroupTpl()

function this.bind()
  return {
    selectId = 0,
    reward_item_list = {
      moduleName = "pages/gameAct/cellActivityRewardItem"
    },
    reward_item_listMobile = {
      moduleName = "pages/gameAct/cellActivityRewardItem"
    },
    active_rewardPc = false,
    active_rewardMobile = false,
    module_tabList = {
      moduleName = "pages/common/modules/moduleCommonTab"
    },
    bg_level = true,
    bg_star = false,
    bg_level_left = true,
    bg_star_left = false
  }
end

function this.methods()
  return {}
end

function this:close(options)
  L_GameEventStore:unListenCallFunc(L_GameEventStore.event.gameEventReward, self.refreshByData)
  L_GameEventStore:unListenCallFunc(L_GameEventStore.event.gameEventEnd, self.endActivity)
end

function this:open(options)
  self.isPc = L_DeviceTpl:getIsPc()
  self.bind.active_rewardPc = self.isPc
  self.bind.active_rewardMobile = not self.isPc
  L_GameEventStore:listenCallFunc(L_GameEventStore.event.gameEventEnd, self.endActivity, self)
  L_GameEventStore:listenCallFunc(L_GameEventStore.event.gameEventReward, self.refreshByData, self)
  self.activityId = options.id
  self.reward_state_list = L_GameEventStore:getGameEventData(self.activityId):getRewardStateList()
  self:initUIData()
  if self.tab_list ~= nil and #self.tab_list > 0 then
    self:refreshRewardItemList(self.tab_list[1])
  end
  self:initTopTab()
end

function this:refreshTabList()
  local tab_tmp_list = {}
  for k, v in pairs(self.tab_list) do
    local tab_item = {
      id = v,
      activityId = self.activityId,
      action = function(group_id)
        self:refreshRewardItemList(group_id)
      end
    }
    table.insert(tab_tmp_list, tab_item)
  end
  self:refreshTab(tab_tmp_list)
end

function this:initTopTab()
  local tab_tmp_list = {}
  for k, v in pairs(self.tab_list) do
    local tpl = _GameEventRewardGroupTpl:getTplById(v)
    local name = _GameEventRewardGroupTpl:getName(tpl)
    local item_tmp_list = self.tab_to_item_map[v]
    local isShow = false
    for k1, v1 in pairs(item_tmp_list) do
      if v1.reward_state == L_Const.ActivityRewardState.ARS_FINISH then
        isShow = true
        break
      end
    end
    local tab_item = {
      id = v,
      name = name,
      isNew = isShow
    }
    table.insert(tab_tmp_list, tab_item)
  end
  
  local function callback(tabId)
    self:refreshRewardItemList(tabId)
  end
  
  self.modules.module_tabList:initData(tab_tmp_list, callback, 1)
end

function this:refreshRewardItemList(reward_group_id)
  self.selectId = reward_group_id
  self.bind.selectId = reward_group_id
  local item_tmp_list = self.tab_to_item_map[reward_group_id]
  if item_tmp_list ~= nil then
    local item_list = self:sortRewardItemList(item_tmp_list)
    self:refreshRewardItem(item_list)
  end
  if reward_group_id == self.tab_list[1] then
    self.bind.bg_star = true
    self.bind.bg_star_left = true
    self.bind.bg_level = false
    self.bind.bg_level_left = false
  else
    self.bind.bg_level = true
    self.bind.bg_level_left = true
    self.bind.bg_star = false
    self.bind.bg_star_left = false
  end
end

function this:sortRewardItemList(item_list)
  local priority = {
    [1] = 1,
    [0] = 2,
    [2] = 3
  }
  table.sort(item_list, function(a, b)
    if priority[a.reward_state] ~= priority[b.reward_state] then
      return priority[a.reward_state] < priority[b.reward_state]
    end
    return a.reward_id < b.reward_id
  end)
  return item_list
end

function this:initUIData()
  self.tab_list = {}
  self.tab_to_item_map = {}
  if self.reward_state_list ~= nil then
    for k, v in pairs(self.reward_state_list) do
      if not table.find(self.tab_list, function(m)
        return m == v.reward_show_type
      end) then
        table.insert(self.tab_list, v.reward_show_type)
      end
    end
    table.sort(self.tab_list, function(a, b)
      return a < b
    end)
    for k, v in pairs(self.reward_state_list) do
      if not self.tab_to_item_map[v.reward_show_type] then
        self.tab_to_item_map[v.reward_show_type] = {}
      end
      table.insert(self.tab_to_item_map[v.reward_show_type], v)
    end
  end
end

function this:refreshByData()
  self.reward_state_list = L_GameEventStore:getGameEventData(self.activityId):getRewardStateList()
  self:initUIData()
  self:refreshRewardItemList(self.selectId)
  self:refreshRedDot()
end

function this:refreshTab(tab_list)
  if tab_list ~= nil then
    self.bind.tab_list:clear()
    self.bind.tab_list:insert_array(tab_list)
  else
    errorf("活动奖励" .. "奖励页签数据为空", 2)
  end
end

function this:refreshRewardItem(item_list)
  if item_list ~= nil then
    if self.isPc then
      self.bind.reward_item_list:clear()
      self.bind.reward_item_list:insert_array(item_list)
    else
      self.bind.reward_item_listMobile:clear()
      self.bind.reward_item_listMobile:insert_array(item_list)
    end
  else
    errorf("活动奖励" .. "奖励列表数据为空", 2)
  end
end

function this:endActivity(eventID)
  if eventID == self.activityId then
    L_UI:close("pageGameActivityReward")
  end
end

function this:refreshRedDot()
  for k, v in pairs(self.tab_list) do
    local item_tmp_list = self.tab_to_item_map[v]
    local isShow = false
    for k1, v1 in pairs(item_tmp_list) do
      if v1.reward_state == L_Const.ActivityRewardState.ARS_FINISH then
        isShow = true
        break
      end
    end
    self.modules.module_tabList:refreshReddot(v, isShow)
  end
end

return this
