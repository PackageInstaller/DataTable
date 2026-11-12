local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResType = GameResourceLoader.ResType
local GameCameraStackManager = CS.GameCameraStackManager
local BasePanel = class("BasePanel")
local sTopBarCtrlLua = "Game.UI.TopBarEx.TopBarCtrl"
local sSafeAreaRoot = "----SafeAreaRoot----"
local bDebugLog = false
local typeof = _ENV.typeof
local InUnityEditor = NovaAPI.IsEditorPlatform()

function BasePanel:ctor(nIndex, nPanelId, tbParam)
  self._nIndex = nIndex
  self._nPanelId = nPanelId
  self._bIsActive = false
  self._tbParam = tbParam
  self._nGoBlurInsId = nil
  if self._nFADEINTYPE == nil then
    self._nFADEINTYPE = 1
  end
  if self._nFadeInType == nil then
    self._nFadeInType = 1
  end
  if self._bIsMainPanel == nil then
    self._bIsMainPanel = true
  end
  if self._bAddToBackHistory == nil then
    self._bAddToBackHistory = true
  end
  if self._nSnapshotPrePanel == nil then
    self._nSnapshotPrePanel = 0
  end
  if self._sSortingLayerName == nil then
    self._sSortingLayerName = AllEnum.SortingLayerName.UI
  end
  if self._tbDefine == nil then
    self._tbDefine = {}
  end
  if self._sUIResRootPath ~= nil then
    self.sUIResRootPath = Settings.AB_ROOT_PATH .. self._sUIResRootPath
  else
    self.sUIResRootPath = Settings.AB_ROOT_PATH .. "UI/"
  end
  self._tbObjCtrl = {}
  self._tbObjChildCtrl = {}
  self._tbObjDyncChildCtrl = {}
  if type(self.Awake) == "function" then
    self:Awake()
  end
  self.bIsTipsPanel = UTILS.CheckIsTipsPanel(self._nPanelId)
end

function BasePanel:_PreExit(callback, bPlayFadeOut)
  if self._bIsActive == false then
    return
  end
  self:_UnbindEventCallback()
  for sName, objChildCtrl in ipairs(self._tbObjChildCtrl) do
    objChildCtrl:_PreExit()
  end
  for i, objDyncChildCtrl in ipairs(self._tbObjDyncChildCtrl) do
    objDyncChildCtrl:_PreExit()
  end
  local nCount = #self._tbObjCtrl
  
  local function func_PreExitDone()
    nCount = nCount - 1
    if nCount == 0 and type(callback) == "function" then
      callback()
    end
  end
  
  for i, objCtrl in ipairs(self._tbObjCtrl) do
    objCtrl:_PreExit(func_PreExitDone, bPlayFadeOut)
  end
end

