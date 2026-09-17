local this = class("situationDataContainer_obj", require("ui.manager.situation.data.situationDataContainer"))
local _objTpl = L_GameTpl:getSituationObjectsTpl()

function this:define()
  self.dataType = L_Const.situationDataType.obj
end

function this:initData(param)
  self.data = require("ui.manager.situation.data.situationData_obj").new()
  self.data.configId = param.configId
  self.data.pos = param.pos
  self.data.rot = param.rot
end

function this:load(sceneData)
  self.sceneData = sceneData
  self:createObj()
end

function this:release()
  if self.gameObject and not self.gameObject:IsNull() then
    C_GameObject.Destroy(self.gameObject)
  end
end

function this:createObj()
  local path = _objTpl:getObjResource(_objTpl:getTplById(self.data.configId))
  local ending = ".prefab"
  if string.sub(path, -#ending) ~= ending then
    path = path .. ending
  end
  local obj = L_ResPool:syncGameObject(path, self.sceneData.objRoot)
  local trans = obj.transform
  obj.layer = 7
  L_Vector3.setLocalPos(trans, self.data.pos)
  L_Vector3.setLocalRot(trans, self.data.rot)
  self.gameObject = obj
  CS.Lens.Gameplay.Modules.Azur.SituationUtility.CreateCollider(obj)
end

function this:setLocalPosition(v3)
  local localPos = v3
  if self.gameObject then
    L_Vector3.setLocalPos(self.gameObject.transform, localPos)
  end
  self.data.pos = L_Vector3.new(localPos.x, localPos.y, localPos.z)
end

function this:setRotation(v3)
  if self.gameObject then
    L_Vector3.setRot(self.gameObject.transform.transform, v3)
  end
  self.data.rot = L_Vector3.new(v3.x, v3.y, v3.z)
end

return this
