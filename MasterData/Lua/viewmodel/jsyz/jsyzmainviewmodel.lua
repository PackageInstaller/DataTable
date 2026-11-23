require("ViewModel/JSYZ/JSYZMapLvItem")

local this =
{
    activityKey = nil,
    curGameLv = 1,
    eventList = nil,
    mapEventList = {},
    selectedLvConfig = nil,
    medalActivityID = "5130",
    chapterList = nil,
    curSelectChapter = nil,
    allMapEvents = nil,
    chapterPos1 = { { -40, 88 }, { -7, 33 }, { 4, -31 }, { -6, -85 } },
    chapterPos2 = { { -22, 62 }, { -7, 2 }, { -19, -54 } },
    chapterPos3 = { { -2, 55 }, { -9, 2 }, { 11, -54 } },
    chapterPos4 = { { 53, 114 }, { 10, 68 }, { -15, 11 }, { -17, -44 }, { -2, -98 } },
};

local objs = {
    levelItem = { path = "template/LevelItem", type = "GameObject" },
    rootAnimator = { path = "root", type = "Animator" },
    sandTableBtn = { path = "root/Right/SandTable", type = "Button" },
    storyBtn = { path = "root/Right/Story", type = "Button" },
    videoBtn = { path = "root/Right/Video", type = "Button" },
    missionBtn = { path = "root/Right/Mission", type = "Button" },
    signInBtn = { path = "root/Left/SignIn", type = "Button" },
    textRatio = { path = "root/Left/SignIn/TextRatio", type = "Text" },
    rewardBtn = { path = "root/Left/Reward", type = "Button" },
    playGameBtn = { path = "root/Right/PlayGame", type = "Button" },
    imgChapter1 = { path = "root/Middle/ImgChapter1/btn", type = "Button" },
    imgSelect1 = { path = "root/Middle/ImgChapter1/ImgSelect", type = "GameObject" },
    itemListBox1 = { path = "root/Middle/ImgChapter1/ItemListBox", type = "Transform" },
    imgFinishAll1 = { path = "root/Middle/ImgChapter1/ImgFinishAll", type = "GameObject" },
    imgChapter2 = { path = "root/Middle/ImgChapter2/btn", type = "Button" },
    imgSelect2 = { path = "root/Middle/ImgChapter2/ImgSelect", type = "GameObject" },
    itemListBox2 = { path = "root/Middle/ImgChapter2/ItemListBox", type = "Transform" },
    imgFinishAll2 = { path = "root/Middle/ImgChapter2/ImgFinishAll", type = "GameObject" },
    imgChapter3 = { path = "root/Middle/ImgChapter3/btn", type = "Button" },
    imgSelect3 = { path = "root/Middle/ImgChapter3/ImgSelect", type = "GameObject" },
    itemListBox3 = { path = "root/Middle/ImgChapter3/ItemListBox", type = "Transform" },
    imgFinishAll3 = { path = "root/Middle/ImgChapter3/ImgFinishAll", type = "GameObject" },
    imgChapter4 = { path = "root/Middle/ImgChapter4/btn", type = "Button" },
    imgSelect4 = { path = "root/Middle/ImgChapter4/ImgSelect", type = "GameObject" },
    itemListBox4 = { path = "root/Middle/ImgChapter4/ItemListBox", type = "Transform" },
    imgFinishAll4 = { path = "root/Middle/ImgChapter4/ImgFinishAll", type = "GameObject" },
    imgSelectLv = { path = "root/ImgSelectLv", type = "Button" },
    textLevel = { path = "root/ImgSelectLv/Image/TextLevel", type = "Text" },
    levelFinish = { path = "root/ImgSelectLv/Image/TextLevel/finish", type = "GameObject" },
    btnLeft = { path = "root/ImgSelectLv/Image/btnLeft", type = "Button" },
    btnRight = { path = "root/ImgSelectLv/Image/btnRight", type = "Button" },
    btnComfirm = { path = "root/ImgSelectLv/Image/btnComfirm", type = "Button" },
    btnComfirmGray = { path = "root/ImgSelectLv/Image/btnComfirm", type = "UIGray" },
    dayText = { path = "root/Middle/TimeImg/TextTime", type = "Text" },
    gameSkill = { path = "root/Right/GameSkill", type = "Button" },
};




