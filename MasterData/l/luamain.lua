-- Desc: LuaMain是整个游戋的核心类，它是一个MonoBehaviour的子类，通过这个类，完成整个游戏的逻辑驱动
-- 游戏启动的时候，通过MonoBehaviour的生命周期管理，来触发LuaMain的Start函数，然后，进入游戏的主循环
-- 通过LuaMain的Update函数，来完成整个游戏的逻辑驱动
-- 通过LuaMain的OnDestroy函数，来完成整个游戏的资源释放

require "LuaPath"

Restart = function()
    if ClientData then
        ClientData:Clear()
    end
    if ResMgr then
        ResMgr:Clear()
    end
    if PoolMgr then
        PoolMgr:Clear()
    end
    if UIMgr then
        UIMgr:Clear()
    end
    if StateMgr then
        StateMgr:Clear()
    end
    if GuideMgr then
        GuideMgr:Clear()
    end
    if StoryMgr then
        StoryMgr:Clear()
    end
    if GameMsgMgr then
        GameMsgMgr:Clear()
    end
    if LoadingMgr then
        LoadingMgr:Clear()
    end
    if LuaAsyncMgr then
        LuaAsyncMgr:Clear()
    end

    if SeaMapMgr then
        SeaMapMgr:Clear()
    end

    if CoveManager then
        CoveManager:clear()
    end

    -- if RaffleMgr then
    --     RaffleMgr:Clear()
    -- end

    if QualitySettingsMgr then
        QualitySettingsMgr:Clear()
    end

    GameInput.Slash = nil
    g_GameMain:Restart()
end

ClearAllCSharpUI = function()
    if UIMgr and UIMgr.clearAllCSharpUI then
        UIMgr:clearAllCSharpUI()
    end
end

LuaMgr.Instance:LaterStart(g_GameMain.gameObject)

require "dglobal"
-- require "zbdebug"
require "luacross"
require "luaext"
require "class"
require "DLuaUtil"
require "LuaMonoBehavior"

G.Declare("LuaMain", "GameFlowFSM", "ResMgr", "PoolMgr", "AudioMgr", "Me", "AccountPrefs", "CommonLogic", "UICommonUtils",
    "UIMgr", "StateMgr", "SDKMgr", "PayMgr", "ClientData", "DLuaTimer", "TimeMgr", "server", "callFunc",
    "GameMsgMgr", "LoginNetHandler", "GameNetHandler", "Standalone", "GlobalInfo", "AddictionPrevention", "g_MainPanel", "RedPointMgr", "NativeInfoLua", "LuaFileLogger",
    "DFileLoggerInst", "GuideMgr", "LoadingMgr", "NotificationMgr" ,"HttpCrypt",
    "ThinkingAnalytics", "BattleCore", "LuaAsyncMgr", "SeaMapMgr", "CoveManager",  "CovePropsMgr", "DisplayConfigMgr",
    "RaffleMgr","QualitySettingsMgr", "CoveBattleMgr", "CoveRoleManager", "ClientBattleManager", "UIObj", "StoryMgr",
    "DFileLoggerInst", "AppleIAPManager", "PayManager", "HuaWeiPurchaseManager", "GameInput", "WXLuaManager","WebGLManager","DPlayerPrefsGlobal", "SurvivalManager", "AutoChessManager")

if EngineGlobal.GetPlatformName() == "WebGL" and EngineGlobal.luaMode == EngineGlobal.LuaMode.PackMode then
    require "protobuf"
else
    --require "3rd/pbc/protobuf"
end



-- 在真机上，低性能接口禁用，如果需要print，使用Debugger.Log
if UnityEngine.Application.platform == UnityEngine.RuntimePlatform.Android or UnityEngine.Application.platform == UnityEngine.RuntimePlatform.IPhonePlayer then
    function dump(...)
        return ""
    end
    function table_dump(...)
        return ""
    end
    function table.dump(...)
        return ""
    end
    function debug.traceback(...)
        return ""
    end
    function tablex.dump(...)
        return ""
    end
end

