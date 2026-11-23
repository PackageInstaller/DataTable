local this = {
    vm = nil,
    expireTime = nil,
};

local data = {
    leftTimeStr = "",
    achievementStr = "",
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
            LuaMgr.ShowLuaPanel(UIName.Rogue2MedalPopup)
        end
    },
    signInBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if RogueMgr.CheckRogueLike2IsOpen() then
                LuaMgr.ShowLuaPanel(UIName.PassesMain2ViewModel);
            else
                LuaMgr.ShowLuaPanel(UIName.PassesMainViewModel);
            end
        end
    },
    shopBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.Rogue2ShopViewModel)
        end
    },
    page1Btn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.RogueMain1ViewModel)
        end
    },
    page2Btn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        RedMgr.Singleton:RegisterViewModel(UIName.Rogue2Main1ViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        RedMgr.Singleton:Refresh()
        this.Refresh()
        LuaMgr.AddTimer(TimerConst.RogueMainTimer, this.Timer, 1, -1, true);
        RogueMgr.PlayBgm()
        if (RedMgr.Singleton:CheckRedCondition("16901")) then
            RedMgr.Singleton:FrushRedCondition("16901")
        end
        PlayerMedalMgr.CheckMedalPopup(tostring(RogueMgr.GroupId_2))
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
    
    RogueMgr.CurShowPage = 2
    this.expireTime = this.activityData.expireTime
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
    this.vm.data.achievementStr = string.format(LuaMgr.GetLangText("Rogue2Main1ViewModel_0"), finishMedalCount, #medalList)
end

this.Timer = function()
    if this.expireTime == nil then
        return
    end
    this.vm.data.leftTimeStr = RogueMgr.GetActivityLeftTimeStr_2(this.expireTime)
end

return vm({
    data = data,
    command = command,
    hook = hook
})