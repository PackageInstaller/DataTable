_class("MailModule", GameModule)
MailModule = MailModule

function MailModule:Constructor()
  self.m_mail_map = {}
  self.m_collect_mail_map = {}
  self.m_expired_mail = {}
  self.have_new_mail = false
  self.m_collect_mail_map = {}
end

function MailModule:Init()
  self.caller:RegisterPushHandler(CEventMobileNotifyNewMail, self.HandleNotifyNewMail, self)
  self.caller:RegisterPushHandler(CEventMobileNotifyExpiredMail, self.HandleNotifyExpiredMail, self)
end

function MailModule:_DeleteOneMail(mail_id)
  local delete_index
  for i, v in ipairs(self.m_mail_map) do
    if v.mail_id == mail_id then
      delete_index = i
      break
    end
  end
  if delete_index ~= nil then
    table.remove(self.m_mail_map, delete_index)
  end
  delete_index = nil
  for i, v in ipairs(self.m_collect_mail_map) do
    if v.mail_id == mail_id then
      delete_index = i
      break
    end
  end
  if delete_index ~= nil then
    table.remove(self.m_collect_mail_map, delete_index)
  end
end

function MailModule:_SetMailInfoByMailId(mail_id, dataName, value)
  if mail_id == nil or dataName == nil or value == nil then
    return nil
  end
  for i, v in ipairs(self.m_mail_map) do
    if v.mail_id == mail_id then
      v[dataName] = value
      return v
    end
  end
  for i, v in ipairs(self.m_collect_mail_map) do
    if v.mail_id == mail_id then
      v[dataName] = value
      return v
    end
  end
  return nil
end

function MailModule:GetAllMailData()
  return self.m_mail_map, self.m_collect_mail_map
end

function MailModule:HaveNewMail()
  local isNewMail = false
  for i, v in ipairs(self.m_mail_map) do
    if (v.appendix == nil or table.count(v.appendix) <= 0) and v.is_read == false then
      isNewMail = true
    elseif table.count(v.appendix) > 0 and v.is_gain == false then
      isNewMail = true
    end
  end
  for i, v in ipairs(self.m_collect_mail_map) do
    if (v.appendix == nil or table.count(v.appendix) <= 0) and v.is_read == false then
      isNewMail = true
    elseif table.count(v.appendix) > 0 and v.is_gain == false then
      isNewMail = true
    end
  end
  if isNewMail == false then
    isNewMail = self.have_new_mail
  end
  return isNewMail
end

function MailModule:CheckHaveNewMail(bHaveNewMail)
  if bHaveNewMail == true then
    self:HandleNotifyNewMail()
  end
end

function MailModule:HandleNotifyNewMail()
  self.have_new_mail = true
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ModuleMailNotifyNewMail)
end

function MailModule:HandleNotifyExpiredMail(msg)
  if msg.expired_mail_vec == nil then
    return
  end
  self.m_expired_mail = msg.expired_mail_vec
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ModuleMailNotifyExpiredMail)
end

function MailModule:ParseAppendix(appendixconfig)
  if appendixconfig == nil then
    return
  end
  local appendixlist = {}
  for num, asset in pairs(appendixconfig) do
    if #asset < 2 then
      Log.error("MailModule:ParseAppendix error config")
    end
    local ra = RoleAsset:New()
    ra.assetID = asset[1]
    ra.count = asset[2]
    appendixlist[#appendixlist + 1] = ra
  end
  return appendixlist
end

function MailModule:LoadAllMails(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventMobileReqMail)
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  if replyEvent.ret == MailErrorCode.MAIL_SUCC and replyEvent.mail_vec then
    self.m_mail_map = replyEvent.mail_vec
    self.m_collect_mail_map = replyEvent.collect_mail_vec
    self.have_new_mail = false
  end
  return res, self.m_mail_map, self.m_collect_mail_map
end

function MailModule:RequestSendMailByModule(TT, receiver_id, module_id)
  return nil
end

function MailModule:RequestReadMail(TT, mail_id)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventMobileReadMail)
  request.mail_id = mail_id
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  if replyEvent.ret == MailErrorCode.MAIL_SUCC then
    local mail_info = self:_SetMailInfoByMailId(replyEvent.mail_id, "is_read", true)
  elseif replyEvent.ret == MailErrorCode.MAIL_ERR_MAIL_EXPIRED then
    self:_DeleteOneMail(replyEvent.mail_id)
  end
  res:SetResult(replyEvent.ret)
  return res
