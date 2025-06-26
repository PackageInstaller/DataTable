require("protocol/Init").init();

socket = {}

--等待返回协议列表（0.5s 后开启转圈的菊花）
socket.waitResponseDic = 
{
    reconnectView = nil,-- 菊花界面
    waitDic = {}, -- 等待列表
    waitTimer = nil,--等待时间戳
} 
socket.pingCount = 0 --心跳计数
socket.faultTimer = nil --容错菊花计时器
-- socket.reconnectView = nil -- 菊花界面
-- socket.SocketSend = require("game/socket/SocketSend")
function SOCKET_SEND(opTable, dataTable,resTable,customWaitTimer)
    if gs.socket.SendCmdID(opTable[1], dataTable)==-1 then
        gs.socket.SendCmd(opTable, dataTable)
    end
    
    if resTable ~= nil then
        if socket.waitResponseDic.waitDic[resTable[1]] then 
            logAll(resTable[1],"<color=red>重复请求协议，请检查代码---------------------</color>")
        end

        local idxSn = SnMgr:getSn()
        socket.waitResponseDic.waitDic[resTable[1]] = 1
        if not socket.waitResponseDic.reconnectView then
            if customWaitTimer == nil then
                customWaitTimer = 0.5
            end
            socket.waitResponseDic.waitTimer = LoopManager:setTimeout(customWaitTimer, nil, function ()
                if table.empty(socket.waitResponseDic.waitDic) then return end

                socket.pingCount = 0
                socket.waitResponseDic.reconnectView = UIFactory:showReconnect()
                logAll(socket.waitResponseDic.waitDic,"菊花停留等待中协议")

                --添加4秒的容错
                socket.faultTimer = LoopManager:addTimer(2,-1,nil,function ()
                    if socket.waitResponseDic.reconnectView and socket.pingCount > 5 then
                        if socket.faultTimer then
                            LoopManager:removeTimerByIndex(socket.faultTimer)
                            socket.faultTimer = nil
                        end

                        socket.waitResponseDic.reconnectView:close()
                        socket.waitResponseDic.reconnectView = nil

                        for k,v in pairs(socket.waitResponseDic.waitDic) do
                            socket.waitResponseDic.waitDic[k] = nil
                            logAll("菊花转圈，有协议未返回。请检查逻辑。协议号=" .. k)
                            return
                        end
                    end
                end)
            end, idxSn)
        end
    end
end
--清理所有的等待协议返回，用于顶号，重新登入
function CLEAR_SOCKET_WAITAITRESPONSE()
    if socket.faultTimer then
        LoopManager:removeTimerByIndex(socket.faultTimer)
        socket.faultTimer = nil
    end

    if socket.waitResponseDic.reconnectView then 
        socket.waitResponseDic.reconnectView:close()
        socket.waitResponseDic.reconnectView = nil
    end

    socket.waitResponseDic.waitDic = {}
end
    

socket.SocketController = require("game/socket/controller/SocketController").new();
return {}
 
--[[ 替换语言包自动生成，请勿修改！
]]
