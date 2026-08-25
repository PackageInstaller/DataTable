local tableInsert = table.insert
local tableSort = table.sort
local tableRemove = table.remove
local MailModel = NewClass("MailModel", BaseModel)

function MailModel:OnInit()
  self:OnReset()
  EventMgr.Instance.OnMailSyncEvent:RegisterEvent(System.fn(self, self._OnSyncMails))
end

function MailModel:OnReset()
  self.mails = {}
  self.mailList = {}
  self.treasureMails = {}
  self.treasureMailList = {}
  self.notReadMails = {}
  self.needSort = false
  self.treasureNeedSort = false
  self.selectMailUid = nil
  self.selectMailIndex = nil
  self.selectTreasureMailUid = nil
  self.selectTreasureMailIndex = nil
  self.treasureRedState = MailDataUtils.TreasureRedState.NotRed
  self.maxNum = 100
  self.showGetCollectMailAnim = false
end

function MailModel:CheckChosenEmpty()
  return self.selectMailUid ~= nil
end

function MailModel:CheckTreasureChosenEmpty()
  return self.selectTreasureMailUid ~= nil
end

function MailModel:GetMailConfig(tid)
  if not tid then
    return
  end
  return DT.Mail[tid]
end

function MailModel:HasMailNotRead()
  return table.next(self.notReadMails) ~= nil
end

function MailModel:HasReadMailNum()
  local num = 0
  for _, mail in ipairs(self.mailList) do
    if mail and mail:IsRead() then
      num = num + 1
    end
  end
  return num
end

function MailModel:GetMail(uid)
  if not uid then
    return
  end
  local mail = self.mails[uid]
  mail = mail or self.treasureMails[uid]
  return mail
end

function MailModel:GetMailTitle(uid)
  local mail = self:GetMail(uid)
  if not mail then
    return
  end
  local config = self:GetMailConfig(mail:GetCfgTid())
  if not config then
    do return StrUtils.ReplacePlayerNamePlaceholder, LT.Text(mail:GetTitle() or "") end
    return StrUtils.ReplacePlayerNamePlaceholder, LT.Text(mail:GetTitle() or "")
  end
  local params = mail:GetCfgParam()
  local title
  if params and #params > 0 then
    title = LT.Textf(config.Name, table.unpack(self:ParseMailCfgParam(params)))
  else
    title = LT.Text(config.Name)
  end
  do return StrUtils.ReplacePlayerNamePlaceholder end
  return StrUtils.ReplacePlayerNamePlaceholder, title, table.unpack(self:ParseMailCfgParam(params))
end

function MailModel:GetTimeFormat(time)
  do return TimeUtils.TimestampToString, time end
  return TimeUtils.TimestampToString, time, TimeUtils.TimeExactType.Minute
end

function MailModel:GetLeftTime(uid)
  local mail = self:GetMail(uid)
  if not mail then
    return ""
  end
  local validTime = mail:GetValidTime()
  if not validTime then
    return ""
  end
  if type(validTime) ~= "number" then
    Logger.ReportApusErrorS("【Mail】 Error mail valid time!", "uid:" .. tostring(uid) .. ", validTime type:" .. type(validTime), TimeUtils.GetServerTime())
    return ""
  end
  local leftTime = validTime
  local d, h = TimeUtils.ConvertTime(leftTime)
  if d > 0 then
    do return LT.Textf, "Mail_CountDown_Day" end
    return LT.Textf, "Mail_CountDown_Day", d, TimeUtils.GetServerTime()
  elseif h >= 1 and h < 24 then
    do return LT.Textf, "Mail_CountDown_Hour" end
    return LT.Textf, "Mail_CountDown_Hour", h, TimeUtils.GetServerTime()
  else
    do return LT.Text end
    return LT.Text, "Mail_CountDown_Soon", h, TimeUtils.GetServerTime()
  end
end