this.SetData = function()
    this.activityKey = ActivityKey.JSYZ
    this.curSelectChapter = nil
    this.allMapEvents = DataExHelper.GetActivityMapEventMap()
    SetActive(this.sandTableBtn.gameObject, true)
    SetActive(this.playGameBtn.gameObject, true)
    SetActive(this.videoBtn.gameObject, false)
    this.dayText.text = JSYZMgr.GetTimeStr()
    local cacheList = JSYZMgr.GetActiveEventsByArea("JSYZ")
    this.eventList = {}
    for i, v in ipairs(cacheList) do
        if v.type == 3 then
            table.insert(this.eventList, v)
            local pUnLock = JSYZMgr.CheckEventIsUnLock(v);
            local finish = JSYZMgr.CheckEventIsComplete(v)
            if pUnLock and not finish then
                this.curGameLv = #this.eventList
            end
        end
    end
    this.InitChapter()
    local finishMedalCount1 = DataExHelper.GetMedalFinishCount(this.medalActivityID)
    local medalList1 = DataExHelper.GetMedalList(this.medalActivityID)
    this.medalList = {}
    for key, value in pairs(medalList1) do
        table.insert(this.medalList, value)
    end
    this.textRatio.text = string.format(LuaMgr.GetLangText("CrisisContract2MainViewModel_0"), finishMedalCount1,
        #this.medalList)
    this.SwitchChapter(JSYZMgr.GetChapterIndex())
end


this.OnBack = function()
    JSYZMgr.SetShowAni(true);
    JSYZMgr.SetChapterIndex(nil)
    if DataExHelper.CommonActivityCheck(this.activityKey) then
        LuaMgr.Back(this.activityKey)
    else
        LuaMgr.Back()
    end
end


this.OnClickStory = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.JSYZNovelViewModel)
    end
end


this.OnClickVideo = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.PlayVideoViewModel, "Main6_PV")
    end
end


this.OnClickMission = function()
    if this.CheckActivityRunning() then
        if (RedMgr.Singleton:CheckRedCondition("16802")) then
            RedMgr.Singleton:FrushRedCondition("16802")
        end
        LuaMgr.ShowLuaPanel(UIName.JSYZGameMissionViewModel)
    end
end


this.OnClickSandTable = function()
    if this.CheckActivityRunning() then
        if (RedMgr.Singleton:CheckRedCondition("16803")) then
            RedMgr.Singleton:FrushRedCondition("16803")
        end
        LuaMgr.ShowLuaPanel(UIName.JSYZChallengeViewModel)
    end
end


this.OnClickReward = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.JSYZShopViewModel);
    end
end

this.OnClickGameBtn = function()
    if this.CheckActivityRunning() then
        if (RedMgr.Singleton:CheckRedCondition("16807")) then
            RedMgr.Singleton:FrushRedCondition("16807")
        end
        this.SwitchGameLv(this.curGameLv)
        SetActive(this.imgSelectLv.gameObject, true)
    end
end

this.OnClickSelectLv = function()
    SetActive(this.imgSelectLv.gameObject, false)
end


this.OnClickSignIn = function()
    if this.CheckActivityRunning() then
        local data = {}
        data.medalActivityID = this.medalActivityID
        data.medalColor = "#3d6053"
        data.medalImgKey = "ui_hd_ty_dtyl_bt_wtzj"
        data.bgmPath = "Assets/_BundleResources/Audio/Bgm/JSYZ.mp3"
        LuaMgr.ShowLuaPanel(UIName.PassesMain2ViewModel, data);
    end
