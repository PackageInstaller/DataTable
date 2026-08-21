_class("L2R_NormalAttackResult", Object)

function L2R_NormalAttackResult:Constructor()
  self._playNormalSkillSequence = {}
  self._chainPathTriggerTrapDic = {}
  self._normalAttackResultList = {}
  self._petRoundTeam = {}
  self._isFinalAtk = false
end

function L2R_NormalAttackResult:ClearNormalAttackResult()
  table.clear(self._playNormalSkillSequence)
  table.clear(self._chainPathTriggerTrapDic)
  table.clear(self._normalAttackResultList)
  self._petRoundTeam = {}
  self._isFinalAtk = false
end

function L2R_NormalAttackResult:SetPlayNormalAttackFinalAttack(finalAtk)
  self._isFinalAtk = finalAtk
end

function L2R_NormalAttackResult:SetCurPlayNormalSkillPlayStartTime(order, currentTimeMs)
  local cur = self._playNormalSkillSequence[order]
  cur.playStartTime = currentTimeMs
end

function L2R_NormalAttackResult:SetPlayNormalSkillSequence(playNormalSkillSequence)
  self._playNormalSkillSequence = playNormalSkillSequence
end

function L2R_NormalAttackResult:GetNormalSkillSequenceWithAttackGridData(skillID, beAttackPos, attackPos)
  for i = 1, #self._playNormalSkillSequence do
    local playNormalSkill = self._playNormalSkillSequence[i]
    if playNormalSkill.skillID == skillID and playNormalSkill.beAttackPos.x == beAttackPos.x and playNormalSkill.beAttackPos.y == beAttackPos.y and playNormalSkill.attackPos.x == attackPos.x and playNormalSkill.attackPos.y == attackPos.y then
      return playNormalSkill
    end
  end
  return nil
end

function L2R_NormalAttackResult:GetNormalSkillSequenceWithOrder(order)
  for i = 1, #self._playNormalSkillSequence do
    local playNormalSkill = self._playNormalSkillSequence[i]
    if playNormalSkill.order == order then
      return playNormalSkill
    end
  end
  return nil
end

function L2R_NormalAttackResult:GetPlayNormalSkillSequence()
  return self._playNormalSkillSequence
end

function L2R_NormalAttackResult:SetChainPathTriggerTrap(trapsDic)
  self._chainPathTriggerTrapDic = trapsDic
end

function L2R_NormalAttackResult:GetChainPathTriggerTrap(pathIndex)
  return self._chainPathTriggerTrapDic[pathIndex]
end

function L2R_NormalAttackResult:SetNormalSkillWaitTimeDic(dic)
  self._normalSkillWaitTimeDic = dic
end

function L2R_NormalAttackResult:GetNormalSkillWaitTimeDic(petIndex, chainIndex)
  return self._normalSkillWaitTimeDic[petIndex][chainIndex]
end

function L2R_NormalAttackResult:SetPathMoveStartWaitTime(pathMoveStartWaitTime)
  self._pathMoveStartWaitTime = pathMoveStartWaitTime
end

function L2R_NormalAttackResult:GetPathMoveStartWaitTime()
  return self._pathMoveStartWaitTime
end

function L2R_NormalAttackResult:GetPetNormalAttackResult(petEntityID)
  return self._normalAttackResultList[petEntityID]
end

function L2R_NormalAttackResult:SetPetNormalAttackResultList(dataList)
  self._normalAttackResultList = dataList
end

function L2R_NormalAttackResult:GetPlayNormalAttackFinalAttack()
  return self._isFinalAtk
end
