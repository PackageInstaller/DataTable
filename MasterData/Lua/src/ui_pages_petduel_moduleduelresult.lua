local this = class("moduleDuelResult", G_UIModuleBase)
local maxShowCount = 5
local petTpl = L_GameTpl:getPetTpl()
local continuousKillStart = L_GameTpl:getGameConstTpl():getData("KIBO_DUEL_CONTINUITY_KO_NUM", L_Const.GameTplType.int)
local continuousKillTime = L_GameTpl:getGameConstTpl():getData("KIBO_DUEL_CONTINUITY_KO_TIME", L_Const.GameTplType.dict_int_int)
local multiKillStart = L_GameTpl:getGameConstTpl():getData("KIBO_DUEL_ACCUMULATE_KO_NUM", L_Const.GameTplType.int)

function this.bind()
  return {}
end

function this.methods()
  return {}
end

function this:toBind(uiBinding)
  self.super.toBind(self, uiBinding)
  local addModuleGeneric = xlua.get_generic_method(self.parent.csharpPage:GetType(), "AddModule", 1)
  local addModule = addModuleGeneric(CS.Lens.Gameplay.UI.PetDuel.ModuleDuelResult, CS.UnityEngine.GameObject)
  self.transferModule = addModule(self.parent.csharpPage, self.parent.csharpPage, self.gameObject)
end

function this:restartKiBoDuel(e, varList)
  self:reset()
end

function this:reset()
  self.showResults = L_Struct.getQueue()
  self:disposeNotifyTimer()
  self.bind.resultList:clear()
  self.bind.resultNotifyActive = false
  self:disposeStuckTimer()
  self.notifyCache = {}
  self.notifyStuck = false
  self.multiKillCache = {}
  self.nextNotifyCache = nil
  self:disposeAllAccTimer()
  self.accTimer = {}
  self.continuousRecord = {}
  self.continuousKillTimeCount = 0
end

function this:onRefreshDuelResult(e, varList)
  local data = varList:GetObject(0)
  if self.multiKillCache == nil then
    self.multiKillCache = {}
  end
  local winNotRecord = data.isWin and data.player.notRecord or data.enemy.notRecord
  local winEntityId = data.isWin and data.player.guid or data.enemy.guid
  local loseEntityId = data.isWin and data.enemy.guid or data.player.guid
  if winEntityId == loseEntityId then
    self.multiKillCache[loseEntityId] = {
      killCount = 0,
      continuousKillCount = 0,
      killTime = 0,
      isShutDown = false
    }
    return
  end
  self:recordMultiKillCache(winEntityId, loseEntityId, winNotRecord)
  if self.accStuck[winEntityId] then
    return
  end
  local delayTime = self.notifyStuck and 2 or 0.1
  self.accTimer[winEntityId] = Timer.once(delayTime, function()
    CS.UnityEngine.Profiling.Profiler.BeginSample("Timer:onRefreshDuelResult.createNotify")
    self.accStuck[winEntityId] = false
    self:disposeAccTimer(winEntityId)
    self:createNotify(data, winEntityId, loseEntityId)
    CS.UnityEngine.Profiling.Profiler.EndSample()
  end, self)
  self.accStuck[winEntityId] = true
end

function this:createNotify(data, winEntityId, loseEntityId)
  if self.notifyCache == nil then
    self.notifyCache = {}
  end
  local continuousKillCount = self.multiKillCache[winEntityId].continuousKillCount
  local notify = {
    isWin = data.isWin,
    player = data.player,
    enemy = data.enemy,
    isShutDown = self.multiKillCache[loseEntityId].isShutDown,
    continuousKillCount = continuousKillCount,
    killCount = self.multiKillCache[winEntityId].killCount
  }
  if continuousKillCount > self.continuousKillTimeCount + 1 then
    self.multiKillCache[winEntityId].continuousKillCount = self.multiKillCache[winEntityId].continuousKillCount % (self.continuousKillTimeCount + 1)
  end
  table.insert(self.notifyCache, notify)
  self:checkAndPlayNofity()
end

