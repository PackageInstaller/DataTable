ConfigDHMgr = {}

local this = {
    activityMapEvent = nil,
    mainActivityMapEvent = nil,
    redColor = UnityEngine.Color(173 / 255, 36 / 255, 30 / 255, 1),
    greenColor = UnityEngine.Color(0 / 255, 141 / 255, 122 / 255, 1),
    yellowColor = UnityEngine.Color(195 / 255, 144 / 255, 55 / 255, 1),
};


ConfigDHMgr.Init = function()

    if ConfigMgr and ConfigMgr.Config then

        print("ConfigDHMgr 初始化完成")
    else
        LuaDebug.error("ConfigMgr 或 ConfigMgr.Config 不存在，初始化失败")
    end
end

ConfigDHMgr.Clear = function()
    this.activityMapEvent = nil;
    this.mainActivityMapEvent = nil;
end


ConfigDHMgr.GetGridType = function(type)
    if not ConfigMgr or not ConfigMgr.Config or not ConfigMgr.Config.DHGridTypeMap then
        LuaDebug.error("获取格子类型失败：配置数据不存在")
        return nil
    end

    local gridTypeMap = ConfigMgr.Config.DHGridTypeMap;
    for _, gridConfig in pairs(gridTypeMap) do
        if (gridConfig.GridType == type) then
            return gridConfig;
        end
    end

    return nil;
end


ConfigDHMgr.GetGridReward = function(type, stageId)
    if not ConfigMgr or not ConfigMgr.Config or not ConfigMgr.Config.DHGridTypeMap then
        LuaDebug.error("获取格子奖励失败：格子配置数据不存在")
        return nil
    end

    if not ConfigMgr.Config.DHLevelMap or not ConfigMgr.Config.DHLevelMap[stageId] then
        return nil
    end

    local gridTypeMap = ConfigMgr.Config.DHGridTypeMap;
    for _, gridConfig in pairs(gridTypeMap) do
        if (gridConfig.GridType == type) then
            local dhLevel = ConfigMgr.Config.DHLevelMap[stageId];
            if not dhLevel or not dhLevel.SortId or not gridConfig.Reward then
                return nil
            end
            return gridConfig.Reward[dhLevel.SortId];
        end
    end
    return nil;
end


ConfigDHMgr.GetDrawScrollList = function(typeId)
    if not ConfigMgr or not ConfigMgr.Config or not ConfigMgr.Config.DHScrollMap then
        LuaDebug.error("获取画格奖励列表失败：配置数据不存在")
        return {}
    end

    local gridTypeMap = ConfigMgr.Config.DHScrollMap;
    local cacheList = {}
    for _, scrollConfig in pairs(gridTypeMap) do
        if (scrollConfig.Type == typeId) then
            table.insert(cacheList, scrollConfig)
        end
    end

    table.sort(cacheList, function(a, b)
        return a.Id < b.Id
    end)

    return cacheList
end


ConfigDHMgr.GetHpColor = function(hpPercent)
    if not hpPercent or type(hpPercent) ~= "number" then
        LuaDebug.error("获取血条颜色失败：无效的血量百分比")
return this.greenColor
    end

    if (hpPercent < 0.2) then
        return this.redColor;
    elseif (hpPercent < 0.5) then
        return this.yellowColor;
    end
    return this.greenColor;
end


ConfigDHMgr.GetUnlockName = function(unlockParam)
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

ConfigDHMgr.GetUnlockTimeStr = function(time)
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