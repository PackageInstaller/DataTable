local this = class("mailManager")

function this:getMailByCategory(categoryType)
  if categoryType == L_Const.mailCategory.all then
    return self:getAllMail()
  elseif categoryType == L_Const.mailCategory.unread then
    return self:getUnreadMail()
  else
    return self:getCollectedMail()
  end
end

function this:getAllMail()
  local res = {}
  local allMails = L_MailStore:getAllMailInfo()
  for _, mail in pairs(allMails) do
    if self:checkMailEffectValid(mail) then
      table.insert(res, mail)
    end
  end
  self:sortMail(res)
  return res
end

function this:getUnreadMail(allMails)
  local res = {}
  allMails = allMails or L_MailStore:getAllMailInfo()
  for _, mail in pairs(allMails) do
    if self:checkMailEffectValid(mail) then
      if mail.read then
        if mail.reward and mail.reward.rewards and not mail.fetch then
          table.insert(res, mail)
        end
      else
        table.insert(res, mail)
      end
    end
  end
  self:sortMail(res)
  return res
end

function this:getCollectedMail(allMails)
  local res = {}
  allMails = allMails or L_MailStore:getAllMailInfo()
  for _, mail in pairs(allMails) do
    if mail.collect then
      table.insert(res, mail)
    end
  end
  self:sortMail(res)
  return res
end

function this:sortMail(mails)
  for _, mail in ipairs(mails) do
    mail.weight = 0
    if not mail.read then
      mail.weight = mail.weight + 200000000
    elseif mail.reward and mail.reward.rewards and not mail.fetch then
      mail.weight = mail.weight + 200000000
    end
    if mail.collect then
      mail.weight = mail.weight + 100000000
    end
  end
  table.sort(mails, function(a, b)
    if a.weight == b.weight then
      return a.createtm > b.createtm
    end
    return a.weight > b.weight
  end)
end

function this:checkMailEffectValid(mail)
  if mail.effecttm == 0 then
    return true
  end
  if mail.collect then
    return true
  end
  local endTime = mail.effecttm + mail.createtm
  local now = L_TimeUtil.getServerTime()
  local leftTime = endTime - now
  return 0 < leftTime
end

function this:checkMailEffectValidAndRefresh(mailGuid, callback)
  local mail = L_MailStore:getMail(mailGuid)
  local isValid = self:checkMailEffectValid(mail)
  if not isValid then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_mial_pass_play"))
    if callback then
      callback()
    end
  end
  return isValid
end

function this:isMailHasRed(mail)
  if not self:checkMailEffectValid(mail) then
    return false
  end
  local red = not mail.read
  if not red then
    local reward
    if mail.reward and mail.reward.rewards then
      reward = mail.reward.rewards[1]
    end
    if reward ~= nil then
      red = not mail.fetch
    end
  end
  return red
end

return this