function MailModel:GetMailInfoDesc(uid)
  local mail = self:GetMail(uid)
  if not mail then
    return
  end
  local publisher = self:GetPublisher(uid) or ""
  local time = self:GetTimeFormat(mail:GetTimeStamp())
  local timeText = LT.Textf("Mail_SendTime", time)
  local infoDesc = publisher .. "\n" .. timeText
  return infoDesc
end

function MailModel:GetTimeInfoText(uid)
  local mail = self:GetMail(uid)
  if not mail then
    return
  end
  local time = self:GetTimeFormat(mail:GetTimeStamp())
  return time
end

function MailModel:GetPublisher(uid, withPrefix)
  local mail = self:GetMail(uid)
  if not mail then
    return
  end
  local publisher
  local config = self:GetMailConfig(mail:GetCfgTid())
  if not config then
    if not mail:GetSender() then
      return
    end
    publisher = mail:GetSender() or ""
  else
    publisher = LT.Text(config.Sender)
  end
  publisher = StrUtils.ReplacePlayerNamePlaceholder(LT.Text(publisher))
  if withPrefix then
    publisher = LT.Textf("Mail_Sender", publisher)
  end
  return publisher
end

function MailModel:GetMailDesc(uid)
  local mail = self:GetMail(uid)
  if not mail then
    return
  end
  local params = mail:GetCfgParam()
  local config = self:GetMailConfig(mail:GetCfgTid())
  local desc
  if config then
    if params and #params > 0 then
      desc = LT.Textf(config.Desc, table.unpack(self:ParseMailCfgParam(params)))
    else
      desc = LT.Text(config.Desc)
    end
  else
    desc = LT.Text(mail:GetContent() or "")
  end
  do return StrUtils.ReplacePlayerNamePlaceholder end
  return StrUtils.ReplacePlayerNamePlaceholder, desc, mail, table.unpack(self:ParseMailCfgParam(params))
end

function MailModel:ParseMailCfgParam(cfgParam)
  local rst = {}
  for _, param in ipairs(cfgParam) do
    table.insert(rst, LT.Text(param))
  end
  return rst
end

function MailModel:GetQuantityShow(list, textKey)
  local listNum = list and #list or 0
  do return LT.Textf, textKey, listNum end
  return LT.Textf, textKey, listNum, self.maxNum
end

function MailModel:IsEmpyMailBox(list)
  return not list or table.next(list) == nil
end

function MailModel:IsMailRead(uid)
  local mail = self:GetMail(uid)
  if not mail then
    return true
  end
  do return mail.IsRead end
  return mail.IsRead, mail
end

function MailModel:HasAttachment(uid)
  local mail = self:GetMail(uid)
  if not mail then
    return false
  end
  do return mail.HasAttachment end
  return mail.HasAttachment, mail
end

function MailModel:IsClientSurveyMail(uid)
  local mail = self:GetMail(uid)
  if not mail then
    return false
  end
  do return mail.IsClientSurvey end
  return mail.IsClientSurvey, mail
end

function MailModel:CanReceiveAttachment(uid)
  local mail = self:GetMail(uid)
  if not mail then
    return false
  end
  do return mail.CanReceiveAttachment end
  return mail.CanReceiveAttachment, mail
end

function MailModel:GetAttachments(uid)
  local mail = self:GetMail(uid)
  if not mail then
    return {}
  end
  do return mail.GetItemList end
  return mail.GetItemList, mail
end

function MailModel:GetMailList()
  return self.mailList
end

function MailModel:GetTreasureMailList()
  return self.treasureMailList
end

function MailModel:GetSelectedMail()
  do return self.GetMail, self end
  return self.GetMail, self, self.selectMailUid
end

function MailModel:GetSelectedTreasureMail()
  do return self.GetMail, self end
  return self.GetMail, self, self.selectTreasureMailUid
end

function MailModel:GetSelectMailIndex()
  return self.selectMailIndex
end

function MailModel:GetSelectTreasureMailIndex()
  return self.selectTreasureMailIndex
end

function MailModel:GetTreasureRedState()
  return self.treasureRedState
end

function MailModel:ShouldShowGetCollectMailAnim()
  return self.showGetCollectMailAnim
