local this = class("petGetSceneRuntimeData")

function this:ctor(sceneGo)
  self.petScene = sceneGo
  self.petPoints = nil
  self.petCache = {}
  self.petFlashObj = nil
  self.modelCache = nil
  self.cameraNode = nil
  self.placePets = {}
  self:_parseSceneModel()
end

function this:_parseSceneModel()
  local sceneTrans = self.petScene.transform
  self.petPoints = sceneTrans:Find("petRoot")
  self.cameraNode = sceneTrans:Find("petCamera")
  self.modelCache = sceneTrans:Find("modelCache")
end

function this:destroy()
  if L_CommonUtil.isValid(self.petScene) then
    C_GameObject.Destroy(self.petScene)
  end
  for i, v in pairs(self.petCache) do
    if L_CommonUtil.isValid(v) then
      C_GameObject.Destroy(v)
    end
  end
  if L_CommonUtil.isValid(self.petFlashObj) then
    C_GameObject.Destroy(self.petFlashObj)
  end
  self.petFlashObj = nil
end

return this
