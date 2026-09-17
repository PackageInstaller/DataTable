local this = {}
local gameActTpl = L_GameTpl:getGameActTpl()

function this:init()
  this.super.init(self)
  self.data = {
    gameActList = {},
    signInDay = 0,
    signInStatus = 0,
    signInMonth = 0,
    dayChangedFlag = false
  }
end

function this:state()
  return {}
end

function this:getGameActList()
  return self.data.gameActList
end

function this:getSignInInfo()
  local data = {
    signInDay = self.data.signInDay,
    signInStatus = self.data.signInStatus,
    signInMonth = self.data.signInMonth
  }
  return data
end

function this:getGameActItem(id, isCreate)
  local entity = self.data.gameActList[id]
  if entity == nil and isCreate then
    entity = require(L_R.store .. "gameAct.data.gameActItem").new()
    local tpl = gameActTpl:getTplById(id)
    if tpl then
      entity.id = id
      entity.name = gameActTpl:getName(tpl)
      entity.describe = gameActTpl:getDesc(tpl)
      entity.type = gameActTpl:getType(tpl)
      entity.joinStart = gameActTpl:getJoinStart(tpl)
      entity.joinDuration = gameActTpl:getJoinDuration(tpl)
      entity.value = gameActTpl:getValue(tpl)
      entity.sort = gameActTpl:getSort(tpl)
      self.data.gameActList[id] = entity
    else
      return nil
    end
  end
  return entity
end

function this:getDayChangedFlag()
  return self.data.dayChangedFlag
end

return this
