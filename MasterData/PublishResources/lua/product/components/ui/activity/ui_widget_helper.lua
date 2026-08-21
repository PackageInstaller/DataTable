_class("UIWidgetHelper", Object)
UIWidgetHelper = UIWidgetHelper

function UIWidgetHelper:Constructor()
end

function UIWidgetHelper.SpawnObject(uiView, widgetName, className, prefabName)
  local pool = uiView:GetUIComponent("UISelectObjectPath", widgetName)
  if not string.isnullorempty(prefabName) then
    pool.dynamicInfoOfEngine:SetObjectName(prefabName)
  end
  local obj = pool:SpawnObject(className)
  return obj
end

function UIWidgetHelper.SpawnObjects(uiView, widgetName, className, count, prefabName)
  local pool = uiView:GetUIComponent("UISelectObjectPath", widgetName)
  if not string.isnullorempty(prefabName) then
    pool.dynamicInfoOfEngine:SetObjectName(prefabName)
  end
  local objs = {}
  pool:SpawnObjects(className, count, objs)
  return objs
end

function UIWidgetHelper.ClearWidgets(uiView, widgetName)
  local pool = uiView:GetUIComponent("UISelectObjectPath", widgetName)
  pool:ClearWidgets()
end

function UIWidgetHelper.SetImageSprite(uiView, widgetName, atlasName, spriteName)
  local atlas = uiView:GetAsset(atlasName, LoadType.SpriteAtlas)
  local obj = uiView:GetUIComponent("Image", widgetName)
  obj.sprite = atlas:GetSprite(spriteName)
end

function UIWidgetHelper.SetRawImage(uiView, widgetName, url)
  local obj = uiView:GetUIComponent("RawImageLoader", widgetName)
  obj:LoadImage(url)
end

function UIWidgetHelper.SetRawImageTexture(uiView, widgetName, texture)
  if texture ~= nil then
    local obj = uiView:GetUIComponent("RawImage", widgetName)
    obj.texture = texture
    return true
  end
  return false
end

function UIWidgetHelper.InitImageSpriteOrRaw(uiView, name, uiWidget)
  local icon = {
    _iconGO = uiWidget,
    _icon = uiWidget:GetComponent("Image"),
    _iconRaw = uiWidget:GetComponent("RawImage"),
    _iconLoader = uiWidget:GetComponent("RawImageLoader")
  }
  uiView[name] = icon
end

function UIWidgetHelper.SetImageSpriteOrRaw(uiView, name, atlas, spriteName)
  local icon = uiView[name]
  local sprite = atlas:GetSprite(spriteName)
  if sprite ~= nil then
    if icon._icon == nil then
      UnityEngine.Object.DestroyImmediate(icon._iconRaw)
      UnityEngine.Object.DestroyImmediate(icon._iconLoader)
      icon._iconRaw = nil
      icon._iconLoader = nil
      icon._icon = icon._iconGO:AddComponent(typeof(UnityEngine.UI.Image))
    end
    icon._icon.sprite = sprite
  else
    if icon._iconRaw == nil then
      UnityEngine.Object.DestroyImmediate(icon._icon)
      icon._icon = nil
      icon._iconRaw = icon._iconGO:AddComponent(typeof(UnityEngine.UI.RawImage))
      icon._iconLoader = icon._iconGO:AddComponent(typeof(RawImageLoader))
    end
    icon._iconLoader:LoadImage(spriteName)
  end
end

function UIWidgetHelper.SetSliderValue(uiView, widgetName, value, maxValue)
  local obj = uiView:GetUIComponent("Slider", widgetName)
  if maxValue then
    obj.maxValue = maxValue
  end
  obj.value = value
end

function UIWidgetHelper.SetLocalizationText(uiView, widgetName, text)
  local obj = uiView:GetUIComponent("UILocalizationText", widgetName)
  obj:SetText(text)
end

function UIWidgetHelper.SetRollingText(uiView, widgetName, text)
  local obj = uiView:GetUIComponent("RollingText", widgetName)
  obj:RefreshText(text)
end

function UIWidgetHelper.SetLocalizedTMPMaterial(uiView, widgetName, matName, materialReq)
  materialReq = materialReq or ResourceManager:GetInstance():SyncLoadAsset(matName, LoadType.Mat)
  if materialReq and materialReq.Obj then
    local tmp = uiView:GetUIComponent("UILocalizedTMP", widgetName)
    local oldMaterial = tmp.fontMaterial
    tmp.fontMaterial = materialReq.Obj
    tmp.fontMaterial:SetTexture("_MainTex", oldMaterial:GetTexture("_MainTex"))
  end
  return materialReq
