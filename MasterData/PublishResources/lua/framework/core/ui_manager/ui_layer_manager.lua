_class("UILayerManager", GameEventListener)
local MAX_DEPTH = 8

function UILayerManager:Constructor(resRequest, uiControllerManager)
  self.topDepth = 0
  self.layerManagerHelper = UILayerManagerHelper:New(MAX_DEPTH, resRequest)
  self.uiControllerManager = uiControllerManager
  self.lastBlurMaskDepth = 0
  self.lastBlurControllerName = nil
  self.depthCameraList = {}
  self.uiRootObj = resRequest.Obj
  for i = 0, MAX_DEPTH - 1 do
    local name = "depth_" .. i
    local depth_trans = self.uiRootObj.transform:Find("UICameras/" .. name)
    if depth_trans then
      self.depthCameraList[i] = {}
      self.depthCameraList[i].root_obj = depth_trans.gameObject
      self.depthCameraList[i].camera_obj = depth_trans:Find("Camera").gameObject
      self.depthCameraList[i].back_obj = depth_trans:Find("BG_Camera").gameObject
    end
  end
  GameGlobal.EventDispatcher():AddListener(GameEventType.UpdateLayerTopDepth, self)
  GameGlobal.EventDispatcher():AddListener(GameEventType.AfterUILayerChanged, self)
end

function UILayerManager:Dispose()
  GameGlobal.EventDispatcher():RemoveListener(GameEventType.UpdateLayerTopDepth, self.listenerID)
  GameGlobal.EventDispatcher():RemoveListener(GameEventType.AfterUILayerChanged, self.listenerID)
  self.layerManagerHelper:Dispose()
  self.lastBlurMaskDepth = 0
  self.lastBlurControllerName = nil
end

function UILayerManager:SetInVisibleParent(view, uiName)
  self.layerManagerHelper:SetInVisibleParent(view, uiName)
end

function UILayerManager:SetMessageBoxParent(view, uiName)
  self.layerManagerHelper:SetMessageBoxParent(view, uiName)
end

function UILayerManager:SetGuideMessageBoxParent(view, uiName)
  self.layerManagerHelper:SetGuideMessageBoxParent(view, uiName)
end

function UILayerManager:GetMessageBoxCamera()
  return self.layerManagerHelper:GetMessageBoxCamera()
end

function UILayerManager:SetTopParent(view, uiName)
  self.layerManagerHelper:SetTopParent(view, uiName)
end

function UILayerManager:SetHighParent(view, uiName)
  self.layerManagerHelper:SetHighParent(view, uiName)
end

function UILayerManager:ShowLayer(depth, flag)
  self.layerManagerHelper:ShowLayer(depth, flag)
end

function UILayerManager:ShowAllLayers()
  for i = 0, MAX_DEPTH - 1 do
    self.layerManagerHelper:ShowLayer(i, true)
  end
end

function UILayerManager:OnShowUI(uiController, depth)
  if not uiController then
    Log.fatal("[UI] UILayerManager:OnShowUI Error uiController is Null")
    return
  end
  Log.debug("[UI] UILayerManager:OnShowUI,", uiController:GetName())
  depth = depth or -1
  if depth == 0 then
    self:ChangeUIDepth(uiController, 0)
  else
    local newTopDepth = self.topDepth + 1
    self:ChangeUIDepth(uiController, newTopDepth)
    self:SetTopDepth(newTopDepth)
  end
end

function UILayerManager:GetLowestShowingBGCamera()
  for i = 0, table.count(self.depthCameraList) - 1 do
    local bgcamera = self.depthCameraList[i].back_obj:GetComponent("Camera")
    if self.depthCameraList[i].root_obj.activeSelf and bgcamera.enabled then
      return bgcamera
    end
  end
  return nil
end

function UILayerManager:ChangeUIDepth(uiController, newDepth, needChangeRootActive)
  if needChangeRootActive then
    local oldLayerRoot = self:GetUIRootByDepth(uiController:GetDepth())
    local newLayerRoot = self:GetUIRootByDepth(newDepth)
    newLayerRoot:SetActive(oldLayerRoot.activeSelf)
    oldLayerRoot:SetActive(true)
  end
  uiController:SetDepth(newDepth)
  self.layerManagerHelper:ChangeUIDepth(uiController:View(), uiController:GetName(), uiController:GetMaskType(), uiController:GetDepth())
