



local this = { vm = nil }
local GALLERY_PAth = "Images/Novel/NPC/npc_1_chicken/";
local effectAnimator = nil;
local cortinera = nil
local AnimationShow
local CDJObjAnimator
local saveTime
local RedId
local data = {
    Description = "",
    showEffect_1 = false,
    animation_name = "UI_ChickPanel_ani",
    showEffect_2 = false,
    showEffect_3 = false,
    chickIcon = DefaultTexture,
}

local command = {
    clickMask = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.NonsenseChickViewModel);
        end
    },
    clickGotoPanel = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local GotoScreen = ConfigMgr.Config.redPointMap[RedId].GotoScreen
            if GotoScreen ~= nil or GotoScreen ~= "" then
                FeatureManager.GotoViewModel(GotoScreen)
            end
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        effectAnimator = this.vm.behaviour.transform:Find("root"):GetComponent("Animator")
        CDJObjAnimator = this.vm.behaviour.transform:Find("root/Middle/RedChickTips"):GetComponent("Animator")
    end,

    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        RedId = vm.behaviour.Params[0]
        LuaMgr.RemoveUIEventListener(UIEventConst.NonsenseChickPanelClose, this.closeChickPanel)
        LuaMgr.AddUIEventListener(UIEventConst.NonsenseChickPanelClose, this.closeChickPanel)

        this.initChickData()

        saveTime = LuaMgr.Timestamp()
        CDJObjAnimator:Play("UI_CDJTips_tanchu", 0, 0)
        LuaMgr.AddTimer(TimerConst.NonsenseChickTime, this.timeLast, 1, -1, true);
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.vm.data.showEffect_1 = false
        this.vm.data.showEffect_2 = false
        this.vm.data.showEffect_3 = false
        LuaMgr.RemoveUIEventListener(UIEventConst.NonsenseChickPanelClose, this.closeChickPanel)

    end,
    before_destroy = function(vm)
        this.vm.behaviour = nil;
        effectAnimator = nil;
        data = nil;
        command = nil;
    end,
}
this.initChickData = function()
    local RedData = ConfigMgr.Config.redPointMap[RedId]
    this.vm.data.Description = LuaMgr.GetLangText(RedData.ChickDescLan)
    local rendomAnimatio = math.random(1, 3)
    local name = "showEffect_" .. rendomAnimatio
    this.vm.data.animation_name = "UI_ChickPanel_ani"
    this.vm.data[name] = true






end
this.timeLast = function()
    if LuaMgr.Timestamp() - saveTime >= 5 then
        ComData.MainPageChickShowTime = LuaMgr.Timestamp()
        LuaMgr.RemoveTimer(TimerConst.NonsenseChickTime);
    end
end
this.ShowCDJShowAnimation = function()
    if cortinera ~= nil then
        coroutine_runner.stop(cortinera)
    end
    cortinera = coroutine_runner.start(function()
        CDJObjAnimator:Play("UI_CDJTips_tanchu", 0, 0)
        coroutine_runner.wait(5)
        cortinera = nil
        CDJObjAnimator:Play("UI_CDJTips_tanchu", 0, 0)
        ComData.MainPageChickShowTime = LuaMgr.Timestamp()
    end)
end


this.ParseData = function()
    if AnimationShow ~= nil then
        AnimationShow.stop(cortinera)
        AnimationShow = nil
    end
    AnimationShow = coroutine_runner.start(function()
        coroutine_runner.wait(5)
        local rand = math.random(0, 1)

        if rand == 0 then
            effectAnimator:Play("UI_ChickPanel_Shine", 0, 0)
        elseif rand == 1 then
            effectAnimator:Play("UI_ChickPanel_Falldown", 0, 0)
        end
    end)
    if cortinera ~= nil then
        coroutine_runner.stop(cortinera)
        cortinera = nil
    end
    cortinera = coroutine_runner.start(function()
        coroutine_runner.wait(7)
        LuaMgr.HidePanel(UIName.NonsenseChickViewModel);
        RedMgr.Singleton:SetCDjTipShow(false)
        ComData.MainPageChickShowTime = LuaMgr.Timestamp()
    end)
end
this.OnShowPanel = function(arge)
    if not LuaMgr.IsPanelOpen("MainPageViewModel") then
        LuaMgr.RemoveUIEventListener(UIEventConst.ShowPanel, this.OnShowPanel)
    end

end

this.closeChickPanel = function()
    LuaMgr.RemoveTimer(TimerConst.NonsenseChickTime);
    if not ComData.MainPageChickFirstShow then
        ComData.MainPageChickFirstShow = true
    end
    LuaMgr.RemoveUIEventListener(UIEventConst.ShowPanel, this.OnShowPanel);
    LuaMgr.HidePanel(UIName.NonsenseChickViewModel)
end
return vm({
    data = data,
    command = command,
    hook = hook,
})