end

this.InitChapter = function()
    this.mapEventList = DataExHelper.EX_GetEventMapByArea("JSYZ")
    this.chapterList = {}
    for i = 1, 4 do
        this.chapterList[i] = UIListView.New(this["itemListBox" .. i]);
        this.RefreshChapter(i)
    end
end

this.RefreshChapter = function(chapterIndex)
    local str = "JSYZ" .. chapterIndex
    local configArea = DataExHelper.EX_GetGroupListByArea(str)
    if (configArea ~= nil) then
        local groupId = configArea[1].id
        local evetList = this.mapEventList[groupId]
        if (evetList ~= nil) then
            local list = {}
            for i, v in ipairs(evetList) do
                local pUnLock = JSYZMgr.CheckEventIsUnLock(v);
                local pPass = JSYZMgr.CheckEventIsComplete(v);
                local item = {
                    config = v,
                    isUnLock = pUnLock,
                    isPass = pPass,
                    callBack = this.EventClickCallBack,
                }
                item.isRotate = chapterIndex == 3 or chapterIndex == 4;
                local shopData = UIListData.GetData(this.levelItem, "JSYZMapLvItem", item);
                table.insert(list, shopData);
            end
            this.chapterList[chapterIndex]:SetData(list);
        end
    end
end

this.EventClickCallBack = function(data)
    if data.config ~= nil then
        if (data.isUnLock == false) then
            local unlockPassConfig = this.allMapEvents[data.config.unlockParam]
            if unlockPassConfig then
                local unlockPassName = LuaMgr.GetLangText(unlockPassConfig.namelan)
                local tipsContent = string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7319"),
                    unlockPassName)
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
            end
            return
        end
        JSYZMgr.SetChapterIndex(this.curSelectChapter)
        JSYZMgr.SetShowAni(false);
        if (data.config.type == 1) then
            LuaMgr.PlayNovel(data.config.eventParam, function()
                LuaMgr.ShowLuaPanel(UIName.JSYZMainViewModel);
            end);
        else
            BattlePrepareMgr.EnterBattlePrepare(data.config.id, data.config.eventParam)
        end
    end
end

this.OnClickChapter1 = function()
    this.SwitchChapter(1)
end

this.OnClickChapter2 = function()
    this.SwitchChapter(2)
end

this.OnClickChapter3 = function()
    this.SwitchChapter(3)
end

this.OnClickChapter4 = function()
    this.SwitchChapter(4)
end

this.SwitchChapter = function(chapter)
    if (this.curSelectChapter == chapter) then
        return
    end
    for k, v in pairs(this.chapterList) do
        SetActive(this["imgSelect" .. k], k == chapter)
        SetActive(v.transform.gameObject, k == chapter)
    end
end

this.OnClickLeft = function()
    this.SwitchGameLv(this.curGameLv - 1)
end

this.OnClickRight = function()
    this.SwitchGameLv(this.curGameLv + 1)
end

this.OnClickComfirm = function()
    local pUnLock = JSYZMgr.CheckEventIsUnLock(this.selectedLvConfig);
    if (not pUnLock) then
        local unlockPassConfig = this.allMapEvents[this.selectedLvConfig.unlockParam]
        if unlockPassConfig then
            local unlockPassName = LuaMgr.GetLangText(unlockPassConfig.namelan)
            local tipsContent = string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7319"),
                unlockPassName)
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        end
        return
    end
    SetActive(this.imgSelectLv.gameObject, false)
    LuaMgr.ShowLuaPanel(UIName.JSYZGameViewModel, this.selectedLvConfig)
end

