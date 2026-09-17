local cls = {}

function cls:state()
  return {}
end

function cls:init()
  cls.super.init(self)
  self.data = {
    notices = {},
    noticeReadMarks = {},
    noticeListMap = {}
  }
  self:_initNoticeReadMarks()
end

function cls:getNoticeListByType(type)
  local list = {}
  for k, v in pairs(self.data.notices) do
    if type == nil or v.type == type then
      table.insert(list, v)
    end
  end
  table.sort(list, cls._noticeSorter)
  return list
end

function cls._noticeSorter(a, b)
  return a.sorts < b.sorts
end

function cls:getLoginNotice()
  for k, v in pairs(self.data.notices) do
    if v.type == "login" then
      return v
    end
  end
  return nil
end

function cls:getNotice(noticeId)
  return self.data.notices[noticeId]
end

function cls:getNotices()
  return self.data.notices
end

function cls:isNoticeRead(noticeId)
  return self.data.noticeReadMarks[noticeId] == true
end

return cls
