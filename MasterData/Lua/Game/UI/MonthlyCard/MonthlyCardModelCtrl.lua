local MonthlyCardModelCtrl = class("MonthlyCardModelCtrl", BaseCtrl)
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResType = GameResourceLoader.ResType
local Camera = CS.UnityEngine.Camera
local Light = CS.UnityEngine.Light
local Animator = CS.UnityEngine.Animator
local ClientManager = CS.ClientManager
local CustomModelMaterialVariantComponent = CS.CustomModelMaterialVariantComponent
local typeof = _ENV.typeof
MonthlyCardModelCtrl._mapNodeConfig = {
  trParent = {sComponentName = "Transform"},
  rimgModel = {sComponentName = "RawImage"}
}
MonthlyCardModelCtrl._mapEventConfig = {}

function MonthlyCardModelCtrl:ShowRawImage()
  self.sModelPath = "UI/MonthlyCard/Model/MonthlyCardBox01.prefab"
  if not self.mActive then
    return
  end
  local obj = self:LoadAsset(self.sModelPath, typeof(GameObject))
  self:showModel(obj)
end

function MonthlyCardModelCtrl:PlayOpenAnim()
  if self.animator ~= nil then
    self.animator:SetTrigger("tOpen")
  end
end

function MonthlyCardModelCtrl:buildData()
  local layerName = "Cam_Layer_1"
  local layerIndex = NovaAPI.LayerMaskName2Layer(layerName)
  local layerMask = NovaAPI.LayerMaskGetMask(layerName)
  local windowResolution = ClientManager.Instance.currentWindowResolution
  local texSize = windowResolution.x
  local imgSize = 2160
  local go = self:CreatePrefabInstance("UI/MonthlyCard/MonthlyCardModel.prefab", self._mapNode.trParent)
  go.transform.position = Vector3(0, 0, 0)
  go.transform:SetLayerRecursively(layerIndex)
  self.m3DData.gameObject = go
  self.m3DData.camera = go.transform:Find("Camera"):GetComponent(typeof(Camera))
  self.m3DData.camera.cullingMask = layerMask
  self.m3DData.camera:SetCameraVolumeLayerMask(layerMask)
  local n = math.floor(texSize * Settings.RENDERTEXTURE_SIZE_FACTOR)
  self.m3DData.cameraRT = GameUIUtils.GenerateRenderTextureFor3D(n, n)
  self.m3DData.camera.targetTexture = self.m3DData.cameraRT
  self.m3DData.light = go.transform:Find("Light"):GetComponent(typeof(Light))
  self.m3DData.light.cullingMask = layerMask
  self.m3DData.node = go.transform:Find("SpawnPosition")
  self.m3DData.box = nil
  NovaAPI.SetTexture(self._mapNode.rimgModel, self.m3DData.cameraRT)
  self._mapNode.rimgModel:GetComponent(typeof(RectTransform)).sizeDelta = Vector2(imgSize, imgSize)
end

function MonthlyCardModelCtrl:showModel(modelPrefab)
  self.m3DData.gameObject.transform.position = Vector3(0, 0, 0)
  self.m3DData.box = instantiate(modelPrefab, self.m3DData.node)
  self.m3DData.weaponPath = self.sModelPath
  self.animator = self.m3DData.box:GetComponent(typeof(Animator))
  local matVariantComp = self.m3DData.box:GetComponent(typeof(CustomModelMaterialVariantComponent))
  if matVariantComp ~= nil then
    matVariantComp:SetVariant(CS.CustomModelMaterialVariantComponent.VariantNames.WeaponModelView)
  end
  local layerName = "Cam_Layer_1"
  local layerIndex = NovaAPI.LayerMaskName2Layer(layerName)
  local layerMask = NovaAPI.LayerMaskGetMask(layerName)
  self.m3DData.gameObject.transform:SetLayerRecursively(layerIndex)
  self.m3DData.camera.cullingMask = layerMask
  self.m3DData.camera:SetCameraVolumeLayerMask(layerMask)
  self.m3DData.light.cullingMask = layerMask
end

function MonthlyCardModelCtrl:Awake()
  self.mActive = true
  self.m3DData = {}
  self:buildData()
end

function MonthlyCardModelCtrl:OnEnable()
  self.mActive = true
end

function MonthlyCardModelCtrl:OnDisable()
  if self.m3DData.box ~= nil then
    destroy(self.m3DData.box)
    self.m3DData.box = nil
  end
  self.mActive = false
end

function MonthlyCardModelCtrl:OnDestroy()
  if self.m3DData.box ~= nil then
    destroy(self.m3DData.box)
    self.m3DData.box = nil
  end
  if self.m3DData.cameraRT ~= nil then
    self.m3DData.camera.targetTexture = nil
    GameUIUtils.ReleaseRenderTexture(self.m3DData.cameraRT)
    self.m3DData.cameraRT = nil
  end
  if self.m3DData.gameObject ~= nil then
    destroy(self.m3DData.gameObject)
    self.m3DData.gameObject = nil
  end
  self.m3DData = {}
end

return MonthlyCardModelCtrl
