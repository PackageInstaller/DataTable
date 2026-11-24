require("ViewModel/LHSA/LHSAEventItem")
require("ViewModel/LHSA/LHSAConst")

local this =
{
    activityKey = nil,
    medalActivityID = "32201",
    tagList = { "fs", "zx", "gn", "jq", "xyx", },
    eventUIList = {},
    eventList = {},
};

local objs = {
    eventItemObj = { path = "template/eventItem", type = "GameObject" },
    storyBtn = { path = "root/Middle/Story", type = "Button" },
    videoBtn = { path = "root/Right/Video", type = "Button" },
    missionBtn = { path = "root/Middle/Mission", type = "Button" },
    gameBtn = { path = "root/Middle/Game", type = "Button" },
    signInBtn = { path = "root/Left/SignIn", type = "Button" },
    textRatio = { path = "root/Left/SignIn/TextRatio", type = "Text" },
    rewardBtn = { path = "root/Left/Reward", type = "Button" },
    dayText = { path = "root/Left/TimeImg/TextTime", type = "Text" },
    goPopUp = { path = "root/Middle/goPopUp", type = "GameObject" },
    tranScrollView = { path = "root/Middle/goPopUp/ScrollView", type = "ScrollRect" },
    tranContent = { path = "root/Middle/goPopUp/ScrollView/Viewport/tranContent", type = "RectTransform" },
    btnMask = { path = "root/Middle/goPopUp/btnMask", type = "Button" },
};

local EventType = {
    Story = 1,
    Battle = 2,
    Game = 3,
}

this.ClosePopUp = function()
    SetActive(this.goPopUp, false)
    LHSAMgr.SetCurTap(nil)
    this.typeIndex = nil
end

this.GetTypeIndexFromParams = function(vm)
    if vm.behaviour.Params ~= nil and vm.behaviour.Params.Length > 0 then
        return vm.behaviour.Params[0]
    end
    return LHSAMgr.GetCurTap()
end

this.RefreshMedalData = function()
    local finishMedalCount = DataExHelper.GetMedalFinishCount(this.medalActivityID)
    local medalList = DataExHelper.GetMedalList(this.medalActivityID) or {}
    this.medalList = {}
    for key, value in pairs(medalList) do
        table.insert(this.medalList, value)
    end
    this.textRatio.text = string.format(LuaMgr.GetLangText("CrisisContract2MainViewModel_0"), finishMedalCount,
        #this.medalList)
end




this.SetData = function()
    this.activityKey = ActivityKey.LHSA
    this.dayText.text = LHSAMgr.GetTimeStr()
    this.RefreshMedalData()
end


this.OnBack = function()
    if this.goPopUp.activeInHierarchy then
        this.ClosePopUp()
        return;
    end
    local activityKey = this.activityKey or ActivityKey.LHSA
    if DataExHelper.CommonActivityCheck(activityKey) then
        LuaMgr.Back(activityKey)
    else
        LuaMgr.Back()
    end
end


this.OnClickStory = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.LHSANovelPanel)
    end
end


this.OnClickVideo = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.PlayVideoViewModel, "Main6_PV")
    end
end


this.OnClickMission = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.LHSARecollectionPopup)
    end
end


this.OnClickGame = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.LHSALevelViewModel)
    end
end

this.OnClosePopUp = function()
    this.ClosePopUp()
end

this.SetEventUIList = function(typeIndex)
    this.typeIndex = typeIndex;
    this.eventUIList:Clear();
    local area = LHSALevel2StrType[typeIndex]
    if area == nil then
        this.eventList = {}
        this.ClosePopUp()
        return
    end
    this.eventList = LHSAMgr.GetActiveEventsByArea(area)
    if #this.eventList == 0 then
        this.ClosePopUp()
        return
    end;
    this.tranScrollView.transform.anchoredPosition = #this.eventList > 3 and Vector2(0, -44) or Vector2(30, -44);
    this.tranScrollView.enabled = #this.eventList > 3
    SetActive(this.goPopUp, true);
    local list = {};
    local locIndex = 0;
    for i, v in ipairs(this.eventList) do
        local unlock, lockTip = LHSAMgr.CheckEventIsUnLock(v);
        local isComplete = LHSAMgr.CheckEventIsComplete(v)
        if isComplete then
            locIndex = locIndex + 1;
        end
        local eventItem = {
            index = i,
            type = typeIndex,
            isUnlock = unlock,
            tag = this.tagList[typeIndex],
            passTag = LHSAMgr.GetEventCompleteTag(v),
            name = LuaMgr.GetLangText(v.namelan),
            lockInfo = lockTip ~= nil and lockTip or LuaMgr.GetLangText(v.tipslan),
            isRed = LHSAMgr.redEventMap[v.id] ~= nil,
            callBack = this.EventCallBack,
        }
        local eventData = UIListData.GetData(this.eventItemObj, "LHSAEventItem", eventItem);
        table.insert(list, eventData);
    end
    this.eventUIList:SetData(list);
    if locIndex <= 3 or locIndex == #list then
        this.tranContent.anchoredPosition = Vector2(0, 0);
    else
        this.tranContent.anchoredPosition = Vector2(-246 * (locIndex - 2), 0);
    end
