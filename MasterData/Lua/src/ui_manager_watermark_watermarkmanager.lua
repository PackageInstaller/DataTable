local this = class("waterMarkManager", G_EventManagerBase)

function this:ctor()
  this.super.ctor(self)
  self.markImage = nil
  self.waterMarkCamera = nil
  self.isSetPlayerId = false
  self.testWaterMarkNode = nil
  self.testWaterMarkTextNode = nil
  self.networkInfoRoot = nil
  self.isTestMarkRefresh = false
  self.isEnteredGame = false
end

function this:initialize()
  L_PlayerStore:listenCallFunc(L_PlayerStore.event.refreshBaseInfo, self.onEvent_refreshBaseInfo, self)
  self.systemUnlockHandleid = C_IntegrateMgr.SystemUnlockModule:listenCallFunc(C_IntegrateMgr.SystemUnlockModule.updateSystem, self.refreshSystemUnlock, self)
  L_GameStore:listenCallFunc(L_GameStore.event.enterGame, self.onEvent_enterGame, self)
  local root = L_UI:getRoot()
  self.markImage = root:Find("[VisiableWaterMark]/markImage")
  self.testWaterMarkNode = root:Find("[VisiableWaterMark]/testingWaterMark")
  self.testWaterMarkTextNode = root:Find("[VisiableWaterMark]/testingWaterMark/markIdText")
  self.networkInfoRoot = root:Find("NetworkInfo")
  self:refreshAll(false)
  self:refreshNetworkInfoRoot(false)
  local isHide = C_PlayerPrefsUtility.GetBool("IsOpenWaterMarkOrFPS")
  if isHide then
    self:setActiveVisiableWaterMark(root)
  end
end

function this:setCameraAndRender(cell)
  local rect = cell.rect
  local renderTexture = C_RenderTexture.GetTemporary(rect.width, rect.height, 0, Unity.RenderTextureFormat.ARGB32)
  local camTrans = self.waterMarkCamera.transform:Find("camera")
  local camera = camTrans:GetComponent(typeof(Unity.Camera))
  camera.targetTexture = renderTexture
  C_RenderTexture.active = renderTexture
  camTrans.gameObject:SetActive(true)
  Unity.Rendering.Azur._2D.Utilities.ScreenCaptureHelper.RegistCaptureCamera(camera)
  if self.texCache then
    CS.Azur.Gameplay.Core.Asset.AssetManager.Instance:DestroyNewAsset(self.texCache)
    self.texCache = nil
  end
  local tex2d = CS.Azur.Gameplay.Core.Asset.AssetManager.Instance:NewTexture2D("WaterMark-CameraRender", math.round(rect.width), math.round(rect.height))
  tex2d.wrapMode = Unity.TextureWrapMode.Repeat
  C_CameraCaptureUtil.CaptureFrameToTexture2D(camera, tex2d, Unity.Rect(0, 0, rect.width, rect.height))
  Unity.Rendering.Azur._2D.Utilities.ScreenCaptureHelper.UnregistCaptureCamera(camera)
  C_RenderTexture.ReleaseTemporary(renderTexture)
  self.texCache = tex2d
  return tex2d
end

function this:setTextureUV(tex2d)
  local rawImage = self.markImage:GetComponent(typeof(C_LRawImage))
  if L_CommonUtil.isValid(tex2d) then
    rawImage.texture = tex2d
  else
    tex2d = rawImage.texture
    if not L_CommonUtil.isValid(tex2d) then
      return
    end
  end
  local rect = self.markImage.rect
  local uvX = rect.width / tex2d.width
  local uvY = rect.height / tex2d.height
  rawImage.uvRect = Unity.Rect(0, 0, uvX, uvY)
end

local function getPlayerIdText(playerId)
  local tag = CS.Lens.Framework.Managers.AppConfigManager.WaterMaskTag
  if tag and tag ~= "" then
    return string.format("{%s}%d", tag, playerId)
  else
    return tostring(playerId)
  end
end

function this:refreshMarkNode(isActive)
  if not L_CommonUtil.isValid(self.markImage) then
    return
  end
  self.markImage.gameObject:ActiveTrans(isActive)
  if not isActive then
    return
  end
  local playerId = L_PlayerStore:getPlayerId()
  if not self.isSetPlayerId and playerId ~= nil then
    if not self.waterMarkCamera then
      self.waterMarkCamera = L_ResPool:syncGameObject("Scene/Prefab/WaterMarkCam.prefab")
    end
    if L_CommonUtil.isValid(self.waterMarkCamera) then
      local cell = self.waterMarkCamera.transform:Find("canvas/cell")
      local text = cell:Find("cellWaterMark/markIdText")
      local idText = text:GetComponent(typeof(C_LTextMeshProUGUI))
      idText.text = getPlayerIdText(playerId)
      local tex2d = self:setCameraAndRender(cell)
      self:setTextureUV(tex2d)
      C_GameObject.DestroyImmediate(self.waterMarkCamera)
    end
    self.waterMarkCamera = nil
    self.isSetPlayerId = true
  else
    self:setTextureUV()
  end
