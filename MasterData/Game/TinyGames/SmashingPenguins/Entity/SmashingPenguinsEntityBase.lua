local SmashingPenguinsEntityBase = class("SmashingPenguinsEntityBase", UIBaseNode)

function SmashingPenguinsEntityBase:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.canLookAtDir = true
  self.characterEntity = nil
  self.mainController = nil
end

function SmashingPenguinsEntityBase:InitEntityData(characterEntity, controller)
  self.characterEntity = characterEntity
  self.mainController = controller
end

function SmashingPenguinsEntityBase:GetLocalUnityBorder()
  local leftX = self.transform.localPosition.x + self.transform.rect.xMin
  local rightX = self.transform.localPosition.x + self.transform.rect.xMax
  local downY = self.transform.localPosition.y + self.transform.rect.yMin
  local upY = self.transform.localPosition.y + self.transform.rect.yMax
  return leftX, rightX, downY, upY
end

function SmashingPenguinsEntityBase:LookAtDir(moveForward)
  local localScale = self.transform.localScale
  self.transform.localScale = localScale
  local forward = Vector3.New(moveForward.y, -moveForward.x, 0)
  local rotation = Quaternion.LookRotation(Vector3.forward, forward)
  self.transform.rotation = rotation
end

return SmashingPenguinsEntityBase
