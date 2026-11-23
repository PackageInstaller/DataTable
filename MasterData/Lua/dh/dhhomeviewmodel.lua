local this = {};

local objs = {
    storyBtn = { path = "root/Left/Story", type = "Button" },
    storyRedDot = { path = "root/Left/Story/RedDot", type = "GameObject" },
    sandTableBtn = { path = "root/Right/SandTable/Button", type = "Button" },
    sandTableRedDot = { path = "root/Right/SandTable/RedDot", type = "GameObject" },
    signInBtn = { path = "root/Left/SignIn", type = "Button" },
    signInRedDot = { path = "root/Left/SignIn/RedDot", type = "GameObject" },
    rewardBtn = { path = "root/Left/Reward", type = "Button" },
    rewardRedDot = { path = "root/Left/Reward/RedDot", type = "GameObject" },
    missionBtn = { path = "root/Right/Mission", type = "Button" },
    missionRedDot = { path = "root/Right/Mission/RedDot", type = "GameObject" },
    missionLockObj = { path = "root/Right/Mission/iconLock", type = "GameObject" },
    missionLocktxt = { path = "root/Right/Mission/iconLock/Image/TextUnLockTime", type = "Text" },
    trainBtn = { path = "root/Right/Train", type = "Button" },
    gameBtn = { path = "root/Right/Game", type = "Button" },
    gameLockObj = { path = "root/Right/Game/iconLock", type = "GameObject" },
    gameLocktxt = { path = "root/Right/Game/iconLock/Image/TextUnLockTime", type = "Text" },
    gameRedDot = { path = "root/Right/Game/RedDot", type = "GameObject" },
    middleTF = { path = "root/Bg_01", type = "Transform" },
    dayText = { path = "root/Right/TimeImg/Text/TextTime", type = "Text" },
};


this.SetData = function()





    local d, h, m = 0, 0, 0
    local timeStr = "";
    if DataExHelper.CommonActivityCheck(ActivityKey.DunHuang) then
        local daqin = DataExHelper.GetDataExByTag(ActivityKey.DunHuang);
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
    this.CheckTime()
end


this.OnBack = function()
    LuaMgr.Back();





end


this.OnClickStory = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.DHStoryViewModel);
    end
end


this.OnClickSandTable = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.DHLevelViewModel);
    end
end


this.OnClickMission = function()
    if(this.missionLockObj.activeSelf) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("7108"))
        return;
    end
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.DHSeekViewModel);
    end
end


this.OnClickReward = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.DHShopViewModel);
    end
end


this.OnClickSignIn = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.PassesMainViewModel);
    end
end


this.OnClickTrain = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.ParkourLevelViewModel);
    end
end


this.OnClickGame = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.DispatchMainViewModel);
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.storyBtn, this.OnClickStory);
        LuaMgr.AddClick(this.sandTableBtn, this.OnClickSandTable);
        LuaMgr.AddClick(this.missionBtn, this.OnClickMission);
        LuaMgr.AddClick(this.rewardBtn, this.OnClickReward);
        LuaMgr.AddClick(this.signInBtn, this.OnClickSignIn);
        LuaMgr.AddClick(this.trainBtn, this.OnClickTrain);
        LuaMgr.AddClick(this.gameBtn, this.OnClickGame);
        RedMgr.Singleton:RegisterViewModel(UIName.DHHomeViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        HeroRedDataHelper.SetDHRed()
        RedMgr.Singleton:Refresh()
        vm.behaviour:UpdateTopBar("", this.OnBack);
        this.SetData();
        if (this.spineGO == nil) then
            local path = "Assets/_BundleResources/UI/KV/KV20.prefab";
            this.spineGO = LuaMgr.GetPrefab(path);          
            this.spineGO.transform:SetParent(this.middleTF, false);
            this.spineGO.transform.localScale = Vector3(0.9, 0.9, 1);
        end
    end,
    before_deactive = function(vm)

    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.storyBtn, this.OnClickStory);
        LuaMgr.RemoveClick(this.sandTableBtn, this.OnClickSandTable);
        LuaMgr.RemoveClick(this.missionBtn, this.OnClickMission);
        LuaMgr.RemoveClick(this.rewardBtn, this.OnClickReward);
        LuaMgr.RemoveClick(this.signInBtn, this.OnClickSignIn);
        LuaMgr.RemoveClick(this.trainBtn, this.OnClickTrain);
        LuaMgr.RemoveClick(this.gameBtn, this.OnClickGame);
        RedMgr.Singleton:RemoveViewModel(UIName.DHHomeViewModel);
        if (this.spineGO ~= nil) then
            LuaMgr.Destroy(this.spineGO);
            this.spineGO = nil;
        end
    end
}


this.CheckActivityRunning = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.DunHuang) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"))
        return false;
    end
    return true;
end

this.CheckTime = function()
    local group = nil
    for i, v in ipairs(ConfigMgr.Config.activityMapList) do
        if v.area == "DH05" then
            group = v
            break
        end
    end
    local curTimeStamp = LuaMgr.Timestamp();
    if group.openDate == 0 and group.closeDate == 0 then
        return true;
    end
    if curTimeStamp < group.openDate then       
        this.missionLocktxt.text = ConfigDHMgr.GetUnlockTimeStr(group.openDate)
    end
    if curTimeStamp > group.closeDate then
        this.missionLocktxt.text = LuaMgr.GetLangText("DHHomeViewModel_0")
    end
    local bShow = curTimeStamp >= group.openDate and curTimeStamp <= group.closeDate
    SetActive(this.missionLockObj, not bShow)    
    return;
end


return vm({
    data = data,
    command = command,
    hook = hook
})