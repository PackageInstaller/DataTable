







local PV_PATH = "Video/ShortPV/%s.mp4"
local objs = {
    videoPlayer = {path = "root/Middle/VideoPlayer", type = UITool.UIVideoPlayer}
}

local this = {}

this.VideoEnd = function()
    this.videoPlayer:Stop()
    AudioMgr.Singleton:SetBgmVolume(this.volume)
    LuaMgr.HidePanel(UIName.ExtractCardPreVideoPanel)
    this.SetExtracardViewAnimEnable(true)
end

this.before_active = function()
    local func = function()
        this.delayCallFunc()
    end
    this.coroutineValid = coroutine_runner.start(func)
end

this.delayCallFunc = function()
    coroutine_runner.wait(0.01)
    if this.EndCallback ~= nil then
        this.EndCallback(this.EndcallbackParams)
    end
    coroutine_runner.wait(1.5)
    local uitype = "Laigu.ViewModel.TakeCard.ExtractCardViewModel"
    if LuaMgr.IsPanelOpen(uitype) then
        local uiTrans = CS.Laigu.Manager.UIManager.Singleton:GetPanel(uitype)
        if uiTrans ~= nil then
            this.allUIAnimators = uiTrans:GetComponentsInChildren(typeof(UnityEngine.Animator))
            this.SetExtracardViewAnimEnable(false)
        end
    end
end

this.SetExtracardViewAnimEnable = function(enabled)
    if type(this.allUIAnimators) == "nil" then
        LuaDebug.error("this.SetExtracardViewAnimEnable error")
        return
    end
    local len = this.allUIAnimators.Length - 1
    for i = 0, len do
        local animator = this.allUIAnimators[i]
        animator.enabled = enabled
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil or vm.behaviour.Params.Length < 1 then
            return
        end
        local data = vm.behaviour.Params[0]
        this.EndCallback = data.callback
        this.EndcallbackParams = data.callbackParams
        this.before_active()
        local videoName = data.videoName
        if videoName == nil or videoName == "" then
            this.VideoEnd()
            return
        end
        AudioMgr.Singleton:SetBgmVolume(0)
        this.volume = SettingHelper.GetPrefasFloat(ESetting.Audio_MusicVolume)
        this.videoPlayer:SetVolume(this.volume)
        this.videoPlayer:Load(string.format(PV_PATH, videoName), this.VideoEnd)
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)