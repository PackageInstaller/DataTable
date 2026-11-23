local this = {};

local objs = {
    bgRt = { path = "root/Bg", type = "RectTransform" },
    sandTableBtn = { path = "root/Middle/Right/SandTable", type = "Button" },
    sandTableRedDot = { path = "root/Middle/Right/SandTable/RedDot", type = "GameObject" },
    storyBtn = { path = "root/Middle/Right/Story", type = "Button" },
    storyRedDot = { path = "root/Middle/Right/Story/RedDot", type = "GameObject" },
    signInBtn = { path = "root/Middle/Left/SignIn", type = "Button" },
    signInRedDot = { path = "root/Middle/Left/SignIn/RedDot", type = "GameObject" },
    rewardBtn = { path = "root/Middle/Left/Reward", type = "Button" },
    rewardRedDot = { path = "root/Middle/Left/Reward/RedDot", type = "GameObject" },
    dayText = { path = "root/Middle/TimeImg/TextTime", type = "Text" },
};


this.SetData = function()





    local d, h, m = 0, 0, 0
    local timeStr = "";
    if DataExHelper.CommonActivityCheck(ActivityKey.LightEvent) then
        local daqin = DataExHelper.GetDataExByTag(ActivityKey.LightEvent);
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
    local numTab = PlayerZGCXMgr.GetEventsNum()
    SetActive(this.storyBtn.gameObject,numTab[1] > 0)  
end


this.OnBack = function()
    if DataExHelper.CommonActivityCheck(ActivityKey.LightEvent) then
        LuaMgr.Back(ActivityKey.LightEvent)
    else
        LuaMgr.Back()
    end
end


this.OnClickStory = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.ZGCXMainViewModel, 1);
    end
end


this.OnClickSandTable = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.ZGCXMainViewModel);
    end
end


this.OnClickReward = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.ZGCXShopViewModel);
    end
end


this.OnClickSignIn = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.PassesMainViewModel);
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.storyBtn, this.OnClickStory);
        LuaMgr.AddClick(this.rewardBtn, this.OnClickReward);
        LuaMgr.AddClick(this.signInBtn, this.OnClickSignIn);
        LuaMgr.AddClick(this.sandTableBtn, this.OnClickSandTable);
        RedMgr.Singleton:RegisterViewModel(UIName.ZGCXHomeViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        HeroRedDataHelper.SetZGCXRed()
        RedMgr.Singleton:Refresh()
        vm.behaviour:UpdateTopBar("", this.OnBack);
        this.SetData();
        if (this.spineGO == nil) then
            local path = "Assets/_BundleResources/UI/KV/KV21.prefab";
            this.spineGO = LuaMgr.GetPrefab(path);
            this.spineGO.transform:SetParent(this.bgRt.transform, false);
            this.spineGO.transform.localScale = Vector3(1, 1, 1);
            local logo = this.spineGO.transform:Find("KV21/logo")
            logo.gameObject:SetActive(false)
        end
    end,
    before_deactive = function(vm)

    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.storyBtn, this.OnClickStory);
        LuaMgr.RemoveClick(this.rewardBtn, this.OnClickReward);
        LuaMgr.RemoveClick(this.signInBtn, this.OnClickSignIn);
        LuaMgr.RemoveClick(this.sandTableBtn, this.OnClickSandTable);
        RedMgr.Singleton:RemoveViewModel(UIName.ZGCXHomeViewModel);
        if (this.spineGO ~= nil) then
            LuaMgr.Destroy(this.spineGO);
            this.spineGO = nil;
        end
    end
}


this.CheckActivityRunning = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.LightEvent) then
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