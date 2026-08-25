local tableInsert = table.insert
local tableSort = table.sort
local MAIL_TITLE_MAX_LEN = 22

local function createMailModelState()
  local state = {}
  state.mails = {}
  state.mailList = {}
  state.treasureMails = {}
  state.treasureMailList = {}
  
  function state.notReadMails()
    local mailList = state.mailList
    local map = {}
    for _, mail in ipairs(mailList) do
      if not mail.read then
        map[mail.mailUid] = true
      end
    end
    return map
  end
  
  state.needSort = false
  state.treasureNeedSort = false
  state.selectMailUid = nil
  state.selectMailIndex = nil
  state.selectTreasureMailIndex = nil
  state.selectTreasureMailUid = nil
  state.treasureRedState = MailDataUtils.TreasureRedState.NotRed
  state.maxNum = 100
  state.showGetCollectMailAnim = false
  return state
end

local function createMailModelViews()
  local views = {}
  
  function views:CheckChosenEmpty()
    return self.selectMailUid ~= nil
  end
  
  function views:CheckTreasureChosenEmpty()
    return self.selectTreasureMailUid ~= nil
  end
  
  function views:GetMailConfig(tid)
    if not tid then
      return
    end
    return DT.Mail[tid]
  end
  
  function views:HasMailNotRead()
    return table.next(self.notReadMails) ~= nil
  end
  
  function views:HasReadMailNum()
    local num = 0
    for _, mail in ipairs(self.mailList) do
      if mail and mail.read then
        num = num + 1
      end
    end
    return num
  end
  
  function views:GetMail(uid)
    if not uid then
      return
    end
    local mail = self.mails[uid]
    mail = mail or self.treasureMails[uid]
    return mail
  end
  
  function views:GetMailTitle(uid)
    local mail = self:GetMail(uid)
    if not mail then
      return
    end
    local config = self:GetMailConfig(mail.cfgTid)
    if not config then
      do return StrUtils.ReplacePlayerNamePlaceholder, LT.Text(mail.title or "") end
      return StrUtils.ReplacePlayerNamePlaceholder, LT.Text(mail.title or "")
    end
    do return StrUtils.ReplacePlayerNamePlaceholder, LT.Text(config.Name) end
    return StrUtils.ReplacePlayerNamePlaceholder, LT.Text(config.Name)
  end
  
  function views:GetMailListTitle(uid)
    local title = self:GetMailTitle(uid)
    if not title then
      return
    end
    do return StrUtils.TruncateTextForDisplay, title end
    return StrUtils.TruncateTextForDisplay, title, MAIL_TITLE_MAX_LEN
  end
  
  function views:GetTimeFormat(time)
    do return TimeUtils.TimestampToString, time end
    return TimeUtils.TimestampToString, time, TimeUtils.TimeExactType.Minute
  end
  
  function views:GetLeftTime(uid)
    local mail = self:GetMail(uid)
    if not mail or not mail.validTime then
      return ""
    end
    if type(mail.validTime) ~= "number" then
      Logger.ReportApusErrorS("【Mail】 Error mail valid time!", "uid:" .. tostring(uid) .. ", validTime type:" .. type(mail.validTime), TimeUtils.GetServerTime())
      return ""
    end
    local leftTime = mail.validTime
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
  
  function views:GetMailInfoDesc(uid)
    local mail = self:GetMail(uid)
    if not mail then
      return
    end
    local publisher = self:GetPublisher(uid) or ""
    local time = self:GetTimeFormat(mail.ts)
    local timeText = LT.Textf("Mail_SendTime", time)
    local infoDesc = publisher .. "\n" .. timeText
    return infoDesc
  end
  
  function views:GetTimeInfoText(uid)
    local mail = self:GetMail(uid)
    if not mail then
      return
    end
    local time = self:GetTimeFormat(mail.ts)
    return time
  end
  
  function views:GetPublisher(uid, withPrefix)
    local mail = self:GetMail(uid)
    if not mail then
      return
    end
    local publisher
    local config = self:GetMailConfig(mail.cfgTid)
    if not config then
      if not mail.sender then
        return
      end
      publisher = mail.sender or ""
    else
      publisher = LT.Text(config.Sender)
    end
    publisher = StrUtils.ReplacePlayerNamePlaceholder(LT.Text(publisher))
    if withPrefix then
      publisher = LT.Textf("Mail_Sender", publisher)
    end
    return publisher
  end
  
  function views:GetMailDesc(uid)
    local mail = self:GetMail(uid)
    if not mail then
      return
    end
    local params = mail.cfgParam
    local config = self:GetMailConfig(mail.cfgTid)
    local desc
    if config then
      if params and #params > 0 then
        desc = LT.Textf(config.Desc, table.unpack(self:ParseMailCfgParam(params)))
      else
        desc = LT.Text(config.Desc)
      end
    else
      desc = LT.Text(mail.content or "")
    end
    do return StrUtils.ReplacePlayerNamePlaceholder end
    return StrUtils.ReplacePlayerNamePlaceholder, desc, table.unpack(self:ParseMailCfgParam(params))
  end
  
  function views:ParseMailCfgParam(cfgParam)
    local rst = {}
    for _, param in ipairs(cfgParam) do
      table.insert(rst, LT.Text(param))
    end
    return rst
  end
  
  function views:GetQuantityShow(list, textKey)
    local listNum = list and #list or 0
    do return LT.Textf, textKey, listNum end
    return LT.Textf, textKey, listNum, self.maxNum
  end
  
  function views:IsEmpyMailBox(list)
    return not list or table.next(list) == nil
  end
  
  function views:IsMailRead(uid)
    local mail = self:GetMail(uid)
    if not mail then
      return true
    end
    return mail.read
  end
  
  function views:HasAttachment(uid)
    local mail = self:GetMail(uid)
    if not mail then
      return false
    end
    return mail and mail.isItem
  end
  
  function views:IsClientSurveyMail(uid)
    local mail = self:GetMail(uid)
    if not mail then
      return false
    end
    return mail.isClientSurvey
  end
  
  function views:CanReceiveAttachment(uid)
    local hasAttachment = self:HasAttachment(uid)
    local hasMailRead = self:IsMailRead(uid)
    return hasAttachment and not hasMailRead
  end
  
  function views:GetAttachments(uid)
    local mail = self:GetMail(uid)
    if not mail then
      return {}
    end
    return mail.itemList
  end
  
  function views:ListSorting(targetList)
    local list = {}
    for _, mail in ipairs(targetList) do
      tableInsert(list, mail)
    end
    
    local function sortFunc(a, b)
      local readSortA = a.read and 1 or 0
      local readSortB = b.read and 1 or 0
      if readSortA == readSortB then
        if a.ts == b.ts then
          return a.mailUid > b.mailUid
        end
        return a.ts > b.ts
      end
      return readSortA < readSortB
    end
    
    tableSort(list, sortFunc)
    return list
  end
  
  return views
