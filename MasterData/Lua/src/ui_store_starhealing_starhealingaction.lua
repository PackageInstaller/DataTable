local this = {}

function this:rsp_starHealingChargeSync(data, errorCode)
  if errorCode == L_Const.errorCode.ErrCodeSucc then
    self:setOldChargeValue(self.data.charge.cur_value)
    if data.cur_hp then
      self.data.charge.cur_hp = data.cur_hp
    end
    if data.up_count then
      self.data.charge.up_count = data.up_count
    end
    if data.lastdaytime then
      self.data.charge.lastdaytime = data.lastdaytime
    end
    if data.reduce_time then
      self.data.charge.reduce_time = data.reduce_time
    end
    if data.ban_time then
      self.data.charge.ban_time = data.ban_time
    end
    if data.add_hp then
      self.data.charge.add_hp = data.add_hp
    end
    if data.cur_value then
      self.data.charge.cur_value = data.cur_value
    end
    self:call(self.event.starHealingChargeRefresh, self.data.oldValue < self.data.charge.cur_value)
  end
end

function this:rsp_starHealingChargeHpSync(data, errorCode)
  local heroId = data.hero_id
  self:call(self.event.playStarHealingEffect, heroId)
  if errorCode == L_Const.errorCode.ErrCodeSucc then
  end
end

function this:req_CSProtoWorldMapActiveBehavior(callback)
  local data = {
    type = L_Const.PlayerActiveBehavior.PAB_NEAR_TRANS_POINT
  }
  L_Net:sendMessage(MsgGenCode.CSProtoWorldMapActiveBehavior, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc and callback then
      callback()
    end
  end)
end

return this
