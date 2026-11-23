local this = {
    vm = nil,
    expireTime = nil,
    refreshTime = nil,
    page2IsOpen = false,
};

local data = {
    leftTimeStr = "",
    achievementStr = "",
    page2Lock = false,
    showSignInBtn = false,
}

local command = {
    startBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.RogueMain2ViewModel)
        end
    },
    reviewBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.RogueReviewViewModel)
        end
    },
    medalBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.RogueMedalPopup)
        end
    },
    signInBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.PassesMainViewModel);
        end
    },
    shopBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.RogueShopViewModel)
        end
    },
    page1Btn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
        end
    },
    page2Btn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.page2IsOpen then
                LuaMgr.ShowLuaPanel(UIName.Rogue2Main1ViewModel)
            else
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("26510"));
            end
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        RedMgr.Singleton:RegisterViewModel(UIName.RogueMain1ViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        RedMgr.Singleton:Refresh()
        this.Refresh()
        LuaMgr.AddTimer(TimerConst.RogueMainTimer, this.Timer, 1, -1, true);
        RogueMgr.PlayBgm()
        if (RedMgr.Singleton:CheckRedCondition("16857")) then
            RedMgr.Singleton:FrushRedCondition("16857")
        end
        PlayerMedalMgr.CheckMedalPopup(tostring(RogueMgr.GroupId_1))
        HeroRedDataHelper.SetRogueRed()
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

this.Refresh = function()
    this.activityData = DataExHelper.GetDataExByTag(ActivityKey.RogueLike);
    if this.activityData == nil or not DataExHelper.CommonActivityCheck(ActivityKey.RogueLike) then
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", ConfigMgr.LangGlobal("18344"))
        return
    end

    RogueMgr.CurShowPage = 1 
    this.expireTime = this.activityData.expireTime
    this.page2IsOpen = RogueMgr.CheckRogueLike2IsOpen()
    this.vm.data.page2Lock = not this.page2IsOpen
    this.vm.data.showSignInBtn = not this.page2IsOpen
    this.refreshTime = nil
    if not this.page2IsOpen and ConfigMgr.Config.RogueConstants.RogueNextTime ~= nil then
        this.refreshTime = ConfigMgr.Config.RogueConstants.RogueNextTime - LuaMgr.Timestamp()
    end
    this.SetMedalInfo()
end

this.SetMedalInfo = function()
    local medalList = RogueMgr.GetMedalList()
    local finishMedalCount = 0
    for i, v in ipairs(medalList) do
        if v.finish then
            finishMedalCount = finishMedalCount + 1
        end
    end
    this.vm.data.achievementStr = string.format(LuaMgr.GetLangText("RogueMain1ViewModel_0"), finishMedalCount, #medalList)
end

this.Timer = function()
    if this.expireTime == nil then
        return
    end
    this.vm.data.leftTimeStr = RogueMgr.GetActivityLeftTimeStr_1(this.expireTime)

    if this.refreshTime ~= nil then
        this.refreshTime = this.refreshTime - 1
        if this.refreshTime == 0 then
            this.refreshTime = nil
            this.Refresh()
        end
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})