end

function MailModule:RequestDeleteMail(TT, mail_id)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventMobileDeleteMail)
  request.mail_id = mail_id
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  if replyEvent.ret == MailErrorCode.MAIL_SUCC then
    self:_DeleteOneMail(replyEvent.mail_id)
  elseif replyEvent.ret == MailErrorCode.MAIL_ERR_MAIL_EXPIRED then
    self:_DeleteOneMail(replyEvent.mail_id)
  end
  return res
end

function MailModule:RequestBatchDeleteMail(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventMobileDeleteAllMail)
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  if replyEvent.ret == MailErrorCode.MAIL_SUCC and replyEvent.mail_vec then
    self.m_mail_map = replyEvent.mail_vec
    self.have_new_mail = false
  end
  return res
end

function MailModule:RequestReceiveAppendix(TT, mail_id)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventMobileGetOneMail)
  request.mail_id = mail_id
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  if replyEvent.ret == MailErrorCode.MAIL_SUCC then
    self:_SetMailInfoByMailId(replyEvent.mail_id, "is_gain", true)
    self:_SetMailInfoByMailId(replyEvent.mail_id, "is_read", true)
    if replyEvent.reward_vec then
      for i = 1, #replyEvent.reward_vec do
        self:PrintAppendix(replyEvent.reward_vec[i])
      end
    end
  elseif replyEvent.ret == MailErrorCode.MAIL_ERR_MAIL_EXPIRED then
    self:_DeleteOneMail(replyEvent.mail_id)
  end
  Log.debug("_____________________replyEvent.ret:", replyEvent.ret)
  Log.debug("_____________________replyEvent.reward_vec.size:", table.count(replyEvent.reward_vec))
  return res, replyEvent.reward_vec
end

function MailModule:RequestBatchReceiveAppendix(TT, get_collect)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventMobileGetAllMail)
  request.get_collect = get_collect
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  if replyEvent.ret == MailErrorCode.MAIL_SUCC and replyEvent.reward_vec then
    for i = 1, #replyEvent.reward_vec do
      self:PrintAppendix(replyEvent.reward_vec[i])
    end
  end
  if not get_collect then
    if replyEvent.mail_vec then
      self.m_mail_map = replyEvent.mail_vec
    else
      self.m_mail_map = {}
    end
  elseif replyEvent.mail_vec then
    self.m_collect_mail_map = replyEvent.mail_vec
  else
    self.m_collect_mail_map = {}
  end
  self.have_new_mail = false
  Log.debug("_____________________________________ret: ", replyEvent.ret)
  Log.debug("_____________________________________m_mail_map: ", table.count(self.m_mail_map))
  Log.debug("_____________________________________mail_vec: ", table.count(replyEvent.mail_vec))
  return res, replyEvent.reward_vec
end

function MailModule:RequestLoadMail()
  return nil
end

function MailModule:PrintAppendix(asset)
  if not asset then
    Log.fatal("not asset")
    return
  end
  Log.debug("id: ", asset.assetID, " count: ", asset.count)
end

function MailModule:PrintMail(mail)
  if not mail then
    Log.fatal("not asset")
    return
  end
  Log.warn("mail_id ", mail.mail_id, " sender_id ", mail.sender_id, " receiver_id ", mail.receiver_id, " remain_time ", mail.remain_time)
end