end

function MailModel:ClearMailList()
  self.mailList = {}
  self.mails = {}
end

function MailModel:SetSelectMailUid(uid)
  self.selectMailUid = uid
end

function MailModel:SetSelectMailIndex(index)
  self.selectMailIndex = index
end

function MailModel:SetSelectTreasureMailIndex(index)
  self.selectTreasureMailIndex = index
end

function MailModel:SetSelectTreasureMailUid(uid)
  self.selectTreasureMailUid = uid
end

function MailModel:SortMailList()
  self.mailList = self:ListSorting(self.mailList)
end

function MailModel:SetNeedSort(needSort)
  self.needSort = needSort
  if false == needSort and (DataCenter.mailData.hasAddMail or DataCenter.mailData.hasDelMail) then
    local hasAdd, hasDel
    if DataCenter.mailData.hasAddMail then
      hasAdd = false
    end
    if DataCenter.mailData.hasDelMail then
      hasDel = false
    end
    MailDataUtils.SetSyncStatus(hasAdd, hasDel)
  end
end

function MailModel:SetMailHasRead(uid)
  if not uid then
    return
  end
  if self.notReadMails[uid] then
    self.notReadMails[uid] = nil
  end
end

function MailModel:SetTreasureNeedSort(treasureNeedSort)
  self.treasureNeedSort = treasureNeedSort
  if false == treasureNeedSort and DataCenter.mailData.hasDelMail then
    MailDataUtils.SetSyncStatus(nil, false)
  end
end

function MailModel:SortTreasureMailList()
  self.treasureMailList = self:ListSorting(self.treasureMailList)
end

function MailModel:SetTreasureRedState(state)
  if not state then
    return
  end
  self.treasureRedState = state
end

function MailModel:SetShowCollectMailAnim(bool)
  self.showGetCollectMailAnim = bool
end

function MailModel:HasTreasureRed()
  if self.treasureRedState == MailDataUtils.TreasureRedState.NotRed then
    return false
  end
  return RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.TreasureMail) == RedPointDataUtils.RedAttrType.Red
end

function MailModel:ListSorting(targetList)
  local list = {}
  for _, mail in ipairs(targetList) do
    tableInsert(list, mail)
  end
  
  local function sortFunc(a, b)
    local readSortA = a:IsRead() and 1 or 0
    local readSortB = b:IsRead() and 1 or 0
    if readSortA == readSortB then
      if a:GetTimeStamp() == b:GetTimeStamp() then
        return a:GetMailUid() > b:GetMailUid()
      end
      return a:GetTimeStamp() > b:GetTimeStamp()
    end
    return readSortA < readSortB
  end
  
  tableSort(list, sortFunc)
  return list
end

function MailModel:UpdateMails(serverDatas)
  if not serverDatas then
    return
  end
  for _, serverMail in pairs(serverDatas) do
    if serverMail then
      local mail
      local addToTreasureMails = serverMail.collection and serverMail.read
      if addToTreasureMails then
        mail = self.treasureMails[serverMail.mailUid]
      else
        mail = self.mails[serverMail.mailUid]
      end
      if mail then
        mail:UpdateData(serverMail)
      else
        mail = MailMO()
        mail:UpdateData(serverMail)
        if addToTreasureMails then
          self.treasureMails[serverMail.mailUid] = mail
        else
          self.mails[serverMail.mailUid] = mail
        end
        self:AddMailToList(mail)
      end
    end
  end
end

function MailModel:AddMailToList(mailData)
  if not mailData then
    return
  end
  local addToTreasureMails = mailData:IsCollection() and mailData:IsRead()
  if addToTreasureMails then
    table.insert(self.treasureMailList, mailData)
  else
    table.insert(self.mailList, mailData)
  end
end

function MailModel:RemoveMail(mailUid)
  if not mailUid then
    return
  end
  if self.mails[mailUid] then
    self.mails[mailUid] = nil
  end
  self:RemoveMailFromList(mailUid)
