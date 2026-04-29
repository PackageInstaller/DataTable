require("base_service")
require("battle_svc_l")
_class("BattleService_Maze", BattleService)
BattleService_Maze = BattleService_Maze

function BattleService_Maze:AddPetDeadMark(teamEntity)
  local deadPet = {}
  local petEntities = teamEntity:Team():GetTeamPetEntities()
  for id, entity in ipairs(petEntities) do
    local curHP = entity:Attributes():GetCurrentHP()
    if curHP <= 0 and not entity:HasPetDeadMark() then
      entity:AddPetDeadMark()
      table.insert(deadPet, entity:GetID())
      Log.fatal("PetDead PetEntityID:", entity:GetID(), "HP:", curHP, "TID:", entity:PetPstID():GetTemplateID())
      local teamOrder = teamEntity:Team():CloneTeamOrder()
      local deadPstID = entity:PetPstID():GetPstID()
      local petOrder = 1
      for index, pstID in ipairs(teamOrder) do
        if deadPstID == pstID then
          petOrder = index
          break
        end
      end
      entity:PetPstID():SetTeamOrderBeforeDead(petOrder)
    end
  end
  return deadPet
end

function BattleService_Maze:GetNonHelperAlivePet(teamEntity)
  local teamLeader = teamEntity:GetTeamLeaderPetEntity()
  local petEntities = teamEntity:Team():GetTeamPetEntities()
  local secondaryPetEntity
  for id, entity in ipairs(petEntities) do
    if entity:GetID() ~= teamLeader:GetID() and not entity:HasPetDeadMark() and not entity:PetPstID():IsHelpPet() then
      if not entity:HasBuffFlag(BuffFlags.SealedCurse) and not entity:HasBuffFlag(BuffFlags.Pet1702361NotLinkLine) then
        return entity
      else
        secondaryPetEntity = secondaryPetEntity or entity
      end
    end
  end
  if secondaryPetEntity then
    return secondaryPetEntity
  end
  return nil
end

function BattleService_Maze:UnLoadTeamMemberLogic(teamEntity)
  local teamLeader = teamEntity:GetTeamLeaderPetEntity()
  local petEntities = teamEntity:Team():GetTeamPetEntities()
  local unloadList = {}
  for id, entity in ipairs(petEntities) do
    if id ~= teamLeader:GetID() and entity:HasPetDeadMark() then
      table.insert(unloadList, entity)
    end
  end
end

function BattleService_Maze:ChangeTeamLeaderLogic(teamEntity)
  local teamLeader = teamEntity:GetTeamLeaderPetEntity()
  if teamLeader:HasPetDeadMark() then
    self._world.BW_WorldInfo.TeamLeaderPetPstID = teamLeader:PetPstID():GetPstID()
    local oldLeaderTemplateID = teamLeader:PetPstID():GetTemplateID()
    local replaceEntity = self:GetNonHelperAlivePet(teamEntity)
    if replaceEntity then
      self._world:GetService("Trigger"):Notify(NTBeforeMazeTeamLeaderSucceed:New(replaceEntity))
      teamEntity:SetTeamLeaderPetEntity(replaceEntity)
      local petDeadRes = DataPetDeadResult:New()
      local deadList = {}
      deadList[#deadList + 1] = teamEntity:GetID()
      petDeadRes:DataSetDeadPetEntityIDList(deadList)
      self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, petDeadRes)
      local battleStatCmpt = self._world:BattleStat()
      battleStatCmpt:AddPassiveTeamLeaderChangeNum()
      local newLeaderTemplateID = replaceEntity:PetPstID():GetTemplateID()
      self._world:EventDispatcher():Dispatch(GameEventType.MazeChangeTeamLeader, oldLeaderTemplateID, newLeaderTemplateID)
    end
  end
end

function BattleService_Maze:TeamLeaderResurgence(originalLeader, teamEntity)
  local teamLeader = teamEntity:GetTeamLeaderPetEntity()
  local oldLeaderTemplateID = teamLeader:PetPstID():GetTemplateID()
  local replaceEntity = originalLeader
  local entityService = self._world:GetService("LogicEntity")
  if replaceEntity then
    teamEntity:SetTeamLeaderPetEntity(replaceEntity)
    local battleStatCmpt = self._world:BattleStat()
    battleStatCmpt:AddPassiveTeamLeaderChangeNum()
    local newLeaderTemplateID = replaceEntity:PetPstID():GetTemplateID()
    self._world:EventDispatcher():Dispatch(GameEventType.MazeChangeTeamLeader, oldLeaderTemplateID, newLeaderTemplateID)
  end
end

