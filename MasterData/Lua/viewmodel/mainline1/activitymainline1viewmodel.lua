local this = {
  
};

local objs = {
    gotoBtn = { path = "root/Middle/Goto", type = "Button" },
    image1 = { path = "root/Middle/Goto/Image1", type = "GameObject" },
    image2 = { path = "root/Middle/Goto/Image2", type = "GameObject" },
    timeText = { path = "root/Middle/Time/Text", type = "Text" },
    rawImage1 = { path = "root/Middle/RawImage1", type = "GameObject" },
    rawImage2 = { path = "root/Middle/RawImage2", type = "GameObject" },
};


this.SetData = function()   
    local daqin = DataExHelper.GetDataExByTag(ActivityKey.MainLine1);
    local time = daqin.expireTime - LuaMgr.Timestamp();
    local timeStr = "";
    local d, h, m = GetTimeDHM(time);
    if (not IsNullOrEmpty(d)) then
        timeStr = timeStr .. string.format("%s%s", d, ConfigMgr.LangGlobal("10365"));
    end
    if (not IsNullOrEmpty(h)) then
        timeStr = timeStr .. string.format("%s%s", h, ConfigMgr.LangGlobal("10366"));
    end
    if (not IsNullOrEmpty(m)) then
        timeStr = timeStr .. string.format("%s%s", m, ConfigMgr.LangGlobal("10367"));
    end
    this.timeText.text = string.format(timeStr);
    this.CheckSwitchType()
end

this.CheckSwitchType = function()
    local showType1 = ConfigMainLineMgr.CheckCanSwitch()    
    SetActive(this.image1, showType1)
    SetActive(this.image2, not showType1)
    SetActive(this.rawImage1, showType1)
    SetActive(this.rawImage2, not showType1)
end


this.OnClickGoto = function()
    LuaMgr.ShowLuaPanel(UIName.MainLine1HomeViewModel); 
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