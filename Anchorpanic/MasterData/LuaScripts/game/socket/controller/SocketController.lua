module("socket.SocketController", Class.impl(Controller))

--构造函数
function ctor(self)
    super.ctor(self)

    self.m_socketCloseTimes = 0
    self.m_reconnectTimes = 0
    self.m_isReconnect = false
    self.mServerPingStop = false
end

--析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
end

--游戏开始的回调
function gameStartCallBack(self)

end

--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.SOCKET_SELECT_CONNECT, self.selectConnectSocketHandler, self)
    GameDispatcher:addEventListener(EventName.SOCKET_CONNECT, self.connectSocketHandler, self)
    GameDispatcher:addEventListener(EventName.CLOSE_SOCKET, self.closeSocketHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_SYS_PING = self.onSysPingMsg,
        SC_SYS_DATE = self.onSysDateMsg,
        SC_SYS_KICK = self.onSysKickMsg,
        SC_SYS_5_RESET = self.onSysDaily5Reset,
    --SC_SYS_5_WEEK_RESET = self.onSysWeekReset
    }
end

function selectConnectSocketHandler(self, args)
    local time = web.__getTime()
    print(string.format("Socket选择连接->开始%s:%s", web.WebManager.ip, web.WebManager.port))
    local serverVo = args.serverVo
    local connectedFunc = function()
        print(string.format("Socket选择连接->成功%s:%s，耗时：%s", web.WebManager.ip, web.WebManager.port, web.__getTime() - time))
        -- 存储成功连接记录
        web.WebManager:addWebServerStorage(serverVo)
        self:onConnected()
    end
    local disconnectFunc = function(msg)
        print(string.format("Socket选择连接->失败%s:%s，耗时：%s", web.WebManager.ip, web.WebManager.port, web.__getTime() - time))
        if (login.LoginManager.isAccHadLoginSuc) then
            login.LoginManager.isAccHadLoginSuc = false
            self:onDisConnect(msg)
        else
            GameDispatcher:dispatchEvent(EventName.CLOSE_SOCKET, {})
            web.WebManager:delWebServerStorage()
            login.LoginController:checkServerList()
        end
    end
    print("开始遍历连接： ", web.WebManager.ip, web.WebManager.port)
    gs.socket.Connect(web.WebManager.ip, web.WebManager.port, connectedFunc, disconnectFunc)
end

function connectSocketHandler(self)
    self:connectSocket()
    LoopManager:removeTimer(self, self.connectSocket)
    LoopManager:addTimer(4, 0, self, self.connectSocket)
end

--连接socket
function connectSocket(self)
    self.m_reconnectTimes = self.m_reconnectTimes + 1
    if self.m_reconnectTimes <= 20 then
        local time = web.__getTime()
        print(string.format("Socket连接->开始%s:%s", web.WebManager.ip, web.WebManager.port))
        local connectedFunc = function()
            print(string.format("Socket连接->成功%s:%s，耗时：%s", web.WebManager.ip, web.WebManager.port, web.__getTime() - time))
            self:onConnected()
        end
        local disconnectFunc = function(msg)
            print(string.format("Socket连接->失败%s:%s，耗时：%s", web.WebManager.ip, web.WebManager.port, web.__getTime() - time))
            login.LoginManager.isAccHadLoginSuc = false
            self:onDisConnect(msg)
        end
        print("开始连接： ", web.WebManager.ip, web.WebManager.port)
        gs.socket.Connect(web.WebManager.ip, web.WebManager.port, connectedFunc, disconnectFunc)
    else
        LoopManager:removeTimer(self, self.connectSocket)
        self.m_isReconnect = false
        self:onDisConnect(string.format("主动连接断开（超过重连上限%s次）", self.m_reconnectTimes))
    end
end

-- 断线重连
function reconnectSocket(self)
    self.m_reconnectTimes = self.m_reconnectTimes + 1

    if self.m_reconnectTimes <= 20 then
        local connectedFunc = function()
            self.m_reconnectTimes = 0
            self.m_socketCloseTimes = 0
            self.m_isReconnect = false
            LoopManager:removeTimer(self, self.connectSocket)
            LoopManager:removeTimer(self, self.reconnectSocket)
            if self.reconnectView then
                self.reconnectView:close()
                self.reconnectView = nil
            end
            print("断线重连成功", web.WebManager.login_account_id, login.LoginManager.gameLoginPlayerId, login.LoginManager.gameLoginSession)

            if login.LoginManager.gameLoginPlayerId == "" or login.LoginManager.gameLoginSession == "" then
                print("====================reconnectSocket 重连socket成功但角色数据出错")
                fight.SceneManager:stopLoadScene()
                GameManager:dispatchEvent(GameManager.NET_AUTO_ALERT)
                UIFactory:alertOK0(_TT(49), _TT(50) .. ".", function()
                    GameDispatcher:dispatchEvent(EventName.REQ_EXIT_GAME, { isCleanGameRes = false, isCleanServerInfo = false, isNeedLoginSdk = true, isNeedRunUpdate = false })
                end)
                return
            end

            SOCKET_SEND(Protocol.CS_ACCOUNT_RELOGIN,
            {
                acc_id = web.WebManager.login_account_id or "",
                player_id = login.LoginManager.gameLoginPlayerId or "",
                session = login.LoginManager.gameLoginSession or "",
                dev_platform_type = web.WebManager.dev_os or web.GetDeviceCode(nil)
            })
        end
        local disconnectFunc = function(msg)
            login.LoginManager.isAccHadLoginSuc = false
            self:onDisConnect(msg)
        end
        print("开始重连接： ", web.WebManager.ip, web.WebManager.port)
        gs.socket.Connect(web.WebManager.ip, web.WebManager.port, connectedFunc, disconnectFunc)
    else
        LoopManager:removeTimer(self, self.connectSocket)
        self:onDisConnect(string.format("断线重连断开（超过重连上限%s次）", self.m_reconnectTimes))
        self.m_isReconnect = false
    end
