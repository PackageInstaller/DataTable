local RankRailWayMO, Super = NewClass("RankRailWayMO", RankBaseMO)

function RankRailWayMO:ctor()
  Super.ctor(self)
  self.score2 = 0
  self.team = nil
end

function RankRailWayMO:UpdateData(data)
  Super.UpdateData(self, data)
  self:SetScore2(data.score2)
  self:SetTeam(data.railWayTeam)
end

function RankRailWayMO:SetTeam(team)
  if nil == team then
    return
  end
  self.team = team
end

function RankRailWayMO:SetScore2(score2)
  if nil == score2 then
    return
  end
  self.score2 = score2
end

function RankRailWayMO:GetTeam()
  if not self.team then
    return {}
  end
  return self.team
end

function RankRailWayMO:GetTeamAwakers()
  return self.team and self.team.awakers or {}
end

function RankRailWayMO:GetStageTid()
  return self.team and self.team.stageId
end

function RankRailWayMO:GetWid()
  return self.team and self.team.wid
end

function RankRailWayMO:GetRoundNum()
  return self.score2
end

return RankRailWayMO
