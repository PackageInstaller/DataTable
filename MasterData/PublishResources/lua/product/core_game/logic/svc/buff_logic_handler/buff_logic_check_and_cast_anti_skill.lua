_class("BuffLogicCheckAndCastAntiSkill", BuffLogicBase)
BuffLogicCheckAndCastAntiSkill = BuffLogicCheckAndCastAntiSkill

function BuffLogicCheckAndCastAntiSkill:Constructor(buffInstance, logicParam)
  self._skillID = logicParam.skillID
end

function BuffLogicCheckAndCastAntiSkill:DoLogic()
  local entity = self._buffInstance:Entity()
  if not entity then
    return
  end
  local attributeCmpt = entity:Attributes()
  local antiSkillEnabled = attributeCmpt:GetAttribute("AntiSkillEnabled")
  if antiSkillEnabled == 0 then
    return
  end
  local activeSkillCount = attributeCmpt:GetAttribute("WaitActiveSkillCount")
  if activeSkillCount == 0 then
    return
  end
  local curRoundAntiCount = attributeCmpt:GetAttribute("MaxAntiSkillCountPerRound")
  if curRoundAntiCount == 0 then
    return
  end
  local checkActiveSkillType = attributeCmpt:GetAttribute("AntiActiveSkillType")
  if checkActiveSkillType == {-1} then
  else
    local teamEntity = self._world:Player():GetCurrentTeamEntity()
    local activeSkillCmpt = teamEntity:ActiveSkill()
    local activeSkillID = activeSkillCmpt:GetActiveSkillID()
    local configService = self._world:GetService("Config")
    local skillConfigData = configService:GetSkillConfigData(activeSkillID, entity)
    local skillTags = skillConfigData:GetSkillTag()
    local hasTag = false
    for i, v in ipairs(checkActiveSkillType) do
      if v == -1 then
        hasTag = true
        break
      end
      if table.icontains(skillTags, v) then
        hasTag = true
        break
      end
    end
    if hasTag == false then
      return
    end
  end
  local newActiveSkillCount = activeSkillCount - 1
  if newActiveSkillCount < 0 then
    newActiveSkillCount = 0
  end
  attributeCmpt:Modify("WaitActiveSkillCount", newActiveSkillCount)
  local buffResult = BuffResultCheckAndCastAntiSkill:New(entity:GetID())
  if newActiveSkillCount == 0 then
    local skillHolder = self._buffInstance:Entity()
    local skillLogicSvc = self._world:GetService("SkillLogic")
    skillLogicSvc:CalcSkillEffect(skillHolder, self._skillID)
    local result = skillHolder:SkillContext():GetResultContainer()
    buffResult:SetSkillResult(result)
    buffResult:SetSkillID(self._skillID)
    skillHolder:ReplaceSkillContext()
    local roundCount = "MaxAntiSkillCountPerRound"
    local curValue = attributeCmpt:GetAttribute(roundCount)
    local newValue = curValue - 1
    if newValue < 0 then
      newValue = 0
    end
    attributeCmpt:Modify(roundCount, newValue)
    local originalAntiCount = attributeCmpt:GetAttribute("OriginalWaitActiveSkillCount")
    attributeCmpt:Modify("WaitActiveSkillCount", originalAntiCount)
  end
  return buffResult
end
