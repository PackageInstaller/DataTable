
require("CollectorPractice/Common/UIBuffSLotItem")
require("CollectorPractice/Common/UICollectorMapIconItem")
local tarGameObject = nil;
local tarRect = nil;
local UIBuffSLotItemPrefab = nil;
local UICollectorMapIconItemPrefab = nil;
local root = nil;
local Middle = nil;
local rawImageBg = nil;
local rectSpine = nil;
local rectLeftImageBg = nil;
local rectBGBuff = nil;
local rectBuffGroup = nil;
local scrollMapList = nil;
local btnWeakReward = nil;
local btnStart = nil;
local textStart = nil;
local textRewardPrecent = nil;
local rectMapListContent=nil;
local rawImageBgTemp=nil;
local animator=nil;
local this = {
    womanOBJ = nil,
    manOBj = nil,

    openMap={},
    mapIconObjList={},
    mapIdToMapIconObj={},
    buffOrigins={},
    buffItemList={},
    selectMapId=nil,
isLoadSaveData={},
    switchPanelCo=nil,

};





local TEXTURE_PATH_MAN_MAP ={
    ["MapA"] = "Assets/_BundleResources/Images/CollectorAchieve/ui_yx_cg_bj.png",
    ["MapB"] = "Assets/_BundleResources/Images/CollectorAchieve/ui_sx_jy_bj.png",
} 
local TEXTURE_PATH_WOMAN_MAP ={
    ["MapA"] = "Assets/_BundleResources/Images/CollectorAchieve/ui_yx_cg_bj.png",
    ["MapB"] = "Assets/_BundleResources/Images/CollectorAchieve/ui_sx_jy_bj.png",
}


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    UIBuffSLotItemPrefab = uiLink:Get("UIBuffSLotItem");
    UICollectorMapIconItemPrefab = uiLink:Get("UICollectorMapIconItem");
    root = uiLink:Get("root");
    animator=uiLink:Get("root"):GetComponent("Animator");
    Middle = uiLink:Get("MiddleNotLayout");
    rawImageBg = uiLink:Get("rawImageBg"):GetComponent("RawImage");
    rectSpine = uiLink:Get("rectSpine"):GetComponent("RectTransform");
    rectLeftImageBg = uiLink:Get("rectLeftImageBg"):GetComponent("RectTransform");
    rectBGBuff = uiLink:Get("rectBGBuff"):GetComponent("RectTransform");
    rectBuffGroup = uiLink:Get("rectBuffGroup"):GetComponent("RectTransform");
    scrollMapList = uiLink:Get("scrollMapList"):GetComponent("ScrollRect");
    btnWeakReward = uiLink:Get("btnWeakReward"):GetComponent("Button");
    btnStart = uiLink:Get("btnStart"):GetComponent("Button");
textStart = uiLink:Get("textStart"):GetComponent("Text");
    textRewardPrecent = uiLink:Get("textRewardPrecent"):GetComponent("Text");
    rectMapListContent= uiLink:Get("rectMapListContent"):GetComponent("RectTransform");
    rawImageBgTemp= uiLink:Get("rawImageBgTemp"):GetComponent("RawImage");
    uiLink:AddClickEvent("btnWeakReward", function()
        LuaMgr.ShowLuaPanel(UIName.CollectorPracticeWeeklyMissionViewModel)
    end);
    uiLink:AddClickEvent("btnStart", function()
        if this.switchPanelCo~=nil then
            return;
        end
        this.switchPanelCo = coroutine_runner.start(function()
            animator:Play("ani_CollectorPracticeHomePanel_disappear",0,0)
            coroutine_runner.wait(0.5)
            if this.selectMapId=="MapA" then
                LuaMgr.ShowLuaPanel(UIName.CollectorPracticeHomeViewModel)
                CollectorPracticeAllMgr.SelectMap("MapA");
            elseif this.selectMapId=="MapB" then
                LuaMgr.ShowLuaPanel(UIName.CollectorPracticeHomeVersion2ViewModel)
                CollectorPracticeAllMgr.SelectMap("MapB");
            end
            
            this.switchPanelCo=nil;
        end)
    end);
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    UIBuffSLotItemPrefab = nil;
    UICollectorMapIconItemPrefab = nil;
    root = nil;
    animator=nil;
    Middle = nil;
    rawImageBg = nil;
    rectSpine = nil;
    rectLeftImageBg = nil;
    rectBGBuff = nil;
    rectMapListContent=nil;
    rectBuffGroup = nil;
    scrollMapList = nil;
    btnWeakReward = nil;
    btnStart = nil;
    textStart = nil;
    textRewardPrecent = nil;
    rawImageBgTemp=nil;
    for index, value in ipairs(this.buffItemList) do
        value:Destroy();
    end
    this = nil;
