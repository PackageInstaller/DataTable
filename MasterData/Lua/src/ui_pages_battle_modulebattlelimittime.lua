local this = class("moduleBattleLimitTime", G_UIModuleBase)

function this.bind()
  return {
    goTime = false,
    txt_time = "",
    go_battleEft = false
  }
end

function this.methods()
  return {}
end

function this:created(...)
  self.data = {limitTime = nil, startTime = nil}
  this.super.created(self, ...)
end

function this:clearData()
  if not self.data then
    return
  end
  self.bind.goTime = false
  self.data.limitTime = nil
  self.data.startTime = nil
end

function this:open()
  L_BattleDataManager:addListener(L_BattleDataManager.event.startBattleLimitTime, self.onEvent_startBattleLimitTime, self)
  L_BattleDataManager:addListener(L_BattleDataManager.event.battleFinished, self.stopTimer, self)
  self:refresh()
  self.updateHandle = handler(self, self.update)
  C_UpdateSource.AddUpdateEventHandler(self.updateHandle, "moduleBattleLimitTime.update")
  self:refreshBattleEft()
end

function this:refreshBattleEft()
  local curModule = L_WorldManager:getCurModule()
  if curModule == L_Const.worldModule.main then
    self.bind.go_battleEft = false
    self.bind.go_battleEft = true
  end
end

function this:refresh()
  self.data.startTime = L_BattleDataManager:getBattleStartTime()
  self.data.limitTime = L_BattleDataManager:getBattleLimitTime()
  self.bind.goTime = self.data.startTime ~= nil and self.data.limitTime ~= nil
  if self.bind.goTime then
    self.beginTime = C_TimeManager.globalTime
  end
end

function this:update()
  if not self.bind.goTime then
    return
  end
  local second = self.data.limitTime - (C_TimeManager.globalTime - self.beginTime)
  second = second < 0 and 0 or math.floor(second)
  self.bind.txt_time = L_WordsTpl:getValue("ui_moduleBattleLimitTime", {
    [0] = L_TimeUtil.secondToString(second)
  })
end

function this:stopTimer()
  self.bind.goTime = false
end

function this:onEvent_startBattleLimitTime(args)
  self:refresh()
  self.beginTime = C_TimeManager.globalTime
end

function this:hide(options)
  self.bind.go_battleEft = false
end

function this:close()
  self:clearData()
  C_UpdateSource.RemoveUpdateEventHandler(self.updateHandle)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.startBattleLimitTime, self.onEvent_startBattleLimitTime, self)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.battleFinished, self.stopTimer, self)
end

function this:activate()
  self:open()
  self:openModules()
  self:show()
  self:showModules()
end

function this:deActivate()
  self:hide()
  self:hideModules()
  self:close()
  self:closeModules()
end

return this
