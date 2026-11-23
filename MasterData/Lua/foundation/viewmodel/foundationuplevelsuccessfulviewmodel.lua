local data = {
    originLevel = "",
    currentLevel = "",
    effectList = {{text="",text1="",text2="",isArrow=false,isShow=false}},
};

local this = {
    vm = nil,
    effectIndex = 1,
};


this.SetEffect = function(config)
    local item;
    local obj;
    local list = {};
    local len = #config.UpEffect;
    for i = 1, len do
        obj = config.UpEffect[i];
        item = {text=LuaMgr.GetLangText(obj[1]),text1=obj[2],text2=obj[3]};
        item.isArrow = not IsNullOrEmpty(obj[2]) and not IsNullOrEmpty(obj[3]);
        item.isShow = false;
        table.insert(list, item);
    end
    this.vm.data.effectList = list;
    this.effectIndex = 1;
    LuaMgr.AddTimer(TimerConst.FoundationUpLevelSuccessfulEffect, this.OnEffect, 0.3, -1, false);
end

this.OnEffect = function()
    local len = #this.vm.data.effectList;
    if (this.effectIndex <= len) then
        this.vm.data.effectList[this.effectIndex].isShow = true;
        this.effectIndex = this.effectIndex + 1;
    else
        LuaMgr.RemoveTimer(TimerConst.FoundationUpLevelSuccessfulEffect);
    end
end

this.OnClose = function()
    LuaMgr.HidePanel(UIName.FoundationUpLevelSuccessfulViewModel);
end

local command = {
    OnClickMask = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClose();
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
    end,
    before_active = function(vm)
        if (this.vm.behaviour.Params == nil) then return end
        
        local current = this.vm.behaviour.Params[0];
        local origin = ConfigFoundationMgr.GetInteractionByGroupLevel(current.Group, current.Level - 1);
        if (origin ~= nil) then
            this.vm.data.originLevel = tostring(origin.Level);
            this.vm.data.currentLevel = tostring(current.Level);
            this.SetEffect(origin);
        end
        LuaMgr.AddTimer(TimerConst.FoundationUpLevelSuccessfulDelay, this.OnClose, 3, 1, false);
        LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationUpLevelSuccessfulViewModel);
        AudioMgr.Singleton:PlayVoice(Path.audio_PATH.."newUI/Foundation_levelup_1.mp3");
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.FoundationUpLevelSuccessfulDelay);
        LuaMgr.RemoveTimer(TimerConst.FoundationUpLevelSuccessfulEffect);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})