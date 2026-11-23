




local tarRect = nil;
local root = nil;
local rootBtn = nil;
local rootAni = nil;
local Left = nil;
local goCollecBtnLock = nil;
local goCourseBtnLock = nil;
local goChapter = nil;
local goLeftGray = nil;
local goRightGray = nil;
local goChapterList = nil;
local goChapterListContent = nil;
local Right = nil;
local goGroup = nil;
local goBtnExploreLock = nil;
local goExploreRedIcon_Dispatchable = nil;
local goExploreRedIcon_Dispatch = nil;
local goExploreRedIcon_CollectReward = nil;
local goBtnBranchLock = nil;
local goBtnTeachingLock = nil;
local goRightIcon = nil;
local goCutIn = nil;
local ScrollView = nil;
local ScrollViewRect = nil;
local rectMapContent = nil;
local rectContent = nil;
local contentSizeFitter = nil;
local rectTipsPoint = nil;
local rectEvents = nil;
local goEvents = nil;
local textAreaName = nil;
local textFullName = nil;
local textExploreCount = nil;
local btnExploreCount = nil;
local btnCollect = nil;
local btnCourse = nil;
local btnShop = nil;
local goBtnShop = nil
local btnMap = nil;
local btnLeftArrow = nil;
local btnRightArrow = nil;
local btnImage = nil;
local btnExplore = nil;
local btnClimbtownBtn = nil;
local btnBranch = nil;
local btnTeaching = nil;
local btnTeachingImgColor = nil;
local btnBranchImgColor = nil;
local btnCollectImgColor = nil;
local btnCourseImgColor = nil;
local btnExploreImgColor = nil;
local btnClimbtownBtnImgColor = nil;
local btnLeftArrowActive = nil;
local btnRightArrowActive = nil;
local btnExploreCountLock=nil;
local goBtnBranch=nil;
local goBtnExplore=nil;
local toggleAnyss=nil;
local isBtnStrategy = nil
local textAbyss = nil
local btnModelType=nil;
local goNovelType=nil;
local btnNovelTips=nil;
local goNovelGroup=nil;
local goNovelTag=nil;
local this = {
    vm = nil,
}
require("ViewModel/AreaMap/AreaMapEventItem")
require("ViewModel/AreaMap/AreaMapChapterItem")


local chapterList = {}
local mapNotDestory=false
local stopClickNext = false;
local currentBuilding = "";
local tween = nil;
local currentArea = "";
local eventDatas = {};
local mapId = "";
local areaExploreUnlockId = "";
local areaCourseUnlockId = "";
local areaCollectUnlockId = "";
local infoItems = {};
local chapterIndex = 1;
local coroutineArea = "";
local chapterDataList = {}
local nonosenseTime = 0;
local luaSaveTime = 0;
local moveTween = nil;
local newBuildingList = {};
local newEventList = {};
local coroutineBuilding = nil;
local rectMiddleContent=nil;
local cokey1=nil;
local cokey2=nil;
local mainAreaMapModel=nil;

local test=nil;

local lockColor = UnityEngine.Color(255 / 255.0, 255 / 255.0, 255 / 255.0, 153 / 255.0);
local unlockColor = UnityEngine.Color.white;
local MAP_PATH = "Assets/_BundleResources/UI/Area/%s.prefab";
local PREFAB_PATH = "Assets/_BundleResources/UI/Area/AreaMapPanel.prefab";
local ANIMA_OPEN = "aniUI_AreaMap_cutin_01";
local ANIMA_CUT_01 = "UI_AreaMapPanel_cut_01";
local ANIMA_CUT_02 = "UI_AreaMapPanel_cut_02";
local AUDIO_PATH="Assets/_BundleResources/Audio/";
local DungeonLimitStr = nil

local EMapMode={
    Normal=0,
    Anyss=1,
}


local areaMode=nil;

local data = {
}
local command = {
}

this.Init = function(prefab)
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    rootAni = uiLink:Get("root"):GetComponent("Animator");
    Left = uiLink:Get("Left");
    goCollecBtnLock = uiLink:Get("goCollecBtnLock");
    goCourseBtnLock = uiLink:Get("goCourseBtnLock");
    goChapter = uiLink:Get("goChapter");
    goLeftGray = uiLink:Get("goLeftGray");
    goRightGray = uiLink:Get("goRightGray");
    goChapterList = uiLink:Get("goChapterList");
    goChapterListContent = uiLink:Get("goChapterListContent");
    Right = uiLink:Get("Right");
    goGroup = uiLink:Get("goGroup");
    goBtnExploreLock = uiLink:Get("goBtnExploreLock");
    goExploreRedIcon_Dispatchable = uiLink:Get("goRedIcon1");
    goExploreRedIcon_Dispatch = uiLink:Get("goRedIcon2");
    goExploreRedIcon_CollectReward = uiLink:Get("goRedIcon3");
    goBtnBranchLock = uiLink:Get("goBtnBranchLock");
    goBtnTeachingLock = uiLink:Get("goBtnTeachingLock");
    goRightIcon = uiLink:Get("goRightIcon");
goCutIn = uiLink:Get("goCutIn");
    ScrollViewRect = uiLink:Get("ScrollView"):GetComponent("RectTransform");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    rectMapContent = uiLink:Get("rectMapContent"):GetComponent("RectTransform");
    rectContent = uiLink:Get("rectContent"):GetComponent("RectTransform");
    contentSizeFitter = uiLink:Get("rectContent"):GetComponent("ContentSizeFitter");
rectTipsPoint = uiLink:Get("rectTipsPoint"):GetComponent("RectTransform");
    rectEvents = uiLink:Get("rectEvents"):GetComponent("RectTransform");
    goEvents = uiLink:Get("rectEvents");
    textAreaName = uiLink:Get("textAreaName"):GetComponent("Text");
    textFullName = uiLink:Get("textFullName"):GetComponent("Text");
    textExploreCount = uiLink:Get("textExploreCount"):GetComponent("Text");
    btnExploreCount = uiLink:Get("btnExploreCount"):GetComponent("Button");
    btnExploreCountLock=uiLink:Get("btnExploreCount")
    btnCollect = uiLink:Get("btnCollect"):GetComponent("Button");
    btnCourse = uiLink:Get("btnCourse"):GetComponent("Button");
btnShop = uiLink:Get("btnShop"):GetComponent("Button");
    goBtnShop = uiLink:Get("btnShop");
    btnMap = uiLink:Get("btnMap"):GetComponent("Button");
    btnLeftArrow = uiLink:Get("btnLeftArrow"):GetComponent("UIButtonClick");
    btnRightArrow = uiLink:Get("btnRightArrow"):GetComponent("UIButtonClick");
    btnLeftArrowActive = uiLink:Get("btnLeftArrow");
    btnRightArrowActive = uiLink:Get("btnRightArrow");
    btnImage = uiLink:Get("btnImage"):GetComponent("UIButtonClick");
    btnExplore = uiLink:Get("btnExplore"):GetComponent("Button");
    btnClimbtownBtn = uiLink:Get("btnClimbtownBtn"):GetComponent("Button");
    btnBranch = uiLink:Get("btnBranch"):GetComponent("Button");
    btnTeaching = uiLink:Get("btnTeaching"):GetComponent("Button");
    btnTeachingImgColor = uiLink:Get("btnTeaching"):GetComponent("Image");
    btnBranchImgColor = uiLink:Get("btnBranch"):GetComponent("Image");
    btnCollectImgColor = uiLink:Get("btnCollect"):GetComponent("Image");
    btnCourseImgColor = uiLink:Get("btnCourse"):GetComponent("Image");
    btnExploreImgColor = uiLink:Get("btnExplore"):GetComponent("Image");
    btnClimbtownBtnImgColor = uiLink:Get("btnClimbtownBtn"):GetComponent("Image");
    rectMiddleContent=uiLink:Get("rectMiddleContent"):GetComponent("RectTransform")
    goBtnBranch=uiLink:Get("btnBranch");
    goBtnExplore=uiLink:Get("btnExplore");
    toggleAnyss=uiLink:Get("toggleAnyss"):GetComponent("Button");
    isBtnStrategy = uiLink:Get("btnStrategy")
    textAbyss = uiLink:Get("textAbyss"):GetComponent("Text");
    goNovelType=uiLink:Get("goNovelType");
    btnModelType=uiLink:Get("btnModelType"):GetComponent("Button");
    goNovelGroup=uiLink:Get("goNovelGroup");
    goNovelTag=uiLink:Get("goNovelTag");

    test=uiLink:Get("rectContent");
    uiLink:AddClickEvent("root", this.OnClickClose)
    uiLink:AddClickEvent("btnExplore", this.OnClickExplore)
    uiLink:AddClickEvent("btnCollect", this.OnClickCollect)
    uiLink:AddClickEvent("btnCourse", this.OnClickCourse)
    uiLink:AddClickEvent("btnLeftArrow", this.OnClickLeft)
    uiLink:AddClickEvent("btnRightArrow", this.OnClickRight)
    uiLink:AddClickEvent("btnMap", this.OnClickMap)
    uiLink:AddClickEvent("btnTeaching", this.OnClickActivity)
    uiLink:AddClickEvent("btnBranch", this.OnClickBranch)
    uiLink:AddClickEvent("btnExploreCount", this.OnClickExploreCount)
    uiLink:AddClickEvent("btnClimbtownBtn", this.OnClickClimbtown)
    uiLink:AddClickEvent("btnStrategy", this.OnClickGotoStrategyWeb)
    uiLink:AddClickEvent("btnModelType",this.OnClickSwitchModelType);
    uiLink:AddClickEvent("btnNovelTips",this.OnClickNovelTypeTips);
    


    uiLink:AddClickEvent("btnImage", this.OnClickCloseWorldMap)
    uiLink:AddClickEvent("toggleAnyss",this.ToggleAbyss)
    this.InitInfos();
