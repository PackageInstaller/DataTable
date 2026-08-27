local CS_UnityEngine_GameObject = CS.UnityEngine.GameObject
local DormFightCtrlBase = require("Game.Fight.Ctrl.DormFightCtrlBase")
local CharacterFactory = require("Game.Fight.Character.Entity.CharacterFactory")
local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCharacterCtrl = class("DormFightCharacterCtrl", DormFightCtrlBase)

function DormFightCharacterCtrl:ctor(_)
  self._resLoader = nil
  self._characterIndex = 0
  self._allCharacters = {}
  self._hittableParts2Char = {}
  self._hitIndexDict = {}
  self._isDoing = false
  self._onCharacterHit = BindCallback(self, self.OnCharacterHitSomeone)
  self._someoneKnockOutDelegate = nil
end

function DormFightCharacterCtrl:AddCharacter(characterId, characterType, isMainCharacter, name, comp, bornPosition, bornRotation)
  local character = CharacterFactory.CreateCharacter(characterType)
  if character == nil then
    return
  end
  self._characterIndex = self._characterIndex + 1
  local folderKey
  if characterId == DormFightConst.MaleProfessorIdDefine then
    folderKey = "professor_boy"
  elseif characterId == DormFightConst.FemaleProfessorIdDefine then
    folderKey = "professor"
  else
    local heroCfg = ConfigData.hero_data[characterId]
    local cfg = heroCfg and ConfigData.resource_model[heroCfg.src_id]
    folderKey = cfg ~= nil and cfg.res_Name or "professor"
  end
  local resPath = PathConsts:GetCharacterFightModelPath(folderKey)
  local modelPrefab = self._resLoader:LoadABAsset(resPath)
  if modelPrefab == nil then
    return -1
  end
  local modelGo = CS_UnityEngine_GameObject.Instantiate(modelPrefab, bornPosition, bornRotation)
  character:Initialize(self._characterIndex, isMainCharacter, name, comp, modelGo)
  character:AddHitSomeoneListener(self._onCharacterHit)
  local hittableParts = character:GetHittableParts()
  for i = 0, hittableParts.Count - 1 do
    local partGo = hittableParts[i]
    if not IsNull(partGo) then
      self._hittableParts2Char[partGo:GetInstanceID()] = self._characterIndex
    end
  end
  self._allCharacters[self._characterIndex] = character
  return self._characterIndex
end

function DormFightCharacterCtrl:GetCharacter(characterId)
  return characterId and self._allCharacters[characterId]
end

function DormFightCharacterCtrl:GetMainCharacterByComp(comp)
  local ret
  for _, v in pairs(self._allCharacters) do
    if v:GetComp() == comp and v:IsMainCharacter() then
      ret = v
      break
    end
  end
  return ret
end

function DormFightCharacterCtrl:GetAllCharacter()
  return self._allCharacters
end

function DormFightCharacterCtrl:OnCharacterHitSomeone(triggerCharacterId, hitIndex, hitInstanceId, velocity)
  if not self._isDoing then
    return
  end
  if triggerCharacterId == nil or hitInstanceId == nil or self._hittableParts2Char[hitInstanceId] == nil then
    return -1
  end
  local hitCharacterId = self._hittableParts2Char[hitInstanceId]
  local hitCharacter = self:GetCharacter(hitCharacterId)
  if hitCharacter == nil then
    return -1
  end
  if self._hitIndexDict[triggerCharacterId] == nil then
    self._hitIndexDict[triggerCharacterId] = {}
  end
  local hitDict = self._hitIndexDict[triggerCharacterId]
  local lastHitIndex = hitDict[hitCharacterId] or -1
  if hitIndex == lastHitIndex then
    return
  end
  hitDict[hitCharacterId] = hitIndex
  local shouldKnockOut = false
  local vitalityCtrl = hitCharacter:GetFeature(DormFightConst.FeatureEnum.VitalityController)
  if vitalityCtrl ~= nil then
    vitalityCtrl:OnAttacked()
    shouldKnockOut = vitalityCtrl:ShouldKnockOut()
  end
  local sceneUiCtrl = hitCharacter:GetFeature(DormFightConst.FeatureEnum.SceneUiController)
  if sceneUiCtrl ~= nil then
    sceneUiCtrl:ShowVitalityNode()
  end
  local modelCtrl = hitCharacter:GetFeature(DormFightConst.FeatureEnum.ModelController)
  if shouldKnockOut then
    modelCtrl:PostEvent(DormFightConst.EventEnum.KnockOut, velocity)
    if self._someoneKnockOutDelegate ~= nil then
      self._someoneKnockOutDelegate(hitCharacter:GetComp())
    end
  else
    modelCtrl:PostEvent(DormFightConst.EventEnum.Hit, velocity)
  end
end

function DormFightCharacterCtrl:GetNearestEnemyPosition(comp, position, containMinor)
  local res
  local minSqrDistance = 999999
  for _, v in pairs(self._allCharacters) do
    if v:GetComp() ~= comp and (containMinor or v:IsMainCharacter()) then
      local tPosition = v:GetPosition()
      local dx = tPosition.x - position.x
      local dz = tPosition.z - position.z
      local sqrDistance = dx * dx + dz * dz
      if minSqrDistance > sqrDistance then
        res = tPosition
        minSqrDistance = sqrDistance
      end
    end
  end
  return res
end

function DormFightCharacterCtrl:SetSomeoneKnockOutDelegate(listener)
  self._someoneKnockOutDelegate = listener
end

function DormFightCharacterCtrl:DestroyAllCharacter()
  for _, character in pairs(self._allCharacters) do
    character:Destroy()
  end
  self._allCharacters = {}
  self._hittableParts2Char = {}
  self._hitIndexDict = {}
end

function DormFightCharacterCtrl:OnUpdate(deltaTime)
  if not self._isDoing then
    return
  end
  for _, v in pairs(self._allCharacters) do
    v:Update(deltaTime)
  end
end

function DormFightCharacterCtrl:OnFightTrueStart()
  self._isDoing = true
end

function DormFightCharacterCtrl:OnFightEnd()
  self._isDoing = false
end

function DormFightCharacterCtrl:OnEnterFightScene()
  if self._resLoader == nil then
    self._resLoader = CS.ResLoader.Create()
  end
end

function DormFightCharacterCtrl:OnExitFightScene()
  if self._resLoader ~= nil then
    self._resLoader:Put2Pool()
    self._resLoader = nil
  end
  self:DestroyAllCharacter()
end

return DormFightCharacterCtrl
