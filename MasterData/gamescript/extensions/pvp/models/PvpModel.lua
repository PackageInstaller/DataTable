local PvpModel = NewClass("PvpModel", BaseModel)

function PvpModel:OnInit()
  self._curTeamIdx = 1
end

function PvpModel:OnReset()
  self:OnInit()
end

function PvpModel:GetCurTeamIdx()
  return self._curTeamIdx
end

function PvpModel:SetCurTeamIdx(teamIdx)
  self._curTeamIdx = teamIdx
end

return PvpModel
