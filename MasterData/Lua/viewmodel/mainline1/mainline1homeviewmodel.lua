local this =
{
    canFightArea = nil,
    abyssCantFigthMsg = nil,
    missionInterfaceTb = { ["laigu"] = "2201", ["zhengzhou"] = "2202", ["shanghai"] = "2203", ["guangzhou"] = "2204", ["xian"] = "2205", ["saibei"] = "2206", },
    activityKey = nil
};

local objs = {
    bgMask = { path = "root/BgMask", type = "RectTransform" },
    sandTableBtn = { path = "root/Middle/Right/Box/SandTable", type = "Button" },
    sandTableRedDot = { path = "root/Middle/Right/Box/SandTable/RedDot", type = "GameObject" },
    storyBtn = { path = "root/Middle/Right/Story", type = "Button" },
    storyRedDot = { path = "root/Middle/Right/Story/RedDot", type = "GameObject" },
    videoBtn = { path = "root/Middle/Right/Video", type = "Button" },
    videoRedDot = { path = "root/Middle/Right/Video/RedDot", type = "GameObject" },
    missionBtn = { path = "root/Middle/Right/Box/Mission", type = "Button" },
    missionRedDot = { path = "root/Middle/Right/Box/Mission/RedDot", type = "GameObject" },
    signInBtn = { path = "root/Middle/Left/SignIn", type = "Button" },
    signInRedDot = { path = "root/Middle/Left/SignIn/RedDot", type = "GameObject" },
    rewardBtn = { path = "root/Middle/Left/Reward", type = "Button" },
    rewardRedDot = { path = "root/Middle/Left/Reward/RedDot", type = "GameObject" },
    playGameBtn = { path = "root/Middle/Left/PlayGame", type = "Button" },
    dayText = { path = "root/Middle/TimeImg/TextTime", type = "Text" },


    bg1 = { path = "root/Bg1", type = "GameObject" },
    bg2 = { path = "root/Bg2", type = "GameObject" },
    imageLine1 = { path = "root/ImageLine1", type = "GameObject" },
    imageLine2 = { path = "root/ImageLine2", type = "GameObject" },
    imageTitle1 = { path = "root/ImageTitle1", type = "GameObject" },
    imageTitle2 = { path = "root/ImageTitle2", type = "GameObject" },
    signInIcon1 = { path = "root/Middle/Left/SignIn/icon1", type = "GameObject" },
    signInIcon2 = { path = "root/Middle/Left/SignIn/icon2", type = "GameObject" },
    rewardIcon1 = { path = "root/Middle/Left/Reward/icon1", type = "GameObject" },
    rewardIcon2 = { path = "root/Middle/Left/Reward/icon2", type = "GameObject" },
    storyIcon1 = { path = "root/Middle/Right/Story/icon1", type = "GameObject" },
    storyIcon2 = { path = "root/Middle/Right/Story/icon2", type = "GameObject" },
    sandTableIcon1 = { path = "root/Middle/Right/Box/SandTable/icon1", type = "GameObject" },
    sandTableIcon2 = { path = "root/Middle/Right/Box/SandTable/icon2", type = "GameObject" },
    missionIcon1 = { path = "root/Middle/Right/Box/Mission/icon1", type = "GameObject" },
    missionIcon2 = { path = "root/Middle/Right/Box/Mission/icon2", type = "GameObject" },
};

this.SwitchType = function(_type)
    for i = 1, 2 do
        if (i == _type) then
            this["bg" .. i]:SetActive(true);
            this["imageLine" .. i]:SetActive(true);
            this["imageTitle" .. i]:SetActive(true);
            this["signInIcon" .. i]:SetActive(true);
            this["rewardIcon" .. i]:SetActive(true);
            this["storyIcon" .. i]:SetActive(true);
            this["sandTableIcon" .. i]:SetActive(true);
            this["missionIcon" .. i]:SetActive(true);
        else
            this["bg" .. i]:SetActive(false);
            this["imageLine" .. i]:SetActive(false);
            this["imageTitle" .. i]:SetActive(false);
            this["signInIcon" .. i]:SetActive(false);
            this["rewardIcon" .. i]:SetActive(false);
            this["storyIcon" .. i]:SetActive(false);
            this["sandTableIcon" .. i]:SetActive(false);
            this["missionIcon" .. i]:SetActive(false);
        end
    end
end


this.SetData = function()
    local d, h, m = 0, 0, 0
    local timeStr = "";
    local curType = ConfigMainLineMgr.CheckCanSwitch() and 1 or 2;
    this.SwitchType(curType)
    if (curType == 1) then
        this.activityKey = ActivityKey.MainLine1
    else
        this.activityKey = ActivityKey.MainLine2
    end
    SetActive(this.sandTableBtn.gameObject, curType == 2)
    SetActive(this.playGameBtn.gameObject, curType == 2)
    SetActive(this.videoBtn.gameObject, curType == 2)
    if DataExHelper.CommonActivityCheck(this.activityKey) then
        local daqin = DataExHelper.GetDataExByTag(this.activityKey);
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

    this.canFightArea = PlayerAreaMapMgr.CheckAreaCanFight("zhengzhuan").area
    local abyssCanFight, abyssCantFight = PlayerAreaMapMgr.CheckAreaCanFight("abyss")
    this.abyssCantFigthMsg = nil
    if (abyssCanFight == nil) then
        local tipName = LuaMgr.GetLangText(ConfigMgr.Config.dungeonMap[abyssCantFight.unlockParam].NameLan)
        local tipStr = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["12002"].NameLan), tipName)
        this.abyssCantFigthMsg = tipStr
    end
end


