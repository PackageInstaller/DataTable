_class("L2R_LoadingResult", Object)
L2R_LoadingResult = L2R_LoadingResult

function L2R_LoadingResult:Constructor()
  self._teamCreationResult = {}
  self._monsterResultList = {}
  self._chessPetCreationResult = {}
end

function L2R_LoadingResult:GetTeamCreationResult()
  return self._teamCreationResult
end

function L2R_LoadingResult:SetTeamCreationResult(teamRes)
  self._teamCreationResult = teamRes
end

function L2R_LoadingResult:SetLoadMonsterResultList(resList)
  self._monsterResultList = resList
end

function L2R_LoadingResult:GetLoadMonsterResultList()
  return self._monsterResultList
end

function L2R_LoadingResult:GetChessPetCreationResult()
  return self._chessPetCreationResult
end

function L2R_LoadingResult:SetChessPetCreationResult(res)
  self._chessPetCreationResult = res
end