end

function MailModel:RemoveTreasureMail(mailUid)
  if not mailUid then
    return
  end
  if self.treasureMails[mailUid] then
    self.treasureMails[mailUid] = nil
  end
  self:RemoveMailFromTreasureList(mailUid)
end

function MailModel:RemoveMailFromList(mailUid)
  if not mailUid then
    return
  end
  local index
  for _index, mailData in ipairs(self.mailList) do
    if mailData and mailData:GetMailUid() == mailUid then
      index = _index
      break
    end
  end
  if index then
    tableRemove(self.mailList, index)
  end
end

function MailModel:RemoveMailFromTreasureList(mailUid)
  if not mailUid then
    return
  end
  local index
  for _index, mailData in ipairs(self.treasureMailList) do
    if mailData and mailData:GetMailUid() == mailUid then
      index = _index
      break
    end
  end
  if index then
    tableRemove(self.treasureMailList, index)
  end
end

function MailModel:OnDeleteMailSuccess(mail)
  if mail:IsCollection() then
    self:SetTreasureNeedSort(true)
    self:RemoveTreasureMail(mail:GetMailUid())
  else
    self:SetNeedSort(true)
    self:RemoveMail(mail:GetMailUid())
  end
end

function MailModel:_MoveToTreasureMails(mail)
  if mail:IsRead() and mail:IsCollection() then
    mail:SetValidTime(nil)
    local uid = mail:GetMailUid()
    self.mails[uid] = nil
    self:RemoveMailFromList(uid)
    if not self.treasureMails[uid] then
      self.treasureMails[uid] = mail
      table.insert(self.treasureMailList, mail)
    end
  end
end

function MailModel:UpdateNotReadMails()
  self.notReadMails = {}
  for _, mail in ipairs(self.mailList) do
    if not mail:IsRead() then
      self.notReadMails[mail:GetMailUid()] = true
    end
  end
end

function MailModel:GetPreviousUid(currentUid)
  local list = self.mailList
  for i, mail in ipairs(list) do
    if mail:GetMailUid() == currentUid then
      local prev = list[i - 1]
      return prev and prev:GetMailUid()
    end
  end
end

function MailModel:GetNextUid(currentUid)
  local list = self.mailList
  for i, mail in ipairs(list) do
    if mail:GetMailUid() == currentUid then
      local nextMail = list[i + 1]
      return nextMail and nextMail:GetMailUid()
    end
  end
end

function MailModel:GetPreviousTreasureUid(currentUid)
  local list = self.treasureMailList
  for i, mail in ipairs(list) do
    if mail:GetMailUid() == currentUid then
      local prev = list[i - 1]
      return prev and prev:GetMailUid()
    end
  end
end

function MailModel:GetNextTreasureUid(currentUid)
  local list = self.treasureMailList
  for i, mail in ipairs(list) do
    if mail:GetMailUid() == currentUid then
      local nextMail = list[i + 1]
      return nextMail and nextMail:GetMailUid()
    end
  end
end

function MailModel:ReqMailList()
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnOpenEmail", function(svrData)
    local function __OnReqSurveyCallback(succ, surveyList)
      self:UpdateMails(svrData)
      
      MailDataUtils.OnHandleSurveyData(succ, surveyList)
      self:UpdateMails(DataCenter.mailData.surveyMails)
      self:UpdateNotReadMails()
      self:SetNeedSort(true)
      self:LocalNotify(NotifyId.OnChangeMailData)
      self:LocalNotify(NotifyId.OnMailListLoaded)
    end
    
    SdkMgr.Instance:GetSurveyList(__OnReqSurveyCallback)
  end, function()
  end)
end

function MailModel:_OnSyncMails(data)
  if not data then
    return
  end
  local hasAdd = data.add and table.next(data.add) ~= nil
  local hasDel = data.del and nil ~= table.next(data.del)
  if hasAdd then
    self:UpdateMails(data.add)
  end
  if hasDel then
    for _, uid in ipairs(data.del) do
      self:RemoveMail(uid)
    end
  end
  MailDataUtils.SetSyncStatus(hasAdd, hasDel)
  self:UpdateNotReadMails()
  self:LocalNotify(NotifyId.OnChangeMailData)
