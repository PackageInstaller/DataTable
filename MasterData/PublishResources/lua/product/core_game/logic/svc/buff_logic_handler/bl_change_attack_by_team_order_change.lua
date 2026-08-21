_class("BuffLogicChangeAttackByTeamOrderChange", BuffLogicBase)
BuffLogicChangeAttackByTeamOrderChange = BuffLogicChangeAttackByTeamOrderChange

function BuffLogicChangeAttackByTeamOrderChange:Constructor(buffInstance, logicParam)
  self._mulValuePerPos = logicParam.mulValuePerPos or 0
  self._mulValueBase = logicParam.mulValueBase
  self._useCasterPosChange = logicParam.useCasterPosChange == 1
  self._changeCurrentTeamLeaderInstead = logicParam.changeCurrentTeamLeaderInstead == 1
end

function BuffLogicChangeAttackByTeamOrderChange:DoLogic(notify)
  local e = self._buffInstance:Entity()
  if e:HasSuperEntity() then
    e = e:GetSuperEntity()
  end
  local context = self._buffInstance:Context()
  local eCaster = context.casterEntity
  local formerPosIndex = 0
  local newPosIndex = 0
  local petPstID = e:PetPstID():GetPstID()
  if self._useCasterPosChange then
    petPstID = eCaster:PetPstID():GetPstID()
  end
  for index, pstID in ipairs(notify:GetOldTeamOrder()) do
    if pstID == petPstID then
      formerPosIndex = index
      break
    end
  end
  for index, pstID in ipairs(notify:GetNewTeamOrder()) do
    if pstID == petPstID then
      newPosIndex = index
      break
    end
  end
  if formerPosIndex == 0 or newPosIndex == 0 then
    Log.error(self._className, "pstID not found in notify???", petPstID)
    return
  end
  local changedTeamPosCount = math.abs(formerPosIndex - newPosIndex) - 1
  if changedTeamPosCount < 0 then
    changedTeamPosCount = 0
  end
  local cAttrCaster = eCaster:Attributes()
  local base = cAttrCaster:GetAttribute("Attack")
  local val = base * (self._mulValueBase + self._mulValuePerPos * changedTeamPosCount)
  local eBeneficiary = e
  if self._changeCurrentTeamLeaderInstead then
    eBeneficiary = e:Pet():GetOwnerTeamEntity():Team():GetTeamLeaderEntity()
  end
  local cBuffBeneficiary = eBeneficiary:BuffComponent()
  local lastEffectedInfo = cBuffBeneficiary:GetLastEffectedLogicInfo("ChangeAttackByTeamOrderChange")
  if lastEffectedInfo then
    local seqID = lastEffectedInfo.seq
    local lastVal = lastEffectedInfo.val
    if val <= lastVal then
      return
    end
    self._buffLogicService:RemoveBaseAttack(eBeneficiary, seqID, ModifyBaseAttackType.AttackConstantFix)
  end
  self._buffLogicService:ChangeBaseAttack(eBeneficiary, self:GetBuffSeq(), ModifyBaseAttackType.AttackConstantFix, val)
  cBuffBeneficiary:SetLastEffectedLogicInfo("ChangeAttackByTeamOrderChange", {
    seq = self:GetBuffSeq(),
    val = val
  })
  return BuffResultChangeAttackByTeamOrderChange:New(eBeneficiary:PetPstID():GetPstID(), val)
end

function BuffLogicChangeAttackByTeamOrderChange:DoOverlap(logicParam)
  return self:DoLogic()
end

_class("BuffLogicChangeAttackByTeamOrderChangeUndo", BuffLogicBase)
BuffLogicChangeAttackByTeamOrderChangeUndo = BuffLogicChangeAttackByTeamOrderChangeUndo

function BuffLogicChangeAttackByTeamOrderChangeUndo:Constructor(buffInstance, logicParam)
  self._changeCurrentTeamLeaderInstead = logicParam.changeCurrentTeamLeaderInstead == 1
end

function BuffLogicChangeAttackByTeamOrderChangeUndo:DoLogic()
  local e = self._buffInstance:Entity()
  if e:HasSuperEntity() then
    e = e:GetSuperEntity()
  end
  if self._changeCurrentTeamLeaderInstead then
    e = e:Pet():GetOwnerTeamEntity():Team():GetTeamLeaderEntity()
  end
  local cBuffBeneficiary = e:BuffComponent()
  local lastEffectedInfo = cBuffBeneficiary:GetLastEffectedLogicInfo("ChangeAttackByTeamOrderChange")
  if lastEffectedInfo then
    local seqID = lastEffectedInfo.seq
    local lastVal = lastEffectedInfo.val
    self._buffLogicService:RemoveBaseAttack(e, seqID, ModifyBaseAttackType.AttackConstantFix)
  end
  cBuffBeneficiary:RemoveLastEffectedLogicInfo("ChangeAttackByTeamOrderChange")
end

function BuffLogicChangeAttackByTeamOrderChangeUndo:DoOverlap(logicParam)
end
