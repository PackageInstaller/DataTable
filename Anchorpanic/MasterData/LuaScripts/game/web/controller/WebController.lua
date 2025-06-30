module('web.WebController', Class.impl())

--析构函数
function dtor(self)
    self:__removeEvents()
end

--构造函数
function ctor(self)
    web.setSplashTipProcess(10)
    -- 比较消耗的实时发送初始默认关闭，每次都由后台控制
    if (web.getLogCollectType() == web.DEBUG_LOG_COLLECT_TYPE.AUTO_REAL_TIME_UPLOAD) then
        web.setLogCollectType(web.DEBUG_LOG_COLLECT_TYPE.NONE)
    elseif (web.getLogCollectType() == web.DEBUG_LOG_COLLECT_TYPE.OPEN_DETAIL_DOWNLOAD_LOG) then
        gs.ApplicationUtil.SetDebugBackgroundCollect(true)
        CS.Lylibs.ResDownLoadManager.Instance.IsPrintLog = true
        CS.Lylibs.DownloadManager.Instance.IsPrintLog = true
        CS.Lylibs.ZipDownLoadManager.Instance.TestCode = true
        CS.Lylibs.ZipDownloadTask.TestCode = true
        CS.Lylibs.ZipMissionManager.TestCode = true
        CS.Lylibs.ZipUnzipTask.TestCode = true
        CS.Lylibs.ZipValidationTask.TestCode = true
    else
        gs.ApplicationUtil.SetDebugBackgroundCollect(false)
        CS.Lylibs.ResDownLoadManager.Instance.IsPrintLog = false
        CS.Lylibs.DownloadManager.Instance.IsPrintLog = false
        CS.Lylibs.ZipDownLoadManager.Instance.TestCode = false
        CS.Lylibs.ZipDownloadTask.TestCode = false
        CS.Lylibs.ZipMissionManager.TestCode = false
        CS.Lylibs.ZipUnzipTask.TestCode = false
        CS.Lylibs.ZipValidationTask.TestCode = false
    end

    local url, parasmDic = web.getUploadTypeUrl()
    local correctCall = function(self, webData, jsonObj)
        if (string.find(webData, "<html") == nil) then
            if (webData ~= "" and jsonObj ~= nil and jsonObj.data ~= nil and jsonObj.status ~= 0) then
                if (#jsonObj.data > 0) then
                    self:openSecretPassWord(jsonObj.data)
                end
            end
        end
        self:start()
    end
    local errorCall = function(self, errorData, jsonObj)
        self:start()
    end
    -- 直接把首次预热请求后再显示游戏了
    WebInterfaceUtil:postAsyncLoop(url, parasmDic, correctCall, errorCall, self, 1)
end

function start(self)
    web.setSplashTipProcess(11)
    sdk.SdkController:openMemoryCheck()
    web.setSplashTipProcess(12)
    local function allInitFinishCallBack(self, msg)	-- sdk和unity都已经初始化完毕
        sdk.SdkManager:removeEventListener(sdk.SdkManager.ALL_INIT_FINISH, allInitFinishCallBack, self)
        web.setSplashTipProcess(14)
        print("SDK和Unity都初始化完毕")
        self:checkABKey()
    end
    sdk.SdkManager:addEventListener(sdk.SdkManager.ALL_INIT_FINISH, allInitFinishCallBack, self)

    web.setSplashTipProcess(13)
    -- unity端游戏逻辑初始化完毕
    self:reqReportStep(web.REPORT_STEP.UNITY_INIT_FINISH)
    CS.Lylibs.SDKManager.Ins:UnityInitFinish()
end

-- 检查解压
function checkABKey(self)
    if (not CS.Lylibs.ApplicationUtil.IsEditorRun) then
        local function yesPermission()
            self:reqABKey()
        end
        local function noPermission()
            CS.Lylibs.AlertTip.Instance:OpenVisible("网络提示", "无法连接网络，请检查网络设置", "", nil, "确认", function() CS.Lylibs.SDKManager.Ins:RestartApplication() end)
        end
        web.setSplashTipProcess(15)
        self:checkNetPermission(2, yesPermission, noPermission)
    else
        self:reqABKey()
    end
    self:reportColdStartUpTime(CS.Lylibs.Splash.Instance.CostColdStarUpTime)
end

-- 检查网络权限
function checkNetPermission(self, tryCount, yesCallFun, noCallFun)
    if (CS.Lylibs.ApplicationUtil.IsEditorRun) then
        yesCallFun()
    else
        local url, parasmDic = web.getIPUrl()
        local correctCall = function(self, webData, jsonObj)
            yesCallFun()
        end
        local errorCall = function(self, errorData, jsonObj)
            noCallFun()
        end
        -- 直接把首次预热请求后再显示游戏了
        WebInterfaceUtil:postAsyncLoop(url, parasmDic, correctCall, errorCall, self, tryCount)
        -- -- 使用HttpClient首次会卡顿因为内部机制执行了预热；HttpWebRequest貌似不用预热速度快，这里如果要规避闪屏界面卡顿就使用HttpWebRequest
        -- WebInterfaceUtil.GetDataXHRByPost(url, parasmDic, correctCall, errorCall, self, tryCount)
    end
end

-- 上报冷启动时长
function reportColdStartUpTime(self, times)
    if (times ~= "") then
        local url, parasmDic = web.getReportGenericArgsUrl(web.GENERIC_ARGS_REPORT_TYPE.COLD_STAR_UP, tonumber(times) / 1000)
        WebInterfaceUtil:postAsyncLoop(url, parasmDic, nil, nil, self, nil)
    end
end

-- 密钥请求
function reqABKey(self)
    web.setSplashTipProcess(16)
    if (CS.Lylibs.ABStream.EncryptKey == "") then
        self:reqReportStep(web.REPORT_STEP.START_REQ_AB_KEY)
        local url, parasmDic = web.getABKeyUrl()
        local function correctCall(self, webData, jsonObj)
            web.setSplashTipProcess(17)
            if (jsonObj.status == 0) then
                local message = CS.Lylibs.UTF8StringUtil.GetString(jsonObj.message)
                print("WebController", "Key返回出错：" .. message .. " => " .. webData)
                CS.Lylibs.AlertTip.Instance:OpenVisible("网络提示", "网络返回参数错误，请重新请求", "", nil, "确认",
                function()
                    self:reqABKey()
                end)
            else
                print("WebController", "Key返回" .. webData)
                local abEncryptKeyName = "ABEncryptKey"
                local cacheKey = StorageUtil:getString0(abEncryptKeyName)
                if (cacheKey == nil or cacheKey == "" or cacheKey == jsonObj.data) then
                    StorageUtil:saveString0(abEncryptKeyName, jsonObj.data)
                    CS.Lylibs.ABStream.EncryptKey = jsonObj.data
                    web.setSplashTipProcess(18)
                    CS.Game.Instance:OtherSetting(web.WebManager.res_split_type,
                    function(result)
                        if (result) then
                            self:__init()
                        else
                            self:__resetGame()
                        end
                    end
                    )
                else
                    CS.Lylibs.ApplicationUtil.CleanGameRes()
                    StorageUtil:deleteKey0(abEncryptKeyName)
                    self:__resetGame()
                end
            end
        end
        local errorCall = function(self, errorData, jsonObj)
            CS.Lylibs.AlertTip.Instance:OpenVisible("网络提示", "无法连接网络，请检查网络设置", "", nil, "确认",
            function()
                self:reqABKey()
            end)
        end
        WebInterfaceUtil:postAsyncLoop(url, parasmDic, correctCall, errorCall, self, 1)
    else
        web.setSplashTipProcess(18)
        CS.Game.Instance:OtherSetting(web.WebManager.res_split_type,
        function(result)
            if (result) then
                self:__init()
            else
                self:__resetGame()
            end
        end
        )
    end
end

function __init(self)
    web.setSplashTipProcess(19)
    -- web判断net_type，加载web配置
    -- 内网：--------------------------------------------------->DebugLoginView登录->模拟参数请求web获取登录Token->请求P登录，
    -- 外网：sdk账号密码登录——>获得平台账号id、平台Token——>平台Token会过期，须立即请求web登录验证获得游戏服登录Token——>请求web获取推荐服务器(CdnUrl)——>检测资源是否更新(是则更新界面执行流程)——>LoginView登录——>请求P登录
    -- web.setSplashTipProcess(65)
    -- gs.ResMgr:ShaderVariantWarmUp("artsPlugins/LeiyanUIFX/Shader/Variants/variants_uifx.shadervariants")
    -- web.setSplashTipProcess(70)
    -- gs.ResMgr:ShaderVariantWarmUp("artsPlugins/LeiyanFX/Shader/Character/Variants/variants_char.shadervariants")
    -- web.setSplashTipProcess(75)
    -- gs.ResMgr:ShaderVariantWarmUp("artsPlugins/LeiyanFX/Shader/Effect/Variants/variants_fx_0.shadervariants")
    -- web.setSplashTipProcess(80)
    -- gs.ResMgr:ShaderVariantWarmUp("artsPlugins/LeiyanFX/Shader/Effect/Variants/variants_fx_1.shadervariants")
    -- web.setSplashTipProcess(85)
    -- gs.ResMgr:ShaderVariantWarmUp("artsPlugins/LeiyanFX/Shader/Effect/Variants/variants_fx_2.shadervariants")
    -- web.setSplashTipProcess(90)
    -- gs.ResMgr:ShaderVariantWarmUp("artsPlugins/LeiyanFX/Shader/Scene/Variants/variants_scene.shadervariants")
    gs.ResMgr:ShaderVariantWarmUpAll()

    self:reqReportStep(web.REPORT_STEP.START)
    self:__addEvents()
    if (web.WebManager.run_update_code) then
        if (download.ResDownLoadManager:getIsNeedRunUpdate()) then
            self:__onReqModuleUpdateCheckHandler()
        else
            self:__onModuleUpdateCheckFinishHandler()
        end
    else
        self:__onModuleUpdateCheckFinishHandler()
        if (web.WebManager.preloadType == 1 or web.WebManager.preloadType == 2) then
            GameManager:setIsLoadPreResComplete(true)
        end
    end
end

function __addEvents(self)
    -- 第一个界面模块初始化完毕回调
    web.WebManager:addEventListener(web.WebManager.FIRST_VIEW_INIT_FINISH, self.__onFirstViewInitFinishHandler, self)
    -- 请求启动资源更新模块检测
    web.WebManager:addEventListener(web.WebManager.REQ_MODULE_UPDATE_CHECK, self.__onReqModuleUpdateCheckHandler, self)
    -- 资源更新模块检测完毕回调
    web.WebManager:addEventListener(web.WebManager.MODULE_UPDATE_CHECK_FINISH, self.__onModuleUpdateCheckFinishHandler, self)
    -- 所有功能模块加载完毕
    web.WebManager:addEventListener(web.WebManager.ALL_MODULE_REQUIRE_FINISH, self.__onAllModuleRequireFinishHandler, self)
    -- 请求Sdk账号登录
    web.WebManager:addEventListener(web.WebManager.REQ_SDK_ACCOUNT_LOGIN, self.__onReqSdkAccountLoginHandler, self)
end

function __removeEvents(self)
    web.WebManager:removeEventListener(web.WebManager.FIRST_VIEW_INIT_FINISH, self.__onFirstViewInitFinishHandler, self)
    web.WebManager:removeEventListener(web.WebManager.MODULE_UPDATE_CHECK_FINISH, self.__onModuleUpdateCheckFinishHandler, self)
    web.WebManager:removeEventListener(web.WebManager.ALL_MODULE_REQUIRE_FINISH, self.__onAllModuleRequireFinishHandler, self)
    web.WebManager:removeEventListener(web.WebManager.REQ_SDK_ACCOUNT_LOGIN, self.__onReqSdkAccountLoginHandler, self)
end

-- 第一个界面模块初始化完毕回调
function __onFirstViewInitFinishHandler(self)
    web.setSplashTipProcess(nil)
    GameManager:setIsExiting(false)
    print("第一个界面模块初始化完毕回调")
    -- 对应的更新逻辑（分渠道包和非渠道包逻辑）
    if (web.WebManager:isReleaseApp()) then
        self:reqReportStep(web.REPORT_STEP.OPEN_UPDATE_RES_VIEW)
        if (download.ResDownLoadManager:getIsNeedRunUpdate()) then
            local isHasNetWork, isMobileNet, isWifi = web.getNetStatus()
            if (isHasNetWork) then
                self:reqCdnUrlInfo(2)			-- 请求web获取资源版本cdn后开始检测资源更新
            else
                UIFactory:alertOK0("网络提示", "当前网络不可用，请检查是否连接了可用的Wifi或移动网络", function() CS.Lylibs.SDKManager.Ins:RestartApplication() end)
            end
        end
    else
        local isHasNetWork, isMobileNet, isWifi = web.getNetStatus()
        if (isHasNetWork) then
            -- 判断是否允许运行更新逻辑
            if (web.WebManager.run_update_code) then
                -- 判断是否需要更新
                if (download.ResDownLoadManager:getIsNeedRunUpdate()) then
                    -- 开始检测资源更新
                    updateRes.UpdateResController:start()
                end
            end
        else
            UIFactory:alertOK0("网络提示", "当前网络不可用，请检查是否连接了可用的Wifi或移动网络", function() CS.Lylibs.SDKManager.Ins:RestartApplication() end)
        end
    end
end

-- 请求启动资源更新模块检测
function __onReqModuleUpdateCheckHandler(self, args)
    -- 先显示更新loading界面
    LuaUtil:reRequire("game/updateRes/Init")
end

-- 资源更新模块检测完毕回调
function __onModuleUpdateCheckFinishHandler(self)
    -- 资源更新模块检测完毕之后不需要再跑更新逻辑
    download.ResDownLoadManager:setIsNeedRunUpdate(false)
    -- 已经成功更新到了资源
    if (updateRes and updateRes.UpdateResManager:getIsNeedRestart()) then
        CS.Lylibs.Splash.Instance:OpenVisible()

        local preset3DNode = gs.GameObject.Find("[3D_PRESET]")
        if (preset3DNode) then
            gs.GameObject.Destroy(preset3DNode)
        end

        BoardShower:hideBoard()

        -- 关闭更新模块的加载界面
        updateRes.UpdateResManager:dispatchEvent(updateRes.UpdateResManager.CLOSE_LOADING_VIEW, {})

        updateRes.UpdateResManager:setIsNeedRestart(false)
        download.ResDownLoadManager:setIsNeedLoginSdk(true)
        self:__resetGame()
    else
        print("WebController", "启动各个游戏模块加载")
        LuaUtil:reRequire("game/common/controller/MainController").new()
    end
end

-- 所有功能模块加载完毕
function __onAllModuleRequireFinishHandler(self)
    GameManager:setIsExiting(false)
    -- 检查sdk和公告
    local function _checkSdkState()
        self:reqLoginNotice()						-- 请求登录公告
        if (web.WebManager:isReleaseApp()) then
            if (download.ResDownLoadManager:getIsNeedLoginSdk()) then
                self:__onReqSdkAccountLoginHandler()				-- 请求sdk账号登录
            else
                -- 检验用户，获取游戏服登录Token
                self:reqGameLoginTokenUrl(nil, 2)
            end
        else
            -- Debug界面包直接通知所有ok完成
            web.WebManager:dispatchEvent(web.WebManager.GAIN_ALL_DATA_FINISH, {})
        end
    end

    if (web.WebManager.preloadType == 1) then			-- 1：在显示登录界面之前
        -- 在预加载完成后再回调显示登录界面
        local function _preLoadFinishCall()                                                        
            -- 在登录界面显示并且生命周期Start触发后再回调请求sdk账号登录
            local function _loginViewShowCall()                                                    
                _checkSdkState()
            end
            -- 启动登录界面
            GameDispatcher:dispatchEvent(EventName.START_CHECK_LOGIN_VIEW, { loginViewShowCall = _loginViewShowCall })
        end
        -- 启动登录预加载
        GameDispatcher:dispatchEvent(EventName.START_CHECK_LOGIN_PRELOAD_VIEW, { preLoadFinishCall = _preLoadFinishCall, isAutoDestroy = false })
    elseif (web.WebManager.preloadType == 2) then		-- 2：在显示登录界面之后
        -- 在登录界面显示并且生命周期Start触发后再回调触发预加载
        local function _loginViewShowCall()                                                        
            -- 在预加载完成后再回调请求sdk账号登录
            local function _preLoadFinishCall()                                                    
                _checkSdkState()
            end
            -- 启动登录预加载
            GameDispatcher:dispatchEvent(EventName.START_CHECK_LOGIN_PRELOAD_VIEW, { preLoadFinishCall = _preLoadFinishCall, isAutoDestroy = true })
        end
        -- 启动登录界面
        GameDispatcher:dispatchEvent(EventName.START_CHECK_LOGIN_VIEW, { loginViewShowCall = _loginViewShowCall })
    elseif (web.WebManager.preloadType == 3) then		-- 3：在点击登录之后
        local function _loginViewShowCall()
            _checkSdkState()
        end
        -- 启动登录界面
        GameDispatcher:dispatchEvent(EventName.START_CHECK_LOGIN_VIEW, { loginViewShowCall = _loginViewShowCall })
    end
end

-- 获取登录公告
function reqLoginNotice(self)
    local url, parasmDic = web.getLoginNoticeUrl()
    local function correctCall(self, webData, jsonObj) web.WebManager:parseLoginNoticeData(webData, jsonObj) end
    local function errorCall(self, errorData, jsonObj) LoopManager:addTimer(1, 1, self, function() self:reqLoginNotice() end) end
    WebInterfaceUtil:postAsyncLoop(url, parasmDic, correctCall, errorCall, self, 1)
end

function __resetGame(self)
    sdk.SdkController:closeMemoryCheck()
    -- 各个C#模块注册的，该处不清理
    -- gs.LoopBehaviour.ClearLuaLoop()
    gs.AudioManager:ClearAll()
    gs.LuaLoopTick:ClearAll()
    gs.LanguageMgr:RemoveAllEvent()
    gs.UIComponentProxy:RemoveAllListeners()
    gs.SocketMessageCenter:ClearAllMessageHandlers()
    CS.Lylibs.DownloadManager.Instance:StopDownloadExit()
    -- 清理相关内存
    pcall(function()
        GCUtil.collectLuaGC()
        GCUtil.colllectCSharpGC()
        gs.GOPoolMgr:ClearAll()
        -- gs.ResMgr:ForceUnload(true, true)
        gs.ResMgr:Clear(true, true)
    end)
    CS.Game.Instance:ResetGame()
end

-- 请求sdk账号登录
function __onReqSdkAccountLoginHandler(self)
    if (self.sdkLoginCallBack) then
        sdk.SdkManager:removeEventListener(sdk.SdkManager.SDK_LOGIN, self.sdkLoginCallBack, self)
        self.sdkLoginCallBack = nil
    end
    self.sdkLoginCallBack = function(self, msg)
        self:reqReportStep(web.REPORT_STEP.SDK_ACCOUNT_DATA_PARSE)
        if (web.WebManager:parseSdkAccountInfo(msg)) then
            print("WebController", string.format("请求sdk账号登录成功，为%s", msg))
            -- sdk登录成功设置不需要登录sdk标识
            download.ResDownLoadManager:setIsNeedLoginSdk(false)
            self:reqReportStep(web.REPORT_STEP.SDK_ACCOUNT_LOGIN_SUC)
            -- 检验用户，获取游戏服登录Token
            self:reqGameLoginTokenUrl(nil, 2)
        else
            print("WebController", string.format("请求sdk账号登录失败，为%s", msg))
            -- sdk登录失败设置需要登录sdk标识
            download.ResDownLoadManager:setIsNeedLoginSdk(true)
            web.WebManager:dispatchEvent(web.WebManager.SDK_ACCOUNT_LOGIN_INTERRUPT, {})
        end
    end
    -- 整个游戏生命周期中需要保证有该监听
    sdk.SdkManager:addEventListener(sdk.SdkManager.SDK_LOGIN, self.sdkLoginCallBack, self)

    local function delayReqSdk()
        print("WebController", "请求sdk账号登录")
        self:reqReportStep(web.REPORT_STEP.REQ_SDK_ACCOUNT_LOGIN)
        if (GameManager:getGameState() == 1) then
            sdk.SdkManager:sdkLogin(false)
        else
            sdk.SdkManager:sdkLogin(true)
        end
    end
    LoopManager:addTimer(1, 1, self, delayReqSdk)

    -- -- 模拟测试
    -- -- 通知打开sdk账号登录，获得相关参数
    -- print("WebController", "模拟请求sdk账号登录")
    -- if(not self.sdkLoginCallBackSn)then
    -- 	local function _loopCall()
    -- 		LoopManager:removeTimerByIndex(self.sdkLoginCallBackSn)
    -- 		web.WebManager.web_login_time = math.floor(web.__getTime())
    -- 		web.WebManager.web_account_id = "模拟测试"
    -- 		web.WebManager.web_login_token = "" --MD5({account_id}+{time}+ {SRV_KEY})
    -- 		-- 检验用户，获取游戏服登录Token
    -- 		self:reqGameLoginTokenUrl(nil, 2)
    -- 	end
    -- 	self.sdkLoginCallBackSn = LoopManager:addTimer(1, 1, self, _loopCall)
    -- end
end

-- 获取CDN版本地址
function reqCdnUrlInfo(self, tryCount)
    print("WebController", "请求获取资源CDN版本")
    self:reqReportStep(web.REPORT_STEP.REQ_CDN_URL)

    local time = web.__getTime()
    local url, parasmDic = web.getRecommendServerInfoUrl()
    local function correctCall(self, webData, jsonObj)
        print("WebController", string.format("获取CDN版本数据：%s->响应，耗时：%s秒", webData, web.__getTime() - time))
        -- 此处可能没网络
        if (jsonObj == nil) then
            print("WebController", string.format("网络异常请重试！提示码：%s", web.TIP_CODE.RECOMMEND_SERVER_NET_ERROR))
            local titleTip = string.format("网络异常请重试！提示码：%s", web.TIP_CODE.RECOMMEND_SERVER_NET_ERROR)
            if (string.find(webData, "<html") ~= nil) then
                titleTip = titleTip .. "，" .. web.RECOMMEND_SUB_CODE.HTML_CONTENT
            end
            UIFactory:alertOK0("网络提示", titleTip,
            function()
                WebInterfaceUtil:postAsyncLoop(url, parasmDic, correctCall, function(self, errorData, jsonObj) correctCall(self, errorData, nil) end, self, tryCount)
            end)
        else
            self:reqReportStep(web.REPORT_STEP.CDN_URL_PARSE)
            local subCode = web.WebManager:parseRecommandServerData(webData, jsonObj)
            if (subCode == web.RECOMMEND_SUB_CODE.NORMAL) then
                self:reqReportStep(web.REPORT_STEP.GET_CDN_URL_SUC)
                -- 开始检测资源更新
                updateRes.UpdateResController:start()
            else
                print("WebController", string.format("网络异常请重试！提示码：%s，%s", web.TIP_CODE.CDN_ERROR, subCode))
                UIFactory:alertOK0("网络提示", string.format("网络异常请重试！提示码：%s，%s", web.TIP_CODE.CDN_ERROR, subCode),
                function()
                    WebInterfaceUtil:postAsyncLoop(url, parasmDic, correctCall, function(self, errorData, jsonObj) correctCall(self, errorData, nil) end, self, tryCount)
                end)
            end
        end
    end
    WebInterfaceUtil:postAsyncLoop(url, parasmDic, correctCall, function(self, errorData, jsonObj) correctCall(self, errorData, nil) end, self, tryCount)
end

-- 获取游戏服登录token
function reqGameLoginTokenUrl(self, isYingYongBao, tryCount)
    local time = web.__getTime()
    local url, parasmDic = web.getGameLoginTokenUrl(isYingYongBao)
    print("WebController", string.format("请求获取游戏服登录token：%s", url))
    self:reqReportStep(web.REPORT_STEP.REQ_GAME_LOGIN_TOKEN)

    local function correctCall(self, webData, jsonObj)
        print("WebController", string.format("获取游戏服登录token->响应，耗时：%s秒", web.__getTime() - time))
        if (jsonObj == nil) then
            print("WebController", string.format("获取游戏服登录token->提示码：%s", web.TIP_CODE.LOGIN_TOKEN_NET_ERROR))
            local titleTip = string.format("网络异常请重试！提示码：%s", web.TIP_CODE.LOGIN_TOKEN_NET_ERROR)
            if (string.find(webData, "<html") ~= nil) then
                titleTip = titleTip .. "，" .. web.GAME_LOGIN_TOKEN_SUB_CODE.HTML_CONTENT
            end
            UIFactory:alertOK0("网络提示", titleTip,
            function()
                -- 请求sdk账号登录：sdk账号token可能会过期了或者sdk登录那边连点登录多次拿到了旧的token，每次游戏服登录token失败了就从请求sdk账号token重新来过
                download.ResDownLoadManager:setIsNeedLoginSdk(true)
                self:__onReqSdkAccountLoginHandler()
            end)
        else
            self:reqReportStep(web.REPORT_STEP.GAME_LOGIN_TOKEN_PARSE)
            local subCode = web.WebManager:parseGameTokenData(webData, jsonObj)
            if (subCode == web.GAME_LOGIN_TOKEN_SUB_CODE.NORMAL) then
                print("WebController", "获取游戏服登录token->成功")
                self:reqReportStep(web.REPORT_STEP.GET_GAME_LOGIN_TOKEN_SUC)
                self:reqRecommendServerInfo(nil, 2)
            else
                print("获取游戏服登录token->过期，等待玩家操作")
                -- UIFactory:alertOK0("网络提示", string.format("网络异常请重试！提示码：%s，%s", web.TIP_CODE.GAME_LOGIN_TOKEN_ERROR, subCode), 
                -- 	function() 
                -- 		print("获取游戏服登录token->过期，开始重新sdk登录")
                -- 		-- 请求sdk账号登录：sdk账号token可能会过期了或者sdk登录那边连点登录多次拿到了旧的token，每次游戏服登录token失败了就从请求sdk账号token重新来过
                -- 		download.ResDownLoadManager:setIsNeedLoginSdk(true)
                -- 		self:__onReqSdkAccountLoginHandler()
                -- 	end)
                print("WebController", "游戏服登录token可能失效了，将重新登录sdk")
                -- 请求sdk账号登录：sdk账号token可能会过期了或者sdk登录那边连点登录多次拿到了旧的token，每次游戏服登录token失败了就从请求sdk账号token重新来过
                download.ResDownLoadManager:setIsNeedLoginSdk(true)
                self:__onReqSdkAccountLoginHandler()
            end
        end
    end
    WebInterfaceUtil:postAsyncLoop(url, parasmDic, correctCall, function(self, errorData, jsonObj) correctCall(self, errorData, nil) end, self, tryCount)
end

-- 获取指定服或推荐服 列表
function reqRecommendServerInfo(self, loginCallBack, tryCount)
    local tip = loginCallBack and "登录->" or ""
    print("WebController", string.format("%s%s", tip, "获取指定服或推荐服->开始"))
    self:reqReportStep(web.REPORT_STEP.REQ_RECOMMENT_SERVER_LIST)

    local time = web.__getTime()
    local url, parasmDic = web.getRecommendServerInfoUrl()
    local function correctCall(self, webData, jsonObj)
        print("WebController", string.format(tip .. "获取指定服或推荐服->响应，耗时：%s秒", web.__getTime() - time))
        if (jsonObj == nil) then
            print("WebController", string.format(tip .. "获取指定服或推荐服->提示码：%s", web.TIP_CODE.CDN_NET_ERROR))
            local titleTip = string.format("网络异常请重试！提示码：%s", web.TIP_CODE.CDN_NET_ERROR)
            if (string.find(webData, "<html") ~= nil) then
                titleTip = titleTip .. "，" .. web.RECOMMEND_SUB_CODE.HTML_CONTENT
            end
            UIFactory:alertOK0("网络提示", titleTip,
            function()
                WebInterfaceUtil:postAsyncLoop(url, parasmDic, correctCall, function(self, errorData, jsonObj) correctCall(self, errorData, nil) end, self, tryCount)
            end)
        else
            self:reqReportStep(web.REPORT_STEP.RECOMMENT_SERVER_LIST_PARSE)
            local subCode = web.WebManager:parseRecommandServerData(webData, jsonObj)
            if (subCode == web.RECOMMEND_SUB_CODE.NORMAL) then
                print("WebController", tip .. "获取指定服或推荐服->成功")
                self:reqReportStep(web.REPORT_STEP.GET_RECOMMENT_SERVER_LIST_SUC)
                web.WebManager:dispatchEvent(web.WebManager.GAIN_ALL_DATA_FINISH, {})
                if (loginCallBack) then
                    loginCallBack(true)
                end
            else
                if (loginCallBack) then
                    loginCallBack(false)
                    print("WebController", string.format("网络异常请重试！提示码：%s，%s", web.TIP_CODE.LOGIN_RECOMMEND_ERROR, subCode))
                    UIFactory:alertOK0("网络提示", string.format("网络异常请重试！提示码：%s，%s", web.TIP_CODE.LOGIN_RECOMMEND_ERROR, subCode),
                    function()
                        WebInterfaceUtil:postAsyncLoop(url, parasmDic, correctCall, function(self, errorData, jsonObj) correctCall(self, errorData, nil) end, self, tryCount)
                    end)
                else
                    print("WebController", string.format("网络异常请重试！提示码：%s，%s", web.TIP_CODE.RECOMMEND_ERROR, subCode))
                    UIFactory:alertOK0("网络提示", string.format("网络异常请重试！提示码：%s，%s", web.TIP_CODE.RECOMMEND_ERROR, subCode),
                    function()
                        WebInterfaceUtil:postAsyncLoop(url, parasmDic, correctCall, function(self, errorData, jsonObj) correctCall(self, errorData, nil) end, self, tryCount)
                    end)
                end
            end
        end
    end
    WebInterfaceUtil:postAsyncLoop(url, parasmDic, correctCall, function(self, errorData, jsonObj) correctCall(self, errorData, nil) end, self, tryCount)
end

-- bug统计
function reqBug(self, tag, content, isSendAndClear)
    web.ADD_BUG_CACHE(tag, content)
    if (isSendAndClear and web.WebManager:isReleaseApp()) then
        local bugList = web.GET_BUG_CACHE(tag)
        if (bugList and #bugList > 0) then
            local bugListContent = ""
            for i = 1, #bugList do
                bugListContent = bugListContent .. string.format("\n[%s][%s] %s：%s", os.date("%Y-%m-%d %H:%M:%S", web.__getTime()), tag, i, bugList[i])
            end
            local url, parasmDic = web.getBugUrl(bugListContent)
            local function correctCall(self, webData, jsonObj) web.WebManager:parseBugData(webData, jsonObj) end
            local function errorCall(self, errorData, jsonObj) end
            WebInterfaceUtil:postAsyncLoop(url, parasmDic, correctCall, errorCall, self, 1)
        end
        web.DEL_BUG_CACHE(tag, nil)
    end
end

-- 上报步骤统计
function reqReportStep(self, step)
    local time = web.__getTime()
    web.SET_REPORT_STEP_TIME_CACHE(step, time)-- 缓存当前步骤时间戳
    local getIpCall = function(ip)
        local url, parasmDic = web.getReportStepUrl(step, time)
        local function correctCall(self, webData, jsonObj)
            web.WebManager:parseReportStepData(webData, jsonObj)
        end
        local function errorCall(self, errorData, jsonObj) end
        WebInterfaceUtil:postAsyncLoop(url, parasmDic, correctCall, errorCall, self, 1)
    end
    self:reqIpUrl(getIpCall)
end

-- 获取QQ客服
function reqQQServiceUrl(self)
    local url, parasmDic = web.getQQServiceUrl()
    local function correctCall(self, webData, jsonObj)
        web.WebManager:parseQQServiceData(webData, jsonObj)
    end
    local function errorCall(self, errorData, jsonObj) end
    WebInterfaceUtil:postAsyncLoop(url, parasmDic, correctCall, errorCall, self, 1)
end

-- 请求充值订单
function reqRecharge(self, itemId, money, moneyType, itemTitle, itemName, itemDes, successFun, failFun)
    UIFactory:showNetRollView()
    local url = web.getRechargeOrderUrl(itemId, money, moneyType)
    local function correctCall(self, webData, jsonObj)
        if (jsonObj == nil) then
            UIFactory:closeNetRollView()
            return
        end
        if (not jsonObj.data) then
            UIFactory:closeNetRollView()
            if (tonumber(jsonObj.errorcode) == 15) then
                gs.Message.Show("超过购买次数")
            else
                gs.Message.Show("环境异常，提示码：" .. tostring(jsonObj.errorcode))
            end
            print("WebManager", "请求充值订单返回出错：" .. webData)
            return
        end
        if (jsonObj.status == 0) then
            UIFactory:closeNetRollView()
            local message = CS.Lylibs.UTF8StringUtil.GetString(jsonObj.message)
            print("WebManager", "请求充值订单返回出错：" .. message .. " => " .. webData)
        else
            print("WebManager", "请求充值订单返回：" .. webData)

            if (self.sdkRechargeCallBack) then
                sdk.SdkManager:removeEventListener(sdk.SdkManager.SDK_RECHARGE, self.sdkRechargeCallBack, self)
                self.sdkRechargeCallBack = nil
            end
            self.sdkRechargeCallBack = function(self, rechargeData)
                sdk.SdkManager:removeEventListener(sdk.SdkManager.SDK_RECHARGE, self.sdkRechargeCallBack, self)
                UIFactory:closeNetRollView()
                if (rechargeData ~= nil and rechargeData.isSuccess ~= nil and tonumber(rechargeData.isSuccess) == 1) then
                    if (successFun) then
                        successFun()
                    else
                        local channelId, channelName = sdk.SdkManager:getChannelData()
                        if (channelId ~= sdk.AndroidChannelId.QIANYOU and channelId ~= sdk.AndroidChannelId.DANDANYOU and channelId ~= sdk.AndroidChannelId.QUICK and channelId ~= sdk.AndroidChannelId.QUICK2 and channelId ~= sdk.AndroidChannelId.QUICK3) then
                            gs.Message.Show("充值成功")
                        end
                    end
                    logInfo("充值成功", "SdkManager")
                else
                    if (failFun) then
                        failFun()
                    else
                        local channelId, channelName = sdk.SdkManager:getChannelData()
                        if (channelId ~= sdk.AndroidChannelId.QIANYOU and channelId ~= sdk.AndroidChannelId.DANDANYOU and channelId ~= sdk.AndroidChannelId.QUICK and channelId ~= sdk.AndroidChannelId.QUICK2 and channelId ~= sdk.AndroidChannelId.QUICK3) then
                            gs.Message.Show("充值失败")
                        end
                    end
                    logInfo("充值失败：" .. rechargeData.gameExt .. "，" .. rechargeData.code .. "，" .. rechargeData.des, "SdkManager")
                end
            end
            sdk.SdkManager:addEventListener(sdk.SdkManager.SDK_RECHARGE, self.sdkRechargeCallBack, self)
            sdk.SdkManager:pay(jsonObj.data.order_id, jsonObj.data.url, itemId, money, itemTitle, itemName, itemDes, false)
        end
    end
    local function errorCall(self, errorData, jsonObj)
        print("WebManager", "请求充值订单报错：" .. errorData)
        correctCall(self, nil, nil)
    end
    WebInterfaceUtil:getAsyncLoop(url, correctCall, errorCall, self, 1)
end

-- 获取IP数据
function reqIpUrl(self, callFun)
    if (web.WebManager.web_ip) then
        if (callFun) then
            callFun(web.WebManager.web_ip)
        end
    else
        local url, parasmDic = web.getIPUrl()
        local function correctCall(self, webData, jsonObj)
            web.WebManager:parseIpData(webData, jsonObj)
            if (callFun) then
                callFun(web.WebManager.web_ip)
            end
        end
        local function errorCall(self, errorData, jsonObj) LoopManager:addTimer(1, 1, self, function() self:reqIpUrl(callFun) end) end
        WebInterfaceUtil:postAsyncLoop(url, parasmDic, correctCall, errorCall, self, 1)
    end
end

-- 请求debug登录权限
function reqClientAuthLogin(self, callFun)
    local url, parasmDic = web.getClientAuthLoginUrl()
    local function correctCall(self, webData, jsonObj)
        if jsonObj.status == 1 then
            login.LoginManager.clientAuthLv = tonumber(jsonObj.data)
            if (callFun) then
                callFun()
            end
        else
            gs.Message.Show("客户端登录权限验证失败，请联系客户端申请")
        end
    end
    local function errorCall(self, errorData, jsonObj)
        print("WebManager", "请求登录权限错误" .. errorData)
        correctCall(self, nil, nil)
    end
    WebInterfaceUtil:postAsyncLoop(url, parasmDic, correctCall, errorCall, self, 1)
end








function openSecretPassWord(self, dataList)
    LoopManager:removeFrame(self, self.onFrameHandler)
    self.WebCollectDataList = dataList
    self:__initSecretPassWord()
    LoopManager:addFrame(1, 0, self, self.onFrameHandler)
end

function __initSecretPassWord(self)
    self.mClickDeltaTime = 0.5
    self.mLasClickDeltaTime = nil
    self.mPassWordList = {}
    if (self.WebCollectDataList and #self.WebCollectDataList > 0) then
        for i = 1, #self.WebCollectDataList do
            local data = self.WebCollectDataList[i]
            local itemData = {}
            itemData.type = data.type
            itemData.passWordList = data.password_list
            self:__recoveryPassWordList(itemData)
            if (#data.password_list <= 0) then
                self:__triggerPassWord(itemData)
                itemData = nil
            else
                table.insert(self.mPassWordList, itemData)
            end
        end
    end
end

function __recoveryPassWordList(self, itemData)
    itemData.isNowLeft = true
    itemData.tempPassWordList = {}
    table.merge(itemData.tempPassWordList, itemData.passWordList)
end

function onFrameHandler(self, deltaTime)
    if (self.mLasClickDeltaTime ~= nil) then
        self.mLasClickDeltaTime = self.mLasClickDeltaTime + deltaTime
        if (self.mLasClickDeltaTime >= self.mClickDeltaTime) then
            self:__initSecretPassWord()
        end
    end
    if (gs.Input.GetMouseButtonUp(0) == true) then
        if (self.mLasClickDeltaTime == nil) then
            self.mLasClickDeltaTime = 0
        end
        self.mDownX = gs.Input.mousePosition.x
        for i = 1, #self.mPassWordList do
            local itemData = self.mPassWordList[i] -- itemData.type、itemData.isNowLeft、itemData.passWordList
            local result = nil
            local halfW = math.floor(gs.Screen.width) / 2
            if (itemData.isNowLeft) then
                if (self.mDownX > 0 and self.mDownX < halfW) then
                    result = true
                else
                    result = false
                end
            else
                if (self.mDownX > 0 and self.mDownX < halfW) then
                    result = false
                else
                    result = true
                end
            end
            if (result) then
                if (#itemData.tempPassWordList > 0) then
                    self.mLasClickDeltaTime = 0
                    itemData.tempPassWordList[1] = itemData.tempPassWordList[1] - 1
                    if (itemData.tempPassWordList[1] <= 0) then
                        table.remove(itemData.tempPassWordList, 1)
                        if (#itemData.tempPassWordList > 0) then
                            itemData.isNowLeft = not itemData.isNowLeft
                        else
                            self:__triggerPassWord(itemData)
                            self:__initSecretPassWord()
                            break
                        end
                    end
                else
                    self:__initSecretPassWord()
                end
            else
                self:__recoveryPassWordList(itemData)
            end
        end
    end
end

function __triggerPassWord(self, itemData)
    local isUseReporter = false
    if (itemData.type == web.DEBUG_LOG_COLLECT_TYPE.AUTO_REAL_TIME_UPLOAD) then
        web.setLogCollectType(web.DEBUG_LOG_COLLECT_TYPE.AUTO_REAL_TIME_UPLOAD)
        gs.Message.Show(string.format("%s成功", web.DEBUG_LOG_COLLECT_TYPE.AUTO_REAL_TIME_UPLOAD))
    elseif (itemData.type == web.DEBUG_LOG_COLLECT_TYPE.OPEN_DETAIL_DOWNLOAD_LOG) then
        web.setLogCollectType(web.DEBUG_LOG_COLLECT_TYPE.OPEN_DETAIL_DOWNLOAD_LOG)
        if (isUseReporter) then
            gs.ApplicationUtil.SetDebugBackgroundCollect(true)
        end
        CS.Lylibs.ResDownLoadManager.Instance.IsPrintLog = true
        CS.Lylibs.DownloadManager.Instance.IsPrintLog = true
        CS.Lylibs.ZipDownLoadManager.Instance.TestCode = true
        CS.Lylibs.ZipDownloadTask.TestCode = true
        CS.Lylibs.ZipMissionManager.TestCode = true
        CS.Lylibs.ZipUnzipTask.TestCode = true
        CS.Lylibs.ZipValidationTask.TestCode = true
        gs.Message.Show(string.format("%s成功", web.DEBUG_LOG_COLLECT_TYPE.OPEN_DETAIL_DOWNLOAD_LOG))

    elseif (itemData.type == web.DEBUG_LOG_COLLECT_TYPE.MANUAL_FILE_UPLOAD) then
        if (isUseReporter) then
            local remoteFileName = string.format("LyGameLog_%s_%s_%s", web.WebManager.platform, web.WebManager.channel_id, sdk.SdkManager:getUniqueId())
            local saveFilePath = gs.PathUtil.GetPersistentAssetsWPath("LyGameLog.txt")
            local content = gs.ApplicationUtil.GetDebugBackgroundCollect(saveFilePath)
            if (content ~= "") then
                local function successCall(responseCode, msg)
                    gs.Message.Show(string.format("%s成功：%s，%s", web.DEBUG_LOG_COLLECT_TYPE.MANUAL_FILE_UPLOAD, responseCode, msg))
                end
                local function failCall(responseCode, msg)
                    gs.Message.Show(string.format("%s失败：%s，%s", web.DEBUG_LOG_COLLECT_TYPE.MANUAL_FILE_UPLOAD, responseCode, msg))
                end
                web.uploadFile(isUseReporter, saveFilePath, remoteFileName, successCall, failCall)
            end
        else
            local remoteFileName = string.format("LyGameLog_%s_%s_%s", web.WebManager.platform, web.WebManager.channel_id, sdk.SdkManager:getUniqueId())
            local saveFilePath = CS.Lylibs.LogManager.Instance.logFilePath
            local function successCall(responseCode, msg)
                gs.Message.Show(string.format("%s成功：%s，%s", web.DEBUG_LOG_COLLECT_TYPE.MANUAL_FILE_UPLOAD, responseCode, msg))
            end
            local function failCall(responseCode, msg)
                gs.Message.Show(string.format("%s失败：%s，%s", web.DEBUG_LOG_COLLECT_TYPE.MANUAL_FILE_UPLOAD, responseCode, msg))
            end
            web.uploadFile(isUseReporter, saveFilePath, remoteFileName, successCall, failCall)
        end

        web.setLogCollectType(web.DEBUG_LOG_COLLECT_TYPE.NONE)
        if (isUseReporter) then
            gs.ApplicationUtil.SetDebugBackgroundCollect(false)
        end
        CS.Lylibs.ResDownLoadManager.Instance.IsPrintLog = false
        CS.Lylibs.DownloadManager.Instance.IsPrintLog = false
        CS.Lylibs.ZipDownLoadManager.Instance.TestCode = false
        CS.Lylibs.ZipDownloadTask.TestCode = false
        CS.Lylibs.ZipMissionManager.TestCode = false
        CS.Lylibs.ZipUnzipTask.TestCode = false
        CS.Lylibs.ZipValidationTask.TestCode = false

    elseif (itemData.type == web.DEBUG_LOG_COLLECT_TYPE.PRIVATE_INNER_DEBUG_LOG_SHOW) then
        if (not web.WebManager:isReleaseApp()) then
            GameManager.IS_DEBUG = true
            Debug:setLogAllow(GameManager.IS_DEBUG)
            gs.ApplicationUtil.SetDebugVisible(GameManager.IS_DEBUG)
            gs.ApplicationUtil.ShowDebugView()
        end
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(49):	"系统提示"
]]