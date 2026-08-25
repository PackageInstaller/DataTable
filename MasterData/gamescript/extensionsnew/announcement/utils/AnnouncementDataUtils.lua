local AnnouncementDataUtils = {}
AnnouncementDataUtils.VALUE_IMPORTANT = 1
AnnouncementDataUtils.VALUE_NOT_IMPORTANT = 0

function AnnouncementDataUtils._CreateAnnData(data)
  if not data then
    return
  end
  local importantValue = AnnouncementDataUtils.VALUE_NOT_IMPORTANT
  if data.value.important then
    importantValue = AnnouncementDataUtils.VALUE_IMPORTANT
  end
  local isForcePopup = data._badge_config and data._badge_config.is_force_popup
  return {
    uid = data._uuid,
    annType = data._type,
    title = data.value.title,
    content = data.value.content,
    new = not data.has_read,
    order = data.order,
    page = data.value.page,
    subTitle = data.value.subTitle,
    status = data.value.status,
    imagePath = data.value.imagePath,
    important = importantValue,
    isForcePopup = isForcePopup
  }
end

function AnnouncementDataUtils.HandleAnnDataByResponse(anns)
  if not anns then
    return
  end
  local map = {}
  for _, annData in pairs(anns) do
    if annData then
      local data = AnnouncementDataUtils._CreateAnnData(annData)
      if data then
        map[data.uid] = data
      end
    end
  end
  return map
end

function AnnouncementDataUtils.OpenAnnouncementPanel()
  SdkMgr.Instance:GetNotice("Normal", nil, nil, function(succ, anns, force_popup)
    local map = {}
    if succ then
      map = AnnouncementDataUtils.HandleAnnDataByResponse(anns)
    end
    UIManager.Instance:Reopen(Urls.AnnouncementPanel, map)
  end)
end

function AnnouncementDataUtils.CheckForcePopAnnouncement()
  SdkMgr.Instance:GetNotice("Normal", nil, nil, function(succ, anns, force_popup)
    if succ and anns and force_popup then
      local has_new = false
      for _, annData in ipairs(anns) do
        if annData.has_read == false then
          has_new = true
          break
        end
      end
      if has_new then
        local map = AnnouncementDataUtils.HandleAnnDataByResponse(anns)
        UIManager.Instance:Reopen(Urls.AnnouncementPanel, map)
      end
    end
  end)
end

return AnnouncementDataUtils
