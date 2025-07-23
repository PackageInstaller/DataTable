--[[ 
-----------------------------------------------------
@filename       : FirstChargeManager
@Description    : 首充
@date           : 2023-4-2 
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.firstCharge.manager.FirstChargeManager', Class.impl(Manager))

--构造
function ctor(self)
    super.ctor(self)
    self:__init()
end

--析构
function dtor(self)
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

function __init(self)
    self.mFirstChargeConfigDic = nil
    self.mFirstChargeConfigList = {}
    self.mFirstChargeMsgList = {}
    self.mFirstChargeMsgDic = {}
    self.mIsCharge = false
end

---------------------------------------------------------配置--------------------------------------------------------------
--获取迷你工厂信息
function parseFirstChargeDataConfigData(self)
    self.mFirstChargeConfigDic = {}
    self.mFirstChargeConfigList = {}
    local baseData = RefMgr:getData("first_charge_data")
    for daily, data in pairs(baseData) do
        local vo = firstCharge.FirstChargeVo.new()
        vo:parseData(daily, data)
        self.mFirstChargeConfigDic[daily] = vo
        table.insert(self.mFirstChargeConfigList, vo)
    end
    table.sort(self.mFirstChargeConfigList, function(vo1, vo2)
        return vo1.daily < vo2.daily
    end)
end

function parseFirstChargePanelMsg(self, msg)
    if msg then
        if not self.mFirstChargeMsgDic then
            self.mFirstChargeMsgDic = {}
        end
        for _, dayVo in pairs(msg.gain_state_list) do
            self.mFirstChargeMsgDic[dayVo.key] = dayVo.value
        end
        self:updateBubble()
    end
end
--是否已领取
function getIsRecivedByDay(self, daily)
    return (self:getDayState(daily) == 1) and true or false
end

function getDayState(self, daily)
    if not self.mFirstChargeMsgDic[daily] then
        return -1
    end
    return self.mFirstChargeMsgDic[daily]
end
--是否可领取
function getIsCanReciveByDay(self, daily)
    if (self:getIsReCharge()) and (self:getDayState(daily) == 0) then
        return true
    end
    return false
end

-- 是否领取完毕
function getIsReciveOver(self)
    local isOver = false
    local recNum = 0
    if self:getIsReCharge() then
        for _, chargeVo in ipairs(self:getFirstChargeList()) do
            if chargeVo:getIsRecived() then
                recNum = recNum + 1
            end
        end
    end
    isOver = recNum >= #self:getFirstChargeList()
    return isOver
end

-- 显示状态（主UI使用）
function checkShowState(self)
    local isOpen = funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_FIRSTCHARGE)
    if not isOpen then
        return false
    end

    if self:getIsReciveOver() then
        return false
    end

    return true
end

function updateBubble(self)
    local flag = self:updateRed()
    GameDispatcher:dispatchEvent(EventName.UPDATE_FIRSTCHARGE_PANEL)
    mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_FIRSTCHARGE, flag)
end

function updateRed(self)
    local flag = false
    for _, chargeVo in ipairs(self:getFirstChargeList()) do
        if chargeVo:getIsCanRecive() then
            flag = true
            break
        end
    end
    return flag
end


function getIsReCharge(self)
    return (self.mFirstChargeMsgDic[1] ~= nil)
end

function getItemVoByDaily(self, daily)
    if not self.mFirstChargeConfigDic then
        self:parseFirstChargeDataConfigData()
    end
    return self.mFirstChargeConfigDic[daily]
end

function getFirstChargeList(self)
    if #self.mFirstChargeConfigList <= 0 then
        self:parseFirstChargeDataConfigData()
    end
    return self.mFirstChargeConfigList or {}
end

function parseFirstChargeMsg(self, msg)
    if msg.result == 1 then
        if self.mFirstChargeMsgDic[msg.day] <= 0 then
            self.mFirstChargeMsgDic[msg.day] = 1
        end
        self:updateBubble()
    end
end



return _M

--[[ 替换语言包自动生成，请勿修改！
]]