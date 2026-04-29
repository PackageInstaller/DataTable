_class("BulletinModule", GameModule)
BulletinModule = BulletinModule

function BulletinModule:Constructor()
  self.token = nil
  self.current_server = nil
  self.server_list = nil
  self.current_gateway = nil
end

function BulletinModule:Init()
end

function BulletinModule:GetServerInfo(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(false)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestGetServerInfo)
  Log.warn("BulletinModule:GetServerInfo request created", request)
  local reply = self:Call(TT, request)
  if not reply:Succ() then
    Log.fatal("BulletinModule:GetServerInfo send message failed")
    return res
  end
  local replyEvent = CEventReplyGetServerInfo(reply.msg)
  if replyEvent == nil then
    return res
  end
  res:SetSucc(true)
  res:SetResult(replyEvent.ret)
  self.server_list = replyEvent.server_list
  return res
end

function BulletinModule:GetDefaultServerInfo(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(false)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestGetDefaultServerInfo)
  request.login_info = GameGlobal.GameLogic().msdkAuthorityInfo
  local reply = self:Call(TT, request)
  if not reply:Succ() then
    Log.error("[login] BulletinModule: Call CEventRequestGetDefaultServerInfo error reply:Succ()")
    return res
  end
  local replyEvent = CEventReplyGetDefaultServerInfo(reply.msg)
  if replyEvent == nil then
    Log.error("[login] BulletinModule: CEventReplyGetDefaultServerInfo replyEvent == nil")
    return res
  end
  res:SetSucc(true)
  res:SetResult(replyEvent.ret)
  self.current_server = replyEvent.default_server
  self.current_gateway = replyEvent.default_gateway
  self.token = NetToken.NewBySerial(replyEvent.token.type, replyEvent.token.serial, replyEvent.token.token_id)
  if APPVERNETSTAT then
    self.caller:UpdateNetworkCfgInfo(replyEvent.net_cfg_info)
  end
  Log.info("[login] BulletinModule:GetDefaultServerInfo result ", replyEvent.ret)
  return res
end

function BulletinModule:GetLoginInfo(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(false)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestGetLoginInfo)
  local reply = self:Call(TT, request)
  if not reply:Succ() then
    return res
  end
  local replyEvent = CEventReplyGetLoginInfo(reply.msg)
  if replyEvent == nil then
    return res
  end
  res:SetSucc(true)
  res:SetResult(replyEvent.ret)
  self.token = NetToken.NewBySerial(replyEvent.token.type, replyEvent.token.serial, replyEvent.token.token_id)
  return res
end

function BulletinModule:QuickGetServerInfo(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(false)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestQuickGetServerInfo)
  request.login_info = GameGlobal.GameLogic().msdkAuthorityInfo
  local reply = self:Call(TT, request)
  if not reply:Succ() then
    Log.fatal("BulletinModule:QuickGetServerInfo send message failed")
    return res
  end
  local replyEvent = CEventReplyQuickGetServerInfo(reply.msg)
  if replyEvent == nil then
    return res
  end
  res:SetSucc(true)
  res:SetResult(replyEvent.ret)
  self.token = NetToken.NewBySerial(replyEvent.token.type, replyEvent.token.serial, replyEvent.token.token_id)
  self.server_list = replyEvent.server_list
  self.current_server = replyEvent.default_server
  self.current_gateway = replyEvent.default_gateway
  return res
end

function BulletinModule:QuickGetDefaultServerInfo(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(false)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestQuickGetDefaultServerInfo)
  request.login_info = GameGlobal.GameLogic().msdkAuthorityInfo
  local reply = self:Call(TT, request)
  if not reply:Succ() then
    Log.fatal("BulletinModule:QuickGetDefaultServerInfo send message failed")
    return res
  end
  local replyEvent = CEventReplyQuickGetDefaultServerInfo(reply.msg)
  if replyEvent == nil then
    return res
  end
  res:SetSucc(true)
  res:SetResult(replyEvent.ret)
  self.token = NetToken.NewBySerial(replyEvent.token.type, replyEvent.token.serial, replyEvent.token.token_id)
  self.current_server = replyEvent.default_server
  self.current_gateway = replyEvent.default_gateway
  return res
end

function BulletinModule:RequestTempMailMaintain(TT, mailAddr)
  local res = AsyncRequestRes:New()
  res:SetSucc(false)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestMailMaintainInfo)
  request.mail = mailAddr
  local reply = self:Call(TT, request)
  if not reply:Succ() then
    Log.fatal("BulletinModule:RequestTempMailMaintain send message failed")
    return res, nil
  end
  local replyEvent = CEventReplyMailMaintainInfo(reply.msg)
  if replyEvent == nil then
    return res, nil
  end
  res:SetSucc(true)
  return res, replyEvent
end
