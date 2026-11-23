





local this = {
    vm=nil;
};
require("ViewModel/Shop/UISkinPicItem")
require("ViewModel/Shop/UISkinPicBtn")
require("ViewModel/Shop/UISkinGridItem")

local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Middle = nil;
local scrollView = nil;
local rectScrollView = nil;
local rectBtnContent = nil;
local rectContent=nil;
local uiSkinPicBtn=nil;
local rareBtns={};
local skinRareData={};
local uiSkinGridItem=nil;
local gridLayoutGroup=nil;
local currRare=nil;
local goIsOn=nil;
local goIsOn2 = nil
local lastWidth=nil;
local lastHeight=nil
local scrollPosition=nil;
local cloneNum = 0;
local goNothing = nil;

this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Middle = uiLink:Get("Middle");
    uiSkinPicBtn=uiLink:Get("UISkinPicBtn");
    rectScrollView = uiLink:Get("ScrollView"):GetComponent("RectTransform");
    scrollView = UIScrollView.New(rectScrollView.gameObject)
    rectContent=uiLink:Get("rectContent"):GetComponent("RectTransform");
    uiSkinGridItem=uiLink:Get("UISkinGridItem"):GetComponent("RectTransform");
    rectBtnContent=uiLink:Get("rectBtnContent"):GetComponent("RectTransform");
    gridLayoutGroup=uiLink:Get("UISkinGridItem"):GetComponent("GridLayoutGroup");
    goIsOn=uiLink:Get("goIsOn");
    goIsOn2=uiLink:Get("goIsOn2");
    goNothing=uiLink:Get("goNothing");
    
    uiLink:AddClickEvent("btnGetHave",function()
        SetActive(goIsOn, not goIsOn.activeSelf)
         if(goIsOn.activeSelf)then
            SetActive(goIsOn2, false)
        end
        this.UpdateUI(currRare);
    end)
    uiLink:AddClickEvent("btnDontHave",function()
        SetActive(goIsOn2, not goIsOn2.activeSelf)
        if(goIsOn2.activeSelf)then
            SetActive(goIsOn, false)
        end
        this.UpdateUI(currRare);
    end)
    uiLink:AddClickEvent("btnFeature",function()
        LuaMgr.ShowLuaPanel(UIName.FilterSkinPopup)
    end)
    
    SetActive(uiSkinPicBtn,false);
end


this.Clear = function()

    for i = 1, #rareBtns do
        rareBtns[i]:Destroy();
    end
    
    
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Middle = nil;
    rectScrollView = nil;
    scrollView=nil;
    rectContent = nil;
    uiSkinPicBtn = nil;
    uiSkinGridItem = nil;
    goIsOn=nil;
    goIsOn2 = nil
    scrollPosition=nil;
    goNothing = nil;
end

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour.gameObject)
    end ,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end

        vm.behaviour:UpdateTopBar("", this.OnBack);
        
        if not this.vm.behaviour.IsPop then
            HeroParameter.CurSkinLog = nil
            HeroParameter.CurSkinIndex = nil
        end
        
        local addWidth = LuaMgr.GetScreenAddWidth();





lastWidth = 1212 + addWidth
lastHeight = rectScrollView.rect.height
        rectScrollView.pivot = Vector2(0.5, 0.5);
        rectScrollView.anchorMax = Vector2(0.5, 0.5);
        rectScrollView.anchorMin = Vector2(0.5, 0.5);
        rectScrollView.anchoredPosition = Vector2(0, rectScrollView.anchoredPosition.y);
        uiSkinGridItem.sizeDelta = Vector2(lastWidth, uiSkinGridItem.anchoredPosition.y);

        
        local calcWith = lastWidth-gridLayoutGroup.padding.left;
        cloneNum = 0;
        while (cloneNum<=10 and calcWith >= gridLayoutGroup.cellSize.x ) do
            calcWith=calcWith-gridLayoutGroup.cellSize.x;
            calcWith=calcWith-gridLayoutGroup.spacing.x;
cloneNum=cloneNum+1;
        end
        
        this.UpdateUI(currRare);
        
        if scrollPosition ~= nil and this.vm.behaviour.IsPop then

            coroutine_runner.start(
                    function()
                        coroutine_runner.wait(0.02)
                        scrollView.content.anchoredPosition = scrollPosition
                    end )

        end
        LuaMgr.AddUIEventListener(UIEventConst.FilterSkinUpdate, this.FilterSkin)
    end ,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        scrollView:Clear(true)
        scrollPosition = scrollView.content.anchoredPosition;
        LuaMgr.RemoveUIEventListener(UIEventConst.FilterSkinUpdate, this.FilterSkin)
    end,
    before_destroy=function()
        this.Clear()
        UIScrollView.ClearItem("UISkinGridItem")
        UIScrollView.ClearItem("UISkinPicItem")
    end
}

