local this = {
status = "",
    startAniName = "ani_VoyageRichManStatusPanel_start",
    startDisappearAniName = "ani_VoyageRichManStatusPanel_start_disappear",
    failAniName = "ani_VoyageRichManStatusPanel_fail",
    failDisappearAniName = "ani_VoyageRichManStatusPanel_fail_disappear",
    completeAniName = "ani_VoyageRichManStatusPanel_complete",
    completeDisapearAniName = "ani_VoyageRichManStatusPanel_complete_disapear",
};

local objs = {
    animator = { path = "root", type = "UIAnimator" },
    startGO = { path = "root/Middle/Start", type = "GameObject" },
    startWinConditionLabel = { path = "root/Middle/Start/WinCondition/Label", type = "Text" },
    startWinConditionText = { path = "root/Middle/Start/WinCondition/Text", type = "Text" },
    startLoseConditionLabel = { path = "root/Middle/Start/LoseCondition/Label", type = "Text" },
    startLoseConditionText = { path = "root/Middle/Start/LoseCondition/Text", type = "Text" },
    loseGO = { path = "root/Middle/Lose", type = "GameObject" },
    loseMsg = { path = "root/Middle/Lose/Msg/Text", type = "Text" },
    completeGO = { path = "root/Middle/Complete", type = "GameObject" },
    completeMsg = { path = "root/Middle/Complete/Msg/Text", type = "Text" },
};


this.SetData = function(vm)
    if (vm.behaviour.Params == nil) then return end

    VoyageRichManSceneMgr.SetDrag(false);
    this.status = vm.behaviour.Params[0];
    SetActive(this.startGO, false);
    SetActive(this.loseGO, false);
    SetActive(this.completeGO, false);
    LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnPlayFinish);
    LuaMgr.AddUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnPlayFinish);
if (this.status == VoyageRichManStatus.OpenHarbor) then
        this.startWinConditionLabel.text = ConfigMgr.LangGlobal("10457");
        this.startWinConditionText.text = ConfigMgr.LangGlobal("10558");
        this.startLoseConditionLabel.text = ConfigMgr.LangGlobal("10458");
        this.startLoseConditionText.text = ConfigMgr.LangGlobal("10559");
        SetActive(this.startGO, true);
        this.animator.AnimationName = this.startAniName;
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/huazhao_donghua1.mp3");
elseif (this.status == VoyageRichManStatus.Success) then
        local harborID = vm.behaviour.Params[1];
        local portConfig = ConfigVoyageMgr.GetPortConfig(harborID);
        if (portConfig ~= nil) then
            this.completeMsg.text = string.format(ConfigMgr.LangGlobal("10463"), LuaMgr.GetLangText(portConfig.HarborNameLan));
        end
        SetActive(this.completeGO, true);
        this.animator.AnimationName = this.completeAniName;
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/hightea_levelup.mp3");
elseif (this.status == VoyageRichManStatus.Fail) then
        this.loseMsg.text = ConfigMgr.LangGlobal("10500");
        SetActive(this.loseGO, true);
        this.animator.AnimationName = this.failAniName;
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/hightea_failed.mp3");
    end
end


this.OnPlayFinish = function(args)
    if (args.Length > 0) then
        local aniName = args[0];
        if (aniName == this.startAniName) then
            this.animator.AnimationName = this.startDisappearAniName;
        elseif (aniName == this.startDisappearAniName) then
            LuaMgr.HidePanel(UIName.VoyageRichManStatusViewModel);
            VoyageRichManMgr.StatusComplete();
        elseif (aniName == this.failAniName) then
            this.animator.AnimationName = this.failDisappearAniName;
        elseif (aniName == this.failDisappearAniName) then
            LuaMgr.HidePanel(UIName.VoyageRichManStatusViewModel);
            VoyageRichManMgr.StatusComplete();
        elseif (aniName == this.completeAniName) then
            this.animator.AnimationName = this.completeDisapearAniName;
        elseif (aniName == this.completeDisapearAniName) then
            LuaMgr.HidePanel(UIName.VoyageRichManStatusViewModel);
            VoyageRichManMgr.StatusComplete();
        end
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
    end,
    before_active = this.SetData,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnPlayFinish);
        VoyageRichManSceneMgr.SetDrag(true);
    end,
    before_destroy = function()
        
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})