end

this.InitData = function()
    this.isLoadSaveData={};
    this.openMap={};
    this.switchPanelCo=nil;
    this.selectMapId=nil;
    local config=ConfigMgr.Config.PracticePeriodMaps;
    local currenTime = LuaMgr.Timestamp()
    if config ~= nil then
        for key, value in pairs(config) do
            table.insert(this.openMap,value.mapType)
        end
    end
    table.sort(this.openMap,function (a, b)
        return a<b;
    end);
    table.insert(this.openMap,"Unknow")
    this.InitBuffData();
HeroRedDataHelper.UpdateRedLevelSelectMap();
end

this.InitPanel=function ()
    for i = 1, #this.openMap, 1 do
        if i > #this.mapIconObjList then
            table.insert(this.mapIconObjList,UICollectorMapIconItem.New(UICollectorMapIconItemPrefab,rectMapListContent))
        end
        this.mapIconObjList[i]:SetData(this.openMap[i],this.ClickMapIcon);
        this.mapIdToMapIconObj[this.openMap[i]]=this.mapIconObjList[i];
    end
    for i = #this.openMap + 1, #this.mapIconObjList do
        this.mapIconObjList:Hide();
    end
    local nowPrecent = (LuaMgr.GetScreenWidth() + LuaMgr.ScreenOffSet() - 1280) / (1680 - 1280)
    rectLeftImageBg.anchoredPosition = Vector2(this.GetNumberByPercent(-56, 0, nowPrecent), rectLeftImageBg.anchoredPosition.y);

    HeroRedDataHelper.RefreshCollectorPractice();

end

this.GetNumberByPercent = function(startValue, endValue, percent)
    return startValue + ((endValue - startValue) * percent);
end



this.ClickMapIcon=function (mapIconObj,isFirst)
if mapIconObj.isLock or this.switchPanelCo~=nil or this.selectMapId==mapIconObj.mapId then
        return;
    end
    for index, value in ipairs(this.mapIconObjList) do
        value:SetSelect(false);
    end
    mapIconObj:SetSelect(true);
    this.selectMapId=mapIconObj.mapId;
    
    if isFirst then
        this.RefreshTempImg(mapIconObj.mapId);
        this.SelectMapInitPanel(mapIconObj.mapId)
