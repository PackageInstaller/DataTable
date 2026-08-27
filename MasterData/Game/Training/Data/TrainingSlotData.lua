local TrainingSlotData = class("TrainingSlotData")
local TrainEnum = require("Game.Training.TrainEnum")

function TrainingSlotData.InitAllTrainingSlotData()
  local trainingCfg = ConfigData.training[TrainEnum.eTrainingDataType.Slot]
  local slotDatas = {}
  for i = 1, #trainingCfg do
    local key = i
    local cfg = trainingCfg[key]
    local slotData = TrainingSlotData.New()
    slotData:InitTrainingData(cfg)
    slotDatas[key] = slotData
  end
  return slotDatas
end

function TrainingSlotData:InitTrainingData(stcData)
  self.stcData = stcData
  self.index = stcData.type_id
  self.duration = 0
  self.progress = 0
  self.remainSecond = 0
end

function TrainingSlotData:UpdateTrainingData(data)
  self.heroId = data.hero
  self.effectiveness = data.effectiveness
  self.overTm = data.overTm
  self.startTm = data.startTm
  self.extraNum = data.extraNum
  if self.overTm ~= nil then
    self.totalTime = self.overTm - self.startTm
  else
    self.totalTime = nil
  end
end

function TrainingSlotData:Empty()
  self:UpdateTrainingData({})
end

function TrainingSlotData:CheckUnlock()
  local stcData = self.stcData
  local unlock = CheckCondition.CheckLua(stcData.pre_condition, stcData.pre_para1, stcData.pre_para2)
  return unlock, stcData.pre_para2
end

function TrainingSlotData:UpdateProgress(timestamp)
  local totalTime = self.totalTime
  local duration = math.floor(timestamp - self.startTm)
  duration = math.max(duration, 0)
  duration = math.min(duration, totalTime)
  local remainSecond = totalTime - duration
  local progress = duration / totalTime
  self.duration = duration
  self.progress = progress
  self.remainSecond = remainSecond
  return duration, remainSecond, progress
end

return TrainingSlotData
