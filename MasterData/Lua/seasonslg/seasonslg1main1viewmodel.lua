local this = {
    vm = nil,
    pagetypeKey = "",
    topBarComp = nil,
    animator = nil,
};

local data = {
    leftTimeStr = "",
    leftTimeStr2 = "",
    leftTimeShortStr = "",
    achievementStr = "",
    showNovel = false,
    selected1 = false,
    selected2 = false,
    selected3 = false,
    showSignInBtn = true,
    showFirstNoval = false,
    textContent = "",
    isNewActivity = false,
    isOldActivity = false,
}

local command = {
    startBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            SeasonSLGMapMgr.SetSeasonCutIn(true);
            NumTool.DelayHandler(function()
                if this ~= nil then
                    LuaMgr.ShowLuaPanel(UIName.SeasonSLGMapViewModel);
                end
            end, 0.8)
        end
    },
    reviewBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)

        end
    },
    medalBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)

        end
    },
    signInBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)

        end
    },
    novalBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if (this.vm.data.isNewActivity) then
                LuaMgr.ShowLuaPanel(UIName.YLWXNovelPanel)
            else
                LuaMgr.ShowLuaPanel(UIName.SeasonSLGNovelPanel)
            end
        end
    },
    rankBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            SeasonSLGMapMgr.OpenCommonRankPanel();
        end
    },
    shopBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.SeasonSLGShopPanel)
        end
    },
    eventBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.SeasonSLGOverviewViewModel)
        end
    },
    missionBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.SeasonSlGMainPageTaskPopupViewModel)
        end
    },
    talentBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.SeasonSLGTechPanel)
        end
    },
    page1Btn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.RefreshPageTypeKey(1)
        end
    },
    page2Btn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnFirstMainPage()
            this.RefreshPageTypeKey(2)
        end
    },
    trafficBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.SeasonSLGTrafficPermitViewModel);
        end
    },
    skipBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.showNovel = false;
            if this.startDelay ~= nil then
                coroutine_runner.stop(this.startDelay)
            end
        end
    },
    jumpBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            FeatureManager.GotoViewModel("1009_1")
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        RedMgr.Singleton:RegisterViewModel(UIName.SeasonSLG1Main1ViewModel);
        this.pagetypeKey = DataMgr.Player.uid .. "SeasonSLGMainPage"
        local tf = this.vm.behaviour.transform;
        this.animator = tf:Find("root"):GetComponent("Animator");
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        if this.topBarComp == nil then
            local topBarObj = UnityEngine.GameObject.Find("UIRoot(Clone)/Fixed/TopBarPanel(Clone)")
            if (topBarObj ~= nil) then
                this.topBarComp = topBarObj:GetComponent("TopBarViewModel")
            end
        end
        LuaMgr.AddTimer(TimerConst.SeasonSLGMapTimeEventTimeLeft, this.SeasonTaskCountDown, 1)
        HeroRedDataHelper.SetSeasonSLGRed()
        RedMgr.Singleton:Refresh()
        this.Refresh()
        if vm.behaviour.Params.Length > 0 then
            local param = tonumber(vm.behaviour.Params[0]) or 1
            if param == 2 then
                this.OnFirstMainPage()
            end
            this.RefreshPageTypeKey(param)
            this.RefreshPageNameTypeKey(param)
        else
            local cache = PlayerPrefs.GetInt(this.pagetypeKey)
            this.RefreshPageTypeKey(cache)
            this.RefreshPageNameTypeKey(cache)
        end
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.SeasonSLGMapTimeEventTimeLeft);
        if (vm.behaviour.Params == nil) then
            return
        end
        if this.startDelay ~= nil then
            coroutine_runner.stop(this.startDelay)
        end
        this.barType = nil
        if this.tween ~= nil then
            this.tween:Kill()
            this.tween = nil
        end
    end,
    before_destroy = function(vm)
        RedMgr.Singleton:RemoveViewModel(UIName.SeasonSLG1Main1ViewModel);
        this = nil;
    end
}

