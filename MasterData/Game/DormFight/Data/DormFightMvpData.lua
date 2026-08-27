local DormFightMvpData = class("DormFightMvpData")

function DormFightMvpData:ctor(userId, fightIndex)
  self.userId = userId
  self.fightIndex = fightIndex
  self.killCount = 0
end

return DormFightMvpData
