local this = {
    vm = nil,
    expireTime = nil,
};

local data = {
    leftTimeStr = "",
    isShowGM=false;
    isShowExploreInfo=false;
    locName="";
    isLocLevel=false;
    locLevel="";
    resItemIcon1=DefaultTexture;
    resItemText1="";
    resItemIcon2=DefaultTexture;
    resItemText2="";
    resItemIcon3Bool=false;
    resItemIcon3=DefaultTexture;
    resItemText3="";
}

local command = {
    startBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.CheckContinueExplore() then
                RogueExploreMgr.Init();
                return;
            end
            LuaMgr.ShowLuaPanel(UIName.RogueLevelViewModel)
        end
    },
    itemBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.RogueCollectViewModel)
        end
    },
    rewardBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.RogueTaskViewModel)
        end
    },
    talentTreeBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.RogueTalentViewModel)
        end
    },
    gmBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.RogueGMViewModel)
        end
    },
    exitBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.RogueConfirmViewModel,ConfigMgr.LangGlobal("26232"),function()
                RogueExploreMgr.TriggerExploreEnd(function()
                    this.Refresh();
                end);
            end,nil)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        RedMgr.Singleton:RegisterViewModel(UIName.RogueMain2ViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        RogueMgr.Clear()
        RedMgr.Singleton:Refresh()
        this.Refresh()
        LuaMgr.AddTimer(TimerConst.RogueMainTimer, this.Timer, 1, -1, true);
        RogueMgr.PlayBgm()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        LuaMgr.RemoveTimer(TimerConst.RogueMainTimer)
    end,
    before_destroy = function(vm)
        this = nil;
    end
}

this.CheckContinueExplore=function()
    if IsNull(DataMgr.Player.Rogue) or IsNull(DataMgr.Player.Rogue.Maps) or  DataMgr.Player.Rogue.EndStatus>0 then
        return false;
    end
    return true;
end

this.Refresh = function()
    this.vm.data.isShowGM=LuaMgr.IsDebug();
    this.activityData = DataExHelper.GetDataExByTag(ActivityKey.RogueLike);
    if this.activityData == nil or not DataExHelper.CommonActivityCheck(ActivityKey.RogueLike) then
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", ConfigMgr.LangGlobal("18344"))
        return
    end
    this.expireTime = this.activityData.expireTime
    this.vm.data.isShowExploreInfo=this.CheckContinueExplore();
    if this.vm.data.isShowExploreInfo then
        this.mapId=RogueExploreMgr.GetCurMapID();
        if ConfigMgr.Config.RogueMaps[this.mapId]~=nil then
            local name=LuaMgr.GetLangText(ConfigMgr.Config.RogueMaps[this.mapId].NameLan);
            this.vm.data.locName=name;
        end
        local buffLevel=RogueMgr.GetGlobalBuffsLevel();
        this.vm.data.isLocLevel=buffLevel>0;
        this.vm.data.locLevel=string.format(ConfigMgr.LangGlobal("26511"),buffLevel);
    end
    this.SetResItemsInfo();
end

this.Timer = function()
    if this.expireTime == nil then
        return
    end
    this.vm.data.leftTimeStr = RogueMgr.GetActivityLeftTimeStr_1(this.expireTime)
end

this.SetResItemsInfo=function()
    local dailyItemLimit=ConfigMgr.Config.RogueConstants.RogueDailyItemLimit;
    this.vm.data.resItemIcon1=LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath(dailyItemLimit[1][1]))
    this.vm.data.resItemIcon2=LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath(dailyItemLimit[2][1]))
    local  dailyCurrency=DataMgr.Player.RogueDailyCurrency;
    local item1Count=0;
    local item2Count=0;
    if dailyCurrency[dailyItemLimit[1][1]]~=nil then
        item1Count=dailyCurrency[dailyItemLimit[1][1]];
    end
    if dailyCurrency[dailyItemLimit[2][1]]~=nil then
        item2Count=dailyCurrency[dailyItemLimit[2][1]];
    end
    this.vm.data.resItemText1=string.format("<color=#ffffff>%s</color>/%s",item1Count,dailyItemLimit[1][2]);
    this.vm.data.resItemText2=string.format("<color=#ffffff>%s</color>/%s",item2Count,dailyItemLimit[2][2]);
    local isRogueNext=RogueMgr.CheckRogueLike2IsOpen();
    this.vm.data.resItemIcon3Bool=isRogueNext;
    if isRogueNext then
        this.vm.data.resItemIcon3=LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath(dailyItemLimit[3][1]))
        local item3Count=0;
        if dailyCurrency[dailyItemLimit[3][1]]~=nil then
            item3Count=dailyCurrency[dailyItemLimit[3][1]];
        end
        this.vm.data.resItemText3=string.format("<color=#ffffff>%s</color>/%s",item3Count,dailyItemLimit[3][2]);
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})