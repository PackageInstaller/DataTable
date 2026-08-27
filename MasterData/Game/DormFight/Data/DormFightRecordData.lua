local DormFightRecordData = class("FormationData")

function DormFightRecordData:ctor(msg)
  if msg ~= nil then
    self:UpdateRecord(msg)
  else
    self.actId = 1
    self.winCount = 0
    self.faildedCount = 0
    self.totalCount = 0
  end
end

function DormFightRecordData:UpdateRecord(msg)
  if msg == nil then
    return
  end
  self.actId = msg.actId
  self.winCount = msg.win
  self.faildedCount = msg.failed
  self.totalCount = msg.total
end

function DormFightRecordData:GetWinRate()
  if self.totalCount <= 0 then
    return string.format("%.2f", 0)
  end
  local rate = self.winCount / self.totalCount * 100
  return string.format("%.2f", rate)
end

return DormFightRecordData
