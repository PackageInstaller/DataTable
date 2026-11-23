require("ViewModel/KZRY/KZRYMedalItem")

local this = {
    scrollView = nil,
    medalList = {},
};

local objs = {
    missionItem = { path = "template/MissionItem", type = "GameObject" },
    bgRt = { path = "root/Bg", type = "RectTransform" },
    sandTableBtn = { path = "root/Middle/SandTable", type = "Button" },
    scheduleBtn = { path = "root/Right/Schedule", type = "Button" },
    textSchedule = { path = "root/Right/Schedule/icon/TextSchedule", type = "Text" },
    storyBtn = { path = "root/Middle/Story", type = "Button" },
    shopBtn = { path = "root/Middle/Shop", type = "Button" },
    signInBtn = { path = "root/Middle/SignIn", type = "Button" },
    dayText = { path = "root/Left/TimeImg/TextTime", type = "Text" },
    collectPanel = { path = "root/Middle/CollectPanel", type = "GameObject" },
    maskBtn = { path = "root/Middle/CollectPanel/Mask", type = "Button" },
    closeBtn = { path = "root/Middle/CollectPanel/closeBtn", type = "Button" },
    scrollViewGO = { path = "root/Middle/CollectPanel/ScrollView", type = "GameObject" },   
    spineCharacter = { path = "root/Bg/box1/Body1", type = "UISpineCharacter" },
    spineCharacter2 = { path = "root/Bg/box2/Body2", type = "UISpineCharacter" },
};


this.SetData = function()
    HeroRedDataHelper.SetKZRYRed()
    local d, h, m = 0, 0, 0
    local timeStr = "";
    if DataExHelper.CommonActivityCheck(ActivityKey.KZRY) then
        local daqin = DataExHelper.GetDataExByTag(ActivityKey.KZRY);
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
    this.medalList = KZRYMgr.GetMedalList()
    local finishMedalCount = 0
    for i, v in ipairs(this.medalList) do
        local curScore = KZRYMgr.GetTotalScore(v.id)
        if curScore.Current >= curScore.Target then
            finishMedalCount = finishMedalCount + 1
        end
    end
    this.textSchedule.text = string.format(LuaMgr.GetLangText("CrisisContract2MainViewModel_0"), finishMedalCount,
        #this.medalList)
    this.SetMedalList()
end

this.SetMedalList = function()
    this.scrollView:Clear(false)
    local scrollData, scrollDatas = {}, {}    
    for i, v in ipairs(this.medalList) do
        local curScore = KZRYMgr.GetTotalScore(v.id)
        local groupData = {}
        groupData.data = v
        groupData.isFinish = curScore.Current >= curScore.Target
        groupData.progress = string.format(LuaMgr.GetLangText("CrisisContract2MedalPopup_0"), curScore.Current,
            curScore.Target)

        scrollData = UIScrollData.GetData(this.missionItem, "KZRYMedalItem", 620, 100, groupData)
        table.insert(scrollDatas, scrollData)
    end
    this.scrollView:SetParams(647, 303)
    this.scrollView:SetData(scrollDatas, true)
end

this.SetCharacter = function()
    local skinId = "ED90501";
    this.spineCharacter:SetBattle(skinId, skinId, "-1", 0, function()
        this.spineCharacter:Play("idle", true, nil);
    end)
    local skinId2 = "ED90601";
    this.spineCharacter2:SetBattle(skinId2, skinId2, "-1", 0, function()
        this.spineCharacter2:Play("idle", true, nil);
    end)
end


this.OnBack = function()
    KZRYMgr.SetShowAni(true)
    if (this.collectPanel.activeSelf) then
        SetActive(this.collectPanel, false)
        return
    end
    if DataExHelper.CommonActivityCheck(ActivityKey.KZRY) then
        LuaMgr.Back(ActivityKey.KZRY)
    else
        LuaMgr.Back()
    end
end


this.OnClickStory = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.KZRYSelectLevelViewModel);
    end
end


this.OnClickSandTable = function()
    if this.CheckActivityRunning() then
        KZRYMgr.SetShowAni(true)
        LuaMgr.ShowLuaPanel(UIName.KZRYExploreViewModel);       
    end
end


this.OnClickShop = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.KZRYShopViewModel);
    end
end


this.OnClickSignIn = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.PassesMainViewModel);
    end
end


this.OnClickSchedule = function()
    SetActive(this.collectPanel, true)
end


this.OnClickCollect = function()
    SetActive(this.collectPanel, false)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.storyBtn, this.OnClickStory);
        LuaMgr.AddClick(this.signInBtn, this.OnClickSignIn);
        LuaMgr.AddClick(this.shopBtn, this.OnClickShop);
        LuaMgr.AddClick(this.sandTableBtn, this.OnClickSandTable);
        LuaMgr.AddClick(this.scheduleBtn, this.OnClickSchedule);
        LuaMgr.AddClick(this.maskBtn, this.OnClickCollect);
        LuaMgr.AddClick(this.closeBtn, this.OnClickCollect);
        RedMgr.Singleton:RegisterViewModel(UIName.KZRYMainViewModel);
        this.scrollView = UIScrollView.New(this.scrollViewGO);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        PlayerMedalMgr.CheckMedalPopup("4009")
        HeroRedDataHelper.SetKZRYRed()
        RedMgr.Singleton:Refresh()
        vm.behaviour:UpdateTopBar("", this.OnBack);
        SetActive(this.collectPanel, false)        
        this.SetData();
        this.SetCharacter();       
    end,
    before_deactive = function(vm)
        this.scrollView:Clear(true);  
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.storyBtn, this.OnClickStory);
        LuaMgr.RemoveClick(this.signInBtn, this.OnClickSignIn);
        LuaMgr.RemoveClick(this.shopBtn, this.OnClickShop);
        LuaMgr.RemoveClick(this.sandTableBtn, this.OnClickSandTable);
        LuaMgr.RemoveClick(this.scheduleBtn, this.OnClickSchedule);
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickCollect);
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickCollect);
        RedMgr.Singleton:RemoveViewModel(UIName.KZRYMainViewModel);
        UIScrollView.ClearItem("KZRYMedalItem");       
        if this.spineCharacter ~= nil then
            this.spineCharacter:Clear();
        end
        if this.spineCharacter2 ~= nil then
            this.spineCharacter2:Clear();
        end
    end
}


this.CheckActivityRunning = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.KZRY) then
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