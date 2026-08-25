local AnnouncementModel = NewClass("AnnouncementModel", BaseModel)
local INTERVAL = 20

function AnnouncementModel:OnInit()
end

function AnnouncementModel:OnReset()
  self._page = nil
  self._curLoadAnnCnt = INTERVAL
  self._annMap = nil
  self._annListMap = nil
  self._currUid = nil
  self._contentHeights = nil
end

function AnnouncementModel:InitData(annMap)
  self._annMap = annMap
  self._curLoadAnnCnt = INTERVAL
  self._currUid = nil
  self._annListMap = nil
  self._contentHeights = nil
end

function AnnouncementModel:GetPage()
  return self._page
end

function AnnouncementModel:SetPage(page)
  if not page or "" == page then
    return
  end
  self._page = page
  self._annListMap = nil
  self:Notify(NotifyId.OnAnnouncementPageChanged)
end

function AnnouncementModel:GetCurrUid()
  return self._currUid
end

function AnnouncementModel:SetCurUid(uid, scrollToTop)
  if not uid or "" == uid then
    return
  end
  self._currUid = uid
  EventMgr.Instance.SelectAnnouncementEvent:Dispatch(uid, scrollToTop)
  self:Notify(NotifyId.OnAnnouncementCurUidChanged, uid)
end

function AnnouncementModel:ResetCurUid()
  self._currUid = nil
  self:Notify(NotifyId.OnAnnouncementCurUidChanged, nil)
end

function AnnouncementModel:GetCurLoadAnnCnt()
  return self._curLoadAnnCnt
end

function AnnouncementModel:AddLoadAnnCnt()
  local annListMap = self:GetAnnListMap()
  if not annListMap or not self._page then
    return
  end
  local pageList = annListMap[self._page]
  if pageList then
    self._curLoadAnnCnt = math.min(self._curLoadAnnCnt + INTERVAL, #pageList)
  end
end

function AnnouncementModel:ResetLoadAnnCnt()
  self._curLoadAnnCnt = INTERVAL
end

function AnnouncementModel:GetAnnListMap()
  if self._annListMap then
    return self._annListMap
  end
  if not self._annMap then
    return {}
  end
  local map = {}
  for _, data in pairs(self._annMap) do
    if data and data.page then
      if not map[data.page] then
        map[data.page] = {}
      end
      table.insert(map[data.page], data)
    end
  end
  for _, list in pairs(map) do
    if list and #list > 1 then
      table.sort(list, function(a, b)
        if a.important ~= b.important then
          return a.important > b.important
        end
        if a.order ~= b.order then
          return a.order < b.order
        end
        return a.uid < b.uid
      end)
      for idx, _ in ipairs(list) do
        self:SetAnnDataIndex(list[idx], idx)
      end
    end
  end
  self._annListMap = map
  return map
end

function AnnouncementModel:GetShowAnns()
  local annListMap = self:GetAnnListMap()
  if not self._page or not annListMap then
    return {}
  end
  local pageList = annListMap[self._page]
  if not pageList then
    return {}
  end
  if #pageList > self._curLoadAnnCnt then
    local result = {}
    for i = 1, self._curLoadAnnCnt do
      table.insert(result, pageList[i])
    end
    return result
  end
  return pageList
end

function AnnouncementModel:GetCurAnns()
  local annListMap = self:GetAnnListMap()
  if not self._page or not annListMap then
    return {}
  end
  return annListMap[self._page] or {}
end

function AnnouncementModel:GetAnnMap()
  return self._annMap
end

function AnnouncementModel:GetAnnData(uid)
  if not uid or not self._annMap then
    return
  end
  return self._annMap[uid]
end

function AnnouncementModel:SetAnnDataIndex(annData, index)
  if not annData or not index then
    return
  end
  annData.index = index
end

function AnnouncementModel:GetContentHeights(uid)
  if not uid then
    return nil
  end
  if not self._contentHeights then
    self._contentHeights = {}
  end
  return self._contentHeights[uid]
end

function AnnouncementModel:CacheContentHeights(uid, heights)
  if not uid or not heights then
    return
  end
  if not self._contentHeights then
    self._contentHeights = {}
  end
  self._contentHeights[uid] = heights
end

function AnnouncementModel:InitDefaultSelection()
  local showAnns = self:GetShowAnns()
  if not showAnns or #showAnns <= 0 then
    self:ResetCurUid()
    return
  end
  local data = showAnns[1]
  for _, annData in ipairs(showAnns) do
    if annData and annData.isForcePopup and annData.new then
      data = annData
      break
    end
  end
  if data then
    self:SetCurUid(data.uid, true)
  else
    self:ResetCurUid()
  end
end

return AnnouncementModel