end

this.EventCallBack = function(index)
    if not this.CheckActivityRunning() then
        return;
    end
    local item = this.eventUIList and this.eventUIList.itemList and this.eventUIList.itemList[index]
    local eventData = item and item.data
    local cfgEvent = this.eventList and this.eventList[index]
    if eventData == nil or cfgEvent == nil then
        return
    end
    if not eventData.isUnlock then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, eventData.lockInfo);
        return;
    end
    LHSAMgr.SetCurTap(this.typeIndex)
    local key = DataMgr.Player.uid .. "LHSA_" .. cfgEvent.id;
    PlayerPrefs.SetInt(key, 1);
    if cfgEvent.type == EventType.Story then

        LuaMgr.PlayNovel(cfgEvent.eventParam, function()
            LuaMgr.Back()
        end);
    elseif cfgEvent.type == EventType.Battle then

        local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
        enterDungeonParams.eventId = cfgEvent.eventParam
        enterDungeonParams.dungeonId = cfgEvent.eventParam
        BattlePrepareMgr.BattlePrepare(enterDungeonParams)
    elseif cfgEvent.type == EventType.Game then

        LuaMgr.ShowLuaPanel(UIName.LHSAGameViewModel, cfgEvent);
    end
end



this.OnClickReward = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.LHSAShopViewModel);
    end
end




this.OnClickSignIn = function()
    if this.CheckActivityRunning() then
        local data = {}
        data.medalActivityID = this.medalActivityID
        data.medalColor = "#3d6053"
        data.medalImgKey = "ui_hd_ty_dtyl_bt_lhsa"
        data.bgmPath = "Assets/_BundleResources/Audio/Bgm/LHSA.mp3"
        LuaMgr.ShowLuaPanel(UIName.PassesMain2ViewModel, data);
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
        LuaMgr.AddClick(this.gameBtn, this.OnClickGame)
        LuaMgr.AddClick(this.rewardBtn, this.OnClickReward);
        LuaMgr.AddClick(this.signInBtn, this.OnClickSignIn);
        LuaMgr.AddClick(this.btnMask, this.OnClosePopUp);
        RedMgr.Singleton:RegisterViewModel(UIName.LHSAMainViewModel);
        this.eventUIList = UIListView.New(this.tranContent);
    end,
    before_active = function(vm)
        this.typeIndex = this.GetTypeIndexFromParams(vm)
        HeroRedDataHelper.SetLHSARed()
        RedMgr.Singleton:Refresh()
        vm.behaviour:UpdateTopBar("", this.OnBack);
        SetActive(this.goPopUp, false);
        this.SetData();
        if LHSAMgr.GetNeedOpenDungeonUI() == true then
            LHSAMgr.SetNeedOpenDungeonUI(false)
            this.OnClickMission()
        end
    end,
    before_deactive = function(vm)
        if this.flyDoTween ~= nil then
            this.flyDoTween.onComplete = nil
            this.flyDoTween:Kill()
            this.flyDoTween = nil
        end
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.storyBtn, this.OnClickStory);
        LuaMgr.RemoveClick(this.videoBtn, this.OnClickVideo);
        LuaMgr.RemoveClick(this.missionBtn, this.OnClickMission)
        LuaMgr.RemoveClick(this.gameBtn, this.OnClickGame)
        LuaMgr.RemoveClick(this.rewardBtn, this.OnClickReward);
        LuaMgr.RemoveClick(this.signInBtn, this.OnClickSignIn);
        LuaMgr.RemoveClick(this.btnMask, this.OnClosePopUp);
        RedMgr.Singleton:RemoveViewModel(UIName.LHSAMainViewModel);
        UIListView.ClearItem("LHSAEventItem");
    end
}


this.CheckActivityRunning = function()
    local activityKey = this.activityKey or ActivityKey.LHSA
    if not DataExHelper.CommonActivityCheck(activityKey) then
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