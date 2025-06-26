module("login.LoginController", Class.impl(Controller))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

--析构函数
function dtor(self)
end

--游戏开始的回调
function gameStartCallBack(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
end

--模块间事件监听
function listNotification(self)
    -- 切换账号回调
    sdk.SdkManager:addEventListener(sdk.SdkManager.SDK_SWITCH_ACCOUNT, self.onSdkReqExitGameHandler, self)
    -- 登出回调
    sdk.SdkManager:addEventListener(sdk.SdkManager.SDK_LOGOUT, self.onSdkReqExitGameHandler, self)
    -- 退出回调（比如防沉迷时sdk界面逻辑触发，我方执行数据保存和关闭）
    sdk.SdkManager:addEventListener(sdk.SdkManager.SDK_EXIT, self.onSdkReqExitGameHandler, self)

    -- 请求退出游戏
    GameDispatcher:addEventListener(EventName.REQ_EXIT_GAME, self.onReqExitGameHandler, self)
    -- 开始检查显示登录预加载界面
    GameDispatcher:addEventListener(EventName.START_CHECK_LOGIN_PRELOAD_VIEW, self.onStartCheckLoginPreloadViewHandler, self)
    -- 开始检查显示登录界面
    GameDispatcher:addEventListener(EventName.START_CHECK_LOGIN_VIEW, self.onStartCheckLoginViewHandler, self)
    -- 关闭登录界面
    GameDispatcher:addEventListener(EventName.CLOSE_LOGIN_VIEW, self.__onCloseLoginViewHandler, self)
    -- 打开登录公告界面
    GameDispatcher:addEventListener(EventName.OPEN_LOGIN_BULLETIN_VIEW, self.onOpenLoginBulletinTipViewHandler, self)
    -- 打开登录适龄提示界面
    GameDispatcher:addEventListener(EventName.OPEN_LOGIN_AGE_TIP_VIEW, self.__onOpenLoginAgetTipViewHandler, self)
    -- socket连接成功
    GameDispatcher:addEventListener(EventName.SOCKET_CONNECT_SUCC, self.__onTryLoginHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_ACCOUNT_LOGIN = self.onLoginMsgHandler,
        SC_ACCOUNT_RELOGIN = self.onAccountReLogin
    }
end

------------------------------------------------------------请求-------------------------------------------------------------------
-- sdk通知请求退出游戏
function onSdkReqExitGameHandler(self, args)
    print("统一登出sdk")
    GameDispatcher:dispatchEvent(EventName.REQ_EXIT_GAME, { isCleanGameRes = false, isCleanServerInfo = false, isNeedLoginSdk = true, isNeedRunUpdate = false })
end

-- 请求退出游戏
function onReqExitGameHandler(self, args)
    if(GameView.UINode["UID"] and not gs.GoUtil.IsCompNull(GameView.UINode["UID"]))then
        -- gs.GameObject.Destroy(GameView.UINode["UID"].gameObject)
        GameView.UINode["UID"].text = ""
    end
    download.ResDownLoadManager:removeAllDownLoadTask()
    GameManager:setIsExiting(true)
    local exitFun = function()
        local isCleanGameRes = args.isCleanGameRes
        local isCleanServerInfo = args.isCleanServerInfo
        local isNeedRunUpdate = args.isNeedRunUpdate == nil and download.ResDownLoadManager:getIsNeedRunUpdate() or args.isNeedRunUpdate
        local isNeedLoginSdk = args.isNeedLoginSdk == nil and download.ResDownLoadManager:getIsNeedLoginSdk() or args.isNeedLoginSdk

        -- 删除所有bug日志缓存
        web.DEL_ALL_BUG_CACHE()
        GameDispatcher:dispatchEvent(EventName.CLOSE_SOCKET, {})
        fight.SceneManager:stopLoadScene()
        AudioManager:stopMusic()
        -- 清理相关内存
        pcall(function()
            GCUtil.collectLuaGC()
            GCUtil.colllectCSharpGC()
            gs.GOPoolMgr:ClearAll()
            gs.ResMgr:ForceUnload(true, true)
        end)

        -- loading界面关闭
        loginLoad.LoginLoadController:closeLoading()
        GameManager:setIsGetPlayerData(false)
        if (web.WebManager.preloadType == 1 or web.WebManager.preloadType == 2) then
            if (isNeedRunUpdate) then
                GameManager:setIsLoadPreResComplete(false)
            else
                GameManager:setIsLoadPreResComplete(true)
            end
        else
            GameManager:setIsLoadPreResComplete(false)
        end
        download.ResDownLoadManager:setIsNeedRunUpdate(isNeedRunUpdate)
        download.ResDownLoadManager:setIsNeedLoginSdk(isNeedLoginSdk)
        if (isCleanServerInfo) then
            web.WebManager:delWebServerStorage()
        end
        local function cleanFinish(result)
            U3DSceneUtil:loadSceneSingle("login")
            map.MapLoader:resetMapCtrl()
            U3DSceneUtil:reset()
            if (isNeedRunUpdate) then
                GameDispatcher:dispatchEvent(EventName.READY_EXIT_GAME, {})
                UIFactory:closeForcibly()
                -- 调用READY_EXIT_GAME的时候，会触发各个控制器clearMap调用到Perset3dHandler:reset继而隐藏默认场景相机
                -- 手动设置场景相机为空，统一走WebController的reRequire GameView重新CameraMgr的设置相机流程
                gs.CameraMgr:SetSceneCamera(nil)
                -- 如果需要重新更新游戏，此时更新界面可能不在缓存池中需要一定时间加载会有蓝屏空隙，所以由UpdateResLoadingView显示后自动关闭所有界面
                web.WebManager:dispatchEvent(web.WebManager.REQ_MODULE_UPDATE_CHECK, { isNeedRunUpdate = isNeedRunUpdate })
            else
                -- 如果不需要重新更新游戏，关闭所有界面，会直接显示登陆界面
                gs.PopPanelManager.CloseAll(true)
                if (not gs.PopPanelManager.AllPanelIsClose()) then
                    gs.PopPanelManager.CloseAll(true)
                end
                GameDispatcher:dispatchEvent(EventName.HIDE_MAIN_UI)
                GameDispatcher:dispatchEvent(EventName.READY_EXIT_GAME, {})
                UIFactory:closeForcibly()
                gs.PopPanelManager.DestroyAllPanel()
                -- 调用READY_EXIT_GAME的时候，会触发各个控制器clearMap调用到Perset3dHandler:reset继而隐藏默认场景相机
                -- 手动设置场景相机为空，统一走WebController的reRequire GameView重新CameraMgr的设置相机流程
                gs.CameraMgr:SetSceneCamera(nil)
                web.WebManager:dispatchEvent(web.WebManager.MODULE_UPDATE_CHECK_FINISH, {})

                --清理协议等待返回列表
                CLEAR_SOCKET_WAITAITRESPONSE()
            end
        end

        if (isCleanGameRes) then
            -- 清理全部资源，包括GameRes和ZipGameRes
            download.ResDownLoadManager:cleanGameRes(cleanFinish)
        else
            cleanFinish()
        end
    end
    if (BoardShower:getBoardState() == BoardShower.BoardState.None) then
        BoardShower:showBoard(BoardShower:getBoardImgSource(), BoardShower:getBoardImgAudioSource(), BoardShower:getBoardVideoSource(), false, nil,
        function()
            exitFun()
        end)
    else
        exitFun()
    end
end

-- 开始检查显示登录预加载界面
function onStartCheckLoginPreloadViewHandler(self, args)
    if (login.LoginManager:getIsLoginPreLoaded()) then
        print("LoginController", "不需启动预加载资源加载")
        args.preLoadFinishCall()
    else
        local function _finishCall()
            login.LoginManager:setIsLoginPreLoaded(true)
            if (args.isAutoDestroy == true) then
                if (self.m_preLoadView) then
                    self.m_preLoadView:destroy()
                    self.m_preLoadView = nil
                end
            end
            args.preLoadFinishCall()
        end
        print("LoginController", "启动预加载资源加载")
        if (not self.m_preLoadView) then
            self.m_preLoadView = login.LoginPreloadView.new()
            self.m_preLoadView:startLoad(_finishCall)
        end
    end
end

--- 请求开始检查登录界面
function onStartCheckLoginViewHandler(self, args)
    print("LoginController", "启动登录界面")
    if (web.WebManager:isReleaseApp()) then
        web.WebController:reqReportStep(web.REPORT_STEP.READY_OPEN_LOGIN_VIEW)
        self:__onOpenLoginViewHandler(args.loginViewShowCall)
    else
        self:__onOpenDebugLoginViewHandler(args.loginViewShowCall)
    end
end

-- 请求登录
function __onTryLoginHandler(self)
    print("点击正式登录->开始请求账号登录")
    web.WebController:reqReportStep(web.REPORT_STEP.SOCKET_CONNECT_SUC)

    print(string.format("请求账号登录，IP：%s，端口：%s，服务器id：%s", web.WebManager.ip, web.WebManager.port, web.WebManager.server_id))
    print(string.format("账号名：%s", web.WebManager.web_account_id or ""))
    print(string.format("登录时间：%s", web.WebManager.web_login_time or ""))
    print(string.format("登录ticket：%s", web.WebManager.web_login_token or ""))
    print(string.format("防沉迷：%s", web.WebManager.web_infant or ""))
    print(string.format("平台id：%s", web.WebManager.pf_id or ""))
    print(string.format("平台渠道：%s", web.WebManager.channel_id or ""))
    print(string.format("平台子渠道：%s", web.WebManager.sub_channel_id or ""))
    print(string.format("设备类型：%s", web.WebManager.dev_os))
    print(string.format("设备码：%s", sdk.SdkManager:getUniqueId()))
    print(string.format("设备型号：%s", CS.UnityEngine.SystemInfo.deviceModel))

    SOCKET_SEND(Protocol.CS_ACCOUNT_LOGIN,
    {
        acc_name = web.WebManager.web_account_id or "",
        login_time = web.WebManager.web_login_time or 0,
        login_token = web.WebManager.web_login_token or "",
        infant = web.WebManager.web_infant or 1, -- 防沉迷：1、成年人 0：未成年人
        pf = web.WebManager.pf_id or 0,
        channel_id = web.WebManager.channel_id or 0,
        sub_channel_id = web.WebManager.sub_channel_id or 0,
        srv_id = web.WebManager.server_id or 0,
        dev_platform_type = web.WebManager.dev_os or web.GetDeviceCode(nil),
        dev_code = sdk.SdkManager:getUniqueId() or "",
        dev_model = CS.UnityEngine.SystemInfo.deviceModel or "",
        dev_token = gs.SdkManager:GetDevicePushToken() or ""
    })
end
------------------------------------------------------------响应-------------------------------------------------------------------

-- 账号登陆结果
function onLoginMsgHandler(self, msg)
    -- 0).     % 验证成功
    -- 1).     % 用户名为空
    -- 2).     % IP被封
    -- 3).     % 服务器ID非法
    -- 4).     % 服务器注册账号已满
    -- 5).     % 账号被封
    -- 6).     % 账号防沉迷
    -- 7).     % 设备法非法
    -- 8).     % IP地址登录人数达上线
    -- 9).     % 渠道非法
    -- 10).    % 子渠道非法
    -- 11).    % 服务器初始化中
    -- 12).    % 用户创建失败
    -- 13).    % 设备码验证失败
    -- 14).    % 加密串验证失败
    -- 15).    % 注册时间限制
    -- 20).    % 创角失败
    -- 21).    % 登录失败
    if msg.result == 0 then
        print("点击正式登录->请求账号登录成功")
        web.WebController:reqReportStep(web.REPORT_STEP.SERVER_LOGIN_SUC)

        web.WebManager.login_account_id = msg.acc_id
        login.LoginManager.gameLoginPlayerId = msg.player_id
        login.LoginManager.gameLoginSession = msg.session
        login.LoginManager.createRoleTime = msg.create_time
        login.LoginManager.isFirstCreateRole = msg.is_new == 1 and true or false
        login.LoginManager.isAccHadLoginSuc = true

        loginLoad.LoginLoadController:starRunLoad()
        GameDispatcher:dispatchEvent(EventName.ACCOUNT_LOGIN_SUC, {})
    else
        print("点击正式登录->请求账号登录失败")
        loginLoad.LoginLoadController:closeLoading()
        GameDispatcher:dispatchEvent(EventName.CLOSE_SOCKET, {})
        web.WebManager:delWebServerStorage()

        if (msg.result == 15) then
            GameDispatcher:dispatchEvent(EventName.REQ_EXIT_GAME, { isCleanGameRes = false, isCleanServerInfo = false, isNeedLoginSdk = false, isNeedRunUpdate = false })
            local confirmCall = function()
                CS.Lylibs.SDKManager.Ins:CloseApplication()
            end
            UIFactory:alertOK0(_TT(49), _TT(61), confirmCall)
        elseif (msg.result == 3 or msg.result == 4 or msg.result == 12 or msg.result == 20) then
            -- 仅在后端指定情况下才需要遍历连接服务器列表
            self:checkServerList()
        else
            gs.Message.Show(login.getLoginResultTip(msg.result))
        end
    end