end

function UIWidgetHelper.DisposeLocalizedTMPMaterial(materialReq)
  if materialReq then
    materialReq:Dispose()
  end
  return nil
end

function UIWidgetHelper.SetLocalizedTMPText(uiView, widgetName, text)
  local obj = uiView:GetUIComponent("UILocalizedTMP", widgetName)
  obj:SetText(text)
end

function UIWidgetHelper.SetAnimationPlay(uiView, widgetName, animName)
  local obj = uiView:GetUIComponent("Animation", widgetName)
  obj:Play(animName)
end

function UIWidgetHelper.SetAnimationReset(uiView, widgetName, animName)
  local obj = uiView:GetUIComponent("Animation", widgetName)
  local state = obj:get_Item(animName)
  state.normalizedTime = 0
  obj:Stop()
end

function UIWidgetHelper.LogAnimationClips(uiView, widgetName, desc)
  local obj = uiView:GetUIComponent("Animation", widgetName)
  local text = "UIWidgetHelper.LogAnimationClips() " .. desc
  Log.debug(text, "----------")
  local clips = HelperProxy:GetInstance():GetAllAnimationClip(obj)
  for i = 0, clips.Length - 1 do
    if clips[i] ~= nil then
      Log.debug(text, " clips[", i, "] = ", clips[i].name)
    end
  end
end

function UIWidgetHelper.SetSpineLoad(uiView, widgetName, spineName, curSpine)
  local skip = true
  if curSpine and curSpine.spineName == spineName then
    return curSpine, skip
  end
  local obj = uiView:GetUIComponent("SpineLoader", widgetName)
  obj:LoadSpine(spineName)
  local skeleton = obj.CurrentSkeleton or obj.CurrentMultiSkeleton
  return {
    spine = obj,
    skeleton = skeleton,
    spineName = spineName
  }, not skip
end

function UIWidgetHelper.SetSpineDestroy(uiView, widgetName)
  local obj = uiView:GetUIComponent("SpineLoader", widgetName)
  obj:DestroyCurrentSpine()
end

function UIWidgetHelper.SetSpineAnimation(curSpine, trackIndex, animName, loop)
  if curSpine and curSpine.skeleton then
    curSpine.skeleton.AnimationState:SetAnimation(trackIndex, animName, loop)
  end
end

function UIWidgetHelper.SetSpineAnimationTimeScale(curSpine, timeScale)
  if curSpine and curSpine.skeleton then
    curSpine.skeleton.timeScale = timeScale
  end
end

function UIWidgetHelper.SetAnchoredPosition(uiView, widgetName, x, y)
  local obj = uiView:GetUIComponent("RectTransform", widgetName)
  obj.anchoredPosition = Vector2(x, y)
end

function UIWidgetHelper.SetObjGroupShow(objTable, showIndex)
  for _, v in pairs(objTable) do
    for __, vv in pairs(v) do
      vv:SetActive(false)
    end
  end
  if showIndex and objTable[showIndex] then
    for __, vv in pairs(objTable[showIndex]) do
      vv:SetActive(true)
    end
  end
end

function UIWidgetHelper.GetObjGroupByWidgetName(uiView, widgetNameGroup, objTable)
  local tb = UIWidgetHelper.GetObjGroupByFunc(widgetNameGroup, objTable, function(w)
    return uiView:GetGameObject(w)
  end)
  return tb
end

function UIWidgetHelper.GetObjGroupByTransformFind(uiTrans, widgetNameGroup, objTable)
  local tb = UIWidgetHelper.GetObjGroupByFunc(widgetNameGroup, objTable, function(w)
    local trans = uiTrans:Find(w)
    return trans and trans.gameObject
  end)
  return tb
end

function UIWidgetHelper.GetObjGroupByFunc(widgetNameGroup, objTable, func)
  if objTable ~= nil then
    return objTable
  end
  local tb = {}
  if func then
    for k, v in pairs(widgetNameGroup) do
      local t = {}
      for _, _v in pairs(v) do
        if not string.isnullorempty(_v) then
          table.insert(t, func(_v))
        end
      end
      tb[k] = t
    end
  end
  return tb
end

