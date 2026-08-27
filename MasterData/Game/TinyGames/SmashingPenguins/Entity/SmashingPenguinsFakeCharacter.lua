local base = require("Game.TinyGames.SmashingPenguins.Entity.SmashingPenguinsCharacterEntity")
local SmashingPenguinsFakeCharacter = class("SmashingPenguinsFakeCharacter", base)
local SmashingPenguinsEnum = require("Game.TinyGames.SmashingPenguins.Enum.SmashingPenguinsEnum")
local SmashingPenguinsCharacterAnimState = SmashingPenguinsEnum.eCharacterAnimState
local SmashingPenguinsConfig = require("Game.TinyGames.SmashingPenguins.Config.SmashingPenguinsConfig")
local CS_UnityEngine_ForceMode = CS.UnityEngine.ForceMode2D

function SmashingPenguinsFakeCharacter:_OnCollisionEnter(collider)
  if self.canPlayRollAnim then
    self:SetSmashingPenguinsAnimState(SmashingPenguinsCharacterAnimState.Roll)
  end
end

function SmashingPenguinsFakeCharacter:LookAtDir(moveForward, forceSet)
  if not forceSet and not self.canLookAtDir then
    moveForward.y = 0
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

return SmashingPenguinsFakeCharacter