end

--连接成功
function onConnected(self)
    print("Socket 连接成功")
    GameDispatcher:dispatchEvent(EventName.SOCKET_CONNECT_SUCC)
    self.m_reconnectTimes = 0
    self.m_socketCloseTimes = 0
    self.m_isReconnect = false
    LoopManager:removeTimer(self, self.connectSocket)
    LoopManager:removeTimer(self, self.reconnectSocket)
    if self.reconnectView then
        self.reconnectView:close()
        self.reconnectView = nil
    end
end

--掉线或连接失败
function onDisConnect(self, msg)
    LoopManager:clearTimeout(self.m_timePingSn)
    self.m_timePingSn = nil
    self.mServerPingStop = false
    print("Socket 连接断开：" .. (msg or ""))
    loginLoad.LoginLoadController:closeLoading()
    if self:isBanReconnect() then
        -- 顶号，防沉迷，更新，封号，维护，不走重连
        return
    end

    if self.m_isReconnect then
        return
    end
    if self.reconnectView then
        self.reconnectView:close()
        self.reconnectView = nil
    end

    self.m_socketCloseTimes = self.m_socketCloseTimes + 1
    if self.m_socketCloseTimes >= 5 then
        self:stopPing()
        LoopManager:removeTimer(self, self.reconnectSocket)

        self.m_socketCloseTimes = 0
        self.m_reconnectTimes = 0

        local disMsg = "与服务器断开连接,请检查网络"
        -- local confirmCall = function()
        --     CS.Lylibs.SDKManager.Ins:RestartApplication()
        -- end
        GameManager:dispatchEvent(GameManager.NET_AUTO_ALERT)
        UIFactory:alertOK0("系统提示", disMsg, function()
            GameDispatcher:dispatchEvent(EventName.REQ_EXIT_GAME, { isCleanGameRes = false, isCleanServerInfo = false, isNeedLoginSdk = true, isNeedRunUpdate = false })
        end)
    else
        self:tryToReConnect()
    end
end

-- 请求重连
function tryToReConnect(self)
    if self.m_reconnectTimes > 0 then
        if self.reconnectView then
            self.reconnectView:close()
            self.reconnectView = nil
        end
        LoopManager:removeTimer(self, self.reconnectSocket)
        GameManager:dispatchEvent(GameManager.NET_AUTO_ALERT)
        self.reconnectView = UIFactory:alertOK0("系统提示", "网络连接中断，请尝试重新连接", function()
            self.m_reconnectTimes = 0
            if self.reconnectView then
                self.reconnectView:close()
                self.reconnectView = nil
            end
            self:tryToReConnect()
        end)
    else
        self.m_isReconnect = true
        self.reconnectView = UIFactory:showReconnect()

        LoopManager:addTimer(1, 0, self, self.reconnectSocket)
        self:reconnectSocket()
    end
end

function isReconnecting(self)
    return self.m_isReconnect
end

-- 关闭socket
function closeSocketHandler(self)
    LoopManager:removeTimer(self, self.connectSocket)
    LoopManager:removeTimer(self, self.reconnectSocket)
    self:stopPing()
    gs.socket:CloseSocket()
end

-- 服务器心跳同步
function onSysPingMsg(self, msg)
    if not GameManager.isInitSuccess then
        return
    end

    if self.mServerPingStop then
        self.mServerPingStop = false
        GameDispatcher:dispatchEvent(EventName.SERVER_PING_REGAIN)
    end

    GameManager:setServerTime(msg.time)
    LoopManager:clearTimeout(self.m_timePingSn)
    --心跳停止超过5秒 关闭socket
    self.m_timePingSn = LoopManager:setTimeout(5, self, function()
        self.mServerPingStop = true
        -- gs.Message.Show2("当前网络信号弱")
        GameDispatcher:dispatchEvent(EventName.SERVER_PING_STOP)
    end)
end