end

function MailModel:ReqTreasureMailList(callback)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnOpenCollectionEmail", function(svrData)
    self:SetTreasureNeedSort(true)
    self:UpdateMails(svrData)
    self:LocalNotify(NotifyId.OnChangeTreasureMailData)
    if callback then
      callback()
    end
  end, function()
  end)
end

function MailModel:_OnReadMail(svrData, mail, callback)
  if not mail then
    return
  end
  self:UpdateMails({svrData})
  if not mail:HasAttachment() then
    mail:SetRead(true)
    self:SetMailHasRead(mail:GetMailUid())
  end
  if callback then
    callback()
  end
  mail:SetHasDetail(true)
  if not self:HasMailNotRead() then
    MailDataUtils.RemoveMailRed()
  end
  self:LocalNotify(NotifyId.OnChangeMailData)
end

function MailModel:ReqReadMail(uid, callback)
  if not uid then
    return
  end
  local mail = self:GetMail(uid)
  if not mail then
    return
  end
  if mail:HasDetail() then
    if callback then
      callback()
    end
    return
  end
  if mail:IsClientSurvey() then
    mail:SetHasDetail(true)
    mail:SetRead(true)
    MailDataUtils.SetReadSurveyCache(mail:GetMailUid())
    self:SetMailHasRead(uid)
    if callback then
      callback()
    end
    self:LocalNotify(NotifyId.OnChangeMailData)
    return
  end
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnOpenEmailDetails", function(svrData)
    self:_OnReadMail(svrData, mail, callback)
  end, function()
  end, uid)
end

function MailModel:ReqDeleteMail(uid, index, callback)
  if not uid then
    return
  end
  if self:IsClientSurveyMail(uid) then
    return
  end
  local mail = self:GetMail(uid)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnEmailDelete", function(_)
    if callback then
      callback(mail, index)
    end
  end, function()
  end, uid)
end

function MailModel:ReqDeleteAllMail(tp)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnEmailDeleteAll", function(_)
    for key, mail in pairs(self.mails) do
      if mail:IsRead() and not mail:IsClientSurvey() then
        self:RemoveMail(key)
      end
    end
    self:SetSelectMailUid()
    self:SetSelectMailIndex()
    self:SetNeedSort(true)
    self:UpdateNotReadMails()
    self:LocalNotify(NotifyId.OnChangeMailData)
  end, function()
  end, tp)
end

function MailModel:_OnGetAttachmentSuccess(mail)
  if mail then
    mail:SetRead(true)
    self:SetMailHasRead(mail:GetMailUid())
  end
  if not self:HasMailNotRead() then
    MailDataUtils.RemoveMailRed()
  end
  if mail:IsCollection() then
    mail:SetValidTime(nil)
    self:_MoveToTreasureMails(mail)
    self:SetSelectMailUid()
    self:SetTreasureRedState(MailDataUtils.TreasureRedState.ShouldShowRed)
    self:SetShowCollectMailAnim(true)
  end
  self:UpdateNotReadMails()
  self:LocalNotify(NotifyId.OnChangeMailData)
end

function MailModel:ReqGetAttachment(uid, callback)
  if not uid then
    return
  end
  local mail = self:GetMail(uid)
  if not mail then
    return
  end
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnEmailGainItem", function(_)
    self:_OnGetAttachmentSuccess(mail)
    if callback then
      callback()
    end
  end, function()
  end, uid)
end

