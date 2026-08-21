module("purchase.GradeGiftManager", Class.impl(Manager))

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
    self.mGradeGiftRecedList = {}
    self.mGradeGiftList = {}
    self.mGradeGiftDic = {}
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 解析服务器面板信息
function parsePanelInfoMsg(self, msg)
    if msg then
        for _, id in ipairs(msg.gained_gift_list) do
            if (not table.indexof(self.mGradeGiftRecedList, id)) then
                table.insert(self.mGradeGiftRecedList, id)
            end
        end
    end
    self:updateBubble()
end
-- 解析等级礼包领取
function parseGradeGiftRecedMsg(self, msg)
    if msg.result == 1 then
        if (not table.indexof(self.mGradeGiftRecedList, msg.gift_id)) then
            table.insert(self.mGradeGiftRecedList, msg.gift_id)
        end
    end
    self:updateBubble()
end

function updateBubble(self)
    GameDispatcher:dispatchEvent(EventName.UPDATE_GRADE_GIFT)
    GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_RED)
    purchase.PurchaseManager:dispatchEvent(purchase.PurchaseManager.BUBBLE_CHANGE, purchase.PurchaseTab.GRADE_GIFT)
end

-- 解析等级礼包列表 1 普通礼包 2 付费礼包
function parseGradeGiftData(self)
    self.mGradeGiftList = {}
    self.mGradeGiftDic = {}
    local baseData = RefMgr:getData("level_gift_data")
    for key, data in pairs(baseData) do
        local vo = purchase.GradeGiftVo.new()
        vo:parseGradeGiftMsg(key, data)
        table.insert(self.mGradeGiftList, vo)
    end
    table.sort(self.mGradeGiftList, function(a, b)
        return a.sort < b.sort
    end)
    for _, giftVo in ipairs(self.mGradeGiftList) do
        if not self.mGradeGiftDic[giftVo:getGiftType()] then
            self.mGradeGiftDic[giftVo:getGiftType()] = {}
        end
        table.insert(self.mGradeGiftDic[giftVo:getGiftType()], giftVo)
    end
end
--获取当前类型奖励
function getGradeGiftVoByType(self, type)
    if #self.mGradeGiftList <= 0 then
        self:parseGradeGiftData()
    end
    if (self:getGradeGiftRecOverByType(type) == true) then
        return self:getGradeGiftOverVoByType(type)
    end
    for _, vo in ipairs(self.mGradeGiftDic[type]) do
        if type == vo:getGiftType() then
            if (#self:getGradeGiftRecedList() <= 0) or (not table.indexof(self:getGradeGiftRecedList(), vo.sort)) then
                return vo
            end
        end
    end
end

--获取当前类型列表
function getGradeGiftListByType(self, type)
    if #self.mGradeGiftList <= 0 then
        self:parseGradeGiftData()
    end
    return self.mGradeGiftDic[type]
end

--获取当前类型列表是否已领取完毕
function getGradeGiftRecOverByType(self, type)
    local endVo = self:getGradeGiftListByType(type)[#self:getGradeGiftListByType(type)]
    local isOver = (#self:getGradeGiftRecedList() > 0) and (table.indexof(self:getGradeGiftRecedList(), endVo.sort) ~= false) or false
    return isOver
end

--获取当前类型列表最后数据
function getGradeGiftOverVoByType(self, type)
    local tempVo = self:getGradeGiftListByType(type)[#self:getGradeGiftListByType(type)]
    return tempVo
end

--获取是否列表已全部领取
function getGradeGiftAllOver(self)
    local isAllOver = false
    for type = 1, 2 do
        isAllOver = self:getGradeGiftRecOverByType(type)
        if not isAllOver then
            return isAllOver
        end
    end
    return isAllOver
end

-- 获取当前数值
function getGradeGiftRecedList(self)
    return (#self.mGradeGiftRecedList > 0) and self.mGradeGiftRecedList or {}
end

-- 获取是否有红点
function getIsGradeGiftBubble(self)
    -- for type = 1, 2 do
    if self:getGradeGiftVoByType(1):getIsCanRec() and (not self:getGradeGiftVoByType(1):getIsReced()) then
        return true
    end
    -- end
    return false
end

-- 获取等级礼包列表
function getGradeGiftList(self)
    if #self.mGradeGiftList <= 0 then
        self:parseGradeGiftData()
    end
    return self.mGradeGiftList or {}
end

--析构函数
function dtor(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]