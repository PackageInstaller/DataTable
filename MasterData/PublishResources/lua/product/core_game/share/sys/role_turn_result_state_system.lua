require("main_state_sys")
_class("RoleTurnResultStateSystem", MainStateSystem)
RoleTurnResultStateSystem = RoleTurnResultStateSystem

function RoleTurnResultStateSystem:_GetMainStateID()
  return GameStateID.RoleTurnResult
end

function RoleTurnResultStateSystem:_OnMainStateEnter(TT)
  self:_DoLogicNotify()
  self:_DoRenderPlayNotify(TT)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  self:_DoLogicNormalAttackMonsterDead()
  self:_DoRenderNormalAttackMonsterDead(TT)
  self:_WaitBeHitSkillFinish(TT)
  self:_DoRestoreTeamLeader(teamEntity)
  self:_DoRenderGuideSkill(TT)
  self:_DoRoleTurnResultEnd(teamEntity)
end

function RoleTurnResultStateSystem:_DoLogicNotify()
  self._world:GetService("Trigger"):Notify(NTRoleTurnResultState:New())
end

function RoleTurnResultStateSystem:_DoLogicNormalAttackMonsterDead()
  local sMonsterShowLogic = self._world:GetService("MonsterShowLogic")
  sMonsterShowLogic:DoAllMonsterDeadLogic()
  local deadGroup = self._world:GetGroup(self._world.BW_WEMatchers.DeadMark)
  local normalSkillKillCount = #deadGroup:GetEntities()
  local battleStatCmpt = self._world:BattleStat()
  battleStatCmpt:SetNormalAttackKillCount(normalSkillKillCount)
end

function RoleTurnResultStateSystem:_DoRoleTurnResultEnd(teamEntity)
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local isTriggerDimension = boardServiceLogic:IsPlayerOnDimension(teamEntity)
  if isTriggerDimension then
    self._world:BattleStat():SetTriggerDimensionFlag(TriggerDimensionFlag.ChainAttack)
    self._world:EventDispatcher():Dispatch(GameEventType.RoleTurnResultFinish, 2)
  else
    self._world:EventDispatcher():Dispatch(GameEventType.RoleTurnResultFinish, 1)
  end
end

function RoleTurnResultStateSystem:_DoRestoreTeamLeader(teamEntity)
  local teamCmpt = teamEntity:Team()
  local teamLeaderEntityID = teamCmpt:GetOriginalTeamLeaderID()
  if teamLeaderEntityID then
    local teamLeaderEntity = self._world:GetEntityByID(teamLeaderEntityID)
    teamEntity:SetTeamLeaderPetEntity(teamLeaderEntity)
    teamCmpt:SetOriginalTeamLeaderID(nil)
  end
end

function RoleTurnResultStateSystem:_DoRenderPlayNotify(TT)
end

function RoleTurnResultStateSystem:_DoRenderNormalAttackMonsterDead(TT)
end

function RoleTurnResultStateSystem:_DoRenderGuideSkill(TT)
end

function RoleTurnResultStateSystem:_DoRenderWaitDeathEnd(TT)
end

function RoleTurnResultStateSystem:_WaitBeHitSkillFinish(TT)
end
