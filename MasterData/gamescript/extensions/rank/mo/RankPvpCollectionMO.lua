local RankPvpCollectionMO, Super = NewClass("RankPvpCollectionMO", RankBaseMO)

function RankPvpCollectionMO:ctor()
  Super.ctor(self)
end

function RankPvpCollectionMO:UpdateData(data)
  Super.UpdateData(self, data)
end

function RankPvpCollectionMO:GetPlayerName()
  return self.name
end

function RankPvpCollectionMO:GetPlayerIcon()
  return self.icon
end

function RankPvpCollectionMO:GetPlayerFrame()
  return self.avatarFrame
end

function RankPvpCollectionMO:GetWinCount()
  return self.score
end

function RankPvpCollectionMO:GetRankType()
  return self.type
end

function RankPvpCollectionMO:GetRankIdx()
  return self.rank
end

return RankPvpCollectionMO
