local this = {};

local objs = {
    storyBtn = { path = "root/Right/Story", type = "Button" },
    storyRedDot = { path = "root/Right/Story/RedDot", type = "GameObject" },
    sandTableBtn = { path = "root/Right/SandTable", type = "Button" },
    sandTableRedDot = { path = "root/Right/SandTable/RedDot", type = "GameObject" },
    signInBtn = { path = "root/Left/SignIn", type = "Button" },
    signInRedDot = { path = "root/Left/SignIn/RedDot", type = "GameObject" },
    rewardBtn = { path = "root/Left/Reward", type = "Button" },
    rewardRedDot = { path = "root/Left/Reward/RedDot", type = "GameObject" },   
    trainBtn = { path = "root/Right/Train", type = "Button" },  
    middleTF = { path = "root/Bg_01", type = "Transform" },
    dayText = { path = "root/Middle/TimeImg/Text/TextTime", type = "Text" },
};


this.SetData = function()





    local d, h, m = 0, 0, 0
    local timeStr = "";
    if DataExHelper.CommonActivityCheck(ActivityKey.RoomShare) then
        local daqin = DataExHelper.GetDataExByTag(ActivityKey.RoomShare);
        local time = daqin.expireTime - LuaMgr.Timestamp();
        d, h, m = GetTimeDHM(time);
    end
    if (not IsNullOrEmpty(d)) then
        timeStr = timeStr .. string.format("%s%s", d, ConfigMgr.LangGlobal("10365"));
    end
    if (not IsNullOrEmpty(h)) then
        timeStr = timeStr .. string.format("%s%s", h, ConfigMgr.LangGlobal("10366"));
    end
    if (not IsNullOrEmpty(m)) then
        timeStr = timeStr .. string.format("%s%s", m, ConfigMgr.LangGlobal("10367"));
    end
    this.dayText.text = string.format(timeStr);    
end


this.OnBack = function()
    if DataExHelper.CommonActivityCheck(ActivityKey.RoomShare) then
        LuaMgr.Back(ActivityKey.RoomShare)
    else
        LuaMgr.Back()
    end
end


this.OnClickStory = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.DHStory2ViewModel);
    end
end


this.OnClickSandTable = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.DHLevel2ViewModel);
    end
end


this.OnClickReward = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.DHShop2ViewModel);
    end
end


this.OnClickSignIn = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.PassesMain2ViewModel);
    end
end


this.OnClickTrain = function()
    if this.CheckActivityRunning() then
        PlayerFoundationMgr.EnterDunHuangRoom(function()
            PlayerFoundationMgr.SetShowAnimator(true);
            FoundationMgr.Open(FoundationMgr.ActivityRoom);
       end);
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.storyBtn, this.OnClickStory);
        LuaMgr.AddClick(this.sandTableBtn, this.OnClickSandTable);       
        LuaMgr.AddClick(this.rewardBtn, this.OnClickReward);
        LuaMgr.AddClick(this.signInBtn, this.OnClickSignIn);
        LuaMgr.AddClick(this.trainBtn, this.OnClickTrain);        
        RedMgr.Singleton:RegisterViewModel(UIName.DHHome2ViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        HeroRedDataHelper.SetDH2Red()
        RedMgr.Singleton:Refresh()
        vm.behaviour:UpdateTopBar("", this.OnBack);
        this.SetData();






    end,
    before_deactive = function(vm)

    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.storyBtn, this.OnClickStory);
        LuaMgr.RemoveClick(this.sandTableBtn, this.OnClickSandTable);        
        LuaMgr.RemoveClick(this.rewardBtn, this.OnClickReward);
        LuaMgr.RemoveClick(this.signInBtn, this.OnClickSignIn);
        LuaMgr.RemoveClick(this.trainBtn, this.OnClickTrain);        
        RedMgr.Singleton:RemoveViewModel(UIName.DHHome2ViewModel);
        if (this.spineGO ~= nil) then
            LuaMgr.Destroy(this.spineGO);
            this.spineGO = nil;
        end
    end
}


this.CheckActivityRunning = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.RoomShare) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"))
        return false;
    end
    return true;
end


return vm({
    data = data,
    command = command,
    hook = hook
})