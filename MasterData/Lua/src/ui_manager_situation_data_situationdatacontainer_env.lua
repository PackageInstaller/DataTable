local this = class("situationDataContainer_camera", require("ui.manager.situation.data.situationDataContainer"))
local _situationSceneTpl = L_GameTpl:getSituationSceneTpl()

function this:define()
  self.dataType = L_Const.situationDataType.env
end

function this:initData(param)
  self.data = require("ui.manager.situation.data.situationData_env").new()
  self.data.configId = param.configId
end

function this:load(sceneData)
  self.sceneData = sceneData
  local root = self.sceneData.envRoot
  local tpl = _situationSceneTpl:getTplById(self.data.configId)
  local path = _situationSceneTpl:getSceneResource(tpl)
  self.gameObject = L_ResPool:syncGameObject(path, root)
end

function this:release()
  if self.gameObject and not self.gameObject:IsNull() then
    C_GameObject.Destroy(self.gameObject)
  end
end

function this:changeEnv(id)
  self:release()
  self.data.configId = id
  self:load(self.sceneData)
end

return this
