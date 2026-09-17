local this = class("loadingManager", G_EventManagerBase)
this.event = {
  loadingProgressStart = "loadingProgressStart",
  loadingProgressUpdate = "loadingProgressUpdate",
  loadingProgressEnd = "loadingProgressEnd"
}
AzurWorld = CS.Lens.Gameplay.Modules.Azur.AzurWorld

function this:ctor()
  this.super.ctor(self)
  self.behavior = nil
end

function this:sendOnLoadProcess(option)
  self:sendEvent(self.event.loadingProgressUpdate, option)
  if AzurWorld.DungeonEntrustManager then
    AzurWorld.DungeonEntrustManager:UpdateLoading(option.progress)
  end
  if self.behavior then
    self.behavior:onUpdateProgress(option)
  end
end

function this:openLoading(options)
  if G_Launcher.gameplayRequired then
    local curModule = L_WorldManager:getCurModule()
    if curModule == L_Const.worldModule.nestCoop then
      local nestTeamLoadingPage = L_UI:getPage("pageNestTeam")
      if nestTeamLoadingPage ~= nil then
        return
      end
    elseif curModule == L_Const.worldModule.multiDungeon then
      local pageMultipleTeam = L_UI:getPage("PageMultipleTeam")
      if pageMultipleTeam ~= nil then
        return
      end
    elseif curModule == L_Const.worldModule.kiboDuelArena then
      if not L_UI:checkPageOpen("pageKiboDuelPVPLoading") then
        L_UI:open("pageKiboDuelPVPLoading")
      end
      if L_UI:checkPageOpen("loading") then
        L_UI:close("loading")
      end
      return
    end
  end
  self:interruptPendingClose()
  options = options or {}
  local tipTpl = L_GameTpl:getTipsTpl()
  local tpl = tipTpl:getDefaultTpl()
  if AzurWorldInstance.inGame then
    local sceneId = AzurWorldInstance.CurWorldId
    tpl = tipTpl:getTplBySceneIdOrDefault(sceneId)
  end
  local gId = tipTpl:getGroupId(tpl)
  local tipGropTpl = L_GameTpl:getTipsGroupTpl()
  local list = tipGropTpl:getTplListByGroupId(gId)
  local bg = tipGropTpl:getBg(list[1])
  if options.mode == nil then
    if string.isEmpty(bg) then
      options.mode = L_Const.loadingMode.default
    else
      options.mode = L_Const.loadingMode.scene
    end
  end
  L_UI:open("loading", options)
end

function this:openBattleLoading(waitCall, options)
  options = options or {}
  options.mode = L_Const.loadingMode.battleIn
  options.autoClose = false
  L_UI:open("loading", options)
  if waitCall then
    Timer.once(0.5, waitCall)
  end
end

function this:openBattleOutLoading(options, waitCall)
  options = options or {}
  options.mode = L_Const.loadingMode.battleOut
  options.autoClose = false
  L_UI:open("loading", options)
  if waitCall then
    Timer.once(0.5, waitCall)
  end
end

function this:openBlackCutLoading(options, waitCall)
  options = options or {}
  options.mode = L_Const.loadingMode.blackCutIn
  L_UI:open("loading", options)
  if waitCall then
    Timer.once(0.4, waitCall)
  end
end

function this:openSaveFormationLoading(options, waitCall, ignoreDelay)
  self:interruptPendingClose()
  options = options or {}
  options.mode = L_Const.loadingMode.saveFormation
  L_UI:open("loading", options)
  if ignoreDelay then
    if waitCall then
      waitCall()
    end
  elseif waitCall then
    Timer.once(0.167, waitCall)
  end
end

function this:closeLoading()
  if G_Launcher.gameplayRequired then
    local curModule = L_WorldManager:getCurModule()
    if curModule == L_Const.worldModule.nestCoop then
      local nestTeamLoadingPage = L_UI:getPage("pageNestTeam")
      if nestTeamLoadingPage ~= nil then
        local isLoadingPageOpen = L_UI:checkPageOpen("loading")
        if isLoadingPageOpen then
          printf("[巢穴]loadingFinish. 存在一般loading界面,关闭巢穴loading界面")
          L_UI:close("pageNestTeam")
        else
          printf("[巢穴]loadingFinish. 关闭巢穴loading界面")
          nestTeamLoadingPage.cls:PlayCutOut()
          local cfg = C_ProxyDefine.UIRootDic[curModule]
          L_UI:open(cfg.PageName, nil)
          return
        end
      end
    elseif curModule == L_Const.worldModule.multiDungeon then
      local nestTeamLoadingPage = L_UI:getPage("PageMultipleTeam")
      if nestTeamLoadingPage ~= nil then
        local isLoadingPageOpen = L_UI:checkPageOpen("loading")
        if isLoadingPageOpen then
          printf("[巢穴]loadingFinish. 存在一般loading界面,关闭巢穴loading界面")
          L_UI:close("PageMultipleTeam")
        else
          printf("[巢穴]loadingFinish. 关闭巢穴loading界面")
          if AzurWorld.DungeonEntrustManager then
            AzurWorld.DungeonEntrustManager:UpdateLoading(1)
          end
          return
        end
      end
    elseif curModule == L_Const.worldModule.kiboDuelArena then
      local kiboArenaLoadingPage = L_UI:getPage("pageKiboDuelPVPLoading")
      if kiboArenaLoadingPage ~= nil then
        kiboArenaLoadingPage.cls:OnLoadingEnd()
        return
      end
    elseif curModule == L_Const.worldModule.culTrial then
      AzurWorld.scenarioManager:OnCompleteLoading()
    elseif curModule == L_Const.worldModule.culMain then
      AzurWorld.scenarioManager:OnCompleteLoading()
      return
    end
  end
  self:sendOnLoadProcess({progress = 1, finish = true})
end

function this:shotDownLoading()
  L_UI:close("loading")
end

function this:getCurBehavior()
  return self.behavior
end

function this:generateBehavior(mode, options, parent)
  self.behavior = require("ui.manager.loading.behavior.loadingBehavior_" .. mode).new()
  if mode == L_Const.loadingMode.default or mode == L_Const.loadingMode.scene or mode == L_Const.loadingMode.blackShow or mode == L_Const.loadingMode.whiteShow or mode == L_Const.loadingMode.saveFormation then
    local prePath = string.format("UI/Pages/Loading/part/partLoading_%s.prefab", mode)
    local go = L_ResPool:syncGameObject(prePath, parent)
    self.behavior:created(go, options)
  else
    self.behavior:open(options)
  end
  self.behavior.mode = mode
  return self.behavior
end

function this:unloadBehavior()
  if self.behavior == nil then
    return
  end
  local mode = self.behavior:getMode()
  if mode == L_Const.loadingMode.default or mode == L_Const.loadingMode.scene or mode == L_Const.loadingMode.saveFormation then
    C_BoundGameObject.Destroy(self.behavior.gameObject)
  end
  self.behavior:destroy()
  self.behavior = nil
end

function this:isLoading()
  local status = L_UI:getPageStatus("loading")
  if status and status == "shown" then
    return true
  end
  return false
end

function this:interruptPendingClose()
  local behavior = self.behavior
  if behavior == nil or not behavior.isClosing then
    return false
  end
  behavior:cancelPendingClose()
  return true
end

return this
