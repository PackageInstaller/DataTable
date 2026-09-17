local this = class("worldManager", G_EventManagerBase)
this.event = {
  exitBattle = "syncManager_exitBattle",
  triggerInteractive = "triggerInteractive"
}

function this:ctor()
  this.super.ctor(self)
end

function this:initialize()
end

function this:getCurModule()
  if AzurWorld.proxyCenter then
    return AzurWorld.proxyCenter.curWorldType
  end
end

function this:getIsActive()
  return AzurWorldInstance.WorldStarted
end

function this:translateUpdate(isUpdate)
  local worldIns = C_WorldProxy.GetInstance()
  if isUpdate then
    L_GameTimer.resume()
    AzurWorldInstance:ResumeWorld()
  else
    L_GameTimer.pause()
    AzurWorldInstance:PauseWorld()
  end
end

function this:dispose(callback)
end

return this