this.SwitchGameLv = function(index)
    this.curGameLv = index
    local num = #this.eventList
    if (index < 1) then
        this.curGameLv = num
    end
    if (index > num) then
        this.curGameLv = 1
    end
    local config = this.eventList[this.curGameLv]
    if (config ~= nil and config.type == 3) then
        this.selectedLvConfig = config
        local pPass = JSYZMgr.CheckEventIsComplete(config);
        SetActive(this.levelFinish, pPass)
        this.btnComfirmGray.IsGray = not JSYZMgr.CheckEventIsUnLock(config);
        this.textLevel.text = LuaMgr.GetLangText(config.namelan)
    end
end

this.OnClickGameSkill = function()
    LuaMgr.ShowLuaPanel(UIName.JSYZTalentViewModel);
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
        LuaMgr.AddClick(this.imgSelectLv, this.OnClickSelectLv)
        LuaMgr.AddClick(this.signInBtn, this.OnClickSignIn);
        LuaMgr.AddClick(this.sandTableBtn, this.OnClickSandTable);
        LuaMgr.AddClick(this.btnLeft, this.OnClickLeft);
        LuaMgr.AddClick(this.btnRight, this.OnClickRight);
        LuaMgr.AddClick(this.btnComfirm, this.OnClickComfirm)
        LuaMgr.AddClick(this.gameSkill, this.OnClickGameSkill);
        LuaMgr.AddClick(this.imgChapter1, this.OnClickChapter1);
        LuaMgr.AddClick(this.imgChapter2, this.OnClickChapter2);
        LuaMgr.AddClick(this.imgChapter3, this.OnClickChapter3);
        LuaMgr.AddClick(this.imgChapter4, this.OnClickChapter4);
        RedMgr.Singleton:RegisterViewModel(UIName.JSYZMainViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        HeroRedDataHelper.SetJSYZRed()
        RedMgr.Singleton:Refresh()
        vm.behaviour:UpdateTopBar("", this.OnBack);
        this.enabled = JSYZMgr.CheckShowAni()
        this.OnClickSelectLv()
        this.SetData();
    end,
    before_deactive = function(vm)
        if (this.chapterList ~= nil) then
            for k, v in pairs(this.chapterList) do
                v:Clear();
            end
        end
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.storyBtn, this.OnClickStory);
        LuaMgr.RemoveClick(this.videoBtn, this.OnClickVideo);
        LuaMgr.RemoveClick(this.missionBtn, this.OnClickMission)
        LuaMgr.RemoveClick(this.rewardBtn, this.OnClickReward);
        LuaMgr.RemoveClick(this.playGameBtn, this.OnClickGameBtn)
        LuaMgr.RemoveClick(this.imgSelectLv, this.OnClickSelectLv)
        LuaMgr.RemoveClick(this.signInBtn, this.OnClickSignIn);
        LuaMgr.RemoveClick(this.sandTableBtn, this.OnClickSandTable);
        LuaMgr.RemoveClick(this.btnLeft, this.OnClickLeft);
        LuaMgr.RemoveClick(this.btnRight, this.OnClickRight);
        LuaMgr.RemoveClick(this.btnComfirm, this.OnClickComfirm)
        LuaMgr.RemoveClick(this.gameSkill, this.OnClickGameSkill);
        LuaMgr.RemoveClick(this.imgChapter1, this.OnClickChapter1);
        LuaMgr.RemoveClick(this.imgChapter2, this.OnClickChapter2);
        LuaMgr.RemoveClick(this.imgChapter3, this.OnClickChapter3);
        LuaMgr.RemoveClick(this.imgChapter4, this.OnClickChapter4);
        RedMgr.Singleton:RemoveViewModel(UIName.JSYZMainViewModel);
        UIListView.ClearItem("JSYZMapLvItem");
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
    local key = DataMgr.Player.uid .. "JSYZ"
    local cache = PlayerPrefs.GetInt(key)
    if cache == 1 then
        this.firstShow = false
        return
    end
    PlayerPrefs.SetInt(key, 1)
    this.firstShow = true
    LuaMgr.ShowLuaPanel(UIName.PlayVideoViewModel, "Main6_PV")
end


return vm({
    data = data,
    command = command,
    hook = hook
})