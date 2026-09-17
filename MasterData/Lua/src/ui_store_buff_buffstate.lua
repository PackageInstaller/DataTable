local this = {}

function this:init()
  this.super.init(self)
  self.data = {
    fightList = {},
    worldList = {},
    fastList = {},
    changeList = {},
    removeList = {}
  }
  self.dataPool = {}
end

function this:getFightList()
  return self.data.fightList
end

function this:getFightListNum()
  local index = 0
  for _, _ in pairs(self:getFightList()) do
    index = index + 1
  end
  return index
end

function this:getWorldBuffList()
  return self.data.worldList
end

function this:getFastBuffList()
  return self.data.fastList
end

function this:getChangeList()
  return self.data.changeList
end

function this:removeWorldBuff(buffId)
  if buffId == nil then
    return false
  end
  local isDelete = false
  table.clear(self.data.removeList)
  for i, v in pairs(self.data.worldList) do
    if v.buff_id == buffId then
      local data = self.data.worldList[i]
      self:setPoolInfoData(data)
      table.insert(self.data.removeList, i)
      isDelete = true
    end
  end
  if #self.data.removeList > 0 then
    for _, v in ipairs(self.data.removeList) do
      self.data.worldList[v] = nil
    end
  end
  return isDelete
end

function this:removeFastBuff(buffId)
  if buffId == nil then
    return false
  end
  if self.data.fastList[buffId] then
    self.data.fastList[buffId] = nil
    return true
  end
  return false
end

function this:clearFastExcuteList()
  if self.data.fastList == nil then
    return
  end
  for _, v in pairs(self.data.fastList) do
    self:setPoolInfoData(v)
  end
  table.clear(self.data.fastList)
end

function this:clearChangeBuffList()
  if self.data.changeList == nil then
    return
  end
  for _, v in pairs(self.data.changeList) do
    if v.state == L_Const.buffStateType.removeBuff then
      self:setPoolInfoData(v)
    end
  end
  table.clear(self.data.changeList)
end

function this:getPoolInfoData(isCreate)
  if #self.dataPool <= 0 or isCreate then
    local data = require(L_R.store .. "buff.data.worldBuffData").new()
    return data
  end
  local buffData = self.dataPool[1]
  buffData:clear()
  table.remove(self.dataPool, 1)
  return buffData
end

function this:setPoolInfoData(buffData)
  if buffData == nil then
    return
  end
  table.insert(self.dataPool, buffData)
end

function this:worldBuffRefresh(reduceTime)
  local needRef = false
  table.clear(self.data.removeList)
  for i, v in pairs(self.data.worldList) do
    if v.last_time == nil then
      table.insert(self.data.removeList, i)
    end
    v.last_time = v.last_time - reduceTime
    if v.last_time <= 0 then
      table.insert(self.data.removeList, i)
    end
    needRef = true
  end
  if needRef then
    local removeCount = #self.data.removeList
    if 0 < removeCount then
      for _, v in ipairs(self.data.removeList) do
        local data = self.data.worldList[v]
        self:setPoolInfoData(data)
        self.data.worldList[v] = nil
      end
      self:call(self.event.worldBuffRefresh)
    end
    self:call(self.event.buffTimeRefresh, removeCount)
  end
end

return this