end

function this:refreshTestWaterMark(isActive)
  if not L_CommonUtil.isValid(self.testWaterMarkNode) then
    errorf("Water Mark: testWaterMarkNode is nil")
    return
  end
  if not L_CommonUtil.isValid(self.testWaterMarkTextNode) then
    errorf("Water Mark: testWaterMarkTextNode is nil")
    return
  end
  if isActive then
    local lockState = C_IntegrateMgr.SystemUnlockModule:getSystemIsBan(L_SystemConst.enum.TestWaterMask)
    local testText = self.testWaterMarkTextNode:GetComponent(typeof(C_LTextMeshProUGUI))
    local wordsID = lockState and "notice_watermark_tips02" or "notice_watermark_tips01"
    local str = L_WordsTpl:getRawValue(wordsID)
    if testText ~= nil and str ~= nil then
      local fin_str = L_Config:provider(str)
      if fin_str ~= nil then
        self.testWaterMarkNode.gameObject:ActiveTrans(isActive)
        testText.text = fin_str
        self.testWaterMarkTextNode.gameObject:ActiveTrans(true)
      end
    else
      print("Water Mark: notice_watermark_tips01 is nil")
    end
  else
    self.testWaterMarkNode.gameObject:ActiveTrans(isActive)
    if L_CommonUtil.isValid(self.testWaterMarkTextNode) then
      self.testWaterMarkTextNode.gameObject:ActiveTrans(true)
    end
  end
end

function this:creatMarkList()
  for i = 1, self.cellCount do
    local cell = CS.Lens.Framework.AzurAssets.Instantiate(self.cellWaterMark.gameObject, false, self.markList).Result
    cell.name = "cellWaterMark_" .. i
  end
end

function this:clearMarkList()
  if L_CommonUtil.isValid(self.markList) then
    for i = 0, self.markList.childCount - 1 do
      local child = self.markList:GetChild(i)
      if L_CommonUtil.isValid(child) then
        C_GameObject.Destroy(child.gameObject)
      end
    end
  end
end

function this:dispose()
  self:refreshAll(false)
  self.markImage = nil
  self.networkInfoRoot = nil
  self.isSetPlayerId = nil
  self.cellCount = 0
  self.cellLayout = nil
  self.isEnteredGame = false
  L_PlayerStore:unListenCallFunc(L_PlayerStore.event.refreshBaseInfo, self.onEvent_refreshBaseInfo)
  C_IntegrateMgr.SystemUnlockModule:unListenCallFunc(self.systemUnlockHandleId)
  L_GameStore:unListenCallFunc(L_GameStore.event.enterGame, self.onEvent_enterGame, self)
  if self.texCache then
    CS.Azur.Gameplay.Core.Asset.AssetManager.Instance:DestroyNewAsset(self.texCache)
    self.texCache = nil
  end
end

function this:onEvent_refreshBaseInfo()
  self:refreshAll()
end

function this:refreshSystemUnlock(id)
  self:refreshAll()
end

function this:onEvent_enterGame()
  self.isEnteredGame = true
  self:refreshNetworkInfoRoot(true)
end

function this:refreshAll(isActive)
  if isActive == nil then
    isActive = not C_IntegrateMgr.SystemUnlockModule:getSystemIsBan(L_SystemConst.enum.waterMark)
  end
  self:refreshMarkNode(isActive)
  self:refreshTestWaterMark(isActive)
  self:refreshNetworkInfoRoot()
end

function this:refreshNetworkInfoRoot(isActive)
  if isActive == nil then
    isActive = self.isEnteredGame
  end
  if L_CommonUtil.isValid(self.networkInfoRoot) then
    self.networkInfoRoot.gameObject:ActiveTrans(isActive)
  end
end

function this:setActiveVisiableWaterMark(root)
  local waterMarkTran = root:Find("[WaterMark]")
  if L_CommonUtil.isValid(waterMarkTran) then
    waterMarkTran.gameObject:SetActive(false)
  end
  local VisiableWaterMarkTran = root:Find("[VisiableWaterMark]")
  if L_CommonUtil.isValid(VisiableWaterMarkTran) then
    VisiableWaterMarkTran.gameObject:SetActive(false)
  end
end

return this
