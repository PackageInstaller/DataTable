local this = {
    eventConfig = nil,
    eventData = nil,
};

local objs = {
    animator = { path = "root", type = "UIAnimator" },
    maskBtn = { path = "root/Mask", type = "Button" },
    pic = { path = "root/Middle/Event/Glow/Pic", type = "RawImage" },
    msg = { path = "root/Middle/Event/Msg/Text", type = "Text" },
    effect = { path = "root/Middle/Event/Effect/Text", type = "Text" },
};


this.SetData = function()
    this.pic.texture = LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/Voyage/%s.png", this.eventConfig.EventPic));
    this.msg.text = LuaMgr.GetLangText(this.eventConfig.EventDesLan);
    this.effect.text = LuaMgr.GetLangText(this.eventConfig.EventNameLan);
    if (this.eventConfig.Effect == 1) then
        this.animator.AnimationName = "ani_VoyageRichManEventPanel_root";
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/Talent_choose2.mp3");
    else
        this.animator.AnimationName = "ani_VoyageRichManEventPanel_root_negative";
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/Round Change_One.mp3");
    end
    local time = VoyageRichManMgr.IsAutoDice() and 1.5 or 3;
    LuaMgr.AddTimer(TimerConst.VoyageRichManEventTime, this.OnClickMask, time, 1, false);
end


this.OnClickMask = function()
    VoyageRichManMgr.ExecuteEvent(this.eventConfig, this.eventData);
    LuaMgr.HidePanel(UIName.VoyageRichManEventViewModel);
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.maskBtn, this.OnClickMask);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        
        VoyageRichManSceneMgr.SetDrag(false);
        this.eventConfig = vm.behaviour.Params[0];
        this.eventData = vm.behaviour.Params[1];
        this.SetData();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.VoyageRichManEventTime);
        this.eventConfig = nil;
        this.eventData = nil;
        VoyageRichManSceneMgr.SetDrag(true);
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickMask);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})