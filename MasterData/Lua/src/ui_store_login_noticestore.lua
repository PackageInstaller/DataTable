local cls = class("noticeStore", G_BaseStore)
local tag = cls:getName()
local SaveKey_NoticeReadMarks = "[noticeStore]NoticeReadMarks"
cls:importPartialClass(require("ui.store.login.noticeState"))
require("ui.manager.login.loginConst")
cls.EventKey = {
  onUpdateNotice = "onUpdateNotice",
  onReadNotice = "onReadNotice"
}

function cls:_initNoticeReadMarks()
  table.clear(self.data.noticeReadMarks)
  local save = C_PlayerPrefsUtility.GetString(SaveKey_NoticeReadMarks, nil)
  if string.isEmpty(save) then
    return
  end
  local splitArr = string.split(save, "|")
  if splitArr then
    for i, v in ipairs(splitArr) do
      local id = tonumber(v)
      if id then
        self.data.noticeReadMarks[id] = true
      end
    end
  end
end

function cls:setNotice(id, notice)
  if id then
    self.data.notices[id] = notice
  end
end

function cls:clearNotices()
  table.clear(self.data.notices)
end

function cls:setNoticeReadMark(id, isRead, save)
  if id == nil then
    return
  end
  local curMark = self.data.noticeReadMarks[id]
  local tarMark
  if isRead then
    tarMark = true
  else
    tarMark = nil
  end
  if curMark ~= tarMark then
    self.data.noticeReadMarks[id] = tarMark
    self:call(self.EventKey.onReadNotice, id)
    if save then
      self:saveNoticeReadMarks()
    end
  end
end

function cls:syncNotices(data)
  self:clearNotices()
  if data then
    for i, v in ipairs(data) do
      self:setNotice(v.id, v)
    end
  end
  self:call(self.EventKey.onUpdateNotice)
end

function cls:removeExpiredReadMarks()
  for k, v in pairs(self.data.noticeReadMarks) do
    if self.data.notices[k] == nil then
      self.data.noticeReadMarks[k] = nil
    end
  end
end

function cls:saveNoticeReadMarks()
  self:removeExpiredReadMarks()
  local save = ""
  for k, v in pairs(self.data.noticeReadMarks) do
    if save ~= "" then
      save = save .. "|"
    end
    save = save .. tostring(k)
  end
  C_PlayerPrefsUtility.SetString(SaveKey_NoticeReadMarks, save)
end

return cls
