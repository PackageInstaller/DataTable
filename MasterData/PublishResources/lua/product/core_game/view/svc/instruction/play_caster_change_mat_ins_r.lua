require("base_ins_r")
_class("PlayCasterChangeMaterialInstruction", BaseInstruction)
PlayCasterChangeMaterialInstruction = PlayCasterChangeMaterialInstruction
local ChangeMaterialType = {Modify = 0, Revert = 1}
_enum("ChangeMaterialType", ChangeMaterialType)
local ModelPartType = {Body = 0, Weapon = 1}
_enum("ModelPartType", ModelPartType)

function PlayCasterChangeMaterialInstruction:Constructor(paramList)
  self._changeType = tonumber(paramList.type)
  self._part = tonumber(paramList.part)
  self._matResName = paramList.mat
  self._nodeName = paramList.nodeName
end

function PlayCasterChangeMaterialInstruction:DoInstruction(TT, casterEntity, phaseContext)
  if self._changeType == ChangeMaterialType.Modify then
    self:_ModifyMaterial(casterEntity)
  elseif self._changeType == ChangeMaterialType.Revert then
    self:_RevertMaterial(casterEntity)
  end
end

function PlayCasterChangeMaterialInstruction:_ModifyMaterial(casterEntity)
  local backupCmpt = casterEntity:BackUpMaterial()
  if backupCmpt == nil then
    casterEntity:AddBackUpMaterial()
    backupCmpt = casterEntity:BackUpMaterial()
  end
  local casterObj = casterEntity:View().ViewWrapper.GameObject
  if self._part == ModelPartType.Body then
    local bodyRender = GameObjectHelper.FindFirstSkinedMeshRender(casterObj)
    if bodyRender ~= nil then
      self:_SetNewMaterial(bodyRender, backupCmpt)
    end
  elseif self._part == ModelPartType.Weapon then
    local weaponRender = self:FindWeaponSkinnedMeshRender(casterObj.transform, self._nodeName)
    if weaponRender ~= nil then
      self:_SetNewMaterial(weaponRender, backupCmpt)
    end
  end
end

function PlayCasterChangeMaterialInstruction:_SetNewMaterial(render, backupCmpt)
  local newBodyMat = backupCmpt:GetBackUpMaterial(self._part)
  if not newBodyMat then
    local matResRequest = ResourceManager:GetInstance():SyncLoadAsset(self._matResName, LoadType.Mat)
    newBodyMat = UnityEngine.Material:New(matResRequest.Obj)
    backupCmpt:SetBackUpRequest(self._matResName, matResRequest)
  end
  local sharedMaterials = render.sharedMaterials
  local curMat = sharedMaterials[0]
  backupCmpt:SetBackUpMaterial(self._part, curMat)
  local newMats = {}
  newMats[#newMats + 1] = newBodyMat
  render.sharedMaterials = newMats
end

function PlayCasterChangeMaterialInstruction:_RevertMaterial(casterEntity)
  local backupCmpt = casterEntity:BackUpMaterial()
  local casterObj = casterEntity:View().ViewWrapper.GameObject
  if self._part == ModelPartType.Body then
    local bodyRender = GameObjectHelper.FindFirstSkinedMeshRender(casterObj)
    if bodyRender ~= nil then
      self:_SetNewMaterial(bodyRender, backupCmpt)
    end
  elseif self._part == ModelPartType.Weapon then
    local weaponRender = self:FindWeaponSkinnedMeshRender(casterObj.transform, self._nodeName)
    if weaponRender ~= nil then
      self:_SetNewMaterial(weaponRender, backupCmpt)
    end
  end
end

function PlayCasterChangeMaterialInstruction:FindWeaponSkinnedMeshRender(casterObj, weaponName)
  local transform = GameObjectHelper.FindChild(casterObj, weaponName)
  if not transform then
    return nil
  end
  local render = transform.gameObject:GetComponent(typeof(UnityEngine.SkinnedMeshRenderer))
  return render
end
