require("ZGCX/ZGCXConst")
ConfigZGCXMgr = {}

local this = {
    activityMapEvent = nil,
    mainActivityMapEvent = nil,
    redColor = UnityEngine.Color(173 / 255, 36 / 255, 30 / 255, 1),
    greenColor = UnityEngine.Color(0 / 255, 141 / 255, 122 / 255, 1),
    yellowColor = UnityEngine.Color(195 / 255, 144 / 255, 55 / 255, 1),
    lightCollectTb = nil
};


ConfigZGCXMgr.Init = function()

    if ConfigMgr and ConfigMgr.Config then

        print("ConfigZGCXMgr 初始化完成")
    else
        LuaDebug.error("ConfigMgr 或 ConfigMgr.Config 不存在，初始化失败")
    end
end

ConfigZGCXMgr.Clear = function()
    this.activityMapEvent = nil;
    this.mainActivityMapEvent = nil;
end



ConfigZGCXMgr.GetUnlockName = function(unlockParam)
    local config = nil
    for i, v in ipairs(ConfigMgr.Config.activityMapEventList) do
        if v.id == unlockParam then
            config = v
            break
        end
    end
    if (config ~= nil) then
        return LuaMgr.GetLangText(config.namelan)
    end
    return "";
end

ConfigZGCXMgr.GetUnlockTimeStr = function(time)
    local curTimeStamp = LuaMgr.Timestamp();
    curTimeStamp = time - curTimeStamp
    if (curTimeStamp <= 0) then
        return LuaMgr.GetLangText("ConfigDHMgr_0")
    end
    local day, hour, minute = GetTimeDHM(curTimeStamp)
    local timeStr = ""
    if IsNullOrEmpty(day) then
        timeStr = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["10209"].NameLan), hour, minute)
    else
        timeStr = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["10208"].NameLan), day, hour)
    end
    return timeStr .. LuaMgr.GetLangText("ConfigDHMgr_1")
end


ConfigZGCXMgr.GetActivityMapConfigByArea = function(areaId)
    local config = nil
    for i, v in ipairs(ConfigMgr.Config.activityMapList) do
        if v.area == areaId then
            config = v
            break
        end
    end
    return config;
end

ConfigZGCXMgr.GetLightCollectTbByType = function(_type)
    if (this.lightCollectTb == nil) then
        this.lightCollectTb = {}
        for i, v in pairs(ConfigMgr.Config.LightCollectMap) do
            if (this.lightCollectTb[v.LightType] == nil) then
                this.lightCollectTb[v.LightType] = {}
            end
            table.insert(this.lightCollectTb[v.LightType], v)
        end
        for k, v in pairs(ZGCXLevelNumType) do
            table.sort(this.lightCollectTb[v], function(a, b)
                return tonumber(a.ID) < tonumber(b.ID)
            end)
        end
    end
    if (_type == nil) then
        return this.lightCollectTb
    end
    return this.lightCollectTb[_type]
end