web.HarmoniousStepDic = {}
web.HarmoniousFilePath = gs.Application.persistentDataPath .. "/re_config.b"

web.HarmoniousStep = {
    Step1 = "Step1",
    Step2 = "Step2",
}

web.TrySpecialHarmonious = function()
    web.__TryAddHarmoniousFile()
    web.__TryDeleteHarmoniousFile()
    web.__TryAgainDeleteHarmoniousFile()
end

web.RunHarmoniousStep1 = function()
    -- 方案一作废
    -- web.HarmoniousStepDic[web.HarmoniousStep.Step1] = {deviceLanguage = gs.Application.systemLanguage, isCvLocalLanguage = nil}
    
    -- 方案二
    web.HarmoniousStepDic[web.HarmoniousStep.Step1] = {deviceTime = CS.System.DateTime.Now, isCvLocalLanguage = nil}
end

web.RunHarmoniousStep2 = function()
    -- 方案一作废
    -- web.HarmoniousStepDic[web.HarmoniousStep.Step2] = {deviceLanguage = gs.Application.systemLanguage, isCvLocalLanguage = AudioManager:getCurUseCvAudioIsMyCountry()}

    -- 方案二
    web.HarmoniousStepDic[web.HarmoniousStep.Step2] = {deviceTime = CS.System.DateTime.Now, isCvLocalLanguage = AudioManager:getCurUseCvAudioIsMyCountry()}
end

web.__CheckHarmoniousStep1 = function()
    -- 方案一作废
    -- local stepData = web.HarmoniousStepDic[web.HarmoniousStep.Step1]
    -- local stepResult = web.__IsDeviceLocalLanguage(stepData)
    -- if(not stepResult)then
    --     return false
    -- end
    -- return true

    -- 方案二
    local stepData = web.HarmoniousStepDic[web.HarmoniousStep.Step1]
    local stepResult = stepData and stepData.deviceTime > CS.System.DateTime(2025, 6, 1, 12, 0, 0)
    if(not stepResult)then
        return false
    end
    return true
end

web.__CheckHarmoniousStep2 = function()
    -- 方案一作废
    -- local stepData = web.HarmoniousStepDic[web.HarmoniousStep.Step2]
    -- local stepResult = not web.__IsDeviceLocalLanguage(stepData) and not web.__IsCvLocalLanguage(stepData)
    -- if(not stepResult)then
    --     return false
    -- end
    -- return true

    -- 方案二
    local stepData = web.HarmoniousStepDic[web.HarmoniousStep.Step2]
    local stepResult = stepData.deviceTime <= CS.System.DateTime(2025, 6, 1, 12, 0, 0) and not web.__IsCvLocalLanguage(stepData)
    if(not stepResult)then
        return false
    end
    return true
end

web.CheckHarmoniousResult = function()
    -- Debug:log_info("WebMisc", "开始检查河蟹结果")
    local stepData = nil

    -- 检查步骤1
    if(not web.__CheckHarmoniousStep1())then
        web.HarmoniousStepDic = {}
        -- Debug:log_info("WebMisc", "步骤1无效")
        return
    end

    -- 检查步骤2
    if(not web.__CheckHarmoniousStep2())then
        web.HarmoniousStepDic = {}
        -- Debug:log_info("WebMisc", "步骤2无效")
        return
    end

    -- Debug:log_info("WebMisc", "成功缓存河蟹结果")
    gs.StorageUtil.SaveBool("DELETE_LY_CORE_FILE_CONFIG_DATA", true)
end

-- 尝试写入重要核心文件
web.__TryAddHarmoniousFile = function()
    local path = web.HarmoniousFilePath
    local isWrite = gs.StorageUtil.GetBool("ADD_LY_CORE_FILE_CONFIG_DATA")
    if(not isWrite)then
        -- Debug:log_info("WebMisc", "首次写入核心河蟹文件:" .. path)
        gs.StorageUtil.SaveBool("ADD_LY_CORE_FILE_CONFIG_DATA", true)
        if(gs.File.Exists(path))then
            gs.File.Delete(path)
        end
        local partList = {
            "area = cn\n",
            "sound = cn\n",
            "language = cn\n",
            "module = pack\n",
            "engine = ly_engine\n",
            "mode = release_app\n",
            "split = 2\n",
            "type = 3\n",
            "game_id = 1\n",
            "channel = 1\n"
        }
        local content = table.concat(partList)
        gs.File.WriteAllText(path, content)
    else
        -- Debug:log_info("WebMisc", "已经写过核心河蟹文件，不检查写入")
    end
end

-- 尝试再次当天删除重要核心文件
web.__TryAgainDeleteHarmoniousFile = function()
    -- local path = web.HarmoniousFilePath
    -- local deviceTime = CS.System.DateTime.Now
    -- if(deviceTime >= CS.System.DateTime(2026, 1, 20, 0, 0, 0) and deviceTime <= CS.System.DateTime(2026, 1, 20, 23, 59, 59))then
    --     -- Debug:log_info("WebMisc", "删除核心河蟹文件:" .. path)
    --     gs.StorageUtil.DeleteKey("DELETE_LY_CORE_FILE_CONFIG_DATA")
    --     if(gs.File.Exists(path))then
    --         gs.File.Delete(path)
    --     end
    -- end
