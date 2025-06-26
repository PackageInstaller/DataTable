--[[ 
-----------------------------------------------------
@filename       : WelfareOptOpenBetaManager
@Description    : 福利 公测活动 管理器
@date           : 2023/7
@Author         : Tonn
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("welfareOpt.WelfareOptOpenBetaManager", Class.impl(Manager))

UPDATE_RECEIVE_AWARD = "UPDATE_RECEIVE_AWARD"
--福利模块内部五点刷新
ON_FIVE_RESET = "ON_FIVE_RESET"

function ctor(self)
    super.ctor(self)
end

--析构函数
function dtor(self)

end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

--初始化
function __init(self)
    --配置表
    self.configData = nil
    -- Msg
    self.msgInfo = nil
    -- 开服天数
    self.mOpenDay = nil
    -- 活动结束时间
    self.mEndTime = nil
    -- 中午字典
    self.mChineseDic = nil
end

--------------------------------------------配置表--------------------------------------------
function parseConfigData(self)
    if self.configData == nil then
        --提前开辟长度，避免表扩容
        self.configData = {
            { day = 0, itemTid = 1, num = 1 },
            { day = 0, itemTid = 1, num = 1 },
            { day = 0, itemTid = 1, num = 1 },
            { day = 0, itemTid = 1, num = 1 },
            { day = 0, itemTid = 1, num = 1 },
            { day = 0, itemTid = 1, num = 1 },
            { day = 0, itemTid = 1, num = 1 },
        }
        self.mMaxLen = table.nums(self.configData)
    end

    local baseData = RefMgr:getData("open_server_sign_data")

    if next(baseData) then
        for day, vo in pairs(baseData) do
            local configVo = self.configData[day]
            configVo.day = day
            configVo.itemTid = vo.reward[1]
            configVo.num = vo.reward[2]
        end
    else
        logError("open_server_sign_data 为空，薄纱曹老板")
    end
end

-- 获得公测活动配置表 
function getConfigTable(self)
    if self.configData == nil then
        self:parseConfigData()
    end
    return self.configData
end

-- 获得ConfigVo 通过天数 
function getConfigVoById(self, id)
    if self.configData == nil then
        self:parseConfigData()
    end

    if id > 0 and id <= self.mMaxLen then
        return self.configData[id]
    else
        logError("Invalid id tryting to get Vo from ConfigTable")
    end
end

function getDayChineseById(self, day)
    if self.mChineseDic == nil then
        self.mChineseDic = { "一", "二", "三", "四", "五", "六", "七" }
    end
    return self.mChineseDic[day]
end
--------------------------------------------MSG--------------------------------------------

function parseMsgData(self, msg)
    if self.msgInfo == nil then
        self.msgInfo = { 0, 0, 0, 0, 0, 0, 0 }
    end
    self.mOpenDay = msg.open_day
    self.mEndTime = msg.end_time
    if next(msg.sign_day_reward_list) then
        for _, day in pairs(msg.sign_day_reward_list) do
            if self.msgInfo[day] < 1 then
                self.msgInfo[day] = day
            end
        end
    else
        for i = 1, 7 do
            self.msgInfo[i] = 0
        end
    end
    self:dispatchEvent(self.UPDATE_RECEIVE_AWARD)
    GameDispatcher:dispatchEvent(EventName.UPDATE_WELFAREOPT_FLAG, { tabType = welfareOpt.WelfareOptConst.WELFAREOPT_OPEN_BETA })
end

--------------------------------------------function--------------------------------------------
function getMsgVoById(self, id)
    if self.msgInfo == nil then
        self.msgInfo = { 0, 0, 0, 0, 0, 0, 0 }
    end
    if id > 0 and id <= self.mMaxLen then
        return self.msgInfo[id]
    else
        logError("Invalid id tryting to get MsgVo")
    end

end

--获得结束时间
function getEndTime(self)
    if self.mEndTime then
        return self.mEndTime
    end
end

--获得当前开服天数
function getOpenDays(self)
    if self.mOpenDay then
        return self.mOpenDay
    end
end


--公测福利红点
function checkBubble(self)
    local mMainStageId = battleMap.MainMapManager:getMainMapCurStage()
    local mIsPassMainStage = mMainStageId > sysParam.SysParamManager:getValue(SysParamType.OPEN_BETA_MAINSTAGE_ID)
    if mIsPassMainStage then
        if self.msgInfo ~= nil then
            if next(self.msgInfo) then

                for day, isReceived in pairs(self.msgInfo) do
                    if self.mOpenDay >= day and isReceived == 0 then
                        return true
                    end
                end
            end

        else
            return false
        end
    else
        return false
    end
end

-- 判断活动是否开启
function checkIsOpen(self)
    local leftTime = self.mEndTime ~= nil and self.mEndTime - GameManager:getClientTime() or 0 - GameManager:getClientTime()
    return leftTime > 0 and funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_WELFAREOPT_OPEN_BETA, false)
end


-------------------------------------------SOCKET--------------------------------------------------------------------------------

-----发送领取协议
function sendReceiveReq(self, day)
    if self.msgInfo ~= nil and self.msgInfo[day] == 0 then
        SOCKET_SEND(Protocol.CS_GAIN_OPEN_SERVER_SIGN_REWARD, { day = day })
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]