function this:checkAndPlayNofity()
  if (self.notifyCache == nil or #self.notifyCache == 0) and self.nextNotifyCache == nil then
    return
  end
  if self.notifyStuck then
    return
  end
  self.notifyStuck = true
  self.bind.resultNotifyActive = false
  local data = self.nextNotifyCache and table.clone(self.nextNotifyCache) or table.remove(self.notifyCache, 1)
  if self.nextNotifyCache then
    data.multiNotifyState = L_Const.kiboDuelMultiNotifyEnum.shutDown
    self.nextNotifyCache = nil
  end
  local delayTime = data.isWin and 2.475 or 2.475
  local animationName = data.isWin and "anim_petbattle_kill" or "anim_petbattle_killed"
  self.bindComponents.notifyAnimation:Play(animationName)
  self:disposeNotifyTimer()
  self:disposeStuckTimer()
  self.modules.moduleDuelResultNotify:playResultNotify(data)
  L_AudioUtil.playSound("Play_SFX_System_QiboChallenge_KO")
  self.bind.resultNotifyActive = true
  self.notifyTimer = Timer.once(delayTime, function()
    CS.UnityEngine.Profiling.Profiler.BeginSample("Timer:checkAndPlayNofity.hideNotify")
    self.notifyStuck = false
    self.bind.resultNotifyActive = false
    self:disposeNotifyTimer()
    self:checkAndPlayNofity()
    CS.UnityEngine.Profiling.Profiler.EndSample()
  end, self)
  self.stuckTimer = Timer.once(2, function()
    CS.UnityEngine.Profiling.Profiler.BeginSample("Timer:checkAndPlayNofity.unstuck")
    self.notifyStuck = false
    self:disposeStuckTimer()
    if self.notifyCache ~= nil and #self.notifyCache > 0 or self.nextNotifyCache ~= nil then
      self:checkAndPlayNofity()
      self:disposeNotifyTimer()
    end
    CS.UnityEngine.Profiling.Profiler.EndSample()
  end, self)
  if not data.multiNotifyState and self:checkIsmultiNotifyState(data) then
    data.multiNotifyState = L_Const.kiboDuelMultiNotifyEnum.specialKill
    self.nextNotifyCache = data
  end
  self:playResult(data)
end

function this:playResult(data)
  Timer.once(0.17, function()
    CS.UnityEngine.Profiling.Profiler.BeginSample("Timer:playResult.showMsg")
    if not self.isBind then
      CS.UnityEngine.Profiling.Profiler.EndSample()
      return
    end
    AzurWorld.FlymsgManager:Enqueue("FlymsgPetDuelResult", data)
    CS.UnityEngine.Profiling.Profiler.EndSample()
  end, self)
end

function this:disposeStuckTimer()
  if self.stuckTimer ~= nil then
    Timer.remove(self.stuckTimer)
    self.stuckTimer = nil
  end
end

function this:disposeNotifyTimer()
  if self.notifyTimer ~= nil then
    Timer.remove(self.notifyTimer)
    self.notifyTimer = nil
  end
end

function this:disposeAccTimer(winEntityId)
  if self.accTimer ~= nil and self.accTimer[winEntityId] ~= nil then
    Timer.remove(self.accTimer[winEntityId])
    self.accTimer[winEntityId] = nil
  end
end

function this:disposeAllAccTimer()
  if self.accStuck == nil then
    self.accStuck = {}
    return
  end
  for k, v in pairs(self.accStuck) do
    self:disposeAccTimer(k)
  end
  self.accStuck = {}
end

function this:recordMultiKillCache(winEntityId, loseEntityId, winNotRecord)
  if self.multiKillCache[winEntityId] == nil or winNotRecord then
    self.multiKillCache[winEntityId] = {
      killCount = 1,
      continuousKillCount = 1,
      killTime = C_KiboDuelSystemMgr:GetDuelTime(),
      isShutDown = false
    }
  else
    local data = self.multiKillCache[winEntityId]
    local currTime = C_KiboDuelSystemMgr:GetDuelTime()
    local killCount = self.multiKillCache[winEntityId].continuousKillCount
    local isOverKill = killCount > self.continuousKillTimeCount + 1 and not self.notifyStuck and not self.accStuck[winEntityId]
    local overTime = continuousKillTime[killCount + 1]
    if isOverKill or overTime ~= nil and overTime < currTime - data.killTime then
      self.multiKillCache[winEntityId].continuousKillCount = 1
    else
      self.multiKillCache[winEntityId].continuousKillCount = killCount + 1
    end
    self.multiKillCache[winEntityId].isShutDown = false
    self.multiKillCache[winEntityId].killTime = currTime
    self.multiKillCache[winEntityId].killCount = self.multiKillCache[winEntityId].killCount + 1
  end
  if self.multiKillCache[loseEntityId] == nil then
    self.multiKillCache[loseEntityId] = {
      killCount = 0,
      continuousKillCount = 0,
      killTime = 0,
      isShutDown = false
    }
  else
    local isShutDown = self.multiKillCache[loseEntityId].killCount >= multiKillStart
    self.multiKillCache[loseEntityId] = {
      killCount = 0,
      continuousKillCount = 0,
      killTime = 0,
      isShutDown = isShutDown
    }
  end
end

function this:checkIsmultiNotifyState(data)
  local isContinuousNotify = data.continuousKillCount >= continuousKillStart and continuousKillTime[data.continuousKillCount] ~= nil
  local isMultiNotify = data.killCount >= multiKillStart
  return (isContinuousNotify or isMultiNotify) and data.isShutDown
end

return this
