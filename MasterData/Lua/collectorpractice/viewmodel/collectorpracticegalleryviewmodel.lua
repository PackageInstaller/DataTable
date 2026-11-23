



require("CollectorPractice/Common/UICollectorPracticeTag")
require("CollectorPractice/Common/UICollectorCardItem")
local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Middle = nil;
local RightTags = nil;
local LeftIntro = nil;
local goBuffActive = nil;
local goBuffInactive = nil;
local rectGallery = nil;
local rectTag = nil;
local textTotolNumShow = nil;
local textPageShow = nil;
local textIconName = nil;
local textIconIntro = nil;
local textBuffActiveTips1 = nil;
local textBuffActiveTips2 = nil;
local textBuffActiveTips3 = nil;
local textBuffActiveTips4 = nil;
local textActiveBuffEffectTips = nil;
local textBuffInactiveTips1 = nil;
local textBuffInactiveTips2 = nil;
local textBuffInactiveTips3 = nil;
local textBuffInactiveTips4 = nil;
local textInactiveBuffEffectTips = nil;
local imgIcon = nil;
local btnToNext = nil;
local btnToBefor = nil;
local animator = nil;
local goLockIcon=nil;
local goeff=nil;
local animatorBuffGroup=nil;

local this = {
selectCalleryTag = nil;
    CurrentSelectPage = 1;
    practiceGallerytag = {};
    galleryList = {};
originsTalentDataMap = {};
beforeTabId = nil;
    animator = nil;
    mapId = "";
unlock={};
}
this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Middle = uiLink:Get("Middle");
    RightTags = uiLink:Get("RightTags");
    LeftIntro = uiLink:Get("LeftIntro");
    goBuffActive = uiLink:Get("goBuffActive");
    goBuffInactive = uiLink:Get("goBuffInactive");
    rectGallery = uiLink:Get("rectGallery"):GetComponent("RectTransform");
    rectTag = uiLink:Get("rectTag"):GetComponent("RectTransform");
    textTotolNumShow = uiLink:Get("textTotolNumShow"):GetComponent("Text");
    textPageShow = uiLink:Get("textPageShow"):GetComponent("Text");
    textIconName = uiLink:Get("textIconName"):GetComponent("Text");
    textIconIntro = uiLink:Get("textIconIntro"):GetComponent("Text");
    textBuffActiveTips1 = uiLink:Get("textBuffActiveTips1"):GetComponent("Text");
    textBuffActiveTips2 = uiLink:Get("textBuffActiveTips2"):GetComponent("Text");
    textBuffActiveTips3 = uiLink:Get("textBuffActiveTips3"):GetComponent("Text");
    textBuffActiveTips4 = uiLink:Get("textBuffActiveTips4"):GetComponent("Text");
    textActiveBuffEffectTips = uiLink:Get("textActiveBuffEffectTips"):GetComponent("Text");
    textBuffInactiveTips1 = uiLink:Get("textBuffInactiveTips1"):GetComponent("Text");
    textBuffInactiveTips2 = uiLink:Get("textBuffInactiveTips2"):GetComponent("Text");
    textBuffInactiveTips3 = uiLink:Get("textBuffInactiveTips3"):GetComponent("Text");
    textBuffInactiveTips4 = uiLink:Get("textBuffInactiveTips4"):GetComponent("Text");
    textInactiveBuffEffectTips = uiLink:Get("textInactiveBuffEffectTips"):GetComponent("Text");
    animator = uiLink:Get("root"):GetComponent("Animator");
    imgIcon = uiLink:Get("imgIcon"):GetComponent("Image");
    btnToNext = uiLink:Get("btnToNext"):GetComponent("Button");
    btnToBefor = uiLink:Get("btnToBefor"):GetComponent("Button");
    goeff = uiLink:Get("goeff");
    animatorBuffGroup = uiLink:Get("animatorBuffGroup"):GetComponent("Animator");
    goLockIcon=uiLink:Get("goLockIcon")
    uiLink:AddClickEvent("btnToNext", function()
        this.changNextBeforePage(1)
    end)
    uiLink:AddClickEvent("btnClickBuff", function()
        if this.unlock[this.selectCalleryTag]==1 then
            this.TrammelNet(this.selectCalleryTag);

        end
    end)
    uiLink:AddClickEvent("btnToBefor", function()
        this.changNextBeforePage(-1)
    end)
    uiLink:AddClickEvent("btnClickUnlockBuff", function()
        LuaMgr.ShowLuaPanel(UIName.CollectorPracticeShowAllTrammelsViewModel,this.mapId);
    end)
end

this.TrammelNet = function(id)
    local matchData = { OriginsId = id }
    ApiMgr.Request("fetter/activate", matchData, true, function(result)
        local re = json.decode(result);
        if re.code == 0 then
            this.unlock[id]=2;
            SetActive(goLockIcon,false);
            SetActive(goBuffInactive,false);
            SetActive(goBuffActive,true);
            DataMgr.Player.originsTalent[id] = DataMgr.Player.originsTalent[id] == nil and LuaMgr.Timestamp() or DataMgr.Player.originsTalent[id]
            SetActive(goeff,true);
            RedMgr.Singleton:UpdateClientRedData("1219_"..tostring(id), 0);
            RedMgr.Singleton:Refresh();
            LuaMgr.AddTimer(TimerConst.DelayClose, function ()
                SetActive(goeff,false);
                LuaMgr.RemoveTimer(TimerConst.DelayClose)
            end, 1, 1, false)
        end
    end, nil, true)
