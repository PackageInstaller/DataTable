local UIManager = class("UIManager")
local cs_UIManager = CS.UIManager.Instance
local cs_ResLoader = CS.ResLoader
local cs_InputUtility = CS.InputUtility
local cs_MicaSDKManager = CS.MicaSDKManager.Instance
local cs_BattleManager = CS.BattleManager
local CS_ClientConsts = CS.ClientConsts
local CS_MessageBoxWindow = CS.GameMessage.MessageBoxWindow
local typeMessageBoxWindow = typeof(CS_MessageBoxWindow)

local function OnUpdate(self)
end

function UIManager:PlayFov(fov, endValue, duration, delay)
  self.UICamera.fieldOfView = fov
  self.UICamera:DOFieldOfView(endValue, duration):SetDelay(delay):SetEase(CS.DG.Tweening.Ease.OutCubic)
end

function UIManager:PlayDoFade(canvasGroup, alpha, endValue, duraction, func)
  canvasGroup.alpha = alpha
  local tween = canvasGroup:DOFade(endValue, duraction):SetLink(canvasGroup.gameObject)
  if func ~= nil then
    tween.onComplete = func
  end
  return tween
end

function UIManager:ctor()
  local UICanvas = cs_UIManager.UICanvas
  local UICamera = cs_UIManager.UICamera
  local UICanvasRoot = UICanvas.transform
  self.UICanvas = UICanvas
  self.UICamera = UICamera
  self.csUIManager = cs_UIManager
  self:OnScreenSizeChanged()
  self.windows = {}
  self.resloaders = {}
  self.async_loaders = {}
  self.layers = {}
  for i = 0, UICanvasRoot.childCount - 1 do
    self.layers[i] = UICanvasRoot:GetChild(i)
  end
  local referenceResolution = cs_UIManager.UICanvasScaler.referenceResolution
  self.Resolution = Vector2.New(referenceResolution.x, referenceResolution.y)
  self.__update_handle = BindCallback(self, OnUpdate)
  UpdateManager:AddUpdate(self.__update_handle)
  self.sortingLayerList = {
    "UIBottom",
    "UINormal",
    "UIMiddle",
    "UIHigh",
    "UIOverHigh",
    "UILowTop",
    "UITop",
    "UIMsg",
    "UIMax"
  }
  self.__OnScreenSizeChanged = BindCallback(self, self.OnScreenSizeChanged)
  MsgCenter:AddListener(eMsgEventId.OnScreenSizeChanged, self.__OnScreenSizeChanged)
end

function UIManager:OnScreenSizeChanged()
  self.BackgroundCullSize = cs_UIManager.BackgroundCullSize
  self.BackgroundStretchSize = cs_UIManager.BackgroundStretchSize
  self.MatchWidthOrHeight = cs_UIManager.MatchWidthOrHeight
end

function UIManager:GetScreenWidthSafe()
  local safeX = self.BackgroundStretchSize.x * (1 - cs_UIManager.CurNotchValue / 100 * 2)
  return safeX
end

function UIManager:GetMainCamera()
  return cs_UIManager.MainCam
end

function UIManager:IsMainCameraEnable()
  return cs_UIManager.IsMainCamEnable
end

function UIManager:GetUICamera()
  return cs_UIManager.UICamera
end

function UIManager:GetUIRootCanvasGroup()
  if IsNull(self._uiRootCanvasGroup) then
    self._uiRootCanvasGroup = self.UICanvas.gameObject:AddComponent(typeof(CS.UnityEngine.CanvasGroup))
  end
  return self._uiRootCanvasGroup
end

function UIManager:World2UIPosition(position, rectTransform, uiCam, mainCam)
  return cs_UIManager:World2UIPosition(position, rectTransform, uiCam, mainCam)
end

function UIManager:World2UIPositionOut(transform, rectTransform, uiCam, mainCam)
  return cs_UIManager:World2UIPositionOut(transform, rectTransform, uiCam, mainCam)
end

function UIManager:Screen2UIPosition(screenPoint, rectTransform, camera)
  return cs_UIManager:Screen2UIPosition(screenPoint, rectTransform, camera)
