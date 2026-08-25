local DonationBoxModel = NewClass("DonationBoxModel", BaseModel)
local SECOND_PER_HOUR = 3600
local BoxActiveState = {
  Unactive = 0,
  Active = 1,
  Finish = 10
}
local BoxRewardState = {
  CannotGain = 0,
  CanGain = 1,
  AlreadyGain = 2,
  FullGain = 3
}

function DonationBoxModel:OnInit()
  self:OnReset()
end

function DonationBoxModel:OnReset()
  self.boxes = {}
end

function DonationBoxModel:GetDonationBoxData(produceTid)
  if not produceTid or not self.boxes[produceTid] then
    return
  end
  return self.boxes[produceTid]
end

function DonationBoxModel:UpdateDonationBoxData(donationBoxData)
  if not donationBoxData then
    return
  end
  local produceTid = donationBoxData.tid
  if not self.boxes[produceTid] then
    self.boxes[produceTid] = donationBoxData
  else
    for k, v in pairs(donationBoxData) do
      self.boxes[produceTid][k] = v
    end
  end
  self:UpdateProduceShow(donationBoxData)
end

function DonationBoxModel:UpdateDonationBoxRed()
  if not self.boxes then
    return
  end
  local RedType_DonationBox = RedTypeDefine.RedType.DonationBox
  if not DataCenter.redPointData[RedType_DonationBox] then
    DataCenter.redPointData[RedType_DonationBox] = {}
  end
  for produceTid, donationBoxData in pairs(self.boxes) do
    if donationBoxData then
      if not DataCenter.redPointData[RedType_DonationBox][produceTid] then
        DataCenter.redPointData[RedType_DonationBox][produceTid] = {}
      end
      local red = self:IsReachMaxReward(produceTid) and 1 or 0
      DataCenter.redPointData[RedType_DonationBox][produceTid].red = red
    end
  end
end

function DonationBoxModel:UpdateProduceShow(svrData)
  self:LocalNotify(NotifyId.OnActivityDonationProduceUpdate, svrData)
end

function DonationBoxModel:GetProductConfig(produceTid)
  if not produceTid then
    return
  end
  return DT.Produce[produceTid]
end

function DonationBoxModel:GetProductRewardTids(produceTid)
  local config = self:GetProductConfig(produceTid)
  if not (config and config.ProductContent) or not config.ProductContent[1] then
    return
  end
  local dropConfig = DT.Drop[config.ProductContent[1]]
  if not dropConfig or not dropConfig.data_list then
    return
  end
  local tids = {}
  tids.normal = dropConfig.data_list[1] and dropConfig.data_list[1].DropItem
  if config.ExtraProduce and config.ExtraProduce[1] then
    local extraDropConfig = DT.Drop[config.ExtraProduce[1]]
    if extraDropConfig and extraDropConfig.data_list and extraDropConfig.data_list[1] then
      tids.extra = extraDropConfig.data_list[1].DropItem
    end
  end
  return tids
end

function DonationBoxModel:GetProductionSpeeds(produceTid)
  local speeds = {normal = "-"}
  if not produceTid then
    return speeds
  end
  local boxData = self:GetDonationBoxData(produceTid)
  local calcExtra = false
  if boxData and boxData.extraDrop then
    speeds.extra = "-"
    calcExtra = true
  end
  local config = self:GetProductConfig(produceTid)
  if not (config and config.ProductContent) or not config.ProductContent[1] then
    return speeds
  end
  local dropConfig = DT.Drop[config.ProductContent[1]]
  if not dropConfig or not dropConfig.data_list then
    return speeds
  end
  local dropNum = dropConfig.data_list[1] and dropConfig.data_list[1].DropNum
  local productInterval = config.ProductInterval
  if not dropNum or not productInterval then
    return speeds
  end
  speeds.normal = self:CalcProduceSpeed(productInterval, dropNum)
  if calcExtra and config.ExtraProduce and config.ExtraProduce[1] then
    local extraDropConfig = DT.Drop[config.ExtraProduce[1]]
    if extraDropConfig and extraDropConfig.data_list and extraDropConfig.data_list[1] and extraDropConfig.data_list[1].DropNum then
      local extraDropNum = extraDropConfig.data_list[1].DropNum
      speeds.extra = self:CalcProduceSpeed(productInterval, extraDropNum)
    end
  end
  return speeds
end

function DonationBoxModel:CalcProduceSpeed(productInterval, dropNum)
  do return math.ceil end
  return math.ceil, dropNum * (SECOND_PER_HOUR / productInterval)
end

