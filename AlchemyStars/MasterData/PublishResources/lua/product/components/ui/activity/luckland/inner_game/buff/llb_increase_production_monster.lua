require("llb_logic_base")
_class("LLBuffLogicIncreaseProductionMonster", LLBuffLogicBase)
LLBuffLogicIncreaseProductionMonster = LLBuffLogicIncreaseProductionMonster

function LLBuffLogicIncreaseProductionMonster:Constructor(buffObj, logicParam)
  self._incType = logicParam.incType
  self._fixVal = logicParam.fixVal
  self._perVal = logicParam.perVal
end

function LLBuffLogicIncreaseProductionMonster:DoLogic(notify)
  local notifyEntity = notify:GetNotifyEntity()
  local monsterCount = 0
  local entityMgr = LuckLandInnerGameHelper.GetEntityMgr()
  local monsters = entityMgr:GetFightMonsters()
  if monsters then
    monsterCount = #monsters
  end
  local targets = self._buffObj:GetTargets()
  for _, target in ipairs(targets) do
    self:DoLogicSingle(target, monsterCount)
  end
end

function LLBuffLogicIncreaseProductionMonster:DoLogicSingle(target, monsterCount)
  if target:GetEntityType() == LuckLandEntityType.Pet then
    if target:HasDeleteFlag() then
      return
    end
  elseif target:GetEntityType() == LuckLandEntityType.Monster and target:IsDead() then
    return
  end
  if self._incType == LuckLandIncType.Accumulate then
    if self._fixVal then
      target:AddAccFixValue(self._fixVal * monsterCount)
    end
    if self._perVal then
      target:AddAccPerValue(self._perVal * monsterCount)
    end
  elseif self._incType == LuckLandIncType.Temp then
    if self._fixVal then
      target:AddTempFixValue(self._fixVal * monsterCount)
    end
    if self._perVal then
      target:AddTempPerValue(self._perVal * monsterCount)
    end
  end
end
