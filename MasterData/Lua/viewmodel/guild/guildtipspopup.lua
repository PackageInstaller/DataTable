local this = {
    vm = nil,
}
local isAni = false
local SHOW_ANI_NAME = "ani_ui_MessageTipsPopup_01"
local HIDE_ANI_NAME = "ani_ui_MessageTipsPopup_02"

local objs = {

}
local data = {
    desc = "",
    uiAniName = "",
}

local command = {
    ClosePanelCommand =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.PlayHideAni()
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        UITool.Parse(vm.behaviour, this, objs);

    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        isAni = false
        this.vm.data.desc = tostring(vm.behaviour.Params[0] or "")
        this.vm.data.uiAniName = SHOW_ANI_NAME
        LuaMgr.AddTimer(1, this.PlayHideAni, 2, 1,false);
    end,
    before_deactive = function(vm)
        this.ClearTips()
        this.vm.data.desc = ""
        this.vm.data.uiAniName = ""
    end,
    before_destroy = function(vm)
        this = nil
    end,
}

this.ClearTips = function()
    LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnHideAni)
    isAni = false
end

this.PlayHideAni = function()
    if isAni then
        return
    end
    isAni = true
    LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnHideAni)
    LuaMgr.AddUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnHideAni)
    this.vm.data.uiAniName = HIDE_ANI_NAME
end

this.OnHideAni = function(animName)
    this.ClearTips()
    LuaMgr.HidePanel(UIName.GuildTipsPopup)
end

return vm({
    data = data,
    command = command,
    hook = hook
})