end

function UIManager:Screen2WorldPosition(screenPoint, rectTransform, camera)
  return cs_UIManager:Screen2WorldPosition(screenPoint, rectTransform, camera)
end

function UIManager:HideClickEffect(hide)
  cs_UIManager:HideClickEffect(hide)
end

local function InitWindowInternal(self, typeID, uiconfig, prefab, fromWhichUI)
  if IsNull(prefab) then
    self.resloaders[typeID]:Put2Pool()
    self.resloaders[typeID] = nil
    error("Can't find window's prefab, window type is " .. uiconfig.PrefabName)
    return nil
  end
  local obj = prefab:Instantiate(self.layers[uiconfig.LayoutLevel])
  obj.name = uiconfig.PrefabName
  local rectTransform = obj.transform
  rectTransform.localScale = Vector3.New(1, 1, 1)
  rectTransform:SetAsLastSibling()
  rectTransform.localPosition = Vector3.New(0, 0, 0)
  rectTransform.offsetMax = Vector2.New(0, 0)
  rectTransform.offsetMin = Vector2.New(0, 0)
  local window = uiconfig.WindowClass.New()
  self.windows[typeID] = window
  UIUtil.LuaUIBindingTable(obj, window.ui)
  window.__typeID = typeID
  window.__layerID = uiconfig.LayoutLevel
  window.__winAnima = uiconfig.AnimaType
  window.fromType = fromWhichUI
  window:Init(rectTransform)
  return window
end

local function __CheckCreateWindow(self, typeID)
  if self._inDeleteAllWindow then
    error("Cant create window while in deleting all window， typeID = " .. tostring(typeID))
    return false
  end
  return true
end

local function CreateWindowInternal(self, typeID, isAsync, replaceTypeId, fromWhichUI)
  if __CheckCreateWindow(self, typeID) == false then
    return
  end
  local resloader = self.resloaders[typeID]
  resloader = resloader or cs_ResLoader.Create()
  local uiconfig = UIWindowGlobalConfig[typeID]
  if replaceTypeId ~= nil then
    uiconfig = UIWindowGlobalConfig[replaceTypeId]
  end
  assert(uiconfig)
  assert(not string.IsNullOrEmpty(uiconfig.PrefabName))
  self.resloaders[typeID] = resloader
  if isAsync then
    local tmpId = typeID
    UIUtil.CreateNewTopStatusData():SetTopStatusAsyncWindowId(tmpId):PushTopStatusDataToBackStack()
    resloader:LoadABAssetAsync(PathConsts:GetUIPrefabPath(uiconfig.PrefabName), function(prefab)
      local window = InitWindowInternal(self, typeID, uiconfig, prefab, fromWhichUI)
      for k, cb in ipairs(self.async_loaders[tmpId]) do
        cb(window)
      end
      self.async_loaders[tmpId] = nil
      if table.count(self.async_loaders) == 0 then
        cs_UIManager.MaxMaskActive = false
      end
      UIUtil.PopFromBackStackByAsyncWindowId(tmpId)
    end)
  else
    local prefab = resloader:LoadABAsset(PathConsts:GetUIPrefabPath(uiconfig.PrefabName))
    return InitWindowInternal(self, typeID, uiconfig, prefab)
  end
end

function UIManager:GetWindow(typeID)
  local target = self.windows[typeID]
  return target
end

function UIManager:CreateWindow(typeID, replaceType)
  local target = self:GetWindow(typeID)
  if target then
    return target
  end
  if self.resloaders[typeID] ~= nil then
    return nil
  end
  return CreateWindowInternal(self, typeID, false, replaceType)
end

function UIManager:ShowWindow(typeID, replaceType, fromWhichUI)
  local target = self:GetWindow(typeID)
  if target then
    target:Show()
    return target
  end
  if self.resloaders[typeID] ~= nil then
    return nil
  end
  local window = CreateWindowInternal(self, typeID, false, replaceType, fromWhichUI)
  window:Show()
  return window
end

