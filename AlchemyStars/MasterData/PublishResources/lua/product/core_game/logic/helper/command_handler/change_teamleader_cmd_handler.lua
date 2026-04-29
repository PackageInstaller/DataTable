require("command_base_handler")
_class("ChangeTeamLeaderCommandHandler", CommandBaseHandler)
ChangeTeamLeaderCommandHandler = ChangeTeamLeaderCommandHandler

function ChangeTeamLeaderCommandHandler:DoHandleCommand(cmd)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local newTeamLeaderPetPstID = cmd:GetNewLeaderPstID()
  local oldTeamLeaderPetPstID = cmd:GetOldLeaderPstID()
  local teamAttrConmpt = teamEntity:Attributes()
  local leftCount = teamAttrConmpt:GetAttribute("ChangeTeamLeaderCount")
  if leftCount < 1 and leftCount ~= -1 then
    Log.fatal("ChangeTeamLeader Invalid LeftCount:", leftCount)
    return
  end
  if not self:_CheckChangeTeamLeaderPstID(teamEntity, newTeamLeaderPetPstID, oldTeamLeaderPetPstID) then
    Log.fatal("CheckChangeTeamLeader failed")
    return
  end
  local newPetData = self._world:GetPetData(newTeamLeaderPetPstID)
  if newPetData:IsHelpPet() then
    Log.fatal("NewPet Is HelpPet NewTeamLeaderPetPstID:", newTeamLeaderPetPstID)
    return
  end
  local battleStatCmpt = self._world:BattleStat()
  battleStatCmpt:AddTeamLeaderChangeNum()
  local cTeam = teamEntity:Team()
  local tOldTeamOrder = cTeam:CloneTeamOrder()
  local teamOrderBefore, teamOrderAfter = self:ChangeTeamLeader(newTeamLeaderPetPstID)
  if leftCount == -1 then
  else
    if leftCount < 1 then
      Log.fatal("ChangeTeamLeader Invalid LeftCount:", leftCount)
    end
    teamAttrConmpt:Modify("ChangeTeamLeaderCount", leftCount - 1)
  end
  local leftChangeTeamLeaderCount = teamAttrConmpt:GetAttribute("ChangeTeamLeaderCount")
  local petEntity = teamEntity:Team():GetPetEntityByPetPstID(newTeamLeaderPetPstID)
  local oldLeaderPetEntity = teamEntity:Team():GetPetEntityByPetPstID(oldTeamLeaderPetPstID)
  local tNewTeamOrder = cTeam:CloneTeamOrder()
  teamEntity:Team():SetChangeTeamLeaderCmdData(tOldTeamOrder, tNewTeamOrder)
  local triggerService = self._world:GetService("Trigger")
  triggerService:Notify(NTChangeTeamLeader:New(petEntity, oldLeaderPetEntity))
  local ntTeamOrderChange = NTTeamOrderChange:New(teamEntity, teamOrderBefore, teamOrderAfter)
  triggerService:Notify(ntTeamOrderChange)
  if self._world:RunAtClient() then
    self._world:EventDispatcher():Dispatch(GameEventType.WaitInputFinish, 10)
  end
end

function ChangeTeamLeaderCommandHandler:_PlayNotify(TT, ntTeamOrderChange)
  self._world:GetService("PlayBuff"):PlayBuffView(TT, ntTeamOrderChange)
end

function ChangeTeamLeaderCommandHandler:_CheckChangeTeamLeaderPstID(teamEntity, newPetPstID, oldPetPstID)
  local teamLeaderEntity = teamEntity:GetTeamLeaderPetEntity()
  local curTeamLeaderPstID = teamEntity:Team():GetTeamLeaderPetPstID()
  if newPetPstID == curTeamLeaderPstID then
    Log.fatal("NewTeamLeader Invalid PetPstID:", newPetPstID)
    return false
  end
  if curTeamLeaderPstID ~= oldPetPstID then
    Log.fatal("OldTeamLeader Invalid ", oldPetPstID, " curTeamLeaderPstID=", curTeamLeaderPstID)
    return false
  end
  local utilDataSvc = self._world:GetService("UtilData")
  local newTeamLeaderEntity = teamEntity:Team():GetPetEntityByPetPstID(newPetPstID)
  local flag = utilDataSvc:OnCheckEntityHasBuffFlag(newTeamLeaderEntity, BuffFlags.Pet1702361NotLinkLine)
  return not flag
end

function ChangeTeamLeaderCommandHandler:ChangeTeamLeader(petPstID)
  local battleService = self._world:GetService("Battle")
  return battleService:ChangeLocalTeamLeader(petPstID)
end
