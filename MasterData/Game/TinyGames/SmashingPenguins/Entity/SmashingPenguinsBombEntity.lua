local base = require("Game.TinyGames.SmashingPenguins.Entity.SmashingPenguinsEntityBase")
local SmashingPenguinsBombEntity = class("SmashingPenguinsBombEntity", base)

function SmashingPenguinsBombEntity:OnInit()
  base.OnInit(self)
  local listener = CS.ColliderEventListener.Get(self.transform)
  listener:TriggerEnter2DEvent("+", BindCallback(self, self._OnTriggerEnter))
  listener:TriggerExit2DEvent("+", BindCallback(self, self._OnTriggerLeave))
end

function SmashingPenguinsBombEntity:InitEntityData(characterEntity, controller)
  self.isUsed = false
  base.InitEntityData(self, characterEntity, controller)
end

function SmashingPenguinsBombEntity:_OnTriggerEnter(collider)
  if self.isUsed then
    return
  end
  if collider.gameObject == self.characterEntity.gameObject then
    if self.mainController.getBomb then
      self.mainController:ReGetBomb(self)
      return
    end
    self:SetBombGotten()
  end
end

function SmashingPenguinsBombEntity:_OnTriggerLeave()
  self.mainController:RemoveReGetBomb(self)
end

function SmashingPenguinsBombEntity:SetBombGotten()
  self.mainController:GetBomb()
  self.isUsed = true
  self:Hide()
end

function SmashingPenguinsBombEntity:OnHide()
  self.mainController:RemoveReGetBomb(self)
end

return SmashingPenguinsBombEntity
