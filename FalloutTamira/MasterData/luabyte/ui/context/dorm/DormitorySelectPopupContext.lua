local DormitorySelectPopupContext = BaseClass("DormitorySelectPopupContext", BaseContext)
local M = DormitorySelectPopupContext

function M:__init()
end

function M:_Destory()
    M.super._Destory(self)
end

function M:Open()
    DormDailyGolasDataMgr:GetInstance():GetActivityData(Bind(self, self.LoadActivityCallBack))
end

function M:LoadActivityCallBack(...)
    self:_Show()
end

return DormitorySelectPopupContext