end

function UILayerManager:IsLayerShow(depth)
  return self.layerManagerHelper:IsLayerShow(depth)
end

function UILayerManager:SetVisibleParent(view, uiName)
  self.layerManagerHelper:SetVisibleParent(view, uiName)
end

function UILayerManager:SetParentOfMsgBox()
end

function UILayerManager:IsFull()
  return self.topDepth >= MAX_DEPTH - 1
end

function UILayerManager:IsTopUI(depth)
  return self.topDepth == depth
end

function UILayerManager:TopDepth()
  return self.topDepth
end

function UILayerManager:SetTopDepth(newTopDepth)
  if newTopDepth < 0 or newTopDepth > MAX_DEPTH then
    Log.fatal("[UI] UILayerManager Set TopDepth Error, value=", newTopDepth, Log.traceback())
    return
  end
  self.topDepth = newTopDepth
  self.layerManagerHelper:SetTopDepth(self.topDepth)
  self:ResetLowBGCameraClearFlag()
end

function UILayerManager:ResetLowBGCameraClearFlag()
  local lowestBGCamera = self:GetLowestShowingBGCamera()
  if lowestBGCamera then
    lowestBGCamera.clearFlags = UnityEngine.CameraClearFlags.Depth
  end
end

function UILayerManager:GetUICameraByDepth(depth)
  if depth < 0 then
    return self.depthCameraList[0].camera_obj:GetComponent("Camera")
  elseif depth < table.count(self.depthCameraList) then
    return self.depthCameraList[depth].camera_obj:GetComponent("Camera")
  end
  return nil
end

function UILayerManager:ResetAllUIRoot()
  for i = 1, MAX_DEPTH do
    local root = self:GetUIRootByDepth(i - 1)
    root:SetActive(true)
  end
end

function UILayerManager:GetUIRootByDepth(depth)
  if depth < 0 then
    return self.depthCameraList[0].root_obj
  elseif depth < table.count(self.depthCameraList) then
    return self.depthCameraList[depth].root_obj
  end
  return nil
end

function UILayerManager:OnGameEvent(gameEventType, ...)
  if gameEventType == GameEventType.UpdateLayerTopDepth then
    local depth = self.topDepth
    local length = select("#", ...)
    if 0 < length then
      local v = select(1, ...)
      if v and type(v) == "number" then
        depth = depth + v
      else
        Log.fatal("[UI] UILayerManager:OnGameEvent parameters error")
      end
    else
      depth = 0
    end
    self:SetTopDepth(depth)
    self:CheckUpdateBlurMask()
  elseif gameEventType == GameEventType.AfterUILayerChanged then
    self:CheckUpdateBlurMask()
  end
end

function UILayerManager:CheckUpdateBlurMask()
  local blurMaskLayer, blurControllorName = 0
  local visibleUIList = self.uiControllerManager:VisibleUIList()
  for i = 1, visibleUIList:Size() do
    local name = visibleUIList:GetAt(i)
    local uiRegisterInfo = self.uiControllerManager:GetUIRegisterInfo(name)
    if uiRegisterInfo and uiRegisterInfo.maskType == MaskType.MT_BlurMask then
      local uiController = self.uiControllerManager:GetController(name)
      local depth = uiController:GetDepth()
      if uiController and blurMaskLayer < depth then
        blurMaskLayer = depth
        blurControllorName = uiController:GetName()
      end
    end
  end
  if blurMaskLayer == self.lastBlurMaskDepth and blurControllorName == self.lastBlurControllerName then
    Log.debug("[UI] UILayerManager模糊层级未发生变化 return, blurMaskLayer=", blurMaskLayer, ",self.lastBlurMaskDepth=", self.lastBlurMaskDepth)
    return
  end
  Log.debug("[UI] UILayerManager刷新模糊,", self.lastBlurMaskDepth, ",", self.lastBlurControllerName, " => ", blurMaskLayer, ",", blurControllorName)
  self.lastBlurMaskDepth = blurMaskLayer
  self.lastBlurControllerName = blurControllorName
  self.layerManagerHelper:RefreshBlurMask(blurMaskLayer)
  self:ResetLowBGCameraClearFlag()
end
