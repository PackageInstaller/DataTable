local AnnouncementRedUtils = {}
local SUB_RED_TYPE = RedTypeDefine.AnnouncementSubType

function AnnouncementRedUtils.CreateAnnRedByAnnInfo(info)
  if not info then
    return
  end
  local red = {
    isNew = info.new and 1 or 0
  }
  return red
end

function AnnouncementRedUtils.SetEntranceRed(new)
  local _isNew = new and 1 or 0
  if not DataCenter.redPointData[RedTypeDefine.RedType.AnnouncementEnter] then
    DataCenter.redPointData[RedTypeDefine.RedType.AnnouncementEnter] = {}
  end
  DataCenter.redPointData[RedTypeDefine.RedType.AnnouncementEnter].isNew = _isNew
end

function AnnouncementRedUtils.InitRed(data)
  if not data then
    return {}
  end
  local redMap = {}
  for _, v in pairs(SUB_RED_TYPE) do
    redMap[v] = {}
  end
  for page, annList in pairs(data) do
    if not redMap[SUB_RED_TYPE.PAGE][page] then
      redMap[SUB_RED_TYPE.PAGE][page] = 0
    end
    if annList then
      for _, annData in ipairs(annList) do
        if annData and annData.new then
          local redData = AnnouncementRedUtils.CreateAnnRedByAnnInfo(annData)
          redMap[SUB_RED_TYPE.UID][annData.uid] = redData
          redMap[SUB_RED_TYPE.PAGE][page] = redMap[SUB_RED_TYPE.PAGE][page] + 1
        end
      end
    end
  end
  DataCenter.redPointData[RedTypeDefine.RedType.Announcement] = redMap
end

function AnnouncementRedUtils.AddRedDataByInfo(info)
  if not info or not info.new then
    return
  end
  local redMap = DataCenter.redPointData[RedTypeDefine.RedType.Announcement]
  if not redMap then
    return
  end
  redMap[SUB_RED_TYPE.UID][info.uid] = AnnouncementRedUtils.CreateAnnRedByAnnInfo(info)
  redMap[SUB_RED_TYPE.PAGE][info.page] = redMap[SUB_RED_TYPE.PAGE][info.page] + 1
end

function AnnouncementRedUtils.RemoveRedData(info)
  if not info then
    return
  end
  local redMap = DataCenter.redPointData[RedTypeDefine.RedType.Announcement]
  if not redMap then
    return
  end
  info.new = false
  if redMap[SUB_RED_TYPE.UID][info.uid] then
    redMap[SUB_RED_TYPE.UID][info.uid] = nil
    redMap[SUB_RED_TYPE.PAGE][info.page] = redMap[SUB_RED_TYPE.PAGE][info.page] - 1
  end
  local hasRed = false
  for _, newCount in pairs(redMap[SUB_RED_TYPE.PAGE]) do
    if newCount > 0 then
      hasRed = true
      break
    end
  end
  if not hasRed then
    AnnouncementRedUtils.SetEntranceRed(false)
  end
end

function AnnouncementRedUtils.GetNoticeRedData(uid)
  if not uid then
    return
  end
  local redMap = DataCenter.redPointData[RedTypeDefine.RedType.Announcement]
  return redMap[SUB_RED_TYPE.UID][uid]
end

function AnnouncementRedUtils.GetNoticePageRedData(page)
  if not page then
    return
  end
  local redMap = DataCenter.redPointData[RedTypeDefine.RedType.Announcement]
  local newCount = redMap[SUB_RED_TYPE.PAGE][page]
  local _isNew = newCount and newCount > 0 and 1 or 0
  return {isNew = _isNew}
end

function AnnouncementRedUtils.GetEntranceRed()
  local enterRedData = DataCenter.redPointData[RedTypeDefine.RedType.AnnouncementEnter]
  return enterRedData and 1 == enterRedData.isNew
end

return AnnouncementRedUtils
