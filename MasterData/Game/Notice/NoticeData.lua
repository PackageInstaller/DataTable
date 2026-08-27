local NoticeData = class("NoticeData")

function NoticeData.CreateNoticeData(timeStamp, type, jumpInfo, noticeStrList, extraData)
  local NoticeData = NoticeData.New()
  NoticeData:InitNoticeData(timeStamp, type, jumpInfo, noticeStrList, extraData)
  return NoticeData
end

function NoticeData:ctor()
  self.timeStamp = 0
  self.timeStampOfShow = 0
  self.type = nil
  self.jumpInfo = nil
  self.noticeStrList = nil
  self.extraData = nil
  self.noticeCfg = nil
  self.noticeShowType = NoticeManager.eNoticeShowType.defualt
end

function NoticeData:InitNoticeData(timeStamp, type, jumpInfo, noticeStrList, extraData)
  self.timeStamp = timeStamp and math.floor(timeStamp) or PlayerDataCenter.timestamp
  self.type = type
  self.jumpInfo = jumpInfo
  self.noticeStrList = noticeStrList
  self.extraData = extraData
  self.noticeCfg = ConfigData.homeside_info[self.type]
  if self.noticeCfg == nil then
    error("can't read noticeCfg with typeId: " .. tostring(self.type))
  end
  self.noticeShowType = self.noticeCfg.type
end

function NoticeData:GetNoticeStr()
  if self.noticeStrList ~= nil then
    local ok, str = pcall(function()
      return string.format(LanguageUtil.GetLocaleText(self.noticeCfg.describe), table.unpack(self.noticeStrList))
    end)
    if ok then
      return str
    else
      error(tostring(self.noticeShowType) .. "type NoticeData's des is wrong with str=" .. LanguageUtil.GetLocaleText(self.noticeCfg.describe) .. " args=" .. tostring(serpent(self.noticeStrList)))
    end
  else
    return LanguageUtil.GetLocaleText(self.noticeCfg.describe)
  end
end

function NoticeData:GetNoticeTitle()
  return LanguageUtil.GetLocaleText(self.noticeCfg.title)
end

function NoticeData:GetIcon()
  return self.noticeCfg.icon
end

function NoticeData:GetNoticeIcon()
  return self.noticeCfg.icon
end

function NoticeData:IsNeedRedDot()
  return self.noticeCfg.is_reddot and self:GetIsPutInHomeside()
end

function NoticeData:GetIsMerge()
  return self.noticeCfg.is_merge
end

function NoticeData:GetIsPutInHomeside()
  return self.noticeCfg.put_in_homeside
end

function NoticeData.ValidNoticeDesStr(str, ...)
  if string.IsNullOrEmpty(str) then
    return false
  end
  local num = string.find(str, "%s")
  return true
end

return NoticeData
