local MailMO = NewClass("MailMO")

function MailMO:ctor()
  self.mailUid = nil
  self.cfgTid = nil
  self.title = ""
  self.content = ""
  self.sender = ""
  self.ts = 0
  self.validTime = nil
  self.sign = ""
  self.read = false
  self.collection = false
  self.isItem = false
  self.itemList = {}
  self.isClientSurvey = false
  self.survey_id = nil
  self.end_time = nil
  self.hasDetail = false
  self.cfgParam = nil
end

function MailMO:UpdateData(data)
  if not data then
    return
  end
  self:SetMailUid(data.mailUid)
  self:SetCfgTid(data.cfgTid)
  self:SetTitle(data.title)
  self:SetContent(data.content)
  self:SetSender(data.sender)
  self:SetTimeStamp(data.ts)
  self:SetValidTime(data.validTime)
  self:SetSign(data.sign)
  self:SetRead(data.read)
  self:SetCollection(data.collection)
  self:SetIsItem(data.isItem)
  self:SetItemList(data.itemList)
  self:SetIsClientSurvey(data.isClientSurvey)
  self:SetSurveyId(data.survey_id)
  self:SetEndTime(data.end_time)
  self:SetHasDetail(data.hasDetail)
  self:SetCfgParam(data.cfgParam)
end

function MailMO:SetMailUid(val)
  if nil == val then
    return
  end
  self.mailUid = val
end

function MailMO:SetCfgTid(val)
  if nil == val then
    return
  end
  self.cfgTid = val
end

function MailMO:SetTitle(val)
  self.title = val or ""
end

function MailMO:SetContent(val)
  self.content = val or ""
end

function MailMO:SetSender(val)
  self.sender = val or ""
end

function MailMO:SetTimeStamp(val)
  if nil == val then
    return
  end
  self.ts = val
end

function MailMO:SetValidTime(val)
  self.validTime = val
end

function MailMO:SetSign(val)
  self.sign = val or ""
end

function MailMO:SetRead(val)
  if nil == val then
    return
  end
  self.read = val
end

function MailMO:SetCollection(val)
  if nil == val then
    return
  end
  self.collection = val
end

function MailMO:SetIsItem(val)
  if nil == val then
    return
  end
  self.isItem = val
end

function MailMO:SetItemList(val)
  if nil == val then
    return
  end
  self.itemList = val
end

function MailMO:SetIsClientSurvey(val)
  if nil == val then
    return
  end
  self.isClientSurvey = val
end

function MailMO:SetSurveyId(val)
  self.survey_id = val
end

function MailMO:SetEndTime(val)
  self.end_time = val
end

function MailMO:SetHasDetail(val)
  if nil == val then
    return
  end
  self.hasDetail = val
end

function MailMO:SetCfgParam(val)
  self.cfgParam = val
end

function MailMO:GetMailUid()
  return self.mailUid
end

function MailMO:GetCfgTid()
  return self.cfgTid
end

function MailMO:GetTitle()
  return self.title
end

function MailMO:GetContent()
  return self.content
end

function MailMO:GetSender()
  return self.sender
end

function MailMO:GetTimeStamp()
  return self.ts
end

function MailMO:GetValidTime()
  return self.validTime
end

function MailMO:GetSign()
  return self.sign
end

function MailMO:GetItemList()
  return self.itemList
end

function MailMO:GetSurveyId()
  return self.survey_id
end

function MailMO:GetEndTime()
  return self.end_time
end

function MailMO:GetCfgParam()
  return self.cfgParam
end

function MailMO:IsRead()
  return self.read
end

function MailMO:IsCollection()
  return self.collection
end

function MailMO:HasAttachment()
  return self.isItem
end

function MailMO:IsClientSurvey()
  return self.isClientSurvey
end

function MailMO:HasDetail()
  return self.hasDetail
end

function MailMO:CanReceiveAttachment()
  return self.isItem and not self.read
end

function MailMO:IsExpired()
  local now = TimeUtils.GetServerTime()
  if self.isClientSurvey and self.end_time then
    return now > self.end_time
  end
  if self.validTime and type(self.validTime) == "number" then
    return now > self.validTime
  end
  return false
end

return MailMO
