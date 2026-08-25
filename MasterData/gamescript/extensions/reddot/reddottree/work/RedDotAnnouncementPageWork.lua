local RedDotAnnouncementPageWork, Super = System.NewClass("RedDotAnnouncementPageWork", RedDotSingleFlow)

function RedDotAnnouncementPageWork:ctor(args)
  Super.ctor(self, "公告页签红点")
  self.page = args and args.page
end

function RedDotAnnouncementPageWork:Execute()
  if not self.page then
    return false
  end
  local redData = AnnouncementRedUtils.GetNoticePageRedData(self.page)
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

return RedDotAnnouncementPageWork
