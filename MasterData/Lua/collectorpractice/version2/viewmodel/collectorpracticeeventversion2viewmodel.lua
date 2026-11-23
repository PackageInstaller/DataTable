local this = {
    nowEventId = nil,
    paramData = {},
    BuffSV = nil,
    HeroSV = nil,
    chooseBuffId = nil,
    chooseBuffIndex = nil,
    nowBuffItem = nil,
    targetBuffItem = nil,
    chooseHeroIds = {},
    chooseHeroIndexList = {},
    nowEventNo = nil,
    chooseGetHeroIds = {},
    chooseGetHeroItems = {},
    needAddHeroCount = 0,
    haveCharacterMap = {},
    needShowFirstStage = nil,
    isCanExit = false,
    reveiveHeroCount = 0,
    needReveiveHeroCount = 0,
};
require("CollectorPractice/Version2/Common/UICollectorEventHeroVersion2Item")
require("CollectorPractice/Version2/Common/UICollectorEventGetHeroVersion2Item")
require("CollectorPractice/Version2/Common/UIChooseBuffVersion2Item")
local BUFF_PREFAB_PATH = "Assets/_BundleResources/UI/CollectorPractice/Version2/UIChooseBuffVersion2Item.prefab";
local tarGameObject = nil;
local tarRect = nil;
local UICollectorEventHeroVersion2Item = nil;
local UIChooseBuffVersion2ItemPrefab = nil;
local UICollectorEventGetHeroVersion2ItemPrefab = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local goShowIntro = nil;
local goTipsGroup = nil;
local goReplaceBuff = nil;
local goReplaceBuffStep1 = nil;
local goNoNowBuff = nil;
local goReplaceBuffStep2 = nil;
local goReviveHero = nil;
local goReviveImageTips = nil;
local goNoHeroRevive = nil;
local goGetHero = nil;
local Right = nil;
local btnMask = nil;
local btnClickShowIntro = nil;
local btnClickNowBuff = nil;
local btnStep1Confirm = nil;
local rectBtnStep1GiveUp = nil;
local btnStep2Confirm = nil;
local btnReviveConfirm = nil;
local btnGetConfirm = nil;
local imgLeftBg = nil;
local imgTitleBG = nil;
local textTitle = nil;
local textIntro = nil;
local textShowIntroButton = nil;
local rectTargetBuff = nil;
local rectNowBuff = nil;
local rectGetHero = nil;
local ScrollViewBuff = nil;
local ScrollViewRevive = nil;
local textReplaceBuffTips = nil;
local textReviveTips = nil;
local textGetHeroTips = nil;
local dissolveStepController=nil;
local StageEnum = {
    ["FirstStage"] = 1,
    ["ReplaceBuff"] = 2,
    ["ReviveHero"] = 3,
    ["GetHero"] = 4,
}




