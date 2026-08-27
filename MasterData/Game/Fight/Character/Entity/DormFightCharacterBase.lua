local FeatureFactory = require("Game.Fight.Character.Feature.FeatureFactory")
local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCharacterBase = class("DormFightCharacterBase")

function DormFightCharacterBase:ctor()
  self._uniqueId = -1
  self._comp = -1
  self._name = nil
  self._isMainCharacter = false
  self.gameObject = nil
  self.transform = nil
  self.characterCo = nil
  self.rigidBody = nil
  self.collider = nil
  self.ragBody = nil
  self.animator = nil
  self.modelRoot = nil
  self._featureDict = {}
  self._hitIndex = 0
  self._hitEnabled = false
  self._onHitSomething = nil
end

function DormFightCharacterBase:Initialize(uniqueId, isMainCharacter, name, comp, modelGameObject)
  self._uniqueId = uniqueId
  self._isMainCharacter = isMainCharacter or false
  self._comp = comp
  self._name = name
  self.gameObject = modelGameObject
  self.transform = modelGameObject.transform
  self.characterCo = modelGameObject:GetComponent(typeof(CS.FightDemo.Character.CharacterComponent))
  self.rigidBody = self.characterCo.rigidbody
  self.collider = self.characterCo.collider
  self.ragBody = self.characterCo.ragBody
  self.animator = self.characterCo.animator
  self.modelRoot = self.characterCo.model
  self:SetIgnoreWallCollider(true)
  self:FillFeatures()
  self.characterCo.onHitSomeone:AddListener(BindCallback(self, self.OnHitSomeone))
  for _, v in pairs(self._featureDict) do
    v:Init(self)
  end
end

function DormFightCharacterBase:IsMainCharacter()
  return self._isMainCharacter
end

function DormFightCharacterBase:OnHitSomeone(collision, velocity)
  local instanceId = collision.gameObject:GetInstanceID()
  if self._onHitSomething ~= nil then
    self._onHitSomething(self._uniqueId, self._hitIndex, instanceId, velocity)
  end
end

function DormFightCharacterBase:AddHitSomeoneListener(listener)
  self._onHitSomething = listener
end

function DormFightCharacterBase:GetHittableParts()
  return not IsNull(self.characterCo) and self.characterCo.hittableParts or {}
end

function DormFightCharacterBase:GetComp()
  return self._comp or -1
end

function DormFightCharacterBase:GetName()
  return self._name or ""
end

function DormFightCharacterBase:GetPosition()
  return not IsNull(self.rigidBody) and self.rigidBody.position or Vector3.zero
end

function DormFightCharacterBase:SetHandDetectHit(hitEnabled)
  if hitEnabled == self._hitEnabled or IsNull(self.characterCo) then
    return
  end
  self._hitEnabled = hitEnabled
  self._hitIndex = self._hitIndex + 1
  self.characterCo:SetHandDetectHit(hitEnabled)
end

function DormFightCharacterBase:AddFeature(featureType)
  local featureInst = FeatureFactory.CreateFeature(featureType)
  self._featureDict[featureType] = featureInst
end

function DormFightCharacterBase:GetFeature(featureType)
  return featureType and self._featureDict[featureType]
end

function DormFightCharacterBase:GetCharacterType()
  return DormFightConst.CharacterType.Undefined
end

function DormFightCharacterBase:FillFeatures()
end

function DormFightCharacterBase:SetIgnoreWallCollider(ignore)
  if IsNull(self.characterCo) then
    return
  end
  local dormFightCtrl = ControllerManager:GetController(ControllerTypeId.DormFight)
  local sceneCtrl = dormFightCtrl:GetSceneCtrl()
  local wallsList = sceneCtrl:GetWallList()
  for _, wall in ipairs(wallsList) do
    self.characterCo:SetIgnoreWallColliders(ignore, wall)
  end
end

function DormFightCharacterBase:Update(deltaTime)
  for _, v in pairs(self._featureDict) do
    v:Update(deltaTime)
  end
end

function DormFightCharacterBase:Destroy()
  if not IsNull(self.gameObject) then
    DestroyUnityObject(self.gameObject, true)
  end
  self.gameObject = nil
  self.transform = nil
  self.characterCo = nil
  self.rigidBody = nil
  self.collider = nil
  self.ragBody = nil
  self.animator = nil
  for _, v in pairs(self._featureDict) do
    v:Destroy()
  end
  self._featureDict = nil
end

return DormFightCharacterBase