require "LuaLogger"
require "DQueue"
require "CommonType"
require "GlobalConfig"  -- 在CommonType之后
require("Config").Load()
require "CommonConstant"
--require "tolua"
require "EngineUtil"

local platform = require "platform"

UIBase = require "UIBase"
-- protobuf.ExtractEnabled = true

local LuaMain = class("LuaMain", LuaMonoBehavior)

require "GameFlowState"
require "FSM"

-- LuaMain是在LuaRestart后，整个游戏的核心主循环
-- 通过跟LuaMono相结合，让LuaMain这个代码具有了MonoBehaviour的生命周期管理规则，从而利用这个类来完成整个逻辑代码的驱动
-- commented by xingyan
function LuaMain:ctor(...)
    ---@type FSM
    GameFlowFSM = nil

    ---@type ResMgr
    ResMgr = nil
    
    ---@type PoolMgr
    PoolMgr = nil
    
    ---@type UIMgr
    UIMgr = nil
    
    ---@type StateMgr
    StateMgr = nil
    
    ---@type SDK
    SDKMgr = nil
    
    ---@type Pay
    PayMgr = nil
    
    CommonLogic = nil
    
    ---@type ClientData
    ClientData = nil
    
    ---@type MsgMgr
    GameMsgMgr = nil
    
    UICommonUtils = nil
    
    ---@type LoginNetManager
    LoginNetHandler = nil
    
    ---@type GameNetManager
    GameNetHandler = nil

    -- Standalone = false

    GlobalInfo = nil
    
    ---@type RedPointMgr
    RedPointMgr = nil

    ---@type WXLuaManager
    WXLuaManager = nil

    ---@type GuideMgr
    GuideMgr = nil

    ---@type StoryMgr
    StoryMgr = nil

    ---@type LoadingMgr
    LoadingMgr = nil

    ---@type LuaAsyncMgr
    LuaAsyncMgr = nil

    ---@type NotificationMgr
    NotificationMgr = nil

    ThinkingAnalytics = nil
    ---@type BattleCore
    BattleCore = nil

    DisplayConfigMgr = nil

    CoveRoleManager = nil
    ClientBattleManager = nil
    SurvivalManager = nil


    ---@type HttpCrypt
    HttpCrypt = nil

    ---@type RaffleMgr
    RaffleMgr = nil
    

    DPlayerPrefsGlobal = nil
    self.CheckState = nil
    self.LoginState = nil
    self.BattleState = nil
    self.SurvivalState = nil

    ---@type QualitySettingsMgr
    QualitySettingsMgr = nil

    ---@type UIObj
    UIObj = nil
    

    tolua = tolua or nil

    System = System or nil

    -- AssetManager = AssetManager or nil

    --ErrorLog = ErrorLog or nil

    -- UnityEngine.PlayerPrefs.DeleteAll()
end

function _genNativeInfoLua()
    NativeInfoLua = {}
    function NativeInfoLua.GetDeviceID()
        if not NativeInfoLua.NewDeviceId then
            local cjson = require "cjson"
            local md5Lua = require "md5Lua"
            local toHashDevice = NativeInfo.GetDeviceID()
            local deviceInfo = NativeInfoLua.GetDeviceDetail()
            local ok, deviceInfoTb = pcall(cjson.decode, deviceInfo)
            if ok then
                toHashDevice = toHashDevice .. '|' .. deviceInfoTb.deviceUniqueIdentifier
            end

            LuaLogger.ds("toHashDevice", toHashDevice)
            NativeInfoLua.NewDeviceId = md5Lua.sumhexa(toHashDevice)
        end

        return NativeInfoLua.NewDeviceId
    end

    function NativeInfoLua.GetDeviceDetail()
        if not NativeInfoLua.NewDeviceDetail then
            local deviceInfo = NativeInfo.GetDeviceDetail() or ""
            deviceInfo = deviceInfo:gsub("'", "''")
            deviceInfo = deviceInfo:gsub("\n", "")

            local deviceNameStart, deviceNameValueIndex = deviceInfo:find("\"deviceName\":\"", 1, true)
            local deviceModelStartIndex = deviceInfo:find("\"deviceModel\":\"", 1, true)
            if deviceNameValueIndex and deviceModelStartIndex then
                local deviceName = deviceInfo:sub(deviceNameValueIndex + 1, deviceModelStartIndex - 3)
                if deviceName:find("\"", 1, true) then
                    local newDeviceName = deviceName:gsub("\"", "")
                    deviceName = deviceName:gsub("%(", "%%(")
                    deviceName = deviceName:gsub("%)", "%%)")
                    deviceInfo = deviceInfo:gsub(deviceName, newDeviceName)
                    --deviceInfo = deviceInfo:gsub("\\", "\\\\") -- 处理\问题
                end
                
                if deviceInfo:find("\\", 1, true) then
                    deviceInfo = deviceInfo:gsub("\\", "") -- 处理\问题
                end
            end
            
            NativeInfoLua.NewDeviceDetail = deviceInfo
        end
        
        return NativeInfoLua.NewDeviceDetail
    end
