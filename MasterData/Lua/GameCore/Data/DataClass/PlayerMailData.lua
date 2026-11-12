local PlayerMailData = class("PlayerMailData")
local TimerManager = require("GameCore.Timer.TimerManager")

function PlayerMailData:Init()
  self.bisNew = false
  EventManager.Add(EventId.UpdateWorldClass, self, self.UpdateWorldClass)
  self._mapMail = {}
  self.bNeedUpdate = true
  self.funcCallBack = nil
  self.isOpen = false
  self.delayCallOpen = nil
  self.bInitRedDot = false
  self:StopDeadLineTimer()
end

function PlayerMailData:HandleDefaultMail(tab)
  local id = tab.Id
  local dMsg = ConfigTable.GetData("MailTemplate", tab.TemplateId)
  if dMsg ~= nil then
    if tab.Subject == nil or tab.Subject == "" then
      tab.Subject = dMsg.Subject
    end
    if tab.Desc == nil or tab.Desc == "" then
      tab.Desc = dMsg.Desc
    end
    if tab.Author == nil or tab.Author == "" then
      tab.Author = dMsg.Author
    end
    if (tab.Attachments == nil or #tab.Attachments == 0) and tab.Read then
      tab.Recv = true
    end
    tab.Icon = dMsg.Icon
    tab.LetterPaper = dMsg.LetterPaper
  end
  return tab
end

function PlayerMailData:CacheMailData(mapData)
  self.bNeedUpdate = false
  self.bisNew = false
  self._mapMail = {}
  if mapData == nil then
    self:RunCallBack()
    self:StopDeadLineTimer()
  else
    if mapData.List == nil then
      self:RunCallBack()
      self:StopDeadLineTimer()
      return
    end
    for _, mapMail in ipairs(mapData.List) do
      if mapMail.TemplateId == 0 then
        self._mapMail[mapMail.Id] = mapMail
      else
        local _data = self:HandleDefaultMail(mapMail)
        self._mapMail[mapMail.Id] = _data
      end
    end
    self:RunCallBack()
    self:StartDeadLineTimer()
  end
  if not self.bInitRedDot then
    self.bInitRedDot = true
  end
  self:UpdateMailUnReceiveRedDot()
end

function PlayerMailData:UpdateMailRed(isNew)
  self.bisNew = isNew
  if PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.Mail) then
    if isNew then
      RedDotManager.SetValid(RedDotDefine.Mail_UnRead, nil, true)
    end
    self.bisNew = false
  end
end

function PlayerMailData:UpdateWorldClass()
  if PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.Mail) then
    RedDotManager.SetValid(RedDotDefine.Mail_UnRead, nil, self.bisNew)
    self.bisNew = false
  end
end

function PlayerMailData:UpdateMailList(mapMsgData)
  self.bisNew = true
  self.bNeedUpdate = true
  if PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.Mail) and mapMsgData.New then
    RedDotManager.SetValid(RedDotDefine.Mail_New, nil, true)
  end
  EventManager.Hit("GetAllMailList")
end

function PlayerMailData:ReceiveMailItem(mapData)
  if type(mapData.Ids) == "table" then
    for i = 1, #mapData.Ids do
      if self._mapMail[mapData.Ids[i]] ~= nil then
        self._mapMail[mapData.Ids[i]].Read = true
        self._mapMail[mapData.Ids[i]].Recv = true
      end
    end
    UTILS.OpenReceiveByChangeInfo(mapData.Items, function()
      PlayerData.Base:TryOpenWorldClassUpgrade()
    end)
    local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapData.Items)
    HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
  end
  self:RunCallBack()
  self:UpdateMailUnReceiveRedDot()
end

function PlayerMailData:ReadMail(mapMsgData)
  if self._mapMail[mapMsgData.Value] ~= nil then
    self._mapMail[mapMsgData.Value].Read = true
    if self._mapMail[mapMsgData.Value].Attachments == nil or #self._mapMail[mapMsgData.Value].Attachments == 0 then
      self._mapMail[mapMsgData.Value].Recv = true
    end
  end
  self:RunCallBack()
end

function PlayerMailData:RemoveMail(mapData)
  if type(mapData.Ids) == "table" then
    for i = 1, #mapData.Ids do
      if self._mapMail[mapData.Ids[i]] ~= nil then
        self._mapMail[mapData.Ids[i]] = nil
      end
    end
  end
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self:RunCallBack()
  end
  
  cs_coroutine.start(wait)
end

function PlayerMailData:GetAgainAllMain()
  local function fCb()
    EventManager.Hit("OnEvent_RefrushMailGroup")
  end
  
  self.funcCallBack = fCb
  self:SengMsgMailList()
end

function PlayerMailData:SengMsgMailList(callback)
  HttpNetHandler.SendMsg(NetMsgId.Id.mail_list_req, {}, nil, callback)
end

function PlayerMailData:RefreshMailRedDot(mapMsgData)
  if PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.Mail) and mapMsgData.New then
    RedDotManager.SetValid(RedDotDefine.Mail_New, nil, true)
  end
end

function PlayerMailData:GetAllMail(func_callBack, isOpen)
  if func_callBack then
    self.funcCallBack = func_callBack
  end
  self.isOpen = isOpen
  if self.bNeedUpdate then
    self:SengMsgMailList()
  else
    self:RunCallBack()
  end
end

