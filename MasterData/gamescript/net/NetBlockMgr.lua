local NetBlockMgr = System.NewClass("NetBlockMgr")

function NetBlockMgr:ctor()
  self.ingoreBlockMsg = {}
  self.reqKeys = {}
  self.canelBlocked = false
  self.reqestingMsgKeys = {}
  self.protoCallbacks = {}
  self:_Init()
end

function NetBlockMgr:_Init()
  self:Ingore("Battle", "OnReceiveCommand")
  self:Ingore("BattleFlow", "OnReceiveCommand")
  self:Ingore("TrinketRequest", "OnShowTrinket")
  self:Ingore("GameRequest", "OnShowWeapon")
  self:Ingore("GameRequest", "OnReqAwakerList")
  self:Ingore("GameRequest", "OnOpenShop")
  self:Ingore("GameRequest", "CollecAvgTrigger")
  self:Ingore("GameRequest", "OnSetState")
  self:Ingore("GameRequest", "GetBoardAwakerLikeGained")
  self:Ingore("GameRequest", "OnChangeAssistAwaker")
  self:Ingore("GameRequest", "OnOpenSummon")
  self:Ingore("GameRequest", "OnSaveClientData")
  self:Ingore("GameRequest", "OnDelClientData")
  self:Ingore("GameRequest", "OnTalentList")
  self:Ingore("GameRequest", "OnSocialGood")
  self:Ingore("GameRequest", "OnCheckExpiryItem")
  self:Ingore("GameRequest", "SyncMonthCard")
  self:Ingore("GameRequest", "TutorialOnClickBoardGirl")
  self:Ingore("GameRequest", "OnOpenPvp")
  self:Ingore("GameRequest", "OnQueryRank")
  self:Ingore("GameRequest", "OnGetPvpCollection")
  self:Ingore("GameRequest", "SetEmoji")
  self:Ingore("GameRequest", "MarkPvpOpeningVoiceRead")
  self:Ingore("GameRequest", "OnReadStory")
  self:Ingore("GameRequest", "OnHearVoice")
  self:Ingore("WorldRequest", "OnMove")
  self:Ingore("WorldRequest", "OnTrigger")
  self:Ingore("WorldRequest", "OnTriggerEvent")
  self:Ingore("WorldRequest", "OnEventOptionHandle")
end

function NetBlockMgr:OnRequest(req, funName)
  local key = self:_Key(req, funName)
  if self.canelBlocked or self.ingoreBlockMsg[key] then
    return
  end
  print(">>>>>>>>>>>>>>>>>请求协议---转菊花---", req, funName)
  self.reqestingMsgKeys[key] = true
  WaitingView.Instance:Show(key, WaitingView.Flag_BlockMsg)
end

function NetBlockMgr:IsBlock(req, funName)
  local key = self:_Key(req, funName)
  return self.ingoreBlockMsg[key]
end

function NetBlockMgr:OnRespond(req, funName)
  local key = self:_Key(req, funName)
  if not self.reqestingMsgKeys[key] then
    return
  end
  if self.protoCallbacks[key] then
    local cb = self.protoCallbacks[key]
    self.protoCallbacks[key] = nil
    cb()
  end
  self.reqestingMsgKeys[key] = nil
  WaitingView.Instance:Hide(key, WaitingView.Flag_BlockMsg)
end

function NetBlockMgr:WaitForProto(req, funName, evaluation, cb)
  if not evaluation then
    return
  end
  local evaluated = evaluation()
  if evaluated then
    return
  end
  local key = self:_Key(req, funName)
  if cb then
    self.protoCallbacks[key] = cb
  end
  if self.reqestingMsgKeys[key] then
    return
  end
  self.reqestingMsgKeys[key] = true
  WaitingView.Instance:Show(key, WaitingView.Flag_BlockMsg)
end

function NetBlockMgr:CancelBlocked(canceled)
  self.canelBlocked = canceled
end

function NetBlockMgr:ClearBlockedMsgs()
  for key, v in pairs(self.reqestingMsgKeys) do
    if v then
      WaitingView.Instance:Hide(key, WaitingView.Flag_BlockMsg)
    end
  end
  table.clear(self.reqestingMsgKeys)
  table.clear(self.protoCallbacks)
end

function NetBlockMgr:Ingore(req, funName)
  local key = self:_Key(req, funName)
  self.ingoreBlockMsg[key] = true
end

function NetBlockMgr:_Key(req, funName)
  if self.reqKeys[req] and self.reqKeys[req][funName] then
    return self.reqKeys[req][funName]
  end
  self.reqKeys[req] = self.reqKeys[req] or {}
  self.reqKeys[req][funName] = req .. funName
  return self.reqKeys[req][funName]
end

NetBlockMgr.Instance = NetBlockMgr()
return NetBlockMgr
