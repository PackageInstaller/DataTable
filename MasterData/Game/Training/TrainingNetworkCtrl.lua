local TrainingNetworkCtrl = class("TrainingNetworkCtrl", NetworkCtrlBase)
local SlotData = require("Game.Training.Data.TrainingSlotData")
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function TrainingNetworkCtrl:ctor()
  self.redDotTrainingGlobalExpRatio = ConfigData.game_config.redDotTrainingGlobalExpRatio
end

function TrainingNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_TRAINING_Detail, self, proto_csmsg.SC_TRAINING_Detail, self.__OnRecvTrainingDetail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_TRAINING_SlotHero, self, proto_csmsg.SC_TRAINING_SlotHero, self.__OnRecvSlotHero)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_TRAINING_Settle, self, proto_csmsg.SC_TRAINING_Settle, self.__OnRecvTrainingSettle)
end

function TrainingNetworkCtrl:__UpdateSlotData(data)
  local index = data.idx
  local slotData = PlayerDataCenter.trainingSlotDatas[index]
  if slotData ~= nil then
    slotData:UpdateTrainingData(data)
  else
    error("Training slot index is null, index = " .. tostring(index))
  end
end

function TrainingNetworkCtrl:SendTrainingDetail()
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_TRAINING_Detail, proto_csmsg.CS_TRAINING_Detail, table.emptytable)
  cs_WaitNetworkResponse:StartOrAddWait(proto_csmsg_MSG_ID.MSG_CS_TRAINING_Detail, proto_csmsg_MSG_ID.MSG_SC_TRAINING_Detail)
end

function TrainingNetworkCtrl:__OnRecvTrainingDetail(msg)
  for k, v in pairs(msg.detail.data) do
    self:__UpdateSlotData(v)
  end
  self:InitRedDotTraining()
end

function TrainingNetworkCtrl:SendSlotHero(heroId, slotIndex, effectType)
  local tabMsg = {
    heroId = heroId,
    slotIdx = slotIndex,
    effType = effectType
  }
  self.__slotIndex = slotIndex
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_TRAINING_SlotHero, proto_csmsg.CS_TRAINING_SlotHero, tabMsg)
end

function TrainingNetworkCtrl:__OnRecvSlotHero(msg)
  if msg.ret == proto_csmsg_ErrorCode.None then
    for k, v in pairs(msg.detail.data) do
      self:__UpdateSlotData(v)
    end
    local window = UIManager:GetWindow(UIWindowTypeID.Training)
    if window ~= nil then
      window:UpdateTrainingUI()
      window:OnSlotHeroComplete(self.__slotIndex)
    end
    self.__slotIndex = nil
    self:UpdateRedDotEmptySlot()
  else
    local err = "TrainingNetworkCtrl:__OnRecvSlotHero error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
  end
end

function TrainingNetworkCtrl:SendTrainingSettle(slotIndex)
  local tabMsg = {slotIdx = slotIndex}
  self.__slotIndex = slotIndex
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_TRAINING_Settle, proto_csmsg.CS_TRAINING_Settle, tabMsg)
end

function TrainingNetworkCtrl:__OnRecvTrainingSettle(msg)
  if msg.ret == proto_csmsg_ErrorCode.None then
    for k, v in pairs(msg.detail.data) do
      self:__UpdateSlotData(v)
    end
    PlayerDataCenter.trainingSlotDatas[self.__slotIndex]:Empty()
    local window = UIManager:GetWindow(UIWindowTypeID.Training)
    if window ~= nil then
      window:UpdateTrainingUI()
      window:OnSlotSettleComplete(self.__slotIndex)
    end
    self.__slotIndex = nil
    self:UpdateRedDotEmptySlot()
    self:UpdateRedDotCompleteSlot()
  else
    local err = "TrainingNetworkCtrl:__OnRecvTrainingSettle error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
  end
end

function TrainingNetworkCtrl:InitRedDotTraining()
  local globalExp = PlayerDataCenter:GetItemCount(ConfigData.game_config.globalExpItemId)
  local globalExpCeiling = PlayerDataCenter.playerBonus:GetGlobalExpCeiling()
  local globalExpOk = self.redDotTrainingGlobalExpRatio < globalExp / globalExpCeiling
  local emptySlotCount = 0
  local trainingCompleteCount = 0
  for k, v in ipairs(PlayerDataCenter.trainingSlotDatas) do
    local unlock = v:CheckUnlock()
    if unlock and v.heroId == nil and globalExpOk then
      emptySlotCount = emptySlotCount + 1
    elseif unlock and v.heroId ~= nil then
      local duration, remainSecond, progress = v:UpdateProgress(PlayerDataCenter.timestamp)
      if 1 <= progress then
        trainingCompleteCount = trainingCompleteCount + 1
      end
    end
  end
  local emptySlotNode = RedDotController:AddRedDotNodeWithPath(RedDotDynPath.EmptyTrainingSlotPath, RedDotStaticTypeId.Main, RedDotStaticTypeId.MainSide, RedDotStaticTypeId.Training, RedDotStaticTypeId.EmptyTrainingSlot)
  emptySlotNode:SetRedDotCount(emptySlotCount)
  local completeNode = RedDotController:AddRedDotNodeWithPath(RedDotDynPath.TrainingCompletePath, RedDotStaticTypeId.Main, RedDotStaticTypeId.MainSide, RedDotStaticTypeId.Training, RedDotStaticTypeId.TrainingComplete)
  completeNode:SetRedDotCount(trainingCompleteCount)
  self:StartTrainingRedDotTimer()
end

function TrainingNetworkCtrl:UpdateRedDotEmptySlot()
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.MainSide, RedDotStaticTypeId.Training, RedDotStaticTypeId.EmptyTrainingSlot)
  if not ok then
    return
  end
  local globalExp = PlayerDataCenter:GetItemCount(ConfigData.game_config.globalExpItemId)
  local globalExpCeiling = PlayerDataCenter.playerBonus:GetGlobalExpCeiling()
  local globalExpOk = self.redDotTrainingGlobalExpRatio < globalExp / globalExpCeiling
  local emptySlotCount = 0
  for k, v in ipairs(PlayerDataCenter.trainingSlotDatas) do
    local unlock = v:CheckUnlock()
    if unlock and v.heroId == nil and globalExpOk then
      emptySlotCount = emptySlotCount + 1
    end
  end
  node:SetRedDotCount(emptySlotCount)
end

function TrainingNetworkCtrl:UpdateRedDotCompleteSlot()
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.MainSide, RedDotStaticTypeId.Training, RedDotStaticTypeId.TrainingComplete)
  if not ok then
    return
  end
  local trainingCompleteCount = 0
  for k, v in ipairs(PlayerDataCenter.trainingSlotDatas) do
    local unlock = v:CheckUnlock()
    if unlock and v.heroId ~= nil then
      local duration, remainSecond, progress = v:UpdateProgress(PlayerDataCenter.timestamp)
      if 1 <= progress then
        trainingCompleteCount = trainingCompleteCount + 1
      end
    end
  end
  node:SetRedDotCount(trainingCompleteCount)
end

function TrainingNetworkCtrl:StartTrainingRedDotTimer()
  self.redDotTimerId = TimerManager:StartTimer(60, BindCallback(self, self.UpdateRedDotCompleteSlot), nil, false, false, true)
end

function TrainingNetworkCtrl:StopTrainingRedDotTimer()
  TimerManager:StopTimer(self.redDotTimerId)
end

function TrainingNetworkCtrl:Reset()
  PlayerDataCenter.trainingSlotDatas = {}
  self:StopTrainingRedDotTimer()
end

return TrainingNetworkCtrl
