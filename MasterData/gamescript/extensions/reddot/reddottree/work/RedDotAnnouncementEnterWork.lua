local RedDotAnnouncementEnterWork, Super = System.NewClass("RedDotAnnouncementEnterWork", RedDotSingleFlow)

function RedDotAnnouncementEnterWork:ctor()
  Super.ctor(self, "公告入口红点")
end

function RedDotAnnouncementEnterWork:Execute()
  if AnnouncementRedUtils.GetEntranceRed() then
    return RedDotDefine.RedDotType.New
  end
  return false
end

return RedDotAnnouncementEnterWork
