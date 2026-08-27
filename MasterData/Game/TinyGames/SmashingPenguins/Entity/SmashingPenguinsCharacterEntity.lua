local SmashingPenguinsEntityBase = require("Game.TinyGames.SmashingPenguins.Entity.SmashingPenguinsEntityBase")
local SmashingPenguinsCharacterEntity = class("SmashingPenguinsCharacterEntity", SmashingPenguinsEntityBase)
local base = SmashingPenguinsEntityBase
local SmashingPenguinsEnum = require("Game.TinyGames.SmashingPenguins.Enum.SmashingPenguinsEnum")
local SmashingPenguinsCharacterAnimState = SmashingPenguinsEnum.eCharacterAnimState
local SmashingPenguinsConfig = require("Game.TinyGames.SmashingPenguins.Config.SmashingPenguinsConfig")
local CS_UnityEngine_ForceMode = CS.UnityEngine.ForceMode2D
local SmashingPenguinsGameState = SmashingPenguinsEnum.eGameState

function SmashingPenguinsCharacterEntity:OnInit()
  base.OnInit(self)
  self.rigidbody = self.ui.rig_characterRigidbody
  self.collider = self.ui.collider_shengCan
  local listener = CS.ColliderEventListener.Get(self.transform)
  listener:CollisionEnter2DEvent("+", BindCallback(self, self._OnCollisionEnter))
end

function SmashingPenguinsCharacterEntity:InitEntityData(characterEntity, controller)
  self:SetSmashingPenguinsAnimState(SmashingPenguinsCharacterAnimState.Cry)
  self._currentLogicFrameNumRoll = 0
  base.InitEntityData(self, characterEntity, controller)
  self.canPlayCollisionAudio = true
  self.canLookAtDir = true
  self.canPlayRollAnim = true
end

function SmashingPenguinsCharacterEntity:SetSmashingPenguinsAnimState(animState)
  if IsNull(self.ui.array_characterAnimState[animState]) then
    return
  end
  if not IsNull(self.currentAnimState) and not IsNull(self.ui.array_characterAnimState[self.currentAnimState]) then
    self.ui.array_characterAnimState[self.currentAnimState].gameObject:SetActive(false)
  end
  self._currentLogicFrameNumRoll = 0
  self.ui.array_characterAnimState[animState].gameObject:SetActive(true)
  self.currentAnimState = animState
end

function SmashingPenguinsCharacterEntity:UpdateSmashingPenguinsAnimState()
  if self.currentAnimState ~= SmashingPenguinsCharacterAnimState.Roll then
    return
  end
  self._currentLogicFrameNumRoll = self._currentLogicFrameNumRoll + 1
  if self._currentLogicFrameNumRoll > SmashingPenguinsConfig.MaxLogicFrameNumKeepRoll then
    self:SetSmashingPenguinsAnimState(SmashingPenguinsCharacterAnimState.Cry)
  end
end

function SmashingPenguinsCharacterEntity:SetSmashingPenguinsUseGravity(isUseGravity)
  if isUseGravity == false then
    self.rigidbody.gravityScale = 0
    self.rigidbody.velocity = Vector2.zero
  else
    self.rigidbody.gravityScale = SmashingPenguinsConfig.GravityScale
  end
end

function SmashingPenguinsCharacterEntity:SetSmashingPenguinsColliderEnabled(isEnabled)
  self.collider.enabled = isEnabled == true
end

function SmashingPenguinsCharacterEntity:AddForceToSmashingPenguinsCharacter(forceDir, forcePower, maxForcePower)
  if maxForcePower ~= nil then
    forcePower = math.clamp(forcePower, 0, maxForcePower)
  else
    forcePower = math.clamp(forcePower, 0, forcePower)
  end
  local force = Vector2.New(forceDir.x * forcePower, forceDir.y * forcePower)
  self.rigidbody:AddForce(force, CS_UnityEngine_ForceMode.Impulse)
end

function SmashingPenguinsCharacterEntity:_OnCollisionEnter(collider)
  if self.mainController:GetSmashingPenguinsGameState() == SmashingPenguinsGameState.Fly then
    if self.canPlayCollisionAudio then
      AudioManager:PlayAudioById(1278)
    end
    if self.canPlayRollAnim then
      self:SetSmashingPenguinsAnimState(SmashingPenguinsCharacterAnimState.Roll)
    end
  end
end

function SmashingPenguinsCharacterEntity:LookAtDir(moveForward, forceSet)
  if not forceSet then
    if not self.canLookAtDir then
      moveForward.y = 0
    end
    if self.mainController:GetSmashingPenguinsGameState() == SmashingPenguinsGameState.PrepareToFly then
      return
    end
  end
  local localScale = self.transform.localScale
  if 0 >= moveForward.x then
    localScale.y = math.abs(localScale.y)
  else
    localScale.y = -math.abs(localScale.y)
  end
  self.transform.localScale = localScale
  local forward = Vector3.New(moveForward.y, -moveForward.x, 0)
  local rotation = Quaternion.LookRotation(Vector3.forward, forward)
  self.transform.rotation = rotation
end

return SmashingPenguinsCharacterEntity