end

-- 账号重新登陆结果
function onAccountReLogin(self, msg)
    print("onAccountReLogin", msg.result, msg.session)
    -- 结果：1-成功，0-失败
    if msg.result == 1 then
        print("onAccountReLogin 重新登陆成功")

        login.LoginManager.gameLoginSession = msg.session
        login.LoginManager.isAccHadLoginSuc = true
        GameDispatcher:dispatchEvent(EventName.ACCOUNT_RELOGIN_SUC)
        SOCKET_SEND(Protocol.CS_ENTER_WORLD, { battle_sync_word = fight.FightManager:getSyncWord() })
    else
        print("onAccountReLogin 重新登陆失败")

        fight.SceneManager:stopLoadScene()
        GameDispatcher:dispatchEvent(EventName.CLOSE_SOCKET, {})
        UIFactory:alertOK0(_TT(49), _TT(50) .. "。", function()
            GameDispatcher:dispatchEvent(EventName.REQ_EXIT_GAME, { isCleanGameRes = false, isCleanServerInfo = false, isNeedLoginSdk = true, isNeedRunUpdate = false })
        end)
    end
end

------------------------------------------------------------------------------------------------------------------------------------
-- 关闭存在的登录界面（此处几个界面不置空，关闭后自己回调置空）
function __onCloseLoginViewHandler(self)
    if self.mLoginBulletinTipView then
        self.mLoginBulletinTipView:close()
    end
    if self.m_loginView then
        self.m_loginView:close()
    end
    if self.m_debugLoginView then
        self.m_debugLoginView:close()
    end
    if (self.m_preLoadView) then
        self.m_preLoadView:destroy()
        self.m_preLoadView = nil
    end
