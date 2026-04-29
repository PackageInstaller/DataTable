_class("IdipgameModule", GameModule)
IdipgameModule = IdipgameModule

function IdipgameModule:Constructor()
  self._banacc_end_time = 0
  self._banacc_cause = ""
  self._shutup_end_time = 0
  self._shutup_cause = ""
  self._nick_end_time = 0
  self._nick_cause = ""
  self._signs_end_time = 0
  self._signs_cause = ""
  self._teamdes_end_time = 0
  self._teamdes_cause = ""
  self._relogin = false
end

function IdipgameModule:Init()
  IdipgameModule.super.Init(self)
  self.caller:RegisterPushHandler(CEventNotifyIDIPBan, self.HandleMsg, self)
  self.caller:RegisterPushHandler(CEventNotifyIDIPRelogin, self.HandleReloginMsg, self)
  self.caller:RegisterPushHandler(CEventPushGuideChange, self.HandleGuide, self)
end

function IdipgameModule:Dispose()
  self.caller:UnRegisterPushHandler(CEventNotifyIDIPBan)
  self.caller:UnRegisterPushHandler(CEventNotifyIDIPRelogin)
  self.caller:UnRegisterPushHandler(CEventPushGuideChange)
  IdipgameModule.super.Dispose(self)
end

function IdipgameModule:Update()
end

function IdipgameModule:ClearData()
  self._banacc_end_time = 0
  self._banacc_cause = ""
  self._shutup_end_time = 0
  self._shutup_cause = ""
  self._nick_end_time = 0
  self._nick_cause = ""
  self._signs_end_time = 0
  self._signs_cause = ""
  self._teamdes_end_time = 0
  self._teamdes_cause = ""
  self._relogin = false
end

function IdipgameModule:ShutupHandle()
  self:CheckTime()
  if self._shutup_end_time > 0 then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.IdipBanDataEvent, IDIPBanType.IDIPBan_Shutup)
    return true
  end
  return false
end

function IdipgameModule:TextBanHandle(idipType)
  if idipType ~= IDIPBanType.IDIPBan_Nick and idipType ~= IDIPBanType.IDIPBan_Signs and idipType ~= IDIPBanType.IDIPBan_Teamdes then
    return false
  end
  local ct, desc = self:GetData(idipType)
  if ct <= 0 then
    return false
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.IdipBanDataEvent, idipType)
  return true
end

function IdipgameModule:GetServerTime()
  local time_mod = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local tmSecond, nMilliSecond = math.modf(time_mod:GetServerTime() / 1000)
  return tmSecond
end

function IdipgameModule:CheckTime()
  local ct = self:GetServerTime()
  
  local function cb(timeField, descField)
    if ct >= self["_" .. timeField] then
      self["_" .. timeField] = 0
      self["_" .. descField] = ""
    end
  end
  
  cb("banacc_end_time", "banacc_cause")
  cb("shutup_end_time", "shutup_cause")
  cb("nick_end_time", "nick_cause")
  cb("signs_end_time", "signs_cause")
  cb("teamdes_end_time", "teamdes_cause")
end

function IdipgameModule:GetData(idipType)
  self:CheckTime()
  if idipType == IDIPBanType.IDIPBan_Account then
    return self._banacc_end_time, self._banacc_cause
  elseif idipType == IDIPBanType.IDIPBan_Shutup then
    return self._shutup_end_time, self._shutup_cause
  elseif idipType == IDIPBanType.IDIPBan_Nick then
    return self._nick_end_time, self._nick_cause
  elseif idipType == IDIPBanType.IDIPBan_Signs then
    return self._signs_end_time, self._signs_cause
  else
    return self._teamdes_end_time, self._teamdes_cause
  end
  return 0
end

function IdipgameModule:IsRelogin()
  return self._relogin
end

function IdipgameModule:HandleMsg(msg)
  if msg == nil or msg.info == nil then
    return
  end
  self:SetMsgInfo(msg.info)
end

function IdipgameModule:HandleReloginMsg(msg)
  if msg == nil then
    return
  end
  self._relogin = true
  GameGlobal.EventDispatcher():Dispatch(GameEventType.IdipBanDataEvent, nil)
end

function IdipgameModule:HandleGuide(msg)
  if msg == nil or msg.values == nil then
    return
  end
  SetGuideServerClose(msg.values)
end

function IdipgameModule:ChangeData(msgData, timeField, descField)
  self["_" .. timeField] = msgData[timeField]
  self["_" .. descField] = msgData[descField]
end

function IdipgameModule:SetMsgInfo(info)
  self:ChangeData(info, "banacc_end_time", "banacc_cause")
  self:ChangeData(info, "shutup_end_time", "shutup_cause")
  self:ChangeData(info, "nick_end_time", "nick_cause")
  self:ChangeData(info, "signs_end_time", "signs_cause")
  self:ChangeData(info, "teamdes_end_time", "teamdes_cause")
  if self._banacc_end_time > 0 then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.IdipBanDataEvent, IDIPBanType.IDIPBan_Account)
  end
end
