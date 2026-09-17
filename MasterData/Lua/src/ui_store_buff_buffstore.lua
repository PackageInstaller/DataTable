local this = class("buffStore", G_BaseStore)
local _WorldBuffTpl = L_GameTpl:getWorldBuffTpl()
this.event = {
  buffRefresh = "buffRefresh"
}

function this:init()
  this.super.init(self)
  self.data = {
    worldBuffs = {}
  }
  self.isPauseBuffTime = false
  self.isBuffTimering = false
  self._lastServerTime = nil
end

function this:clear()
  this.super.clear(self)
  L_TimerManager:clearTimer(self)
end

function this:syncWorldBuffData(data)
  local petCatchBuffUpdate = false
  self:checkInitPetCatchFoodBuffInfo()
  for _, buff in ipairs(data.update_buffs or {}) do
    self.data.worldBuffs[buff.guid] = buff
    buff.remain_time = buff.last_time
    if buff.buff_id == self.cachePetCatchFoodBuffId then
      petCatchBuffUpdate = true
    end
  end
  for _, guid in ipairs(data.del_buffs or {}) do
    if self.data.worldBuffs[guid] ~= nil and self.data.worldBuffs[guid].buff_id == self.cachePetCatchFoodBuffId then
      petCatchBuffUpdate = true
    end
    self.data.worldBuffs[guid] = nil
  end
  self:call(this.event.buffRefresh)
  if petCatchBuffUpdate then
    L_PetStore:call(L_PetStore.event.refreshPetCatchFoodBuff, {})
  end
  if not table.isEmpty(self.data.worldBuffs) then
    self:restartBuffTimer()
  else
    L_TimerManager:stopTimer(self, "buffStore")
    self.isBuffTimering = false
    self._lastServerTime = nil
  end
end

function this:getBuffDatas()
  return self.data.worldBuffs
end

function this:getBuffData(buffId)
  if not buffId then
    return
  end
  for _, buff in pairs(self.data.worldBuffs) do
    if buff.buff_id == buffId and buff.guid > 0 then
      return buff
    end
  end
end

function this:pauseWorldBuff()
  self.isPauseBuffTime = true
  self.isBuffTimering = false
  L_TimerManager:stopTimer(self, "buffStore")
  self:onUpdateBuffTimer()
  self._lastServerTime = nil
end

function this:onUpdateBuffTimer()
  if not self._lastServerTime then
    return
  end
  if L_TimeUtil.getServerTime() > self._lastServerTime then
    local deltaTime = L_TimeUtil.getServerTime() - self._lastServerTime
    self._lastServerTime = L_TimeUtil.getServerTime()
    for _, buff in pairs(self.data.worldBuffs) do
      if buff.remain_time and buff.guid > 0 and buff.remain_time > 0 then
        buff.remain_time = math.max(0, buff.remain_time - deltaTime)
      end
    end
  end
end

function this:resumeWorldBuff()
  self.isPauseBuffTime = false
  self:restartBuffTimer()
end

function this:restartBuffTimer()
  if self.isPauseBuffTime or self.isBuffTimering then
    return
  end
  self._lastServerTime = L_TimeUtil.getServerTime()
  L_TimerManager:newOrResetTimer(self, "buffStore", handler(self, self.onUpdateBuffTimer), 0.5, -1)
  self.isBuffTimering = true
end

function this:checkInitPetCatchFoodBuffInfo()
  if not self.cachePetCatchFoodBuffId then
    local foodId = L_GameConstTpl:getData("STAR_LINK_UI_QUICK_USE_MEAL_LUCKY", L_Const.GameTplType.int)
    local foodTpl = L_GameTpl:getFoodTpl()
    local tpl = foodTpl:getTplById(foodId)
    local buffId = tpl and foodTpl:getBuffId(tpl)
    self.cachePetCatchFoodBuffId = buffId
  end
end

return this