end

this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Middle = nil;
    RightTags = nil;
    LeftIntro = nil;
    goBuffActive = nil;
    goBuffInactive = nil;
    rectGallery = nil;
    rectTag = nil;
    textTotolNumShow = nil;
    textPageShow = nil;
    textIconName = nil;
    textIconIntro = nil;
    textBuffActiveTips1 = nil;
    textBuffActiveTips2 = nil;
    textBuffActiveTips3 = nil;
    textBuffActiveTips4 = nil;
    textActiveBuffEffectTips = nil;
    textBuffInactiveTips1 = nil;
    textBuffInactiveTips2 = nil;
    textBuffInactiveTips3 = nil;
    textBuffInactiveTips4 = nil;
    textInactiveBuffEffectTips = nil;
    imgIcon = nil;
    btnToNext = nil;
    goeff=nil;
    animatorBuffGroup=nil;
    btnToBefor = nil;
    animator=nil;
    goLockIcon=nil;
    
    
    for i = 1, #this.practiceGallerytag do
        this.practiceGallerytag[i]:Destroy();
    end

    this.practiceGallerytag = nil;
    for i = 1, #this.galleryList do
        this.galleryList[i]:Destroy();
    end
    this=nil;
end

local hook = {
    before_awake = function(vm)
        this.Init(vm.behaviour.gameObject)
        RedMgr.Singleton:RegisterViewModel(UIName.CollectorPracticeGalleryViewModel); 
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.mapId=CollectorPracticeAllMgr.currentSelectMap;
            this.CurrentSelectPage = 1;
            this.InitUnlockData();
            this.showTageList()
            this.SelectTag(this.practiceGallerytag[1].data)
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then
        end
        LuaMgr.RemoveTimer(TimerConst.DelayClose);
    end,
    before_destroy = function(vm)
        this.Clear();
    end,
}

this.ShowCollectNumText = function(key)
    local data = this.originsTalentDataMap
    local showNmu = #data[key]
    local achieveNum = 0
    for index, value in ipairs(data[key]) do
        if value.Achieve then
            achieveNum = achieveNum + 1
        end
    end
    local collShowText = ConfigMgr.LangGlobal("7127");
    textTotolNumShow.text = string.format(collShowText, tostring(achieveNum), tostring(showNmu))
end


this.showTageList = function()
    local originsTalentConfig = ConfigMgr.Config.OriginsTalentMap;
    local originsToNumSet = {};
    local originsToNumSetLength = 0;

    for key, value in pairs(originsTalentConfig) do
if value.Map == this.mapId then
            if originsToNumSet[key] == nil then
                originsToNumSet[key] = 1;
                this.originsTalentDataMap[key] = {};
                originsToNumSetLength = originsToNumSetLength + 1;
            end
        end
    end

    local index = 1


    local temp = {};
    for key, value in pairs(originsToNumSet) do
        table.insert(temp, key);
    end
    table.sort(temp, function(a, b)
        return originsTalentConfig[a].OtOrder < originsTalentConfig[b].OtOrder
    end)

    for _, value in ipairs(temp) do
        if index > #this.practiceGallerytag then
            table.insert(this.practiceGallerytag, UICollectorPracticeTag.New(rectTag))
            RedMgr.Singleton:Refresh();
        end
        SetActive(this.practiceGallerytag[index].gameObject, true)
        this.practiceGallerytag[index]:SetData(value, false,
function(data)
                this.SelectTag(data);
            end);
        index = index + 1;
    end


    for keys, value in pairs(CollectorPracticeMgr.HomeGrlleryData) do
        if originsToNumSet[value.OriginsID] ~= nil then
            table.insert(this.originsTalentDataMap[value.OriginsID], value)
        end
    end

end

this.SelectTag = function(key)
    this.CurrentSelectPage = 1;
    this.InitListShow(key);
    this.InitTextData(key);

    imgIcon.sprite = LuaMgr.GetSprite("CollectorShop", key);
    for i = 1, #this.practiceGallerytag, 1 do
        this.practiceGallerytag[i]:Select(this.practiceGallerytag[i].data == key);
    end
    this.selectCalleryTag=key;
end

this.InitUnlockData=function ()
    this.unlock={};
    local tempData={};
    for key, value in pairs(CollectorPracticeMgr.HomeGrlleryData) do
        if tempData[value.OriginsID] == nil then

            tempData[value.OriginsID] = {}
            table.insert(tempData[value.OriginsID], value)
        else
            table.insert(tempData[value.OriginsID], value)
        end
    end
    for key, value in pairs(tempData) do
        local ChildTab = tempData[key]
        local completeNum=0;

        for _Index, _value in ipairs(ChildTab) do
            if _value.Achieve then
                completeNum = completeNum + 1
            end
        end
        if completeNum==#tempData[key] then
            if  DataMgr.Player.originsTalent[key]==nil then
                this.unlock[key]=1;
            else
                this.unlock[key]=2;
            end
        else
            this.unlock[key]=0;
        end
    end
