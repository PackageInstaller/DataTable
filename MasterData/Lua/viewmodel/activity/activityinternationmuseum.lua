







local objs = {
    gotoBtn = {path = "root/Middle/GotoBtn", type = UITool.Button},
    jumpBtn = {path = "root/Middle/JumpBtn", type = UITool.Button}
}

local this = {}

this.GotoWebPage = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.InternationMuseum) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"))
        return
    end
    if IsNullOrEmpty(ConfigMgr.Config.constants.MuseumcheckUrl) then
        return
    end
    LuaMgr.OpenURL(ConfigMgr.Config.constants.MuseumcheckUrl)
end


this.JumpCheckInOneYear=function()
    LuaMgr.ShowLuaPanel(UIName.ActivityCheckInYearViewModel)
end


local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.gotoBtn, this.GotoWebPage)
        LuaMgr.AddClick(this.jumpBtn, this.JumpCheckInOneYear)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        local isJumpBtnActive= DataExHelper.CommonActivityCheck(ActivityKey.checkInOneYear);
        SetActive(this.jumpBtn.gameObject,isJumpBtnActive);
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.gotoBtn, this.GotoWebPage)
        LuaMgr.RemoveClick(this.jumpBtn, this.JumpCheckInOneYear)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)