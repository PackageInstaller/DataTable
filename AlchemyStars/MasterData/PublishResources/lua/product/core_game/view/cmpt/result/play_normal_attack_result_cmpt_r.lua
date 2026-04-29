_class("PlayNormalAttackResultComponent", Object)

function PlayNormalAttackResultComponent:Constructor()
  self._playNormalSkillSequence = {}
  self._chainPathTriggerTrapDic = {}
  self._normalAttackResultList = {}
  self._petRoundTeam = {}
  self._isFinalAtk = false
end

function PlayNormalAttackResultComponent:ClearNormalAttackResult()
  table.clear(self._playNormalSkillSequence)
  table.clear(self._chainPathTriggerTrapDic)
  table.clear(self._normalAttackResultList)
  self._petRoundTeam = {}
  self._isFinalAtk = false
end

function PlayNormalAttackResultComponent:SetPlayNormalAttackFinalAttack(finalAtk)
  self._isFinalAtk = finalAtk
end

function PlayNormalAttackResultComponent:SetCurPlayNormalSkillPlayStartTime(order, currentTimeMs)
  local cur = self._playNormalSkillSequence[order]
  cur.playStartTime = currentTimeMs
end

function PlayNormalAttackResultComponent:SetPlayNormalSkillSequence(playNormalSkillSequence)
  self._playNormalSkillSequence = playNormalSkillSequence
end

function PlayNormalAttackResultComponent:GetNormalSkillSequenceWithAttackGridData(skillID, beAttackPos, attackPos)
  for i = 1, #self._playNormalSkillSequence do
    local playNormalSkill = self._playNormalSkillSequence[i]
    if playNormalSkill.skillID == skillID and playNormalSkill.beAttackPos.x == beAttackPos.x and playNormalSkill.beAttackPos.y == beAttackPos.y and playNormalSkill.attackPos.x == attackPos.x and playNormalSkill.attackPos.y == attackPos.y then
      return playNormalSkill
    end
  end
  return nil
end

function PlayNormalAttackResultComponent:GetNormalSkillSequenceWithOrder(order)
  for i = 1, #self._playNormalSkillSequence do
    local playNormalSkill = self._playNormalSkillSequence[i]
    if playNormalSkill.order == order then
      return playNormalSkill
    end
  end
  return nil
end

function PlayNormalAttackResultComponent:GetPlayNormalSkillSequence()
  return self._playNormalSkillSequence
end

function PlayNormalAttackResultComponent:SetChainPathTriggerTrap(trapsDic)
  self._chainPathTriggerTrapDic = trapsDic
end

function PlayNormalAttackResultComponent:GetChainPathTriggerTrap(pathIndex)
  return self._chainPathTriggerTrapDic[pathIndex]
end

function PlayNormalAttackResultComponent:SetNormalSkillWaitTimeDic(dic)
  self._normalSkillWaitTimeDic = dic
end

function PlayNormalAttackResultComponent:GetNormalSkillWaitTimeDic(petIndex, chainIndex)
  return self._normalSkillWaitTimeDic[petIndex][chainIndex]
end

function PlayNormalAttackResultComponent:SetPathMoveStartWaitTime(pathMoveStartWaitTime)
  self._pathMoveStartWaitTime = pathMoveStartWaitTime
end

function PlayNormalAttackResultComponent:GetPathMoveStartWaitTime()
  return self._pathMoveStartWaitTime
end

function PlayNormalAttackResultComponent:GetPetNormalAttackResult(petEntityID)
  return self._normalAttackResultList[petEntityID]
end

function PlayNormalAttackResultComponent:SetPetNormalAttackResultList(dataList)
  self._normalAttackResultList = dataList
end

function PlayNormalAttackResultComponent:GetPetRoundTeam()
  return self._petRoundTeam
end

function PlayNormalAttackResultComponent:SetPetRoundTeam(petRoundTeam)
  self._petRoundTeam = petRoundTeam
end

function PlayNormalAttackResultComponent:GetPlayNormalAttackFinalAttack()
  return self._isFinalAtk
end

function PlayNormalAttackResultComponent:WEC_PostInitialize(owner)
end

function PlayNormalAttackResultComponent:WEC_PostRemoved()
end

function Entity:PlayNormalAttackResult()
  return self:GetComponent(self.WEComponentsEnum.PlayNormalAttackResult)
end

function Entity:HasPlayNormalAttackResult()
  return self:HasComponent(self.WEComponentsEnum.PlayNormalAttackResult)
end

function Entity:AddPlayNormalAttackResult()
  local index = self.WEComponentsEnum.PlayNormalAttackResult
  local component = PlayNormalAttackResultComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplacePlayNormalAttackResult()
  local index = self.WEComponentsEnum.PlayNormalAttackResult
  local component = PlayNormalAttackResultComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemovePlayNormalAttackResult()
  if self:HasPlayNormalAttackResult() then
    self:RemoveComponent(self.WEComponentsEnum.PlayNormalAttackResult)
  end
end
