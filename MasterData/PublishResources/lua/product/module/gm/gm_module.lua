_class("GMProxyModule", GameModule)
GMProxyModule = GMProxyModule

function GMProxyModule:Constructor()
end

function GMProxyModule:Init()
end

function GMProxyModule:Connect(ip, port)
  self.caller:SetLinkConn(NetAddrInfo.New2(ip, port))
  self._serverIP = ip
end

function GMProxyModule:GetServerIP()
  return self._serverIP
end

function GMProxyModule:SendCmd(cmd)
  if string.find(cmd, "quick_play") then
    TaskManager:GetInstance():StartTask(self.QuickPlay, self, cmd)
  else
    TaskManager:GetInstance():StartTask(self.SendCmdTask, self, cmd)
  end
end

function GMProxyModule:SendCmdTask(TT, cmd)
  local res = AsyncRequestRes:New()
  res:SetSucc(false)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventMobileGM_SendCMD)
  request.gm_cmd = cmd
  local reply = self:Call(TT, request)
  if not reply:Succ() then
    Log.fatal("GMProxyModule:SendCmdTask send message failed")
    return res, reply
  end
  local replyEvent = CEventMobileGM_SendCMDResult(reply.msg)
  if replyEvent == nil then
    return res, reply
  end
  res:SetSucc(true)
  res:SetResult(replyEvent.ret)
  Log.debug("GM SendCmdResult: code=", replyEvent.err_code, "msg=", replyEvent.err_msg)
  return res, reply
end

function GMProxyModule:QuickPlay(TT, cmd)
  local s = string.split(cmd, " ")
  if s == nil or #s ~= 2 then
    return
  end
  local uid = s[2]
  local cmds = {
    "set_guide %s",
    "CompleteAllMission %s",
    "UnlockAllArch %s",
    "UnlockAllHomelandFunction %s",
    "add_asset %s 5012001 1",
    "CompleteOneQuest %s 11100001",
    "CompleteOneQuest %s 11100002",
    "CompleteOneQuest %s 11100003",
    "CompleteOneQuest %s 11100004",
    "CompleteOneQuest %s 11100005",
    "CompleteOneQuest %s 11100006",
    "CompleteOneQuest %s 11100007",
    "CompleteOneQuest %s 11100008",
    "CompleteOneQuest %s 11100009",
    "CompleteOneQuest %s 11100010",
    "CompleteOneQuest %s 11100011",
    "CompleteOneQuest %s 11100012",
    "CompleteOneQuest %s 11100013",
    "CompleteOneQuest %s 11100014",
    "CompleteOneQuest %s 11100015",
    "CompleteOneQuest %s 11100016",
    "CompleteOneQuest %s 11100017",
    "CompleteOneQuest %s 11100018",
    "CompleteOneQuest %s 11100019",
    "add_asset %s 5002101 10000",
    "add_asset %s 5002201 10000",
    "add_asset %s 3000001 900"
  }
  for _, c in ipairs(cmds) do
    local res = AsyncRequestRes:New()
    res:SetSucc(false)
    local request = NetMessageFactory:GetInstance():CreateMessage(CEventMobileGM_SendCMD)
    request.gm_cmd = string.format(c, uid)
    local reply = self:Call(TT, request)
    if not reply:Succ() then
      Log.fatal("GMProxyModule:SendCmdTask send message failed")
      return res, reply
    end
  end
  Log.info("快速开始执行成功")
end