function UIManager:ShowWindowOnly(typeID, withoutSound)
  local target = self:GetWindow(typeID)
  if target then
    if withoutSound then
      target:WinNextWithoutSound()
    end
    target:Show()
    return target
  end
  return nil
end

function UIManager:CreateWindowAsync(typeID, openCallback, replaceType, fromWhichUI)
  local target = self:GetWindow(typeID)
  if target ~= nil then
    openCallback(target)
    return
  end
  if __CheckCreateWindow(self, typeID) == false then
    return
  end
  if self.async_loaders[typeID] == nil then
    self.async_loaders[typeID] = {}
  end
  table.insert(self.async_loaders[typeID], openCallback)
  cs_UIManager.MaxMaskActive = true
  CreateWindowInternal(self, typeID, true, replaceType, fromWhichUI)
end

function UIManager:ShowWindowAsync(typeID, openCallback, replaceType, fromWhichUI)
  local target = self:GetWindow(typeID)
  if target then
    target:Show()
    if openCallback ~= nil then
      openCallback(target)
    end
    return target
  end
  if self.resloaders[typeID] ~= nil then
    table.insert(self.async_loaders[typeID], function(win)
      if win ~= nil then
        win:Show()
      end
      if openCallback ~= nil then
        openCallback(win)
      end
    end)
    return nil
  end
  self:CreateWindowAsync(typeID, function(window)
    if window ~= nil then
      window:Show()
    end
    if openCallback ~= nil then
      openCallback(window)
    end
  end, replaceType, fromWhichUI)
end

function UIManager:HideWindow(typeID)
  local target = self:GetWindow(typeID)
  if target then
    target:Hide()
  end
end

function UIManager:DeleteWindow(typeID, isImmeDelete)
  local resloader, target = self:DeleteWindowData(typeID)
  if target == nil then
    return
  end
  if target.active then
    target:OnHide()
  end
  target:OnDelete()
  if target.winTween == nil or isImmeDelete then
    if target.winTween ~= nil then
      target.winTween:Kill()
      target.winTween = nil
    end
    target:OnCloseTween()
    self:RecycleWindowEntity(resloader, target)
  else
    target.isColsingWin = true
    target:CloseTween(resloader)
  end
end

function UIManager:DeleteWindowData(typeID)
  local target = self:GetWindow(typeID)
  if target == nil then
    return
  end
  self.windows[typeID] = nil
  local resloader = self.resloaders[typeID]
  if resloader ~= nil then
    self.resloaders[typeID] = nil
  end
  return resloader, target
end

function UIManager:RecycleWindowEntity(resloader, target)
  if target ~= nil then
    target:OnDeleteEntity()
  end
  if resloader ~= nil then
    resloader:Put2Pool()
  end
end

function UIManager:DeleteAllWindow()
  self._inDeleteAllWindow = true
  self:ClearAllAsyncLoad()
  for k, window in pairs(self.windows) do
    if not window.__permanent then
      self:DeleteWindow(k, true)
    end
  end
  self._inDeleteAllWindow = false
end

function UIManager:InDeleteAllWindow()
  return self._inDeleteAllWindow
end

function UIManager:ClearAllAsyncLoad()
  for typeID, v in pairs(self.async_loaders) do
    local resloader = self.resloaders[typeID]
    if resloader ~= nil then
      self.resloaders[typeID] = nil
      resloader:Put2Pool()
    end
  end
  self.async_loaders = {}
  cs_UIManager.MaxMaskActive = false
end

function UIManager:IsWindowInLoading(typeID)
  return self.async_loaders[typeID] ~= nil
end

function UIManager:GetUILayer(layerId)
  return self.layers[layerId]
end

function UIManager:CopyUI3DModifier(srcObj, destObj, useSimpleRotation)
  useSimpleRotation = useSimpleRotation or false
  CS.UIManager.CopyUI3DModifier(srcObj, destObj, useSimpleRotation)
end

function UIManager:GetSortingLayerName(layerId)
  return self.sortingLayerList[layerId]
end

