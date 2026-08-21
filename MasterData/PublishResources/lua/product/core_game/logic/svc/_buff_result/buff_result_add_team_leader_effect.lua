require("_buff_result_base")
_class("BuffResultAddTeamLeaderEffect", BuffResultBase)
BuffResultAddTeamLeaderEffect = BuffResultAddTeamLeaderEffect

function BuffResultAddTeamLeaderEffect:Constructor(oldTeamLeaderID, newTeamLeaderID, effectID, remove, removeAnim, removeAnimTime)
  self._oldTeamLeaderID = oldTeamLeaderID
  self._newTeamLeaderID = newTeamLeaderID
  self._effectID = effectID
  self._remove = remove
  self._removeAnim = removeAnim
  self._removeAnimTime = removeAnimTime
end

function BuffResultAddTeamLeaderEffect:GetOldTeamLeaderID()
  return self._oldTeamLeaderID
end

function BuffResultAddTeamLeaderEffect:GetNewTeamLeaderID()
  return self._newTeamLeaderID
end

function BuffResultAddTeamLeaderEffect:GetEffectID()
  return self._effectID
end

function BuffResultAddTeamLeaderEffect:GetRemove()
  return self._remove
end

function BuffResultAddTeamLeaderEffect:GetRemoveAnim()
  return self._removeAnim
end

function BuffResultAddTeamLeaderEffect:GetRemoveAnimTime()
  return self._removeAnimTime
end
