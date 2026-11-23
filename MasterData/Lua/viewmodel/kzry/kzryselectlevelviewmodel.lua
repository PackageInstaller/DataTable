local this = {
    vm = nil,
    curAreaEventList = nil,
    curPlayerData = nil,
    dataList = {},
};

local objs = {
    LevelBtn1 = { path = "root/Middle/Level1", type = "Button" },
    LevelBg1 = { path = "root/Middle/Level1/bg", type = "GameObject" },
    LevelFinish1 = { path = "root/Middle/Level1/bg/imgFinish", type = "GameObject" },
    LevelLock1 = { path = "root/Middle/Level1/ImgLock", type = "GameObject" },
    LevelBtn2 = { path = "root/Middle/Level2", type = "Button" },
    LevelBg2 = { path = "root/Middle/Level2/bg", type = "GameObject" },
    LevelFinish2 = { path = "root/Middle/Level2/bg/imgFinish", type = "GameObject" },
    LevelLock2 = { path = "root/Middle/Level2/ImgLock", type = "GameObject" },
    LevelBtn3 = { path = "root/Middle/Level3", type = "Button" },
    LevelBg3 = { path = "root/Middle/Level3/bg", type = "GameObject" },
    LevelFinish3 = { path = "root/Middle/Level3/bg/imgFinish", type = "GameObject" },
    LevelLock3 = { path = "root/Middle/Level3/ImgLock", type = "GameObject" },
}

local data = {

}
local command = {

}

this.ParseData = function()
    this.curAreaEventList = DataExHelper.EX_GetEventMapByArea("KZRY1")
    this.curPlayerData = DataMgr.Player.activityMaps["KZRY1"]
    for k, v in pairs(this.curAreaEventList) do
        for i, vv in ipairs(v) do
            local state = this.CheckState(vv)
            local data = {}
            data.config = vv
            data.state = state
            this.dataList[i] = data
            SetActive(this["LevelLock" .. i], state == 0)
            SetActive(this["LevelBg" .. i], state == 1 or state == 2)
            SetActive(this["LevelFinish" .. i], state == 2)
        end
    end
end

this.CheckState = function(_config)
    local playerData = this.curPlayerData.activityEvents[_config.id]
    local recodeData = DataMgr.Player.dungeonRecords[_config.eventParam]
    local lock = playerData == nil
    if (lock) then
        return 0
    else
        if (recodeData ~= nil and recodeData.completeCount > 0) then
            return 2
        else
            return 1
        end
    end
end

this.OnClickLevelBtn1 = function()
    this.OnClickLevel(1)
end

this.OnClickLevelBtn2 = function()
    this.OnClickLevel(2)
end

this.OnClickLevelBtn3 = function()
    this.OnClickLevel(3)
end

this.OnClickLevel = function(index)
    local cache = this.dataList[index]
    if (cache == nil) then
        return
    end
    if (cache.state == 0) then
        local unlockName = ConfigRhythmGameMgr.GetUnlockName(cache.config.unlockParam)
LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.format(ConfigMgr.LangGlobal("25207"), unlockName));
    else
        local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
        enterDungeonParams.eventId = cache.config.id;
        enterDungeonParams.dungeonId = cache.config.eventParam;
        BattlePrepareMgr.BattlePrepare(enterDungeonParams);
    end
end

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.LevelBtn1, this.OnClickLevelBtn1)
        LuaMgr.AddClick(this.LevelBtn2, this.OnClickLevelBtn2)
        LuaMgr.AddClick(this.LevelBtn3, this.OnClickLevelBtn3)
    end,

    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.ParseData();
        end
    end,

    before_deactive = function(vm)
       
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.LevelBtn1, this.OnClickLevelBtn1)
        LuaMgr.RemoveClick(this.LevelBtn2, this.OnClickLevelBtn2)
        LuaMgr.RemoveClick(this.LevelBtn3, this.OnClickLevelBtn3)
    end
}


return vm({
    data = data,
    command = command,
    hook = hook
})