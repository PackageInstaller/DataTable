local this = {}

function this:init()
  this.super.init(self)
  self.checkedMail = 0
  self.data = {
    pullMail = false,
    mailData = {},
    unreadCount = 0,
    mailRedTimers = {}
  }
  self:getArgsParser()
end

function this:getArgsParser()
  if not self.parser then
    self.parser = require(L_R.store .. "mail.mailArgsParser")
  end
  return self.parser
end

function this:getAllMailInfo()
  return self.data.mailData
end

function this:getUnreadCount()
  return self.data.unreadCount
end

function this:getMail(guid)
  for i, v in pairs(L_MailStore:getAllMailInfo()) do
    if v.guid == guid then
      return self.data.mailData[i], false
    end
  end
  return require(L_R.store .. "mail.mailItem").new(), true
end

function this:getMailTemplateId(guid)
  local allMails = self:getAllMailInfo()
  for i, mail in pairs(allMails) do
    if mail.guid == guid then
      return mail.template_id
    end
  end
  return nil
end

function this:getMailCount()
  local tempCount = 0
  for k, v in pairs(L_MailStore:getAllMailInfo()) do
    local time1, time2 = L_TimeUtil.getLeftDayAndHour(v.effecttm + v.createtm)
    if v.guid ~= 0 and time1 ~= nil or v.effecttm == 0 then
      tempCount = tempCount + 1
    end
  end
  return tempCount
end

function this:getNoReadCount()
  local tempCount = 0
  for k, v in pairs(L_MailStore:getAllMailInfo()) do
    local time1, time2 = L_TimeUtil.getLeftDayAndHour(v.effecttm + v.createtm)
    if v.guid ~= 0 and time1 ~= nil and not v.read then
      tempCount = tempCount + 1
    end
  end
  return tempCount
end

function this:getCheckedMail()
  return self.checkedMail
end

function this:getBoolFetchMail(guid)
  for i = 1, #self.data.mailData do
    if self.data.mailData[i].guid == guid then
      if not self.data.mailData[i].reward or not self.data.mailData[i].reward.rewards then
        return true
      end
      return self.data.mailData[i].fetch
    end
  end
end

function this:getHaveMail(guid)
  for i = 1, #self.data.mailData do
    if self.data.mailData[i].guid == guid then
      return true
    end
  end
  return false
end

function this:getPullMail(guid)
  return self.data.pullMail
end

function this:getMailExtArgs(mailData, type)
  return mailData and mailData.argsDict[type]
end

return this