end

-- 打开登录公告界面
function onOpenLoginBulletinTipViewHandler(self)
    local args = login.LoginManager:getLoginBulletinData()
    if (args) then
        if self.mLoginBulletinTipView == nil then
            self.mLoginBulletinTipView = login.LoginBulletinTipPanel.new()
            self.mLoginBulletinTipView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyLoginBulletinTipViewHandler, self)
        end
        self.mLoginBulletinTipView:open(args)
    end
end

-- 登录公告界面ui销毁
function onDestroyLoginBulletinTipViewHandler(self)
    if (self.mLoginBulletinTipView) then
        self.mLoginBulletinTipView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyLoginBulletinTipViewHandler, self)
        self.mLoginBulletinTipView = nil
    end
end

-- 打开登录适龄提示界面
function __onOpenLoginAgetTipViewHandler(self)
    if self.m_loginAgeTipView == nil then
        self.m_loginAgeTipView = login.LoginAgeTipPanel.new()
        self.m_loginAgeTipView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyLoginAgeTipViewHandler, self)
    end
    self.m_loginAgeTipView:open()
end

-- 登录适龄提示界面ui销毁
function onDestroyLoginAgeTipViewHandler(self)
    if (self.m_loginAgeTipView) then
        self.m_loginAgeTipView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyLoginAgeTipViewHandler, self)
        self.m_loginAgeTipView = nil
    end
