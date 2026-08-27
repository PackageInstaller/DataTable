local DormRoleBaseEntity = class("DormRoleBaseEntity")
local DormUtil = require("Game.Dorm.DormUtil")
local DormEnum = require("Game.Dorm.DormEnum")
local cs_DormAStarUtils = CS.DormAStarUtils
local cs_ParentContraint = CS.UnityEngine.Animations.ParentConstraint
local cs_ConstraintSource = CS.UnityEngine.Animations.ConstraintSource
local speed = 0.5

function DormRoleBaseEntity:GetBelongRoomEntity()
  return nil
end

function DormRoleBaseEntity:GetDormRoleResName()
end

function DormRoleBaseEntity:GetDormMoveSpeed()
end

function DormRoleBaseEntity:TargetPosPossible(pos)
  return self:GetCharAStarComp():IsPathPossible(self.transform.position, pos)
end

function DormRoleBaseEntity:GetCharAStarComp()
  return nil
end

function DormRoleBaseEntity:DoMoveAStar(pos, completeAction, timeout, reachVelocity, noEndSpeedZero)
  reachVelocity = reachVelocity or false
  noEndSpeedZero = noEndSpeedZero or false
  local possible = self:TargetPosPossible(pos)
  if not possible then
    return false
  end
  self:GetCharAStarComp():MoveDestPos(pos, function(success)
    if not noEndSpeedZero then
      self:SetMoveAniSpeed(0)
    end
    if completeAction ~= nil then
      completeAction(success)
    end
  end, reachVelocity, timeout)
  return true
end

function DormRoleBaseEntity:ListenerAIEvent(eventId, action)
  self.aiCtrl:AddListenerForDormAI(eventId, action)
end

function DormRoleBaseEntity:SetNavmeshCutActive(active)
  self:GetCharAStarComp():SetNavMeshCutEnabled(active)
end

function DormRoleBaseEntity:SetStarAIPathActive(active)
  self:GetCharAStarComp().aiPath.canMove = active
end

function DormRoleBaseEntity:SetUnityPos(pos)
  self.transform.localPosition = pos
end

function DormRoleBaseEntity:SetUnityWorldPos(pos)
  self.transform.position = pos
end

function DormRoleBaseEntity:SetLocalRotation(rot)
  self.transform.localRotation = rot
end

function DormRoleBaseEntity:SetObjectActive(active)
  self.gameObject:SetActive(active)
end

function DormRoleBaseEntity:AnimatorCrossFade(aniName, transTime)
  transTime = transTime or 0.25
  self.animator:CrossFadeInFixedTime(aniName, transTime)
end

function DormRoleBaseEntity:GetAnimLength(aniName, forceRefresh)
  if IsNull(self.animator) then
    return -1
  end
  if self._animLength == nil then
    self._animLength = {}
  end
  if self._animLength[aniName] ~= nil and forceRefresh == false then
    return self._animLength[aniName]
  end
  local animationClips = self.animator.runtimeAnimatorController.animationClips
  for i = 0, animationClips.Length - 1 do
    if animationClips[i].name == string.lower(aniName) then
      self._animLength[aniName] = animationClips[i].length
      return self._animLength[aniName]
    end
  end
  return -1
end

function DormRoleBaseEntity:AnimatorTrigger(trigger)
  self.animator:SetTrigger(trigger)
end

function DormRoleBaseEntity:AnimatorStand()
  self.animator:ResetTrigger("DormFloat")
  self.animator:SetTrigger("DormStand")
end

function DormRoleBaseEntity:AnimatorFloat()
  self.animator:ResetTrigger("DormStand")
  self.animator:SetTrigger("DormFloat")
end

function DormRoleBaseEntity:ResetAnimatorTrigger()
  self.animator:ResetTrigger("DormFloat")
  self.animator:ResetTrigger("DormStand")
end

function DormRoleBaseEntity:SetMoveAniSpeed(value)
  self.animator:SetFloat("DormWalkSpeed", value)
end

function DormRoleBaseEntity:DormLogicToWorld(logicpos)
  local x, y = DormUtil.FntCoord2XY(logicpos)
  local destPos = DormUtil.GetFntUnityCoord(x, y)
  local worldPos = self.transform.parent:TransformPoint(destPos)
  return worldPos
end

function DormRoleBaseEntity:DoMoveInteractCurve(curveId, interActionId, pos)
  local dormConfig = DormUtil.GetDormConfigAsset()
  self.curTweener = dormConfig:StartInteractMove(self:GetDormRoleResName(), interActionId, curveId - 1, self.transform, pos):OnComplete(function()
    self.curTweener = nil
  end)
end

