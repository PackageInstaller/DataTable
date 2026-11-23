PlayerSGYMgr = {}

local this = {
    isInit = false,
    levelIndex = 0,
    novelIndex = 0,
    battleIndex = 0,
};

PlayerSGYMgr.Init = function()
    if (this.isInit) then return end
    
    this.isInit = true;
end

PlayerSGYMgr.Clear = function()
    this.isInit = false;
    this.levelIndex = 0;
    this.novelIndex = 0;
    this.battleIndex = 0;
end


PlayerSGYMgr.CheckActivityStatus = function()
    if (not DataExHelper.CommonActivityCheck(ActivityKey.SGY)) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("18344"));
        return false;
    end
    return true;
end


PlayerSGYMgr.GetDungeonRecord = function(id)
    return DataMgr.Player.dungeonRecords[id];
end


PlayerSGYMgr.IsDungeonRecord = function(id)
    local record = DataMgr.Player.dungeonRecords[id];
    return record ~= nil and not IsNullOrEmpty(record.historyRating);
end


PlayerSGYMgr.GetNovelRecord = function(id)
    local completedChapters = DataMgr.Player.completedChapters;
    for _, v in ipairs(completedChapters) do
        if (v == id) then
            return true;
        end
    end
    return false;
end


PlayerSGYMgr.IsUnlock = function(id, isTips)
    if (not IsNullOrEmpty(id)) then
        local record = PlayerSGYMgr.GetDungeonRecord(id);
        if (record == nil or IsNullOrEmpty(record.historyRating)) then
            if (isTips) then
                local unlockName = ConfigSGYMgr.GetDungeonName(id);
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.format(ConfigMgr.LangGlobal("10001"), unlockName));
            end
            return false;
        end
    end
    return true;
end


PlayerSGYMgr.SetLevelIndex = function(index)
    this.levelIndex = index;
end


PlayerSGYMgr.GetLevelIndex = function()
    return this.levelIndex;
end


PlayerSGYMgr.SetNovelIndex = function(index)
    this.novelIndex = index;
end


PlayerSGYMgr.GetNovelIndex = function()
    return this.novelIndex;
end


PlayerSGYMgr.SetBattleIndex = function(index)
    this.battleIndex = index;
end


PlayerSGYMgr.GetBattleIndex = function()
    return this.battleIndex;
end