function UIManager:CreateThreeDCanvas(typeId, Callback, name)
  local path = PathConsts:GetTreeDCanvasPath("UI3DCanvas")
  self.resloaders[typeId]:LoadABAssetAsync(path, function(prefab)
    local canvas = prefab:Instantiate()
    canvas.gameObject.name = name .. "3DCanvas"
    Callback(canvas)
  end)
end

function UIManager:HideAllWindow(exceptDic)
  exceptDic = exceptDic or {}
  exceptDic[UIWindowTypeID.Home] = true
  exceptDic[UIWindowTypeID.ClickContinue] = true
  local hideWinList = {}
  for typeID, win in pairs(self.windows) do
    if not win.__permanent and win.active and not win.isColsingWin and exceptDic[typeID] == nil then
      win:Hide()
      local winData = {}
      winData.win = win
      winData.returnCallback = win:GenCoverJumpReturnCallback()
      table.insert(hideWinList, winData)
    end
  end
  return hideWinList
end

function UIManager:OnClickNavBack()
  if UIWindowTypeID == nil then
    return
  end
  local clickToContinueWin = self:GetWindow(UIWindowTypeID.ClickContinue)
  if cs_UIManager.MaxMaskActive or clickToContinueWin ~= nil and clickToContinueWin.active then
    return
  end
  local avgSkipWin = self:GetWindow(UIWindowTypeID.AvgSkip)
  if avgSkipWin ~= nil then
    avgSkipWin:OnClickClose()
    return
  end
  local avgWin = self:GetWindow(UIWindowTypeID.Avg)
  if avgWin ~= nil then
    avgWin:OnClickSkip()
    return
  end
  local guidePictureWin = self:GetWindow(UIWindowTypeID.GuidePicture_0623New)
  if guidePictureWin ~= nil then
    UIUtil.OnClickBackByUiTab(guidePictureWin)
    return
  end
  local messageBoxWin = self:GetWindow(UIWindowTypeID.MessageBox)
  if messageBoxWin ~= nil and messageBoxWin.active then
    messageBoxWin:OnClickNo()
    messageBoxWin:OnClickClose()
    return
  end
  if GuideManager.inGuide then
    if CS_ClientConsts.IsAudit then
      cs_MicaSDKManager:ExitGame()
    end
    return
  end
  local messageCommonWin = self:GetWindow(UIWindowTypeID.MessageCommon)
  if messageCommonWin ~= nil and messageCommonWin.active then
    messageCommonWin:OnClickNo()
    messageCommonWin:OnClickClose()
    return
  end
  local cSharpMessageBoxWin = self.csUIManager:GetWindow(typeMessageBoxWindow)
  if cSharpMessageBoxWin ~= nil and cSharpMessageBoxWin.Active then
    return
  end
  local getHeroWin = self:GetWindow(UIWindowTypeID.GetHero)
  if getHeroWin ~= nil then
    getHeroWin:OnClickClose()
    getHeroWin:OnClickSkip()
    return
  end
  local commonRewardWin = self:GetWindow(UIWindowTypeID.CommonReward)
  if commonRewardWin ~= nil then
    commonRewardWin:OnClickClose()
    return
  end
  local battleWin = self:GetWindow(UIWindowTypeID.Battle)
  if battleWin ~= nil and battleWin:TryClickBattlePause() then
    return
  end
  local topStatusData = UIUtil.PeekBackStack()
  if topStatusData ~= nil then
    if UIUtil.GlobalIsBlockEsc then
      return
    end
    if topStatusData:GetIsBlockEsc() then
      return
    end
    UIUtil.ForceOnClickBack()
    return
  end
  local explorationWin = self:GetWindow(UIWindowTypeID.Exploration)
  if explorationWin ~= nil and explorationWin.active then
    explorationWin:OnBtnRetreatClicked()
    return
  end
  cs_MicaSDKManager:ExitGame()
end

function UIManager:CreateNewUINode(nodeGameObject, luaPathString)
  local nodeClass = require(luaPathString)
  local node = nodeClass.New()
  node:Init(nodeGameObject)
  return node
end

return UIManager
