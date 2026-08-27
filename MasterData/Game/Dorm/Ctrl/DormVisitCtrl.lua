local DormCtrlBase = require("Game.Dorm.Ctrl.DormCtrlBase")
local DormVisitCtrl = class("DormVisitCtrl", DormCtrlBase)
local DormVisitData = require("Game.Dorm.Data.DormVisitData")
local DormEnum = require("Game.Dorm.DormEnum")

function DormVisitCtrl:RefreshDormVisitCtrl(dormVisit)
  if self.dormVisitData == nil then
    self.dormVisitData = DormVisitData.New()
  end
  self.dormVisitData:RefreshDormVisitData(dormVisit)
end

function DormVisitCtrl:RefreshRoomLikeCount(userId, likeCount)
  if self.roomLikeCountDic == nil then
    self.roomLikeCountDic = {}
  end
  self.roomLikeCountDic[userId] = likeCount
  self.roomLikeCount = likeCount
end

function DormVisitCtrl:GetSelfRoomLikeCount()
  if self.dormVisitData == nil then
    return 0
  end
  return self.dormVisitData:GetSelfRoomLikeCount()
end

function DormVisitCtrl:GetVisitRoomLikeCount(roomOwnerUserId)
  if self.roomLikeCountDic == nil or self.roomLikeCountDic[roomOwnerUserId] == nil then
    return 0
  end
  return self.roomLikeCountDic[roomOwnerUserId]
end

function DormVisitCtrl:GetVisitRoomLikeCountText(roomOwnerUserId)
  local count = self:GetVisitRoomLikeCount(roomOwnerUserId)
  if 99999 < count then
    return "99999+"
  else
    return tostring(count)
  end
end

function DormVisitCtrl:AddLikeVisitRoom(roomOwnerUserId, callback)
  self.dormCtrl.dormNetwork:CS_DORM_VisitFavor(roomOwnerUserId, callback)
end

function DormVisitCtrl:IsHasLike(userId)
  if self.dormVisitData == nil then
    return true
  end
  return self.dormVisitData:IsHasLike(userId)
end

function DormVisitCtrl:UpdateLikeRewardTime(time)
  self.dormVisitData:UpdateLikeRewardTime(time)
end

function DormVisitCtrl:GetLikeRewardTime()
  if self.dormVisitData == nil then
    return 0
  end
  local maxTimes = ConfigData.oasis_building_dorm_visit[1].favor_reward_times
  return maxTimes - self.dormVisitData:GetLikeRewardTime()
end

function DormVisitCtrl:GetLikeRewardTimeAndMaxTimeText()
  if self.dormVisitData == nil then
    return "0", "0"
  end
  local maxTimes = ConfigData.oasis_building_dorm_visit[1].favor_reward_times
  local times = maxTimes - self.dormVisitData:GetLikeRewardTime()
  return tostring(times), tostring(maxTimes)
end

function DormVisitCtrl:UpdateVisitFavor(msg)
  if msg.rewards ~= nil and table.count(msg.rewards) > 0 then
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      local CommonRewardData = require("Game.CommonUI.CommonRewardData")
      local CRData = CommonRewardData.CreateCRDataUseDic(msg.rewards)
      window:AddAndTryShowReward(CRData)
    end)
  end
  local userId = msg.visitee
  if self.roomLikeCountDic ~= nil and self.roomLikeCountDic[userId] ~= nil then
    self.roomLikeCountDic[userId] = self.roomLikeCountDic[userId] + 1
  else
    self.roomLikeCountDic[userId] = 1
  end
  self:UpdateLikeRewardTime(msg.favorRewardTime)
  if self.dormVisitData ~= nil then
    self.dormVisitData:SetHasLike(userId)
  end
end

function DormVisitCtrl:GetVisitorData(visitorType, callback)
  if self.dormVisitData == nil then
    callback(nil)
    return
  end
  if visitorType == DormEnum.VisitPageType.Visitors then
    PlayerDataCenter:GetUserInfoByUIDList(self.dormVisitData.dormVisit.visitors, function(userInfoList)
      callback(userInfoList)
    end)
  end
  if visitorType == DormEnum.VisitPageType.VisitByMe then
    PlayerDataCenter:GetUserInfoByUIDList(self.dormVisitData.dormVisit.visitByMe, function(userInfoList)
      callback(userInfoList)
    end)
  end
  if visitorType == DormEnum.VisitPageType.Friend then
    callback(PlayerDataCenter.friendDataCenter:GetFreindList())
  end
end

function DormVisitCtrl:IsShowVisitRoom(roomData)
  if self.dormVisitData == nil then
    return true
  end
  local houseId = roomData.belongtohouseid
  local pos = roomData.spos
  return self.dormVisitData:IsShowVisitRoom(houseId, pos)
end

function DormVisitCtrl:SetShowVisitRoom(houseId, pos, callback)
  self.dormCtrl.dormNetwork:CS_DORM_VisitAvailSet(houseId, pos, callback)
end

function DormVisitCtrl:UpdateShowVisitRoomData(rooms)
  self.dormVisitData:UpdateShowVisitRoom(rooms)
end

return DormVisitCtrl
