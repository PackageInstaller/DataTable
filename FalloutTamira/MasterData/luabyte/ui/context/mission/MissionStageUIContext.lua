local M = BaseClass("MissionStageUIContext", BaseContext)

function M:Open(chapter, missionId)
    local chapterId = 0
    missionId = missionId or 0
    local ctrl = self:GetCtrl()
    local cpt = ctrl and ctrl:CurChapter() or nil
    local topCmd = JumpMgr:GetInstance():GetTopBackCommand()
    if (missionId == 0) and cpt and (topCmd == "OpenChapterSelection") then chapter = cpt end
    if chapter and (chapter.type == ChapterConst.EChapterType.ECT_Activity) then
        chapterId = chapter.id -- 活动副本才需要动态加载
    end
    MissionDataMgr:GetInstance():LoadChapter(chapterId, function()
        self:_Show(chapter, missionId)
    end)
end

return M
