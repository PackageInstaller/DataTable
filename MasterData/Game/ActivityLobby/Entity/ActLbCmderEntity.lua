local ActLbCmderEntity = class("ActLbCmderEntity")
local ActLbEnum = require("Game.ActivityLobby.ActLbEnum")

function ActLbCmderEntity:ctor()
end

function ActLbCmderEntity:InitActLbCmderEntity(cmderCtrl, cmderHeadFxGo, cmderObject, playerRigidbodyTran)
  self._cmderCtrl = cmderCtrl
  self:_InitHeadFx(cmderHeadFxGo, cmderObject)
  self.gameObject = cmderObject
  self.transform = cmderObject.transform
  self.animator = cmderObject:FindComponent(eUnityComponentID.Animator)
  self.animator:SetBool("DormMoveRun", true)
  self.cmderCharacter = CS.DormAStarCharacter.Create(cmderObject)
  self.cmderCharacter:AddAStarComponents(true)
  self.cmderCharacter.aiPath.canSearch = false
  self.cmderCharacter.aiPath.rotationSpeed = 1000
  self.cmderCharacter.aiPath.slowWhenNotFacingTarget = false
  self.playerRigidbodyTranPrent = playerRigidbodyTran.parent
  self.playerRigidbodyTran = playerRigidbodyTran
  playerRigidbodyTran:SetParent(self.transform, false)
  local listener = CS.ColliderEventListener.Get(playerRigidbodyTran.gameObject)
  listener:TriggerEnterEvent("+", BindCallback(self, self._OnTriggerEnter))
  listener:TriggerExitEvent("+", BindCallback(self, self._OnTriggerExit))
  playerRigidbodyTran.gameObject:SetActive(false)
  playerRigidbodyTran.gameObject:SetActive(true)
  self._characterUnit = self.gameObject:GetComponent(typeof(CS.CharacterUnit))
  if IsNull(self._characterUnit) then
    error("cant get CharacterUnit on character, obj:" .. self.gameObject.name)
  end
end

function ActLbCmderEntity:SetEndReachedDistance(num)
  self.cmderCharacter.aiPath.endReachedDistance = num
end

function ActLbCmderEntity:SetColliderShow(bool)
  if self._collider == nil then
    self._collider = self.gameObject:GetComponent(typeof(CS.UnityEngine.Collider))
  end
  self._collider.enabled = bool
end

function ActLbCmderEntity:_InitHeadFx(cmderHeadFxGo, cmderObject)
  self._cmderHeadFxGo = cmderHeadFxGo
  local posConstraint = cmderHeadFxGo:GetComponent(typeof(CS.UnityEngine.Animations.PositionConstraint))
  if posConstraint ~= nil then
    local constraintSource = posConstraint:GetSource(0)
    local headPath = self._cmderCtrl:GetActLbCmderResPath() .. "/root/Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Neck/Bip001 Head"
    local headTran = cmderObject.transform:Find(headPath)
    if IsNull(headTran) then
      warn("Commander head point is null : " .. tostring(headPath))
    end
    constraintSource.sourceTransform = headTran
    posConstraint:SetSource(0, constraintSource)
  end
end

function ActLbCmderEntity:SetActLbCmdMoveSpeed(speed)
  self.cmderCharacter.speed = speed
  self.cmderCharacter.aiPath.maxSpeed = speed
end

function ActLbCmderEntity:SetActLbCmdPos(posV3)
  self.transform.position = posV3
end

function ActLbCmderEntity:SetActLbCmdRotation(qua)
  if qua == nil then
    return
  end
  self.transform.rotation = qua
end

function ActLbCmderEntity:SetLbCmderStarAIPathActive(active)
  self.cmderCharacter.aiPath.canMove = active
end

function ActLbCmderEntity:GetActLbCmdPos()
  return self.transform.position
end

function ActLbCmderEntity:GetActLbCmdRotation()
  return self.transform.rotation
