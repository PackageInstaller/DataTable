BuffLogicCreateSkillHolder_AbsolutePositionMode = {BoardCenter = 1}
_enum("BuffLogicCreateSkillHolder_AbsolutePositionMode", BuffLogicCreateSkillHolder_AbsolutePositionMode)
_class("BuffLogicCreateSkillHolder", BuffLogicBase)
BuffLogicCreateSkillHolder = BuffLogicCreateSkillHolder

function BuffLogicCreateSkillHolder:Constructor(buffInstance, logicParam)
  self._element = logicParam.element
  self._attackType = logicParam.attackType
  self._name = logicParam.name
  self._absolutePositionMode = logicParam.absolutePositionMode
  self._hideOnDefault = logicParam.hideOnDefault
  self._uesPetTempleteID = logicParam.uesPetTempleteID
  self._useBlackFistEnemyTeam = logicParam.useBlackFistEnemyTeam or 0
end

function BuffLogicCreateSkillHolder:DoLogic()
  local e = self._buffInstance:Entity()
  local entityService = self._world:GetService("LogicEntity")
  local skillHolder = entityService:CreateLogicEntity(EntityConfigIDConst.SkillHolder)
  skillHolder:ReplaceAlignment(e:Alignment():GetAlignmentType())
  skillHolder:ReplaceGameTurn(e:GameTurn():GetGameTurn())
  if self._uesPetTempleteID then
    local teamEntity = self._world:Player():GetCurrentTeamEntity()
    if self._world:MatchType() == MatchType.MT_BlackFist and self._useBlackFistEnemyTeam == 1 then
      local ownerAlignmentType = e:Alignment():GetAlignmentType()
      local teamAlignmentType = teamEntity:Alignment():GetAlignmentType()
      local targetType = MatchAlignmentType(ownerAlignmentType, teamAlignmentType)
      if targetType ~= MatchAlignmentType.Enemy then
        teamEntity = self._world:Player():GetCurrentEnemyTeamEntity()
      end
    end
    local petList = teamEntity:Team():GetTeamPetEntities()
    local petEntity
    for _, e in ipairs(petList) do
      local cPetPstID = e:PetPstID()
      if self._uesPetTempleteID == cPetPstID:GetTemplateID() then
        petEntity = e
        break
      end
    end
    if not petEntity then
      Log.error("BuffLogicCreateSkillHolder cfg error: PetTemplateID = ", self._uesPetTempleteID, ", BuffID = ", self._buffInstance:BuffID())
      return
    end
    local superAttributesComponent = petEntity:Attributes()
    if not skillHolder:HasAttributes() then
      skillHolder:AddAttributes()
    end
    local modifierDic = superAttributesComponent:CloneAttributes()
    skillHolder:Attributes():SetModifierDic(modifierDic)
    local element = petEntity:Element()
    skillHolder:ReplaceElement(element:GetPrimaryType())
  else
    if self._element then
      skillHolder:ReplaceElement(self._element)
    else
      local element = e:Element()
      skillHolder:ReplaceElement(element:GetPrimaryType())
    end
    if self._attackType then
      local attack = self:CalcSkillAttack(e, self._attackType)
      skillHolder:AddAttributes()
      skillHolder:Attributes():SetSimpleAttribute("Attack", attack)
    else
      local superAttributesComponent = e:Attributes()
      if not skillHolder:HasAttributes() then
        skillHolder:AddAttributes()
      end
      local modifierDic = superAttributesComponent:CloneAttributes()
      skillHolder:Attributes():SetModifierDic(modifierDic)
    end
  end
  skillHolder:GridLocation().Position = e:GetGridPosition()
  if self._absolutePositionMode == BuffLogicCreateSkillHolder_AbsolutePositionMode.BoardCenter then
    skillHolder:SetGridLocation(BattleConst.BoardCenterPos, Vector2.down)
  end
  e:AddSkillHolder(self._name, skillHolder:GetID())
  skillHolder:AddSuperEntity(e)
  local casterEntity = self:GetCasterEntity()
  if casterEntity:EntityType() == nil then
    casterEntity = e
  end
  skillHolder:SuperEntityComponent():SetBuffSkillHolderCasterEntityID(casterEntity:GetID())
  local result = BuffResultCreateSkillHolder:New(skillHolder:GetID())
  result:SetAbsolutePositionMode(self._absolutePositionMode)
  result:SetHideOnDefault(self._hideOnDefault)
  return result
end

function BuffLogicCreateSkillHolder:CalcSkillAttack(entity, attackType)
  local formulaSvc = self._world:GetService("Formula")
  local ret = 0
  local attackSum = 0
  local teamMembers = entity:Team():GetTeamPetEntities()
  for _, pet in ipairs(teamMembers) do
    local att = formulaSvc:_CalcFinalAtk(pet)
    attackSum = attackSum + att
  end
  if attackType == BuffSkillAttackType.TeamAttack then
    ret = attackSum
  elseif attackType == BuffSkillAttackType.TeamAverageAttack then
    ret = math.floor(attackSum / #teamMembers)
  end
  if ret == 0 then
    Log.error("CalcSkillAttack() error attack=0!")
  end
  return ret
end

_class("BuffLogicRemoveSkillHolder", BuffLogicBase)
BuffLogicRemoveSkillHolder = BuffLogicRemoveSkillHolder

function BuffLogicRemoveSkillHolder:Constructor(buffInstance, logicParam)
  self._name = logicParam.name
end

function BuffLogicRemoveSkillHolder:DoLogic()
  local e = self._buffInstance:Entity()
  local id = e:GetSkillHolder(self._name)
  local holder = self._world:GetEntityByID(id)
  if holder then
    e:RemoveSkillHolder(self._name)
    return BuffResultCreateSkillHolder:New(holder:GetID())
  end
end
