_class("BuffLogicHarmReduction", BuffLogicBase)
BuffLogicHarmReduction = BuffLogicHarmReduction

function BuffLogicHarmReduction:Constructor(buffInstance, logicParam)
  self._harmReduction = logicParam.harmReduction
  self._stage = logicParam.stage
  self._monsterClassIDArray = logicParam.monsterClassIDArray
  self._previewSkill = logicParam.previewSkill
  self._previewSkillHolderName = logicParam.previewSkillHolderName or "self"
  self._uiText = logicParam.uiText or "str_battle_harm_reduction"
end

function BuffLogicHarmReduction:DoLogic()
  local e = self._buffInstance:Entity()
  local layer = 0
  local lineList = {}
  local harmReduction = 0
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, monsterEntity in ipairs(monsterGroup:GetEntities()) do
    if not monsterEntity:HasDeadMark() then
      local monsterID = monsterEntity:MonsterID():GetMonsterID()
      local monsterClassID = 0
      local cfg = Cfg.cfg_monster[monsterID]
      if cfg and cfg.ClassID then
        monsterClassID = cfg.ClassID
      end
      if table.intable(self._monsterClassIDArray, monsterClassID) then
        layer = layer + 1
      end
    end
  end
  local curStage = 1
  if 0 < layer and layer <= #self._stage then
    for i = 1, layer do
      if curStage < self._stage[i] then
        curStage = self._stage[i]
        local lineIndex = i + #lineList
        table.insert(lineList, lineIndex)
      end
    end
    harmReduction = self._harmReduction[layer]
  end
  local cpt = e:Attributes()
  cpt:Modify("FinalBehitDamageParam", -harmReduction / 100)
  local oldStage = cpt:GetAttribute("BuffStageFixSkillSelectRound")
  cpt:SetSimpleAttribute("BuffStageFixSkillSelectRound", curStage)
  local skillHolder
  local previewSkillID = 0
  if self._previewSkill and 0 < table.count(self._previewSkill) then
    if self._previewSkillHolderName == "self" then
      skillHolder = e
    else
      local skillHolderName = self._previewSkillHolderName .. e:GetID()
      local skillHolderID = e:GetSkillHolder(skillHolderName)
      if not skillHolderID then
        local entityService = self._world:GetService("LogicEntity")
        skillHolder = entityService:CreateLogicEntity(EntityConfigIDConst.SkillHolder)
        skillHolder:SetGridPosition(e:GetGridPosition())
        e:AddSkillHolder(skillHolderName, skillHolder:GetID())
        skillHolder:AddSuperEntity(e)
        local casterEntity = self:GetCasterEntity()
        if casterEntity:EntityType() == nil then
          casterEntity = e
        end
        skillHolder:SuperEntityComponent():SetBuffSkillHolderCasterEntityID(casterEntity:GetID())
        skillHolder:ReplaceAlignment(e:Alignment():GetAlignmentType())
        skillHolder:ReplaceGameTurn(e:GameTurn():GetGameTurn())
      else
        skillHolder = self._world:GetEntityByID(skillHolderID)
      end
    end
    skillHolder:SetGridPosition(e:GetGridPosition())
    local skillEffectResultContainer = skillHolder:SkillContext():GetResultContainer()
    local effectResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.ShowWarningArea)
    if effectResult and oldStage ~= curStage then
      skillEffectResultContainer:Clear()
      previewSkillID = self._previewSkill[curStage]
      if 0 < previewSkillID then
        local skillLogicSvc = self._world:GetService("SkillLogic")
        skillLogicSvc:CalcSkillEffect(skillHolder, previewSkillID)
      end
    end
  end
  self._buffInstance:SetLayerCount(layer)
  local buffResult = BuffResultHarmReduction:New(layer, lineList, harmReduction, previewSkillID, skillHolder, self._uiText)
  return buffResult
end