this.RefreshPageNameTypeKey = function(_type)
    if _type == 2 then
        if (this.topBarComp) then
            this.topbarTextKey = (LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_34252"))
        end
    else
        if (this.vm.data.isNewActivity) then
            if (this.topBarComp) then
                this.topbarTextKey = (LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_35167"))
            end
        else
            if (this.topBarComp) then
                this.topbarTextKey = (LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_34251"))
            end
        end
    end
    local func = function()
        if this.topBarComp and this.topbarTextKey ~= nil then
            local text = LuaMgr.GetLangText(this.topbarTextKey)
            this.topBarComp.BackName:Set(text)
        end
    end
    if this.tween ~= nil then
        this.tween:Kill()
        this.tween = nil
    end
    this.tween = DOTWeen:Sequence()
    this.tween:AppendInterval(0.2):OnComplete(func)
end

this.Refresh = function()
    this.vm.data.leftTimeStr = this.GetActivityTime(ActivityKey.SeasonSLG)
    this.vm.data.leftTimeStr2 = this.GetActivityTime(ActivityKey.YLWX)
    if (not IsNullOrEmpty(this.vm.data.leftTimeStr2)) then
        this.vm.data.isNewActivity = true
        this.vm.data.isOldActivity = false
    else
        this.vm.data.isNewActivity = false
        this.vm.data.isOldActivity = true
        this.vm.data.leftTimeStr2 = this.GetActivityTime(ActivityKey.JYSH)
    end
    this.SeasonTaskCountDown()
end

this.GetActivityTime = function(activity)
    local activityData = DataExHelper.GetDataExByTag(activity);
    if activityData == nil or not DataExHelper.CommonActivityCheck(activity) then
        return ""
    end
    local d, h, m = 0, 0, 0
    local time = activityData.expireTime - LuaMgr.Timestamp();
    d, h, m = GetTimeDHM(time);
    local timeStr = "";
    if (not IsNullOrEmpty(d)) then
        timeStr = timeStr .. string.format("%s%s", d, ConfigMgr.LangGlobal("10365"));
    end
    if (not IsNullOrEmpty(h)) then
        timeStr = timeStr .. string.format("%s%s", h, ConfigMgr.LangGlobal("10366"));
    end
    if (not IsNullOrEmpty(m)) then
        timeStr = timeStr .. string.format("%s%s", m, ConfigMgr.LangGlobal("10367"));
    end
    return LuaMgr.GetLangText("SeasonSLG1Main1ViewModel_0") .. string.format(timeStr);
end

this.RefreshPageTypeKey = function(_type)
    if this.barType ~= nil and this.barType == _type then
        return;
    end
    this.barType = _type;
    this.animator.enabled = false;
    this.animator.enabled = true;
    this.animator:Rebind()
    PlayerPrefs.SetInt(this.pagetypeKey, _type)
    this.vm.data.selected1 = false;
    this.vm.data.selected2 = false;
    this.vm.data.selected3 = false;
    if _type == 2 then
        if (this.topBarComp) then
            this.topBarComp.BackName:Set(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_34252"))
        end
        this.vm.data.selected2 = true;
    else
        if (this.vm.data.isNewActivity) then
            this.vm.data.selected3 = true;
            if (this.topBarComp) then
                this.topBarComp.BackName:Set(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_35167"))
            end
        else
            this.vm.data.selected1 = true;
            if (this.topBarComp) then
                this.topBarComp.BackName:Set(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_34251"))
            end
        end
    end
end

this.SeasonTaskCountDown = function()
    this.vm.data.leftTimeShortStr = LuaMgr.GetLangText("SeasonSLG1Main1ViewModel_1") ..
        SeasonSLGMapMgr.GetSeasonWeekLeftTime(true)
end

this.OnFirstMainPage = function()
    local key = DataMgr.Player.uid .. "SeasonSLGMainNovel8"
    local cache = PlayerPrefs.GetInt(key)
    this.vm.data.showNovel = false
    if cache == 1 then
        return false
    end
    PlayerPrefs.SetInt(key, 1)













    this.vm.data.showNovel = true
    LuaMgr.PlayNovel("T001001", function()

        LuaMgr.ShowLuaPanel(UIName.SeasonSLG1Main1ViewModel, 2);
        LuaMgr.ShowLuaPanel(UIName.SeasonSLGMapViewModel);
    end)
    return true
end


return vm({
    data = data,
    command = command,
    hook = hook
})