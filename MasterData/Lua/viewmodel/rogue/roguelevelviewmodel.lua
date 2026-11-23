local this = {
    vm = nil,
curType = 1,
    curSelectIevel_1 = 0,
    curSelectIevel_2 = 0,
    refreshTime = 0,
};

local data = {
    LevelList = {
        { bg = DefaultSprite, selectBg = DefaultSprite, select = false, lock = false, lockTipsStr = "", anchoredPos = Vector2.zero }
    },
    showType1 = false,
    showType2 = false,
    activeContent = false;
    showThemeBtn_1 = false,
    showThemeBtn_2 = false,
    contentSizeDelta = Vector2(1680, 456),
}

local anchoredPos1 = Vector2(0, -143.5)
local anchoredPos2 = Vector2(0, -334.7)

local command = {
    startBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local selectIevelId = 0
            if this.curType == 1 then
                selectIevelId = this.curSelectIevel_1
            elseif this.curType == 2 then
                selectIevelId = this.curSelectIevel_2
            end
            if selectIevelId == 0 then
                return
            end
            for i, v in ipairs(this.vm.data.LevelList) do
                if this.vm.data.LevelList[i].id == selectIevelId and this.vm.data.LevelList[i].lock then
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, this.vm.data.LevelList[i].lockTipsStr);
                    return
                end
            end
            RogueMgr.RogueLevel = selectIevelId
            RogueMgr.DefaultBuffList = {}
            RogueMgr.ChooseTeamId = -1
            if this.CheckIsUnlockRogueBuff() then
                LuaMgr.ShowLuaPanel(UIName.RogueBuffViewModel)
            else
                LuaMgr.ShowLuaPanel(UIName.RogueTeamViewModel)
            end

            if this.curType == 1 then
                PlayerPrefs.SetInt(DataMgr.Player.uid .. "RogueLastSelectLevel_1", this.curSelectIevel_1);
            elseif this.curType == 2 then
                PlayerPrefs.SetInt(DataMgr.Player.uid .. "RogueLastSelectLevel_2", this.curSelectIevel_2);
            end
            PlayerPrefs.Save();
        end
    },
    switchBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.curType = this.curType % 2 + 1
            this.Refresh()
        end
    },
    levelItemBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = param + 1
            local selectId = this.vm.data.LevelList[index].id
            if this.vm.data.LevelList[index].lock then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, this.vm.data.LevelList[index].lockTipsStr);
                return
            end
            if this.curType == 1 then
                this.curSelectIevel_1 = selectId
            elseif this.curType == 2 then
                this.curSelectIevel_2 = selectId
            end
            for i, v in ipairs(this.vm.data.LevelList) do
                if this.vm.data.LevelList[i].id == selectId then
                    this.vm.data.showThemeBtn_1 = this.vm.data.LevelList[i].version == 1
                    this.vm.data.showThemeBtn_2 = this.vm.data.LevelList[i].version == 2
                    this.vm.data.LevelList[i].select = true
                else
                    this.vm.data.LevelList[i].select = false
                end
            end

        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.vm.data.contentSizeDelta = Vector2(LuaMgr.GetScreenWidth(), 456)
this.curType = 2
        this.curSelectIevel_1 = PlayerPrefs.GetInt(DataMgr.Player.uid .. "RogueLastSelectLevel_1", 0);
        this.curSelectIevel_2 = PlayerPrefs.GetInt(DataMgr.Player.uid .. "RogueLastSelectLevel_2", 0);
        this.Refresh()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        LuaMgr.RemoveTimer(TimerConst.RogueLevelTimer)
    end,
    before_destroy = function(vm)
        this = nil;
    end
}

