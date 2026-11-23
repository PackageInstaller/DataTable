
require("CollectorPractice/Common/UIBuffSLotItem")
local tarGameObject = nil;
local tarRect = nil;
local UIBuffSLotItemPrefab = nil;
local root = nil;
local Middle = nil;
local rawImageBg = nil;
local textShopItemNumber = nil;
local btnChange = nil;
local btnStory = nil;
local btnShop = nil;
local btnGallery = nil;
local btnCompleteAll = nil;
local btnCompleteQuest = nil;
local rectBGStroy = nil;
local rectBGShop = nil;
local rectBGGallery = nil;
local rectBGBuff = nil;
local rectBuffGroup = nil;
local textStart = nil;
local rectSpine = nil;
local goAnimationMask=nil;
local this = {
    nowMapId = "",
    buffItemList = {},
    isOnGame = false,
    womanOBJ=nil;
    manOBj=nil;
    firstAnimationObjectMap={},
    nowShowAnimationMapId=nil,
    needDelectPrefabPath={},
    isCanSkip=false,
    nowPlayAnimator=nil,
    isCanJoinMap=false,

};
local PREFAB_PATH_Man = "Assets/_BundleResources/UI/CollectorPractice/UICollectorPracticeSCJ_ManSpineItem.prefab";
local PREFAB_PATH_Woman = "Assets/_BundleResources/UI/CollectorPractice/UICollectorPracticeSCJ_WomanSpineItem.prefab";
local PREFAB_PATH_BG = "Assets/_BundleResources/UI/CollectorPractice/UICollectorPracticeBGSpineItem.prefab";
local TEXTURE_PATH_MAN = "Assets/_BundleResources/Images/CollectorAchieve/ui_yx_cg_man.png";
local TEXTURE_PATH_WOMAN = "Assets/_BundleResources/Images/CollectorAchieve/ui_yx_cg_woman.png";
local MapIdToPrefabPath={
    ["MapA"]="Assets/_BundleResources/UI/CollectorPractice/CollectorPracticeSwitchMapA.prefab",
}
local MapIdToAnimation={
    ["MapA"]="ani_CollectorPracticeSwitch",
}
this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    UIBuffSLotItemPrefab = uiLink:Get("UIBuffSLotItem");
    root = uiLink:Get("root");
    Middle = uiLink:Get("Middle");
    rawImageBg = uiLink:Get("rawImageBg"):GetComponent("RawImage");
    textShopItemNumber = uiLink:Get("textShopItemNumber"):GetComponent("Text");
    rectSpine = uiLink:Get("rectSpine"):GetComponent("RectTransform");
    btnChange = uiLink:Get("btnChange"):GetComponent("Button");
    btnStory = uiLink:Get("btnStory"):GetComponent("Button");
    btnShop = uiLink:Get("btnShop"):GetComponent("Button");
    btnGallery = uiLink:Get("btnGallery"):GetComponent("Button");
    btnCompleteAll = uiLink:Get("btnCompleteAll"):GetComponent("Button");
    btnCompleteQuest = uiLink:Get("btnCompleteQuest"):GetComponent("Button");
    rectBGStroy = uiLink:Get("rectBGStroy"):GetComponent("RectTransform");
    rectBGShop = uiLink:Get("rectBGShop"):GetComponent("RectTransform");
    rectBGGallery = uiLink:Get("rectBGGallery"):GetComponent("RectTransform");
    rectBGBuff = uiLink:Get("rectBGBuff"):GetComponent("RectTransform");
    rectBuffGroup = uiLink:Get("rectBuffGroup"):GetComponent("RectTransform");
    textStart = uiLink:Get("textStart"):GetComponent("Text");
    goAnimationMask=uiLink:Get("goAnimationMask");
    uiLink:AddClickEvent("btnChange", function()

    end);
    uiLink:AddClickEvent("btnStory", function()
        LuaMgr.ShowLuaPanel(UIName.CollectorPracticeStoryListViewModel)
    end);
    uiLink:AddClickEvent("btnWeakReward", function()
        LuaMgr.ShowLuaPanel(UIName.CollectorPracticeWeeklyMissionViewModel)
    end);
    uiLink:AddClickEvent("btnStart", function()
        if this.isCanJoinMap then
            if this.isOnGame then
                CollectorPracticeMgr.Open2DMap(false);
            else
                LuaMgr.ShowLuaPanel(UIName.CollectorPracticeSelectPathViewModel)
            end
        else
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("7228"));
        end
    end);
    uiLink:AddClickEvent("btnShop", function()
        LuaMgr.ShowLuaPanel(UIName.CollectorPracticeShopViewModel)
    end);
    uiLink:AddClickEvent("btnGallery", function()
        LuaMgr.ShowLuaPanel(UIName.CollectorPracticeGalleryViewModel)
    end);
    uiLink:AddClickEvent("btnCompleteAll", function()
        CollectorPracticeMgr.GMCompleteAllEvent()
    end)
    uiLink:AddClickEvent("btnCompleteQuest", function()
        CollectorPracticeMgr.GMCompleteAllQuest();
    end)
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    UIBuffSLotItemPrefab = nil;
    rectSpine = nil;
    root = nil;
    Middle = nil;
    rawImageBg = nil;
    textShopItemNumber = nil;
    btnChange = nil;
    btnStory = nil;
    btnShop = nil;
    btnGallery = nil;
    btnCompleteAll = nil;
    btnCompleteQuest = nil;
    goAnimationMask=nil;
    rectBGStroy = nil;
    rectBGShop = nil;
    rectBGGallery = nil;
    rectBGBuff = nil;
    rectBuffGroup = nil;
    this = nil;
    textStart = nil;
