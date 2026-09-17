local this = {}

function this:req_CSProtoFishRead(fishId, callback)
  local data = {u32 = fishId}
  L_Net:sendMessage(MsgGenCode.CSProtoFishRead, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc and callback then
      callback()
    end
  end)
end

function this:req_CSProtoFishSetRod(param, callback)
  local data = {
    bait_id = param.baitId or 0,
    rod_id = param.rodId or 0
  }
  L_Net:sendMessage(MsgGenCode.CSProtoFishSetRod, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      self.data.rodId = param.rodId or self.data.rodId
      self.data.baitId = param.baitId or self.data.baitId
      self:call(self.event.refreshFishingGear)
      if callback then
        callback()
      end
    end
  end)
end

function this:req_CSProtoFishFinish(success, callback)
  local data = {success = success}
  L_Net:sendMessage(MsgGenCode.CSProtoFishFinish, data, function(rspData, errorCode)
    self:resetFishFinish()
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      table.merge(self.data.fishFinish, rspData)
    end
    if callback then
      callback(errorCode)
    end
  end)
end

function this:req_CSProtoFishStart(pointId, callback)
  local data = {u32 = pointId}
  L_Net:sendMessage(MsgGenCode.CSProtoFishStart, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc and callback then
      callback(rspData.u32)
    end
  end)
end

function this:rsp_syncFishExternalData(data)
  local handBooks = data.handbooks
  if not table.isEmpty(handBooks) then
    for i, v in pairs(handBooks) do
      self:syncFishHandBook(v)
    end
  end
  if data.cur_rod then
    self.data.rodId = data.cur_rod
  end
  if data.cur_bait then
    self.data.baitId = data.cur_bait
  end
  local event_handbooks = data.event_handbooks
  if not table.isEmpty(event_handbooks) then
    for i, v in pairs(event_handbooks) do
      self:syncFishEventHandBook(v)
    end
  end
end

function this:syncFishHandBook(data)
  local entity = self:getFishHandbook(data.item_id, true)
  table.merge(entity, data)
end

function this:syncFishEventHandBook(data)
  local entity = self:getFishEventHandbook(data.event_id, true)
  table.merge(entity, data)
end

function this:rsp_syncFishPointList(data)
  local ponds = data.ponds
  if not table.isEmpty(ponds) then
    for i, v in pairs(ponds) do
      self:syncFishPoint(v)
    end
  end
  self:call(self.event.refreshFishPoint)
end

function this:syncFishPoint(data)
  local entity = self:getFishPoint(data.pond_id, true)
  table.merge(entity, data)
end

return this