this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    UICollectorEventHeroVersion2Item = uiLink:Get("UICollectorEventHeroVersion2Item");
    UICollectorEventGetHeroVersion2ItemPrefab = uiLink:Get("UICollectorEventGetHeroVersion2Item");
    root = uiLink:Get("root");
    UIChooseBuffVersion2ItemPrefab = LuaMgr.GetPrefab(BUFF_PREFAB_PATH);
    UIChooseBuffVersion2ItemPrefab:GetComponent("RectTransform"):SetParent(root:GetComponent("RectTransform"));
    SetActive(UIChooseBuffVersion2ItemPrefab,false);
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    dissolveStepController=uiLink:Get("goBG"):GetComponent(typeof(CS.Laigu.Art.UIDissolveController));
    goShowIntro = uiLink:Get("goShowIntro");
    goTipsGroup = uiLink:Get("goTipsGroup");
    goReplaceBuff = uiLink:Get("goReplaceBuff");
    goReplaceBuffStep1 = uiLink:Get("goReplaceBuffStep1");
    goNoNowBuff = uiLink:Get("goNoNowBuff");
    goReplaceBuffStep2 = uiLink:Get("goReplaceBuffStep2");
    goReviveHero = uiLink:Get("goReviveHero");
    goReviveImageTips = uiLink:Get("goReviveImageTips");
    goNoHeroRevive = uiLink:Get("goNoHeroRevive");
    goGetHero = uiLink:Get("goGetHero");
    Right = uiLink:Get("Right");
    btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    btnClickShowIntro = uiLink:Get("btnClickShowIntro"):GetComponent("Button");
    btnClickNowBuff = uiLink:Get("btnClickNowBuff"):GetComponent("Button");
    btnStep1Confirm = uiLink:Get("btnStep1Confirm"):GetComponent("Button");
    btnStep2Confirm = uiLink:Get("btnStep2Confirm"):GetComponent("Button");
    btnReviveConfirm = uiLink:Get("btnReviveConfirm"):GetComponent("Button");
    btnGetConfirm = uiLink:Get("btnGetConfirm"):GetComponent("Button");
    imgLeftBg = uiLink:Get("imgLeftBg"):GetComponent("Image");
    imgTitleBG = uiLink:Get("imgTitleBG"):GetComponent("Image");
    textTitle = uiLink:Get("textTitle"):GetComponent("Text");
    textIntro = uiLink:Get("textIntro"):GetComponent("Text");
    textShowIntroButton = uiLink:Get("textShowIntroButton"):GetComponent("Text");
    rectTargetBuff = uiLink:Get("rectTargetBuff"):GetComponent("RectTransform");
    rectNowBuff = uiLink:Get("rectNowBuff"):GetComponent("RectTransform");
    rectGetHero = uiLink:Get("rectGetHero"):GetComponent("RectTransform");
    ScrollViewBuff = uiLink:Get("ScrollViewBuff"):GetComponent("ScrollRect");
    ScrollViewRevive = uiLink:Get("ScrollViewRevive"):GetComponent("ScrollRect");
    textReplaceBuffTips = uiLink:Get("textReplaceBuffTips"):GetComponent("Text");
    textReviveTips = uiLink:Get("textReviveTips"):GetComponent("Text");
    textGetHeroTips = uiLink:Get("textGetHeroTips"):GetComponent("Text");
    rectBtnStep1GiveUp=uiLink:Get("btnStep1GiveUp"):GetComponent("RectTransform");
    uiLink:AddClickEvent("btnMask", function()
        if this.isCanExit then
            dissolveStepController.DissolveStep = 1.0;
            LuaMgr.HidePanel(UIName.CollectorPracticeEventVersion2ViewModel);







        end
    end)
    uiLink:AddClickEvent("btnClickShowIntro", function()

        local config = ConfigMgr.Config.YX2EventMap[this.nowEventId];
        local result, tips = this.CheckIsPassFirstPanel[config.EventParam[1]]();
if result then
            if this.needShowFirstStage then
                local data = {
                    EventID = this.nowEventId,
                    Index = CollectorPracticeMgrVersion2.GetNotFinishStage(),
                    EventNo = this.nowEventNo,
                }
                local Url = "practice2/start_event"
                ApiMgr.Request(Url, data, true,
                    function(result)
                        this.ShowSecondPanel[config.EventParam[1]]();
                    end, nil,
                    true
                )
            else
                this.ShowSecondPanel[config.EventParam[1]]();
            end
else
if this.needShowFirstStage then
                local confirmFun = function()
                    local data = {
                        EventID = this.nowEventId,
                        Index = CollectorPracticeMgrVersion2.GetNotFinishStage(),
                        EventNo = this.nowEventNo,
                    }
                    local Url = "practice2/start_event"
                    ApiMgr.Request(Url, data, true,
                        function(result)
                            local data = {
                                EventID = this.nowEventId,
                                EventNo = this.nowEventNo,
                                Index = CollectorPracticeMgrVersion2.GetNotFinishStage(),
                                Params = nil,
                            }
                            local Url = "practice2/end_event"
                            ApiMgr.Request(Url, data, true,
                                function(result)
                                    LuaMgr.InvokeUIEventListeners(UIEventConst.NeedRefreshState);
                                    dissolveStepController.DissolveStep = 1.0;
                                    LuaMgr.HidePanel(UIName.CollectorPracticeEventVersion2ViewModel);
LuaMgr.InvokeUIEventListeners(UIEventConst.CheckEventFinish);
                                end, nil,
                                true
                            )
                        end, nil,
                        true
                    )
                end
                LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, tips, confirmFun, nil);
            else
                local confirmFun = function()
                    local data = {
                        EventID = this.nowEventId,
                        EventNo = this.nowEventNo,
                        Index = CollectorPracticeMgrVersion2.GetNotFinishStage(),
                        Params = nil,
                    }
                    local Url = "practice2/end_event"
                    ApiMgr.Request(Url, data, true,
                        function(result)
                            LuaMgr.InvokeUIEventListeners(UIEventConst.NeedRefreshState);
dissolveStepController.DissolveStep = 1.0;
                            LuaMgr.HidePanel(UIName.CollectorPracticeEventVersion2ViewModel);
LuaMgr.InvokeUIEventListeners(UIEventConst.CheckEventFinish);
                        end, nil,
                        true
                    )
                end
                LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, tips, confirmFun, nil);
            end
        end
    end)
    uiLink:AddClickEvent("btnClickNowBuff", function()
        this.SwitchBuffPanelState(2);
    end)
    uiLink:AddClickEvent("btnStep1Confirm", function()

        this.EndReplaceBuff(false);
    end)
    uiLink:AddClickEvent("btnStep1GiveUp", function()
        local confirmFun=function ()
            this.EndReplaceBuff(true);
        end
        LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, ConfigMgr.LangGlobal("7229"), confirmFun, nil);
    end)
    uiLink:AddClickEvent("btnStep2Confirm", function()
        this.SwitchBuffPanelState(1);
    end)
    uiLink:AddClickEvent("btnReviveConfirm", function()

        this.EndReviceHero();
    end)
    uiLink:AddClickEvent("btnGetConfirm", function()

        this.EndGetHero();
    end)