function DormRoleBaseEntity:DoMoveUnityPos(pos, completeAction)
  local destPos = pos
  local curPos = self.transform.position
  local moveTime = Vector3.Distance(curPos, destPos) / (speed * self:GetDormMoveSpeed())
  local forward = destPos - curPos
  forward = Vector3.New(forward.x, forward.y, forward.z)
  if forward:Magnitude() > 0 then
    self.transform.rotation = Quaternion.LookRotation(forward, Vector3.up)
  end
  local lastPos = 0
  self.curTweener = self.transform:DOMove(destPos, moveTime):OnComplete(function()
    self.curTweener = nil
    if completeAction ~= nil then
      completeAction()
    end
  end):OnUpdate(function()
    local curPos = GR.GetTweenEaseValue(self.curTweener)
    local pos = curPos - lastPos
    lastPos = curPos
    local avgPos = Time.deltaTime / moveTime
    local velocity = pos / avgPos
    self:SetMoveAniSpeed(velocity)
  end)
end

function DormRoleBaseEntity:SetLogicPos(x, y)
  self.x = x
  self.y = y
  local destPos = DormUtil.GetFntUnityCoord(x, y)
  self.transform.localPosition = destPos
end

function DormRoleBaseEntity:SetCharacterPosFromUnity(unityPos)
  local newX, newY = DormUtil.UnityCoord2Fnt(unityPos, DormEnum.eDormFntType.Furniture)
  local oldX = self.x
  local oldY = self.y
  local move = newX ~= oldX or newY ~= oldY
  if move then
    local roomEntity = self:GetBelongRoomEntity()
    if roomEntity == nil or not DormUtil.IsFntCoordLegal(newX, newY, roomEntity.roomData:GetRoomGridLengthCount()) then
      move = false
    end
  end
  if move then
    self:SetLogicPos(newX, newY)
  end
  return move, newX, newY
end

function DormRoleBaseEntity:QuickExitAIState()
  if self.curTweener ~= nil then
    self.curTweener:Kill()
    self.curTweener = nil
  end
  self.aiCtrl:AIInterruptCurrState(true)
end

function DormRoleBaseEntity:AIStartExitWait(action, ...)
  self.aiCtrl:AIStartExitWait(action, ...)
end

function DormRoleBaseEntity:DormForceStopMove()
  local astarCharcter = self:GetCharAStarComp()
  if astarCharcter ~= nil then
    astarCharcter:ForceStopMove()
  end
  self:SetMoveAniSpeed(0)
  if self.curTweener ~= nil then
    self.curTweener:Kill()
    self.curTweener = nil
  end
end

function DormRoleBaseEntity:StartCmderCheckMove(minDistance, action)
  self:GetCharAStarComp():StartCheckMove(minDistance, action)
end

function DormRoleBaseEntity:StopCmderCheckMove()
  self:GetCharAStarComp():StopCheckMove()
end

function DormRoleBaseEntity:StartCheckAnimator(aniName, action)
  self:GetCharAStarComp():StartCheckAnimator(aniName, action)
end

function DormRoleBaseEntity:StopCheckAnimator()
  self:GetCharAStarComp():StopCheckAnimator()
end

function DormRoleBaseEntity:StartSmoothLookAtTarget(transform, action)
  self:GetCharAStarComp():StartSmoothLookAtTarget(transform, action)
end

function DormRoleBaseEntity:StartSmoothRotate(qua, action)
  self:GetCharAStarComp():StartSmoothRotate(qua, action)
end

function DormRoleBaseEntity:GetRandomOnePoint(gscore)
  gscore = gscore or 10000
  local ok, pos = cs_DormAStarUtils.RandomOnePoint(self.transform.position, gscore)
  return ok, pos
end

function DormRoleBaseEntity:GetRandomBFSPoint(depth)
  depth = depth or 1
  local ok, pos = cs_DormAStarUtils.RandomBFSPoint(self.transform.position, depth)
  return ok, pos
end

function DormRoleBaseEntity:GetRandomPathPoint(length, spread)
  length = length or 10
  spread = spread or 10000
  local ok, pos = cs_DormAStarUtils.RandomPathPoint(self.transform.position, length, spread)
  return ok, pos
end

function DormRoleBaseEntity:GetRoleName()
  return ""
end

function DormRoleBaseEntity:DormAddParentConstraint()
  if IsNull(self._roleConstraint) then
    self._roleConstraint = self.gameObject:AddComponent(typeof(cs_ParentContraint))
    local source = cs_ConstraintSource()
    source.weight = 1
    self._roleConstraint:AddSource(source)
  end
  self._roleConstraint.constraintActive = true
  return self._roleConstraint
end

function DormRoleBaseEntity:DormRemoveParentConstraint(real)
  if real then
    DestroyUnityObject(self._roleConstraint)
    self._roleConstraint = nil
  elseif not IsNull(self._roleConstraint) then
    self._roleConstraint.constraintActive = false
  end
end

function DormRoleBaseEntity:OnDelete()
  self.aiCtrl:AIInterruptCurrState()
  self._animLength = nil
  self._roleConstraint = nil
  if self.curTweener ~= nil then
    self.curTweener:Kill()
    self.curTweener = nil
  end
end

return DormRoleBaseEntity
