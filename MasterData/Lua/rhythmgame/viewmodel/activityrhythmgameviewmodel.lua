local this = {
   
};

local objs = {
    gotoBtn = { path = "root/Middle/Goto", type = "Button" },
    timeText = { path = "root/Middle/RewardBox/Time/Text1/Text", type = "Text" },  
};


this.SetData = function()
    local music = DataExHelper.GetDataExByTag(ActivityKey.musicYDW);
    local date = LuaMgr.GetLangText("ActivityRhythmGameViewModel_0");
    local startTime = os.date(date, music.startTime);
    local expireTime = os.date(date, music.expireTime);

    this.timeText.text = string.format(LuaMgr.GetLangText("ActivityRhythmGameViewModel_1"), startTime, expireTime);
end


this.OnClickGoto = function()
    LuaMgr.ShowLuaPanel(UIName.RhythmGameMainViewModel);
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