module("sdk.SdkController", Class.impl())

--构造函数
function ctor(self)
    gs.SdkManager.LuaSdkTable = self
end

--析构函数
function dtor(self)
end

--------------------------------------------------------------------C#调用----------------------------------------------------------------------
-------------------------------------初始化-------------------------------------
-- unity和sdk皆已初始化完毕
function onLuaAllInitFinishHandler(msg)
    sdk.SdkManager:dispatchEvent(sdk.SdkManager.ALL_INIT_FINISH, {})
    sdk.SdkManager:checkDynamicSdk()
end

-------------------------------------用户-------------------------------------
-- sdk登录回调
function onLuaSdkLoginHandler(msg)
    sdk.SdkManager:parseLogin(msg)
end

-- 切换账号回调
function onLuaSwitchAccountHandler(msg)
    sdk.SdkManager:parseSwitchAccount(msg)
end

-- 登出回调
function onLuaLogoutHandler(msg)
    sdk.SdkManager:parseLogout(msg)
end

-- 退出回调
function onLuaExitHandler(msg)
    sdk.SdkManager:parseExit(msg)
end

-- 充值回调
function onLuaPayHandler(msg)
    sdk.SdkManager:parsePay(msg)
end

-- 分享结果回调
function onLuaShareHandler(msg)
    sdk.SdkManager:parseShare(msg)
end

-- 耳机状态回调
function onHeadphoneStateHandler(msg)
    sdk.SdkManager:headphoneState(msg)
end

-------------------------------------讯飞-------------------------------------
-- 录音机已经准备好了，用户可以开始语音输入
function onLuaXunFeiBeginHandler(msg)
    sdk.SdkManager:parseXunFeiBegin(msg)
end

-- 录音错误码
function onLuaXunFeiErrorHandler(msg)
    sdk.SdkManager:parseXunFeiError(msg)
end

-- 检测到了语音的尾端点，已经进入识别过程，不再接受语音输入
function onLuaXunFeiEndHandler(msg)
    sdk.SdkManager:parseXunFeiEnd(msg)
end

-- 语音解析完毕
function onLuaXunFeiResultHandler(msg)
    sdk.SdkManager:parseXunFeiResult(msg)
end

-- 录入的音量变化
function onLuaXunFeiVolumeHandler(msg)
    sdk.SdkManager:parseXunFeiVolume(msg)
end

-- 具体业务拓展接口
function onLuaXunFeiEventHandler(msg)
    sdk.SdkManager:parseXunFeiEvent(msg)
end

----------------------------------------------------------------------unity通知系统内存----------------------------------------------------------------------
-- 开启内存检测
function openMemoryCheck(self)
    if(web.WebManager.platform == web.DEVICE_TYPE.ANDROID)then
        gs.SdkManager:GetMemorySize("InitMemoryManager")
        LoopManager:addTimer(60, 0, self, self.onMemoryCheckHandler)
    end
end

-- 定时内存检测
function onMemoryCheckHandler(self)
    if(not fight or not fight.FightManager or not fight.FightManager:getIsFighting())then
        if(web.WebManager.platform == web.DEVICE_TYPE.ANDROID)then
            local systemGBSize = gs.SdkManager:GetMemorySize("SystemTotalMemory") / 1024
            local usedGBSize = gs.SdkManager:GetMemorySize("GameUsedMemory") / 1024
            -- Debug:log_error("SdkManager", "定时内存检测回调：" .. usedGBSize .. "G")
            if((systemGBSize <= 5 and usedGBSize >= 2.4) or (5 < systemGBSize and systemGBSize <= 10 and usedGBSize >= 3.5) or (10 < systemGBSize and usedGBSize >= 4))then
                pcall(function()
                    GCUtil.collectLuaGC()
                    GCUtil.colllectCSharpGC()
                    gs.GOPoolMgr:ClearAll()
                    gs.ResMgr:ForceUnload(true, true)
                end)
            end
        end
    end
end

-- 关闭内存检测
function closeMemoryCheck(self)
    LoopManager:removeTimer(self, self.onMemoryCheckHandler)
end

-- unity系统内存提示回调
function onLowMemory(msg)
    print("unity系统内存提示回调")
end

-- 原生系统内存提示回调
function onLowMemoryHandler(msg)
    if(not fight or not fight.FightManager or not fight.FightManager:getIsFighting())then
        -- Debug:log_error("SdkManager", "系统内存提示回调：" .. msg)
        if(web.WebManager.platform == web.DEVICE_TYPE.ANDROID)then
            if(msg == nil or msg == "onLowMemory" or msg == sdk.AndroidMemoryWarn.TRIM_MEMORY_COMPLETE or msg == sdk.AndroidMemoryWarn.TRIM_MEMORY_RUNNING_CRITICAL or msg == sdk.AndroidMemoryWarn.TRIM_MEMORY_RUNNING_LOW or msg == sdk.AndroidMemoryWarn.TRIM_MEMORY_RUNNING_MODERATE)then
                pcall(function()
                    GCUtil.collectLuaGC()
                    GCUtil.colllectCSharpGC()
                    gs.GOPoolMgr:ClearAll()
                    gs.ResMgr:ForceUnload(true, true)
                end)
            end
        elseif(web.WebManager.platform == web.DEVICE_TYPE.IOS)then
            -- pcall(function()
                -- GCUtil.collectLuaGC()
                -- GCUtil.colllectCSharpGC()
                -- gs.GOPoolMgr:ClearAll()
                -- gs.ResMgr:ForceUnload(true, true)
            -- end)

            -- 彻底释放ab包
            local function unLoadAssetBundle(list)
                for i = 1, #list do
                    gs.ResMgr:UnLoadAssetBundle(list[i])
                end
            end
            pcall(function()
                GCUtil.collectLuaGC()
                GCUtil.colllectCSharpGC()
                gs.GOPoolMgr:ClearAll(unpack({ "arts/fx/3d/role/prefab/skill" }))
                gs.ResMgr:ForceUnload(false, true, unpack({ "arts/fx/3d/role/prefab/skill", "arts/character/role", "arts/character/weapon" }))
                unLoadAssetBundle({ "arts/audio", "arts/character/monster", "arts/character/animat", "arts/fx/3d/role/prefab/monster", "arts/fx/3d/role/prefab/boss", "arts/fx/3d/role/prefab/common", "arts/fx/3d/role/prefab/hit", "arts/fx/3d/role/prefab/always" })
            end)
        end
    end
end

-- 设备DP变化（小屏大屏分屏变化）
function onScreenDpChangedHandler(changeResult)
    -- local splitList = string.split(changeResult, "-")
    -- local width = tonumber(splitList[1])
    -- local width = tonumber(splitList[2])
    -- local isPixel = splitList[3] == "1"
    -- -- 如果是像素，就不需要跟DPI进行计算
    -- if(isPixel == false)then
    --     local dpi = gs.Screen.dpi;
    --     local width = gs.Mathf.FloorToInt(dpi / 160 * width)
    --     local height = gs.Mathf.FloorToInt(dpi / 160 * height)
    -- end
    -- 暂时先屏蔽
    gs.Screen.SetResolution(0, 0, gs.FullScreenMode.FullScreenWindow)
    LoopManager:addFrame(5, 1, self, function()
        local screenW, screenH = ScreenUtil:getScreenSize(nil)
        sdk.SdkManager:dispatchEvent(sdk.SdkManager.DEVICE_DP_CHANGE, {width = screenW, height = screenH})
    end)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
