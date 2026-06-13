local M = BaseClass("LimiteChallgeStageUIContext",BaseContext)

function M:Open()
    LimitDataMgr:GetInstance():GetLimitChallgeData(Bind(self,self._OnGetLimitData))
end

function M:_OnGetLimitData(data)
    if data == nil then 
        return
    end
    self:_Show(data)
    if LimitDataMgr:GetInstance():CheckBreakSkillUI() then 
        UIContextMgr:GetInstance():Show("LimitBreakLimitSkill",data)
    end
end

return M