function DonationBoxModel:GetRewardListBySvrData(produceTid)
  local donationBoxData = self:GetDonationBoxData(produceTid)
  if not donationBoxData or not donationBoxData.dropItems then
    return {}
  end
  
  local function _GetItemTidsByDropTid(dropTids)
    local itemInfoMap = {}
    local idx = 1
    for _, dropTid in ipairs(dropTids) do
      if not dropTid then
      else
        local dropConfig = DT.Drop[dropTid]
        if not dropConfig or not dropConfig.data_list then
        else
          for _, dropData in ipairs(dropConfig.data_list) do
            if dropData and dropData.DropItem then
              itemInfoMap[dropData.DropItem] = {
                tid = dropData.DropItem,
                num = 0,
                index = idx
              }
              idx = idx + 1
            end
          end
        end
      end
    end
    return itemInfoMap
  end
  
  local list = {}
  local tmpMap = {}
  local config = self:GetProductConfig(produceTid)
  if config and config.ProductContent then
    tmpMap = _GetItemTidsByDropTid(config.ProductContent)
  end
  local hasExtraDrop = self:HasExtraProduceReward(produceTid)
  if hasExtraDrop and config and config.ExtraProduce then
    table.merge(tmpMap, _GetItemTidsByDropTid(config.ExtraProduce))
  end
  for tid, num in pairs(donationBoxData.dropItems) do
    if tid and num and tmpMap[tid] then
      tmpMap[tid].num = num
    end
  end
  for _, itemInfo in pairs(tmpMap) do
    if itemInfo.num > 0 then
      table.insert(list, {
        tid = itemInfo.tid,
        num = itemInfo.num,
        index = itemInfo.index
      })
    end
  end
  table.sort(list, function(a, b)
    return a.index < b.index
  end)
  return list
end

function DonationBoxModel:GetFullGainLeftTime(produceTid)
  local boxData = self:GetDonationBoxData(produceTid)
  if not boxData or not boxData.dropFullTime then
    return -1
  end
  local now = TimeUtils.GetServerTime()
  local leftTime = boxData.dropFullTime - now
  if leftTime < 0 then
    leftTime = 0
  end
  return leftTime
end

function DonationBoxModel:GetNextGainRewardLeftTime(produceTid)
  local boxData = self:GetDonationBoxData(produceTid)
  if not boxData or not boxData.dropNextTime then
    return -1
  end
  local now = TimeUtils.GetServerTime()
  local leftTime = boxData.dropNextTime - now
  if leftTime < 0 then
    leftTime = 0
  end
  return leftTime
end

function DonationBoxModel:GetCountdownTimeFormatText(leftTime)
  if not leftTime then
    return ""
  end
  if leftTime <= 0 then
    return ""
  end
  local h, m, s = math.floor(leftTime / 3600), math.floor(leftTime % 3600 / 60), math.floor(leftTime % 60)
  if h > 0 then
    do return string.format, "%02d:%02d:%02d", h, m end
    return string.format, "%02d:%02d:%02d", h, m, s
  end
  do return string.format, "%02d:%02d", m end
  return string.format, "%02d:%02d", m, s, s
end

function DonationBoxModel:GetBoxName(produceTid)
  local config = self:GetProductConfig(produceTid)
  return config and config.Name and LT.Text(config.Name)
end

function DonationBoxModel:GetBoxWorldviewText(produceTid)
  local config = self:GetProductConfig(produceTid)
  return config and config.WorldviewText and LT.Text(config.WorldviewText)
end

function DonationBoxModel:GetBoxUnlockTips(produceTid)
  local config = self:GetProductConfig(produceTid)
  return config and config.UnlockTips and LT.Text(config.UnlockTips)
end

function DonationBoxModel:IsBoxActive(produceTid)
  local boxData = self:GetDonationBoxData(produceTid)
  return boxData and boxData.state == BoxActiveState.Active
end

function DonationBoxModel:IsBoxFinish(produceTid)
  local boxData = self:GetDonationBoxData(produceTid)
  return boxData and boxData.state == BoxActiveState.Finish
end

function DonationBoxModel:IsRewardEmpty(produceTid)
  local boxData = self:GetDonationBoxData(produceTid)
  return not boxData or not boxData.dropItems or table.next(boxData.dropItems) == nil
end

function DonationBoxModel:IsReachMaxReward(produceTid)
  local boxData = self:GetDonationBoxData(produceTid)
  return boxData and boxData.rewardState == BoxRewardState.FullGain
end

function DonationBoxModel:EnableGainReward(produceTid)
  local boxData = self:GetDonationBoxData(produceTid)
  if not boxData then
    return false
  end
  return boxData.rewardState == BoxRewardState.CanGain or boxData.rewardState == BoxRewardState.FullGain
end

function DonationBoxModel:HasExtraProduceReward(produceTid)
  local boxData = self:GetDonationBoxData(produceTid)
  return boxData and boxData.extraDrop
end

return DonationBoxModel
