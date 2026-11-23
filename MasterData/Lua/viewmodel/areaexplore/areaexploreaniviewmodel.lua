local this = {vm = nil}

local qiQiuList = {1, 2, 3, 4, 5, 6, 7, 8}
local DISPATCH_AUDIO_PATH = "Assets/_BundleResources/Audio/newUI/dispatch_1.mp3";

local data = {
    qiQiu1 = DefaultSprite,
    qiQiu2 = DefaultSprite,
    qiQiu3 = DefaultSprite,
    qiQiu4 = DefaultSprite,
    qiQiu5 = DefaultSprite,
    qiQiu6 = DefaultSprite,
    qiQiu7 = DefaultSprite,
    qiQiu8 = DefaultSprite,
    isDqAni = false,
    isQiQiu1 = false,
    isQiQiu2 = false,
    isQiQiu3 = false,
    isQiQiu4 = false,
    isQiQiu5 = false,
    isQiQiu6 = false,
    isQiQiu7 = false,
    isQiQiu8 = false,
    rootAnimationName = ""
}

local command = {
    
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then return end
        
        LuaMgr.AddUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAnimatorPlayFinish)
        this.vm.data.rootAnimationName = "UI_AreaExploreAniPanel_01"
        math.randomseed(os.time())
        this.SetData()
        this.vm.data.isDqAni = false
        AudioHelper.PlayUISFX(DISPATCH_AUDIO_PATH)
        LuaMgr.AddTimer(TimerConst.AreaExploreAniComplete, this.OnAniComplete, 5, 1)
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAnimatorPlayFinish)
        LuaMgr.RemoveTimer(TimerConst.AreaExploreAniComplete);
    end,
}

this.SetData = function()
    local area = this.vm.behaviour.Params[0]
    local areaMap = ConfigMgr.Config.areas[area];
    if not areaMap then
        return
    end

    local areaExplore = DataMgr.Player.areaExplores[area];
    if areaExplore == nil then
        return
    end

    if not next(areaExplore.currentExplores or {}) then
        LuaMgr.HidePanel(UIName.AreaExploreAniViewModel);
        return
    end
    
    local qqList = {}
    for k, item in pairs(areaExplore.currentExplores) do
        local exploreConfig = ConfigMgr.Config.areaExplores[item.exploreId];
        if exploreConfig then
            local eventId = exploreConfig.firstEventID
            local completedAreaEvent = DataMgr.Player.completedAreaEvents[eventId]
            if completedAreaEvent then
                eventId = exploreConfig.eventID
            end
            
            local eventConfig = ConfigMgr.Config.areaEvents[eventId]
            if not eventConfig then
                return
            end
            local iconRes = nil
            if eventConfig.type == 1 then
                iconRes = "ui_dc_qp_shu" .. exploreConfig.rare
            elseif eventConfig.type == 2 then
                iconRes = "ui_dc_qp_zd" .. exploreConfig.rare
            elseif eventConfig.type == 3 then
                iconRes = "ui_dc_qp_lw" .. exploreConfig.rare
            end
            table.insert(qqList, iconRes)
        end
    end
    this.SetSort();
    this.vm.data.isQiQiu1 = false
    this.vm.data.isQiQiu2 = false
    this.vm.data.isQiQiu3 = false
    this.vm.data.isQiQiu4 = false
    this.vm.data.isQiQiu5 = false
    this.vm.data.isQiQiu6 = false
    this.vm.data.isQiQiu7 = false
    this.vm.data.isQiQiu8 = false
    
    for i, v in ipairs(qqList) do
        local index = qiQiuList[i]
        local res = LuaMgr.GetSprite("ExploreRes", v)
        this.SetQiQiu[index](res)
    end
end

this.SetQiQiu = {
    [1] = function(res)
        this.vm.data.qiQiu1 = res
        this.vm.data.isQiQiu1 = true
    end,
    [2] = function(res)
        this.vm.data.qiQiu2 = res
        this.vm.data.isQiQiu2 = true
    end,
    [3] = function(res)
        this.vm.data.qiQiu3 = res
        this.vm.data.isQiQiu3 = true
    end,
    [4] = function(res)
        this.vm.data.qiQiu4 = res
        this.vm.data.isQiQiu4 = true
    end,
    [5] = function(res)
        this.vm.data.qiQiu5 = res
        this.vm.data.isQiQiu5 = true
    end,
    [6] = function(res)
        this.vm.data.qiQiu6 = res
        this.vm.data.isQiQiu6 = true
    end,
    [7] = function(res)
        this.vm.data.qiQiu7 = res
        this.vm.data.isQiQiu7 = true
    end,
    [8] = function(res)
        this.vm.data.qiQiu8 = res
        this.vm.data.isQiQiu8 = true
    end,
}

this.SetSort = function()
    local rand
    local temp
    for i = 1, #qiQiuList do
        rand = math.random(1, #qiQiuList)
        temp = qiQiuList[rand]
        qiQiuList[rand] = qiQiuList[i]
        qiQiuList[i] = temp
    end
end

this.OnAnimatorPlayFinish = function(args)
LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAnimatorPlayFinish)
this.vm.data.isDqAni = true
end

this.OnAniComplete = function(args)
LuaMgr.ShowLuaPanel(UIName.AreaExploreResultViewModel, this.vm.behaviour.Params[0]);
LuaMgr.HidePanel(UIName.AreaExploreAniViewModel);
end 


return vm({
data = data,
command = command,
hook = hook,
})