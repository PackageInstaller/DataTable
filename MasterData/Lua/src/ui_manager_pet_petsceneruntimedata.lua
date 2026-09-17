local this = class("petSceneRuntimeData")

function this:ctor(sceneGo)
  self.petScene = sceneGo
  self.petPoints = nil
  self.petCache = {}
  self.cameraNodeData = {}
  self.curCamName = nil
  self.petFlashObj = nil
  self.dressupSwitchEffect = nil
  self.modelCache = nil
  self.cameraNode = nil
  self.globalNode = nil
  self.starSoulCamNode = nil
  self.isDisablePetRot = false
  self.placePets = {}
  self:_parseSceneModel()
end

function this:_parseSceneModel()
  local sceneTrans = self.petScene.transform
  self.petPoints = L_CommonUtil.findTranByName("petRoot", sceneTrans)
  self.cameraNode = L_CommonUtil.findTranByName("petCamera", sceneTrans)
  self.modelCache = L_CommonUtil.findTranByName("modelCache", sceneTrans)
  self.globalNode = L_CommonUtil.findTranByName("Global", sceneTrans)
  self.starSoulCamNode = L_CommonUtil.findTranByName("starSoulCam", sceneTrans)
  if L_CommonUtil.findTranByName("cameraBlend", sceneTrans) then
    self.cameraBlend = L_CommonUtil.findTranByName("cameraBlend", sceneTrans).gameObject
  end
  for _, name in pairs(L_PetConst.EnumCamName) do
    local cam = L_CommonUtil.findTranByName(name, sceneTrans)
    if cam ~= nil then
      self.cameraNodeData[name] = {}
      self.cameraNodeData[name].camera = cam:GetComponent(typeof(CS.Cinemachine.CinemachineVirtualCameraBase))
    end
  end
end

function this:refreshBlend()
  if self.cameraBlend then
    self.cameraBlend:SetActive(false)
    self.cameraBlend:SetActive(true)
  end
end

function this:destroy()
  L_ResPool:destroyGo(self.petScene)
  for i, v in pairs(self.petCache) do
    if L_CommonUtil.isValid(v) then
      C_GameObject.Destroy(v)
    end
  end
  if L_CommonUtil.isValid(self.petFlashObj) then
    L_ResPool:destroyGo(self.petFlashObj)
  end
  if L_CommonUtil.isValid(self.dressupSwitchEffect) then
    L_ResPool:destroyGo(self.dressupSwitchEffect)
  end
  self.petFlashObj = nil
  self.dressupSwitchEffect = nil
  self.cameraBlend = nil
  self.curCamName = nil
end

return this
