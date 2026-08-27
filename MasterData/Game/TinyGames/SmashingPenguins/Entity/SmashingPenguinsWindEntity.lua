local base = require("Game.TinyGames.SmashingPenguins.Entity.SmashingPenguinsEntityBase")
local SmashingPenguinsWindEntity = class("SmashingPenguinsWindEntity", base)
local SmashingPenguinsConfig = require("Game.TinyGames.SmashingPenguins.Config.SmashingPenguinsConfig")
local SmashingPenguinsEnum = require("Game.TinyGames.SmashingPenguins.Enum.SmashingPenguinsEnum")
local SmashingPenguinsCharacterAnimState = SmashingPenguinsEnum.eCharacterAnimState

function SmashingPenguinsWindEntity:OnInit()
  base.OnInit(self)
  local listener = CS.ColliderEventListener.Get(self.transform)
  listener:TriggerEnter2DEvent("+", BindCallback(self, self._OnTriggerEnter))
end

function SmashingPenguinsWindEntity:_OnTriggerEnter(collider)
  if collider.gameObject == self.characterEntity.gameObject then
    AudioManager:PlayAudioById(1281)
    local force = Vector2.New(SmashingPenguinsConfig.WindForce.x, SmashingPenguinsConfig.WindForce.y)
    local forceDir = force.normalized
    local forcePower = force.magnitude
    local velocity = self.characterEntity.rigidbody.velocity
    if velocity.x > 0 then
      velocity.x = velocity.x * SmashingPenguinsConfig.VelocityMultipleBeforeWind.x
    end
    if velocity.y < 0 then
      velocity.y = velocity.y * SmashingPenguinsConfig.VelocityMultipleBeforeWind.y
    end
    self.characterEntity.rigidbody.velocity = velocity
    self.characterEntity:AddForceToSmashingPenguinsCharacter(forceDir, forcePower)
    self.characterEntity:SetSmashingPenguinsAnimState(SmashingPenguinsCharacterAnimState.Roll)
  end
end

return SmashingPenguinsWindEntity
