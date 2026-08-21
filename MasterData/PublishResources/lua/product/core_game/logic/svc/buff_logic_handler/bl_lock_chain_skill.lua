_class("BuffLogicLockChainSkill", BuffLogicBase)
BuffLogicLockChainSkill = BuffLogicLockChainSkill

function BuffLogicLockChainSkill:Constructor(buffInstance, logicParam)
  self._lockIndex = tonumber(logicParam.index)
end

function BuffLogicLockChainSkill:DoLogic()
  local e = self:GetEntity()
  if not e:HasSkillInfo() then
    return
  end
  local cSkillInfo = e:SkillInfo()
  cSkillInfo:LockChainSkillIndex(self._lockIndex)
  return {
    index = self._lockIndex
  }
end

_class("BuffLogicUnlockChainSkill", BuffLogicBase)
BuffLogicUnlockChainSkill = BuffLogicUnlockChainSkill

function BuffLogicUnlockChainSkill:Constructor(buffInstance, logicParam)
  self._unlockIndex = tonumber(logicParam.index)
  self._unlockShowIndex = tonumber(logicParam.showIndex)
  self._randomCount = tonumber(logicParam.randomCount)
  self._randomShowIndex = logicParam.randomShowIndex or {
    0,
    1,
    2,
    3
  }
  self._addBuffList = logicParam.addBuffList
  if not self._unlockIndex and not self._randomCount then
    self._unlockAll = true
  end
end

function BuffLogicUnlockChainSkill:DoLogic()
  local e = self:GetEntity()
  if not e:HasSkillInfo() then
    return
  end
  local cSkillInfo = e:SkillInfo()
  if self._unlockAll then
    cSkillInfo:UnlockAllChainSkill()
  elseif self._randomCount then
    local lockChainSkillList = table.clone(cSkillInfo:GetLockChainSkillIndex())
    local unlockIndexList = {}
    local buffSvc = self._world:GetService("BuffLogic")
    local result = BuffResultAddBuff:New()
    for i, index in ipairs(lockChainSkillList) do
      if i <= self._randomCount then
        cSkillInfo:UnlockChainSkillIndex(index)
        local showIndex = self._randomShowIndex[index]
        table.insert(unlockIndexList, showIndex)
        local buffID = self._addBuffList[index]
        local buffSource = BuffSource:New(BuffSourceType.Buff, e:GetID())
        local ins = buffSvc:AddBuff(buffID, e, nil, buffSource)
        if ins then
          result:AddBuffData(e:GetID(), ins:BuffSeq())
        end
      end
    end
    return {
      unlockList = unlockIndexList,
      isAll = self._unlockAll,
      addBuffResult = result
    }
  else
    cSkillInfo:UnlockChainSkillIndex(self._unlockIndex)
  end
  if self._unlockShowIndex then
    return {
      index = self._unlockShowIndex,
      isAll = self._unlockAll
    }
  else
    return {
      index = self._unlockIndex,
      isAll = self._unlockAll
    }
  end
end
