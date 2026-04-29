_class("DynamicCG", Object)
DynamicCG = DynamicCG
local DynamicCGType = {
  Spine = 1,
  Live2D = 2,
  None = 3
}
_enum("DynamicCGType", DynamicCGType)
local Live2DSize = {
  l2d_1602111 = 0.6,
  l2d_1602112 = 2.2,
  l2d_1602121 = 0.6,
  l2d_1602122 = 0.6,
  l2d_1502132 = 0.6,
  l2d_1602113 = 0.6,
  l2d_1500563 = 0.65,
  l2d_1501573 = 1,
  l2d_1601563 = 0.65
}
local live2DRTSize = {
  l2d_1602162 = {4096, 4096},
  l2d_1601482 = {4096, 4096}
}

function DynamicCG.ReplaceL2D(l2dResName, force)
  if not APPVER1250 or force then
    local name = string.split(l2dResName, "_")
    if name[1] == "l2d" then
      return name[2] .. "_spine_idle"
    end
  end
  return l2dResName
end

function DynamicCG.SyncLoad(resName, loaderCmpt, gameObject)
  local dynCGType = DynamicCGType.Spine
  if string.startwith(resName, "l2d_") then
    dynCGType = DynamicCGType.Live2D
    if not APPVER1250 then
      local replaceSpine = DynamicCG.ReplaceL2D(resName)
      if replaceSpine then
        resName = replaceSpine
        dynCGType = DynamicCGType.Spine
      else
        Log.fatal("不支持l2d版本的客户端，找不到l2d对应的spine代替资源", resName)
        return DynamicCGHandle:New(resName, DynamicCGType.None, loaderCmpt, gameObject)
      end
    end
  end
  local loader = loaderCmpt
  if loader and (not (dynCGType ~= DynamicCGType.Spine or typeof(SpineLoader):IsInstanceOfType(loader)) or APPVER1250 and dynCGType == DynamicCGType.Live2D and not typeof(Live2DLoader):IsInstanceOfType(loader)) and not gameObject then
    gameObject = loader.gameObject
    loader = nil
  end
  if loader then
    local dcgHandle = DynamicCGHandle:New(resName, dynCGType, loader, nil)
    dcgHandle:LoadSync()
    return dcgHandle
  elseif not gameObject then
    Log.fatal("[DynamicCG] Load error, gameObject is nil and loader is nil!")
    return
  else
    local loaderGO = gameObject
    loaderGO = UnityEngine.GameObject:New(resName)
    loaderGO.transform:SetParent(gameObject.transform, false)
    loaderGO:AddComponent(typeof(UnityEngine.RectTransform)).sizeDelta = Vector2(2048, 2048)
    if dynCGType == DynamicCGType.Spine then
      loader = loaderGO:AddComponent(typeof(SpineLoader))
    else
      loader = loaderGO:AddComponent(typeof(Live2DLoader))
    end
    local dcgHandle = DynamicCGHandle:New(resName, dynCGType, loader, loaderGO)
    dcgHandle:LoadSync()
    return dcgHandle
  end
end

function DynamicCG.AsyncLoad(TT, resName, loaderCmpt, gameObject)
  local dynCGType = DynamicCGType.Spine
  if string.startwith(resName, "l2d_") then
    dynCGType = DynamicCGType.Live2D
    if not APPVER1250 then
      local replaceSpine = DynamicCG.ReplaceL2D(resName)
      if replaceSpine then
        resName = replaceSpine
        dynCGType = DynamicCGType.Spine
      else
        Log.fatal("不支持l2d版本的客户端，找不到l2d对应的spine代替资源", resName)
        return DynamicCGHandle:New(resName, DynamicCGType.None, loaderCmpt, gameObject)
      end
    end
  end
  local loader = loaderCmpt
  if loader and (not (dynCGType ~= DynamicCGType.Spine or typeof(SpineLoader):IsInstanceOfType(loader)) or APPVER1250 and dynCGType == DynamicCGType.Live2D and not typeof(Live2DLoader):IsInstanceOfType(loader)) and not gameObject then
    gameObject = loader.gameObject
    loader = nil
  end
  if loader then
    local dcgHandle = DynamicCGHandle:New(resName, dynCGType, loader, true)
    dcgHandle:LoadAsync(TT)
    return dcgHandle
  elseif not gameObject then
    Log.fatal("[DynamicCG] Load error, gameObject is nil and loader is nil!")
    return
  else
    local loaderGO = gameObject
    loaderGO = UnityEngine.GameObject:New(resName)
    loaderGO.transform:SetParent(gameObject.transform, false)
    loaderGO:AddComponent(typeof(UnityEngine.RectTransform)).sizeDelta = Vector2(2048, 2048)
    if dynCGType == DynamicCGType.Spine then
      loader = loaderGO:AddComponent(typeof(SpineLoader))
    else
      loader = loaderGO:AddComponent(typeof(Live2DLoader))
    end
    local dcgHandle = DynamicCGHandle:New(resName, dynCGType, loader, loaderGO)
    dcgHandle:LoadAsync(TT)
    return dcgHandle
  end