end

this.InitInfos = function()
    local infos = { "Info0", "Info1", "", "Info3", "", "Info2" };
    local len = #infos;
    for i = 1, len do
        if (infos[i] ~= "") then
            local info = tarRect:Find("template/" .. infos[i]);
            if (info ~= nil) then
                infoItems[i - 1] = info.gameObject;
            end
        end
    end
end

this.Clear = function()
    tarRect = nil
    root = nil;
    rootBtn = nil;
    rootAni = nil;
    Left = nil;
    goCollecBtnLock = nil;
    goCourseBtnLock = nil;
    goChapter = nil;
    goLeftGray = nil;
    goRightGray = nil;
    goChapterList = nil;
    goChapterListContent = nil;
    Right = nil;
    goGroup = nil;
    goBtnExploreLock = nil;
    goBtnBranchLock = nil;
    goBtnTeachingLock = nil;
    goRightIcon = nil;
    goCutIn = nil;
    ScrollView = nil;
    ScrollViewRect = nil;
    rectMapContent = nil;
    rectContent = nil;
    contentSizeFitter = nil;
    rectTipsPoint = nil;
    rectEvents = nil;
    goEvents = nil;
    textAreaName = nil;
    textFullName = nil;
    textExploreCount = nil;
    btnExploreCount = nil;
    btnExploreCountLock=nil;
    btnCollect = nil;
    btnCourse = nil;
    btnShop = nil;
    goBtnShop = nil;
    btnMap = nil;
    btnLeftArrow = nil;
    btnRightArrow = nil
    btnImage = nil;
    btnExplore = nil;
    btnClimbtownBtn = nil;
    btnBranch = nil;
    btnTeaching = nil;
    btnTeachingImgColor = nil;
    btnBranchImgColor = nil;
    btnCollectImgColor = nil;
    btnCourseImgColor = nil;
    btnExploreImgColor = nil;
    btnClimbtownBtnImgColor = nil;
    btnLeftArrowActive = nil;
    btnRightArrowActive = nil;
    chapterList = {}
    stopClickNext = false;
    currentBuilding = "";
tween = nil;
    currentArea = "";
    eventDatas = {};
    mapId = "";
    areaExploreUnlockId = "";
    areaCourseUnlockId = "";
    areaCollectUnlockId = "";
    infoItems = {};
    chapterIndex = 1;
    coroutineArea = "";
    chapterDataList = {}
    nonosenseTime = 0;
    luaSaveTime = 0;
    moveTween = nil;
    newBuildingList = {};
    newEventList = {};
    coroutineBuilding = nil;
    rectMiddleContent=nil;
    goBtnBranch=nil;
    goBtnExplore=nil;
    toggleAnyss=nil;
    isBtnStrategy=nil;
    textAbyss=nil;
    btnModelType=nil;
    goNovelType=nil;
    btnNovelTips=nil;
    goNovelGroup=nil;
    goNovelTag=nil;
    DungeonLimitStr = nil
end

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.Init(vm.behaviour);
        this.BeforeAwake();
    end,
    before_active = function(vm)
        if (this.vm.behaviour.Params == nil) then
            return
        end
        LuaMgr.ScreenMonitorType("t_3");
        this.BeforeActive(this.vm.behaviour.Params)
    end,
    after_active = function(vm)
        if (this.vm.behaviour.Params == nil) then
            return;
        end
        this.AfterActive();
    end,
    before_deactive = function(vm)
        if (this.vm.behaviour.Params == nil) then
            return;
        end
        this.BeforeDeactive();
    end,
    before_destroy = function(vm)
        this.BeforeDestroy();
        for i = 1, #chapterDataList, 1 do
            chapterDataList[i]:Clear();
        end
    end,
}

this.BeforeAwake = function()
    RedMgr.Singleton:RegisterViewModel(UIName.AreaMapViewModel);
end

this.BeforeActive = function(Params)

    if HeroParameter.JournalGotoPanel ~= nil then
        this.vm.behaviour:UpdateTopBar("", function()
            LuaMgr.Back()

        end)
    end
    SetActive(btnModelType.gameObject,false);
    if not IsNull(ConfigMgr.Config.constants.StoryModelUnlock)  and  #ConfigMgr.Config.constants.StoryModelUnlock>0 then
        local dungeonId=ConfigMgr.Config.constants.StoryModelUnlock[1];
        if PlayerAreaMapMgr.CheckDungeonRecords(dungeonId) then
            SetActive(btnModelType.gameObject,true);
        end
    end
    this.InitMainAreaMapMode();
    rootAni:Play("UI_AreaMapPanel_01", 0, 0);
    this.SetShowIcon(true)
    SetActive(goChapter, true);
    SetActive(goChapterList, false);
    SetActive(goBtnShop, false);

    stopClickNext = false;
    LuaMgr.SetAreaBattleType(BattleType.Area)
    this.CheckMapMode();
LuaMgr.TriggerGuideId();
LuaMgr.TriggerNovel();
    this.RemoveEventListeners();
    this.Listeners();
    local area = "";
    if Params.Length >= 1 then
        area = tostring(Params[0]);
    end
    this.InitChapter();

    this.SetAreaMap(area);
    this.CheckExplore();
    this.CheckExploreMap();
    this.SetChapter(this.GetChapterIndex(currentArea))
    LuaMgr.NextFrame(function()
        this.CheckGotoBuilding();
    end)
    CS.Laigu.Manager.NovelManager.Singleton:CheckCompleteNovel(true)

    this.SetCollectRed();
    this.SetCourseRed();
    this.SetBranchRed();
    HeroRedDataHelper.SetAreaTeachingRed();
    this.CheckUnlockTips();
    LuaMgr.AddUpdate(this.OnUpdate);
    HeroParameter.EmptyPanelType()
    HeroParameter.EmptyAbyssIndex()
    HeroParameter.branchHeroItemClick = nil
    if toggleAnyss.gameObject.activeSelf then
        this.GetAbyssPercent()
    end
    if Params.Length >= 2 and Params[1] ~= nil then
        local panelId = tostring(Params[1]);
        AreaMapSceneMgr.SetBuildingId("");
        FeatureManager.GotoPanel(panelId);
        Params[1] = nil;
    end
    PlayerMedalMgr.CheckMedalPopup(currentArea)
    DungeonLimitStr = ConfigMgr.LangGlobal("31154")
end

this.AfterActive = function()
    if not LuaMgr.IsGuide() then
        this.GetLuaChickTime();
        this.NonsenseChickShowPanel();
    end
end

this.BeforeDeactive = function()
    LuaMgr.RemoveUpdate(this.OnUpdate);
    this.RemoveTween();
    this.RemoveMoveTween();
    this.RemoveEventListeners();
    LuaMgr.RemoveTimer(TimerConst.AreaMapEventTime);
    LuaMgr.RemoveTimer(TimerConst.NonsenseChick)
    this.HideEvents();
    LuaMgr.InvokeUIEventListeners(UIEventConst.NonsenseChickPanelClose);
    if cokey1~=nil then
        coroutine_runner.stop(cokey1)
    end
    if cokey2~=nil then
        coroutine_runner.stop(cokey2)
    end
end

this.BeforeDestroy = function()
    this.RemoveEventItem();
    this.ClearMap();
    AreaMapSceneMgr.Destroy();
    this.Clear();
end

this.OnUpdate = function()
    if (not LuaMgr.IsGuide()) then
        AreaMapSceneMgr.SetMapPos();
        AreaMapSceneMgr.UpdateExplores();
    end
end


this.OnClickChapter = function(index)
    if index < 1 or index == chapterIndex then
        return;
    end
    if index > #chapterList then
        return;
    end
    local areaMap = chapterList[index];
    if areaMap == nil then
        return;
    end
    local isBanned = FeatureManager.UnifyVerControls("areamap",areaMap.area)
    if mainAreaMapModel==AreaModel.Novel then
        if not isBanned or PlayerAreaMgr_NovelModel.areaState[areaMap.area]==nil or PlayerAreaMgr_NovelModel.areaState[areaMap.area].lock then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.gsub(ConfigMgr.LangGlobal("2025"), "{0}",tostring(LuaMgr.GetLangText(areaMap.mapTitlelan))));
            return;
        end
    else
        local data = DataMgr.Player.areaMaps[areaMap.area];
        if data == nil or not PlayerAreaMgr.CheckAreaUnlock(areaMap.area) or not isBanned then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.gsub(ConfigMgr.LangGlobal("2025"), "{0}",tostring(LuaMgr.GetLangText(areaMap.mapTitlelan))));
            return;
        end
    end
   
    AreaMapSceneMgr.SetBuildingId("")
    if index > chapterIndex then
        PlayerAreaMapMgr.InitAreaMapBuildingStatus();
        PlayerAreaMapMgr.InitAreaMapBuildingEvent();
        PlayerAreaMapMgr.InitAreaMapSurveyEvent();
    end
    this.SetChapter(index);

    coroutineArea = areaMap.area