this.OnBack=function()
    LuaMgr.Back();
    currRare = nil
    SetActive(goIsOn, false)
    SetActive(goIsOn2, false)
end

this.UpdateUI=function(rare)
    currRare=(rare~=nil and rare or 1)
    local sysTime = LuaMgr.Timestamp();
    local characterSkins= ConfigMgr.Config.characterSkins;
    local itemList={}
    local cha = nil
    local skinConfig = nil
    if characterSkins~=nil then
        for key, value in pairs(characterSkins) do
            cha = ConfigMgr.Config.characterTable[key]
            if  cha ~= nil then
                for i = 1, #value do
                    skinConfig = value[i];
                    if (sysTime > skinConfig.UnlockDate) then
if skinConfig.skinType == 3 then
if skinRareData[cha.rare] == nil then
                                skinRareData[cha.rare] = cha.rare;
                            end
                            if currRare <=1 or cha.rare==currRare  then
                                local _isGetHave=DataHelper.IsContainsSkin(key, skinConfig.skinID);
                                local canInsert=false;
                                if (not goIsOn.activeSelf) and (not goIsOn2.activeSelf)then
                                    canInsert=true;
                                end
                                if (goIsOn.activeSelf and _isGetHave) then
                                    canInsert=true;
                                end
                                if (goIsOn2.activeSelf and not _isGetHave) then
                                    canInsert=true;
                                end
                                if(canInsert) then
                                    if HeroParameter.CurSkinLog == nil or HeroParameter.CurSkinLog == skinConfig.skinLOGO then
                                        local skinValue={
                                            characterId=key,
                                            character=cha,
                                            skinData=skinConfig,
                                            isGetHave=_isGetHave;
                                        }
                                        table.insert(itemList,skinValue);
                                    end
                                end
                            end
                        end
                    end
                end
            else
                print('character is nil, ' .. key)
            end
        end
    end

    if skinRareData[1] == nil then
        skinRareData[1] = 1;
    end

    local btnIndex=0;
    for key, value in pairs(skinRareData) do
        btnIndex=btnIndex+1;
        if btnIndex> #rareBtns then
            table.insert(rareBtns,UISkinPicBtn.New(uiSkinPicBtn,rectBtnContent))
        end

        SetActive(rareBtns[btnIndex].gameObject,true);
        rareBtns[btnIndex].gameObject.name=tostring(value)
        rareBtns[btnIndex]:SetData(value, value == currRare,  function(data)
            this.UpdateUI(data)
        end);
    end

    for i = btnIndex+1, #rareBtns do
        rareBtns[i]:Clear();
    end

    table.sort(itemList,function(a,b)
        if a.character.rare==b.character.rare then
            return a.skinData.skinID < b.skinData.skinID;
        else
            return a.character.rare < b.character.rare;
        end
    end )

    local scrollDatas = {}
    local maxLength=#itemList;
    local index = 0
    while (index <= maxLength) do
        local groupData = {}
        groupData.datas = {};
        groupData.lastWidth=lastWidth;

        local fun = function(data)
            if data == nil then
                return;
            end

            ComData.skipJump=1;
            if FeatureManager.IsLock("1011") then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, FeatureManager.TipStr("1011"))
            else
                LuaMgr.ShowLuaPanel(UIName.HeroSkinViewModel,data.characterId, data.skinID)
            end
        end

        groupData.fun = fun;

        for i = 1, cloneNum do
            local data=itemList[index+i]
            if data ~= nil then
                table.insert(groupData.datas,data)
            else
                break;
            end
        end

        if #groupData.datas>0 then
            local scrollData = UIScrollData.GetData(uiSkinGridItem.gameObject, "UISkinGridItem", lastWidth, 402, groupData)
            table.insert(scrollDatas, scrollData)
        end

        index = index + cloneNum
    end

    scrollView:SetParams(lastWidth, lastHeight)
    scrollView:SetData(scrollDatas, true)
    SetActive(goNothing,#scrollDatas<=0);
end

this.FilterSkin = function()
    this.UpdateUI(currRare);
end

return vm({
    hook = hook
})