end

function DynamicCG.ProcessLive2DCamSize(resName, loader)
  local camSize = Live2DSize[resName]
  camSize = camSize or 0.5
  loader.RTCam.orthographicSize = camSize
end

_class("DynamicCGHandle", Object)
DynamicCGHandle = DynamicCGHandle

function DynamicCGHandle:Constructor(resName, dynamicCGType, loader, gameObject)
  self._resName = resName
  self._dynamicCGType = dynamicCGType
  self._loader = {}
  self._loader[dynamicCGType] = loader
  self._gameObject = gameObject
  if not gameObject and loader then
    self._gameObject = loader.gameObject
  end
  DynamicCGHandle.Instance = self
end

function DynamicCGHandle:LoadSync()
  local dynCGType = self._dynamicCGType
  if dynCGType == DynamicCGType.Spine then
    self._loader[dynCGType]:LoadSpine(self._resName)
  elseif dynCGType == DynamicCGType.Live2D then
    self._loader[dynCGType]:LoadLive2D(self._resName)
    self:OnLoadLive2D()
  end
end

function DynamicCGHandle:LoadAsync(TT)
  local id = GetCurTaskId()
  local sameFrame = true
  local loaded = false
  local dynCGType = self._dynamicCGType
  if dynCGType == DynamicCGType.Spine then
    self._loader[dynCGType]:AsyncLoadSpine(self._resName, function()
      loaded = true
      if not sameFrame then
        RESUME(TT, id)
      end
    end)
    sameFrame = false
    if not loaded then
      SUSPEND(TT)
    end
  elseif dynCGType == DynamicCGType.Live2D then
    self._loader[dynCGType]:AsyncLoadLive2D(self._resName, function()
      loaded = true
      self:OnLoadLive2D()
      if not sameFrame then
        RESUME(TT, id)
      end
    end)
    sameFrame = false
    if not loaded then
      SUSPEND(TT)
    end
  end
end

function DynamicCGHandle:OnLoadLive2D()
  local loader = self._loader[DynamicCGType.Live2D]
  loader:PlayAnimation("idle")
  local camSize = Live2DSize[self._resName]
  camSize = camSize or 0.5
  if loader.RTCam then
    loader.RTCam.orthographicSize = camSize
  end
  local rtSize = live2DRTSize[self._resName]
  if rtSize and loader.RTCam then
    local rt = loader.RTCam.targetTexture
    if rt.width ~= rtSize[1] or rt.height ~= rtSize[2] then
      rt:Release()
      rt.width = rtSize[1]
      rt.height = rtSize[2]
      rt:Create()
    end
  end
end

function DynamicCGHandle.GetOrAddComponent(gameObject, classType)
  local cmpt = gameObject:GetComponent(typeof(classType))
  cmpt = cmpt or gameObject:AddComponent(typeof(classType))
  return cmpt
end

function DynamicCGHandle:ChangeDynamicCG(resName, keepLive2DUIRenderEnv)
  self._resName = resName
  local dynCGType = DynamicCGType.Spine
  if string.startwith(resName, "l2d_") then
    dynCGType = DynamicCGType.Live2D
    if not APPVER1250 then
      local replaceSpine = DynamicCG.ReplaceL2D(resName)
      if replaceSpine then
        resName = replaceSpine
        self._resName = resName
        dynCGType = DynamicCGType.Spine
      else
        Log.fatal("不支持l2d版本的客户端，找不到l2d对应的spine代替资源", resName)
        self._dynamicCGType = DynamicCGType.None
        return
      end
    end
  end
  if dynCGType ~= self._dynamicCGType then
    if dynCGType == DynamicCGType.Spine then
      if self._loader[self._dynamicCGType] then
        self._loader[self._dynamicCGType]:DestroyCurrentLive2D(not keepLive2DUIRenderEnv)
      end
      self._gameObject = self._gameObject.transform.parent.gameObject
      self._loader[dynCGType] = DynamicCGHandle.GetOrAddComponent(self._gameObject, SpineLoader)
    else
      if self._loader[self._dynamicCGType] then
        self._loader[self._dynamicCGType]:DestroyCurrentSpine()
      end
      if not self._loader[dynCGType] then
        local live2dLoaderGO = UnityEngine.GameObject:New(resName)
        live2dLoaderGO.transform:SetParent(self._gameObject.transform, false)
        live2dLoaderGO:AddComponent(typeof(UnityEngine.RectTransform)).sizeDelta = Vector2(2048, 2048)
        self._gameObject = live2dLoaderGO
        self._loader[dynCGType] = live2dLoaderGO:AddComponent(typeof(Live2DLoader))
      else
        self._gameObject = self._loader[dynCGType].gameObject
      end
    end
  end
  self._dynamicCGType = dynCGType