local co = coroutine_runner.start(function()
        stopClickNext = true
LuaMgr.ShowPanel(UIName.PreloadViewModel);
        coroutine_runner.wait(0.15)
this.SetAreaMap(coroutineArea);
        coroutine_runner.wait(0.15)
        LuaMgr.HidePanel(UIName.PreloadViewModel);
        this.CheckGotoBuilding();
        stopClickNext = false;
    end)

    this.SetChapterData();
end

this.OnClickClimbtown = function()














end


this.OnClickGotoStrategyWeb = function()
    local areaMap = ConfigMgr.Config.areas[currentArea]
    local orientation = ConfigMgr.Config.constants.areaWebURLType
    if areaMap == nil or IsNullOrEmpty(areaMap.mapWebURL) then
        return
    end
    LuaMgr.OpenURL(areaMap.mapWebURL,orientation)
end


this.ToggleAbyss=function()
    FeatureManager.GotoPanel("2099")

























end

this.OnClickCloseWorldMap = function()
    this.CloseWordChapter();
end

this.OnClickBranch = function()
    if goBtnBranchLock.activeSelf then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, FeatureManager.TipStr("1040"));
    else
        this.CloseWordChapter();
        FeatureManager.GotoPanel("1040")
    end
end

this.OnClickExploreCount = function()
    if mapNotDestory then
        PlayerAreaMapMgr.GotoExplore();
    end
end

this.OnClickActivity = function()
    if goBtnTeachingLock.activeSelf then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, FeatureManager.TipStr("3081"));
    else
        LuaMgr.ShowLuaPanel(UIName.JobTeachingViewModel)
    end
end

this.OnClickMap = function()
    SetActive(goChapterList, true);
    rootAni:Play(ANIMA_CUT_01);
    this.SetChapterData();
end


this.OnClickRight = function()
    if stopClickNext then
        return;
    end
    local index = this.GetCorrectAreaIndex(1)
    if index == nil then
        return
    end
    local areaMap = chapterList[index];
    if areaMap == nil then
        return
    end
    if mainAreaMapModel==AreaModel.Novel then
        if PlayerAreaMgr_NovelModel.areaState[areaMap.area].lock then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.gsub(ConfigMgr.LangGlobal("2025"), "{0}", tostring(LuaMgr.GetLangText(areaMap.mapTitlelan))));
            return;
        end
    else
        local data = DataMgr.Player.areaMaps[areaMap.area];
        if data == nil or not PlayerAreaMgr.CheckAreaUnlock(areaMap.area) then

            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.gsub(ConfigMgr.LangGlobal("2025"), "{0}", tostring(LuaMgr.GetLangText(areaMap.mapTitlelan))));
            return;
        end
    end
    AreaMapSceneMgr.SetBuildingId("")
    this.SetChapter(index);
    if mainAreaMapModel==AreaModel.Normal then
        PlayerAreaMapMgr.InitAreaMapBuildingStatus();
        PlayerAreaMapMgr.InitAreaMapBuildingEvent();
        PlayerAreaMapMgr.InitAreaMapSurveyEvent();
    end

    coroutineArea = areaMap.area
local co = coroutine_runner.start(function()
        stopClickNext = true
LuaMgr.ShowPanel(UIName.PreloadViewModel);
        coroutine_runner.wait(0.15)
this.SetAreaMap(coroutineArea);
        coroutine_runner.wait(0.15)
        LuaMgr.HidePanel(UIName.PreloadViewModel);
        this.CheckGotoBuilding();
        stopClickNext = false;
    end)
end

this.OnClickLeft = function()
    if stopClickNext then
        return;
    end
    local index = this.GetCorrectAreaIndex(-1)
    if index == nil then
        return
    end
    local areaMap = chapterList[index];
    if areaMap == nil then
        return
    end
    local data = DataMgr.Player.areaMaps[areaMap.area];
    if mainAreaMapModel==AreaModel.Novel then
        data=PlayerAreaMgr_NovelModel.areaState[areaMap.area];
    end
    if data == nil or not PlayerAreaMgr.CheckAreaUnlock(areaMap.area) then

        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.gsub(ConfigMgr.LangGlobal("2025"), "{0}", tostring(LuaMgr.GetLangText(areaMap.mapTitlelan))));
        return;
    end
    AreaMapSceneMgr.SetBuildingId("")
    this.SetChapter(index);

    coroutineArea = areaMap.area
local co = coroutine_runner.start(function()
        stopClickNext = true
LuaMgr.ShowPanel(UIName.PreloadViewModel);
        coroutine_runner.wait(0.15)
this.SetAreaMap(coroutineArea);
        coroutine_runner.wait(0.15)
        LuaMgr.HidePanel(UIName.PreloadViewModel);
        this.CheckGotoBuilding();
        stopClickNext = false;
    end)
    
end




this.GetCorrectAreaIndex = function(param)
    local index = chapterIndex + param
    if index < 1 or index > #chapterList then
        return nil
    end
    local areaMapKey = chapterList[index].area
    local isBanned = FeatureManager.UnifyVerControls("areamap",areaMapKey)
    if isBanned then
        return index
    else
        local count = param < 0 and 1 or #chapterList
        for i = index + param, count,param do
            areaMapKey = chapterList[i].area
            isBanned = FeatureManager.UnifyVerControls("areamap",areaMapKey)
            if isBanned then return i end
        end
        return nil
    end
end

this.OnClickCourse = function()
    if goCourseBtnLock.activeSelf then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, FeatureManager.TipStr(areaCourseUnlockId));
    else
        this.CloseWordChapter();
        LuaMgr.ShowLuaPanel(UIName.AreaCourseViewModel, currentArea)
    end
end

this.OnClickCollect = function()
    if goCollecBtnLock.activeSelf then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, FeatureManager.TipStr(areaCollectUnlockId));
    else
        LuaMgr.ShowLuaPanel(UIName.AreaMapCollectViewModel, currentArea)
        this.CloseWordChapter();
    end
end

this.OnClickExplore = function()
    if goBtnExploreLock.activeSelf then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, FeatureManager.TipStr(areaExploreUnlockId));
        return;
    end
    this.CloseWordChapter();
    LuaMgr.ShowLuaPanel(UIName.AreaExploreViewModel, currentArea)
    this.SetShowIcon(false);
end

this.OnClickClose = function()
    this.HideEvents();
end


this.RemoveMoveTween = function()
    if moveTween ~= nil then
        moveTween:Kill(false);
        moveTween = nil;
    end
end

this.NonsenseChickShowPanel = function()
    LuaMgr.AddTimer(TimerConst.NonsenseChick, this.NonosenseEvent, 1, -1, true)
end

this.NonosenseEvent = function()
    if nonosenseTime == 0 then
        return;
    end
    if LuaMgr.Timestamp() - luaSaveTime > nonosenseTime then
        RedMgr.Singleton:SetCDjTipShow(true);
        LuaMgr.RemoveTimer(TimerConst.NonsenseChick)
    end
end

this.GetLuaChickTime = function()
    nonosenseTime = ConfigMgr.Config.constants.ChickShowTimeSecond
    local luaData = ComData.NonsenseSaveTime();
    if luaData ~= nil then
        luaSaveTime = luaData;
    end
end

this.SetChapterData = function()
for i = 1, #chapterDataList, 1 do
        chapterDataList[i]:Clear();
    end
    chapterDataList = {};
    local areaList = chapterList;
    local curIndex = chapterIndex;
    local count = #areaList;
    for i = 1, count, 1 do
        local area = areaList[i].area;
        local chapter = AreaMapChapterItem.New(goChapterListContent:GetComponent("RectTransform"), i)
        local isBanned = FeatureManager.UnifyVerControls("areamap",area)
        if i <= #areaList and isBanned then
            local index = curIndex==i and 2 or this.GetChapterSpriteIndex(area);
            local numIndex = curIndex == i and "2" or "1";
            local passName = this.GetAreaPassSpriteName(area);
            chapter.imgBG.sprite = LuaMgr.GetSprite("AreaMapRes", "ui_qydt_name_di0" .. index);
            SetActive(chapter.goLoc, curIndex == i);
            if mainAreaMapModel==AreaModel.Novel then
                SetActive(chapter.imgNameUnLock, not PlayerAreaMgr_NovelModel.areaState[area].lock)
            else
                SetActive(chapter.imgNameUnLock, PlayerAreaMgr.CheckAreaUnlock(area));
            end
            SetActive(chapter.goTag, passName ~= "")
            chapter.imgTag.sprite = LuaMgr.GetSprite("AreaMapRes", passName);
            chapter.imgNum.sprite = LuaMgr.GetSprite("AreaMapRes",
                "ui_qydt_name_sz0" .. tostring(i) .. "_0" .. tostring(index));
            chapter.imgName.sprite = LuaMgr.GetSprite("AreaMapRes",
                "ui_qydt_name_" .. tostring(area) .. "0" .. tostring(numIndex));

        else
            chapter.imgBG.sprite = LuaMgr.GetSprite("AreaMapRes", "ui_qydt_name_di03");
            chapter.imgNum.sprite = LuaMgr.GetSprite("AreaMapRes", "ui_qydt_name_sz0" .. tostring(i) .. "_03");
            SetActive(chapter.goLoc, false);
            SetActive(chapter.imgNameUnLock, false)
            SetActive(chapter.goTag, false)
        end
        chapter.btnBGClickFun = this.OnClickChapter;
        table.insert(chapterDataList, chapter);
    end
