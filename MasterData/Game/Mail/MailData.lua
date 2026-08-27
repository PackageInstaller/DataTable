local MailData = class("MailData")
local MailEnum = require("Game.Mail.MailEnum")
local MailParamKey = {
  keyNone = 0,
  keyLotteryPoolName = 1,
  keyGiftGroupName = 2,
  keyPayProductId = 3,
  keyTimestamp1 = 4,
  keyHeroId = 5,
  keySaveMoneyStage = 6,
  keySaveMoneyLevel = 7,
  KeyPercentReward = 8
}

function MailData.CreateMailData(mailDataMsg)
  local mailData = MailData.New()
  mailData:InitMailData(mailDataMsg)
  return mailData
end

function MailData:ctor()
  self.uid = nil
  self.info = nil
  self.att = nil
  self.expiredTm = nil
  self.status = nil
  self.isSelected = false
  self.isDeleted = false
  self.attReceived = nil
  self._couldShow = true
end

function MailData:InitMailData(mailData)
  self.uid = mailData.uid
  self.info = mailData.info
  self.att = mailData.att
  self.expiredTm = mailData.expiredTm
  self.status = mailData.status
  self.isTreasure = mailData.favorite
  self:DealAttReceived()
  self:DealSpecailParam()
  self:UpdateCouldShow()
end

function MailData:GetIsTreasure()
  return self.isTreasure
end

function MailData:GetState()
  return self.status
end

function MailData:IsHaveAtt()
  if self.att ~= nil and self.att.data ~= nil then
    if table.count(self.att.data) == 0 then
      return false
    end
    return true, self.att.data, self:GetState() == MailEnum.eMailDetailType.Received, self.attReceived
  else
    return false
  end
end

function MailData:GetIsPicked()
  return self:GetState() == MailEnum.eMailDetailType.Received
end

function MailData:GetTitle()
  if self.info ~= nil and self.info.title ~= nil then
    return self.info.title
  else
    error("Can't read mail title")
    return ""
  end
end

function MailData:GetMailEntryCode()
  return self.info.code
end

function MailData:GetSender()
  if self.info ~= nil and self.info.senderName ~= nil then
    return self.info.senderName
  else
    error("Can't read mail senderName")
    return ""
  end
end

function MailData:GetSenderPic()
  if self.info ~= nil and self.info.npcPicId ~= nil and ConfigData.banner_mail_npic[self.info.npcPicId] ~= nil then
    local mailNpicCfg = ConfigData.banner_mail_npic[self.info.npcPicId]
    return mailNpicCfg
  end
  return nil
end

function MailData:GetContent()
  if self.info ~= nil and self.info.content ~= nil then
    return self.info.content
  else
    error("Can't read mail content")
    return ""
  end
end

function MailData:GetTime(needRaw)
  if self.info ~= nil and self.info.created ~= nil then
    if needRaw then
      return self.info.created
    end
    if self.info.YMD == nil or self.info.HM == nil then
      local dataTable = TimeUtil:TimestampToDate(self.info.created, nil, true)
      local YMD = string.format("%d/%02d/%02d", dataTable.year, dataTable.month, dataTable.day)
      local HM = string.format("%02d:%02d", dataTable.hour, dataTable.min)
      self.info.YMD = YMD
      self.info.HM = HM
    end
    return self.info.YMD, self.info.HM
  else
    error("Can't read mail created tiemStamp")
    return
  end
end

function MailData:GetTimeBeforeExpired()
  return math.ceil(math.max(self.expiredTm - PlayerDataCenter.timestamp, 0))
end

function MailData:IsSignInRewardMail()
  local mailCfg = ConfigData.mail[self.info.code]
  if mailCfg == nil then
    return false
  end
  return mailCfg.type == MailEnum.eMailType.SigninReward
end

function MailData:IsSignInMonthCardReward()
  local mailCfg = ConfigData.mail[self.info.code]
  if mailCfg == nil then
    return false
  end
  return mailCfg.entry == 115
end

function MailData:UpdateCouldShow()
  if self:IsSignInRewardMail() then
    self._couldShow = false
  end
end

function MailData:GetCouldShow()
  return self._couldShow
end

function MailData:Update(mailData)
  self.uid = mailData.uid
  self.info = mailData.info
  self.att = mailData.att
  self.expiredTm = mailData.expiredTm
  self.status = mailData.status
  self.isTreasure = mailData.favorite
  self:DealAttReceived()
  self:DealSpecailParam()
  self:UpdateCouldShow()
end

function MailData:DealAttReceived()
  self.attReceived = {}
  if self.att == nil then
    return
  end
  for i, v in pairs(self.att.received) do
    self.attReceived[v] = true
  end
end

function MailData:DealSpecailParam()
  if self.info.titleParams ~= nil and #self.info.titleParams > 0 then
    local paramsList = self:__DealSpecailParam_Local(self.info.titleParams)
    self.info.title = string.format(self.info.title, table.unpack(paramsList))
  end
  if self.info.contentParams ~= nil and 0 < #self.info.contentParams then
    local paramsList = self:__DealSpecailParam_Local(self.info.contentParams)
    self.info.content = string.format(self.info.content, table.unpack(paramsList))
  end
end

function MailData:__DealSpecailParam_Local(params)
  local list = {}
  for i = 1, #params do
    local temp = params[i]
    local value
    if temp.cat == MailParamKey.keyLotteryPoolName then
      value = LanguageUtil.GetLocaleText(ConfigData.lottery_para[temp.value].name)
    elseif temp.cat == MailParamKey.keyGiftGroupName then
      value = LanguageUtil.GetLocaleText(ConfigData.pay_gift_type[temp.value].name)
    elseif temp.cat == MailParamKey.keyPayProductId then
      value = LanguageUtil.GetLocaleText(ConfigData.pay_product[temp.value].name)
    elseif temp.cat == MailParamKey.keyTimestamp1 then
      local dateData = TimeUtil:TimestampToDate(temp.value, nil, true)
      local originalStr = LanguageUtil.GetLocaleText(ConfigData:GetTipContent(TipContent.MailDataInfo))
      value = string.gsub(originalStr, "%$(%w+)", dateData)
    elseif temp.cat == MailParamKey.keyHeroId then
      value = LanguageUtil.GetLocaleText(ConfigData.hero_data[temp.value].name)
    elseif temp.cat == MailParamKey.keySaveMoneyStage then
      value = tostring(temp.value)
    elseif temp.cat == MailParamKey.keySaveMoneyLevel then
      local actId = temp.value // 1000
      local stageId = temp.value % 1000
      value = LanguageUtil.GetLocaleText(ConfigData.activity_saveMoney_save[actId][stageId].level_name)
    else
      value = tostring(temp.value)
    end
    table.insert(list, value)
  end
  return list
end

function MailData:GetExtraParams()
  return self.info.extraParams
end

function MailData:Delete()
  self.isDeleted = true
end

return MailData
