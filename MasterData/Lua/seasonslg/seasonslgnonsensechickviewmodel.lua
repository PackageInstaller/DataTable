local this = { vm = nil }
local GALLERY_PAth = "Images/Novel/NPC/npc_1_chicken/";
local effectAnimator = nil;
local cortinera = nil
local AnimationShow
local CDJObjAnimator
local saveTime
local config
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
            LuaMgr.HidePanel(UIName.SeasonSLGNonsenseChickViewModel);
        end
    },
    clickGotoPanel = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if not IsNullOrEmpty(config.JumpGrid) then
                SeasonSLGMapMgr.JumpToMapGrid(config.JumpGrid)
            else
                LuaMgr.ShowLuaPanel(UIName.SeasonSLGMapViewModel);
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
        config = vm.behaviour.Params[0]
        LuaMgr.RemoveUIEventListener(UIEventConst.SeasonSLGNoticeEnd, this.closeChickPanel)
        LuaMgr.AddUIEventListener(UIEventConst.SeasonSLGNoticeEnd, this.closeChickPanel)

        this.initChickData()

        saveTime = LuaMgr.Timestamp()
        CDJObjAnimator:Play("UI_CDJTips_tanchu", 0, 0)
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.vm.data.showEffect_1 = false
        this.vm.data.showEffect_2 = false
        this.vm.data.showEffect_3 = false
        LuaMgr.RemoveUIEventListener(UIEventConst.SeasonSLGNoticeEnd, this.closeChickPanel)

    end,
    before_destroy = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.SeasonSLGNoticeEnd, this.closeChickPanel)
        this.vm.behaviour = nil;
        effectAnimator = nil;
        data = nil;
        command = nil;
    end,
}
this.initChickData = function()
    this.vm.data.Description = SeasonSLGTimeEventMgr.GetNoticeDesc(config)
    local rendomAnimatio = math.random(1, 3)
    local name = "showEffect_" .. rendomAnimatio
    this.vm.data.animation_name = "UI_ChickPanel_ani"
    this.vm.data[name] = true






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
    end)
end

this.closeChickPanel = function(param)
    if param ~= nil and param.Length > 0 and config ~= nil then
        local noticeConfig = param[0]
        if noticeConfig ~= nil and tostring(noticeConfig.Id) ~= tostring(config.Id) then
            return
        end
    end
    LuaMgr.HidePanel(UIName.SeasonSLGNonsenseChickViewModel)
end
return vm({
    data = data,
    command = command,
    hook = hook,
})