end

this.GetAreaPassSpriteName = function(area)
    if mainAreaMapModel==AreaModel.Novel then

        if not PlayerAreaMgr_NovelModel.CheckAreaAllBuildingsEventsComplete(area) then
            return ""; 
        else
           return "ui_qydt_rukou_tg"
        end
        return;
    end
    if not PlayerAreaMgr.CheckAreaUnlock(area) or not AreaMapSceneMgr.AreaPass(area) then
        return "";
    end
    if AreaMapSceneMgr.AreaPass_S(area) then
        return "ui_qydt_rukou_wm"
    else
        return "ui_qydt_rukou_tg";
    end
end

this.GetChapterSpriteIndex = function(area)
    if mainAreaMapModel==AreaModel.Novel then
        if PlayerAreaMgr_NovelModel.areaState[area].lock then
            return "3";
        else
            return "1";
        end
    else
        if not PlayerAreaMgr.CheckAreaUnlock(area) then
            return "3";
        else
            return "1";
        end
    end
    
end


this.HideEvents = function()
    LuaMgr.RemoveTimer(TimerConst.AreaMapEventTime);
    if not mapNotDestory then
        return
    end
    SetActive(goEvents, false);
    this.CheckMapMode();
    this.SetRightButtonState(true)
    RedMgr.Singleton:Refresh();
    AreaMapSceneMgr.SetLight(currentBuilding, false);
    currentBuilding = "";
end

this.CheckUnlockTips = function()
    HeroRedDataHelper.SetCheDanJiRed();
    UnlockTipsMgr.CheckUnlockTips();
end





















this.SetBranchRed = function()
    local isHaveRed = BranchMissionHelper.BranchRedDataTabInit("Branch")
    if FeatureManager.IsLock("1040") then
        return
    end
    local redNum = isHaveRed and 1 or 0

    if redNum == 0 then
        redNum = redNum + BranchMissionHelper.BranchHeroNewRed()
    end
    if redNum == 0 then
        redNum = redNum + BranchMissionHelper.BranchHeroRewardRed()
    end
    if redNum == 0 then
        redNum = redNum + BranchMissionHelper.BranchAnecdoteNewRed()
    end
    if redNum == 0 then
        redNum = redNum + BranchMissionHelper.BranchAnecdoteRewardRed()
    end
    RedMgr.Singleton:UpdateClientRedData("1080", redNum);
    BranchMissionHelper.BranchChickTips();
end

this.CheckGotoBuilding = function()
    if LuaMgr.IsGuide() then
        AreaMapSceneMgr.SetBuildingId("");
    end
    AreaMapSceneMgr.isClick = true;
    local buildingId = AreaMapSceneMgr.GetBuildingId();
    if not IsNullOrEmpty(buildingId) then
        AreaMapSceneMgr.SetLight(currentBuilding, false);
        AreaMapSceneMgr.SetBuildingId("");
        if AreaMapSceneMgr.GetBuilding(buildingId) ~= nil then
            newBuildingList = {};
            newEventList = {};
            AreaMapSceneMgr.GetNewBuildings(newBuildingList, newEventList);
            local isAllMain=true;
            if #newBuildingList>1 then
                for i,v in ipairs(newBuildingList) do
                    if v.buildingAtlas=="AreaMapRes" then
                        isAllMain=false;
                    end
                end
            end
            this.CheckNewBuildingsByNovelModel(newBuildingList);
            this.CheckNewEventsByNovelModel(newEventList);
            table.sort(newBuildingList, function(a, b)
                if isAllMain then
                    return a.buildingId<b.buildingId 
                else
                    return b.buildingId < a.buildingId
                end
            end)
            table.sort(newEventList, function(a, b)
                return b.buildingId < a.buildingId
            end)
            if #newBuildingList > 0 then
                if #newBuildingList>1 then
                    print("11")
                end
                AreaMapSceneMgr.isClick = false;
                LuaMgr.AddTimer(0, this.CheckNewBuildings, 0.1, 1, false)
            elseif #newEventList > 0 then
                AreaMapSceneMgr.isClick = false;
                LuaMgr.AddTimer(0, this.CheckNewEvents, 0.1, 1, false)
            else
                this.ClickBuilding(buildingId);
            end
            return;
        end
        local posIndex = tonumber(buildingId);
        if posIndex ~= nil then
            local explore = AreaMapSceneMgr.GetAreaExplore(posIndex);
            if explore ~= nil then
                SetActive(goEvents, false);
                this.SetRightButtonState(true);
                this.LookAt(explore.transform);
                return;
            end
        end
    end
    SetActive(goEvents, false);
    this.SetRightButtonState(true);
    buildingId = AreaMapSceneMgr.GetGotoBuilding(currentArea);
    if not IsNullOrEmpty(buildingId) then
        this.GotoBuilding(buildingId);
    else
        this.GotoMainLine();
    end
end


this.CheckNewBuildingsByNovelModel=function(newBuildingList)
    if mainAreaMapModel==AreaModel.Normal or #newBuildingList==0 then return  end;
    for i=#newBuildingList,1,-1 do
        if newBuildingList[i].buildingAtlas=="AreaMapRes" then
            table.remove(newBuildingList,i);
        end
    end
end

this.CheckNewEventsByNovelModel=function(newEventList)
    if mainAreaMapModel==AreaModel.Normal or #newEventList==0 then return  end;
    for i=#newEventList,1,-1 do



    end
end

this.ClickBuilding=function (buildingId)
    if buildingId==nil then
        buildingId="";
    end
    if currentBuilding == buildingId then
        return;
    end
    AreaMapSceneMgr.SetLight(currentBuilding, false);
    currentBuilding = buildingId;
    AreaMapSceneMgr.SetLight(buildingId, true);
    this.CloseWordChapter();
    if not goEvents.activeSelf then
        this.EventsMoveIn();
    end
    this.GotoBuilding(buildingId);
    this.SetEvents(true);
    SetActive(goRightIcon, false);
end

this.CheckNewBuildings = function()
    this.RemoveMoveTween();
    SetActive(goEvents, false);
    this.SetRightButtonState(true);
    this.MoveNewBuilding();
end


