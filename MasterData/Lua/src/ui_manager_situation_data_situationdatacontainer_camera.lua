local this = class("situationDataContainer_camera", require("ui.manager.situation.data.situationDataContainer"))

function this:define()
  self.dataType = L_Const.situationDataType.camera
end

function this:initData(param)
  self.data = require("ui.manager.situation.data.situationData_camera").new()
  self.data.pos = param.pos
  self.data.targetPos = param.targetPos
end

function this:load(sceneData)
  self.sceneData = sceneData
  L_Vector3.setLocalPos(self.sceneData.camera.transform, self.data.pos)
  L_Vector3.setLocalPos(self.sceneData.lookAtRoot, self.data.targetPos)
end

function this:setCameraPos(v3)
  L_Vector3.setLocalPos(self.sceneData.camera.transform, v3)
  self.data.pos = {
    x = v3.x,
    y = v3.y,
    z = v3.z
  }
end

function this:setTargetPos(v3, onlyData)
  self.data.targetPos = {
    x = v3.x,
    y = v3.y,
    z = v3.z
  }
  if not onlyData then
    L_Vector3.setLocalPos(self.sceneData.lookAtRoot, v3)
  end
end

return this
