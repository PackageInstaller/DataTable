local this = class("loading", G_UIPageBase)

function this.bind()
  return {
    goCutRoot = false,
    goFxIn = false,
    goFxOut = false,
    goChance = false,
    csOrder = 30000
  }
end

function this:preOpen(options)
  L_LoadingManager:sendEvent(L_LoadingManager.event.loadingProgressStart)
end

function this:show(options)
  self.bind.csOrder = 30000
  self.bind.goFxIn = false
  self.bind.goFxOut = false
  local bev = L_LoadingManager:getCurBehavior()
  if bev then
    if bev:blend(options.mode, options) then
      return
    end
    L_LoadingManager:unloadBehavior()
  end
  bev = L_LoadingManager:generateBehavior(options.mode, options, self.bindComponents.normalRoot)
  local mode = bev:getMode()
  local isNormal = mode == L_Const.loadingMode.scene or mode == L_Const.loadingMode.default
  self.bind.goCutRoot = not isNormal
  bev:start()
  if options.showCallback then
    options.showCallback()
  end
end

function this:update()
  local bev = L_LoadingManager:getCurBehavior()
  if bev then
    bev:update()
  end
end

function this:close(options)
  CS.Azur.Gameplay.Core.SmartGC.Instance:GCClearTiming(CS.Azur.Gameplay.Core.EGCClearTiming.LoadingClose)
  L_LoadingManager:unloadBehavior()
  L_LoadingManager:sendEvent(L_LoadingManager.event.loadingProgressEnd)
end

return this
