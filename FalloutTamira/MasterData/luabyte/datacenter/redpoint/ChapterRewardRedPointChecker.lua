local M = BaseClass("ChapterRewardRedPointChecker", require("DataCenter.RedPoint.BaseRedPointChecker"))

function M:__init()
    self.m_chapterId = 0
    self.m_loadChapter = Bind(self, self.OnLoadChapter)
end

function M:Check(param)
    self.checkResult = 0
    if not self:OnChanged() then return end

    self.m_chapterId = param
    MissionDataMgr:GetInstance():LoadChapter(0,self.m_loadChapter)
end

function M:OnLoadChapter()
    local hasAward = MissionDataMgr:GetInstance():IsRoleChapterReward(self.m_chapterId)
    self.checkResult = hasAward and 1 or 0
end

return M