end

------------------------------------------------------------------------------------------------------------------------------------
-- 显示登录界面
function __onOpenLoginViewHandler(self, loginViewShowCall)
    if self.m_loginView == nil then
        self.m_loginView = login.LoginView.new()
        self.m_loginView:addEventListener(login.LoginManager.EVENT_LOGIN, self.onLoginHandler, self)
        self.m_loginView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyLoginViewHandler, self)
    end
    local function _callFun()
        if (self.m_preLoadView) then
            self.m_preLoadView:destroy()
            self.m_preLoadView = nil
        end
        loginViewShowCall()
    end
    self.m_loginView:setCallFun(_callFun)
    self.m_loginView:open()
end

-- 登录界面ui销毁
function onDestroyLoginViewHandler(self)
    if (self.m_loginView) then
        self.m_loginView:removeEventListener(login.LoginManager.EVENT_LOGIN, self.onLoginHandler, self)
        self.m_loginView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyLoginViewHandler, self)
        self.m_loginView = nil
    end
end

-- 显示debug登录
function __onOpenDebugLoginViewHandler(self, loginViewShowCall)
    if self.m_debugLoginView == nil then
        self.m_debugLoginView = login.DebugLoginView.new()
        self.m_debugLoginView:addEventListener(login.LoginManager.EVENT_LOGIN, self.onDebugLoginHandler, self)
        self.m_debugLoginView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDebugLoginViewHandler, self)
    end
    local function _callFun()
        if (self.m_preLoadView) then
            self.m_preLoadView:destroy()
            self.m_preLoadView = nil
        end
        loginViewShowCall()
    end
    self.m_debugLoginView:setCallFun(_callFun)
    self.m_debugLoginView:open()
