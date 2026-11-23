require("ViewModel/YPS/YPSExploreChapterItem")
local this = {
    chapterUIList = nil,
    scrollWidth = 0,
    itemObjList = {},
    spineGO1 = nil,
    manObj = nil,
    womanObj = nil,
};

local objs = {
    chapterItem = { path = "template/ChapterItem", type = "GameObject" },

    enterGameBtn = { path = "root/Right/EnterGame", type = "Button" },
    otherBtn = { path = "root/Right/Other", type = "Button" },
    shopBtn = { path = "root/Left/Shop", type = "Button" },
    signInBtn = { path = "root/Left/SignIn", type = "Button" },
    checkInBtn = { path = "root/Middle/CheckIn", type = "Button" },
    videoBtn = { path = "root/Right/Video", type = "Button" },
    video2Btn = { path = "root/Right/Video/Video2", type = "Button" },
    missionBtn = { path = "root/Right/Mission", type = "Button" },
    talentBtn = { path = "root/Right/Talent", type = "Button" },
    dayText = { path = "root/Middle/TimeImg/TextTime", type = "Text" },
    tranContent = { path = "root/SVChapter/Viewport/tranContent", type = "RectTransform" },
    tranCity = { path = "root/SVChapter/Viewport/tranContent/tranCity", type = "RectTransform" },
};

local chapterPos = { Vector2(-1303, 89), Vector2(-680, -60), Vector2(-129, 68), Vector2(530, -70),
    Vector2(1251, 60) }


this.SetData = function()
    this.dayText.text = YPSMgr.GetTimeStr()
    this.groupList = YPSMgr.GetGroupsByYPS("YPS01");
    this.SetChapterList()
end

this.SetChapterList = function()
    if IsNull(this.groupList) then return end;
    this.chapterUIList:Clear();
    local list = {}
    local unLockIndex = 1
    SetActive(this.video2Btn.gameObject, false)
    for i, v in ipairs(this.groupList) do
        local pLock, type, lockInfo = YPSMgr.CheckGroupIsLock(v)

        if (not pLock) then
            unLockIndex = i
        end
        local chapterData = {
            index = i,
            isLock = pLock,
            lockInfo = type == 1 and lockInfo or ConfigMgr.LangGlobal("10352"),
            lockInfoTips = lockInfo,
            config = v,
            locPos = chapterPos[i] ~= nil and chapterPos[i] or Vector2.zero,
            callBack = this.CityCallBack,
        }
        local cityData = UIListData.GetData(this.chapterItem, "YPSExploreChapterItem", chapterData);
        table.insert(list, cityData);
        if (i == 5 and not pLock) then
            local pro, max = YPSMgr.GetEventsProByGroup(v.id);
            if (pro == max) then
                this.OnFirstMainPage()
            end
        end
    end
    this.chapterUIList:SetData(list);
    this.SetMapPos(unLockIndex, false)
end

this.GetEventsProStrTip = function(groupId)
    local pro, max = YPSMgr.GetEventsProByGroup(groupId);
    local proStr = ConfigMgr.LangGlobal("25203");
    local endStr = string.format("<color=#f8febe>%s</color>/%s", pro, max);
    return string.format(proStr, endStr);
end

this.CityCallBack = function(index)
    local curGroup = this.groupList[index];
    if curGroup == nil then return end;
    LuaMgr.ShowLuaPanel(UIName.YPSSwitchViewModel, index);
end

this.SetMapPos = function(moveIndex, bAnim)
    local tar = this.chapterUIList.itemList[moveIndex].transform
    if (bAnim) then
        if this.tweener2 ~= nil then
            this.tweener2:Kill();
        end
        this.tweener2 = DOTWeen.To(function() return this.tranContent.anchoredPosition end, function(value)
            this.tranContent.anchoredPosition = value;
        end, tar.anchoredPosition * -1, 0.5):SetEase(Ease.Linear);
    else
        this.tranContent.anchoredPosition = tar.anchoredPosition * -1
    end
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

    if DataExHelper.CommonActivityCheck(ActivityKey.YPS) then
        LuaMgr.Back(ActivityKey.YPS)
    else
        LuaMgr.Back()
    end
end


