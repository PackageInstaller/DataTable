local SectorPlayModeData = class("SectorPlayModeData")

function SectorPlayModeData:ctor()
  self.tagIndex = nil
  self.stateType = nil
  self.stateStrArray = nil
  self.secondeStateType = nil
  self.secondeStateStrArray = nil
  self.spEndtime = nil
  self.getLeftTimeStrFunc = nil
  self.rewardProgress = nil
end

function SectorPlayModeData:SetSPMTagInfo(index)
  self.tagIndex = index
end

function SectorPlayModeData:GetSPMTagInfo()
  return self.tagIndex
end

function SectorPlayModeData:SetSPMStateInfo(stateType, strArray)
  self.stateType = stateType
  self.stateStrArray = strArray
end

function SectorPlayModeData:GetSPMStateInfo()
  return self.stateType, self.stateStrArray
end

function SectorPlayModeData:SetSSPMStateInfo(stateType, strArray)
  self.secondeStateType = stateType
  self.secondeStateStrArray = strArray
end

function SectorPlayModeData:GetSSPMStateInfo()
  return self.secondeStateType, self.secondeStateStrArray
end

function SectorPlayModeData:SetSPEndTime(spEndtime)
  self.spEndtime = spEndtime
end

function SectorPlayModeData:GetSPEndTime()
  return self.spEndtime
end

function SectorPlayModeData:SetGetLeftTimeFunc(getLeftTimeStrFunc)
  self.getLeftTimeStrFunc = getLeftTimeStrFunc
end

function SectorPlayModeData:GetGetLeftTimeFunc()
  return self.getLeftTimeStrFunc
end

function SectorPlayModeData:SetSPMRewardProgress(currentStage, totalStage, isReceiveAll, rewardItemList, curStageFullPointNum)
  if currentStage == nil then
    self.rewardProgress = nil
  end
  self.rewardProgress = {
    currentStage = currentStage,
    totalStage = totalStage,
    isReceiveAll = isReceiveAll,
    rewardItemList = rewardItemList,
    curStageFullPointNum = curStageFullPointNum
  }
end

function SectorPlayModeData:GetSPMRewardProgress()
  return self.rewardProgress
end

function SectorPlayModeData:SetSPMUp()
  self._hasUp = true
end

function SectorPlayModeData:IsSPMUp()
  return self._hasUp
end

function SectorPlayModeData:SetSPMUpInfo(info)
  self._upInfo = info
end

function SectorPlayModeData:GetSPMUpInfo()
  return self._upInfo
end

return SectorPlayModeData
