--[[    
    游戏配置
]]
module('GameManager', Class.impl("lib.event.EventDispatcher"))

-- 是否运行测试单元
-- RUN_TEST = true
RUN_TEST = false
-- 是否进行Socket消息打印
SOCKET_DEBUG = false
-- 是否为debug
IS_DEBUG = false

-- 是否隐藏debug信息
HIDE_DEBUG_INFO = false

-- 网络造成自动弹提示
NET_AUTO_ALERT = 'NET_AUTO_ALERT'

-- ******************日志设置 BEGIN****************************************
-- 是否记录日志
LOG_SHOW = true
-- 日志的输出等级
LOG_LIMIT_LEVEL = 0
-- 只显示的日志内容
LOG_EXCLUSIVE = {} -- {"displayTag1", "displayTag2"}
-- 日志过滤的标志
LOG_IGNORE = { 'ignoreTag1', 'ignoreTag2' }
-- ******************日志设置 END****************************************
-- 预加载资源是否完成
LOAD_PRE_RES_COMPLETE = 'LOAD_PRE_RES_COMPLETE'
-- 获取玩家数据完毕
GET_PLAYER_DATA = 'GET_PLAYER_DATA'
-- 初始化心跳包完成
GET_PING_SUCCESS = 'GET_PING_SUCCESS'

-- 构造函数
function ctor(self)
    super.ctor(self)

    self.m_isLoadPreResComplete = false
    self.m_isGetPlayerData = false

    -- 心跳包是否初始化完成
    self.isInitSuccess = false
    -- 服务器时间（秒）
    self.mServerTime = nil
    -- 客户端启动后经过的时间（秒）
    self.mClientStartTime = nil
    -- 客户端启动后经过的时间（毫秒，单纯用秒*1000而已，不准，尽量不用）
    self.mClientStartMSTime = nil
    -- 开服时间
    self.openTime = nil
    -- 合服时间
    self.mergeTime = nil
    -- 是否已经5点重置
    self.isDaily5Reset = nil

    -- 客户端启动时间
    self.clientSetupTime = os.time()

    -- 是否正在退出到登录中
    self.mIsExiting = nil

    -- 每周重置时间戳
    self.mWeekResetTime = nil
end

function setIsExiting(self, is)
    self.mIsExiting = is
end
function getIsExiting(self)
    return self.mIsExiting
end

-- 析构函数
function dtor(self)

end

-- 预加载资源是否完成
function setIsLoadPreResComplete(self, b)
    if self.m_isLoadPreResComplete ~= b then
        self.m_isLoadPreResComplete = b
        self:dispatchEvent(LOAD_PRE_RES_COMPLETE)
    end
end
function getIsLoadPreResComplete(self)
    return self.m_isLoadPreResComplete
end

-- 获取玩家数据是否完毕
function setIsGetPlayerData(self, b)
    if self.m_isGetPlayerData ~= b then
        self.m_isGetPlayerData = b
        self:dispatchEvent(GET_PLAYER_DATA)
    end
end
function getIsGetPlayerData(self)
    return self.m_isGetPlayerData
end

-- 同步服务器时间
function setServerTime(self, cusServerTime)
    if self.mServerTime == cusServerTime then
        return
    end
    if self.mServerTime == nil then
        Debug:log_info('GameManager', '当前服务器时间：' .. os.date("%Y-%m-%d %H:%M:%S", cusServerTime))
        Debug:log_info('GameManager', '当前服务器开服时间：' .. os.date("%Y-%m-%d %H:%M:%S", self.openTime))
        Debug:log_info('GameManager', '当前服务器合服时间：' .. self.mergeTime)
    end
    self.mServerTime = cusServerTime
    local nowTime = os.time()
    self.mClientStartTime = nowTime
    self.mClientStartMSTime = nowTime * 1000

    if not self.isInitSuccess then
        self.isInitSuccess = true
        self:dispatchEvent(GET_PING_SUCCESS)
    end
end

-- 服务器时间(业务功能请使用客户端时间)
function getServerTime(self)
    if (self.mClientStartTime and self.mServerTime) then
        return math.floor(os.time() - self.mClientStartTime + self.mServerTime);
    elseif self.mServerTime then
        return self.mServerTime
    end
    return 0
    -- return self.mServerTime
end

-- 客户端时间（秒）
function getClientTime(self)
    if (self.mClientStartTime and self.mServerTime) then
        return math.floor(os.time() - self.mClientStartTime + self.mServerTime);
    else
        return nil
    end
end
-- 客户端时间(毫秒)
function getClientMSTime(self)
    if (self.mClientStartMSTime and self.mServerTime) then
        return math.floor(os.time() * 1000 - self.mClientStartMSTime + self.mServerTime * 1000);
    else
        return nil
    end
end

-- 设置游戏的判断状态（被踢下线的原因，该值不受切换登录影响，只在登录游戏服成功后才置nil）(0重登)
function setGameState(self, state)
    self.m_state = state
end
-- 获取游戏的判断状态
function getGameState(self)
    return self.m_state
end

-- 设置5点重置状态
function setDaily5Reset(self)
    logInfo("============5点重置更新===========")
    self.isDaily5Reset = true
    GameDispatcher:dispatchEvent(EventName.FIVE_RESET)
    --gs.Message.Show(_TT(46824))
end

-- 检查是否5点重置
function checkDialy5Reset(self)
    if self.isDaily5Reset then
        self.isDaily5Reset = false
        --gs.Message.Show(_TT(46824))
        --gs.PopPanelManager.CloseAll()
        return true
    end
    return false
end

function setWeekResetTime(self, msg)
    self.mWeekResetTime = msg.time
end

function getWeekResetTime(self)
    local wday = tonumber(os.date("%w", self.mServerTime)) == 0 and 7 or tonumber(os.date("%w", self.mServerTime))
    wday = (wday == 1 and tonumber(os.date("%H", self.mServerTime)) < 5) and 8 or wday
    local endTime = ((8 - wday) * 24 * 3600) - os.date("%H", self.mServerTime) * 3600 - os.date("%M", self.mServerTime) * 60 - os.date("%S", self.mServerTime) + 5 * 3600 + self.mServerTime
    return endTime
end

-- 是否处于提审期间
function setIsInCommiting(self, isIn)
    if (self.mIsInCommiting ~= isIn) then
        self.mIsInCommiting = isIn
        GameDispatcher:dispatchEvent(EventName.UPDATE_IS_IN_COMMITING)
    end
end
function getIsInCommiting(self)
    return self.mIsInCommiting
end

function getDoundlessLockTime(self)
    local wday = tonumber(os.date("%w", self.mServerTime)) == 0 and 7 or tonumber(os.date("%w", self.mServerTime))
    wday = (wday == 1 and tonumber(os.date("%H", self.mServerTime)) < 5) and 8 or wday
    local endTime = ((8 - wday) * 24 * 3600) - os.date("%H", self.mServerTime) * 3600 - os.date("%M", self.mServerTime) * 60 - os.date("%S", self.mServerTime) - 2 * 3600 + self.mServerTime
    return endTime
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(39):	"每日数据更新"
]]