end

this.InitListShow = function(key)

    local selectTab = this.originsTalentDataMap[key]
    CollectorPracticeMgr.SortTypeTabData(selectTab)

    if selectTab == nil or #selectTab == 0 then
        return
    end
    this.ShowCollectNumText(key)
    local tableLength = #selectTab / 8
    local tableIndex = math.ceil(tableLength)
    TotolShowGroup = {}
    for i = 1, tableIndex, 1 do
        local data = { index = i, value = {} }
        table.insert(TotolShowGroup, data)
    end

    for index, value in ipairs(selectTab) do
        local tableIndex = math.ceil(index / 8)
        table.insert(TotolShowGroup[tableIndex].value, value)
    end


    this.dataIntoTab(key)
end

this.InitTextData = function(key)
    local originsTalentConfig = ConfigMgr.Config.OriginsTalentMap;
    textIconName.text = LuaMgr.GetLangText(originsTalentConfig[key].OtNameLan);
    textIconIntro.text = LuaMgr.GetLangText(originsTalentConfig[key].OtDesLan);
    local textTemp = ConfigMgr.LangGlobal("7109");
    textBuffActiveTips1.text = CNSub(textTemp, 1, 3);
    textBuffInactiveTips1.text = CNSub(textTemp, 1, 3);
    textBuffActiveTips2.text = CNSub(textTemp, 3, 5);
    textBuffInactiveTips2.text = CNSub(textTemp, 3, 5);
    textBuffActiveTips3.text = CNSub(textTemp, 5, 7);
    textBuffInactiveTips3.text = CNSub(textTemp, 5, 7);
    textBuffActiveTips4.text = CNSub(textTemp, 7, 9);
    textBuffInactiveTips4.text = CNSub(textTemp, 7, 9);
    local teleten = ConfigMgr.Config.talentBankMap
    textActiveBuffEffectTips.text = LuaMgr.GetLangText(teleten[originsTalentConfig[key].TalentId[1]].DescriptionLan)
    textInactiveBuffEffectTips.text = LuaMgr.GetLangText(teleten[originsTalentConfig[key].TalentId[1]].DescriptionLan)
    if this.unlock[key]==2 then
        SetActive(goLockIcon,false);
        SetActive(goBuffInactive,false);
        SetActive(goBuffActive,true);
        animatorBuffGroup:Play("New State",0,0);
    elseif this.unlock[key]==1 then
        SetActive(goLockIcon,true);
        SetActive(goBuffInactive,true);
        SetActive(goBuffActive,false);
        animatorBuffGroup:Play("ani_CollectorPracticeGalleryPanel_buffgroup",0,0);
    else
        SetActive(goLockIcon,true);
        SetActive(goBuffInactive,true);
        SetActive(goBuffActive,false);
        animatorBuffGroup:Play("New State",0,0);
    end
    SetActive(goeff,false);

end


this.dataIntoTab = function(key)
    SetActive(btnToBefor.gameObject, this.CurrentSelectPage - 1 > 0)
    SetActive(btnToNext.gameObject, this.CurrentSelectPage + 1 <= #TotolShowGroup)

    this.tab = {};
    for index, value in ipairs(TotolShowGroup[this.CurrentSelectPage].value) do
        table.insert(this.tab, value);
    end


    local totols = math.ceil(#TotolShowGroup)
    textPageShow.text = string.format(LuaMgr.GetLangText("CollectorPracticeGalleryViewModel_11"),
        tostring(this.CurrentSelectPage), tostring(totols))

    local listDatashow = function(tabs, listItem, rect)
        local tempList = {}
        for index, _value in ipairs(tabs) do
            table.insert(tempList, _value)
        end
        local len = #tempList;
        for i = 1, len do
            if i > #listItem then
                table.insert(listItem, UICollectorCardItem.New(rect, Vector3(0.85, 0.85, 0.85)))
            end

            SetActive(listItem[i].gameObject, true);
            listItem[i]:SetData(tempList[i], function(data)
                LuaMgr.ShowLuaPanel(UIName.CollectorPracticeGalleryTipViewModel, data, 1)
            end, true)
        end

        for i = (len + 1), #listItem do
            listItem[i]:Clear();
        end
    end

    listDatashow(this.tab, this.galleryList, rectGallery)
    this.beforeTabId = key;
    animator:Play("UI_CollectorPracticeGalleryPanel_01", 0, 0)
end

this.changNextBeforePage = function(dir)
    local totogroup = #TotolShowGroup
    if this.CurrentSelectPage + dir <= 0 then
        return
    end

    if this.CurrentSelectPage + dir > totogroup then
        return
    end

    this.CurrentSelectPage = this.CurrentSelectPage + dir
    this.dataIntoTab()
end

return vm({
    hook = hook
})