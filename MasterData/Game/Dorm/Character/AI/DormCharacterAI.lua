local DormCharacterAI = class("DormCharacterAI")
local DormAIStateConfig = require("Game.Dorm.Character.AI.DormAIStateConfig")
local DormUtil = require("Game.Dorm.DormUtil")
local DormEnum = require("Game.Dorm.DormEnum")
local Messenger = require("Framework.Common.Messenger")

function DormCharacterAI:ctor(aiCfg, charEntity, autoNextState)
  self.aiCfg = aiCfg
  self.charEntity = charEntity
  self.__dormAIMsg = Messenger.New()
  self.__OnCurStateExit = BindCallback(self, self.OnCurStateExit)
  self.__randNextOnExit = autoNextState
  self:InitAIData()
end

function DormCharacterAI:InitAIData()
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

function DormCharacterAI:GetCurAIState()
  return self.state
end

function DormCharacterAI:RefreshDesireOpen()
  local roomData = self.charEntity.roomData
  if roomData == nil then
    return
  end
  self.weightSum = 0
  for index, actionId in ipairs(self.aiCfg.actions) do
    local actionCfg = ConfigData.dorm_action[actionId]
    local ableOpen = false
    if actionCfg ~= nil then
      if actionCfg.type == DormAIStateConfig.eDormActionType.Fnt then
        for k, v in ipairs(roomData.interpoint) do
          if v:GetPointActive() and v:GetInterPointType() == actionCfg.interact_point_type then
            ableOpen = true
            break
          end
        end
      elseif actionCfg.type == DormAIStateConfig.eDormActionType.Visit then
        ableOpen = self.charEntity.roomCharCtrl:HaveOtherNoFullRoom()
      else
        ableOpen = true
      end
    end
    if ableOpen then
      self.desireOpen[index] = true
      self.weightSum = self.weightSum + self.desires[index]
    else
      self.desireOpen[index] = false
    end
  end
end

function DormCharacterAI:RandNewAction()
  if self.charEntity:IsDormUnBindTimeout() and self:UnBindCharacterStartExit() then
    if isEditorMode then
      warn("非绑定角色换人:" .. self.charEntity.heroData:GetName())
    end
    return
  end
  self:RefreshDesireOpen()
  local roomData = self.charEntity.roomData
  if roomData == nil then
    return
  end
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

function DormCharacterAI:SetCurState(index)
  local actionId = self.aiCfg.actions[index]
  local actionCfg = ConfigData.dorm_action[actionId]
  if actionCfg == nil then
    return
  end
  local state = DormAIStateConfig.GetState(actionCfg.type).New(self, actionCfg, self.__OnCurStateExit)
  self.state = state
  self.stateType = actionCfg.type
  local duration = self:CalAIStateDuration(index)
  self.state:SetStateDuration(duration)
  self.state:StartState()
  if isEditorMode then
    warn(self.charEntity.heroData:GetName() .. self.state:GetStateName())
  end
  self:ReassignDesires(index)
end

function DormCharacterAI:CalAIStateDuration(index)
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

function DormCharacterAI:ReassignDesires(index)
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

function DormCharacterAI:AIInterruptCurrState(gotoNext)
  if self.state ~= nil then
    self.state:InterruptState(gotoNext)
  end
  self.state = nil
end

function DormCharacterAI:AIStartExitWait(action, ...)
  if self.state == nil then
    if action ~= nil then
      action(false)
    end
    return
  end
  self.state:StartExitWait(action, ...)
end

function DormCharacterAI:EnableExitCurrentState()
  if self.state == nil then
    return true
  end
  return self.state:EnableExitState()
end

function DormCharacterAI:StartFntInterPointState(interPoint, setPos)
  if self:__StartFntInterPoint(self.aiCfg.actions, interPoint, setPos, true) then
    return
  end
  if self:__StartFntInterPoint(self.aiCfg.support_actions, interPoint, setPos, false) then
    return
  end
  if isEditorMode then
    warn("角色[" .. tostring(self.charEntity.heroData.dataId) .. "]没有找到家具交互点类型:" .. tostring(interPoint:GetInterPointType()))
  end
end

function DormCharacterAI:__StartFntInterPoint(actions, interPoint, setPos, normal)
  for index, actionId in ipairs(actions) do
    local actionCfg = ConfigData.dorm_action[actionId]
    if actionCfg ~= nil and actionCfg.type == DormAIStateConfig.eDormActionType.Fnt and actionCfg.interact_point_type == interPoint:GetInterPointType() then
      local state = DormAIStateConfig.GetState(actionCfg.type).New(self, actionCfg, self.__OnCurStateExit)
      self.state = state
      self.stateType = actionCfg.type
      if normal then
        local duration = self:CalAIStateDuration(index)
        self.state:SetStateDuration(duration)
        self.state:StateStateByInterPoint(interPoint, setPos)
        self:ReassignDesires(index)
      else
        self.state:SetStateDuration(math.maxinteger)
        self.state:StateStateByInterPoint(interPoint, setPos)
      end
      return true
    end
  end
  return false
end

function DormCharacterAI:StartVisitOtherRoom(action)
  local state = DormAIStateConfig.GetDormVisitState().New(self, nil, self.__OnCurStateExit)
  self.state = state
  self.stateType = 0
  state:DirectExitRoom(action)
end

function DormCharacterAI:UnBindCharacterStartExit()
  local state = DormAIStateConfig.GetDormUnbindExitState().New(self, nil, self.__OnCurStateExit)
  self.state = state
  self.stateType = 0
  return state:StartState()
end

function DormCharacterAI:RandToRoomOnePoint()
  local state = DormAIStateConfig.GetDormIdleState().New(self, nil, self.__OnCurStateExit)
  self.state = state
  self.stateType = 0
  return state:StartRandToRoomOnePoint()
end

function DormCharacterAI:OnUpdate()
  if self.state ~= nil then
    self.state:OnUpdate()
  end
end

function DormCharacterAI:OnCurStateExit(state, enterNext)
  local stateType = self.stateType
  self.state = nil
  self.stateType = 0
  self:BroadcastForDormAI(DormEnum.CharacterAIEventId.ExitState, stateType)
  if self.__randNextOnExit and enterNext then
    self:RandNewAction()
  end
end

function DormCharacterAI:BroadcastForDormAI(eventId, ...)
  self.__dormAIMsg:Broadcast(eventId, ...)
end

function DormCharacterAI:AddListenerForDormAI(eventId, func)
  self.__dormAIMsg:AddListener(eventId, func)
end

function DormCharacterAI:RemoveListenerForDormAI(eventId, func)
  self.__dormAIMsg:RemoveListener(eventId, func)
end

return DormCharacterAI
