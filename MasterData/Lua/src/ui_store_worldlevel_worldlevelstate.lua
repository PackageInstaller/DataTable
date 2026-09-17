local this = {}

function this:init()
  this.super.init(self)
  self.data = {
    serverLevelInfo = {},
    maxLevel = nil,
    freeTime = 0,
    needShowLevel = false
  }
end

function this:state()
  return {}
end

function this:getServerLevelInfo()
  return self.data.serverLevelInfo
end

function this:getNowLevel()
  return self.data.serverLevelInfo and self.data.serverLevelInfo.cur_level
end

function this:getMaxLevel()
  return self.data.maxLevel
end

function this:getFreeTime()
  return self.data.freeTime
end

function this:getNeedShowLevel()
  return self.data.needShowLevel
end

function this:getChangeTimeIsOver()
  local serverInfo = self:getServerLevelInfo()
  local setTime = serverInfo.set_time
  if math.isEmpty(setTime) then
    return true
  end
  local cdTime = tonumber(L_GameConstTpl:getData("WORLD_DIFFICULT_CD", L_Const.GameTplType.int)) * 60
  local nowTime = L_TimeUtil:getServerTime()
  local leftTime = nowTime - setTime
  if cdTime < leftTime then
    return true
  end
  return false
end

return this
