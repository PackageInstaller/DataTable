local RedDotGuideNoteSidebarWork, Super = System.NewPoolClass("RedDotGuideNoteSidebarWork", RedDotSingleFlow)

function RedDotGuideNoteSidebarWork:ctor(moduleType)
  Super.ctor(self, "密境手记侧栏页签")
  self.moduleType = moduleType
end

function RedDotGuideNoteSidebarWork:Execute()
  if not self.moduleType then
    return nil
  end
  if GuideNoteModel and GuideNoteModel.Instance and GuideNoteModel.Instance.RefreshSidebarRedDotMap then
    GuideNoteModel.Instance:RefreshSidebarRedDotMap()
  end
  if GuideNoteModel.Instance:ShouldShowSidebarRedDot(self.moduleType) then
    return RedDotDefine.RedDotType.Red
  end
  return nil
end

return RedDotGuideNoteSidebarWork