function BasePanel:_PreEnter(callback, goSnapshot)
  local _trParent = PanelManager.GetUIRoot(self._sSortingLayerName)
  local nCount = #self._tbDefine
  
  local function func_DoInstantiate(nIndex)
    local function func_ProcNext()
      nIndex = nIndex + 1
      
      if nIndex > nCount then
        if type(callback) == "function" then
          callback()
        end
      else
        func_DoInstantiate(nIndex)
      end
    end
    
    local objCtrl = self._tbObjCtrl[nIndex]
    if objCtrl ~= nil and objCtrl.gameObject ~= nil then
      objCtrl:ParsePrefab()
      func_ProcNext()
    else
      local tbDefine = self._tbDefine[nIndex]
      local sPrefabFullPath = self.sUIResRootPath .. tbDefine.sPrefabPath
      local sLuaClassName = tbDefine.sCtrlName
      
      local function func_PrefabLoaded(uiPrefab)
        local luaClassName = require(sLuaClassName)
        local trParent = _trParent
        if sLuaClassName == sTopBarCtrlLua and self._trTopBarParent ~= nil then
          trParent = self._trTopBarParent
        end
        local goPrefabInstance = instantiate(uiPrefab, trParent)
        goPrefabInstance.name = uiPrefab.name
        goPrefabInstance.transform:SetAsLastSibling()
        if nIndex == 1 then
          self._trTopBarParent = goPrefabInstance.transform:Find(sSafeAreaRoot)
          if self._trTopBarParent == nil then
            self._trTopBarParent = goPrefabInstance.transform
          end
          if goSnapshot ~= nil and goSnapshot:IsNull() == false then
            goSnapshot.transform:SetParent(goPrefabInstance.transform)
            goSnapshot.transform.localScale = Vector3.one
            goSnapshot.transform:SetAsFirstSibling()
            local rt = goSnapshot:GetComponent("RectTransform")
            rt.anchorMax = Vector2.one
            rt.anchorMin = Vector2.zero
            rt.anchoredPosition = Vector2.zero
          end
        end
        if InUnityEditor then
          local sPanelName = self.__cname
          NovaAPI.AttachPrefabLuaInspector(goPrefabInstance, sLuaClassName, sPanelName, sPrefabFullPath)
        end
        if objCtrl == nil then
          objCtrl = luaClassName.new(goPrefabInstance, self)
          table.insert(self._tbObjCtrl, objCtrl)
        else
          objCtrl:ParsePrefab(goPrefabInstance)
          if type(objCtrl.Awake) == "function" then
            objCtrl:Awake()
          end
        end
        func_ProcNext()
      end
      
      local prefab = GameResourceLoader.LoadAsset(ResType.Any, sPrefabFullPath, typeof(Object), "UI", self._nPanelId)
      if prefab == nil or prefab:IsNull() == true then
        printError(sPrefabFullPath .. " can not found!!!")
      end
      func_PrefabLoaded(prefab)
    end
  end
  
  func_DoInstantiate(1)
  self._bIsActive = true
end

function BasePanel:_Exit()
  if self._bIsActive == false then
    return
  end
  if type(self.OnDisable) == "function" then
    self:OnDisable()
  end
  for sName, objChildCtrl in ipairs(self._tbObjChildCtrl) do
    objChildCtrl:_Exit()
  end
  for i, objDyncChildCtrl in ipairs(self._tbObjDyncChildCtrl) do
    objDyncChildCtrl:_Exit()
  end
  for i, objCtrl in ipairs(self._tbObjCtrl) do
    objCtrl:_Exit()
  end
  self:_DebugLogDataCount("OnDisable")
  self._bIsActive = false
end

function BasePanel:_Enter(bPlayFadeIn)
  self:_BindEventCallback()
  for i, objCtrl in ipairs(self._tbObjCtrl) do
    local canvas = objCtrl.gameObject:GetComponent("Canvas")
    if canvas ~= nil and canvas:IsNull() == false then
      NovaAPI.SetCanvasWorldCamera(canvas, GameCameraStackManager.Instance.uiCamera)
      NovaAPI.SetCanvasSortingName(canvas, self._sSortingLayerName)
      local nSortingOrder = 0
      if self._nIndex >= AllEnum.UI_SORTING_ORDER.Guide then
        nSortingOrder = self._nIndex
      elseif self.bIsTipsPanel == true then
        nSortingOrder = AllEnum.UI_SORTING_ORDER.Tips
        if self._bIsExtraTips == true then
          nSortingOrder = AllEnum.UI_SORTING_ORDER.TipsEx
        end
      elseif self._nPanelId == PanelId.ProVideoGUI then
        nSortingOrder = AllEnum.UI_SORTING_ORDER.ProVideo
      elseif self._nSortingOrderBase ~= nil then
        nSortingOrder = self._nSortingOrderBase + i
      else
        nSortingOrder = self._nIndex * 100 + i
      end
      NovaAPI.SetCanvasSortingOrder(canvas, nSortingOrder)
      objCtrl._nSortingOrder = nSortingOrder
      NovaAPI.SetCanvasPlaneDistance(canvas, 101)
    end
    objCtrl.gameObject:SetActive(true)
    objCtrl:_Enter(bPlayFadeIn)
  end
  for sName, objChildCtrl in ipairs(self._tbObjChildCtrl) do
    objChildCtrl:_Enter()
  end
  if type(self.OnEnable) == "function" then
    self:OnEnable(bPlayFadeIn)
  end
  EventManager.Hit("OnEvent_PanelOnEnableById", self._nPanelId)
  self:_DebugLogDataCount("OnEnable")
end

