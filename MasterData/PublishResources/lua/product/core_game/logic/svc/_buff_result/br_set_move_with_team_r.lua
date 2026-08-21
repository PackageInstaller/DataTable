_class("BuffResultSetMoveWithTeam", BuffResultBase)
BuffResultSetMoveWithTeam = BuffResultSetMoveWithTeam

function BuffResultSetMoveWithTeam:Constructor(bSet, teamEntity)
  self._bSet = bSet
  self._targetTeamEntity = teamEntity
end

function BuffResultSetMoveWithTeam:IsSet()
  return self._bSet
end

function BuffResultSetMoveWithTeam:GetTargetTeamEntity()
  return self._targetTeamEntity
end
