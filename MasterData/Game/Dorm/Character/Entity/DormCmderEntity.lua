local DormRoleBaseEntity = require("Game.Dorm.Character.Entity.DormRoleBaseEntity")
local DormCmderEntity = class("DormCmderEntity", DormRoleBaseEntity)
local DormCharacterAI = require("Game.Dorm.Character.AI.DormCharacterAI")
local DormEnum = require("Game.Dorm.DormEnum")
local DormUtil = require("Game.Dorm.DormUtil")

function DormCmderEntity:ctor()
  self.__resName = DormUtil.GetDormCmderResName()
end

function DormCmderEntity:InitDormCmderEntity(gameObject)
  self.gameObject = gameObject
  self.transform = gameObject.transform
  self.animator = self.gameObject:FindComponent(eUnityComponentID.Animator)
  self.cmderCharacter = CS.DormAStarCharacter.Create(self.gameObject)
  self.cmderCharacter.speed = self:GetDormMoveSpeed()
  self.cmderCharacter:AddAStarComponents(true)
  self.cmderCharacter.aiPath.enableRotation = false
  if ConfigData.buildinConfig.DormStopCollideFeature then
    self.cmderCharacter.rvoController.lockWhenNotMoving = true
  end
  local cmderAIID = DormUtil.GetDormCmderConfig().ai_id
  local aiCfg = ConfigData.dorm_ai[cmderAIID]
  if aiCfg == nil then
    error("cmder ai config is null, aiId:" .. tostring(cmderAIID))
    return
  end
  self.aiCtrl = DormCharacterAI.New(aiCfg, self)
  self.__OnStartFntInteract = BindCallback(self, self.__StartFntInteract)
  self.__OnStartExitInteract = BindCallback(self, self.__StartExitInteract)
  self.aiCtrl:AddListenerForDormAI(DormEnum.CharacterAIEventId.StartFntInteract, self.__OnStartFntInteract)
  self.aiCtrl:AddListenerForDormAI(DormEnum.CharacterAIEventId.ExitFntInteract, self.__OnStartExitInteract)
end

function DormCmderEntity:GetRoleName()
  return ConfigData:GetTipContent(14022)
end

function DormCmderEntity:GetDormRoleResName()
  return self.__resName
end

function DormCmderEntity:GetCharAStarComp()
  return self.cmderCharacter
end

function DormCmderEntity:GetBelongRoomEntity()
  return self.__roomEntity
end

function DormCmderEntity:GetDormMoveSpeed()
  return DormUtil.GetDormCmderConfig().dorm_move_spd
end

function DormCmderEntity:CmderAddToRoom(roomEntity, initPos)
  self.__roomEntity = roomEntity
  self.transform:SetParent(roomEntity.characterHolder)
  self.transform.position = initPos
end

function DormCmderEntity:ShowDormCmder()
  self.gameObject:SetActive(true)
end

function DormCmderEntity:HideDormCmder()
  self.gameObject:SetActive(false)
end

function DormCmderEntity:CmderStartMove(moveData)
  self.cmderCharacter:MoveByJoystickData(moveData)
  self:SetMoveAniSpeed(moveData.power)
end

function DormCmderEntity:CmderEndMove()
  self:GetCharAStarComp():StartSmoothDownSpeed()
end

function DormCmderEntity:__StartFntInteract()
  self:SetStarAIPathActive(false)
  self:SetNavmeshCutActive(false)
end

function DormCmderEntity:__StartExitInteract()
  self:SetNavmeshCutActive(true)
end

function DormCmderEntity:HidePauseCmder()
  self:GetCharAStarComp().isPause = true
  self:GetCharAStarComp().aiPath.enabled = false
  self.__position = self.transform.position
  self.transform.position = DormEnum.DormInvisiblePos
  self.animator.speed = 0
  if self.curTweener ~= nil then
    self.curTweener:Pause()
  end
end

function DormCmderEntity:ShowResumeCmder()
  if self.__position ~= nil then
    self.transform.position = self.__position
  end
  self.animator.speed = 1
  self:GetCharAStarComp().isPause = false
  self:GetCharAStarComp().aiPath.enabled = true
  if self.curTweener ~= nil then
    self.curTweener:Play()
  end
end

function DormCmderEntity:OnDelete()
  DormRoleBaseEntity.OnDelete(self)
  self.cmderCharacter = nil
  self.aiCtrl = nil
end

return DormCmderEntity