function PlayerMailData:RunCallBack()
  if self.funcCallBack then
    self.funcCallBack()
    self.funcCallBack = nil
  end
  if self.isOpen then
    local function func()
      EventManager.Hit(EventId.OpenPanel, PanelId.Mail)
    end
    
    EventManager.Hit(EventId.SetTransition, 5, func)
    self.isOpen = false
    local time = CS.ClientManager.Instance.serverTimeStamp
    local hour = tonumber(os.date("%H", time))
    local minute = tonumber(os.date("%M", time))
    local second = tonumber(os.date("%S", time))
    local delaySec = 100800 - hour * 3600 - minute * 60 - second
    self.delayCallOpen = TimerManager.Add(1, delaySec, self, self.DelayTimeCallMsg, true, true, false)
  end
end

function PlayerMailData:CheckMailDeadLine()
  local bNeedRefresh = false
  for id, v in pairs(self._mapMail) do
    if v.Deadline ~= 0 and not self.tbDeadLineCheckList[id] then
      local remainTime = v.Deadline - CS.ClientManager.Instance.serverTimeStamp
      if remainTime <= 0 then
        self.tbDeadLineCheckList[id] = true
        bNeedRefresh = true
        break
      end
    end
  end
  if bNeedRefresh then
    self:UpdateMailUnReceiveRedDot()
    EventManager.Hit("GetAllMailList")
  end
end

function PlayerMailData:StartDeadLineTimer()
  if nil == self.timerMailDeadLine then
    self.timerMailDeadLine = TimerManager.Add(0, 10, self, self.CheckMailDeadLine, true, true, false)
  end
end

function PlayerMailData:StopDeadLineTimer()
  if nil ~= self.timerMailDeadLine then
    TimerManager.Remove(self.timerMailDeadLine, false)
  end
  self.timerMailDeadLine = nil
  self.tbDeadLineCheckList = {}
end

function PlayerMailData:DelayTimeCallMsg()
  if self.bNeedUpdate then
    local function cb()
      EventManager.Hit(EventId.RefrushMailView)
    end
    
    self:GetAllMail(cb, false)
  end
  self:CancelTimeDelay()
  local time = CS.ClientManager.Instance.serverTimeStamp
  local hour = tonumber(os.date("%H", time))
  local minute = tonumber(os.date("%M", time))
  local second = tonumber(os.date("%S", time))
  local delaySec = 100800 - hour * 3600 - minute * 60 - second
  self.delayCallOpen = TimerManager.Add(1, delaySec, self, self.DelayTimeCallMsg, true, true, false)
end

function PlayerMailData:SendMailRecvReq(id, flag, callback)
  if callback then
    self.funcCallBack = callback
  end
  
  local function skinCachClearCb(_, mapMsgData)
    PlayerData.CharSkin:TryOpenSkinShowPanel(function()
      PlayerData.Mail:ReceiveMailItem(mapMsgData)
    end)
    if callback then
      callback()
    end
  end
  
  local sendMsgBody = {Id = id, Flag = flag}
  HttpNetHandler.SendMsg(NetMsgId.Id.mail_recv_req, sendMsgBody, nil, skinCachClearCb)
end

function PlayerMailData:SendMailGetSurveryMsg(id, callback)
  if callback then
    self.funcCallBack = callback
  end
  local sendMsgBody = {SurveyId = id}
  HttpNetHandler.SendMsg(NetMsgId.Id.player_survey_req, sendMsgBody, nil, callback)
end

function PlayerMailData:SendMailReadReq(id, flag, callback)
  local sendMsgBody = {Id = id, Flag = flag}
  HttpNetHandler.SendMsg(NetMsgId.Id.mail_read_req, sendMsgBody, nil, callback)
end

function PlayerMailData:SendMailRemoveReq(id, flag, callback)
  if callback then
    self.funcCallBack = callback
  end
  local sendMsgBody = {Id = id, Flag = flag}
  HttpNetHandler.SendMsg(NetMsgId.Id.mail_remove_req, sendMsgBody, nil, callback)
end

function PlayerMailData:SendMailPin(id, flag, isPin, callback)
  local sendMsgBody = {
    Id = id,
    Flag = flag,
    Pin = isPin
  }
  
  local function cb(_, mapMsgData)
    self._mapMail[mapMsgData.Id].Flag = mapMsgData.Flag
    self._mapMail[mapMsgData.Id].Pin = mapMsgData.Pin
    callback()
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.mail_pin_req, sendMsgBody, nil, cb)
end

function PlayerMailData:CancelTimeDelay()
  if self.delayCallOpen then
    self.delayCallOpen:Cancel(nil)
    self.delayCallOpen = nil
  end
end

function PlayerMailData:ClearFunCallBack()
  if self.funcCallBack then
    self.funcCallBack = nil
  end
end

function PlayerMailData:UpdateMailUnReadRedDot()
  local bUnRead = false
  for _, mail in pairs(self._mapMail) do
    if not mail.Read then
      bUnRead = true
      break
    end
  end
  RedDotManager.SetValid(RedDotDefine.Mail_UnRead, nil, bUnRead)
end

function PlayerMailData:UpdateMailUnReceiveRedDot()
  local nUnReceive = false
  for _, mail in pairs(self._mapMail) do
    if (mail.Deadline == 0 or CS.ClientManager.Instance.serverTimeStamp < mail.Deadline) and mail.Attachments and 0 < #mail.Attachments and not mail.Recv then
      nUnReceive = true
      break
    end
  end
  RedDotManager.SetValid(RedDotDefine.Mail_UnReceive, nil, nUnReceive)
end

return PlayerMailData