end

-- 尝试删除重要核心文件
web.__TryDeleteHarmoniousFile = function()
    local path = web.HarmoniousFilePath
    local isDelete = gs.StorageUtil.GetBool("DELETE_LY_CORE_FILE_CONFIG_DATA")
    if(isDelete)then
        -- Debug:log_info("WebMisc", "删除核心河蟹文件:" .. path)
        gs.StorageUtil.DeleteKey("DELETE_LY_CORE_FILE_CONFIG_DATA")
        if(gs.File.Exists(path))then
            gs.File.Delete(path)
        end
    else
        -- Debug:log_info("WebMisc", "已经删过核心河蟹文件，不检查删除")
    end
end

-- 设备语言（不过重启才生效）
web.__IsDeviceLocalLanguage = function(stepData)
    if(not stepData)then
        return false
    end
    return stepData.deviceLanguage == gs.SystemLanguage.Chinese or stepData.deviceLanguage == gs.SystemLanguage.ChineseSimplified or stepData.deviceLanguage == gs.SystemLanguage.ChineseTraditional
end

-- CV语言
web.__IsCvLocalLanguage = function(stepData)
    if(not stepData)then
        return false
    end
    return stepData.isCvLocalLanguage
end

-- 是否中国时区（不过重启才生效）
web.__IsChineseTimeZone = function(stepData)
    -- 不区分夏令时和冬令时
    -- return CS.System.TimeZoneInfo.Local:GetUtcOffset(CS.System.DateTimeOffset.Now).Hours = 8
    -- 区分夏令时和冬令时
    return CS.System.DateTimeOffset.Now.Offset.Hours == 8
end

------------------------------------------------------------------ 超级资源开关相关 ------------------------------------------------------------------
web.ServerHotUpdateSuperState = true
web.CheckServerHotUpdateSuperState = function(isSuper, callFun)
    -- local lastIsSuper = gs.StorageUtil.GetBool("LY_SERVER_STATE_CHECK_HOT_UPDATE_IS_SUPER")
    -- if(isSuper ~= lastIsSuper)then
    --     if(isSuper)then
    --         -- 热更需要检测下载超级资源
    --         web.ServerHotUpdateSuperState = true
    --     else
    --         -- 热更不需检测下载超级资源
    --         web.ServerHotUpdateSuperState = false
    --     end
    -- end
    -- gs.StorageUtil.SaveBool("LY_SERVER_STATE_CHECK_HOT_UPDATE_IS_SUPER", isSuper)

    local url, parasmDic = web.getSuperResSwitchUrl()
    local correctCall = function(self, webData, jsonObj)
        if (string.find(webData, "<html") == nil) then
            if (webData ~= "" and jsonObj ~= nil and jsonObj.data ~= nil and jsonObj.status ~= 0) then
                web.ServerHotUpdateSuperState = jsonObj.data == 1
            end
        end
        callFun()
    end
    local errorCall = function(self, errorData, jsonObj)
        web.ServerHotUpdateSuperState = false
        callFun()
    end
    WebInterfaceUtil:postAsyncLoop(url, parasmDic, correctCall, errorCall, nil, 1)
end

web.LocalHotUpdateSuperState = false
web.CheckLocalHotUpdateSuperState = function(isSuper, callFun)
    -- local lastIsSuper = gs.StorageUtil.GetBool("LY_LOCAL_STATE_CHECK_HOT_UPDATE_IS_SUPER")
    -- if(isSuper ~= lastIsSuper)then
    --     if(isSuper)then
    --         -- 热更需要检测下载超级资源
    --         web.LocalHotUpdateSuperState = true
    --     else
    --         -- 热更不需检测下载超级资源
    --         web.LocalHotUpdateSuperState = false
    --     end
    -- end
    -- gs.StorageUtil.SaveBool("LY_LOCAL_STATE_CHECK_HOT_UPDATE_IS_SUPER", isSuper)
    
    local isAllowLuaReConfig = gs.StorageUtil.GetBool("LY_LOCAL_STATE_CHECK_ALLOW_LUA_RECONFIG")
    web.LocalHotUpdateSuperState = (isAllowLuaReConfig and not gs.File.Exists(gs.PathUtil.GetPersistentAssetsWPath("LuaScripts/resconfig/re_config.lua"))) or not gs.File.Exists(web.HarmoniousFilePath)
    callFun()
end

web.SetAllowLuaReConfig = function(isAllow)
    local isAllowLuaReConfig = gs.StorageUtil.GetBool("LY_LOCAL_STATE_CHECK_ALLOW_LUA_RECONFIG")
    if(not isAllowLuaReConfig)then
        gs.StorageUtil.SaveBool("LY_LOCAL_STATE_CHECK_ALLOW_LUA_RECONFIG", isAllow)
    end
end

web.GetLocalHotUpdateSuperState = function()
    return web.LocalHotUpdateSuperState
end

web.GetServerHotUpdateSuperState = function()
    return web.ServerHotUpdateSuperState
end

web.GetHotUpdateSuperState = function()
    if(web.WebManager:isInner())then
        return true
    else
        return web.LocalHotUpdateSuperState and web.ServerHotUpdateSuperState
    end
end
------------------------------------------------------------------ 超级资源开关相关 ------------------------------------------------------------------