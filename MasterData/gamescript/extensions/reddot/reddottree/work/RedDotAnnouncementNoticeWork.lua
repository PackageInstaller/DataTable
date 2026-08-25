local RedDotAnnouncementNoticeWork, Super = System.NewClass("RedDotAnnouncementNoticeWork", RedDotSingleFlow)

function RedDotAnnouncementNoticeWork:ctor(args)
  Super.ctor(self, "公告列表项红点")
  self.uid = args and args.uid
end

function RedDotAnnouncementNoticeWork:Execute()
  if not self.uid then
    return false
  end
  local redData = AnnouncementRedUtils.GetNoticeRedData(self.uid)
  local state = RedPointDataUtils.ShowRedPointState(redData)
  if state == RedPointDataUtils.RedAttrType.IsNew then
    return RedDotDefine.RedDotType.New
  elseif state == RedPointDataUtils.RedAttrType.Red then
    return RedDotDefine.RedDotType.Red
  elseif state then
    return RedDotDefine.RedDotType.Red
  end
  return false
end

return RedDotAnnouncementNoticeWork