end

this.EndReplaceBuff = function(isGive)
    local paramsTemp = {};
    if not isGive then
        table.insert(paramsTemp, this.chooseBuffId);
    end
    local data = {
        EventID = this.nowEventId,
        EventNo = this.nowEventNo,
        Index = CollectorPracticeMgrVersion2.GetNotFinishStage(),
        Params = (not TableIsNull(paramsTemp)) and paramsTemp or nil,
    }
    local Url = "practice2/end_event"
    ApiMgr.Request(Url, data, true,
        function(result)
            LuaMgr.InvokeUIEventListeners(UIEventConst.NeedRefreshState);
dissolveStepController.DissolveStep = 1.0;
            LuaMgr.HidePanel(UIName.CollectorPracticeEventVersion2ViewModel);
LuaMgr.InvokeUIEventListeners(UIEventConst.CheckEventFinish);
        end, nil,
        true
    )
end

this.EndGetHero = function()
    local paramsTemp = {};
    for index, value in ipairs(this.chooseGetHeroIds) do
        table.insert(paramsTemp, value);
    end
    local data = {
        EventID = this.nowEventId,
        EventNo = this.nowEventNo,
        Index = CollectorPracticeMgrVersion2.GetNotFinishStage(),
        Params = (not TableIsNull(paramsTemp)) and paramsTemp or nil,
    }
    local Url = "practice2/end_event"
    ApiMgr.Request(Url, data, true,
        function(result)
            LuaMgr.InvokeUIEventListeners(UIEventConst.NeedRefreshState);
dissolveStepController.DissolveStep = 1.0;
            LuaMgr.HidePanel(UIName.CollectorPracticeEventVersion2ViewModel);
LuaMgr.InvokeUIEventListeners(UIEventConst.CheckEventFinish);
        end, nil,
        true
    )
end

this.EndReviceHero = function()
    local paramsTemp = {};
    for index, value in ipairs(this.chooseHeroIds) do
        table.insert(paramsTemp, value);
    end
    local data = {
        EventID = this.nowEventId,
        EventNo = this.nowEventNo,
        Index = CollectorPracticeMgrVersion2.GetNotFinishStage(),
        Params = (not TableIsNull(paramsTemp)) and paramsTemp or nil,
    }
    local Url = "practice2/end_event"
    ApiMgr.Request(Url, data, true,
        function(result)
            LuaMgr.InvokeUIEventListeners(UIEventConst.NeedRefreshState);
dissolveStepController.DissolveStep = 1.0;
            LuaMgr.HidePanel(UIName.CollectorPracticeEventVersion2ViewModel);
LuaMgr.InvokeUIEventListeners(UIEventConst.CheckEventFinish);
        end, nil,
        true
    )
end

