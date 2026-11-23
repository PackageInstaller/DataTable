local this = {
  
};

local objs = {
    gotoBtn = { path = "root/Middle/Goto", type = "Button" },
    timeText = { path = "root/Middle/Time/Text", type = "Text" },
};


this.SetData = function()  
    this.timeText.text = YPSMgr.GetTimeStr();
end


this.OnClickGoto = function()
    LuaMgr.ShowLuaPanel(UIName.YPSMainViewModel); 
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