function BattleService_Maze:UnloadPetLogic(teamEntity)
  local tOldTeamOrder = teamEntity:Team():CloneTeamOrder()
  local deadPetThisTime = self:AddPetDeadMark(teamEntity)
  self:UnLoadDeadPetBuff(teamEntity)
  self:RemoveDeadPetPassiveSkill(teamEntity)
  self:ChangeTeamLeaderLogic(teamEntity)
  self:UnLoadTeamMemberLogic(teamEntity)
  local ntChangeTeamOrder
  if 0 < #deadPetThisTime then
    ntChangeTeamOrder = self:ChangeTeamOrderOnUnloadPet(teamEntity, tOldTeamOrder, deadPetThisTime)
  end
  return ntChangeTeamOrder
end

function BattleService_Maze:UnLoadDeadPetBuff(teamEntity)
  local buffLogicService = self._world:GetService("BuffLogic")
  local petList = teamEntity:Team():GetTeamPetEntities()
  for i, entity in ipairs(petList) do
    if entity:HasPetDeadMark() then
      buffLogicService:RemoveAllBuffInstance(entity)
    end
  end
end

function BattleService_Maze:RemoveDeadPetPassiveSkill(teamEntity)
  local petList = teamEntity:Team():GetTeamPetEntities()
  for i, entity in ipairs(petList) do
    if entity:HasPetDeadMark() then
      local buffSource = BuffSource:New(BuffSourceType.PassiveSkill, entity:PetPstID():GetPstID())
      local buffEntityList = self._world:GetGroupEntities(self._world.BW_WEMatchers.Buff)
      for _, buffEntity in ipairs(buffEntityList) do
        local buffComponent = buffEntity:BuffComponent()
        buffComponent:UnLoadBuff(buffSource)
      end
    end
  end
end

function BattleService_Maze:PlayerIsDead(teamEntity)
  return self:IsAllPetDead()
end

function BattleService_Maze:HandlePlayerCalculation()
  return self:IsAllPetDead()
end

function BattleService_Maze:IsAllPetDead()
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local petEntities = teamEntity:Team():GetTeamPetEntities()
  for _, entity in ipairs(petEntities) do
    local curHP = entity:Attributes():GetCurrentHP()
    if 0 < curHP then
      return false
    end
  end
  return true
end

function BattleService_Maze:GetCasterHP(casterEntity)
  local attributeCmpt = casterEntity:Attributes()
  local HP = attributeCmpt:GetCurrentHP()
  local maxHP = attributeCmpt:CalcMaxHp()
  return HP, maxHP
end

function BattleService_Maze:ChangeTeamOrderOnUnloadPet(teamEntity, oldTeamOrder, deadPets)
  local cTeam = teamEntity:Team()
  local tTeamOrderAfterLeaderCheck = teamEntity:Team():CloneTeamOrder()
  local tNewTeamOrder = {}
  local deadPetPstIDs = {}
  local helpPetPstID
  for index, pstID in ipairs(tTeamOrderAfterLeaderCheck) do
    local e = cTeam:GetPetEntityByPetPstID(pstID)
    if e:PetPstID():IsHelpPet() then
      helpPetPstID = pstID
    elseif not e:HasPetDeadMark() then
      table.insert(tNewTeamOrder, pstID)
    else
      table.insert(deadPetPstIDs, pstID)
    end
  end
  local isHelpPetDead = helpPetPstID and cTeam:GetPetEntityByPetPstID(helpPetPstID):HasPetDeadMark()
  if helpPetPstID and not isHelpPetDead then
    table.insert(tNewTeamOrder, helpPetPstID)
  end
  for _, pstID in ipairs(deadPetPstIDs) do
    table.insert(tNewTeamOrder, pstID)
  end
  if helpPetPstID and isHelpPetDead then
    table.insert(tNewTeamOrder, helpPetPstID)
  end
  cTeam:SetTeamOrder(tNewTeamOrder)
  local nt = NTTeamOrderChange:New(teamEntity, oldTeamOrder, tNewTeamOrder)
  self._world:GetService("Trigger"):Notify(nt)
  return nt
end

function BattleService_Maze:GetTeamHP()
  local HP, maxHP = 0, 0
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local teamPetEntities = teamEntity:Team():GetTeamPetEntities()
  for _, petEntity in ipairs(teamPetEntities) do
    local attributeCmpt = petEntity:Attributes()
    HP = HP + attributeCmpt:GetCurrentHP()
    maxHP = maxHP + attributeCmpt:CalcMaxHp()
  end
  return HP, maxHP
end

function BattleService_Maze:GetAlivePetCount()
  local count = 0
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local petList = teamEntity:Team():GetTeamPetEntities()
  for i, entity in ipairs(petList) do
    if not entity:HasPetDeadMark() then
      count = count + 1
    end
  end
  return count
end