this.switchPanelCo = coroutine_runner.start(function()
            
            for i = 1, #this.buffOrigins[this.selectMapId], 1 do
if i <= #this.buffItemList then
                    this.buffItemList[i]:PlayFirstAnimation();
                end
            end
            coroutine_runner.wait(0.63)
            this.switchPanelCo=nil
        end)
    else
        this.switchPanelCo = coroutine_runner.start(function()
            animator:Play("ani_CollectorPracticeHomePanel_switch",1,0)
            this.RefreshTempImg(mapIconObj.mapId);
            local complete=nil;
            local playeData = DataMgr.Player.originsTalent
            for i = 1, #this.buffOrigins[this.selectMapId], 1 do
if i <= #this.buffItemList then
                    complete = playeData[this.buffOrigins[this.selectMapId][i].OriginsID] ~= nil
                    coroutine_runner.wait(0.03)

                    this.buffItemList[i]:PlaySwitchAnimationAndEndSetData(this.buffOrigins[this.selectMapId][i].OriginsID,(not complete),true);
                end
            end
            local value=math.min(#this.buffOrigins, #this.buffItemList);
            coroutine_runner.wait((0.85-(value*0.03)))
    
            this.RefreshImg(mapIconObj.mapId)
            this.SwitchMapInitPanel(mapIconObj.mapId);
            coroutine_runner.wait(0.3)
            this.switchPanelCo=nil
        end)
    end

end

this.GetStoryDataPrecent={
    ["MapA"]=CollectorPracticeMgr.GetStoryDataPrecent;
    ["MapB"]=CollectorPracticeMgrVersion2.CalculateCollect;
}

this.SelectMapInitPanel=function (mapId)
    this.InitBuffPanel(mapId);
    this.RefreshImg(mapId)
    if this.isLoadSaveData[mapId]~=nil then
        textRewardPrecent.text=this.isLoadSaveData[mapId];
    else
        this.isLoadSaveData[mapId]=tostring(math.floor(this.GetStoryDataPrecent[mapId]()*100)).."%";
        textRewardPrecent.text=this.isLoadSaveData[mapId];
    end
end

this.SwitchMapInitPanel=function (mapId)
    if this.isLoadSaveData[mapId]~=nil then
        textRewardPrecent.text=this.isLoadSaveData[mapId];
    else
        this.isLoadSaveData[mapId]=tostring(math.floor(this.GetStoryDataPrecent[mapId]()*100)).."%";
        textRewardPrecent.text=this.isLoadSaveData[mapId];
    end
end


this.InitBuffData = function()
    this.buffOrigins = {}
    for key, value in pairs(ConfigMgr.Config.OriginsTalentMap) do
        if this.buffOrigins[value.Map]==nil then
            this.buffOrigins[value.Map]={};
        end
        table.insert(this.buffOrigins[value.Map], value);
    end
    for key, value in pairs(this.buffOrigins) do
        table.sort(value, function(a, b)
            return a.OtOrder < b.OtOrder;
        end)
    end

end

this.InitBuffPanel=function (mapId)
    local playeData = DataMgr.Player.originsTalent
    local complete = false;
    for i = 1, #this.buffOrigins[mapId], 1 do
        complete = playeData[this.buffOrigins[mapId][i].OriginsID] ~= nil
        if i > #this.buffItemList then
            local temp = UIBuffSLotItem.New(UIBuffSLotItemPrefab, rectBuffGroup);
            table.insert(this.buffItemList, temp);
        end
        this.buffItemList[i]:SetData(this.buffOrigins[mapId][i].OriginsID,(not complete),true);
    end
    for i = #this.buffOrigins[mapId] + 1, #this.buffItemList, 1 do
        this.buffItemList[i]:Hide();
    end

    rectBGBuff.sizeDelta = Vector2(21.8979 + (89 * #this.buffOrigins[mapId]) + (8 * (#this.buffOrigins[mapId] - 1)), rectBGBuff.sizeDelta.y);
end

this.RefreshImg=function (mapId)
    if DataMgr.Player.sex == 1 then
        rawImageBg.texture = LuaMgr.GetTexture(
        TEXTURE_PATH_MAN_MAP[mapId]
    )
    else
        rawImageBg.texture = LuaMgr.GetTexture(
            TEXTURE_PATH_WOMAN_MAP[mapId]
    )
    end
end

this.RefreshTempImg=function (mapId)
    if DataMgr.Player.sex == 1 then
        rawImageBgTemp.texture = LuaMgr.GetTexture(
        TEXTURE_PATH_MAN_MAP[mapId]
    )
    else
        rawImageBgTemp.texture = LuaMgr.GetTexture(
            TEXTURE_PATH_WOMAN_MAP[mapId]
    )
    end
end






















this.CoroutineClose = function()
if coroutine_runner.checkIsDestory() then
        return;
    end
    if this.switchPanelCo ~= nil then
        coroutine_runner.stop(this.switchPanelCo)
    end
end

this.CheckWeeklyRefresh=function ()
    local currentScore=0;
    local maxTargetScore=0;
    local refreshWeeklyId="";
    for key, value in pairs(DataMgr.Player.missions["weekly"]["604"]) do
        refreshWeeklyId=DataMgr.Player.uid.."#"..value.createTime;
        currentScore=value.current;
        maxTargetScore=math.max(maxTargetScore,value.target);
    end
if (not PlayerPrefs.HasKey(refreshWeeklyId)) and (currentScore<maxTargetScore) then
PlayerPrefs.SetInt(refreshWeeklyId,1);
LuaMgr.ShowLuaPanel(UIName.CollectorPracticeWeeklyMissionViewModel)
    end
end

local hook = {
    before_awake = function(vm)
        this.Init(vm.behaviour.gameObject)
        RedMgr.Singleton:RegisterViewModel(UIName.CollectorPracticeSelectMapViewModel);
    end,
    before_active = function(vm)
        local redID = "15112"
        RedMgr.Singleton:FrushRedCondition(redID)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.InitData();
        this.InitPanel();
        if CollectorPracticeAllMgr.currentMap~=nil then
            this.ClickMapIcon(this.mapIdToMapIconObj[CollectorPracticeAllMgr.currentMap],true);
        else
            this.ClickMapIcon(this.mapIconObjList[1],true);
        end
        this.CheckWeeklyRefresh();
    end,
    before_deactive = function(vm)
        if vm.behaviour.Params ~= nil then
            this.CoroutineClose();
        end
    end,
    before_destroy = function(vm)
        this.Clear();
    end,
}

return vm({
    hook = hook
})