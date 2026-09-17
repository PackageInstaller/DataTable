local this = class("priorityShowQueueManager")
this:importPartialClass(require("ui.manager.priorityShowQueue.priorityShowQueueCheckFuncs"))
local _uiViewTpl = L_GameTpl:getUiViewTpl()
local _worldDifficultyCityTpl = L_GameTpl:getWorldDifficultyCityTpl()

function this:getUniqueId()
  return 0
end

function this:initialize()
  L_GameEventStore:listenCallFunc(L_GameEventStore.event.gameEventSync, self.checkSignInSystem, self)
  L_GameStore:listenCallFunc(L_GameStore.event.enterGame, self.checkSignInSystem, self)
  L_FlyMsgManager:addListener(L_FlyMsgManager.event.flyMsgPopupEnd, self.onEvent_flyMsgPopupEnd, self)
  L_BattleManager:addListener(L_BattleManager.event.exitBattle, self.onEvent_exitBattle, self)
  L_BattleManager:addListener(L_BattleManager.event.battleStart, self.onEvent_battleStart, self)
end

function this:dispose()
  L_GameEventStore:unListenCallFunc(L_GameEventStore.event.gameEventSync, self.checkSignInSystem)
  L_GameStore:unListenCallFunc(L_GameStore.event.enterGame, self.checkSignInSystem, self)
  L_FlyMsgManager:removeListener(L_FlyMsgManager.event.flyMsgPopupEnd, self.onEvent_flyMsgPopupEnd)
  L_BattleManager:removeListener(L_BattleManager.event.exitBattle, self.onEvent_exitBattle)
  L_BattleManager:removeListener(L_BattleManager.event.battleStart, self.onEvent_battleStart)
end

function this:onEvent_battleStart()
  AzurWorld.PriorityQueueManager:Freeze(true, 2)
end

function this:onEvent_exitBattle()
  AzurWorld.PriorityQueueManager:Freeze(false, 2)
end

function this:onEvent_flyMsgPopupEnd(flyMsgType, uuid)
  AzurWorld.FlymsgManager:CloseFlymsg(uuid)
end

function this:addPriorityShowData(priorityShowData)
  if AzurWorld.FlymsgManager then
    AzurWorld.FlymsgManager:Enqueue(priorityShowData.flyMsgType, priorityShowData and priorityShowData.params)
  end
end

function this:checkSignInSystem()
  AzurWorld.PriorityQueueManager:CheckSignInSystem()
end

return this
