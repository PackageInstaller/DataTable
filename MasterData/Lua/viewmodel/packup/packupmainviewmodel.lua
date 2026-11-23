require("ViewModel/PackUp/PackUpMedalItem")

local this = {
    scrollView = nil,
    scrollWidth = 0,
    medalList = {},
    itemObjList = {},
    spineGO1 = nil,
    manObj = nil,
    womanObj = nil,
};

local objs = {
    missionItem = { path = "template/MissionItem", type = "GameObject" },
    collectItem = { path = "template/CollectItem", type = "GameObject" },
    bgRt = { path = "root/Bg", type = "RectTransform" },
    enterGameBtn = { path = "root/Right/EnterGame", type = "Button" },
    scheduleBtn = { path = "root/Left/Schedule", type = "Button" },
    textSchedule = { path = "root/Left/Schedule/icon/TextSchedule", type = "Text" },
    otherBtn = { path = "root/Right/Other", type = "Button" },
    ratioTex = { path = "root/Right/Other/ratioBg/RatioText", type = "Text" },
    shopBtn = { path = "root/Left/Shop", type = "Button" },
    signInBtn = { path = "root/Left/SignIn", type = "Button" },
    dayText = { path = "root/Middle/TimeImg/TextTime", type = "Text" },
    collectPanel = { path = "root/Middle/CollectPanel", type = "GameObject" },
    maskBtn = { path = "root/Middle/CollectPanel/Mask", type = "Button" },
    closeBtn = { path = "root/Middle/CollectPanel/closeBtn", type = "Button" },
    scrollViewGO = { path = "root/Middle/CollectPanel/ScrollView", type = "GameObject" },
};


this.SetData = function()
    local d, h, m = 0, 0, 0
    local timeStr = "";
    if DataExHelper.CommonActivityCheck(ActivityKey.PackUp) then
        local daqin = DataExHelper.GetDataExByTag(ActivityKey.PackUp);
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
    this.medalList = PackUpMgr.GetMedalList()
    local finishMedalCount = 0
    for i, v in ipairs(this.medalList) do
        local curScore = PackUpMgr.GetTotalScore(v.id)
        if curScore.Current >= curScore.Target then
            finishMedalCount = finishMedalCount + 1
        end
    end
    this.textSchedule.text = string.format(LuaMgr.GetLangText("CrisisContract2MainViewModel_0"), finishMedalCount,
        #this.medalList)
    this.SetMedalList()
    this.RefreshItemCollectPanel()
end

this.SetMedalList = function()
    this.scrollView:Clear(false)
    local scrollData, scrollDatas = {}, {}
    for i, v in ipairs(this.medalList) do
        local curScore = PackUpMgr.GetTotalScore(v.id)
        local groupData = {}
        groupData.data = v
        groupData.isFinish = curScore.Current >= curScore.Target
        groupData.progress = string.format(LuaMgr.GetLangText("CrisisContract2MedalPopup_0"), curScore.Current,
            curScore.Target)

        scrollData = UIScrollData.GetData(this.missionItem, "PackUpMedalItem", 620, 100, groupData)
        table.insert(scrollDatas, scrollData)
    end
    this.scrollView:SetParams(647, 303)
    this.scrollView:SetData(scrollDatas, true)
end

this.SetKV = function()
    if (this.spineGO1 ~= nil) then
        SetActive(this.spineGO1.GameObject, false)
    end
    if (this.spineGO1 == nil) then
        local path = "Assets/_BundleResources/UI/PackUp/PackUp001.prefab";
        this.spineGO1 = LuaMgr.GetPrefab(path);
        this.spineGO1.transform:SetParent(this.bgRt.transform, false);
        this.spineGO1.transform.localScale = Vector3(0.25, 0.25, 0.25);
        this.manObj = this.spineGO1.transform:Find("man")
        this.womanObj = this.spineGO1.transform:Find("woman")
    end
    local isWoMan = DataMgr.Player.sex > 1
    this.womanObj.gameObject:SetActive(isWoMan)
    this.manObj.gameObject:SetActive(not isWoMan)
    SetActive(this.spineGO1.GameObject, true)
end


this.OnBack = function()

    if (this.collectPanel.activeSelf) then
        SetActive(this.collectPanel, false)
        return
    end
    if DataExHelper.CommonActivityCheck(ActivityKey.PackUp) then
        LuaMgr.Back(ActivityKey.PackUp)
    else
        LuaMgr.Back()
    end
end


this.OnClickSandTable = function()
    if this.CheckActivityRunning() then

        LuaMgr.ShowLuaPanel(UIName.PackUpExploreViewModel);
    end
end


this.OnClickShop = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.PackUpShopViewModel);
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