this.OnClickSandTable = function()
    if this.CheckActivityRunning() then

        LuaMgr.ShowLuaPanel(UIName.YPSChallengeViewModel);
    end
end


this.OnClickShop = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.YPSShopViewModel);
    end
end


this.OnClickSignIn = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.PassesMain2ViewModel,"4170","#3d6053","ui_hd_ty_dtyl_bt_wps");
    end
end

this.OnClickCheckIn = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.YPSSignIn7DaysViewModel);
    end
end

this.OnClickVideo = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.YPSNovelViewModel);
    end
end

this.OnClickVideo2 = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.PlayVideoViewModel, "YPS_PV")
    end
end

this.OnClickMission = function(...)
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.YPSGameMissionViewModel);
    end
end

this.OnClickTalent = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.YPSGameSkillViewModel);
    end
end


this.OnClickOther = function()
    if this.CheckActivityRunning() and YPSMgr.CheckChallengeTimes() then
        LuaMgr.ShowLuaPanel(UIName.YPSGameViewModel);
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.otherBtn, this.OnClickOther);
        LuaMgr.AddClick(this.signInBtn, this.OnClickSignIn);
        LuaMgr.AddClick(this.checkInBtn, this.OnClickCheckIn);
        LuaMgr.AddClick(this.videoBtn, this.OnClickVideo);
        LuaMgr.AddClick(this.video2Btn, this.OnClickVideo2);
        LuaMgr.AddClick(this.missionBtn, this.OnClickMission);
        LuaMgr.AddClick(this.talentBtn, this.OnClickTalent);
        LuaMgr.AddClick(this.shopBtn, this.OnClickShop);
        LuaMgr.AddClick(this.enterGameBtn, this.OnClickSandTable);

        RedMgr.Singleton:RegisterViewModel(UIName.YPSMainViewModel);
        this.chapterUIList = UIListView.New(this.tranCity);
        local addWidth = LuaMgr.GetScreenAddWidth();
        this.scrollWidth = 1280 + addWidth;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        HeroRedDataHelper.SetYPSRed()
        RedMgr.Singleton:Refresh()
        vm.behaviour:UpdateTopBar("", this.OnBack);
        this.SetData();

    end,
    before_deactive = function(vm)
        this.chapterUIList:Clear();
        if this.itemObjList ~= nil then
            for i = 1, #this.itemObjList do
                this.itemObjList[i]:Clear()
            end
            this.itemObjList = {}
        end
        if this.tweener2 ~= nil then
            this.tweener2:Kill();
        end
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.otherBtn, this.OnClickOther);
        LuaMgr.RemoveClick(this.signInBtn, this.OnClickSignIn);
        LuaMgr.RemoveClick(this.checkInBtn, this.OnClickCheckIn);
        LuaMgr.RemoveClick(this.videoBtn, this.OnClickVideo);
        LuaMgr.RemoveClick(this.video2Btn, this.OnClickVideo2);
        LuaMgr.RemoveClick(this.missionBtn, this.OnClickMission);
        LuaMgr.RemoveClick(this.talentBtn, this.OnClickTalent);
        LuaMgr.RemoveClick(this.shopBtn, this.OnClickShop);
        LuaMgr.RemoveClick(this.enterGameBtn, this.OnClickSandTable);

        RedMgr.Singleton:RemoveViewModel(UIName.YPSMainViewModel);
        UIListView.ClearItem("YPSExploreChapterItem");
        if (this.spineGO1 ~= nil) then
            LuaMgr.Destroy(this.spineGO1);
            this.spineGO1 = nil;
        end
    end
}


this.CheckActivityRunning = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.YPS) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"))
        return false;
    end
    return true;
end

this.OnFirstMainPage = function()
    local key = DataMgr.Player.uid .. "YPS"
    local cache = PlayerPrefs.GetInt(key)
    if cache == 1 then
        SetActive(this.video2Btn.gameObject, true)
        this.firstShow = false
        return
    end
    PlayerPrefs.SetInt(key, 1)
    this.firstShow = true
    LuaMgr.ShowLuaPanel(UIName.PlayVideoViewModel, "YPS_PV")
end


return vm({
    data = data,
    command = command,
    hook = hook
})