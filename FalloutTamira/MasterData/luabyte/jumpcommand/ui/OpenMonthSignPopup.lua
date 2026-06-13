-- 月签到弹出
local M = BaseClass("OpenMonthSignPopup", BaseJumpCommand)
local EActivityId = EnumConst.EActivityId

function M:Execute()
    if IGuideMgr.IsGuiding then
        CommandMgr:GetInstance():FinishExcute()
        return
    end
    local module = ModuleMgr:GetInstance():GetCurrentModule()
    if module.moduleId ~= ModuleConfig.MainSceneModule.id then
        self:_OnClosePopup()
        return
    end
    local openConditionMonthSign = ConfigHelper.GetCfgPropByLua("functionOpen", 21, "openCondition")
    local isUnlockMonthSign = JumpMgr:GetInstance():CheckLockByOpenConditionIds(openConditionMonthSign)
    if not isUnlockMonthSign then
        self:_OnClosePopup()
        return
    end
    local cycleData = CycleDataMgr:GetInstance():GetCycleDataByType(protocol.ECycleEvent.ECET_Award_Sign)
    if cycleData:IsSigned() then
        self:_OnClosePopup()
        return
    else
        UIContextMgr:GetInstance():Show(UIDefine.UIActivity, EActivityId.MonthSign, Bind(self, self._OnClosePopup))
    end
end

function M:_OnClosePopup()
    CommandMgr:GetInstance():FinishExcute()
end

return M
