local RailWayMO = NewClass("RailWayMO")

function RailWayMO:ctor()
  self.stageTid = nil
  self.maxScore = 0
end

function RailWayMO:UpdateData(stageTid, svrData)
  self:SetStageTid(stageTid)
  self:SetMaxScore(svrData.maxScore)
end

function RailWayMO:SetStageTid(stageTid)
  if nil == stageTid then
    return
  end
  self.stageTid = stageTid
end

function RailWayMO:SetMaxScore(maxScore)
  if nil == maxScore then
    return
  end
  self.maxScore = maxScore
end

function RailWayMO:GetStageTid()
  return self.stageTid
end

function RailWayMO:GetState()
  return self.state
end

function RailWayMO:GetMaxScore()
  return self.maxScore
end

function RailWayMO:GetRecommendLevel()
  return StageCfgUtils.GetCfgField("StageLevel", self.stageTid) or 0
end

function RailWayMO:GetMaxProgress()
  do return StageCfgUtils.GetMapBossEliteRailWayExp end
  return StageCfgUtils.GetMapBossEliteRailWayExp, self.stageTid
end

return RailWayMO
