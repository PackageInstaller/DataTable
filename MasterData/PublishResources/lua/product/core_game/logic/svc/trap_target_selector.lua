_class("TrapTargetSelector", Object)
TrapTargetSelector = TrapTargetSelector

function TrapTargetSelector:Constructor(world)
  self._world = world
  self._selectFunc = {}
  self._selectFunc[TrapRaceType.Team] = self._SelectTeam
  self._selectFunc[TrapRaceType.Pet] = self._SelectPet
  self._selectFunc[TrapRaceType.Monster] = self._SelectMonster
  self._selectFunc[TrapRaceType.All] = self._SelectAll
  self._selectFunc[TrapRaceType.FilterByBuff] = self._SelectByBuff
  self._selectFunc[TrapRaceType.FriendTeam] = self._SelectFriendTeam
  self._selectFunc[TrapRaceType.EnemyTeam] = self._SelectEnemyTeam
  self._selectFunc[TrapRaceType.AllTeam] = self._SelectTeam
  self._selectFunc[TrapRaceType.ChessPet] = self._SelectChessPet
  self._selectFunc[TrapRaceType.None] = self._None
end

function TrapTargetSelector:CanSelectTarget(trap, caster)
  local raceType = trap:Trap():GetTrapRaceType()
  return self:CanSelectTargetByType(trap, caster, raceType)
end

function TrapTargetSelector:CanSelectTargetByType(trap, caster, raceType)
  if not caster then
    return true
  end
  raceType = self._world:ReplaceTrapRaceType(raceType)
  local func = self._selectFunc[raceType]
  if not func then
    Log.exception(self._className, "invalid raceType ", raceType)
    return false
  end
  return func(self, trap, caster)
end

function TrapTargetSelector:_SelectTeam(trap, target)
  return target:HasTeam() or target:HasPetPstID()
end

function TrapTargetSelector:_SelectFriendTeam(trap, target)
  if trap:Alignment():GetAlignmentType() == target:Alignment():GetAlignmentType() then
    return target:HasTeam() or target:HasPetPstID()
  end
  return false
end

function TrapTargetSelector:_SelectEnemyTeam(trap, target)
  if trap:Alignment():GetAlignmentType() ~= target:Alignment():GetAlignmentType() then
    return target:HasTeam() or target:HasPetPstID()
  end
  return false
end

function TrapTargetSelector:_SelectPet(trap, target)
  return target:HasPetPstID()
end

function TrapTargetSelector:_SelectMonster(trap, target)
  return target:HasMonsterID() and not target:HasDeadMark()
end

function TrapTargetSelector:_SelectAll(trap, target)
  return self:_SelectTeam(trap, target) or self:_SelectPet(trap, target) or self:_SelectMonster(trap, target)
end

function TrapTargetSelector:_SelectByBuff(trap, target)
  local trapCmpt = trap:Trap()
  local buffEffects = trapCmpt:GetTrapRaceParam()
  local configService = self._world:GetService("Config")
  local buffCpt = target:BuffComponent()
  if buffCpt then
    for _, value in ipairs(buffEffects) do
      if buffCpt:HasBuffEffect(value) then
        return false
      end
    end
  end
  return true
end

function TrapTargetSelector:_SelectChessPet(trap, target)
  return target:HasChessPet()
end

function TrapTargetSelector:_None()
  return false
end
