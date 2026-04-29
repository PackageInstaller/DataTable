_class("BuffLogicCastSkillWithChainCount", BuffLogicBase)
BuffLogicCastSkillWithChainCount = BuffLogicCastSkillWithChainCount

function BuffLogicCastSkillWithChainCount:Constructor(buffInstance, logicParam)
  self._chainCountMultiple = logicParam.chainCountMultiple
  self._petTempleteID = logicParam.petTempleteID
  self._skillList = logicParam.skillList
  self._useAgentSkill = logicParam.useAgentSkill or 0
end

function BuffLogicCastSkillWithChainCount:DoLogic(notify)
  local e = self._buffInstance:Entity()
  local skillList = {}
  for k, v in pairs(self._skillList) do
    local skill = {}
    skill.chainCount = k
    skill.skill = v
    table.insert(skillList, skill)
  end
  table.sort(skillList, function(e1, e2)
    return e1.chainCount > e2.chainCount
  end)
  local petEntity
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  if e:HasSummoner() then
    local ownerPet = e:GetSummonerEntity()
    if ownerPet:HasPet() then
      teamEntity = ownerPet:Pet():GetOwnerTeamEntity()
    end
  end
  local pets = teamEntity:Team():GetTeamPetEntities()
  for i, e in ipairs(pets) do
    local cPetPstID = e:PetPstID()
    if self._petTempleteID == cPetPstID:GetTemplateID() then
      petEntity = e
      break
    end
  end
  if not petEntity then
    return
  end
  local buffComponent = petEntity:BuffComponent()
  buffComponent:SetBuffValue("AgentChainEntityID", e:GetID())
  buffComponent:SetBuffValue("AgentChainCountMultiple", self._chainCountMultiple)
  buffComponent:SetBuffValue("AgentChainSkillList", skillList)
  if self._useAgentSkill == 1 then
    buffComponent:SetBuffValue("AgentChainSkillUseCfgID", 1)
  else
    buffComponent:SetBuffValue("AgentChainSkillUseCfgID", 0)
  end
  local buffResult = BuffResultCastSkillWithChainCount:New(petEntity:GetID())
  return buffResult
end