end

this.InitDebugButton = function()
    SetActive(btnCompleteAll.gameObject, LuaMgr.IsDebug())
    SetActive(btnCompleteQuest.gameObject, LuaMgr.IsDebug());
end

this.InitData = function()
CollectorPracticeMgr.getThemeId()
CollectorPracticeMgr.RefreshGalleryData()
CollectorPracticeMgr.InitStoryData();


    HeroRedDataHelper.RefreshCollectorPractice();

    CollectorPracticeAllMgr.SelectMap("MapA");
    this.nowMapId = "MapA";
    this.isCanJoinMap,this.isOnGame = CollectorPracticeAllMgr.IsCanJoinMapAndOnGame("MapA");
PlayerPrefs.SetInt(DataMgr.Player.uid.."#" ..this.nowMapId,1);
end

this.InitPanel = function()
    local mapData = ConfigMgr.Config.PracticePeriodMaps
    local textShopItemNumberString = ConfigMgr.LangGlobal("7126");
    local num = 0;
    if DataMgr.Player.items["18"] ~= nil then
        num = DataMgr.Player.items["18"].count0
    end
    textShopItemNumber.text = textShopItemNumberString .. LuaMgr.NumFormat(num)


    local nowPrecent = (LuaMgr.GetScreenWidth() + LuaMgr.ScreenOffSet() - 1280) / (1680 - 1280)
    rectBGStroy.anchoredPosition = Vector2(this.GetNumberByPercent(-43.3, 0, nowPrecent), rectBGStroy.anchoredPosition.y);

    rectBGShop.anchoredPosition = Vector2(this.GetNumberByPercent(14.39996, 90.2, nowPrecent),
        rectBGShop.anchoredPosition.y);

    rectBGGallery.anchoredPosition = Vector2(this.GetNumberByPercent(54.4, 156.6, nowPrecent),
        rectBGGallery.anchoredPosition.y);

    rectBGBuff.anchoredPosition = Vector2(this.GetNumberByPercent(-14.1, 0, nowPrecent), rectBGBuff.anchoredPosition.y);
    if this.isOnGame and this.isCanJoinMap then
        textStart.text = ConfigMgr.LangGlobal("7133");
    else
        textStart.text = ConfigMgr.LangGlobal("7134");
    end
    this.RefreshSpine();
    SetActive(goAnimationMask,false);




