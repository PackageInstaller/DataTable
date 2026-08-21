_class("BuffLogicPSPCastCampSkill", BuffLogicBase)
BuffLogicPSPCastCampSkill = BuffLogicPSPCastCampSkill

function BuffLogicPSPCastCampSkill:Constructor(buffInstance, logicParam)
  self._skillLevel = logicParam.skillLevel
  self._skillHolderName = logicParam.skillHolderName
  self._useNotifyEntityPos = logicParam.useNotifyEntityPos or 0
  self._checkMonsterDie = logicParam.checkMonsterDie or 1
end

function BuffLogicPSPCastCampSkill:DoLogic(notify, triggers)
  local popStarProSvc = self._world:GetService("PopStarProLogic")
  local skillID = popStarProSvc:GetCampSkillIDByLevel(self._skillLevel)
  if not skillID then
    return
  end
  local e = self._buffInstance:Entity()
  local casterEntity = self:GetCasterEntity()
  if casterEntity:EntityType() == nil then
    casterEntity = e
  end
  local skillHolderID = e:GetSkillHolder(self._skillHolderName)
  if not skillHolderID then
    Log.error("BuffLogicPSPCastCampSkill must create skill holder, holder name =", self._skillHolderName)
    return
  end
  local skillHolder = self._world:GetEntityByID(skillHolderID)
  if self._useNotifyEntityPos == 1 then
    local posEntity = e
    if e:HasSuperEntity() then
      posEntity = e:GetSuperEntity()
    end
    skillHolder:SetGridPosition(posEntity:GetGridPosition())
    skillHolder:ReplaceBodyArea(posEntity:BodyArea():GetArea())
  end
  Log.info("Skill Record cast skill, buff skillID=", skillID, " casterEntityID=", skillHolderID)
  local battleCmpt = self._world:BattleStat()
  battleCmpt:AffixBeginSkillDamageRecord(skillHolderID, skillID)
  local skillLogicSvc = self._world:GetService("SkillLogic")
  skillLogicSvc:CalcSkillEffect(skillHolder, skillID)
  local count = battleCmpt:AffixEndSkillDamageRecordAndGetCount(skillHolderID, skillID)
  Log.info("Skill Record end skill, buff skillID=", skillID, " casterEntityID=", skillHolderID, " targetCount=", count)
  local calcEndNotify = NTBuffLogicCastSkillCalcEffectEnd:New(skillHolder, skillID)
  calcEndNotify:SetSkillDamageTargetCount(count)
  self._world:GetService("Trigger"):Notify(calcEndNotify)
  local buffResult = BuffResultCastSkill:New(skillID, skillHolder:GetID(), self._skillHolderType, e:GetGridPosition())
  buffResult:SetTrigger(triggers)
  if self._checkMonsterDie then
    local deadIDList = self:_DoLogicMonsterDead()
    buffResult:SetSkillDeadMonsterEntityIDList(deadIDList)
  end
  local result = skillHolder:SkillContext():GetResultContainer()
  buffResult:SetSkillResult(result)
  skillHolder:ReplaceSkillContext()
  return buffResult
end

function BuffLogicPSPCastCampSkill:_DoLogicMonsterDead()
  local drops = {}
  local deadEntityIDList = {}
  self:_DoLogicRecursMonsterDead(drops, deadEntityIDList)
  local deadEntityList = {}
  for _, id in ipairs(deadEntityIDList) do
    deadEntityList[#deadEntityList + 1] = self._world:GetEntityByID(id)
  end
  return deadEntityIDList
end

function BuffLogicPSPCastCampSkill:_DoLogicRecursMonsterDead(drops, deadEntityIDList)
  local sMonsterShowLogic = self._world:GetService("MonsterShowLogic")
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(monsterGroup:GetEntities()) do
    sMonsterShowLogic:AddMonsterDeadMark(e)
  end
  local tmpDrops, tmpDeadEntityIDList = sMonsterShowLogic:DoAllMonsterDeadLogic()
  table.appendArray(drops, tmpDrops)
  table.appendArray(deadEntityIDList, tmpDeadEntityIDList)
  local hasNewDead = self:_DoLogicCheckNewDead()
  if hasNewDead then
    self:_DoLogicRecursMonsterDead(drops, deadEntityIDList)
  end
end

function BuffLogicPSPCastCampSkill:_DoLogicCheckNewDead()
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(monsterGroup:GetEntities()) do
    local cAttributes = e:Attributes()
    local curHp = cAttributes:GetCurrentHP()
    if curHp <= 0 and not e:HasDeadMark() then
      return true
    end
  end
  return false
end
