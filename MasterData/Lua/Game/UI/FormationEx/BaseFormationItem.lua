local Camera = CS.UnityEngine.Camera
local Light = CS.UnityEngine.Light
local NovaAPI = _ENV.NovaAPI
local Animator = CS.UnityEngine.Animator
local ClientManager = CS.ClientManager
local CustomModelMaterialVariantComponent = CS.CustomModelMaterialVariantComponent
local typeof = _ENV.typeof
local BaseFormationItem = class("BaseFormationItem", BaseCtrl)

function BaseFormationItem:Awake()
  self.mIndex = 0
  self.mData = nil
  self.mActive = true
  self.mRole3DData = {}
  self:buildData()
end

function BaseFormationItem:OnDestroy()
  self.mIndex = 0
  self.mData = nil
  if self.mRole3DData.role ~= nil then
    destroy(self.mRole3DData.role)
    self.mRole3DData.role = nil
  end
  if self.mRole3DData.cameraRT ~= nil then
    self.mRole3DData.camera.targetTexture = nil
    GameUIUtils.ReleaseRenderTexture(self.mRole3DData.cameraRT)
    self.mRole3DData.cameraRT = nil
  end
  if self.mRole3DData.gameObject ~= nil then
    destroy(self.mRole3DData.gameObject)
    self.mRole3DData.gameObject = nil
  end
  self.mRole3DData = {}
end

function BaseFormationItem:buildData()
  local layerName = "Cam_Layer_4"
  local layerIndex = NovaAPI.LayerMaskName2Layer(layerName)
  local layerMask = NovaAPI.LayerMaskGetMask(layerName)
  local windowResolution = ClientManager.Instance.currentWindowResolution
  local texSize = windowResolution.y
  if NovaAPI.IsMobilePlatform() then
    texSize = math.round(texSize * 1.333)
  else
    texSize = math.round(texSize * 2)
  end
  local imgSize = 1150
  local go = self:CreatePrefabInstance("UI/MainlineFormationEx/SelectRolePrefab.prefab", self._mapNode.trParent)
  go.transform.position = Vector3(100, 0, 0)
  go.transform:SetLayerRecursively(layerIndex)
  self.mRole3DData.gameObject = go
  self.mRole3DData.camera = go.transform:Find("Camera"):GetComponent(typeof(Camera))
  self.mRole3DData.camera.cullingMask = layerMask
  self.mRole3DData.camera:SetCameraVolumeLayerMask(layerMask)
  local n = math.floor(texSize * Settings.RENDERTEXTURE_SIZE_FACTOR)
  self.mRole3DData.cameraRT = GameUIUtils.GenerateRenderTextureFor3D(n, n)
  self.mRole3DData.camera.targetTexture = self.mRole3DData.cameraRT
  self.mRole3DData.light = go.transform:Find("Light"):GetComponent(typeof(Light))
  self.mRole3DData.light.cullingMask = layerMask
  self.mRole3DData.node = go.transform:Find("RoleSpawnPosition")
  self.mRole3DData.role = nil
  NovaAPI.SetTexture(self._mapNode.rimg_role, self.mRole3DData.cameraRT)
  self._mapNode.rimg_role:GetComponent(typeof(RectTransform)).sizeDelta = Vector2(imgSize, imgSize)
end

function BaseFormationItem:showModel(modelPrefab)
  if self.mData == nil then
    return
  end
  local skinId = PlayerData.Char:GetCharSkinId(self.mData.CharId)
  self.mRole3DData.gameObject.transform.position = Vector3(100 * self.mIndex, 0, 0)
  self.mRole3DData.role = instantiate(modelPrefab, self.mRole3DData.node)
  self.mRole3DData.role.transform.localPosition = Vector3(0, 0.03, 0)
  self.mRole3DData.role.transform.localScale = Vector3.one * (ConfigTable.GetData_CharacterSkin(skinId).ModelShowScale / 10000)
  self.mRole3DData.role.transform.localRotation = Quaternion.identity
  self.mRole3DData.rolePath = self.mData.Model
  local animator = self.mRole3DData.role:GetComponent(typeof(Animator))
  if animator ~= nil then
    animator:SetBool("standby", true)
  end
  local matVariantComp = self.mRole3DData.role:GetComponent(typeof(CustomModelMaterialVariantComponent))
  if matVariantComp ~= nil then
    matVariantComp:SetVariant(CS.CustomModelMaterialVariantComponent.VariantNames.FormationView)
  end
  local layerName = "Cam_Layer_" .. self.mIndex
  local layerIndex = NovaAPI.LayerMaskName2Layer(layerName)
  local layerMask = NovaAPI.LayerMaskGetMask(layerName)
  self.mRole3DData.gameObject.transform:SetLayerRecursively(layerIndex)
  self.mRole3DData.camera.cullingMask = layerMask
  self.mRole3DData.camera:SetCameraVolumeLayerMask(layerMask)
  self.mRole3DData.light.cullingMask = layerMask
end

return BaseFormationItem
