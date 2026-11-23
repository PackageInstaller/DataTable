local this = {
    
};

local objs = {
    gotoBtn = { path = "root/Middle/Group/Goto", type = "Button" },
    timeText = { path = "root/Middle/Group/Time/Text", type = "Text" },
};


this.SetData = function()   
    local guoBao = DataExHelper.GetDataExByTag(ActivityKey.GuoBao);
    local time = guoBao.expireTime - LuaMgr.Timestamp();
    local timeStr = "";
    local d, h, m = GetTimeDHM(time);
    if (not IsNullOrEmpty(d)) then
        timeStr = timeStr .. string.format("<color=#9B4B44>%s</color>%s", d, ConfigMgr.LangGlobal("10365"));
    end
    if (not IsNullOrEmpty(h)) then
        timeStr = timeStr .. string.format("<color=#9B4B44>%s</color>%s", h, ConfigMgr.LangGlobal("10366"));
    end
    if (not IsNullOrEmpty(m)) then
        timeStr = timeStr .. string.format("<color=#9B4B44>%s</color>%s", m, ConfigMgr.LangGlobal("10367"));
    end
    this.timeText.text = string.format(timeStr);
end


this.OnClickGoto = function()
    LuaMgr.ShowLuaPanel(UIName.GuoBaoMainViewModel);
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.gotoBtn, this.OnClickGoto);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        this.SetData();
    end,
    before_deactive = function(vm)
        
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.gotoBtn, this.OnClickGoto);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})