end

-- debug登录ui销毁
function onDestroyDebugLoginViewHandler(self)
    if (self.m_debugLoginView) then
        self.m_debugLoginView:removeEventListener(login.LoginManager.EVENT_LOGIN, self.onDebugLoginHandler, self)
        self.m_debugLoginView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDebugLoginViewHandler, self)
        self.m_debugLoginView = nil
    end
end

---------------------------------------------------------------------------------------------------------------------------------------------
-- 点击debug登录
function onDebugLoginHandler(self, data)
    local isHasNetWork, isMobileNet, isWifi = web.getNetStatus()
    if (isHasNetWork) then
        loginLoad.LoginLoadController:showLoading(self.__onCloseLoginViewHandler, self)
        local function login()
            web.WebManager.web_login_time = math.floor(web.__getTime())
            web.WebManager.web_account_id = data.accname
            web.WebManager.ip = data.ip
            web.WebManager.port = data.port
            web.WebManager.server_id = data.svr_id
            -- 请求连接socket准备进入游戏
            GameDispatcher:dispatchEvent(EventName.SOCKET_CONNECT)
        end

        local function checkIsLatestVersion(isLatestVersion)
            if (isLatestVersion) then
                login()
            else
                loginLoad.LoginLoadController:closeLoading()
                GameDispatcher:dispatchEvent(EventName.REQ_EXIT_GAME, { isCleanGameRes = false, isCleanServerInfo = false, isNeedLoginSdk = true, isNeedRunUpdate = true })
            end
        end

        if (web.WebManager.run_update_code) then
            download.ResDownLoadManager:startReadCdnVersion(checkIsLatestVersion)
        else
            login()
        end
    else
        gs.Message.Show("当前网络不可用，请检查是否连接了可用的Wifi或移动网络")
    end
end

-- 点击正式登录
function onLoginHandler(self, data)
    local isHasNetWork, isMobileNet, isWifi = web.getNetStatus()
    if (isHasNetWork) then
        loginLoad.LoginLoadController:showLoading(self.__onCloseLoginViewHandler, self)
        web.WebController:reqReportStep(web.REPORT_STEP.CLICK_START_BTN)
        local function login(isServerListUpdateSuc)
            print("LoginController", string.format("点击正式登录->推荐服相关已刷新，是否遍历登录：%s", tostring(isServerListUpdateSuc)))
            if (isServerListUpdateSuc) then
                self:checkServerList()
            end
        end

        local time = web.__getTime()
        print("LoginController", "点击正式登录->开始请求是否最新版本")
        local function checkIsLatestVersion(isLatestVersion)
            print("LoginController", string.format("点击正式登录->开始响应是否最新版本->耗时：%s秒，是否最新：%s", web.__getTime() - time, tostring(isLatestVersion)))
            if (isLatestVersion) then
                web.WebController:reqRecommendServerInfo(login, 3)
            else
                loginLoad.LoginLoadController:closeLoading()
                GameDispatcher:dispatchEvent(EventName.REQ_EXIT_GAME, { isCleanGameRes = false, isCleanServerInfo = false, isNeedLoginSdk = true, isNeedRunUpdate = true })
            end
        end
        download.ResDownLoadManager:startReadCdnVersion(checkIsLatestVersion)
    else
        gs.Message.Show("当前网络不可用，请检查是否连接了可用的Wifi或移动网络")
    end