this.Refresh = function()
    this.vm.data.showType1 = this.curType == 1
    this.vm.data.showType2 = this.curType == 2
    this.vm.data.activeContent = false;
    this.vm.data.activeContent = true;
    this.refreshTime = 0
    local showTheme1 = true
    local levelCfgs = ConfigMgr.Config.RogueLevels
    local tempList = {}
    local realIndex = 1
    for i, v in ipairs(levelCfgs) do
        if v.Type == this.curType then
            local isHide = false
            if v.Unlock == 3 and not IsNullOrEmpty(v.Para) then
                local unlockTime = this.GetLevelUnlockTime(v.Para)
                if LuaMgr.Timestamp() < unlockTime then
                    isHide = true
                end
            end
            if not isHide then
                local levelItem = {
                    id = v.Level,
                    version = v.Version
                }
                local bgName = ""
                local isSelect = false
                if this.curType == 1 then
                    if this.curSelectIevel_1 == 0 then
                        this.curSelectIevel_1 = levelItem.id
                    end
                    levelItem.select = levelItem.id == this.curSelectIevel_1
                    bgName = this.GetBgSpriteName(i)
                elseif this.curType == 2 then
                    if this.curSelectIevel_2 == 0 then
                        this.curSelectIevel_2 = levelItem.id
                    end
                    levelItem.select = levelItem.id == this.curSelectIevel_2
                    bgName = this.GetBgSpriteName(i)
                end
                levelItem.anchoredPos = realIndex % 2 == 1 and anchoredPos1 or anchoredPos2
                if levelItem.select then
                    showTheme1 = v.Version == 1
                end
                if not IsNullOrEmpty(bgName) then
                    levelItem.bg = LuaMgr.GetSprite("Rogue", bgName)
                    levelItem.selectBg = LuaMgr.GetSprite("Rogue", bgName .. "02")
                end
                local lockTipsStr = this.GetLockTips(v.Level)
                levelItem.lockTipsStr = lockTipsStr
                levelItem.lock = not IsNullOrEmpty(lockTipsStr)
                table.insert(tempList, levelItem)
                realIndex = realIndex + 1
            end
        end
    end

    this.vm.data.LevelList = tempList
    this.vm.data.showThemeBtn_1 = showTheme1
    this.vm.data.showThemeBtn_2 = not showTheme1

    if this.refreshTime > 0 then
        LuaMgr.AddTimer(TimerConst.RogueLevelTimer, this.UpdateLeftTimer, 1, -1, false)
    end
end

this.GetBgSpriteName = function(level)
    local spriteName = ""
    if level == 1 then
        spriteName = "ui_xhyt_ndxz_kj"
    elseif level == 2 then
        spriteName = "ui_xhyt_ndxz_em"
    elseif level == 3 then
        spriteName = "ui_xhyt_ndxz_jd"
    elseif level == 4 then
        spriteName = "ui_xhyt_ndxz_pt"
    elseif level == 5 then
        spriteName = "ui_xhyt_ndxz_kn"
    elseif level == 6 then
        spriteName = "ui_wsch_ndyh"
    elseif level == 7 then
        spriteName = "ui_wsch_ndyl"
    elseif level == 8 then
        spriteName = "ui_wsch_ndcn"
    end
    return spriteName
end

this.GetLockTips = function(level)
    local lockTips = ""
    local levelCfg = ConfigMgr.Config.RogueLevels[level]
    if (levelCfg.Unlock == 1 or levelCfg.Unlock == 3) and not IsNullOrEmpty(levelCfg.Para) then
        local unlockTime = this.GetLevelUnlockTime(levelCfg.Para)
        local leftTime = unlockTime - LuaMgr.Timestamp()
        if leftTime > 0 then
            this.refreshTime = this.refreshTime == 0 and leftTime or math.min(this.refreshTime, leftTime)
            lockTips = os.date(ConfigMgr.LangGlobal("26227"), unlockTime)
        end
    elseif levelCfg.Unlock == 2 and not IsNullOrEmpty(levelCfg.Para) and DataMgr.Player.RogueRecords[levelCfg.Para] == nil then
        lockTips = string.format(ConfigMgr.LangGlobal("26226"), LuaMgr.GetLangText(ConfigMgr.Config.RogueLevels[tonumber(levelCfg.Para)].ThemeLan))
    end
    return lockTips
end

this.CheckIsUnlockRogueBuff = function()
    local unlock = false
    local unlockTechIds = DataMgr.Player.RogueTech
    if IsNull(unlockTechIds) or TableIsNull(unlockTechIds) then
        return unlock
    end

    local techCfgs = ConfigMgr.Config.RogueTechs
    local tempList = {}
    for i, v in ipairs(techCfgs) do
        if unlockTechIds[v.Id] ~= nil and v.Type == 2 and not TableIsNull(v.Para) and v.Para[1] == "RogueOption" then
            unlock = true
            break
        end
    end
    return unlock
end

this.GetLevelUnlockTime = function(delay)
    local startTime = 0
    local activityData = DataExHelper.GetDataExByTag(ActivityKey.RogueLike)
    if activityData ~= nil then
        startTime = activityData.startTime
    end
    local delayTime = tonumber(delay) * 24 * 60 * 60
    local leftTime = startTime + delayTime
    return leftTime
end

this.UpdateLeftTimer = function()
    if this.refreshTime <= 0 then
        LuaMgr.RemoveTimer(TimerConst.RogueLevelTimer)
        this.Refresh()
        return
    end

    this.refreshTime = this.refreshTime - 1
end

return vm({
    data = data,
    command = command,
    hook = hook
})