this.Clear = function()
    if this.nowBuffItem ~= nil then
        this.nowBuffItem:Destroy();
    end
    if this.targetBuffItem ~= nil then
        this.targetBuffItem:Destroy();
    end
    for index, value in ipairs(this.chooseGetHeroItems) do
        value:Destroy();
    end
    tarGameObject = nil
    tarRect = nil
    UICollectorEventHeroVersion2Item = nil;
    UIChooseBuffVersion2ItemPrefab = nil;
    UICollectorEventGetHeroVersion2ItemPrefab = nil;
    root = nil;
    Left = nil;
    Middle = nil;
    goShowIntro = nil;
    goTipsGroup = nil;
    goReplaceBuff = nil;
    goReplaceBuffStep1 = nil;
    goNoNowBuff = nil;
    goReplaceBuffStep2 = nil;
    goReviveHero = nil;
    goReviveImageTips = nil;
    goNoHeroRevive = nil;
    goGetHero = nil;
    Right = nil;
    btnMask = nil;
    btnClickShowIntro = nil;
    btnClickNowBuff = nil;
    btnStep1Confirm = nil;
    rectBtnStep1GiveUp=nil;
    btnStep2Confirm = nil;
    btnReviveConfirm = nil;
    btnGetConfirm = nil;
    imgLeftBg = nil;
    imgTitleBG = nil;
    textTitle = nil;
    textIntro = nil;
    textShowIntroButton = nil;
    rectTargetBuff = nil;
    rectNowBuff = nil;
    rectGetHero = nil;
    ScrollViewBuff = nil;
    ScrollViewRevive = nil;
    textReplaceBuffTips = nil;
    textReviveTips = nil;
    textGetHeroTips = nil;
    dissolveStepController=nil;
    this = nil;
end


this.InitData = function(data)
    this.chooseBuffId = nil;
    this.chooseBuffIndex = nil;
    this.chooseHeroIds = {};
    this.chooseHeroIndexList = {};
    this.chooseGetHeroIds = {};
    this.isCanExit = false;
    this.nowEventId = data.nowEventId;
this.nowEventNo = data.nowEventNo;
    this.needShowFirstStage = data.needShowFirstStage;
    this.haveCharacterMap = {};
this.reveiveHeroCount = 0;
this.needAddHeroCount = 0;
    for key, value in pairs(DataMgr.Player.practiceStage2.members) do
        this.haveCharacterMap[value.ID] = true;
    end
end

this.InitPanel = function(data)
    local nowEventId = data.nowEventId;

    local config = ConfigMgr.Config.YX2EventMap[nowEventId];
    imgLeftBg.sprite = LuaMgr.GetSprite("CollectorEventVersion2", config.EventPic);

    this.ShowSecondPanel["firstPanel"]()
end

