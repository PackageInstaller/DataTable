local BaseCharacterAI = class("BaseCharacterAI")
local Messenger = require("Framework.Common.Messenger")

function BaseCharacterAI:ctor(aiCfg, autoNextState)
  self.aiCfg = aiCfg
  self.__OnCurStateExit = BindCallback(self, self.OnCurStateExit)
  self.__randNextOnExit = autoNextState
  self:InitAIData()
end

function BaseCharacterAI:InitAIData()
  self.desires = {}
  for k, v in ipairs(self.aiCfg.desire_init) do
    self.desires[k] = v
  end
  self.desireOpen = {}
  for i = 1, #self.desires do
    self.desireOpen[i] = true
  end
  self.state = nil
end

function BaseCharacterAI:GetCurAIState()
  return self.state
end

function BaseCharacterAI:RefreshDesireOpen()
  self.weightSum = 0
  for index, actionId in ipairs(self.aiCfg.actions) do
    local actionCfg = ConfigData.dorm_action[actionId]
    local ableOpen = false
    if actionCfg ~= nil then
      ableOpen = true
    end
    if ableOpen then
      self.desireOpen[index] = true
      self.weightSum = self.weightSum + self.desires[index]
    else
      self.desireOpen[index] = false
    end
  end
end

function BaseCharacterAI:RandNewAction()
  self:RefreshDesireOpen()
  local rangValue = math.random(self.weightSum)
  local weightCount = 0
  for index, v in pairs(self.desireOpen) do
    if v then
      weightCount = weightCount + self.desires[index]
      if rangValue <= weightCount then
        self:SetCurState(index)
        break
      end
    end
  end
end

function BaseCharacterAI:GetStateClass(type)
end

function BaseCharacterAI:SetCurState(index)
  local actionId = self.aiCfg.actions[index]
  local actionCfg = ConfigData.dorm_action[actionId]
  if actionCfg == nil then
    return
  end
  local stateClass = self:GetStateClass(actionCfg.type)
  if stateClass == nil then
    return
  end
  local state = stateClass.New(self, actionCfg, self.__OnCurStateExit)
  self.state = state
  self.stateType = actionCfg.type
  local duration = self:CalAIStateDuration(index)
  self.state:SetStateDuration(duration)
  self.state:StartState()
  self:ReassignDesires(index)
end

function BaseCharacterAI:CalAIStateDuration(index)
  local mintime = self.aiCfg.min_time[index]
  local maxTime = self.aiCfg.max_time[index]
  local time = mintime + math.random(maxTime - mintime + 1) - 1
  if 1 < #self.desires then
    local otherUpRateSum = 0
    for curindex, v in pairs(self.aiCfg.desire_up_rate) do
      if curindex ~= index then
        otherUpRateSum = otherUpRateSum + v
      end
    end
    time = time + self.aiCfg.time_weight[index] * (self.desires[index] // otherUpRateSum)
  end
  return time
end

function BaseCharacterAI:ReassignDesires(index)
  if #self.desires <= 1 then
    return
  end
  local otherUpRateSum = 0
  for curindex, v in ipairs(self.desireOpen) do
    if v then
      otherUpRateSum = otherUpRateSum + self.aiCfg.desire_up_rate[curindex]
    end
  end
  local currentDesireNewValue = self.desires[index] % otherUpRateSum
  local currentDesireConsumption = self.desires[index] - currentDesireNewValue
  self.desires[index] = currentDesireNewValue
  if currentDesireConsumption <= 0 then
    return
  end
  while 0 < currentDesireConsumption do
    for curindex, v in ipairs(self.desireOpen) do
      if v then
        self.desires[curindex] = self.desires[curindex] + self.aiCfg.desire_up_rate[curindex]
        currentDesireConsumption = currentDesireConsumption - self.aiCfg.desire_up_rate[curindex]
      end
    end
  end
end

function BaseCharacterAI:AIInterruptCurrState(gotoNext)
  if self.state ~= nil then
    self.state:InterruptState(gotoNext)
  end
  self.state = nil
end

function BaseCharacterAI:AIStartExitWait(action, ...)
  if self.state == nil then
    if action ~= nil then
      action(false)
    end
    return
  end
  self.state:StartExitWait(action, ...)
end

function BaseCharacterAI:EnableExitCurrentState()
  if self.state == nil then
    return true
  end
  return self.state:EnableExitState()
end

function BaseCharacterAI:OnUpdate()
  if self.state ~= nil then
    self.state:OnUpdate()
  end
end

function BaseCharacterAI:OnCurStateExit(state, enterNext)
  local stateType = self.stateType
  self.state = nil
  self.stateType = 0
  if self.__randNextOnExit and enterNext then
    self:RandNewAction()
  end
end

return BaseCharacterAI
