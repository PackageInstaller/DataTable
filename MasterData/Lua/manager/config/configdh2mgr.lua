ConfigDH2Mgr = {}

local this = {
    activityMapEvent = nil,
    mainActivityMapEvent = nil,
    redColor = UnityEngine.Color(173 / 255, 36 / 255, 30 / 255, 1),
    greenColor = UnityEngine.Color(0 / 255, 141 / 255, 122 / 255, 1),
    yellowColor = UnityEngine.Color(195 / 255, 144 / 255, 55 / 255, 1),
};


ConfigDH2Mgr.Init = function()

    if ConfigMgr and ConfigMgr.Config then

        print("ConfigDH2Mgr 初始化完成")
    else
        LuaDebug.error("ConfigMgr 或 ConfigMgr.Config 不存在，初始化失败")
    end
end

ConfigDH2Mgr.Clear = function()
    this.activityMapEvent = nil;
    this.mainActivityMapEvent = nil;
end



ConfigDH2Mgr.GetUnlockName = function(unlockParam)
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

ConfigDH2Mgr.GetUnlockTimeStr = function(time)
    local curTimeStamp = LuaMgr.Timestamp();
    curTimeStamp = time - curTimeStamp
    if(curTimeStamp <= 0)then
        return LuaMgr.GetLangText("ConfigDHMgr_0")
    end
    local day, hour, minute = GetTimeDHM(curTimeStamp)
    local timeStr = ""
    if IsNullOrEmpty(day) then
        timeStr = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["10209"].NameLan), hour, minute)
    else
        timeStr = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["10208"].NameLan), day, hour)
    end
    return timeStr..LuaMgr.GetLangText("ConfigDHMgr_1")
end