--服务器是否停止心跳
function getIsServerPingStop(self)
    return self.mServerPingStop
end

-- 服务器时间同步
function onSysDateMsg(self, msg)
    GameManager.openTime = msg.open_date
    GameManager.mergeTime = msg.merge_date
    GameManager:setServerTime(msg.time)
    self:onStartPing()
end

-- 被踢下线
function onSysKickMsg(self, msg)
    GameManager:setGameState(msg.reason)
    if (GameManager:getGameState() == 0) then
        print("未知")
    elseif (GameManager:getGameState() == 1) then
        print("顶号")
        local disMsg = "您的账号在其他设备登录"
        local confirmCall = function()
            -- 跳到更新界面并更新完后强制重启
            GameDispatcher:dispatchEvent(EventName.REQ_EXIT_GAME, { isCleanGameRes = false, isCleanServerInfo = false, isNeedLoginSdk = true, isNeedRunUpdate = false })
        end
        GameManager:dispatchEvent(GameManager.NET_AUTO_ALERT)
        UIFactory:alertOK0("账号提示", disMsg, confirmCall)
        fight.SceneManager:stopLoadScene()

        --清理协议等待返回列表
        CLEAR_SOCKET_WAITAITRESPONSE()
        -- end
    elseif (GameManager:getGameState() == 2) then
        print("防沉迷")
    elseif (GameManager:getGameState() == 3) then
        print("热更新")
        if (web.WebManager.run_update_code) then
            local disMsg = "检测到游戏需要更新，请更新游戏"
            local confirmCall = function()
                -- 跳到更新界面并更新完后强制重启（更新完后先优先判断状态GameManager:getGameState()）
                GameDispatcher:dispatchEvent(EventName.REQ_EXIT_GAME, { isCleanGameRes = false, isCleanServerInfo = false, isNeedLoginSdk = true, isNeedRunUpdate = true })
                -- 直接重启自己更新
                -- CS.Lylibs.SDKManager.Ins:RestartApplication()
            end
            GameManager:dispatchEvent(GameManager.NET_AUTO_ALERT)
            UIFactory:alertOK0("更新提示", disMsg, confirmCall)
        end
    elseif (GameManager:getGameState() == 4) then
        print("服务端维护中")
        local disMsg = "服务器正在维护中，请重启游戏"
        local confirmCall = function()
            CS.Lylibs.SDKManager.Ins:CloseApplication()
        end
        GameManager:dispatchEvent(GameManager.NET_AUTO_ALERT)
        UIFactory:alertOK0("维护提示", disMsg, confirmCall)
    elseif (GameManager:getGameState() == 5) then
        print("被封号中")
        local disMsg = "您的账号已被封禁"
        local confirmCall = function()
            -- 跳到更新界面并更新完后强制重启
            GameDispatcher:dispatchEvent(EventName.REQ_EXIT_GAME, { isCleanGameRes = false, isCleanServerInfo = false, isNeedLoginSdk = false, isNeedRunUpdate = false })
        end
        GameManager:dispatchEvent(GameManager.NET_AUTO_ALERT)
        UIFactory:alertOK0("账号提示", disMsg, confirmCall)
    elseif (GameManager:getGameState() == 6) then
        print("服务未开服")
        local disMsg = "服务器暂未开启，敬请期待！"
        local confirmCall = function() end
        GameManager:dispatchEvent(GameManager.NET_AUTO_ALERT)
        UIFactory:alertOK0("开服提示", disMsg, confirmCall)
    end
end
-- 禁止重连
function isBanReconnect(self)
    if GameManager:getGameState() == 0 or
    GameManager:getGameState() == 1 or
    GameManager:getGameState() == 2 or
    GameManager:getGameState() == 3 or
    GameManager:getGameState() == 4 or
    GameManager:getGameState() == 5 then
        return true
    end
    return false
end

-- 启动客户端心跳
function onStartPing(self)
    LoopManager:removeTimer(self, self.sendPingCmd)
    LoopManager:addTimer(10, 0, self, self.sendPingCmd)
end

function _toCloseSocket(self)
    self:closeSocketHandler()
end

-- 发送客户端心跳
function sendPingCmd(self)
    -- gs.socket.SendCmd(Protocol.CS_SYS_PING, { time = GameManager:getServerTime() })
    -- if self.m_isReconnect then
    --     self:reconnectSocket()
    -- else
    SOCKET_SEND(Protocol.CS_SYS_PING, { time = GameManager:getServerTime() })
    -- end
end

-- 停止发送心跳包
function stopPing(self)
    LoopManager:removeTimer(self, self.sendPingCmd)
    self.sendPingCmd = nil
    LoopManager:clearTimeout(self.m_timePingSn)
    self.m_timePingSn = nil
end

-- 5点重置
function onSysDaily5Reset(self)
    GameManager:setDaily5Reset()
end

--每周五重置
function onSysWeekReset(self, msg)
    --GameManager:setWeekResetTime(msg)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]