function UIWidgetHelper.SetItemIcon(uiView, itemId, widgetIcon)
  local cfg = Cfg.cfg_item[itemId]
  if not cfg then
    return
  end
  if not string.isnullorempty(widgetIcon) then
    local url = cfg.Icon
    UIWidgetHelper.SetRawImage(uiView, widgetIcon, url)
  end
end

function UIWidgetHelper.SetItemIconSprite(uiView, itemId, widgetIcon)
  local cfg = Cfg.cfg_top_tips[itemId]
  local spriteName = cfg and cfg.Icon
  if spriteName then
    UIWidgetHelper.SetImageSprite(uiView, widgetIcon, "UICommon.spriteatlas", spriteName)
  end
end

function UIWidgetHelper.SetItemIcon_AdjHead(uiView, itemId, widgetIcon, defaultSizeDelta)
  local iconRect = uiView:GetUIComponent("RectTransform", widgetIcon)
  local isHead = 3750000 <= itemId and itemId <= 3759999
  local whRate = 1
  if isHead then
    if 3751000 <= itemId and itemId <= 3751999 then
      whRate = 0.8421052631578947
    elseif 3752000 <= itemId and itemId <= 3752999 then
      whRate = 0.6388888888888888
    elseif 3753000 <= itemId and itemId <= 3753999 then
      whRate = 0.6388888888888888
    end
  end
  local x = defaultSizeDelta.x
  local y = isHead and whRate ~= 1 and defaultSizeDelta.x * whRate or defaultSizeDelta.y
  iconRect.sizeDelta = Vector2(x, y)
end

function UIWidgetHelper.SetItemIconColor(uiView, itemId, widgetBg, atlasName, spriteNameRoot)
  local cfg = Cfg.cfg_item[itemId]
  if not cfg then
    return
  end
  if not string.isnullorempty(widgetBg) then
    local spriteName = spriteNameRoot .. cfg.Color
    UIWidgetHelper.SetImageSprite(uiView, widgetBg, atlasName, spriteName)
  end
end

function UIWidgetHelper.SetItemCount(uiView, itemId, widgetCount, formatCountFunc)
  local cfg = Cfg.cfg_item[itemId]
  if not cfg then
    return
  end
  if not string.isnullorempty(widgetCount) then
    local itemModule = GameGlobal.GetModule(ItemModule)
    local count = itemModule:GetItemCount(itemId)
    local strCount = formatCountFunc and formatCountFunc(count) or count
    UIWidgetHelper.SetLocalizationText(uiView, widgetCount, strCount)
  end
end

function UIWidgetHelper.SetItemText(uiView, itemId, widgetName, widgetIntro, widgetRpIntro)
  local cfg = Cfg.cfg_item[itemId]
  if not cfg then
    return
  end
  if not string.isnullorempty(widgetName) then
    local str = StringTable.Get(cfg.Name)
    UIWidgetHelper.SetLocalizationText(uiView, widgetName, str)
  end
  if not string.isnullorempty(widgetIntro) then
    local str = StringTable.Get(cfg.Intro)
    UIWidgetHelper.SetLocalizationText(uiView, widgetIntro, str)
  end
  if not string.isnullorempty(widgetRpIntro) then
    local str = StringTable.Get(cfg.RpIntro)
    UIWidgetHelper.SetLocalizationText(uiView, widgetRpIntro, str)
  end
end

function UIWidgetHelper.SetNewAndReds(uiView, new, red, widgetNew, widgetRed, widgetRedCount, widgetRedCountText)
  if type(new) == "boolean" then
    new = new and 1 or 0
  end
  if type(red) == "boolean" then
    red = red and 1 or 0
  end
  new = new or 0
  red = red or 0
  local widgetNames = {}
  widgetNames[0] = {}
  widgetNames[1] = {widgetNew}
  widgetNames[2] = {widgetRed}
  widgetNames[3] = {widgetRedCount}
  local objs = UIWidgetHelper.GetObjGroupByWidgetName(uiView, widgetNames)
  local state = 0
  if 0 < new then
    state = 1
  elseif 1 < red then
    if not string.isnullorempty(widgetRedCount) and not string.isnullorempty(widgetRedCountText) then
      state = 3
    else
      state = 2
    end
  elseif red == 1 then
    if not string.isnullorempty(widgetRed) then
      state = 2
    else
      state = 3
    end
  else
    state = 0
  end
  UIWidgetHelper.SetObjGroupShow(objs, state)
  if state == 3 then
    UIWidgetHelper.SetLocalizationText(uiView, widgetRedCountText, red)
  end
end