end

function DynamicCGHandle:ChangeDynamicCGSync(resName, keepLive2DUIRenderEnv)
  if resName == self._resName then
    return
  end
  self:ChangeDynamicCG(resName, keepLive2DUIRenderEnv)
  self:LoadSync()
end

function DynamicCGHandle:ChangeDynamicCGAsync(TT, resName, keepLive2DUIRenderEnv)
  if resName == self._resName then
    return
  end
  self:ChangeDynamicCG(resName, keepLive2DUIRenderEnv)
  self:LoadAsync(TT)
end

function DynamicCGHandle:DestroyCurrentCG(keepLive2DUIRenderEnv)
  local dynamicCGType = self._dynamicCGType
  if dynamicCGType == DynamicCGType.Spine then
    self._loader[dynamicCGType]:DestroyCurrentSpine()
  elseif dynamicCGType == DynamicCGType.Live2D then
    self._loader[dynamicCGType]:DestroyCurrentLive2D(not keepLive2DUIRenderEnv)
  end
  self._resName = nil
end

function DynamicCGHandle:Release()
  local dynamicCGType = self._dynamicCGType
  if dynamicCGType == DynamicCGType.Spine then
    self._loader[dynamicCGType]:DestroyCurrentSpine()
  elseif dynamicCGType == DynamicCGType.Live2D then
    self._loader[dynamicCGType]:DestroyCurrentLive2D(true)
    UnityEngine.Object.Destroy(self._gameObject)
  end
  self._gameObject = nil
  self._loader = nil
end

function DynamicCGHandle:SetAnimMixTime(mixTime)
  if self._dynamicCGType == DynamicCGType.Spine then
    self._loader[self._dynamicCGType].AnimationState.Data.DefaultMix = mixTime
  else
  end
end

function DynamicCGHandle:InitializeSpine()
  local dynamicCGType = self._dynamicCGType
  if dynamicCGType == DynamicCGType.Spine then
    local spineSke = self._loader[dynamicCGType].CurrentSkeleton
    spineSke = spineSke or self._loader[dynamicCGType].CurrentMultiSkeleton
    if spineSke then
      spineSke:Initialize(true)
    else
      Log.fatal("[DynamicCG] InitializeSpine while spineSke is nil")
    end
  elseif dynamicCGType == DynamicCGType.Live2D then
    self._loader[dynamicCGType]:DestroyCurrentLive2D(false)
    self._loader[dynamicCGType]:LoadLive2D(self._resName)
  end
end

function DynamicCGHandle:SetStartAnimation(animName)
  local dynamicCGType = self._dynamicCGType
  if dynamicCGType == DynamicCGType.Spine then
    local spineSke = self._loader[dynamicCGType].CurrentSkeleton
    spineSke = spineSke or self._loader[dynamicCGType].CurrentMultiSkeleton
    if spineSke then
      spineSke.startingAnimation = animName
    else
      Log.fatal("[DynamicCG] SetStartAnimation while spineSke is nil")
    end
  elseif dynamicCGType == DynamicCGType.Live2D then
    self._loader[dynamicCGType].StartAnimation = animName
  end
end

function DynamicCGHandle:SetAnimation(trackOrLayerID, animName, loop)
  local dynamicCGType = self._dynamicCGType
  if dynamicCGType == DynamicCGType.Spine then
    local spineSke = self._loader[dynamicCGType].CurrentSkeleton
    spineSke = spineSke or self._loader[dynamicCGType].CurrentMultiSkeleton
    if spineSke then
      spineSke.AnimationState:SetAnimation(trackOrLayerID, animName, loop)
    else
      Log.fatal("[DynamicCG] SetAnimation while spineSke is nil")
    end
  elseif dynamicCGType == DynamicCGType.Live2D then
    self._loader[dynamicCGType]:PlayAnimation(animName, trackOrLayerID, 3, loop)
  end
end

