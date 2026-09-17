local this = {}

function this:req_actDoCmd(act_id, act_cmd, callback)
  local data = {act_id = act_id, act_cmd = act_cmd}
  L_Net:sendMessage(MsgGenCode.CSProtoActDoCmd, data, function(rspData, errorCode)
    local actRsp = rspData.act_1
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      if not table.isEmpty(actRsp) then
        self:rsp_syncSignInInfo(actRsp)
      end
      if callback then
        callback()
      end
    end
  end)
end

function this:req_getActDetail(act_id, callback)
  local data = {act_id = act_id}
  L_Net:sendMessage(MsgGenCode.CSProtoActGetDetail, data, function(rspData, errorCode)
    local actRsp = rspData.act_1
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      if not table.isEmpty(actRsp) then
        self:rsp_syncActivityInfo(actRsp)
      end
      if callback then
        callback()
      end
    end
  end)
end

function this:rsp_syncActivityInfo(data)
  if data == nil then
    return
  end
  if data.cur_month ~= nil then
    self:rsp_syncSignInInfo(data)
  else
    for i, v in pairs(data) do
      local entity = self:getGameActItem(v.id, true)
    end
    self:call(self.event.refreshGameAct)
  end
end

function this:rsp_syncAllActivityInfo(data)
  if table.isEmpty(data) or table.isEmpty(data.act_ids) then
    return
  end
  local gameActTpl = L_GameTpl:getGameActTpl()
  for i, v in pairs(data.act_ids) do
    local tpl = gameActTpl:getTplById(v)
    local type = gameActTpl:getType(tpl)
    if type == 99 then
      self:rsp_syncSignInInfo(data.act1, v)
    else
      local entity = self:getGameActItem(v, true)
    end
  end
  self:call(self.event.refreshGameAct)
end

function this:rsp_syncSignInInfo(data, id)
  if data == nil then
    return
  end
  local entity = self:getGameActItem(id, true)
  self.data.signInDay = data.index
  self.data.signInStatus = data.status
  self.data.signInMonth = data.cur_month
  if self.data.signInStatus == self.rewardStatus.alreadyGot then
    self:setDayChangedFlag(false)
  elseif self.data.signInStatus == self.rewardStatus.canGet then
    self:setDayChangedFlag(true)
  end
  self:call(self.event.refreshSignInInfo)
end

return this
