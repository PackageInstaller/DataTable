--[[ 
-----------------------------------------------------
@filename       : ConvertManager
@Description    : 兑换数据中心
@date           : 2020-10-26 15:04:27
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
--
module('game.convert.manager.ConvertManager', Class.impl(Manager))
-- 兑换信息更新
CONVERT_INFO_UPDATE = "CONVERT_INFO_UPDATE"
-- 购买源晶辉锭更新
BUY_TITANITE_UPDATE = "BUY_TITANITE_UPDATE"

-- 构造
function ctor(self)
    super.ctor(self)
    self:__init()
end

-- 析构
function dtor(self)
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

-- 初始化
function __init(self)
    -- 已购买次数
    self.buyTimes = 0
    self.mConfig = {}
    -- 计步器下标
    self.mClickTimes = 1

    self.maxTimes = 0
end

-- 解析兑换数据
function parseConvertInfoMsg(self, msg)

    -- 已购买次数
    self.buyTimes = msg.buy_times
    self.maxTimes = self:getMaxBuyTimes()
    self.mClickTimes = 1
    self:dispatchEvent(convert.ConvertManager.CONVERT_INFO_UPDATE)
end

-- 判断购买状态
function showBuyWinStateTips(self, lastTime, curTime)
    if lastTime > 0 then
        if lastTime < curTime and self.maxTimes >= lastTime then
            gs.Message.Show("购买失败")
        else
            gs.Message.Show("购买成功")
        end
    end
end
-- 获取已购买次数
function getBuyTimes(self)
    if not self.mClickTimes then
        return 0
    end
    return self.mClickTimes + self.buyTimes
    -- + self.buyTimes
end
-- 获得刷新后的钱
function getFreshTiMoney(self)
    if #self.mConfig < 1 then
        self:parseConvertConfig()
    end
    if self.buyTimes > 0 and self.buyTimes < #self.mConfig then
        return self.mConfig[self.buyTimes + self.mClickTimes].titum, self.mConfig[self.buyTimes + self.mClickTimes].gold
    elseif self.buyTimes == 0 then
        return 0, 0
    elseif self.buyTimes == #self.mConfig then
        return self.mConfig[self.buyTimes].titum, self.mConfig[self.buyTimes].gold
    end
end
--------------------------------配置表 ----------------

-- 解析配置表数据
function parseConvertConfig(self)
    local baseData = RefMgr:getData("gold_exchange_data")
    for times, v in pairs(baseData) do
        local areaVo = { titum = v.pay, gold = v.stamina }
        self.mConfig[times] = areaVo
    end
end

function updateBuyTitum(self)
    convert.ConvertManager:dispatchEvent(convert.ConvertManager.BUY_TITANITE_UPDATE)
end
function getBuyConfigByTimes(self, times)
    if #self.mConfig < 1 then
        self:parseConvertConfig()
    end
    local ti, gold = 0, 0
    if self.buyTimes > 0 then
        for i = self.buyTimes + 1, times do
            if self.mConfig[i] ~= nil then
                ti = ti + self.mConfig[i].titum
                gold = gold + self.mConfig[i].gold
            end
        end
    else
        for i = 1, times do
            if self.mConfig[i] ~= nil then
                ti = ti + self.mConfig[i].titum
                gold = gold + self.mConfig[i].gold
            end
        end
    end

    return ti, gold
end

function getConfig(self)
    if #self.mConfig < 1 then
        self:parseConvertConfig()
    end
    return self.mConfig
end

function getMaxBuyTimes(self)
    if #self.mConfig < 1 then
        self:parseConvertConfig()
    end
    return #self.mConfig - self.buyTimes
end

function getCostNum(self)
    if #self.mConfig < 1 then
        self:parseConvertConfig()
    end
    if self.mClickTimes + self.buyTimes <= #self.mConfig then
        return self.mConfig[self.mClickTimes + self.buyTimes].titum
    end
end

function setClikTimes(self, t)
    self.mClickTimes = t
end

function resetClickTimes(self)
    self.mClickTimes = 1
end

function getLefTimes(self)
    return self.maxTimes - self.mClickTimes
end
---------------------------------------发送----
function sendMsg(self)
    GameDispatcher:dispatchEvent(EventName.REQ_CONVERT_GOIN, { buy_times = self.mClickTimes })
end

function sendBuyTitumMsg(self, num, aTid, bTid)
    GameDispatcher:dispatchEvent(EventName.REQ_CONVERT_TITANIUM, { num = num, aTid = aTid, bTid = bTid })
end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]