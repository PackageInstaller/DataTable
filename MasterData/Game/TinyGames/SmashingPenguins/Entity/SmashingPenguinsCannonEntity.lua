local base = require("Game.TinyGames.SmashingPenguins.Entity.SmashingPenguinsEntityBase")
local SmashingPenguinsCannonEntity = class("SmashingPenguinsCannonEntity", base)
local SmashingPenguinsEnum = require("Game.TinyGames.SmashingPenguins.Enum.SmashingPenguinsEnum")
local SmashingPenguinsGameState = SmashingPenguinsEnum.eGameState
local SmashingPenguinsAnimState = SmashingPenguinsEnum.eCharacterAnimState
local cs_Object = CS.UnityEngine.Object
local cs_Image = CS.UnityEngine.UI.Image

function SmashingPenguinsCannonEntity:OnInit()
  base.OnInit(self)
  local listener = CS.ColliderEventListener.Get(self.transform)
  listener:TriggerEnter2DEvent("+", BindCallback(self, self._OnTriggerEnter))
  local upLineImg = self.ui.obj_upLine:GetComponent(typeof(cs_Image))
  self.upLineMat = cs_Object.Instantiate(upLineImg.material)
  upLineImg.material = self.upLineMat
  local downLineImg = self.ui.obj_downLine:GetComponent(typeof(cs_Image))
  self.downLineMat = cs_Object.Instantiate(downLineImg.material)
  downLineImg.material = self.downLineMat
end

function SmashingPenguinsCannonEntity:InitEntityData(characterEntity, controller)
  self.isUsed = false
  self:UpdateCannonLine(self.transform.position)
  self.ui.obj_upLineHolder:SetActive(true)
  self.ui.obj_downLineHolder:SetActive(true)
  base.InitEntityData(self, characterEntity, controller)
end

function SmashingPenguinsCannonEntity:_OnTriggerEnter(collider)
  if self.isUsed then
    return
  end
  if collider.gameObject == self.characterEntity.gameObject then
    self.characterEntity:SetSmashingPenguinsUseGravity(false)
    self.characterEntity:SetSmashingPenguinsColliderEnabled(false)
    self.characterEntity.rigidbody.velocity = Vector3.zero
    self.mainController.isMovingToCannon = true
    self.mainController:SetSmashingPenguinsCannon(self)
    self:MoveCharacterHere(function()
      self.mainController:SetSmashingPenguinsGameState(SmashingPenguinsGameState.PrepareToFly)
      self.mainController.isMovingToCannon = false
    end)
  end
end

function SmashingPenguinsCannonEntity:MoveCharacterHere(callback)
  self.characterEntity.transform:DOKill(false)
  self.characterEntity.transform:DOLocalMove(self.transform.localPosition, 0.2):SetLink(self.gameObject):OnComplete(function()
    self.characterEntity.transform.position = self.transform.position
    callback()
  end)
end

function SmashingPenguinsCannonEntity:SetConnonIsUsed()
  self.isUsed = true
  self.ui.obj_upLineHolder:SetActive(false)
  self.ui.obj_downLineHolder:SetActive(false)
end

function SmashingPenguinsCannonEntity:UpdateCannonLine(worldPos)
  if self.isUsed then
    return
  end
  local characterUpLocalPos = self.ui.obj_upLineHolder.transform:InverseTransformPoint(worldPos)
  local characterDownLocalPos = self.ui.obj_downLineHolder.transform:InverseTransformPoint(worldPos)
  local upDir = worldPos - self.ui.obj_upCannon.transform.position
  self:LineLookAtDir(upDir, self.ui.obj_upLine)
  local downDir = worldPos - self.ui.obj_downCannon.transform.position
  self:LineLookAtDir(downDir, self.ui.obj_downLine)
  local newUpWidth = Mathf.Sqrt(Mathf.Pow(self.transform.rect.height * 0.5, 2) + Mathf.Pow(characterUpLocalPos.x, 2))
  local newDownWidth = Mathf.Sqrt(Mathf.Pow(self.transform.rect.height * 0.5, 2) + Mathf.Pow(characterDownLocalPos.x, 2))
  local upLineTransform = self.ui.obj_upLine.transform
  local currentUpRect = upLineTransform.rect
  upLineTransform.sizeDelta = Vector2.New(newUpWidth, currentUpRect.height)
  self.upLineMat:SetTextureScale("_MainTex", Vector2.New(Mathf.Floor(newUpWidth / currentUpRect.height), 1))
  local downLineTransform = self.ui.obj_downLine.transform
  local currentDownRect = downLineTransform.rect
  downLineTransform.sizeDelta = Vector2.New(newDownWidth, currentDownRect.height)
  self.downLineMat:SetTextureScale("_MainTex", Vector2.New(Mathf.Floor(newDownWidth / currentDownRect.height), 1))
end

function SmashingPenguinsCannonEntity:LineLookAtDir(dir, lineImgGo)
  local forward = Vector3.New(-dir.y, dir.x, 0)
  local rotation = Quaternion.LookRotation(Vector3.forward, forward)
  lineImgGo.transform.rotation = rotation
end

return SmashingPenguinsCannonEntity
