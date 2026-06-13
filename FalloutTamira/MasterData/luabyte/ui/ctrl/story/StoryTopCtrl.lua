local M = BaseClass("StoryTopCtrl", require("UI.Ctrl.Story.BaseStoryCtrl"))
local StoryMgr = StoryDataMgr:GetInstance()

function M:Init()
    local reviewCtrl = require("UI.Ctrl.Story.StoryReviewItemCtrl")
    local reviewView = require("UI.View.Story.StoryReviewItemView")
    self._view.scrollReview:Init(reviewCtrl, reviewView)
    self._view.rectSkip:onClick(Bind(self, self.OnSkipClick))
    self._view.stateAuto:onClick(Bind(self, self.OnAutoClick))
    self._view.stateFast:onClick(Bind(self, self.OnFastClick))
    self._view.rectReview:onClick(Bind(self, self.OnReviewClick))
    self._view.rectHideUI:onClick(Bind(self, self.OnHideUIClick))
    self._view.rectReviewBack:onClick(Bind(self, self.OnReviewBackClick))
    self._view.rectFastMultipler:onClick(Bind(self, self.OnFastMultiplerClick))
    self._view.scrollReview:SetCreateItemCallback(Bind(self, self.OnCreateItem))

    self._view.stateAuto:SetState(1)
    self._view.stateFast:SetState(1)
end

function M:RefreshTopBarVisible(storyCfg)
    local storyType, cmderType = storyCfg.storyType, storyCfg.commanderType
    local EStoryType, ERspType = StoryConst.StoryType, StoryConst.ResponseType
    -- 鹏：storyType=1，且commanderType不为空时关闭
    local isDialogue = (storyType == EStoryType.Dialogue) and (cmderType ~= ERspType.None) or false
    if isDialogue or (storyType == EStoryType.Video) or (storyType == EStoryType.Background) or
        not string.isNullOrEmpty(storyCfg.spinePath) or (cmderType == ERspType.Video)
    then
        StoryHelper.SetActive(self._view.rectTopBarPanel, false)
    else
        StoryHelper.SetActive(self._view.rectTopBarPanel, true)
        self._view.rectSkip:SetActive(storyCfg.canSkip == 1)
    end

    if StoryMgr:IsGuide() then self:_StopAtutoAndFast() end
end

function M:OnCreateItem(item)
    item.onClickTextCallback = Bind(self, self.OnClickText)
end

function M:OnClickText(titleId, content, centerX, centerY)
    self._view.tips:Show(titleId, content, centerX, centerY)
end

function M:OnAutoClick()
    self:StopFastState()

    if not self:StopAutoState() then
        self._view.stateAuto:SetState(2)
        StoryMgr:StartAuto()
    end
end

function M:OnFastClick()
    self:StopAutoState()

    if not self:StopFastState() then
        self._view.stateFast:SetState(2)
        StoryMgr:StartFast()
        self._view.txtFastSpeed:SetText(StoryMgr:GetFastSpeedMultiplier() .. "x")
    end
end

function M:OnFastMultiplerClick()
    self._view.txtFastSpeed:SetText(StoryMgr:SetFastSpeedMultiplier() .. "x")
end

function M:OnSkipClick()
    self:_StopAtutoAndFast()
    -- StoryHelper.SetActive(self._view.rectTopBarPanel, false)
    -- UIContextMgr:GetInstance():Show("StorySkip", function()
    --     StoryHelper.SetActive(self._view.rectTopBarPanel, true)
    -- end)
    -- GZ-7614 剧情-跳过二次确认功能暂时隐藏
    StoryMgr:SkipStory()
end

function M:OnReviewClick()
    self:_StopAtutoAndFast()
    StoryHelper.SetActive(self._view.rectReviewPanel, true)

    local reviewData = StoryMgr:GetReviewStories()
    local dataList = self._view.scrollReview:GetDataList()
    if table.isNullOrEmpty(dataList) then
        self._view.scrollReview:SetDataList(reviewData)
    else
        self._view.scrollReview:UpdateList(reviewData)
        self._view.scrollReview:MovePanelToItemIndex(#reviewData)
    end
end

function M:OnReviewBackClick()
    StoryHelper.SetActive(self._view.rectReviewPanel, false)
end

function M:OnHideUIClick()
    self:_StopAtutoAndFast()
    StoryHelper.SetActive(self._view.rectTopBarPanel, false)
    EventMgr:Broadcast(UIMessageNames.STORY_CALL_MAIN, "SetNextDialogueActive", false)
    EventMgr:Broadcast(UIMessageNames.STORY_CALL_MAIN, "SetNextSamActive", false)
end

function M:_StopAtutoAndFast()
    self._view.stateAuto:SetState(1)
    self._view.stateFast:SetState(1)
    StoryMgr:StopAuto()
    StoryMgr:StopFast()
end

function M:StopAutoState()
    if StoryMgr:IsAuto() then
        self._view.stateAuto:SetState(1)
        StoryMgr:StopAuto()
        return true
    end
    return false
end

function M:StopFastState()
    if StoryMgr:IsFast() then
        self._view.stateFast:SetState(1)
        StoryMgr:StopFast()
        return true
    end
    return false
end

function M:GetHideBtnState()
    return self._view.rectHideUI:IsActiveInHierarchy()
end

return M
