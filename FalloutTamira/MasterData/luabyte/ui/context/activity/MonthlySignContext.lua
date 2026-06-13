local MonthlySignContext = BaseClass("MonthlySignContext", BaseContext)
local M = MonthlySignContext
local tSort = table.sort
local MessageId = Proto.MessageId

function M:Init()
end

function M:Open()
    if self:_InitData() then
        self:_Show(self.datas)
    end
end

-- 暴露给Ctrl需要的数据
function M:GetCurSignNum()
    return self.m_CurSignNum
end

-- 是否已签到
function M:IsSign()
    return self.m_IsSign
end

-- 客户端请求月度签到
function M:RequestMonthSign()
    self._tempResponseMonthSignCallback = NetPack:RegistResponse(MessageId.ResponseMonthSign, Bind(self, self._ResponseMonthSignCallback))
    NetPack:SendMessage(MessageId.RequestMonthSign, {})
end

-- 初始化配置，lPanelUICallback左面板回调，rPanelUICallback右边面板回调
function M:_InitData()
    self:_UpdateData()
    local nowTimer = TimeUtil.GetNowTimeStamp()
    local nowDate = TimeUtil.GetTimeByStamp(nowTimer - 18000)
    self.datas = {}
    local dailyBonuss = ConfigHelper.GetCfgsByLua("dailyBonus", {year=nowDate.year, month=nowDate.month})
    tSort(dailyBonuss, self._Sort)
    self.signNum = self.m_CycleData:GetSignNum()
    for i, dailyBonus in pairs(dailyBonuss) do
        local data = {}
        data.isSign = dailyBonus.days <= self.signNum
        data.dailyBonus = dailyBonus
        self.datas[i] = data
    end
    if table.count(dailyBonuss) == 0 then
        GameHelper.TipsById(27000318) -- 无效日期签到
        Logger.LogError("严重错误:dailyBonus表中无本月的数据,curYear:" .. nowDate.year .. ",curMonth:" .. nowDate.month)
        return
    end
    return true
end

function M._Sort(v1, v2)
    return v1.days < v2.days
end

-- 更新数据
function M:_UpdateData()
    self.m_CycleData = CycleDataMgr:GetInstance():GetCycleDataByType(protocol.ECycleEvent.ECET_Award_Sign)
    self.m_IsSign = self.m_CycleData:IsSigned()
    self.m_CurSignNum = self.m_IsSign and self.m_CycleData:GetSignNum() or self.m_CycleData:GetSignNum() + 1
end

-- 服务器返回的数据处理
function M:_ResponseMonthSignCallback(messageId, result, msg)
    NetPack:UnRegistResponse(MessageId.ResponseMonthSign, self._tempResponseMonthSignCallback)
    self._tempResponseMonthSignCallback = nil
    if result ~= 0 then
        UIContextMgr:GetInstance():GetContext(UIDefine.UIActivity):SetCanRecharge(true)
        return
    end

    self:_UpdateData()
    self:GetCtrl():RefSignSucces(msg.data, self.m_IsSign)

    RedPointMgr:ForceCheck(RedPointConst.MonthSignRedPointChecker)
end

function M:OnClose()
    M.super.OnClose(self)
end

function M:OnDispose()
    M.super.OnDispose(self)
end

return MonthlySignContext
