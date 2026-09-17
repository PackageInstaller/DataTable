local this = class("moduleFlyMsgAsyncImageBase", G_UIModuleBase)

function this:initAsyncImageLoad(canvasGroupComponent)
  self._imageLoadCtx = {
    pendingCount = 0,
    loadedImgCount = 0,
    isComplete = false,
    isDestroyed = false,
    isSetupFinished = false
  }
  if canvasGroupComponent then
    self._canvasGroup = canvasGroupComponent
  else
    self._canvasGroup = self.gameObject:GetComponent(typeof(Unity.CanvasGroup))
    if not self._canvasGroup then
      self._canvasGroup = self.gameObject:AddComponent(typeof(Unity.CanvasGroup))
    end
  end
  self._canvasGroup.alpha = 0
end

function this:showUIAfterImageLoad()
  if self._imageLoadCtx and self._imageLoadCtx.isDestroyed then
    return false
  end
  if self._canvasGroup then
    self._canvasGroup.alpha = 1
  end
  return true
end

function this:_loadImageAsync(ctx, lImage, path, isAtlas)
  if not lImage or string.isEmpty(path) then
    return
  end
  if isAtlas == nil then
    isAtlas = true
  end
  ctx.pendingCount = ctx.pendingCount + 1
  lImage:LoadSprite(path, isAtlas, CS.Azur.Gameplay.UI.ELImageLoadType.ForceAsync, function()
    if ctx.isDestroyed then
      return
    end
    ctx.loadedImgCount = ctx.loadedImgCount + 1
    if ctx.isSetupFinished and ctx.loadedImgCount >= ctx.pendingCount and ctx.pendingCount > 0 and not ctx.isComplete then
      L_TimerManager:stopTimer(self, "imageLoadTimeout")
      self:_completeImageLoad(ctx, ctx.onComplete)
    end
  end)
end

function this:_loadRawImageAsync(ctx, lRawImage, path)
  if not lRawImage or string.isEmpty(path) then
    return
  end
  ctx.pendingCount = ctx.pendingCount + 1
  lRawImage:LoadTextureAsync(path, function()
    if ctx.isDestroyed then
      return
    end
    ctx.loadedImgCount = ctx.loadedImgCount + 1
    if ctx.isSetupFinished and ctx.loadedImgCount >= ctx.pendingCount and ctx.pendingCount > 0 and not ctx.isComplete then
      L_TimerManager:stopTimer(self, "imageLoadTimeout")
      self:_completeImageLoad(ctx, ctx.onComplete)
    end
  end)
end

function this:_completeImageLoad(ctx, onComplete)
  if ctx.isComplete then
    return
  end
  ctx.isComplete = true
  if onComplete then
    onComplete()
  end
end

function this:_startImageLoadTimeout(ctx, onComplete, moduleName)
  L_TimerManager:newOrResetTimer(self, "imageLoadTimeout", function()
    if ctx.isDestroyed then
      return
    end
    if not ctx.isComplete then
      C_MJLog.LogWarning(string.format("[%s] 图片加载超时，强制显示 UI", moduleName or "FlyMsgModule"), C_ELogModule.UIMgr)
      self:_completeImageLoad(ctx, onComplete)
    end
  end, L_FlyMsgManager.FLY_MSG_IMAGE_LOAD_TIMEOUT)
end

function this:_finishImageLoadSetup(ctx, onComplete, moduleName)
  ctx.isSetupFinished = true
  ctx.onComplete = onComplete
  if ctx.isComplete then
    L_TimerManager:stopTimer(self, "imageLoadTimeout")
    if onComplete then
      onComplete()
    end
    return
  end
  if ctx.loadedImgCount >= ctx.pendingCount and ctx.pendingCount > 0 then
    L_TimerManager:stopTimer(self, "imageLoadTimeout")
    if onComplete then
      onComplete()
    end
  elseif ctx.pendingCount == 0 then
    L_TimerManager:stopTimer(self, "imageLoadTimeout")
    if onComplete then
      onComplete()
    end
  else
    self:_startImageLoadTimeout(ctx, onComplete, moduleName)
  end
end

function this:_destroyImageLoadContext()
  if self._imageLoadCtx then
    self._imageLoadCtx.isDestroyed = true
    self._imageLoadCtx = nil
  end
end

function this:close()
  self:_destroyImageLoadContext()
  this.super.close(self)
end

return this