function BasePanel:_AfterEnter()
  if type(self.OnAfterEnter) == "function" then
    self:OnAfterEnter()
  end
end

function BasePanel:_SetPrefabInstance(bDel)
  local nCount = #self._tbObjDyncChildCtrl
  for i = nCount, 1, -1 do
    local objDyncChildCtrl = self._tbObjDyncChildCtrl[i]
    objDyncChildCtrl:_Destroy()
    objDyncChildCtrl.gameObject = nil
    table.remove(self._tbObjDyncChildCtrl, i)
  end
  for i, objCtrl in ipairs(self._tbObjCtrl) do
    if bDel == true then
      if objCtrl.__cname == "TopBarCtrl" then
        objCtrl.gameObject = nil
      elseif objCtrl.gameObject ~= nil and objCtrl.gameObject:IsNull() == false then
        destroy(objCtrl.gameObject)
        objCtrl.gameObject = nil
      end
      self._trTopBarParent = nil
    elseif objCtrl.gameObject ~= nil and objCtrl.gameObject:IsNull() == false then
      objCtrl.gameObject:SetActive(false)
    end
  end
  if bDel == true then
    nCount = #self._tbObjChildCtrl
    for i = nCount, 1, -1 do
      local o = self._tbObjChildCtrl[i]
      o._nGoInstanceId = nil
      o.gameObject = nil
      table.remove(self._tbObjChildCtrl, i)
    end
  end
  self:_DebugLogDataCount("Before OnDestroy")
end

function BasePanel:_Destroy()
  if type(self.OnDestroy) == "function" then
    self:OnDestroy()
  end
  for i, objCtrl in ipairs(self._tbObjCtrl) do
    GameResourceLoader.UnloadAsset(objCtrl._panel._nPanelId)
    objCtrl:_Destroy()
  end
  for sName, objChildCtrl in ipairs(self._tbObjChildCtrl) do
    objChildCtrl:_Destroy()
  end
  self:_SetPrefabInstance(true)
  self._tbParam = nil
  self._tbObjCtrl = nil
  self._tbObjChildCtrl = nil
  self._tbObjDyncChildCtrl = nil
end

function BasePanel:_Release()
  if type(self.OnRelease) == "function" then
    self:OnRelease()
  end
  if type(self._tbObjCtrl) == "table" then
    for i, objCtrl in ipairs(self._tbObjCtrl) do
      objCtrl:_Release()
    end
  end
  if type(self._tbObjChildCtrl) == "table" then
    for sName, objChildCtrl in ipairs(self._tbObjChildCtrl) do
      objChildCtrl:_Release()
    end
  end
end

function BasePanel:_BindEventCallback()
  if type(self._mapEventConfig) == "table" then
    for nEventId, sCallbackName in pairs(self._mapEventConfig) do
      local callback = self[sCallbackName]
      if type(callback) == "function" then
        EventManager.Add(nEventId, self, callback)
      end
    end
  end
end

function BasePanel:_UnbindEventCallback()
  if type(self._mapEventConfig) == "table" then
    for nEventId, sCallbackName in pairs(self._mapEventConfig) do
      local callback = self[sCallbackName]
      if type(callback) == "function" then
        EventManager.Remove(nEventId, self, callback)
      end
    end
  end
end

function BasePanel:_DebugLogDataCount(sTitle)
  if bDebugLog == false then
    return
  end
  local sPanelName = self.__cname
  local nObjCtrlCnt = table.nums(self._tbObjCtrl)
  local nObjChildCtrlCnt = table.nums(self._tbObjChildCtrl)
  local nObjDyncChildCtrlCnt = table.nums(self._tbObjDyncChildCtrl)
  local sDebugLog = string.format("[%s.%s] ctrl实例数量：%d，子ctrl实例数量：%d，动态子ctrl实例数量：%d。", sPanelName, sTitle, nObjCtrlCnt, nObjChildCtrlCnt, nObjDyncChildCtrlCnt)
  printLog(sDebugLog)
end

function BasePanel:GetPanelParam()
  if type(self._tbParam) == "table" then
    return self._tbParam
  else
    return nil
  end
end

function BasePanel:ClearPanelParam()
  self._tbParam = nil
end

return BasePanel