function DynamicCGHandle:SetAnimationWithTrackEntryReturn(trackOrLayerID, animName, loop)
  local dynamicCGType = self._dynamicCGType
  if dynamicCGType == DynamicCGType.Spine then
    local spineSke = self._loader[dynamicCGType].CurrentSkeleton
    spineSke = spineSke or self._loader[dynamicCGType].CurrentMultiSkeleton
    if spineSke then
      return spineSke.AnimationState:SetAnimation(trackOrLayerID, animName, loop)
    else
      Log.fatal("[DynamicCG] SetAnimationWithTrackEntryReturn while spineSke is nil")
    end
  elseif dynamicCGType == DynamicCGType.Live2D then
    self._loader[dynamicCGType]:PlayAnimation(animName, trackOrLayerID, 3, loop)
    local cam = self._loader[dynamicCGType].RTCam
    if cam then
      local l2dTF = cam.transform:GetChild(0)
      if l2dTF then
        require("tolua.reflection")
        tolua.loadassembly("Assembly-CSharp")
        local animationListType = typeof("AnimationClipList")
        local property = tolua.getproperty(animationListType, "Animations")
        if property then
        else
          local field = tolua.getfield(animationListType, "Animations")
          if field then
            local animationClipListCmpt = l2dTF.gameObject:GetComponent(animationListType)
            local value = field:Get(animationClipListCmpt)
            field:Destroy()
            for i = 0, value.Length - 1 do
              local anim = value[i]
              if anim.name == animName then
                return anim
              end
            end
          end
        end
      end
    end
  end
end

function DynamicCGHandle:GetCurDynamicCGType()
  return self._dynamicCGType
end

function DynamicCGHandle:Update(delteTime)
  local dynamicCGType = self._dynamicCGType
  if dynamicCGType == DynamicCGType.Spine then
    local spineSke = self._loader[dynamicCGType].CurrentSkeleton
    spineSke = spineSke or self._loader[dynamicCGType].CurrentMultiSkeleton
    if spineSke then
      spineSke:Update(delteTime)
    else
      Log.fatal("[DynamicCG] Update while spineSke is nil")
    end
  elseif dynamicCGType == DynamicCGType.Live2D then
  end
end

function DynamicCGHandle:SetColor(color)
  local dynamicCGType = self._dynamicCGType
  if dynamicCGType == DynamicCGType.Spine then
    local spineSke = self._loader[dynamicCGType].CurrentSkeleton
    if spineSke then
      spineSke.color = color
    else
      spineSke = self._loader[dynamicCGType].CurrentMultiSkeleton
      if spineSke then
        local skeleton = spineSke.Skeleton
        skeleton.R = color.r
        skeleton.G = color.g
        skeleton.B = color.b
        skeleton.A = color.a
      else
        Log.fatal("[DynamicCG] SetColor while spineSke is nil")
      end
    end
  elseif dynamicCGType == DynamicCGType.Live2D then
    self._loader[self._dynamicCGType]:SetColor(color)
  end
end

function DynamicCGHandle:SetAlpha(alpha)
  local dynamicCGType = self._dynamicCGType
  if dynamicCGType == DynamicCGType.Spine then
    local spineSke = self._loader[dynamicCGType].CurrentSkeleton
    if spineSke then
      local color = spineSke.color
      color.a = alpha
      spineSke.color = color
    else
      spineSke = self._loader[dynamicCGType].CurrentMultiSkeleton
      if spineSke then
        local skeleton = spineSke.Skeleton
        skeleton.A = alpha
      else
        Log.fatal("[DynamicCG] SetAlpha while spineSke is nil")
      end
    end
  elseif dynamicCGType == DynamicCGType.Live2D then
    self._loader[dynamicCGType]:SetOpacity(alpha)
  end
end

function DynamicCGHandle:SetMatFloat(param, value)
  local dynamicCGType = self._dynamicCGType
  if dynamicCGType == DynamicCGType.Spine then
    local spineSke = self._loader[dynamicCGType].CurrentSkeleton
    if spineSke then
      spineSke.material = UnityEngine.Material:New(spineSke.material)
      spineSke.material:SetFloat(param, value)
    else
      spineSke = self._loader[dynamicCGType].CurrentMultiSkeleton
      if spineSke then
        spineSke.UseInstanceMaterials = true
        spineSke:UpdateMesh()
        local renderers = spineSke.canvasRenderers
        for i = 0, renderers.Count - 1 do
          local tmp = renderers[i]
          local tmpMat = tmp:GetMaterial(0)
          if tmpMat then
            tmpMat:SetFloat(param, value)
          end
        end
      else
        Log.fatal("[DynamicCG] SetMatFloat while spineSke is nil")
      end
    end
  elseif dynamicCGType == DynamicCGType.Live2D then
  end
end