end

function ActLbCmderEntity:GetLbCharAStarComp()
  return self.cmderCharacter
end

function ActLbCmderEntity:ActLbCmderStartMove(moveData)
  self:SetLbCmderStarAIPathActive(true)
  self.cmderCharacter:MoveByJoystickData(moveData)
  self:SetLbCmdMoveAniSpeed(self.cmderCharacter.aiPath.velocity.magnitude)
  self._cmderCtrl.actLbCtrl.actLbCamCtrl:SetActLbCamFollowTarget(self.transform)
  self:PlayActLbCmdMoveAudio(true)
end

function ActLbCmderEntity:SetLbCmdMoveAniSpeed(value)
  self.animator:SetFloat("DormWalkSpeed", value)
end

function ActLbCmderEntity:LbCmdEntMoveDestPos(worldPos)
  self._cmderCtrl.actLbCtrl.actLbCamCtrl:SetActLbCamFollowTarget(self.transform)
  self:SetLbCmderStarAIPathActive(true)
  self.cmderCharacter:StopSmoothDownSpeed()
  self:PlayActLbCmdMoveAudio(true)
  self.cmderCharacter:MoveDestPos(worldPos, function(ok)
    self:PlayActLbCmdMoveAudio(false)
    self.cmderCharacter:StopSmoothDownSpeed(true)
  end, true, 0)
  self.cmderCharacter.aiPath:SearchPath()
end

function ActLbCmderEntity:LbCmderEndMove()
  self.cmderCharacter:ForceStopMove()
  self.cmderCharacter:StartSmoothDownSpeed()
  self:PlayActLbCmdMoveAudio(false)
end

function ActLbCmderEntity:_OnTriggerEnter(collider)
  if ActLbEnum.InteractRangeName ~= collider.name then
    return
  end
  self._cmderCtrl.actLbCtrl.actLbIntrctCtrl:OnLbInteractChange(collider.gameObject, true)
end

function ActLbCmderEntity:_OnTriggerExit(collider)
  if ActLbEnum.InteractRangeName ~= collider.name then
    return
  end
  self._cmderCtrl.actLbCtrl.actLbIntrctCtrl:OnLbInteractChange(collider.gameObject, false)
end

function ActLbCmderEntity:LbCmdStartSmoothLookAtTarget(transform, action)
  self.cmderCharacter:StartSmoothLookAtTarget(transform, action)
end

function ActLbCmderEntity:PlayActLbCmdMoveAudio(isPlay)
  do return end
  if isPlay then
    if self._moveAuBack ~= nil then
      return
    end
    self._moveAuBack = AudioManager:PlayAudioById(1254, function(auback)
      if self._moveAuBack == auback then
        self._moveAuBack = nil
      end
    end)
  elseif self._moveAuBack then
    AudioManager:StopAudioByBack(self._moveAuBack)
    self._moveAuBack = nil
  end
end

function ActLbCmderEntity:HideLbEnttRenderer(hide)
  if IsNull(self._characterUnit) then
    return
  end
  if self._renderList == nil then
    self._renderList = {}
    for i = 0, self._characterUnit.smrArray.Length - 1 do
      table.insert(self._renderList, self._characterUnit.smrArray[i])
    end
    for i = 0, self._characterUnit.extraRendererArray.Length - 1 do
      table.insert(self._renderList, self._characterUnit.extraRendererArray[i])
    end
  end
  for k, renderer in ipairs(self._renderList) do
    renderer.gameObject:SetActive(not hide)
  end
  self._cmderHeadFxGo:SetActive(not hide)
end

function ActLbCmderEntity:OnDelete()
  self._collider = nil
  self:PlayActLbCmdMoveAudio(false)
  self.playerRigidbodyTran:SetParent(self.playerRigidbodyTranPrent, false)
  DestroyUnityObject(self.gameObject, true)
end

return ActLbCmderEntity
