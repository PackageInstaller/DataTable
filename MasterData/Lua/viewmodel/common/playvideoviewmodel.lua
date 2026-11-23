





local HERO_VIDEO_PATH = "Video/%s.mp4"
local videoObj = nil
local volume = 0
local this = {vm = nil}

local data = {
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2224"].NameLan)
            LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,tipStr,function()
                this.VideoEnd()
            end,nil)
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        videoObj = vm.behaviour.transform:Find("root/Video"):GetComponent("UIVideoPlayer")
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
    end,
}


this.InitParameter = function()
    if this.vm.behaviour.Params.Length > 0 then
        local videoName = this.vm.behaviour.Params[0]
        if videoName == nil or videoName == "" then return end
        AudioMgr.Singleton:SetBgmVolume(0)
        volume = SettingHelper.GetPrefasFloat(ESetting.Audio_MusicVolume)
        videoObj:SetVolume(volume)
        videoObj:Load(string.format(HERO_VIDEO_PATH, videoName), this.VideoEnd)
    end
end
this.VideoEnd = function()
    videoObj:Stop()
    AudioMgr.Singleton:SetBgmVolume(volume)
    LuaMgr.HidePanel(UIName.ConfirmSmallViewModel)
    LuaMgr.HidePanel(UIName.PlayVideoViewModel)
end
return vm({
    data = data,
    command = command,
    hook = hook
})