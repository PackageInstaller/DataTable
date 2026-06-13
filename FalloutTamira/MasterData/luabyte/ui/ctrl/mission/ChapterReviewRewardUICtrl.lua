local M = BaseClass("ChapterReviewRewardUICtrl", BaseUICtrl)
local MissionDataMgr = MissionDataMgr:GetInstance()

function M:Init()
    self.m_needNum = 0
    self.m_chapterId = 0
    self._view.closeBtn:onClick(Bind(self, self.Close))
    self._view.getBtn:onClick(Bind(self, self.OnClickChapterAward))
end

function M:OnEnter(chapter)
    self.m_chapterId = chapter.id
    self.m_needNum = chapter.stages.Length
    local desHead = ConfigHelper.GetLocalString(chapter.rewardDes[0])
    local desTail = ConfigHelper.GetLocalString(chapter.rewardDes[1])
    self._view.title:SetText(desHead .. desTail)
    for i = 0, chapter.stages.Length - 1, 1 do
        local missionId = chapter.stages[i]
        local md = MissionDataMgr:GetMissionDataById(missionId)
        if md and md:IsPass() then self.m_needNum = self.m_needNum - 1 end
    end

    if self.m_needNum <= 0 then
        self._view.tips:SetActive(false)
        self._view.getBtn:SetActive(true)
        self._view.recivedTag:SetActive(false)
    else
        local fmtStr = ConfigHelper.GetLocalString(4155) --"再通%s关就可领取奖励了哦！"
        local tipStr = string.format(fmtStr, self.m_needNum)
        self._view.tips:SetText(tipStr)
        self._view.recivedTag:SetActive(false)
        self._view.getBtn:SetActive(false)
        self._view.tips:SetActive(true)
    end

    -- 可能数据为收到，则需要额外处理
    local roleChapter = MissionDataMgr:GetRoleChapter(chapter.id) -- 0:没领 1：领过
    if (roleChapter and roleChapter.Status or 0) > 0 then
        self._view.tips:SetActive(false)
        self._view.getBtn:SetActive(false)
        self._view.recivedTag:SetActive(true)
    end
    local itemGroup = ConfigHelper.GetCfg("itemGroup", chapter.chapterReward)
    self:_RefreshRewards(itemGroup)
end

--点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true 
end

function M:OnClickChapterAward(go)
    local handler = Bind(self, self.OnShowChapterAward)
    local request = { ChapterId = self.m_chapterId, Idx = 255 }
    MissionDataMgr:GetChapterAward(request, handler)
end

function M:OnShowChapterAward(msg)
    local items = {}
    for _, item in ipairs(msg.Awards) do items[item.Id] = item.Cnt end
    GameHelper.ShowGetItems(items)
    self._view.tips:SetActive(false)
    self._view.getBtn:SetActive(false)
    self._view.recivedTag:SetActive(true)
    self:Close()
end

function M:_RefreshRewards(itemGroup)
    if not itemGroup or not itemGroup.items then return end
    local numType = ItemNumberType.TOTLE
    for i = 1, #itemGroup.items do
        local item = self._view.itemPfb:Instantiate()
        item:SetInfo(itemGroup.items[i], numType, itemGroup.cnts[i])
        item:EnablePopItem(true)
        item:SetActive(true)
    end
end

return M
