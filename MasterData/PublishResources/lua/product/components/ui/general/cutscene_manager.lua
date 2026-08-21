_class("CutsceneManager", Singleton)
CutsceneManager = CutsceneManager

function CutsceneManager:Init(uiRootGameObject)
  self._cutsceneRoot = uiRootGameObject.transform:Find("UICameras/depth_high/UI/CutSceneCanvas").gameObject
  self._highDepthCamera = uiRootGameObject.transform:Find("UICameras/depth_high/Camera"):GetComponent(typeof(UnityEngine.Camera))
  self._cutsceneList = {}
  self._cutsceneConfig = CutSceneConfig:New()
  self._config = nil
  self._flag = true
end

function CutsceneManager:Dispose()
  self._cutsceneRoot = nil
  for _, value in pairs(self._cutsceneList) do
    UIHelper.DestroyGameObject(value)
  end
  self._cutsceneList = nil
  self._cutsceneConfig = nil
  self._config = nil
  CutsceneManager.super.Dispose(self)
end

function CutsceneManager.ExcuteCutsceneIn_Shot()
  local self = CutsceneManager:GetInstance()
  local commonRedName = "UICutSceneCommon.prefab"
  local lockKey = "Cutscene_Common_Lock"
  if not self._cutsceneList[commonRedName] then
    self._cutsceneList[commonRedName] = UIHelper.GetGameObject(commonRedName)
  end
  local go = self._cutsceneList[commonRedName]
  go.transform:SetParent(self._cutsceneRoot.transform, false)
  go:SetActive(false)
  local raw = go:GetComponentInChildren(typeof(UnityEngine.UI.RawImage))
  raw.color = Color(1, 1, 1, 1)
  local mat = raw.material
  mat:SetFloat("_AlphaScale", 1)
  local shot = go:GetComponentInChildren(typeof(H3DUIBlurHelper))
  local rectTransform = shot:GetComponent("RectTransform")
  local w = rectTransform.rect.size.x
  local h = rectTransform.rect.size.y
  shot:CleanRenderTexture()
  shot.width = w
  shot.height = h
  shot.blurTimes = 0
  local camera = self._highDepthCamera
  if camera then
    shot.UseAllCamerasCapture = false
    shot.UseOwnerCamera = false
    shot.OwnerCamera = camera
  else
    shot.UseAllCamerasCapture = true
  end
  shot:RefreshBlurTexture()
  go:SetActive(true)
  GameGlobal.UIStateManager():Lock(lockKey)
end

function CutsceneManager.ExcuteCutsceneOut_Shot()
  local self = CutsceneManager:GetInstance()
  local commonRedName = "UICutSceneCommon.prefab"
  local lockKey = "Cutscene_Common_Lock"
  if not self._cutsceneList then
    return
  end
  if not self._cutsceneList[commonRedName] then
    return
  end
  local go = self._cutsceneList[commonRedName]
  local shot = go:GetComponentInChildren(typeof(H3DUIBlurHelper))
  local raw = go:GetComponentInChildren(typeof(UnityEngine.UI.RawImage))
  local mat = raw.material
  local animTime = 0.5
  mat:DOFloat(0, "_AlphaScale", animTime):OnComplete(function()
    if shot then
      shot:CleanRenderTexture()
    end
    if self._cutsceneRoot then
      UIHelper.DestroyGameObject(go)
      self._cutsceneList[commonRedName] = nil
    end
    GameGlobal.UIStateManager():UnLock(lockKey)
  end)
end

function CutsceneManager.ExcuteCutsceneIn(uiStateType, callBack, noLock)
  local self = CutsceneManager:GetInstance()
  self._flag = false
  if self._config then
    Log.error("[CutsceneManager] cutscene is running : " .. self._config.ResName)
  end
  self._config = self._cutsceneConfig.config[uiStateType]
  if self._config then
    Log.info("[CutsceneManager] ExcuteCutsceneIn : " .. self._config.ResName)
  end
  if not self._config and callBack then
    callBack()
  else
    local destoryDelayOutCfg = self._config.OnlyEnter and self._config.DestoryDelayOut or 0
    local callbackDelay = self._config.CallBackDelayIn and self._config.CallBackDelayIn or 0
    if not noLock then
      GameGlobal.UIStateManager():Lock("Cutscene" .. self._config.ResName .. "Lock")
    end
    self:_ExcuteCutscene(self._config.ResName, self._config.AnimationIn, callBack, callbackDelay, destoryDelayOutCfg)
  end
end

function CutsceneManager.ExcuteCutsceneOut(callback)
  local self = CutsceneManager:GetInstance()
  if self._config then
    GameGlobal.UIStateManager():UnLock("Cutscene" .. self._config.ResName .. "Lock")
    self:_ExcuteCutscene(self._config.ResName, self._config.AnimationOut, nil, 0, self._config.DestoryDelayOut, callback)
    self._config = nil
  end
end

function CutsceneManager:_ExcuteCutscene(resName, anim, callback, callbackDelay, destroyDelay, outCallback)
  if not self._cutsceneList[resName] then
    self._cutsceneList[resName] = UIHelper.GetGameObject(resName)
  end
  local cutsceneObj = self._cutsceneList[resName]
  if cutsceneObj == nil then
    Log.error("动效资源不存在:" .. resName)
    return
  end
  cutsceneObj.transform:SetParent(self._cutsceneRoot.transform, false)
  local animCmp = cutsceneObj:GetComponentInChildren(typeof(UnityEngine.Animation))
  if not animCmp then
    Log.error("动效资源" .. resName .. "不包含Animation组件")
  elseif anim then
    animCmp:Play(anim)
  end
  GameGlobal.Timer():AddEvent(callbackDelay, function()
    self._flag = true
  end)
  if callback then
    GameGlobal.Timer():AddEvent(callbackDelay, callback)
  end
  if 0 < destroyDelay then
    GameGlobal.Timer():AddEvent(destroyDelay, function()
      if outCallback then
        outCallback()
      end
      UIHelper.DestroyGameObject(cutsceneObj)
      self._cutsceneList[resName] = nil
    end)
  end
end

function CutsceneManager.GetSceneFlag()
  local self = CutsceneManager:GetInstance()
  return self._flag
end
