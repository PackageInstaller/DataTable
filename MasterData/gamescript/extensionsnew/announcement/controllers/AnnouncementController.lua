local AnnouncementController = NewClass("AnnouncementController", BaseController)

function AnnouncementController:MarkAnnRead(data)
  if not data or not data.new then
    return
  end
  SdkMgr.Instance:RemoveNoticeRed(data.annType, data.uid, function()
    AnnouncementRedUtils.RemoveRedData(data)
    AnnouncementModel.Instance:Notify(NotifyId.OnAnnouncementRedDataChanged)
  end)
end

function AnnouncementController:MarkAllRead()
  local curAnns = AnnouncementModel.Instance:GetCurAnns()
  if not curAnns then
    return
  end
  for _, data in ipairs(curAnns) do
    if data.new then
      SdkMgr.Instance:RemoveNoticeRed(data.annType, data.uid, function()
        AnnouncementRedUtils.RemoveRedData(data)
        AnnouncementModel.Instance:Notify(NotifyId.OnAnnouncementRedDataChanged)
      end)
    end
  end
end

return AnnouncementController
