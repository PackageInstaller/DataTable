_class("LoadingHandler", Object)
LoadingHandler = LoadingHandler

function LoadingHandler:Constructor()
  self.sceneResReq = nil
  self.loadingID = nil
  self.cfg = Cfg.cfg_system_loading({
    loadingHandlerName = self._className
  })
end

function LoadingHandler:SetProgressBar(progressBar)
  self._progressBar = progressBar
end

function LoadingHandler:PreLoadBeforeLoadLevel(TT, ...)
end

function LoadingHandler:LoadLevel(TT, levelName)
  if string.equal_with_ignorecase(UIHelper.GetActiveSceneName(), levelName) then
    Log.debug("[Loading] LoadingHandler:LoadLevel, this level is already active ,", levelName)
    return
  end
  Log.debug("[Loading] LoadingHandler:LoadLevel, ", levelName)
  self.sceneResReq = GameGlobal.GameLogic():LoadScene(TT, levelName)
end

function LoadingHandler:PreLoadAfterLoadLevel(TT, ...)
end

function LoadingHandler:LoadingFinish(...)
  self:OnLoadingFinish(...)
end

function LoadingHandler:OnLoadingFinish()
end

function LoadingHandler:SetLoadingProgress(progress)
  if self._progressBar then
    self._progressBar:SetProgress(progress)
  end
end

function LoadingHandler:LoadingType()
  return LoadingType.STATICPIC
end

function LoadingHandler:LoadingID()
  local loadingIds = self.cfg and self.cfg[1].loadingIds
  if loadingIds then
    return GameGlobal.LoadingManager():FilterAndRandomLoadingID(loadingIds)
  else
    return nil
  end
end

function LoadingHandler:NeedSwitchState()
  return false
end