this.OnClickOther = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.PackUpCollectViewModel);
    end
end

this.RefreshItemCollectPanel = function()
    local getNum = 0
    local totalNum = 0
    for i, v in pairs(ConfigMgr.Config.PackUpCollectMap) do
        totalNum = totalNum + 1
        local item = DataMgr.Player.items[v.UnClock[1].id]
        local isFinish = DataMgr.Player.PackUpCollectMap[v.Id]
        if ((item ~= nil and item.count0 > 0) or isFinish) then
            getNum = getNum + 1
        end
    end
    this.ratioTex.text = LuaMgr.GetLangText("PackUpMainViewModel_0") ..
        getNum .. "</color><color=#c9ded2>/" .. totalNum .. "</color>"
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.otherBtn, this.OnClickOther);
        LuaMgr.AddClick(this.signInBtn, this.OnClickSignIn);
        LuaMgr.AddClick(this.shopBtn, this.OnClickShop);
        LuaMgr.AddClick(this.enterGameBtn, this.OnClickSandTable);
        LuaMgr.AddClick(this.scheduleBtn, this.OnClickSchedule);
        LuaMgr.AddClick(this.maskBtn, this.OnClickCollect);
        LuaMgr.AddClick(this.closeBtn, this.OnClickCollect);

        RedMgr.Singleton:RegisterViewModel(UIName.PackUpMainViewModel);
        this.scrollView = UIScrollView.New(this.scrollViewGO);
        local addWidth = LuaMgr.GetScreenAddWidth();
        this.scrollWidth = 1280 + addWidth;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        PlayerMedalMgr.CheckMedalPopup("4150")
        HeroRedDataHelper.SetPackUpRed()
        RedMgr.Singleton:Refresh()
        vm.behaviour:UpdateTopBar("", this.OnBack);
        SetActive(this.collectPanel, false)
        this.OnFirstMainPage()
        this.SetData();
        this.SetKV();
    end,
    before_deactive = function(vm)
        this.scrollView:Clear(true);
        if this.itemObjList ~= nil then
            for i = 1, #this.itemObjList do
                this.itemObjList[i]:Clear()
            end
            this.itemObjList = {}
        end
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.otherBtn, this.OnClickOther);
        LuaMgr.RemoveClick(this.signInBtn, this.OnClickSignIn);
        LuaMgr.RemoveClick(this.shopBtn, this.OnClickShop);
        LuaMgr.RemoveClick(this.enterGameBtn, this.OnClickSandTable);
        LuaMgr.RemoveClick(this.scheduleBtn, this.OnClickSchedule);
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickCollect);
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickCollect);

        RedMgr.Singleton:RemoveViewModel(UIName.PackUpMainViewModel);
        UIScrollView.ClearItem("PackUpMedalItem");
        if (this.spineGO1 ~= nil) then
            LuaMgr.Destroy(this.spineGO1);
            this.spineGO1 = nil;
        end
    end
}


this.CheckActivityRunning = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.PackUp) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"))
        return false;
    end
    return true;
end

this.OnFirstMainPage = function()
    local key = DataMgr.Player.uid .. "PackUp"
    local cache = PlayerPrefs.GetInt(key)
    if cache == 1 then
        this.firstShow = false
        return
    end
    PlayerPrefs.SetInt(key, 1)
    this.firstShow = true
    LuaMgr.PlayNovel("PU10001", function()
        LuaMgr.ShowLuaPanel(UIName.PackUpMainViewModel);
    end);
end


return vm({
    data = data,
    command = command,
    hook = hook
})