function MailModel:_OnGetAllAttachment(svrData, callback)
  if not svrData then
    return
  end
  local mailList = svrData.mailList or {}
  local hasCollection = false
  for _, uid in pairs(mailList) do
    local mail = self.mails[uid]
    if not mail then
    else
      mail:SetRead(true)
      self:SetMailHasRead(mail:GetMailUid())
      if mail:IsCollection() then
        hasCollection = true
      end
      self:_MoveToTreasureMails(mail)
      if mail:GetMailUid() == self.selectMailUid and mail:IsCollection() then
        self:SetSelectMailUid()
      end
    end
  end
  if hasCollection then
    self:SetTreasureRedState(MailDataUtils.TreasureRedState.ShouldShowRed)
    self:SetShowCollectMailAnim(true)
  end
  if not self:HasMailNotRead() then
    MailDataUtils.RemoveMailRed()
  end
  if callback then
    callback()
  end
  if svrData.isAll and #mailList > 0 then
    Alert.Show(10530)
  elseif not svrData.isAll and #mailList > 0 then
    Alert.Show(10534)
  elseif not svrData.isAll and 0 == #mailList then
    Alert.Show(10534)
  else
    Alert.Show(10535)
  end
  self:UpdateNotReadMails()
  self:LocalNotify(NotifyId.OnChangeMailData)
end

function MailModel:ReqGetAllAttachment(callback)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnAllEmailGainItem", function(svrData)
    self:_OnGetAllAttachment(svrData, callback)
  end, function()
  end)
end

function MailModel:ReqAllGainEnergyItemCount(callback)
  ProtoManager.Instance:ReqServer("GameRequest", "OnQueryAllGainEnergyItemCount", function(svrData)
    if callback then
      callback(svrData)
    end
  end, function()
    if callback then
      callback()
    end
  end)
end

function MailModel:ReqShowSurvey(mail)
  if not mail:GetSurveyId() then
    Logger.Info("***** 打开问卷失败, 找不到问卷id, mail.survey_id => ", mail and mail:GetSurveyId())
    return
  end
  SdkMgr.Instance:ShowSurvey(mail:GetSurveyId(), function()
  end)
  Logger.Info("***** 打开了问卷, survay_id:%s, mailUid:%s *****", mail:GetSurveyId(), mail:GetMailUid())
end

function MailModel:ParseMailText(uid)
  local mail = self:GetMail(uid)
  if not mail then
    return
  end
  local config = self:GetMailConfig(mail:GetCfgTid())
  if not uid or not config then
    return {
      {
        true,
        self:GetMailDesc(uid) or ""
      }
    }
  end
  local pictures = {}
  if config.picture then
    local parsePic = string.split(config.picture, ",")
    for i = 1, #parsePic, 2 do
      pictures[parsePic[i]] = parsePic[i + 1]
    end
  end
  local desc = self:GetMailDesc(uid)
  local content = {}
  local strStart = 1
  local nextStart = 1
  local strEnd = 1
  local tmpPic, tmpText
  while strEnd <= string.len(desc) and table.next(pictures) do
    strEnd, nextStart, tmpPic = string.find(desc, "{(.-)}", strStart)
    if not strEnd then
      break
    end
    tmpText = string.sub(desc, strStart, strEnd - 1)
    if tmpText and "" ~= tmpText then
      if tmpPic and "" ~= tmpPic and not pictures[tmpPic] then
        tmpText = tmpText .. "{" .. tmpPic .. "}"
      end
      table.insert(content, {true, tmpText})
    end
    if tmpPic and "" ~= tmpPic and pictures[tmpPic] then
      table.insert(content, {
        false,
        pictures[tmpPic]
      })
    end
    strStart = nextStart + 1
  end
  if strStart and strStart < string.len(desc) then
    table.insert(content, {
      true,
      string.sub(desc, strStart) or ""
    })
  end
  return #content > 0 and content or {
    {
      true,
      desc or ""
    }
  }
end

function MailModel:UpdateMailAttachments(mailUid, attachments)
  local hasAttachment = self:HasAttachment(mailUid)
  local hasMailRead = self:IsMailRead(mailUid)
  local hasReceived = hasAttachment and hasMailRead
  if not attachments then
    return
  end
  for index, data in ipairs(attachments) do
    if data then
      data.received = hasReceived
    end
    if not data.uid then
      data.uid = index
    end
  end
end

return MailModel
