module("lib.mvc.Controller", Class.impl())
--构造函数
function ctor(self, cusMgr)
    self.mMgr = cusMgr
    self:init();
end

--析构函数
function dtor(self)

end

--初始化
function init(self)
    self:listNotification();
    self:doRegisterMsg();
end

--游戏开始的回调
function gameStartCallBack(self)

end

--模块间事件监听
function listNotification(self)
    -- if (EventName.READY_EXIT_GAME) then
    --     GameDispatcher:addEventListener(EventName.READY_EXIT_GAME, self.__onReadyExitGameHandler, self)
    -- end
end

-- 准备退出游戏，overwirte
-- function __onReadyExitGameHandler(self)
-- end

--注册server发来的数据
function registerMsgHandler(self)
    return {};
end

--执行server数据监听注册
function doRegisterMsg(self)
    local _socketProxy = CS.Lylibs.SocketProxy;
    local _msgList = self:registerMsgHandler();
    if (_msgList ~= nil) then
        for k, v in pairs(_msgList) do
            local _protocol = _G.Protocol[k]
            local func = function(msgData)
                if socket.waitResponseDic.waitDic[_protocol[1]] then
                    socket.waitResponseDic.waitDic[_protocol[1]] = nil
                end

                if table.empty(socket.waitResponseDic.waitDic) then
                    if socket.waitResponseDic.waitTimer then 
                        LoopManager:clearTimeout(socket.waitResponseDic.waitTimer)
                        socket.waitResponseDic.waitTimer = nil
                    end

                    if socket.waitResponseDic.reconnectView then
                        socket.waitResponseDic.reconnectView:close()
                        socket.waitResponseDic.reconnectView = nil
                    end

                    if socket.faultTimer then
                        LoopManager:removeTimerByIndex(socket.faultTimer)
                        socket.faultTimer = nil
                    end
                end
                if _protocol == _G.Protocol.SC_SYS_PING then 
                    socket.pingCount = socket.pingCount + 1
                end
                v(self, msgData)
            end
            if(not _protocol)then
                Debug:log_error(self.__cname, "协议号出错:"..k)
            end
            if(not func)then
                Debug:log_error(self.__cname, "响应方法出错："..k)
            end
            _socketProxy.AddMsgListener(_protocol, func)
        end
    end
end

-- Override 重新登录
function reLogin(self)
    if self.mMgr and self.mMgr.resetData then
        self.mMgr:resetData()
    end
end

return _M