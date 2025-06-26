module("purchase.GrowthFundManager", Class.impl(Manager))

--构造函数
function ctor(self)
    super.ctor(self)
    self:__init()
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

function __init(self)
    --成长基金任务列表
    self.mGrowthFundList = {}
    --已领取成长基金列表-普通
    self.mGrowthFundedNList = nil
    --已领取成长基金列表-高级
    self.mGrowthFundedSList = {}
    --是否解锁高级基金
    self.mIsGrowthFundMoney = false
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 解析服务器已领取基金列表
function parseGrowthFundInfoMsg(self, msg)
    if msg then
        self.mGrowthFundedNList = {}
        self.mGrowthFundedSList = {}
        for i, id in ipairs(msg.gained_primary_fund_list) do
            if (not table.indexof(self.mGrowthFundedNList, id)) then
                table.insert(self.mGrowthFundedNList, id)
            end
        end
        for i, id in ipairs(msg.gained_senior_fund_list) do
            if (not table.indexof(self.mGrowthFundedSList, id)) then
                table.insert(self.mGrowthFundedSList, id)
            end
        end
        if not self.mIsGrowthFundMoney then
            self.mIsGrowthFundMoney = msg.whether_unlock_senior_fund > 0 and true or false
        end
        GameDispatcher:dispatchEvent(EventName.UPDATE_GROWTH_FUND)
        self:updateBublle()
    end
end

-- 解析服务器已领取基金
function parseReciveGrowthFundMsg(self, msg)
    if msg.result == 1 then
        if msg.fund_type == 1 then
            if (not table.indexof(self.mGrowthFundedNList, msg.fund_id)) then
                table.insert(self.mGrowthFundedNList, msg.fund_id)
            end
        else
            if (not table.indexof(self.mGrowthFundedSList, msg.fund_id)) then
                table.insert(self.mGrowthFundedSList, msg.fund_id)
            end
        end
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_GROWTH_FUND_ITEM, msg.id)
    self:updateBublle()
end

-- 解析皮肤商品列表
function parseGrowthFundData(self)
    self.mGrowthFundList = {}
    local baseData = RefMgr:getData("fund_data")
    for key, data in pairs(baseData) do
        local vo = purchase.GrowthFundVo.new()
        vo:parseMsg(key, data)
        table.insert(self.mGrowthFundList, vo)
    end
    table.sort(self.mGrowthFundList, function(a, b)
        return a:getSort() < b:getSort()
    end)
end

-- 获取成长基金列表
function getGrowthFundList(self)
    if #self.mGrowthFundList <= 0 then
        self:parseGrowthFundData()
    end
    table.sort(self.mGrowthFundList, function(a, b)
        return a:getSort() < b:getSort()
    end)
    return self.mGrowthFundList
end

-- 获取可领取数量
function getGrowthFundCanReciveNum(self)
    if #self.mGrowthFundList <= 0 then
        self:parseGrowthFundData()
    end
    local canRecNum = 0
    for i, fundVo in ipairs(self.mGrowthFundList) do
        if (fundVo:getIsUnLock()) then
            if (not fundVo:getIsReceiveNomalAward()) then
                canRecNum = canRecNum + 1
            end
            if (not fundVo:getIsReceiveMoneyAward() and fundVo:getIsBuy()) then
                canRecNum = canRecNum + 1
            end
        end
    end
    return canRecNum
end

function getCurReciveIndex(self)
    if #self.mGrowthFundList <= 0 then
        self:parseGrowthFundData()
    end
    for index, fundVo in ipairs(self.mGrowthFundList) do
        if (fundVo:getIsUnLock()) then
            if ((not fundVo:getIsReceiveNomalAward()) or (not fundVo:getIsReceiveMoneyAward() and fundVo:getIsBuy())) then
                return (index - 1)
            end
        end
    end
    return 0
end

-- 获取是否解锁高级基金
function getIsGrowthFundMoney(self)
    return self.mIsGrowthFundMoney or false
end

-- 获取是否已全部领取完毕
function getIsGrowthFundOver(self)
    if #self.mGrowthFundList <= 0 then
        self:parseGrowthFundData()
    end
    for _, fundVo in ipairs(self.mGrowthFundList) do
        if (self.mGrowthFundedNList and ((not table.indexof(self.mGrowthFundedNList, fundVo.sort)) or (not table.indexof(self.mGrowthFundedSList, fundVo.sort)))) then
            return false
        end
    end
    return true
end

-- 显示状态（主UI使用）
function checkShowState(self)
    local isOpen = funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_GROWTHFUND)
    if not isOpen then
        return false
    end

    if self:getIsGrowthFundOver() then
        return false
    end

    return true
end

-- 获取高级奖励列表
function getGrowthFundedSList(self)
    return self.mGrowthFundedSList or {}
end

-- 获取普通奖励列表
function getGrowthFundedNList(self)
    return self.mGrowthFundedNList or {}
end
function updateRed(self)
    return self:getGrowthFundCanReciveNum() >= 1
end

--更新红点
function updateBublle(self)
    local flag = self:getGrowthFundCanReciveNum() >= 1
    GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_RED)
    if self:getIsGrowthFundOver() then
        GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_HIDE, activity.ActivityConst.ACTIVITY_GROUTHFUND)
    end
end

--析构函数
function dtor(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]