end

-- 检测服务器列表
function checkServerList(self)
    local function errorFun(errorCode)
        local confirmCall = function()
            CS.Lylibs.SDKManager.Ins:RestartApplication()
        end
        loginLoad.LoginLoadController:closeLoading()
        UIFactory:alertOK0(_TT(49), _TT(48, errorCode), confirmCall)
    end
    -- 遍历检查
    local function socketSelectConect()
        local serverVo = web.WebManager:getServerVo()
        if (serverVo) then
            web.WebManager:setServerData(serverVo)
            -- 判断是否在维护中
            if (web.WebManager.is_weihu) then
                self:checkServerList()
            else
                -- 遍历服务器列表连接
                GameDispatcher:dispatchEvent(EventName.SOCKET_SELECT_CONNECT, { serverVo = serverVo })
            end
        else
            -- 所有服都连不进去，遍历下是否全都在维护中，是则提示维护中，否则异常
            local isAllWeiHu = true
            local backupServerList = web.WebManager.backup_server_list
            for i = 1, #backupServerList do
                local serverVo = backupServerList[i]
                if (not serverVo.is_weihu) then
                    isAllWeiHu = false
                    break
                end
            end
            if (isAllWeiHu) then
                loginLoad.LoginLoadController:closeLoading()
                -- 恢复服务器备份
                web.WebManager:restoreBackUpServerlist()
                gs.Message.Show(_TT(51))
            else
                -- 所有服在非维护状态下都连接不上
                errorFun(1)

                local bugTip = ""
                local backupServerList = web.WebManager.backup_server_list
                for i = 1, #backupServerList do
                    local serverVo = backupServerList[i]
                    bugTip = bugTip .. serverVo:toString() .. "\n"
                end
                print(string.format("登录连接->所有服在非维护状态下都连接不上：\n%s", bugTip))
            end
        end
    end

    -- 判断是否已有缓存服务器数据
    local storageServerVoStr = web.WebManager:getWebServerStorage()
    if (storageServerVoStr == nil or storageServerVoStr == "") then
        print(string.format("登录连接->无缓存直接遍历登录Socket"))
        socketSelectConect()
    else
        print("存在有服务器缓存数据：", storageServerVoStr)
        local storageServerVo = web.WebServerVo.new()
        local isSuc = storageServerVo:toTable(storageServerVoStr)
        if (isSuc) then
            -- 确保找到最新的服务器数据
            local findServerVo = nil
            for i = 1, #web.WebManager.server_list do
                if (web.WebManager.server_list[i].server_id == storageServerVo.server_id) then
                    findServerVo = web.WebManager.server_list[i]
                    break
                end
            end
            if (findServerVo) then
                print(string.format("登录连接->有缓存指定登录Socket"))
                web.WebManager.server_list = {}
                web.WebManager:setServerData(findServerVo)
                -- 判断是否在维护中
                if (web.WebManager.is_weihu) then
                    loginLoad.LoginLoadController:closeLoading()
                    -- 恢复服务器备份
                    web.WebManager:restoreBackUpServerlist()
                    gs.Message.Show(_TT(51))
                else
                    -- 指定服务器连接
                    GameDispatcher:dispatchEvent(EventName.SOCKET_CONNECT)
                end
            else
                local bugTip = ""
                local backupServerList = web.WebManager.backup_server_list
                for i = 1, #backupServerList do
                    local serverVo = backupServerList[i]
                    bugTip = bugTip .. serverVo:toString() .. "\n"
                end
                print(string.format("登录连接->本地缓存%s在web发来数据中找不到：\n%s，\n将直接遍历服务器列表登录", storageServerVoStr, bugTip))

                -- -- 客户端如果都指定了服务器数据要web发来，却找不到，那就重启
                -- errorFun(3)
                -- 客户端如果都指定了服务器数据要web发来，却找不到，那就直接遍历服务器的列表
                socketSelectConect()
            end
        else
            socketSelectConect()
        end
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(51):	"服务器正在维护中......"
	语言包: _TT(51):	"服务器正在维护中......"
	语言包: _TT(49):	"系统提示"
	语言包: _TT(51):	"服务器正在维护中......"
	语言包: _TT(50):	"与莱丝坦斯通讯中心建立连接时发生错误，请重新登录"
	语言包: _TT(49):	"系统提示"
]]