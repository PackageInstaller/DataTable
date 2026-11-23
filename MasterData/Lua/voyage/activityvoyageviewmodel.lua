local this = {
    sailing = nil,
};

local objs = {
    gotoBtn = { path = "root/Middle/Goto", type = "Button" },
    timeText = { path = "root/Middle/Time/Text", type = "Text" },
};


this.SetData = function()
    local date = LuaMgr.GetLangText("ActivitySlgViewModel_0");
    local startTime = os.date(date, this.sailing.startTime);
    local expireTime = os.date(date, this.sailing.expireTime);
    this.timeText.text = string.format(LuaMgr.GetLangText("ActivitySlgViewModel_1"), startTime, expireTime);
end


this.OnClickGoto = function()
    LuaMgr.ShowLuaPanel(UIName.VoyageViewModel);
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

        this.sailing = DataExHelper.GetDataExByTag(ActivityKey.sailing);
        this.SetData();
    end,
    before_deactive = function(vm)
        this.sailing = nil;
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