end
this.InitBuff = function()
    local buffOrigins = {}

    for key, value in pairs(ConfigMgr.Config.OriginsTalentMap) do
        if value.Map == this.nowMapId then
            table.insert(buffOrigins, value);
        end
    end
    table.sort(buffOrigins, function(a, b)
        return a.OtOrder < b.OtOrder;
    end)
    local playeData = DataMgr.Player.originsTalent
    local complete = false;
    for i = 1, #buffOrigins, 1 do
        complete = playeData[buffOrigins[i].OriginsID] ~= nil
        if i > #this.buffItemList then
            local temp = UIBuffSLotItem.New(UIBuffSLotItemPrefab, rectBuffGroup);
            table.insert(this.buffItemList, temp);
        end
this.buffItemList[i]:SetData(buffOrigins[i].OriginsID, (not complete));
    end
    for i = #buffOrigins + 1, #this.buffItemList, 1 do
        this.buffItemList[i]:Hide();
    end

    rectBGBuff.sizeDelta = Vector2(21.8979 + (89 * #buffOrigins) + (8 * (#buffOrigins - 1)), rectBGBuff.sizeDelta.y);
end

this.InitSpine = function()

    local temp = LuaMgr.GetPrefab(PREFAB_PATH_BG);
    LuaMgr.AddPrefabRefCount(PREFAB_PATH_BG);
    temp:GetComponent("RectTransform"):SetParent(rectSpine, false);
    this.manOBJ = LuaMgr.GetPrefab(PREFAB_PATH_Man);
    LuaMgr.AddPrefabRefCount(PREFAB_PATH_Man);
    this.manOBJ:GetComponent("RectTransform"):SetParent(rectSpine, false);
    this.womanOBJ = LuaMgr.GetPrefab(PREFAB_PATH_Woman);
        LuaMgr.AddPrefabRefCount(PREFAB_PATH_Woman);
        this.womanOBJ:GetComponent("RectTransform"):SetParent(rectSpine, false);
end





































































































this.RefreshSpine = function()
    local isOn = LuaMgr.GetRenderLevelEnable("SpineEnable")
    if isOn then
        SetActive(rawImageBg.gameObject, false);
        SetActive(rectSpine.gameObject, true);
        if DataMgr.Player.sex == 1 then
            SetActive(this.womanOBJ,false);
            SetActive(this.manOBJ,true);
        else
            SetActive(this.womanOBJ,true);
            SetActive(this.manOBJ,false);
        end
    else
        SetActive(rawImageBg.gameObject, true);
        SetActive(rectSpine.gameObject, false);
        if DataMgr.Player.sex == 1 then
            rawImageBg.texture = LuaMgr.GetTexture(
            TEXTURE_PATH_MAN
        )
        else
            rawImageBg.texture = LuaMgr.GetTexture(
                TEXTURE_PATH_WOMAN
        )
        end
    end
end

this.GetNumberByPercent = function(startValue, endValue, percent)
    return startValue + ((endValue - startValue) * percent);
end


local hook = {
    before_awake = function(vm)
        this.Init(vm.behaviour.gameObject)
        RedMgr.Singleton:RegisterViewModel(UIName.CollectorPracticeHomeViewModel);
        this.InitSpine();
CollectorPracticeMgr.AwakeInitGradeToBuffData();
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end

        this.InitDebugButton();
        this.InitData();
        this.InitPanel();
        this.InitBuff();
        CollectorPracticeAllMgr.InitCurrentMapData();
    end,
    before_deactive = function(vm)
        if vm.behaviour.Params ~= nil then

            CollectorPracticeMgr.MissionConfigData = {}
            CollectorPracticeMgr.ThemeCurrent = nil
        end
    end,
    before_destroy = function(vm)







        for index, value in ipairs(this.needDelectPrefabPath) do
            LuaMgr.RemovePrefabRefCount(value);
        end
                    LuaMgr.RemovePrefabRefCount(PREFAB_PATH_BG);
            LuaMgr.RemovePrefabRefCount(PREFAB_PATH_Man);
        LuaMgr.RemovePrefabRefCount(PREFAB_PATH_Woman);
        this.Clear();
    end,
}

return vm({
    hook = hook
})