require("calc_base")
_class("SkillEffectCalc_ChangeElement", SkillEffectCalc_Base)
SkillEffectCalc_ChangeElement = SkillEffectCalc_ChangeElement

function SkillEffectCalc_ChangeElement:Constructor(world)
  self._world = world
end

function SkillEffectCalc_ChangeElement:DoSkillEffectCalculator(skillEffectCalcParam)
  local skillParam = skillEffectCalcParam.skillEffectParam
  local type = skillParam:GetType()
  local targetElement = skillParam:GetElement()
  local targetID = skillEffectCalcParam.casterEntityID
  if type == EffectChangeElementType.ByCurrentTeamLeader then
    local teamEntity = self._world:Player():GetLocalTeamEntity()
    local teamLeaderEntity = teamEntity:GetTeamLeaderPetEntity()
    local elementCmpt = teamLeaderEntity:Element()
    targetElement = elementCmpt:GetPrimaryType()
    targetID = skillEffectCalcParam:GetTargetEntityIDs()[1]
  elseif type == EffectChangeElementType.RestoreMonsterCfgElement then
    local entity = self._world:GetEntityByID(targetID)
    if entity:HasMonsterID() then
      local monsterID = entity:MonsterID():GetMonsterID()
      local configService = self._world:GetService("Config")
      local monsterConfigData = configService:GetMonsterConfigData()
      targetElement = monsterConfigData:GetMonsterElementType(monsterID)
    end
  end
  if skillParam:IsChangeSuperElement() then
    local entity = self._world:GetEntityByID(targetID)
    local superEntity = entity:GetSuperEntity()
    if superEntity then
      targetID = superEntity:GetID()
    end
  end
  local result = SkillEffectResultChangeElement:New(targetID, targetElement)
  return result
end