end

local function createMailModelActions()
  local actions = {}
  
  function actions:ClearMailList()
    self.mailList = {}
    self.mails = {}
  end
  
  function actions:SetSelectMailUid(uid)
    self.selectMailUid = uid
  end
  
  function actions:SetSelectMailIndex(index)
    self.selectMailIndex = index
  end
  
  function actions:SetSelectTreasureMailIndex(index)
    self.selectTreasureMailIndex = index
  end
  
  function actions:SetSelectTreasureMailUid(uid)
    self.selectTreasureMailUid = uid
  end
  
  function actions:SortMailList()
    self.mailList = self:ListSorting(self.mailList)
  end
  
  function actions:SetNeedSort(needSort)
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
  
  function actions:SetMailHasRead(uid)
    if not uid then
      return
    end
    if self.notReadMails[uid] then
      self.notReadMails[uid] = nil
    end
  end
  
  function actions:SetTreasureNeedSort(treasureNeedSort)
    self.treasureNeedSort = treasureNeedSort
    if false == treasureNeedSort and DataCenter.mailData.hasDelMail then
      MailDataUtils.SetSyncStatus(nil, false)
    end
  end
  
  function actions:SortTreasureMailList()
    self.treasureMailList = self:ListSorting(self.treasureMailList)
  end
  
  function actions:UpdateMails(serverDatas)
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
          for k, v in pairs(serverMail) do
            mail[k] = v
          end
        else
          if addToTreasureMails then
            self.treasureMails[serverMail.mailUid] = serverMail
          else
            self.mails[serverMail.mailUid] = serverMail
          end
          self:AddMailToList(serverMail)
        end
      end
    end
  end
  
  function actions:ParseMailText(uid)
    local mail = self:GetMail(uid)
    if not mail then
      return
    end
    local config = self:GetMailConfig(mail.cfgTid)
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
  
  function actions:AddMailToList(mailData)
    if not mailData then
      return
    end
    local addToTreasureMails = mailData.collection and mailData.read
    if addToTreasureMails then
      table.insert(self.treasureMailList, mailData)
    else
      table.insert(self.mailList, mailData)
    end
  end
  
  function actions:RemoveMail(mailUid)
    if not mailUid then
      return
    end
    if self.mails[mailUid] then
      self.mails[mailUid] = nil
    end
    self:RemoveMailFromList(mailUid)
  end
  
  function actions:RemoveTreasureMail(mailUid)
    if not mailUid then
      return
    end
    if self.treasureMails[mailUid] then
      self.treasureMails[mailUid] = nil
    end
    self:RemoveMailFromTreasureList(mailUid)
  end
  
  function actions:RemoveMailFromList(mailUid)
    if not mailUid then
      return
    end
    local index
    for _index, mailData in ipairs(self.mailList) do
      if mailData and mailData.mailUid == mailUid then
        index = _index
        break
      end
    end
    if index then
      table.remove(self.mailList, index)
    end
  end
  
  function actions:RemoveMailFromTreasureList(mailUid)
    if not mailUid then
      return
    end
    local index
    for _index, mailData in ipairs(self.treasureMailList) do
      if mailData and mailData.mailUid == mailUid then
        index = _index
        break
      end
    end
    if index then
      table.remove(self.treasureMailList, index)
    end
  end
  
  function actions:ReqMailList(callback)
    EventMgr.Instance.OpenReqMask:Dispatch()
    ProtoManager.Instance:ReqServer("GameRequest", "OnOpenEmail", function(svrData)
      local function __OnReqSurveyCallback(succ, surveyList)
        self:UpdateMails(svrData)
        
        MailDataUtils.OnHandleSurveyData(succ, surveyList)
        self:UpdateMails(DataCenter.mailData.surveyMails)
        self:SetNeedSort(true)
        if callback then
          callback()
        end
      end
      
      SdkMgr.Instance:GetSurveyList(__OnReqSurveyCallback)
    end, function()
    end)
  end
  
  function actions:ReqTreasureMailList(callback)
    EventMgr.Instance.OpenReqMask:Dispatch()
    ProtoManager.Instance:ReqServer("GameRequest", "OnOpenCollectionEmail", function(svrData)
      self:SetTreasureNeedSort(true)
      self:UpdateMails(svrData)
      if callback then
        callback()
      end
    end, function()
    end)
  end
  
  function actions:_OnReadMail(svrData, mail, callback)
    if not mail then
      return
    end
    self:UpdateMails({svrData})
    if not mail.isItem then
      mail.read = true
      self:SetMailHasRead(mail.mailUid)
    end
    if callback then
      callback()
    end
    mail.hasDetail = true
    if not self:HasMailNotRead() then
      MailDataUtils.RemoveMailRed()
    end
  end
  
  function actions:ReqReadMail(uid, callback, _)
    if not uid then
      return
    end
    local mail = self:GetMail(uid)
    if not mail then
      return
    end
    if mail.hasDetail then
      if callback then
        callback()
      end
      return
    end
    if mail.isClientSurvey then
      mail.hasDetail = true
      mail.read = true
      MailDataUtils.SetReadSurveyCache(mail.mailUid)
      self:SetMailHasRead(uid)
      if callback then
        callback()
      end
      return
    end
    EventMgr.Instance.OpenReqMask:Dispatch()
    ProtoManager.Instance:ReqServer("GameRequest", "OnOpenEmailDetails", function(svrData)
      print("---------------read mail:", table.tostring(svrData))
      self:_OnReadMail(svrData, mail, callback)
    end, function()
    end, uid)
  end
  
  function actions:ReqDeleteMail(uid, index, callback)
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
  
  function actions:OnDeleteMailSuccess(mail)
    if mail.collection then
      self:SetTreasureNeedSort(true)
      self:RemoveTreasureMail(mail.mailUid)
    else
      self:SetNeedSort(true)
      self:RemoveMail(mail.mailUid)
    end
  end
  
  function actions:ReqDeleteAllMail(tp)
    EventMgr.Instance.OpenReqMask:Dispatch()
    ProtoManager.Instance:ReqServer("GameRequest", "OnEmailDeleteAll", function(_)
      for key, mail in pairs(self.mails) do
        if mail.read == true and not mail.isClientSurvey then
          self:RemoveMail(key)
        end
      end
      self:SetSelectMailUid()
      self:SetSelectMailIndex()
      self:SetNeedSort(true)
    end, function()
    end, tp)
  end
  
  function actions:SetShowCollectMailAnim(bool)
    self.showGetCollectMailAnim = bool
  end
  
  function actions:_OnGetAttachmentSuccess(mail)
    if mail then
      mail.read = true
      self:SetMailHasRead(mail.mailUid)
    end
    if not self:HasMailNotRead() then
      MailDataUtils.RemoveMailRed()
    end
    if mail.collection then
      mail.validTime = nil
      self:_MoveToTreasureMails(mail)
      self:SetSelectMailUid()
      self:SetTreasureRedState(MailDataUtils.TreasureRedState.ShouldShowRed)
      self:SetShowCollectMailAnim(true)
    end
  end
  
  function actions:ReqGetAttachment(uid, callback)
    if not uid then
      return
    end
    local mail = self:GetMail(uid)
    EventMgr.Instance.OpenReqMask:Dispatch()
    ProtoManager.Instance:ReqServer("GameRequest", "OnEmailGainItem", function(_)
      self:_OnGetAttachmentSuccess(mail)
      if callback then
        callback()
      end
    end, function()
    end, uid)
  end
  
  function actions:_OnGetAllAttachment(svrData, callback)
    if not svrData then
      return
    end
    for _, uid in pairs(svrData.mailList or {}) do
      local mail = self.mails[uid]
      if not mail then
      else
        mail.read = true
        self:SetMailHasRead(mail.mailUid)
        self:_MoveToTreasureMails(mail)
        if mail.mailUid == self.selectMailUid and mail.collection then
          self:SetSelectMailUid()
        end
      end
    end
    if not self:HasMailNotRead() then
      MailDataUtils.RemoveMailRed()
    end
    if callback then
      callback()
    end
    if svrData.isAll and #svrData.mailList > 0 then
      Alert.Show(10530)
    elseif not svrData.isAll and #svrData.mailList > 0 then
      Alert.Show(10534)
    elseif not svrData.isAll and 0 == #svrData.mailList then
      Alert.Show(10534)
    else
      Alert.Show(10535)
    end
  end
  
  function actions:ReqGetAllAttachment(callback)
    EventMgr.Instance.OpenReqMask:Dispatch()
    ProtoManager.Instance:ReqServer("GameRequest", "OnAllEmailGainItem", function(svrData)
      self:_OnGetAllAttachment(svrData, callback)
    end, function()
    end)
  end
  
  function actions:ReqAllGainEnergyItemCount(callback)
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
  
  function actions:_MoveToTreasureMails(mail)
    if mail.read and mail.collection then
      mail.validTime = nil
      self:UpdateMails({mail})
      self:RemoveMail(mail.mailUid)
    end
  end
  
  function actions:UpdateMailAttachments(mailUid, attachments)
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
  
  function actions:SetTreasureRedState(state)
    if not state then
      return
    end
    self.treasureRedState = state
  end
  
  function actions:ReqShowSurvey(mail)
    if not mail.survey_id then
      Logger.Info("***** 打开问卷失败, 找不到问卷id, mail.survey_id => ", mail and mail.survey_id)
      return
    end
    SdkMgr.Instance:ShowSurvey(mail.survey_id, function()
    end)
    Logger.Info("***** 打开了问卷, survay_id:%s, mailUid:%s *****", mail.survey_id, mail.mailUid)
  end
  
  return actions
end

local function onSetup(binder, model)
  binder:BindToRaw(function(_, valueTable, _)
    if not valueTable then
      return
    end
    local hasAddMail = valueTable[1]
    local hasDelMail = valueTable[2]
    if hasAddMail then
      model:SetNeedSort(true)
    end
    if hasDelMail then
      model:SetNeedSort(true)
      model:SetTreasureNeedSort(true)
    end
  end, function()
    return {
      DataCenter.mailData.hasAddMail,
      DataCenter.mailData.hasDelMail
    }
  end)
end

local MailModel = Vue.model("MailModel", createMailModelState):views(createMailModelViews):actions(createMailModelActions):setup(onSetup)
return MailModel
