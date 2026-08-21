_class("BuffLogicChangeSkillFinalByMonsterIDCount", BuffLogicBase)
BuffLogicChangeSkillFinalByMonsterIDCount = BuffLogicChangeSkillFinalByMonsterIDCount

function BuffLogicChangeSkillFinalByMonsterIDCount:Constructor(buffInstance, logicParam)
  self._minAddValue = logicParam.minAddValue or 0
  self._changeValue = logicParam.changeValue or 0
  self._buffInstance._effectList = logicParam.effectList
  self._entity = buffInstance._entity
  self._monsterClassIDList = logicParam.monsterClassIDList or {}
end

function BuffLogicChangeSkillFinalByMonsterIDCount:DoLogic()
  if #self._monsterClassIDList > 0 then
    local monsterEntityList = self._world:GetGroupEntities(self._world.BW_WEMatchers.MonsterID)
    local addCount = 0
    for i, entity in ipairs(monsterEntityList) do
      local monsterID = entity:MonsterID():GetMonsterClassID()
      if not entity:HasDeadMark() and table.icontains(self._monsterClassIDList, monsterID) then
        addCount = addCount + 1
      end
    end
    local changeValue = self._minAddValue + self._changeValue * addCount
    for _, paramType in ipairs(self._buffInstance._effectList) do
      self._buffLogicService:ChangeSkillFinalParam(self._entity, self:GetBuffSeq(), paramType, changeValue)
    end
  end
end

_class("BuffLogicRemoveChangeSkillFinalByMonsterIDCount", BuffLogicBase)
BuffLogicRemoveChangeSkillFinalByMonsterIDCount = BuffLogicRemoveChangeSkillFinalByMonsterIDCount

function BuffLogicRemoveChangeSkillFinalByMonsterIDCount:Constructor(buffInstance, logicParam)
  self._entity = buffInstance._entity
end

function BuffLogicRemoveChangeSkillFinalByMonsterIDCount:DoLogic()
  for _, paramType in ipairs(self._buffInstance._effectList) do
    self._buffLogicService:RemoveSkillFinalParam(self._entity, self:GetBuffSeq(), paramType)
  end
end
