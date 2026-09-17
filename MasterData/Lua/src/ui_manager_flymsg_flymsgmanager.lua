local this = class("flyMsgManager", G_EventManagerBase)
this.event = {
  flyMsgPopup = "flyMsgPopup",
  flyMsgPopupEnd = "flyMsgPopupEnd"
}
table.merge(this, require("ui.manager.flyMsg.flyMsgManager_normalMsg"))
table.merge(this, require("ui.manager.flyMsg.flyMsgManager_rewardMsg"))
table.merge(this, require("ui.manager.flyMsg.flyMsgManager_longPress"))
table.merge(this, require("ui.manager.flyMsg.flyMsgManager_UILoading"))
table.merge(this, require("ui.manager.flyMsg.flyMsgManager_UISceneChange"))

function this:ctor()
  this.super.ctor(self)
  self.root = nil
  self.pool = nil
end

function this:getNextUniqueId()
  return L_PriorityShowQueueManager:getUniqueId()
end

function this:initialize()
  local go = C_PrefabManager:Instantiate("Program/FlyMsg/pre_flyMsgNode.prefab", L_UI:getRoot())
  go.name = "[FlyMsgNode]"
  self.root = go.transform
  local typeRect = typeof(C_RectTransform)
  self.despawnRoot = self.root:Find("despawnRoot"):GetComponent(typeRect)
  self.normalRoot = self.root:Find("normalRoot"):GetComponent(typeRect)
  self.rewardRoot = self.root:Find("rewardRoot"):GetComponent(typeRect)
  self.petEatFinishRoot = self.root:Find("petEatFinishRoot"):GetComponent(typeRect)
  self.petFavorLevelUpRoot = self.root:Find("petFavorLevelUpRoot"):GetComponent(typeRect)
  self.touchRoot = self.root:Find("touchRoot"):GetComponent(typeRect)
  self.favorabilityRoot = self.root:Find("favorabilityRoot"):GetComponent(typeRect)
  self.favorabilityMoveRoot = self.root:Find("favorabilityMoveRoot"):GetComponent(typeRect)
  self.longPressRoot = self.root:Find("longPressRoot"):GetComponent(typeRect)
  self.leftRoot = self.root:Find("LeftRoot"):GetComponent(typeRect)
  self.petDuelResultRoot = self.root:Find("petDuelResultRoot"):GetComponent(typeRect)
  self.canvas = self.root:GetComponent(typeof(Unity.Canvas))
  self.canvas.sortingOrder = 20000
  self.pool = L_PoolManager:getSpawnPool(self.despawnRoot, 0)
  L_UI:addListener(L_UI.pageEvent.opened, self.dealFlyMsgClose, self)
end

function this:dispose()
  if not self.root then
    return
  end
  self:disposeUILoading()
  self:disposeUISceneChange()
  self.pool:dispose()
  if L_CommonUtil.isValid(self.root.gameObject) then
    C_BoundGameObject.Destroy(self.root.gameObject)
  end
  self.root = nil
  self.despawnRoot = nil
  self.normalRoot = nil
  self.rewardRoot = nil
  self.petEatFinishRoot = nil
  self.touchRoot = nil
  self.favorabilityRoot = nil
  self.favorabilityMoveRoot = nil
  self.longPressRoot = nil
  self.multiDungeonInviteRoot = nil
  self.petDuelResultRoot = nil
  L_UI:removeListener(L_UI.pageEvent.opened, self.dealFlyMsgClose, self)
end

function this:formatImageStr(icon, name)
  local describe
  if string.isEmpty(icon) then
    describe = name
  else
    describe = string.format("<p=%s w=40 h=40/>%s", icon, name)
  end
  return describe
end

this.FLY_MSG_IMAGE_LOAD_TIMEOUT = 1
local _imageLoadCtxIdCounter = 0

function this:createImageLoadContext(onComplete)
  _imageLoadCtxIdCounter = _imageLoadCtxIdCounter + 1
  return {
    pendingCount = 0,
    loadedImgCount = 0,
    isComplete = false,
    isDestroyed = false,
    timeoutTimerGo = nil,
    timerKey = "",
    onComplete = onComplete,
    uniqueId = _imageLoadCtxIdCounter,
    isSetupFinished = false
  }
end

function this:loadImageAsync(ctx, lImage, path, isAtlas)
  if not lImage or string.isEmpty(path) then
    return
  end
  if isAtlas == nil then
    isAtlas = true
  end
  ctx.pendingCount = ctx.pendingCount + 1
  lImage:LoadSprite(path, isAtlas, CS.Azur.Gameplay.UI.ELImageLoadType.ForceAsync, function()
    self:onSingleImageLoaded(ctx)
  end)
end

function this:onSingleImageLoaded(ctx)
  if ctx.isDestroyed then
    return
  end
  ctx.loadedImgCount = ctx.loadedImgCount + 1
  if ctx.isSetupFinished and ctx.loadedImgCount >= ctx.pendingCount and ctx.pendingCount > 0 and not ctx.isComplete then
    self:completeImageLoad(ctx)
  end
end

function this:completeImageLoad(ctx)
  if ctx.isComplete then
    return
  end
  ctx.isComplete = true
  self:stopImageLoadTimeout(ctx)
  if ctx.onComplete then
    ctx.onComplete()
  end
end

function this:startImageLoadTimeout(ctx, go, timerKey)
  ctx.timeoutTimerGo = go
  ctx.timerKey = timerKey or "imageLoadTimeout"
  L_TimerManager:newOrResetTimer(go, ctx.timerKey, function()
    if ctx.isDestroyed then
      return
    end
    if not ctx.isComplete then
      C_MJLog.LogWarning(string.format("[FlyMsgManager] 图片加载超时，强制显示 UI (已加载 %d/%d 张)", ctx.loadedImgCount, ctx.pendingCount), C_ELogModule.UIMgr)
      self:completeImageLoad(ctx)
    end
  end, this.FLY_MSG_IMAGE_LOAD_TIMEOUT)
end

function this:stopImageLoadTimeout(ctx)
  L_TimerManager:stopTimer(ctx.timeoutTimerGo, ctx.timerKey)
end

function this:destroyImageLoadContext(ctx)
  if ctx then
    ctx.isDestroyed = true
    ctx.onComplete = nil
  end
end

function this:finishImageLoadSetup(ctx, go, timerKey)
  ctx.isSetupFinished = true
  if ctx.isComplete then
    return
  end
  if ctx.loadedImgCount >= ctx.pendingCount and ctx.pendingCount > 0 then
    self:completeImageLoad(ctx)
  elseif ctx.pendingCount == 0 then
    self:completeImageLoad(ctx)
  else
    local uniqueTimerKey = string.format("%s_%d", timerKey or "imageLoadTimeout", ctx.uniqueId)
    self:startImageLoadTimeout(ctx, go, uniqueTimerKey)
  end
end

function this:IsShowingAchieve()
  if self.achievementQueue and self.achievementQueue:getFirst() ~= nil then
    return true
  end
  return false
end

function this:dealFlyMsgClose(pageName)
  if pageName ~= "pageMainCity" and pageName ~= "pageNetworkWaiting" and pageName ~= "PageMultiTeamState" then
    C_MJLog.LogWarning(string.format("dealFlyMsgClose pageName: %s", pageName))
    if self.petCatalogTipModule then
      self.petCatalogTipModule:close()
    end
    if self.getPetTipModule then
      self.getPetTipModule:close()
    end
  end
end

return this