end

mri = require("MemoryReferenceInfo")
mri.m_cConfig.m_bAllMemoryRefFileAddTime = false

Shot01 = function()
    -- collectgarbage("collect")
    LuaMgr:ClearMemory()
    -- collectgarbage("collect")
    local savePath = UnityEngine.Application.persistentDataPath.."/"
    if GV.IsEditor then
        savePath = ""
    end
    mri.m_cMethods.DumpMemorySnapshot(savePath, "1-Before", -1)
end

Shot02 = function()
    local savePath = UnityEngine.Application.persistentDataPath.."/"
    if GV.IsEditor then
        savePath = ""
    end
    collectgarbage("collect")
    LuaMgr:ClearMemory()
    collectgarbage("collect")
    mri.m_cMethods.DumpMemorySnapshot(savePath, "2-After", -1)

    --print("lua shot compare 33333")
    collectgarbage("collect")
    LuaMgr:ClearMemory()
    collectgarbage("collect")
    mri.m_cMethods.DumpMemorySnapshotComparedFile(savePath, "Compared", -1, "./LuaMemRefInfo-All-[1-Before].txt", "./LuaMemRefInfo-All-[2-After].txt")
end

-- 利用Mono的Start特性，来启动LuaMain的Start函数，这相当于完成热更后，进入游戏的核心初始化阶段，然后，进入系统的update循环
function LuaMain:Start()
    if EngineUtil.IsWebGL() then
        self._luaInitCo = coroutine.create(function()
            self:DoStart()
        end)
    else
        self:DoStart()
    end
end

