local CommonPoltReviewGroupData = class("CommonPoltReviewData")

function CommonPoltReviewGroupData:ctor(groupENName, groupName, groupDes, AvgIdList)
  self.groupENName = groupENName
  self.groupName = groupName
  self.groupDes = groupDes
  self.AvgIdList = AvgIdList
  self.isUnlock = true
  self.unlockDes = nil
  self.couldShowBlueDotFunc = nil
  self.unfoldCallback = nil
end

function CommonPoltReviewGroupData:SetAvgGroupDataIsUnlock(isUnlock, unlockDes)
  self.isUnlock = isUnlock
  self.unlockDes = unlockDes
  return self
end

function CommonPoltReviewGroupData:SetAvgGroupDataBlueDotFunc(couldShowBlueDotFunc)
  self.couldShowBlueDotFunc = couldShowBlueDotFunc
  return self
end

function CommonPoltReviewGroupData:SetAvgSingleDotFunc(func)
  self._couldShowSingleDotFunc = func
end

function CommonPoltReviewGroupData:SetAvgGroupDataOperateData(unfoldCallback, playCallback)
  self.unfoldCallback = unfoldCallback
  self.playCallback = playCallback
  return self
end

function CommonPoltReviewGroupData:GetAvgGroupIsUnlock()
  return self.isUnlock
end

function CommonPoltReviewGroupData:GetAvgGroupUnlockDes()
  return self.unlockDes
end

function CommonPoltReviewGroupData:GetAvgGroupAvgIdList()
  return self.AvgIdList
end

function CommonPoltReviewGroupData:GetAvgGroupName()
  return self.groupENName, self.groupName, self.groupDes
end

function CommonPoltReviewGroupData:IsAvgGroupDataCouldBlueDot()
  if self.couldShowBlueDotFunc ~= nil then
    return self.couldShowBlueDotFunc()
  end
  return false
end

function CommonPoltReviewGroupData:IsAvgSingleReddot(avgid)
  if self._couldShowSingleDotFunc then
    return self._couldShowSingleDotFunc(avgid)
  end
  return false
end

function CommonPoltReviewGroupData:GetAvgGroupDataUnfoldCallback()
  return self.unfoldCallback
end

function CommonPoltReviewGroupData:GetAvgGroupDataPlayCallback()
  return self.playCallback
end

return CommonPoltReviewGroupData
