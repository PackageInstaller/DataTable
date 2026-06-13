local FriendUIContext = BaseClass("FriendUIContext", BaseContext)
local M = FriendUIContext

function M:Init()
end

function M:Open()
    FriendDataMgr:GetInstance():SendRequsetMyUpHero(Bind(self, self.CallBack))
end

function M:CallBack()
    AchievementDataMgr:GetInstance():SendRequestAchievementShowInfo(Bind(self, self.AchievementCallBack))
end

function M:AchievementCallBack()
    self:_Show()
end

function M:AchievementGroupCallBack()
    self:_Show()
end

function M:OnClose()
    M.super.OnClose(self)
end

return FriendUIContext