function LuaMain:DoStart()
    self:SetUpdateInterval(0)
    GV.IsIOSLogic = UnityEngine.Application.platform == UnityEngine.RuntimePlatform.IPhonePlayer
    GV.IsWebGL = EngineUtil.IsWebGL()
    GV.IsEditor = UnityEngine.Application.platform == UnityEngine.RuntimePlatform.WindowsEditor
        or UnityEngine.Application.platform == UnityEngine.RuntimePlatform.OSXEditor
    if GV.IsEditor then
        GV.GlobalConfig.LocalServerTest = true
    end
    LuaLogger.ds("LuaMain Start version:" .. tostring(_VERSION))

    --local logFilePath = UnityEngine.Application.persistentDataPath .. "/kyjh_error"
    --LuaFileLogger = require "DLuaFileLogger":new(logFilePath)
    --LuaFileLogger:open()
    --
    --UnityEngine.Application.logMessageReceived = UnityEngine.Application.logMessageReceived + function (logString, stackTrace, logType)
    --    local logTypeStr = tostring(logType)
    --    if logTypeStr == "Error" or logTypeStr == "Exception" then --  or logTypeStr == "Warning"
    --        LuaFileLogger:writeLine(logString)
    --        LuaFileLogger:writeLine(stackTrace)
    --        --LuaLogger.ds("abc", logTypeStr, logString)
    --    end
    --end

    --DFileLoggerInst = DFileLogger.Instance
    if EngineUtil.IsWebGL() then
        g_GameMain:SetUpdateProgress(0.75, nil)
        coroutine.yield()
    end
    
    _genNativeInfoLua()
    
    LuaLogger.ds("DID", NativeInfoLua.GetDeviceID())

    self.gameObject:GetOrAddComponent(typeof(LoadManager))
    self.gameObject:GetOrAddComponent(typeof(PoolManager))
    self.gameObject:GetOrAddComponent(typeof(SMSceneManager))
    self.gameObject:GetOrAddComponent(typeof(UIManager))
    self.gameObject:GetOrAddComponent(typeof(BaseTouchInput))
    self.gameObject:GetOrAddComponent(typeof(AudioManager))
    self.gameObject:GetOrAddComponent(typeof(DisplayConfigManager))
    self.gameObject:GetOrAddComponent(typeof(QualitySettingsManager))

    GV.AdLogic = require "AdLogic"
    GV.AdLogic.Init()

    if EngineUtil.IsWebGL() then
        g_GameMain:SetUpdateProgress(0.8, nil)
        coroutine.yield()
    end
    
    ResMgr = require("ResMgr"):new()

    if EngineUtil.IsWebGL() then
        g_GameMain:SetUpdateProgress(0.9, nil)
        coroutine.yield()
    end

    PoolMgr = require("PoolMgr"):new()
    RedPointMgr = require "RedPointMgr":new()
    DPlayerPrefsGlobal = require "DPlayerPrefs":new("")
    ---@type UIMgr
    UIMgr = require("UIMgr"):new()
    ---@type AudioMgr
    AudioMgr = require "AudioMgr":new()
    StateMgr = require("StateMgr"):new()
    SDKMgr = require("SDK"):new(platform.passport, platform.passporturl)
    PayMgr = require("Pay"):new(self.gameObject)
    ---@type DLuaTimer
    DLuaTimer = require "DLuaTimer":new()

    ---@type TimeMgr
    TimeMgr = require "TimeMgr":new()
    
    BattleCore = require"BattleCore"
    DisplayConfigMgr = require "DisplayConfigMgr":new()
    CoveRoleManager = require("CoveRoleManager")
    SurvivalManager = require("SurvivalManager")

    ResMgr:LoadLuaTable()
    ResMgr:LoadConfig()

    GuideMgr = require("GuideMgr"):new()
    StoryMgr = require("StoryMgr"):new()
    LoadingMgr = require("LoadingMgr"):new()
    LuaAsyncMgr = require("LuaAsyncMgr"):new()
    RaffleMgr = require("RaffleMgr"):new()

    QualitySettingsMgr = require("QualitySettingsMgr"):new()
    UIObj = require("UIObj")

    -- 原来的Character类的全局变量，改在LuaMain进行初始化，而不放在SelectUserState中进行初始化
    -- Character作为客户端存储用户数据的唯一单例，虽然没有用单例的形式来进行表达，而是用了一个全局变量的形式进行表达，但是，需要确保是全局唯一的
    ---@type Character
    Me = require ("Character"):new()

    if EngineGlobal.useNewResource or EngineUtil.IsWebGL() then
        --LuaLogger.es("===>>>> ResMgr:loadSpriteDefault")
    end
    ResMgr:loadSpriteDefault()
    GameFlowFSM = FSM:new()
    self.CheckState = require "CheckState"
    self.LoginState = require "LoginState"
    self.AuditingState = require "AuditingState"
    self.GameState = require "GameState"
    self.SelectUserState = require "SelectUserState"
    self.BattleState = require "BattleState"
    self.EmptyState = require "EmptyState"
    self.SurvivalState = require "SurvivalState"

    CommonLogic = require "CommonLogic"
    ---@type UICommonUtils
    UICommonUtils = require "UICommonUtils"
    AddictionPrevention = require "AddictionPrevention"
    -- ThinkingAnalytics = require("ThinkingAnalytics"):new()
    SeaMapMgr = require "SeaMapMgr":new()
    CoveManager = require "CoveManager"
    ---@type CovePropsMgr
    CovePropsMgr = require "CovePropsMgr"

    HttpCrypt = require("HttpCrypt")

	CoveBattleMgr = require ("CoveBattleMgr")

    if EngineUtil.IsWebGL() then
        WXLuaManager = require "WXLuaManager":new()
    end

    if EngineUtil.IsWebGL() then
        if EngineUtil.GetWebGLPlatform() == GE.WebGLMiniPlatform.WxWebMini then
            WebGLManager = WXManager
        elseif EngineUtil.GetWebGLPlatform() == GE.WebGLMiniPlatform.AliWebMini then
            WebGLManager = AliWebGLMiniManager
        elseif EngineUtil.GetWebGLPlatform() == GE.WebGLMiniPlatform.TikTokMini then
            WebGLManager = TiktokWebGLMiniManager
        end
    end
    if EngineUtil.IsWebGL() then
        g_GameMain:SetUpdateProgress(0.95, nil)
        coroutine.yield()
    end

    self:reload()
    UICommonUtils.WrapUIEvent()

    GameFlowFSM:addState(self.AuditingState)
    GameFlowFSM:addState(self.CheckState)
    GameFlowFSM:addState(self.LoginState)
    GameFlowFSM:addState(self.GameState)
    GameFlowFSM:addState(self.SelectUserState)
    GameFlowFSM:addState(self.BattleState)
    GameFlowFSM:addState(self.EmptyState)
    GameFlowFSM:addState(self.SurvivalState)

    g_GameMain.onQuit = function()
       
        --local GameGlobal = require "GameGlobal"
        --GameGlobal.UpdateUserInfoByUid(Me.uid, GameGlobal)

        if Standalone == true then
            SrvSim.save()
        end
    end

    if not EngineUtil.IsWebGL() then
        g_GameMain.onFocus = function(focus)
            print("focus!!!!", focus)
            if Me and Me.isEnterScene then
                Me._onFocus = focus
                -- if PayMgr then
                --     PayMgr:onFocus()
                -- end
            end
        end
    end

    g_GameMain.onPause = function(pause)
        -- print("pause!!!!", pause)
        if Me and Me.isEnterScene then
            Me._onFocus = not pause
        end
    end

    if EngineUtil.IsWebGL() then
        g_GameMain:SetUpdateProgress(1.0, nil)
        coroutine.yield()
    end

    self:ThinkingAnalyticsInit()

    SDKMgr:getGameOpenLoginInfo(function (success)
        if success then -- 实际上只有success为true才会有回调
            GameFlowFSM:changeState(GameFlowState.LoginState)
        end
    end)

    self._luaInitCo = nil