this.CheckClickBuilding = function()
    if (newBuildingList == nil or #newBuildingList <= 0) and (newEventList == nil or #newEventList <= 0) then
        AreaMapSceneMgr.isClick = true;
    end
end

this.MoveNewBuilding = function()
    this.RemoveMoveTween();
    if newBuildingList == nil or #newBuildingList <= 0 then
        this.CheckNewEvents();
        return;
    end
    local pos = AreaMapSceneMgr.GetObjectPos(newBuildingList[1].transform,rectMiddleContent);
    moveTween = rectMiddleContent:DOAnchorPos(pos, 1):OnComplete(this.OnMoveNewBuilding);
end

this.OnMoveNewBuilding = function()
    if newBuildingList == nil or #newBuildingList <= 0 then
        this.CheckNewEvents();
        return;
    end
    local building=newBuildingList[1];
    table.remove(newBuildingList,1);
    if this.CheckUnlockBuilding(building) then
        LuaDebug.error("log：目标解锁建筑 player 状态 lock 为true");
        this.CheckNewEvents();
        return;
    end
    PlayerAreaMapMgr.ModifyAreaMapBuildingStatus(currentArea, building.buildingId);
    PlayerAreaMapMgr.ModifyAreaMapBuildingEvents(currentArea, building.buildingId);
    local mapGroup = ConfigAreaMapMgr.GetAreaMapGroup(currentArea, building.buildingId);
    if mapGroup.category ~= 0 then
        coroutineBuilding = building;
cokey1=coroutine_runner.start(function()
            AreaMapSceneMgr.SetBuilding(coroutineBuilding);
            coroutineBuilding:SetHiddenBuildingUnlockFX(true);
            coroutine_runner.wait(2)
            if coroutineBuilding~=nil then
                coroutineBuilding:SetHiddenBuildingUnlockFX(false);
            end
            this.MoveNewBuilding();
        end)
    else
        coroutineBuilding = building;
cokey1=coroutine_runner.start(function()
            coroutineBuilding:SetMainBuildingUnlockFx(true);
            coroutine_runner.wait(1.35)
            if coroutineBuilding~=nil then
                AreaMapSceneMgr.SetBuilding(coroutineBuilding);
            end
            coroutine_runner.wait(1.2)
            if coroutineBuilding~=nil then
                coroutineBuilding:SetMainBuildingUnlockFx(false);
            end
            this.MoveNewBuilding();
        end)
    end
end

this.CheckUnlockBuilding = function(building)
    if mainAreaMapModel==AreaModel.Novel then
        local key=currentArea.."_"..building.buildingId;
        return not PlayerAreaMgr_NovelModel.areaMapBuildingStatus[key];
    end
    local areaMap = DataMgr.Player.areaMaps[currentArea];
    local mapGroupData = areaMap.mapGroups[building.buildingId];
    return mapGroupData.lock;
end

this.CheckNewEvents = function()
    this.RemoveMoveTween();
    this.MoveNewEventBuilding();
end
 
this.MoveNewEventBuilding = function()
    this.RemoveMoveTween();
    if newEventList == nil or #newEventList <= 0 then
        this.CheckClickBuilding();
        return;
    end
    local pos = AreaMapSceneMgr.GetObjectPos(newEventList[1].transform,rectMiddleContent)
    local mapGroup = ConfigAreaMapMgr.GetAreaMapGroup(currentArea, newEventList[1].buildingId);
    if mapGroup==nil then 
        return 
    end;
    if mapGroup.category ~= 0 then
        newEventList[1]:SetRedNewFx(false);
    end
    moveTween = rectMiddleContent:DOAnchorPos(pos, 0.7):SetEase(Ease.InOutCubic):OnComplete(this.OnMoveNewEventBuilding);
end

this.OnMoveNewEventBuilding = function()
    if newEventList == nil or #newEventList <= 0 then
        AreaMapSceneMgr.isClick = true;
        return;
    end
    local building = newEventList[1];
    table.remove(newEventList, 1);
    currentBuilding = building.buildingId;
    SetActive(goGroup, false);
    local mapGroup = ConfigAreaMapMgr.GetAreaMapGroup(currentArea, building.buildingId);
    if mapGroup.category ~= 0 then
        coroutineBuilding = building;
cokey2 = coroutine_runner.start(function()
            AreaMapSceneMgr.SetBuilding(coroutineBuilding);
            coroutineBuilding:SetHiddenBuildingUnlockFX(true);
            coroutine_runner.wait(2)
             if coroutineBuilding~=nil then
                 coroutineBuilding:SetHiddenBuildingUnlockFX(false);
                 coroutineBuilding:SetResBuidlingRedFx()
                 this.MoveNewBuilding();
             end
        end)
    else
        this.SetEvents(true);
        this.MoveNewEventBuilding();
    end
    PlayerAreaMapMgr.ModifyAreaMapBuildingEvents(currentArea, currentBuilding);
end

this.GotoMainLine = function()
    local areaMap = DataMgr.Player.areaMaps[currentArea];
    if (areaMap == nil) then
        return;
    end
    local areaEventMap = ConfigMgr.Config.areaEvents;
    local mapGroups=ConfigMgr.Config.areaMapGroup[currentArea];
    for key,groupItem in pairs(mapGroups) do
        if mainAreaMapModel==AreaModel.Normal then
            if not areaMap.mapGroups[groupItem.id].lock and PlayerAreaMapMgr.CheckBuildUnLock(currentArea,groupItem.id) then
                for i,v in pairs(areaEventMap) do
                    if v.category==0 and v.groupId == groupItem.id then
                        if  v.type==1 and not DataHelper.CheckNovelComplete(v.id) then
                            this.GotoBuilding(v.groupId);
                            break
                        elseif  v.type==2 and (DataMgr.Player.dungeonRecords[v.id]==nil or DataMgr.Player.dungeonRecords[v.id].completeCount==0) then
                            this.GotoBuilding(v.groupId);
                            break
                        end
                    end
                end
            end
        else
            if PlayerAreaMgr_NovelModel.AreaBuildingUnlocking(currentArea,groupItem.id) then
                for i,v in pairs(areaEventMap) do
                    if v.category==0 and v.groupId == groupItem.id then
                        if  v.type==1 and not DataHelper.CheckNovelComplete(v.id) then
                            this.GotoBuilding(v.groupId);
                            break
                        elseif  v.type==2 and DataHelper.CheckDungeonComplete_NovelModel(v.id) then
                            this.GotoBuilding(v.groupId);
                            break
                        end
                    end
                end
            end
        end
    end
end


this.GetChapterIndex = function(area)
    if area == "" then
        area = DataMgr.Player.areaMapStatus.currentArea;
    end
    for i = 1, #chapterList, 1 do
        if chapterList[i].area == area then
            return i
        end
    end
    return 1
end


this.SetChapter = function(index)
    chapterIndex = index
    SetActive(btnLeftArrowActive, index > 1);
    SetActive(goLeftGray, index <= 1);
    if index < #chapterList then
        local areaMap = chapterList[index + 1];
        local isChapterLock=false;
        if mainAreaMapModel==AreaModel.Normal then
            isChapterLock= not PlayerAreaMgr.CheckAreaUnlock(areaMap.area)
        else
            isChapterLock=PlayerAreaMgr_NovelModel.areaState[areaMap.area].lock;
        end
        if isChapterLock then
            SetActive(btnRightArrowActive, false);
            SetActive(goRightGray, true);
        else
            SetActive(btnRightArrowActive, true);
            SetActive(goRightGray, false);
        end
    else
        SetActive(btnRightArrowActive, false);
        SetActive(goRightGray, true);
    end
end

this.CheckExploreMap = function()
    if AreaMapSceneMgr.isMapEnter then
        AreaMapSceneMgr.isMapEnter = false;
        LuaMgr.ShowLuaPanel(UIName.AreaExploreRecordViewModel, currentArea)
    end
end

this.CheckExplore = function()
    if AreaMapSceneMgr.isExplore then
        AreaMapSceneMgr.isExplore = false;
        local areaExplore = DataMgr.Player.areaExplores[currentArea];
        if areaExplore == nil then
            return;
        end
        if areaExplore.currentExplores ~= nil and #areaExplore.currentExplores > 0 then
            LuaMgr.ShowLuaPanel(UIName.AreaExploreResultViewModel, currentArea)
        end
    end
    if AreaMapSceneMgr.isEnterShop then
        AreaMapSceneMgr.isEnterShop = false;
        this.SetShowIcon(false);
        LuaMgr.ShowLuaPanel(UIName.AreaExploreViewModel, currentArea)
    end
end

this.Listeners = function()
    LuaMgr.AddUIEventListener(UIEventConst.AreaMapClickBuilding, this.OnClickBuilding)
    LuaMgr.AddUIEventListener(UIEventConst.AreaMapClearBuilding, this.OnClearBuilding)
    LuaMgr.AddUIEventListener(UIEventConst.AreaMapLookAt, this.OnLookAt)
    LuaMgr.AddDataEventListener(this.OnDataChanged);
    LuaMgr.AddUIEventListener(UIEventConst.AreaMapExploreChanged, this.OnExploreChanged);
    LuaMgr.AddUIEventListener(UIEventConst.AreaMapGotoExplore, this.OnGotoExplore);
    LuaMgr.AddUIEventListener(UIEventConst.AreaExploreRewardRefresh, this.OnRefreshExploreRedIcon);
    LuaMgr.AddUIEventListener(UIEventConst.AreaExplorePanelClose, this.OnRefreshExploreClose);
    LuaMgr.AddUIEventListener(UIEventConst.AreaExplorePanelOpen, this.OnRefreshExploreOpen);
end

this.RemoveEventListeners = function()
    LuaMgr.RemoveUIEventListener(UIEventConst.AreaMapClickBuilding, this.OnClickBuilding)
    LuaMgr.RemoveUIEventListener(UIEventConst.AreaMapClearBuilding, this.OnClearBuilding)
    LuaMgr.RemoveUIEventListener(UIEventConst.AreaMapLookAt, this.OnLookAt)
    LuaMgr.RemoveDataEventListener(this.OnDataChanged);
    LuaMgr.RemoveUIEventListener(UIEventConst.AreaMapExploreChanged, this.OnExploreChanged);
    LuaMgr.RemoveUIEventListener(UIEventConst.AreaMapGotoExplore, this.OnGotoExplore);
    LuaMgr.RemoveUIEventListener(UIEventConst.AreaExploreRewardRefresh, this.OnRefreshExploreRedIcon);
    LuaMgr.RemoveUIEventListener(UIEventConst.AreaExplorePanelClose, this.OnRefreshExploreClose);
    LuaMgr.RemoveUIEventListener(UIEventConst.AreaExplorePanelOpen, this.OnRefreshExploreOpen);
end

this.SetShowIcon = function(acitve)
    SetActive(goRightIcon, acitve);
    SetActive(Right, acitve);
    SetActive(Left, acitve);
end

this.OnRefreshExploreOpen = function(args)
    if (this.vm.behaviour.Params == nil) then
        return;
    end
    this.SetShowIcon(false);
end

this.OnRefreshExploreClose = function(args)
    if (this.vm.behaviour.Params == nil) then
        return;
    end
    this.SetShowIcon(true);
end

this.OnRefreshExploreRedIcon = function(args)
    if (this.vm.behaviour.Params == nil) then
        return;
    end
    this.SetExploresRed();
    this.SetCourseRed();
end

this.SetCourseRed = function()
    if FeatureManager.IsLock(areaCourseUnlockId) then
        return;
    end   
    local red = AreaMapSceneMgr.CheckCourseRed()   
    RedMgr.Singleton:UpdateClientRedData("1014", red);
end

this.OnGotoExplore = function(args)
    if this.vm.behaviour.Params == nil or not mapNotDestory then
        return;
    end
    local explore = AreaMapSceneMgr.GetAreaExplore(args[0]);
    if explore == nil then
        return;
    end
    explore.Goto();
end

this.OnExploreChanged = function(args)
    if (this.vm.behaviour.Params == nil) then
        return;
    end
    this.SetExplores();
end

this.OnDataChanged = function(args)
    if this.vm.behaviour.Params == nil then
        return;
    end

    local type = tostring(args[0]);
    if type == "areaMaps" then
        this.SetAreaMap(currentArea);
    elseif type == "areaExplores" then
        this.SetExplores();
    end
end

this.SavePositionRequest=function (area,pos)
    local currentArea = area
    local currentPos = pos
    local Result
    local data = { CurrentArea = currentArea, CurrentPos = currentPos }
    local Url = "save_position"
    ApiMgr.Request(Url, data, true,
    nil,
    function(failCode)
        print("SavePosition,ErrorCode:", failCode)
    end,
    true
    )
end

this.CheckMapMode=function()
    local abyssUnLock=false;;
    for i,v in pairs(ConfigMgr.Config.areas) do
        if v.world=="abyss" and  DataMgr.Player.areaMaps~=nil and DataMgr.Player.areaMaps[v.area]~=nil and  PlayerAreaMgr.CheckAreaUnlock(v.area)  then
            abyssUnLock=true;
            break
        end
    end
    SetActive(toggleAnyss.gameObject,abyssUnLock and mainAreaMapModel==AreaModel.Normal);
end

this.SetAreaMap = function(area)
    if IsNullOrEmpty(area) then
        currentArea = DataMgr.Player.areaMapStatus.currentArea;
        if mainAreaMapModel==AreaModel.Normal and  not PlayerAreaMgr.CheckAreaUnlock(currentArea)  then
            currentArea=this.GetCurUnlockArea();
        end
    else
        currentArea = area;
        this.SavePositionRequest(area,"");
        
    end
    local areaMap = ConfigMgr.Config.areas[currentArea];
    if areaMap == nil then return end
    if not IsNullOrEmpty(areaMap.areaBGM) then
        local path = string.format("%sBgm/%s.mp3", AUDIO_PATH,areaMap.areaBGM);
		AudioMgr.Singleton:PlayBgm(path, true);
    end
    areaExploreUnlockId = this.GetInterafaceUnlockId("AreaExploreViewModel");
    areaCourseUnlockId = this.GetInterafaceUnlockId("AreaCourseViewModel");
    areaCollectUnlockId = this.GetInterafaceUnlockId("AreaMapCollectViewModel");
    textAreaName.text = LuaMgr.GetLangText(areaMap.mapTitlelan);
    textFullName.text = LuaMgr.GetLangText(areaMap.episodelan) .. " " .. LuaMgr.GetLangText(areaMap.uiNamelan);
    this.SetMap();

    if mainAreaMapModel==AreaModel.Novel then

        SetActive(btnCourse.gameObject,false);
        SetActive(btnCollect.gameObject,false);
        SetActive(btnExploreCount.gameObject,false);
        SetActive(btnTeaching.gameObject,false)
        SetActive(goBtnExplore,false)
        SetActive(goBtnBranch,false);
        SetActive(goNovelType,true)
        SetActive(goNovelGroup,true);
        SetActive(goNovelTag,true)
        SetActive(goGroup,false);

        AreaMapSceneMgr.ClearExplores();
        return
    end
    SetActive(goBtnBranch,true);
    SetActive(goNovelType,false)
    SetActive(goNovelGroup,false);
    SetActive(goNovelTag,false)
    SetActive(btnCourse.gameObject,true);
    SetActive(btnCollect.gameObject,true);
    SetActive(btnTeaching.gameObject,true)
    SetActive(goBtnExplore,true)
    SetActive(btnExploreCount.gameObject,true);

    this.SetExplores();
    SetActive(isBtnStrategy.gameObject,areaMap.open == 1)
    SetActive(goBtnTeachingLock, FeatureManager.IsLock("3081"));
    SetActive(goBtnBranchLock, FeatureManager.IsLock("1040"));

    SetActive(goCollecBtnLock, FeatureManager.IsLock(areaCollectUnlockId));
    SetActive(goCourseBtnLock, FeatureManager.IsLock(areaCourseUnlockId));
    SetActive(goBtnExploreLock, FeatureManager.IsLock(areaExploreUnlockId));


    btnTeachingImgColor.color = FeatureManager.IsLock("3081") and lockColor or unlockColor;
    btnBranchImgColor.color = FeatureManager.IsLock("1040") and lockColor or unlockColor;
    btnCollectImgColor.color = FeatureManager.IsLock(areaCollectUnlockId) and lockColor or unlockColor;
    btnCourseImgColor.color = FeatureManager.IsLock(areaCourseUnlockId) and lockColor or unlockColor;
    btnExploreImgColor.color = FeatureManager.IsLock(areaExploreUnlockId) and lockColor or unlockColor;

    this.SetCollectRed();
    this.SetExploresRed();
end

this.SetCollectRed = function()
    local redCount = AreaMapCollectHelper.GetCollectRedCount(currentArea)
    if FeatureManager.IsLock(areaCollectUnlockId) then return; end
    RedMgr.Singleton:UpdateClientRedData("1128", redCount);
end

this.SetExploresRed = function()
    SetActive(goExploreRedIcon_CollectReward, false)
    SetActive(goExploreRedIcon_Dispatchable, false)
    SetActive(goExploreRedIcon_Dispatch, false)
    
    if FeatureManager.IsLock(areaExploreUnlockId) then
        return
    end

    if this.GetExploresRewardStatus() then

        SetActive(goExploreRedIcon_CollectReward, true)
        return
    end

    local areaExplore = DataMgr.Player.areaExplores[currentArea];
    if areaExplore ~= nil and not IsNull(areaExplore.currentExplores) and next(areaExplore.currentExplores) ~= nil then

        SetActive(goExploreRedIcon_Dispatch, true)
        return
    end
    

    local redCount = 0
    local mapExplores = ConfigAreaMgr.GetAreaMapExplores(currentArea)
    local configLength = mapExplores ~= nil and #mapExplores or 0;
    local areaExplores = DataMgr.Player.areaExplores[currentArea];
    local dataLength = 0
    if areaExplores ~= nil then
        for k, v in pairs(areaExplores.completedExplores) do
            dataLength = dataLength + 1
        end
    end
    local dataLength = 0
    if areaExplores ~= nil then
        for k, v in pairs(areaExplores.completedExplores) do
            dataLength = dataLength + 1
        end
    end
    if configLength > dataLength then
        local costItem = ConfigMgr.Config.areas[currentArea].exploreCost[1]
        local needCount = costItem.count * ConfigMgr.Config.constants.exploreRedDot
        if needCount <= DataHelper.GetItemCountById(costItem.itemId) then
            redCount = redCount + 1;
        end
    end
    if redCount > 0 then
        SetActive(goExploreRedIcon_Dispatchable, true)
        return
    end
end

this.GetExploresRewardStatus = function()
    if DataMgr.Player.missions[currentArea]==nil or DataMgr.Player.missions[currentArea]["204"]==nil then
        return false
    end
    local missionProgress = table.Copy(DataMgr.Player.missions[currentArea]["204"])
    local missionList = {}
    for i, v in pairs(missionProgress) do
        table.insert(missionList, v)
    end
    table.sort(missionList, function(a, b)
        return MissionHelper.GetTargetCount(a.id) < MissionHelper.GetTargetCount(b.id)
    end)
    local missionData = nil
    for i, v in ipairs(missionList) do
        missionData = v
        if missionData == nil then
            return
        end
        local targetCount = MissionHelper.GetTargetCount(missionData.id)
        if not missionData.completed and missionData.current == targetCount then
            return true
        end
    end
    return false
end

this.SetExplores = function()
    if mainAreaMapModel==AreaModel.Novel then
        return;
    end
    AreaMapSceneMgr.SetExplores();
    this.SetExploreCount();
end

this.SetExploreCount = function()
    if mapNotDestory then
        local count = PlayerAreaMapMgr.GetExploreCount();
        SetActive(btnExploreCountLock, count ~= 0)

        if (count ~= 0) then
            textExploreCount.text = tostring(count);
        end
    end
end

this.SetMap = function()
    this.ClearMap();
    mapNotDestory=true;
    AreaMapSceneMgr.Init(currentArea, rectMapContent, rectMapContent.parent);
    AreaMapSceneMgr.SetInfos(infoItems);
end

this.GetInterafaceUnlockId = function(panelName)
    local data = ConfigInterfaceMgr.GetInterface(panelName, currentArea);
    return data ~= nil and data.id or "";
end

this.OnLookAt = function(args)
    if (args ~= nil and args.Length > 0) then
        this.LookAt(args[0]);
    end
end

this.OnClearBuilding = function(args)
    this.ClearMap();
end

this.ClearMap = function()
    mapNotDestory=false;
    currentBuilding = "";
end


this.RemoveEventItem = function()
    if (eventDatas ~= nil) then
        local len = #eventDatas;
        for i = 1, len do
            eventDatas[i]:Destroy();
        end
        eventDatas = nil;
    end
end

this.OnClickBuilding = function(args)
    local buildingId = args[0];
    if buildingId==nil then
        buildingId="";
    end



    AreaMapSceneMgr.SetLight(currentBuilding, false);
    currentBuilding = buildingId;
    AreaMapSceneMgr.SetLight(buildingId, true);
    this.CloseWordChapter();
    if not goEvents.activeSelf then
        this.EventsMoveIn();
    end
    this.GotoBuilding(buildingId);
    this.SetEvents(true);
    SetActive(goRightIcon, false);
end

this.SetEvents = function(moveIn)
    LuaMgr.RemoveTimer(TimerConst.AreaMapEventTime);
    local areaMap = DataMgr.Player.areaMaps[currentArea]
    if areaMap == nil then
        return;
    end
    SetActive(goEvents, true);
    SetActive(toggleAnyss.gameObject,false);
    this.SetRightButtonState(false);
    local list = {};
    if mainAreaMapModel==AreaModel.Novel then
       list=PlayerAreaMgr_NovelModel.GetBuildingUnlockEvents(currentArea,currentBuilding);
    else
        for key, value in pairs(areaMap.areaEvents) do
            local config = ConfigMgr.Config.areaEvents[key];
            if config ~= nil and config.groupId == currentBuilding and value.type ~= AreaEventType.Shop and PlayerAreaMgr.CheckEventIsUnlock(config.id) then
                table.insert(list, config);
            end
        end
    end
    table.sort(list, function(a, b)
        return a.sort < b.sort;
    end)
    local index = 0;
    local newEvent = false;
    if #list > 0 then

        if #list > 5 then
            contentSizeFitter.enabled = true;
        else
            contentSizeFitter.enabled = false;
            rectContent.sizeDelta = Vector2(338, 600);
        end

        local isLimit,limitIndex = false,0
        for i = 1, #list, 1 do
            local config = list[i];
            newEvent = PlayerAreaMapMgr.CheckAreaMapBuildingNewEvent(currentArea, currentBuilding, config.id);
            local eventData;
            if #eventDatas > index then
                eventData = eventDatas[index+1];
            else
                eventData = AreaMapEventItem.New(test:GetComponent("RectTransform"));
                table.insert(eventDatas,eventData);
            end
            eventData.imgCategory.sprite = LuaMgr.GetSprite("AreaMapRes", config.icon)
            local type = config.type;
            if type == AreaEventType.AVG then
                local narrative = ConfigMgr.Config.narrativeMap[config.eventParam];
                if narrative ~= nil then
                    eventData.textEventName.text = LuaMgr.GetLangText(narrative.nameLan);
                end
                local completed = false;
                if mainAreaMapModel==AreaModel.Novel then
                    completed=PlayerAreaMgr_NovelModel.completedAreaEvents[config.id];
                    if completed==nil then completed=false end;
                else
                    completed=DataMgr.Player.completedAreaEvents[config.id];
                end

                SetActive(eventData.goFinish, completed);
                SetActive(eventData.goEvaluate, false);
                SetActive(eventData.goNotEvaluate, not completed);
                SetActive(eventData.goCompleted, completed);
                SetActive(eventData.goClear, false);
                if config.category == 0 then
                    eventData.textChaterType.text = LuaMgr.GetLangText("AreaMapViewModel_2")
                elseif config.category == 1 then
                    eventData.textChaterType.text = LuaMgr.GetLangText("AreaMapViewModel_3")
                elseif config.category == 2 then
                    eventData.textChaterType.text = LuaMgr.GetLangText("AreaMapViewModel_4")
                elseif config.category == 3 then
                    eventData.textChaterType.text = LuaMgr.GetLangText("AreaMapViewModel_5")
                elseif config.category == 4 then
                    eventData.textChaterType.text = "boss"
                elseif config.category == 5 then
                    eventData.textChaterType.text = LuaMgr.GetLangText("AreaMapViewModel_6")
                elseif config.category == 6 then
                    eventData.textChaterType.text = LuaMgr.GetLangText("AreaMapViewModel_7")
                end
            else
                SetActive(eventData.goFinish, false);
                local dungeon = ConfigMgr.Config.dungeonMap[config.eventParam];
                if dungeon ~= nil then
                    eventData.textEventName.text = dungeon.name;
                    isLimit,limitIndex = ConfigHelper.IsLimitCount(config.id)
                    SetActive(eventData.goCount,isLimit)
                    if isLimit then
                        local totalCount = ConfigMgr.Config.constants.LevelWeeklyLimit[limitIndex]
                        local dungeonKey = "dungeon_"..config.id
                        local getRewardCount = 0
                        if DataMgr.Player.weeklyCount[dungeonKey] ~= nil then
                            getRewardCount = DataMgr.Player.weeklyCount[dungeonKey]
                        end
                        getRewardCount = totalCount - getRewardCount
                        eventData.textCount.text = string.format(DungeonLimitStr,getRewardCount,totalCount)
                    end
                end
                local record =nil;
                local isShowPassByNovelModel=false;
                if mainAreaMapModel==AreaModel.Novel then
                    local novelRecord=DataMgr.Player.storyModeDungeonRecords[config.eventParam];
                    if novelRecord~=nil then
                        record=table.Copy(novelRecord);
                    end

                    if record~=nil and not IsNullOrEmpty(record.historyRating) then
                        isShowPassByNovelModel=true;
                        record.historyRating="";
                    end
                else
                    record=DataMgr.Player.dungeonRecords[config.eventParam];
                end
                if record ~= nil and record.historyRating ~= nil and record.historyRating ~= "" then
                    eventData.imgEvaluate.sprite = LuaMgr.GetSprite("AreaMapRes", "ui_zqzb_pj_" .. record.historyRating)
                    SetActive(eventData.goEvaluate, true)
                    SetActive(eventData.goNotEvaluate, false)
                    if mainAreaMapModel==AreaModel.Normal and record.historyRating == "S" then
                        local isChallenges = AreaMapSceneMgr.IsLevelChallengesById(config.eventParam);
                        SetActive(eventData.goCompleted, isChallenges)
                        SetActive(eventData.goClear, not isChallenges)
                    else
                        SetActive(eventData.goCompleted, false)
                        SetActive(eventData.goClear, false)
                    end
                else
                    SetActive(eventData.goEvaluate, false)
                    SetActive(eventData.goNotEvaluate, true)
                    SetActive(eventData.goCompleted, false)
                    SetActive(eventData.goClear, isShowPassByNovelModel)
                end
                if config.category == 0 then
                    eventData.textChaterType.text = LuaMgr.GetLangText("AreaMapViewModel_8")
                elseif config.category == 1 then
                    eventData.textChaterType.text = LuaMgr.GetLangText("AreaMapViewModel_9")
                elseif config.category == 2 then
                    eventData.textChaterType.text = LuaMgr.GetLangText("AreaMapViewModel_10")
                elseif config.category == 3 then
                    eventData.textChaterType.text = LuaMgr.GetLangText("AreaMapViewModel_11")
                elseif config.category == 4 then
                    eventData.textChaterType.text = "boss"
                elseif config.category == 5 then
                    eventData.textChaterType.text = LuaMgr.GetLangText("AreaMapViewModel_12")
                elseif config.category == 6 then
                    eventData.textChaterType.text = LuaMgr.GetLangText("AreaMapViewModel_13")
                end
            end
            if config.type == 1 then
                local isNew=false;
                if mainAreaMapModel==AreaModel.Novel then
                    isNew=not DataHelper.CheckNovelComplete(config.eventParam);
                else
                    isNew= PlayerAreaMapMgr.CheckAreaMapBuildingNewEvent(currentArea, currentBuilding, config.id);
                end
                SetActive(eventData.goNew, isNew);
            elseif config.type == 2 then
                local isNew=false;
                if mainAreaMapModel==AreaModel.Novel then
                    isNew=not PlayerAreaMgr_NovelModel.CheckDungeonRecords(config.eventParam);
                else
                    isNew=not PlayerAreaMapMgr.CheckDungeonRecords(config.eventParam);
                end
                SetActive(eventData.goNew,isNew)
            end
            eventData.imgType.sprite = LuaMgr.GetSprite("AreaMapRes", "ui_qydt_leixing_" .. config.type)
            eventData:SetData(config.id, currentArea, currentBuilding);
            index = index+1
        end
        LuaMgr.AddTimer(TimerConst.AreaMapEventTime, this.OnEventTime, 1, -1, true)
        local needDelayTime=false;
        for i = 0, (index-1), 1 do
            if moveIn then
                if newEvent then
                    if i < index - 1 then
                        eventDatas[i+1]:MoveIn((i + 1) * 0.2, 0.2, (i + 1 * 0.3))
                        needDelayTime=true;
                    elseif needDelayTime then
                        eventDatas[i+1]:DOScale((i + 1) * 0.2 + 0.4, 0.2, (i + 1) * 0.3);
                    else
                        eventDatas[i+1]:DOScale((i + 1) * 0.2 + 0.2, 0.2, (i + 1) * 0.3);
                    end
                else
                    eventDatas[i+1]:MoveIn((i + 1) * 0.2,0,0);
                end
            end
        end
        local len = #eventDatas
        for i = index, (len-1), 1 do
            eventDatas[i+1]:Hide();
        end
else
        for key, value in pairs(eventDatas) do
            value:Hide();
        end
    end
    
end


this.OnEventTime = function()
    local areaMaps = DataMgr.Player.areaMaps;
    if (areaMaps == nil) then return end
    
    local areaMap = areaMaps[currentArea];
    if (areaMap == nil) then return end
    
    local sysTime = LuaMgr.Timestamp()
    local isOpen=false;
    for key, item in pairs(eventDatas) do
        local data = areaMap.areaEvents[item.id];
        if data == nil then
            goto continue
        end
        if data.removeTime > 0 then
            local time = data.removeTime - sysTime
            if time <= 0 then
                PlayerAreaMapMgr.RemoveAreaEvent(currentArea, data.ID)
                this.SetEvents(false);
                return;
            end

            item.textTime.text = AreaMapSceneMgr.GetTimeDHM(time);
            SetActive(item.goTime, true);
            isOpen=true;
        else
            SetActive(item.goTime, false);
        end
        if not isOpen then
            LuaMgr.RemoveTimer(TimerConst.AreaMapEventTime);
        end
        ::continue::
    end
end

this.GotoBuilding = function(id)
    local building = AreaMapSceneMgr.GetBuilding(id);
    if building == nil then
        return
    end
    AreaMapSceneMgr.SetGotoBuilding(currentArea, id);
    if LuaMgr.IsGuide() then
        this.LookAt(building.transform);
    else
        this.DOMoveBuilding(building.transform);
    end
    AreaMapSceneMgr.SetMapPos();
end

this.DOMoveBuilding = function(rectTransform)
    local targetPos = AreaMapSceneMgr.GetObjectPos(rectTransform,rectMiddleContent);
    DOTWeen.To(
        function() return rectMiddleContent.anchoredPosition end,
        function(vector) rectMiddleContent.anchoredPosition = vector end,
        targetPos,
        0.7
    ):SetEase(Ease.InOutCubic);
end

this.LookAt = function(rectTransform)
    rectMiddleContent.anchoredPosition = AreaMapSceneMgr.GetObjectPos(rectTransform,rectMiddleContent)
end

this.CloseWordChapter = function()
    if not goChapterList.activeSelf then
        return
    end
    SetActive(goChapter, true);
    rootAni:Play("UI_AreaMapPanel_cut_02");
LuaMgr.AddTimer(TimerConst.DelayCloseWorldList, this.DelayCloseWorldList, 0.3, 1, false)
end

this.DelayCloseWorldList = function()
    SetActive(goChapterList, false);
    LuaMgr.RemoveTimer(TimerConst.DelayCloseWorldList)
end

this.EventsMoveIn = function()
    this.RemoveTween();
    rectEvents.anchoredPosition = Vector2(258, 0);
    tween = this.DOAnchorPosX(rectEvents,0, 0.5)
end

this.DOAnchorPosX = function(target, endValue, duration)
    return DOTWeen.To(
        function() return target.anchoredPosition end,
        function(x) target.anchoredPosition = x end,
        Vector2(endValue, 0),
        duration
    )








end

this.RemoveTween = function()
    if tween ~= nil then
        tween:Kill(false);
        tween = nil;
    end
end

this.InitChapter = function()
    areaMode= EMapMode.Normal
    local areas = ConfigMgr.Config.areas;
    chapterList={}
    if areaMode==EMapMode.Normal then
        for key, value in pairs(areas) do
            if value.world == "zhengzhuan"  then
                table.insert(chapterList, value)
            end
        end
        SetActive(goChapter,true)
    elseif areaMode==EMapMode.Anyss then
        for key, value in pairs(areas) do
            if  value.world=="abyss" then
                table.insert(chapterList, value)
            end
        end
        SetActive(goChapter,#chapterList>1)
    end
    
    table.sort(chapterList, function(a, b) return a.sortNum < b.sortNum end)
end

this.SetRightButtonState=function(isOn)
    if areaMode==EMapMode.Normal then
        SetActive(goBtnBranch,isOn and mainAreaMapModel==AreaModel.Normal)
        SetActive(goBtnExplore,isOn and mainAreaMapModel==AreaModel.Normal)
        SetActive(goGroup,isOn);
    end
end
































this.GetAreaByMode=function(isOn)
    local modelist={}
    for i,v in pairs(ConfigMgr.Config.areas) do
        if  isOn and v.world=="abyss" or not isOn and v.world=="zhengzhuan" then
            table.insert(modelist,v)
        end
    end
    table.sort(modelist,function(a, b) return a.sortNum <b.sortNum  end)
    local area=modelist[1];
    for i,v in ipairs(modelist) do
        if PlayerAreaMgr.CheckAreaUnlock(v.area)  then
            area=v;
        else
            break;
        end
    end
    return area.area;
end

this.GetAbyssPercent = function()
    local mapKey = nil
    for key,value in pairs(ConfigMgr.Config.areas) do
        if value.world == "abyss" then
            mapKey = value.area
            break
        end
    end
    local events = ConfigAreaMapMgr.GetAreaMapEvents(mapKey)
    local length = #events
    local perfectCount = 0
    for i = 1, length do
        if this.GetDungeonStatus(events[i].eventParam) == 1 then
            perfectCount = perfectCount + 1
        end
    end
    textAbyss.text = math.floor(perfectCount / length * 100).."%"
end



this.GetDungeonStatus = function(eventParam)
    if IsNullOrEmpty(eventParam) then return end
    local dungeonData = DataMgr.Player.dungeonRecords[eventParam]
    local challengeCount = ConfigAreaMgr.GetChallengeCountById(eventParam)
    local completeCount = 0
    if challengeCount > 0 then
        completeCount = PlayerAreaMgr.GetChallengeCompleteCountById(eventParam)
    end
    if dungeonData == nil or IsNullOrEmpty(dungeonData.historyRating) then
        return 3
    else
        if dungeonData.historyRating == "S" and challengeCount == completeCount then
            return 1
        else
            return 2
        end
    end
end




this.InitMainAreaMapMode=function()
    mainAreaMapModel=PlayerAreaMgr.GetAreaModel();
    PlayerAreaMgr_NovelModel.UpdateAreasData();
end
this.OnClickSwitchModelType=function()
    if stopClickNext then return end
    stopClickNext=true;
    if mainAreaMapModel==nil then
        mainAreaMapModel=PlayerAreaMgr.GetAreaModel();
    end
    if mainAreaMapModel==AreaModel.Normal then
        mainAreaMapModel=AreaModel.Novel;
        local key=DataMgr.Player.uid.."MainAreaMapModel";
        if PlayerPrefs.GetInt(key)==0 then
            PlayerPrefs.SetInt(key,1);
            LuaMgr.ShowLuaPanel(UIName.AreaMapNovelModelTipViewModel)
        end
    else
        mainAreaMapModel=AreaModel.Normal;
    end
    PlayerAreaMgr.SetAreaModel(mainAreaMapModel);
    this.SwitchAreaMapModel();
    this.CheckMapMode();
end


this.SwitchAreaMapModel = function()
    AreaMapSceneMgr.ClearGotoBuilding();
    AreaMapSceneMgr.SetBuildingId("")
    PlayerAreaMgr_NovelModel.UpdateAreasData();
    PlayerAreaMapMgr.InitAreaMapBuildingStatus();
    PlayerAreaMapMgr.InitAreaMapBuildingEvent();
    if mainAreaMapModel==AreaModel.Normal  then
        PlayerAreaMapMgr.InitAreaMapSurveyEvent();
        if not PlayerAreaMgr.CheckAreaUnlock(currentArea) then
            currentArea,chapterIndex=this.GetCurUnlockArea();
        end
    else
        if PlayerAreaMgr_NovelModel.areaState[currentArea].lock then
            currentArea,chapterIndex=this.GetCurUnlockArea();
        end
    end
    this.SetChapter(chapterIndex);
    if goEvents.activeSelf then

        SetActive(goEvents, false);
    end
    if goChapterList.activeSelf then

        this.SetChapterData();
    end
    if currentBuilding~=nil then

        AreaMapSceneMgr.SetLight(currentBuilding, false);
    end
    coroutine_runner.start(function()
        LuaMgr.ShowPanel(UIName.PreloadViewModel); 
        coroutine_runner.wait(0.15)
        this.SetAreaMap(currentArea);
        coroutine_runner.wait(0.15)
        LuaMgr.HidePanel(UIName.PreloadViewModel);
        this.CheckGotoBuilding();
        stopClickNext = false;
    end)
end

this.OnClickNovelTypeTips=function()
    LuaMgr.ShowLuaPanel(UIName.AreaMapNovelModelTipViewModel)
end


this.GetCurUnlockArea=function()
    local areaList={};
    for i,v in pairs(ConfigMgr.Config.areas) do
        if v.world=="zhengzhuan" then
            table.insert(areaList,v);
        end
    end
    table.sort(areaList,function(a, b)
        return a.sortNum<b.sortNum;
    end)
    local curIndex=0;
    if mainAreaMapModel==AreaModel.Normal then
        for i,v in ipairs(areaList) do
            if DataMgr.Player.areaMaps[v.area]~=nil and  PlayerAreaMgr.CheckAreaUnlock(v.area) then
                curIndex=curIndex+1;
            end
        end
    else
        for i,v in ipairs(areaList) do
            if PlayerAreaMgr_NovelModel.areaState[v.area]~=nil and not PlayerAreaMgr_NovelModel.areaState[v.area].lock then
                curIndex=curIndex+1;
            end
        end
    end
    if curIndex==0 then
        curIndex=1;
    end
    return areaList[curIndex].area,curIndex;
end




return vm({
    data = data,
    command = command,
    hook = hook
})