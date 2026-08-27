local DormVisitData = class("DormRoomData")

function DormVisitData:ctor()
end

function DormVisitData:InitRoomData(dormVisit)
  self:RefreshDormVisitData(dormVisit)
end

function DormVisitData:RefreshDormVisitData(dormVisit)
  self.dormVisit = dormVisit
  self:UpdateShowVisitRoom(dormVisit.rooms)
  self:UpdateLikeRewardTime(dormVisit.favorRewardTime)
  self:UpdateFavorDic(dormVisit.favorId)
end

function DormVisitData:GetLikeCount()
  return self.dormVisit.favor
end

function DormVisitData:IsShowVisitRoom(houseId, pos)
  if self.showVisitRoomDic[houseId] == nil then
    return false
  end
  return self.showVisitRoomDic[houseId][pos] == true
end

function DormVisitData:UpdateShowVisitRoom(rooms)
  self.showVisitRoomDic = {}
  if table.IsEmptyTable(rooms) then
    local pos = 16777472
    local houseId = 2
    if self.showVisitRoomDic[houseId] == nil then
      self.showVisitRoomDic[houseId] = {}
    end
    self.showVisitRoomDic[houseId][pos] = true
    return
  end
  for houseId, roomAvail in pairs(rooms) do
    if self.showVisitRoomDic[houseId] == nil then
      self.showVisitRoomDic[houseId] = {}
    end
    for index, pos in ipairs(roomAvail.pos) do
      self.showVisitRoomDic[houseId][pos] = true
    end
  end
end

function DormVisitData:GetLikeRewardCount()
  return self.dormVisit.nextFreshTm
end

function DormVisitData:GetNextLikeFreshTm()
  return self.dormVisit.nextFreshTm
end

function DormVisitData:GetSelfRoomLikeCount()
  return self.dormVisit.favor
end

function DormVisitData:UpdateLikeRewardTime(time)
  self.likeRewardTime = time
end

function DormVisitData:GetLikeRewardTime()
  return self.likeRewardTime
end

function DormVisitData:UpdateFavorDic(userIdList)
  if self.favorDic == nil then
    self.favorDic = {}
  end
  for index, userId in ipairs(userIdList) do
    self.favorDic[userId] = true
  end
end

function DormVisitData:SetHasLike(userId)
  if self.favorDic == nil then
    self.favorDic = {}
  end
  self.favorDic[userId] = true
end

function DormVisitData:IsHasLike(userId)
  return self.favorDic[userId] == true
end

return DormVisitData