end

--埋点初始化
function LuaMain:ThinkingAnalyticsInit()
    ResMgr:LoadPrefabAsync("Prefabs/SDK/ThinkingAnalytics.prefab", function(obj)
        local tObj = GameObject.Instantiate(obj).gameObject
        ThinkingAnalytics = require("ThinkingAnalytics")
        ThinkingAnalytics:init(tObj)
    end)
end

function LuaMain:reload()
    GlobalInfo = {}
    GlobalInfo.DirectLogin = false
    GlobalInfo.DevPanel = false
    GlobalInfo.ResConfig = ResMgr.config
    
    if UnityEngine.PlayerPrefs.HasKey(GE.LocalCustomDataKey.LocalServerTest) then
        local isLocal = UnityEngine.PlayerPrefs.GetInt(GE.LocalCustomDataKey.LocalServerTest)
        LuaLogger.ds("LocalServerTest", isLocal)
        GV.GlobalConfig.LocalServerTest = isLocal == 1
    end
    
    
    if GV.GlobalConfig.LocalServerTest then
        GlobalInfo.DevMode = true
    end

    if ClientData then
        ClientData:Clear()
        ClientData = nil
    end

    GameMsgMgr = require "MsgMgr":new()
    ---@type ClientData
    ClientData = require "ClientData":new()
    if PayMgr then
        PayMgr:Clear()
    end
    UICommonUtils.RegEvent()
    -- ChatUtil.RegMsg()
end
--TestSendTimeReq = false
--G.Declare("TestSendTimeReq")