function UIWidgetHelper.SetAwardItemTips(uiView, widgetName, matid, pos, showPet)
  local petModule = GameGlobal.GetModule(PetModule)
  if petModule:IsPetSkinID(matid) then
    local skinId = petModule:GetSkinIDFromItemID(matid)
    GameGlobal.UIStateManager():ShowDialog("UIPetSkinsMainController", PetSkinUiOpenType.PSUOT_TIPS, skinId)
    return
  end
  if showPet and petModule:IsPetID(matid) then
    GameGlobal.UIStateManager():ShowDialog("UIShopPetDetailController", matid)
    return
  end
  local obj = UIWidgetHelper.SpawnObject(uiView, widgetName, "UISelectInfo")
  obj:SetData(matid, pos)
  return obj
end

function UIWidgetHelper.SetActivityCommonTips(uiView, widgetName, className, prefabName, pos, argsTable)
  local class = "UIActivityCommonTips"
  local prefab = "UIActivity_Common_Tips.prefab"
  local obj = UIWidgetHelper.SpawnObject(uiView, widgetName, class, prefab)
  obj:SetData(className, prefabName, pos, argsTable)
end

function UIWidgetHelper.PlayAnimation(uiView, widgetName, animName, duration, callback, doNotLock)
  local anim = uiView:GetUIComponent("Animation", widgetName)
  local lockName = "UIWidgetHelper_PlayAnimation_" .. animName
  if not doNotLock then
    GameGlobal.UIStateManager():Lock(lockName)
  end
  anim:Play(animName)
  TaskManager:GetInstance():StartTask(function(TT)
    YIELD(TT, duration)
    if not doNotLock then
      GameGlobal.UIStateManager():UnLock(lockName)
    end
    if uiView.view and callback then
      callback()
    end
  end)
end

function UIWidgetHelper.PlayAnimations(uiView, widgetName, animInfos)
  local anim = uiView:GetUIComponent("Animation", widgetName)
  local lockName = "UIWidgetHelper_PlayAnimations_" .. widgetName
  GameGlobal.UIStateManager():Lock(lockName)
  TaskManager:GetInstance():StartTask(function(TT)
    for _, v in ipairs(animInfos) do
      if anim and not string.isnullorempty(v.animName) then
        anim:Play(v.animName)
      end
      if v.duration and v.duration > 0 then
        YIELD(TT, v.duration)
      end
      if uiView.view and v.callback then
        v.callback()
      end
    end
  end)
  GameGlobal.UIStateManager():UnLock(lockName)
end

function UIWidgetHelper.PlayAnimationInSequence(uiView, widgetName, hideWidget, animName, delay, duration, callback, doNotLock)
  local anim = uiView:GetUIComponent("Animation", widgetName)
  if not anim then
    Log.exception("UIWidgetHelper.PlayAnimationInSequence() anim = nil")
  end
  local hideObj = not string.isnullorempty(hideWidget) and uiView:GetGameObject(hideWidget) or nil
  local lockName = "UIWidgetHelper_PlayAnimationInSequence_" .. animName .. delay
  if not doNotLock then
    GameGlobal.UIStateManager():Lock(lockName)
  end
  if hideObj then
    hideObj:SetActive(false)
  end
  TaskManager:GetInstance():StartTask(function(TT)
    if delay and 0 < delay then
      YIELD(TT, delay)
    end
    if not uiView.view then
      if not doNotLock then
        GameGlobal.UIStateManager():UnLock(lockName)
      end
      return
    end
    if hideObj then
      hideObj:SetActive(true)
    end
    if anim then
      anim:Play(animName)
    end
    if duration and 0 < duration then
      YIELD(TT, duration)
    end
    if not doNotLock then
      GameGlobal.UIStateManager():UnLock(lockName)
    end
    if uiView.view and callback then
      callback()
    end
  end)
end

function UIWidgetHelper.BlurHelperShot(uiView, widgetName, controllerName, callback)
  local shot = uiView:GetUIComponent("H3DUIBlurHelper", widgetName)
  shot.gameObject:SetActive(true)
  shot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(controllerName)
  local rt = shot:RefreshBlurTexture()
  local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
  cache_rt.format = UnityEngine.RenderTextureFormat.RGB111110Float
  GameGlobal.TaskManager():StartTask(function(TT)
    YIELD(TT)
    if not uiView.view then
      return
    end
    UnityEngine.Graphics.Blit(rt, cache_rt)
    callback(cache_rt)
  end)
end