this.ShowSVResult = function(targetSV, targetScrollView, scrollDatas, objectWidth, objectHigh, scrollWidth)
    local addWidth = LuaMgr.GetScreenAddWidth();
    local scrollWidth = scrollWidth;
    local needWidth = objectWidth * (#scrollDatas);
    targetSV:SetParams(needWidth < scrollWidth and needWidth or scrollWidth, objectHigh);
if needWidth >= scrollWidth then
        targetScrollView.movementType = CS.UnityEngine.UI.ScrollRect.MovementType.Elastic;
    else
        targetScrollView.movementType = CS.UnityEngine.UI.ScrollRect.MovementType.Clamped;
    end
    targetSV:SetData(scrollDatas);
    targetSV:MoveToIndex(math.ceil(#scrollDatas / 2), true);
    targetSV:Refresh()
end

this.RefreshFirstPanel = function(nowEventId)
    local config = ConfigMgr.Config.YX2EventMap[nowEventId];
    imgTitleBG.sprite = LuaMgr.GetSprite("CollectorEventVersion2", config.EventTitlePic);
    textTitle.text = LuaMgr.GetLangText(config.EventNameLan);
    textIntro.text = LuaMgr.GetLangText(config.EventDesLan);
    textShowIntroButton.text = LuaMgr.GetLangText(config.EventOptionLan);
end



this.RefreshReplaceBuffPanel = function()
    local targetId = DataMgr.Player.practiceStage2.chooseBuffs[1];
    if this.targetBuffItem == nil then
        local temp = UIChooseBuffVersion2Item.New();
        temp.gameObject = LuaMgr.InstantiateGO(UIChooseBuffVersion2ItemPrefab, rectTargetBuff, false)
        temp:Init();
        this.targetBuffItem = temp;
        this.targetBuffItem.gameObject:GetComponent("RectTransform").anchoredPosition = Vector2(0, 0);
    end
    local data = {
        data = {},
    };
    data.data = table.Copy(CollectorPracticeMgrVersion2.GetBuffValueById(targetId));
    data.data.fun = nil;
    data.data.isChoose = false;
    data.data.groupIndex = 0;
    this.targetBuffItem:SetData(data);
    this.SwitchBuffPanelState(1);
end

this.RefreshNowBuff = function()
    if this.chooseBuffId == nil then
        SetActive(goNoNowBuff, true);
    else
        SetActive(goNoNowBuff, false);
        if this.nowBuffItem == nil then
            local temp = UIChooseBuffVersion2Item.New();
            temp.gameObject = LuaMgr.InstantiateGO(UIChooseBuffVersion2ItemPrefab, rectNowBuff, false)
            temp:Init();
            this.nowBuffItem = temp;
            this.nowBuffItem.gameObject:GetComponent("RectTransform").anchoredPosition = Vector2(0, 0);
            btnClickNowBuff.gameObject:GetComponent("RectTransform"):SetAsLastSibling();
        end
        local data = {
            data = {},
        };
        data.data = table.Copy(CollectorPracticeMgrVersion2.GetBuffValueById(this.chooseBuffId));
        data.data.fun = nil;
        data.data.isChoose = false;
        data.data.groupIndex = 0;
        this.nowBuffItem:SetData(data);
    end
end

this.SwitchBuffPanelState = function(state)
    this.CheckReplaceBuffButtonState();
    if state == 1 then
        SetActive(goReplaceBuffStep1, true);
        SetActive(goReplaceBuffStep2, false);
        this.RefreshNowBuff();
    elseif state == 2 then
        this.RefreshBuffSV();
        this.chooseBuffId = nil;
        this.chooseBuffIndex = -1;
        SetActive(goReplaceBuffStep1, false);
        SetActive(goReplaceBuffStep2, true);
    end
end



this.ClickBuffItem = function(itemOBJ)
if this.chooseBuffId == nil then
        this.chooseBuffId = itemOBJ.data.Id;
        this.chooseBuffIndex = itemOBJ.data.groupIndex;
        this.BuffSV.dataList[itemOBJ.data.groupIndex].data.isChoose = true;
        this.BuffSV:Refresh();
    else
if itemOBJ.data.groupIndex == this.chooseBuffIndex then
            this.BuffSV.dataList[itemOBJ.data.groupIndex].data.isChoose = false;
            this.chooseBuffId = nil;
            this.chooseBuffIndex = -1;
            this.BuffSV:Refresh();
        else
            this.BuffSV.dataList[this.chooseBuffIndex].data.isChoose = false;
            this.chooseBuffId = itemOBJ.data.Id;
            this.chooseBuffIndex = itemOBJ.data.groupIndex;
            this.BuffSV.dataList[this.chooseBuffIndex].data.isChoose = true;
            this.BuffSV:Refresh();
        end
    end
    this.CheckReplaceBuffButtonState();
end

this.CheckReplaceBuffButtonState = function()
    SetActive(btnStep1Confirm.gameObject, this.chooseBuffId ~= nil);
    SetActive(btnStep2Confirm.gameObject, this.chooseBuffId ~= nil);

end

this.RefreshBuffSV = function()
    this.BuffSV:Clear(false);
    local scrollDatas = this.GetBuffScrollViewData();
    this.ShowSVResult(this.BuffSV, ScrollViewBuff, scrollDatas, 305, 464, 882.4998);
end


this.GetBuffScrollViewData = function()
    local data = DataMgr.Player.practiceStage2.buffs;
    local scrollData = nil;
    local scrollDatas = {};

    local tempData = {};
    local trueIndex=1;
    for index, value in ipairs(data) do
if (this.chooseBuffId == nil or value ~= this.chooseBuffId) and CollectorPracticeMgrVersion2.NormalBuffMap[value] ~= nil then
            tempData = table.Copy(CollectorPracticeMgrVersion2.NormalBuffMap[value]);
            tempData.fun = this.ClickBuffItem;
            tempData.isChoose = false;
            tempData.groupIndex = trueIndex;
            tempData.scrollRect=ScrollViewBuff;
            scrollData = UIScrollData.GetData(UIChooseBuffVersion2ItemPrefab, "UIChooseBuffVersion2Item", 305,
                464, tempData);
            table.insert(scrollDatas, scrollData);
            trueIndex=trueIndex+1;
        end
    end
    return scrollDatas;
end



this.RefreshReviveHeroPanel = function()
    local deadHero = {};
    local data = DataMgr.Player.practiceStage2.members;
    this.needReveiveHeroCount = tonumber(ConfigMgr.Config.YX2EventMap[this.nowEventId].EventParam[2]);
    for index, value in ipairs(data) do
        if value.State == 1 then
            table.insert(deadHero, value.ID);
        end
    end
    if #deadHero == 0 then
        SetActive(goNoHeroRevive, true);
        SetActive(goReviveImageTips, true);
        SetActive(ScrollViewRevive.gameObject, false);
    else
        SetActive(goNoHeroRevive, false);
        SetActive(goReviveImageTips, false);
        SetActive(ScrollViewRevive.gameObject, true);
        this.RefreshHeroSV(deadHero);
        this.CheckHeroSVButtonState();
    end
end

this.ClickReviveHeroItem = function(itemOBJ)
if this.needReveiveHeroCount == 1 then
if TableIsNull(this.chooseHeroIds) then
            table.insert(this.chooseHeroIds, itemOBJ.data.heroId);
            table.insert(this.chooseHeroIndexList, itemOBJ.data.groupIndex);
            this.HeroSV.dataList[itemOBJ.data.groupIndex].data.isChoose = true;
            this.HeroSV:Refresh();
        else
if itemOBJ.data.groupIndex == this.chooseHeroIndexList[1] then
                this.HeroSV.dataList[itemOBJ.data.groupIndex].data.isChoose = false;
                table.remove(this.chooseHeroIds, 1);
                table.remove(this.chooseHeroIndexList, 1);
                this.HeroSV:Refresh();
            else
                this.HeroSV.dataList[this.chooseHeroIndexList[1]].data.isChoose = false;
                this.chooseHeroIds[1] = itemOBJ.data.heroId;
                this.chooseHeroIndexList[1] = itemOBJ.data.groupIndex;
                this.HeroSV.dataList[itemOBJ.data.groupIndex].data.isChoose = true;
                this.HeroSV:Refresh();
            end
        end
    else
        local isReply = false;
        local replyIndex = 0;
        for index, value in ipairs(this.chooseHeroIndexList) do
            if value == itemOBJ.data.groupIndex then
                isReply = true;
                replyIndex = index;
                break;
            end
        end
if isReply then
            table.remove(this.chooseHeroIds, replyIndex);
            table.remove(this.chooseHeroIndexList, replyIndex);
            this.HeroSV.dataList[itemOBJ.data.groupIndex].data.isChoose = false;
            this.HeroSV:Refresh();
else
            if #this.chooseHeroIds < this.needReveiveHeroCount then
                table.insert(this.chooseHeroIds, itemOBJ.data.Id);
                table.insert(this.chooseHeroIndexList, itemOBJ.data.groupIndex);
                this.HeroSV.dataList[itemOBJ.data.groupIndex].data.isChoose = true;
                this.HeroSV:Refresh();
            end
        end
    end

    this.CheckHeroSVButtonState();
end

this.CheckHeroSVButtonState = function()
    SetActive(btnReviveConfirm.gameObject, #this.chooseHeroIds == this.needReveiveHeroCount);
end

this.RefreshHeroSV = function(deadHero)
    this.HeroSV:Clear(false);
    local scrollDatas = this.GetHeroScrollViewData(deadHero);
    this.ShowSVResult(this.HeroSV, ScrollViewRevive, scrollDatas, 191, 342, 688);
end


this.GetHeroScrollViewData = function(deadHero)
    local data = deadHero;
    local scrollData = nil;
    local scrollDatas = {};

    for index, value in ipairs(data) do
        local tempData = {};
        tempData.heroId = value;
        tempData.fun = this.ClickReviveHeroItem;
        tempData.isChoose = false;
        tempData.groupIndex = index;
        scrollData = UIScrollData.GetData(UICollectorEventHeroVersion2Item, "UICollectorEventHeroVersion2Item", 191,
            308, tempData);
        table.insert(scrollDatas, scrollData);
    end
    return scrollDatas;
end



this.RefreshGetHeroPanel = function()
    local needAddHeroCount = tonumber(ConfigMgr.Config.YX2EventMap[this.nowEventId].EventParam[2]);
    this.needAddHeroCount = needAddHeroCount;
    for i = 1, needAddHeroCount, 1 do
        if i > #this.chooseGetHeroItems then
            local temp = UICollectorEventGetHeroVersion2Item.New(UICollectorEventGetHeroVersion2ItemPrefab, rectGetHero);
            table.insert(this.chooseGetHeroItems, temp);
        end
        local data = {};
        data.heroId = this.chooseGetHeroIds[i];
        data.fun = this.ClickGetHeroItem;
        this.chooseGetHeroItems[i]:SetData(data);
    end
    for i = needAddHeroCount + 1, #this.chooseGetHeroItems, 1 do
        this.chooseGetHeroItems[i]:Hide();
    end
    this.CheckGetHeroButtonState();
end

this.ClickGetHeroItem = function(itemObject)
    local extendParams = {};
    local lockCharacterList = {};
    for index, value in pairs(DataMgr.Player.characters) do
        if this.haveCharacterMap[value.id] then
            goto continue;
        end
        table.insert(lockCharacterList, {
            heroId = value.id
        });
        ::continue::
    end
    if this.needAddHeroCount == 1 then

        HeroParameter.InitCommonOpenSelectOneCharacter(this.chooseGetHeroIds[1], {}, nil, true, lockCharacterList,
            extendParams, this.FinshGetHeroCallBack,{},this.FailGetHeroCallBack);
    else

        HeroParameter.InitCommonOpenSelectQuickCharacter(this.chooseGetHeroIds, this.needAddHeroCount, true,
            lockCharacterList, extendParams, this.FinshGetHeroCallBack,{},this.FailGetHeroCallBack);
    end
    tarRect.anchoredPosition = Vector2(tarRect.anchoredPosition.x, tarRect.anchoredPosition.y + 5000);
    CollectorPracticeMgrVersion2.DeemNotLevelMainScene = true;
    LuaMgr.ShowLuaPanel(UIName.HeroChoiceViewModel);
end

this.CheckGetHeroButtonState = function()
    local needAddHeroCount = tonumber(ConfigMgr.Config.YX2EventMap[this.nowEventId].EventParam[2]);
    SetActive(btnGetConfirm.gameObject, #this.chooseGetHeroIds == needAddHeroCount)
end


this.FinshGetHeroCallBack = function(extendParams, battleMembers)
    tarRect.anchoredPosition = Vector2(0, 0);
    this.chooseGetHeroIds = battleMembers;
    local needDeleteIndex={};
    for index, value in ipairs(this.chooseGetHeroIds) do
        if IsNullOrEmpty(value) then
            table.insert(needDeleteIndex,index);
        end
    end
    for i = #needDeleteIndex, 1, -1 do
        table.remove(this.chooseGetHeroIds,needDeleteIndex[i]);
    end
    this.RefreshGetHeroPanel();
end
this.FailGetHeroCallBack = function(extendParams)
    tarRect.anchoredPosition = Vector2(0, 0);
end

this.OpenBattle = function(eventType, stageId)
CollectorPracticeMgrVersion2.IsOpenBattlePanel = true;
    local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
    enterDungeonParams.eventId = stageId
    enterDungeonParams.dungeonId = stageId
    enterDungeonParams.themeId = CollectorPracticeAllMgr.currentMap;
    enterDungeonParams.eventType2 = eventType
    local extraList = {};
    table.insert(extraList, CollectorPracticeAllMgr.currentMap);
    table.insert(extraList, eventType);
    if not IsNull(DataMgr.Player.practiceStage2.buffs) then
        for i, v in ipairs(DataMgr.Player.practiceStage2.buffs) do
            table.insert(extraList, v)
        end
    end
table.insert(extraList, "NEED_SEND_ROLEHPMAP")
    table.insert(extraList, "YX2")
    enterDungeonParams.panelExtendParams = {};
    enterDungeonParams.panelExtendParams.type = "YX2";
    enterDungeonParams.panelExtendParams.isLockCharacter = true;
    enterDungeonParams.panelExtendParams.lockCharacterList = {};
    local data = DataMgr.Player.practiceStage2.members;
    for key, value in pairs(data) do
        if value.State ~= 1 then
            table.insert(enterDungeonParams.panelExtendParams.lockCharacterList, {
                heroId = value.ID
            });
        end
    end
    enterDungeonParams.extraParams = extraList

    BattlePrepareMgr.BattlePrepare(enterDungeonParams)
end


this.ShowSecondPanel = {
    ["firstPanel"] = function()
        this.isCanExit = true;
        this.OpenStagePanel(StageEnum["FirstStage"])
    end,
    ["boss"] = function()
        this.isCanExit = false;
        this.OpenBattle("boss", ConfigMgr.Config.YX2EventMap[this.nowEventId].EventParam[2])
dissolveStepController.DissolveStep = 1.0;
        LuaMgr.HidePanel(UIName.CollectorPracticeEventVersion2ViewModel);
    end,
    ["monster1"] = function()
        this.isCanExit = false;
        this.OpenBattle("monster1", ConfigMgr.Config.YX2EventMap[this.nowEventId].EventParam[2])
dissolveStepController.DissolveStep = 1.0;
        LuaMgr.HidePanel(UIName.CollectorPracticeEventVersion2ViewModel);
    end,
    ["monster2"] = function()
        this.isCanExit = false;
        this.OpenBattle("monster2", ConfigMgr.Config.YX2EventMap[this.nowEventId].EventParam[2])
dissolveStepController.DissolveStep = 1.0;
        LuaMgr.HidePanel(UIName.CollectorPracticeEventVersion2ViewModel);
    end,
["buffget"] = function()
        this.isCanExit = false;
        LuaMgr.ShowLuaPanel(UIName.CollectorPracticeChooseBuffVersion2ViewModel, true);
dissolveStepController.DissolveStep = 1.0;
        LuaMgr.HidePanel(UIName.CollectorPracticeEventVersion2ViewModel);
    end,
    ["buffchange"] = function()
        this.isCanExit = false;
        this.OpenStagePanel(StageEnum["ReplaceBuff"]);
    end,
    ["characterget"] = function()
        this.isCanExit = false;
        this.OpenStagePanel(StageEnum["GetHero"]);
    end,
    ["characterreborn"] = function()
        this.isCanExit = false;
        this.OpenStagePanel(StageEnum["ReviveHero"]);
    end,
}

this.CheckIsPassFirstPanel = {
    ["firstPanel"] = function()
return true;
    end,
    ["boss"] = function()
return true;
    end,
    ["monster1"] = function()
return true;
    end,
    ["monster2"] = function()
return true;
    end,
["buffget"] = function()
return true;
    end,
    ["buffchange"] = function()
        if #DataMgr.Player.practiceStage2.buffs == 0 then
            return false, ConfigMgr.LangGlobal("7215");
        else
            return true;
        end
    end,
    ["characterget"] = function()
        local characterCount = 0;
        for key, value in pairs(DataMgr.Player.characters) do
            characterCount = characterCount + 1;
        end
        if #DataMgr.Player.practiceStage2.members + 1 > characterCount then
            return false, ConfigMgr.LangGlobal("7214");
        else
            return true;
        end
    end,
    ["characterreborn"] = function()
return true;
    end,
}


this.OpenStagePanel = function(stage)

    if stage == StageEnum["FirstStage"] then
        SetActive(goShowIntro, true);
        SetActive(goReplaceBuff, false);
        SetActive(goReviveHero, false);
        SetActive(goGetHero, false);
        this.RefreshFirstPanel(this.nowEventId);
    elseif stage == StageEnum["ReplaceBuff"] then
        SetActive(goShowIntro, false);
        SetActive(goReplaceBuff, true);
        SetActive(goReviveHero, false);
        SetActive(goGetHero, false);
        textReplaceBuffTips.text = string.format(ConfigMgr.LangGlobal("7211"), GetChineseBigNumber(1));
        this.RefreshReplaceBuffPanel();
    elseif stage == StageEnum["ReviveHero"] then
        SetActive(goShowIntro, false);
        SetActive(goReplaceBuff, false);
        SetActive(goReviveHero, true);
        SetActive(goGetHero, false);
        local config = ConfigMgr.Config.YX2EventMap[this.nowEventId];
        textReviveTips.text = string.format(ConfigMgr.LangGlobal("7212"),
            GetChineseBigNumber(tonumber(config.EventParam[2])));
        this.RefreshReviveHeroPanel();
    elseif stage == StageEnum["GetHero"] then
        SetActive(goShowIntro, false);
        SetActive(goReplaceBuff, false);
        SetActive(goReviveHero, false);
        SetActive(goGetHero, true);
        textGetHeroTips.text = ConfigMgr.LangGlobal("7216");
        this.RefreshGetHeroPanel();
    end
end





local hook = {
    before_awake = function(vm)
        this.Init(vm.behaviour.gameObject)
        LuaMgr.AddPrefabRefCount(BUFF_PREFAB_PATH);
        this.BuffSV = UIScrollView.New(ScrollViewBuff.gameObject);
        this.HeroSV = UIScrollView.New(ScrollViewRevive.gameObject);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.paramData = vm.behaviour.Params[0];
        this.InitData(this.paramData);
        this.InitPanel(this.paramData);
LuaMgr.InvokeUIEventListeners(UIEventConst.NeedSaveData);
    end,
    before_deactive = function(vm)
        if vm.behaviour.Params ~= nil then
            this.BuffSV:Clear(true);
            this.HeroSV:Clear(true);
            
        end
    end,
    before_destroy = function(vm)
        LuaMgr.RemovePrefabRefCount(BUFF_PREFAB_PATH);
        this.Clear();
        UIScrollView.ClearItem("UIChooseBuffVersion2Item");
        UIScrollView.ClearItem("UICollectorEventHeroVersion2Item");
    end,
}

return vm({
    hook = hook
})