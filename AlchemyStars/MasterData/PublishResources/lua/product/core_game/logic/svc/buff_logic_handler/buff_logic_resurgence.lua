_class("BuffLogicResurgence", BuffLogicBase)
BuffLogicResurgence = BuffLogicResurgence

function BuffLogicResurgence:Constructor(buffInstance, logicParam)
  self._mulValue = logicParam.mulValue or 0
  self._addValue = logicParam.addValue or 0
  self._hadResurgence = false
end

function BuffLogicResurgence:DoLogic()
  if self._hadResurgence then
    return
  end
  self._hadResurgence = true
  local e = self._world:BattleStat():GetFirstDeadPetEntity()
  local teamEntity = e:Pet():GetOwnerTeamEntity()
  local attrCmpt = e:Attributes()
  local max_hp = attrCmpt:CalcMaxHp()
  local add_value = max_hp * self._mulValue + self._addValue
  if max_hp < add_value then
    add_value = max_hp
  end
  add_value = math.floor(add_value)
  e:RemovePetDeadMark()
  self._world:BattleStat():SetFirstDeadPetEntity(nil)
  local damageInfo = DamageInfo:New(add_value, DamageType.Recover)
  local calcDamageSvc = self._world:GetService("CalcDamage")
  calcDamageSvc:AddTargetHP(e:GetID(), damageInfo)
  local tOldTeamOrder = teamEntity:Team():CloneTeamOrder()
  local tNewTeamOrderTmp
  local formerOrder = e:PetPstID():GetTeamOrderBeforeDead()
  local pstID = e:PetPstID():GetPstID()
  if formerOrder == 1 then
    local originalLeader = teamEntity:Team():GetPetEntityByPetPstID(tOldTeamOrder[1])
    self._world:GetService("Battle"):TeamLeaderResurgence(originalLeader, teamEntity)
    tNewTeamOrderTmp = teamEntity:Team():CloneTeamOrder()
  else
    tNewTeamOrderTmp = teamEntity:Team():CloneTeamOrder()
    table.removev(tNewTeamOrderTmp, e:PetPstID():GetPstID())
    if formerOrder > #tNewTeamOrderTmp then
    end
    table.insert(tNewTeamOrderTmp, formerOrder, pstID)
    teamEntity:Team():SetTeamOrder(tNewTeamOrderTmp)
  end
  local tNewTeamOrder = {}
  local deadPets = {}
  local helpPet
  for _, pstID in ipairs(tNewTeamOrderTmp) do
    local e = teamEntity:Team():GetPetEntityByPetPstID(pstID)
    if e:PetPstID():IsHelpPet() then
      helpPet = pstID
    elseif not e:HasPetDeadMark() then
      table.insert(tNewTeamOrder, pstID)
    else
      table.insert(deadPets, pstID)
    end
  end
  if helpPet then
    local e = teamEntity:Team():GetPetEntityByPetPstID(helpPet)
    if e:HasPetDeadMark() then
      table.appendArray(tNewTeamOrder, deadPets)
      table.insert(tNewTeamOrder, helpPet)
    else
      table.insert(tNewTeamOrder, helpPet)
      table.appendArray(tNewTeamOrder, deadPets)
    end
  else
    table.appendArray(tNewTeamOrder, deadPets)
  end
  local ntTeamOrderChange = NTTeamOrderChange:New(teamEntity, tOldTeamOrder, tNewTeamOrderTmp)
  self._world:GetService("Trigger"):Notify(ntTeamOrderChange)
  e:PetPstID():SetTeamOrderBeforeDead(0)
  local curTeamLeaderEntityID = teamEntity:Team():GetTeamLeaderEntityID()
  local curTeamLeaderEntity = self._world:GetEntityByID(curTeamLeaderEntityID)
  local res = BuffResultResurgence:New(e, curTeamLeaderEntity, add_value, damageInfo, tOldTeamOrder, tNewTeamOrderTmp)
  return res
end
