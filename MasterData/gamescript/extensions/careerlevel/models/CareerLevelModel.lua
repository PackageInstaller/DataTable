local CareerLevelModel = NewClass("CareerLevelModel", BaseModel)

function CareerLevelModel:OnInit()
  self._careerLevelMODict = {}
end

function CareerLevelModel:OnReset()
end

function CareerLevelModel:UpdateBySvrData(data)
  for careerLevelType, careerLevelData in pairs(data or {}) do
    self:UpdateCareerLevelMO(careerLevelType, careerLevelData)
  end
end

function CareerLevelModel:UpdateByResponse(svrData)
  self:UpdateCareerLevelMO(svrData.careerType, svrData.data)
  EventMgr.Instance.OnCareerLevelDataChanged:Dispatch(svrData.careerType)
end

function CareerLevelModel:_AddCareerLevelMO(careerLevelType, careerLevelMO)
  if not careerLevelType or not careerLevelMO then
    return
  end
  self._careerLevelMODict[careerLevelType] = careerLevelMO
end

function CareerLevelModel:DelCareerLevelMO(careerLevelType)
  if not careerLevelType then
    return
  end
  self._careerLevelMODict[careerLevelType] = nil
end

function CareerLevelModel:UpdateCareerLevelMO(careerLevelType, careerLevelSvrData)
  print("dung svrlevel", careerLevelType, table.tostring(careerLevelSvrData))
  if not careerLevelType or not careerLevelSvrData then
    return
  end
  local careerLevelMO = self:GetCareerLevelMO(careerLevelType)
  if not careerLevelMO then
    careerLevelMO = self:CreateCareerLevelMO(careerLevelSvrData)
    self:_AddCareerLevelMO(careerLevelType, careerLevelMO)
  end
  careerLevelMO:UpdateData(careerLevelSvrData)
end

function CareerLevelModel:CreateCareerLevelMO(careerLevelSvrData)
  local careerLevelMO = CareerLevelMO()
  careerLevelMO:UpdateData(careerLevelSvrData)
  return careerLevelMO
end

function CareerLevelModel:GetCareerLevelMO(careerLevelType)
  return self._careerLevelMODict[careerLevelType]
end

function CareerLevelModel:GetCareerLevel(careerLevelType)
  local careerLevelMO = self:GetCareerLevelMO(careerLevelType)
  if not careerLevelMO then
    return 0
  end
  do return careerLevelMO.GetLevel end
  return careerLevelMO.GetLevel, careerLevelMO
end

function CareerLevelModel:GetCareerLevelProgress(careerLevelType)
  local careerLevelMO = self:GetCareerLevelMO(careerLevelType)
  if not careerLevelMO then
    return 0, 0
  end
  return careerLevelMO:GetLevel() or 0, CareerLevelCfgUtils.GetMaxLevel(careerLevelType) or 0
end

function CareerLevelModel:GetNotReceiveRewardInfoList(careerLevelType)
  local rst = {}
  local careerLevelMO = self:GetCareerLevelMO(careerLevelType)
  if not careerLevelMO then
    return rst
  end
  local cfgList = CareerLevelCfgUtils.GetcfgListByType(careerLevelType)
  for _, cfg in pairs(cfgList) do
    if not careerLevelMO:IsGoted(cfg.Level) then
      local rewardList = {}
      if cfg.Type == CareerLevelDefine.CareerLevelType.RailWay then
        rewardList = cfg.LevelRewardV2 or {}
      else
        rewardList = cfg.LevelReward or {}
      end
      for i = 1, #rewardList, 2 do
        local tid = rewardList[i]
        local num = rewardList[i + 1]
        table.insert(rst, {tid = tid, num = num})
      end
    end
  end
  return rst
end

function CareerLevelModel:IsCareerLevelGoted(careerLevelType, level)
  local careerLevelMO = self:GetCareerLevelMO(careerLevelType)
  if not careerLevelMO then
    return false
  end
  do return careerLevelMO.IsGoted, careerLevelMO end
  return careerLevelMO.IsGoted, careerLevelMO, level
end

function CareerLevelModel:IsCareerLevelCanReceive(careerLevelType, level)
  local careerLevelMO = self:GetCareerLevelMO(careerLevelType)
  if not careerLevelMO then
    return false
  end
  do return careerLevelMO.IsCanReceive, careerLevelMO end
  return careerLevelMO.IsCanReceive, careerLevelMO, level
end

function CareerLevelModel:IsCareerCanReceive(careerLevelType)
  local careerLevelMO = self:GetCareerLevelMO(careerLevelType)
  if not careerLevelMO then
    return false
  end
  do return careerLevelMO.IsCanReceive end
  return careerLevelMO.IsCanReceive, careerLevelMO
end

function CareerLevelModel:IsMaxLevel(careerLevelType)
  local careerLevelMO = self:GetCareerLevelMO(careerLevelType)
  if not careerLevelMO then
    return false
  end
  local maxLevel = CareerLevelCfgUtils.GetMaxLevel(careerLevelType)
  return maxLevel <= careerLevelMO:GetLevel()
end

return CareerLevelModel
