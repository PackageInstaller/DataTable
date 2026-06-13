local StorySkipUICtrl = BaseClass("StorySkipUICtrl", BaseUICtrl)
local M = StorySkipUICtrl

function M:Init()
    self._view.rectConfirm:onClick(Bind(self, self.OnConfirmClick))
    self._view.rectCancel:onClick(Bind(self, self.OnCancelClick))

    self._closeCallback = nil
end

function M:OnDispose()
    self._closeCallback = nil
    M.super.OnDispose(self)
end

function M:OnEnter(callback)
    self._closeCallback = callback
    self:_InitData()
end

function M:_InitData()
    local storyCfg = StoryDataMgr:GetInstance():GetStory()
    local missionCfg = ConfigHelper.GetCfg("mission", storyCfg.missionId)
    if missionCfg then
        local groupId = storyCfg.groupId
        for i = 0, missionCfg.storyID.Length - 1 do
            if groupId == missionCfg.storyID[i] then
                local titleId = missionCfg.storyTitle[i]
                local descId = missionCfg.storyDesc[i]
                self._view.txtTitle:SetText(titleId)
                self._view.txtDesc:SetText(ConfigHelper.GetLocalStringByPlayerName(descId))
            end
        end
    else
        Logger.LogError("[story] mission is nil, id = " .. storyCfg.missionId)
    end
end

function M:OnConfirmClick()
    self:Close()
    StoryDataMgr:GetInstance():SkipStory()
end

function M:OnCancelClick()
    if self._closeCallback then
        self._closeCallback()
    end
    self:Close()
end

return StorySkipUICtrl