this.OnBack = function()
    if DataExHelper.CommonActivityCheck(this.activityKey) then
        LuaMgr.Back(this.activityKey)
    else
        LuaMgr.Back()
    end
end


this.OnClickStory = function()
    if this.CheckActivityRunning() then
        if (RedMgr.Singleton:CheckRedCondition("16803")) then
            RedMgr.Singleton:FrushRedCondition("16803")
        end
        LuaMgr.ShowLuaPanel(UIName.AreaMapViewModel, this.canFightArea)
    end
end


this.OnClickVideo = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.PlayVideoViewModel,"Main6_PV")
    end
end


this.OnClickMission = function()
    if this.CheckActivityRunning() then
        local id = this.missionInterfaceTb[this.canFightArea]
        LuaMgr.ShowLuaPanel(UIName.AreaMapViewModel, this.canFightArea, id)
    end
end


this.OnClickSandTable = function()
    if this.CheckActivityRunning() then
        if (RedMgr.Singleton:CheckRedCondition("16802")) then
            RedMgr.Singleton:FrushRedCondition("16802")
        end
        if (this.abyssCantFigthMsg == nil) then
            LuaMgr.ShowLuaPanel(UIName.AreaMapViewModel, this.canFightArea, 2099)
        else
            LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", this.abyssCantFigthMsg)
        end
    end
end


this.OnClickReward = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.MainLine1PrizeViewModel);
    end
end

this.OnClickGameBtn = function (...)
    if this.CheckActivityRunning() then
        if (RedMgr.Singleton:CheckRedCondition("16807")) then
            RedMgr.Singleton:FrushRedCondition("16807")
        end
        LuaMgr.ShowLuaPanel(UIName.MainLine1PlayViewModel);
    end
end


this.OnClickSignIn = function()
    if this.CheckActivityRunning() then
        if (this.activityKey == ActivityKey.MainLine1) then
            LuaMgr.ShowLuaPanel(UIName.PassesMainViewModel);
        else
            LuaMgr.ShowLuaPanel(UIName.PassesMain2ViewModel);
        end
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.storyBtn, this.OnClickStory);
        LuaMgr.AddClick(this.videoBtn, this.OnClickVideo);
        LuaMgr.AddClick(this.missionBtn, this.OnClickMission)
        LuaMgr.AddClick(this.rewardBtn, this.OnClickReward);
        LuaMgr.AddClick(this.playGameBtn, this.OnClickGameBtn)
        LuaMgr.AddClick(this.signInBtn, this.OnClickSignIn);
        LuaMgr.AddClick(this.sandTableBtn, this.OnClickSandTable);
        RedMgr.Singleton:RegisterViewModel(UIName.MainLine1HomeViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end      
        HeroRedDataHelper.SetMainLine1Red()
        RedMgr.Singleton:Refresh()
        vm.behaviour:UpdateTopBar("", this.OnBack);
        this.SetData();       
        if (this.spineGO1 ~= nil) then
            SetActive(this.spineGO1.GameObject, false)
        end
        if (this.spineGO2 ~= nil) then
            SetActive(this.spineGO2.GameObject, false)
        end
        if (this.activityKey == ActivityKey.MainLine1) then
            if (this.spineGO1 == nil) then
                local path = "Assets/_BundleResources/UI/KV/KV30.prefab";
                this.spineGO1 = LuaMgr.GetPrefab(path);
                this.spineGO1.transform:SetParent(this.bg1.transform, false);
                this.spineGO1.transform.localScale = Vector3(0.84, 0.84, 0.84);


            end
            SetActive(this.spineGO1.GameObject, true)
        else
            this.OnFirstMainPage()       
            if (this.spineGO2 == nil) then
                local path = "Assets/_BundleResources/UI/KV/KV2202.prefab";
                this.spineGO2 = LuaMgr.GetPrefab(path);
                this.spineGO2.transform:SetParent(this.bg2.transform, false);
                this.spineGO2.transform.localScale = Vector3(0.84, 0.84, 0.84);


            end
            SetActive(this.spineGO2.GameObject, true)
        end
    end,
    before_deactive = function(vm)

    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.storyBtn, this.OnClickStory);
        LuaMgr.RemoveClick(this.videoBtn, this.OnClickVideo);
        LuaMgr.RemoveClick(this.missionBtn, this.OnClickMission)
        LuaMgr.RemoveClick(this.rewardBtn, this.OnClickReward);
        LuaMgr.RemoveClick(this.playGameBtn, this.OnClickGameBtn)
        LuaMgr.RemoveClick(this.signInBtn, this.OnClickSignIn);
        LuaMgr.RemoveClick(this.sandTableBtn, this.OnClickSandTable);
        RedMgr.Singleton:RemoveViewModel(UIName.MainLine1HomeViewModel);
        if (this.spineGO1 ~= nil) then
            LuaMgr.Destroy(this.spineGO1);
            this.spineGO1 = nil;
        end
        if (this.spineGO2 ~= nil) then
            LuaMgr.Destroy(this.spineGO2);
            this.spineGO2 = nil;
        end
    end
}


this.CheckActivityRunning = function()
    if not DataExHelper.CommonActivityCheck(this.activityKey) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"))
        return false;
    end
    return true;
end

this.OnFirstMainPage = function()
    local key = DataMgr.Player.uid .. "MainLine1"
    local cache = PlayerPrefs.GetInt(key)
    if cache == 1 then
        this.firstShow = false
        return
    end
    PlayerPrefs.SetInt(key, 1)
    this.firstShow = true
    LuaMgr.ShowLuaPanel(UIName.PlayVideoViewModel,"Main6_PV")
end


return vm({
    data = data,
    command = command,
    hook = hook
})