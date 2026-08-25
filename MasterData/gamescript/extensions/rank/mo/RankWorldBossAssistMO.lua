local RankWorldBossAssistMO, Super = NewClass("RankWorldBossAssistMO", RankBaseMO)

function RankWorldBossAssistMO:ctor()
  Super.ctor(self)
  self.team = nil
end

function RankWorldBossAssistMO:UpdateData(data)
  Super.UpdateData(self, data)
  self:SetTeam(data.team)
end

function RankWorldBossAssistMO:SetTeam(team)
  if nil == team then
    return
  end
  self.team = team
end

function RankWorldBossAssistMO:GetTeam()
  return self.team
end

function RankWorldBossAssistMO:GetAssistAwakerTid()
  local assistAwakerData = self.team and self.team.assistAwaker
  if not assistAwakerData then
    return
  end
  return assistAwakerData.tid
end

function RankWorldBossAssistMO:GetAssistAwakerLevel()
  local assistAwakerData = self.team and self.team.assistAwaker
  if not assistAwakerData then
    return
  end
  return assistAwakerData.level
end

return RankWorldBossAssistMO