-- 系统的主循环
function LuaMain:Update()
    if self._luaInitCo then
        coroutine.resume(self._luaInitCo)
        return
    end

    GameFlowFSM:update()
    if LoginNetHandler and LoginNetHandler.SimUpdate then
        LoginNetHandler:SimUpdate()
    end

    if GameNetHandler and GameNetHandler.SimUpdate then
        GameNetHandler:SimUpdate()
    end
    UIMgr:Update()
    -- ResMgr:Update()
    LuaAsyncMgr:Update()
    SeaMapMgr:Update()
    if CoveManager.instance() then
        CoveManager.instance():Update()
    end

    if CoveBattleMgr.instance() then
        CoveBattleMgr.instance():Update()
    end
    
    ---本地战斗测试接口
    if Input.GetKey(KeyCode.LeftShift) and Input.GetKeyDown(KeyCode.U) then
        local battleMgr = BattleCore:getBattleMgr()
        if battleMgr then
            battleMgr:LocalStartBattle(10204)
        end
    end
    if GV.IsEditor then
        if Input.GetKeyDown(KeyCode.L) then
            if LuaLogger.Enabled then
                print("LOG日志开关已经切换为  ", not LuaLogger.Enabled)
            end
            LuaLogger.Enabled = not LuaLogger.Enabled
            print("LOG日志开关已经切换为  ", LuaLogger.Enabled)
        end
    end
    -- if Input.GetKey(KeyCode.LeftControl) and Input.GetKeyDown(KeyCode.U) then
    --     local name = UIMgr:GetTopUI().uiConfig.id
    --     LuaLogger.d("reload %s", name)
    --     UIMgr:ReloadWnd(name)
    -- end
    
    
    if LuaLogger.Enabled and Input.GetKeyDown(KeyCode.U) then
        Me:ReportHeroHomeActionCompletedReq({heroActions = {{heroId = 10006}}})
    end


    if LuaLogger.Enabled and Input.GetKeyDown(KeyCode.I) then
        ---@type table<integer, HeroInfo>
        local heroList = Me:getHeroList()
        local str = ""
        for i,v in pairs(heroList) do
            local action = v.homelandActionInfo
            if not action then
                action = {}
                action.actionId = 0
                action.lastActionId = 0
            end
            local res = ""
            local c = tablex.size(v.attributeValList)
            for i = 1, c do
                local v1 = v.attributeValList[i]
                if v1.val ~= 0 then
                   res = res ..  " type:" .. v1.type .. " val:" .. v1.val .. ","
                end
            end
            str = str .. "id:".. v.id .. ",actionId:".. tostring(action.actionId).. ",lastActionType:" .. tostring(action.lastActionId) .. "  res: {" .. res .. "}\n"
        end

        str = str .. "离线仓库数据\n"
        local StorageRewardInfo = Me.homeland.storageItemList or {}
        for i = 1, #StorageRewardInfo do
            local rewardInfo = StorageRewardInfo[i]
            str = str .. "id:" .. rewardInfo.id .. " num:" .. rewardInfo.num .. "\n" 
        end

        str = str .. "奖励仓库数据\n"
        local earningsItemList = Me.homeland.earningsItemList or {}
        for i = 1, #earningsItemList do
            local rewardInfo = earningsItemList[i]
            str = str .. "id:" .. rewardInfo.id .. " num:" .. rewardInfo.num .. "\n" 
        end

        LuaLogger.ws("===>>> " .. str)


        local battleData = Me:GetCoveBattleData()

        LuaLogger.ws("对战信息 " .. tablex.dump(battleData))
    end

    if LuaLogger.Enabled and Input.GetKeyDown(KeyCode.O) then


    end

    if LuaLogger.Enabled and Input.GetKeyDown(KeyCode.P) then

    end

end

function LuaMain:OnDestroy()
    --DFileLoggerInst:Close()
    
    if LoginNetHandler then
        LoginNetHandler:OnDestroy()
    end

    if GameNetHandler then
        GameNetHandler:OnDestroy()
    end
end

function LuaMain:SetUpdateInterval(interval)
    if not self.LuaMonoIns then
        self.LuaMonoIns = self.gameObject:GetComponent("LuaMono")
    end
    if self.LuaMonoIns then
        self.LuaMonoIns:SetUpdateInterval(interval)
    end
end

return LuaMain