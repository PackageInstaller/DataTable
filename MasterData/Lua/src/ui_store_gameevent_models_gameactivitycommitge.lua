local this = class("gameActivityCommitGE", L_GameEventStore.baseGameEventCls)
local _GameEventTpl = L_GameTpl:getGameEventsTpl()
local SubmitEventsTpl = L_GameTpl:getGameeventssubitemTpl()

function this:initData()
  self.data.order = 1
  self.data.finish = false
  self.data.showRed = false
  self.data.data_list = {}
end

function this:populate(protoData)
  local data = protoData.submit_item_task
  self.data.order = data.cur_order or self.data.order
  self.data.finish = data.finish or self.data.finish
  for k, data in pairs(data.data_list or L_Const.emptyTable) do
    self.data.data_list[data.id] = {
      id = data.id,
      state = data.state
    }
  end
  
  function self.data.SetRedState(show)
    self.data.showRed = show
  end
end

function this:getData()
  return self.data
end

function this:isActivityCompleted()
  local res = true
  if self.data.data_list == nil or self:getLength(self.data.data_list) == 0 then
    return false
  end
  for k, v in pairs(self.data.data_list) do
    if not self:checkIsCompletById(v.id) then
      res = false
      break
    else
      res = true
    end
  end
  return res
end

function this:getLength(tbl)
  local count = 0
  for _ in pairs(tbl) do
    count = count + 1
  end
  return count
end

function this:SetRedState(show)
  self.data.showRed = show
end

function this:getRedState()
  return self.data.showRed
end

function this:checkIsCompletById(id)
  if self.data.data_list[id] then
    return self.data.data_list[id].state == "CS_FINISH" or self.data.data_list[id].state == L_Const.CommonState.CS_FINISH
  end
  return false
end

function this:getIsActiveById(id)
  if self.data.data_list[id] then
    return self.data.data_list[id].state == "CS_ACCEPT" or self.data.data_list[id].state == L_Const.CommonState.CS_ACCEPT
  end
  return false
end

function this:getIsNoneById(id)
  if self.data.data_list[id] then
    return false
  end
  return true
end

function this:checkCanSubmitById(id)
  if self.data.data_list[id] and (self.data.data_list[id].state == "CS_ACCEPT" or self.data.data_list[id].state == L_Const.CommonState.CS_ACCEPT) then
    local tpl = SubmitEventsTpl:getTplById(id)
    local reward = SubmitEventsTpl:getReward(tpl)
    if reward then
      local item = L_DataUtil.parseRewardConfig(reward)
      for k, v in pairs(item) do
        local needNum = v.itemNum
        local curNum = C_BagMgr:getItemNumByItemId(v.itemId)
        if curNum and needNum <= curNum then
          return true
        end
      end
    end
  end
  return false
end

return this
