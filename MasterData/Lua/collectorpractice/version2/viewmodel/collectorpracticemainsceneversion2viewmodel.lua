local this = {
    rectEventPos = {},
    nowEventLength = 0,
    eventItemList = {},
    lineItemList = {},
    buffItemList = {},
    characterItemList = {},
    startDotween=nil,
    startAnimationCoo=nil,
};
require("CollectorPractice/Version2/Common/UICollectorMainSceneEventVersion2Item")
require("CollectorPractice/Version2/Common/UICollectorMainSceneLineVersion2Item")
require("CollectorPractice/Version2/Common/UICollectorMainSceneCharacterVersion2Item")
require("CollectorPractice/Version2/Common/UICollectorMainSceneBuffVersion2Item")
local tarGameObject = nil;
local tarRect = nil;
local UICollectorMainSceneEventVersion2ItemPrefab = nil;
local UICollectorMainSceneLineVersion2ItemPrefab = nil;
local UICollectorMainSceneCharacterVersion2ItemPrefab = nil;
local UICollectorMainSceneBuffVersion2ItemPrefab = nil;
local root = nil;
local Left = nil;
local Right = nil;
local goShowBuffGroup = nil;
local ScrollViewBuild = nil;
local rectContent = nil;
local rectLineGroup = nil;
local rectEventGroup = nil;
local rectNowPos = nil;
local rectCharacterGroup = nil;
local rectBuffGroup = nil;
local imgNowPos = nil;
local btnSettlement=nil;

this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    UICollectorMainSceneEventVersion2ItemPrefab = uiLink:Get("UICollectorMainSceneEventVersion2Item");
    UICollectorMainSceneLineVersion2ItemPrefab = uiLink:Get("UICollectorMainSceneLineVersion2Item");
    UICollectorMainSceneCharacterVersion2ItemPrefab = uiLink:Get("UICollectorMainSceneCharacterVersion2Item");
    UICollectorMainSceneBuffVersion2ItemPrefab = uiLink:Get("UICollectorMainSceneBuffVersion2Item");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Right = uiLink:Get("Right");
    goShowBuffGroup = uiLink:Get("goShowBuffGroup");
    ScrollViewBuild = uiLink:Get("ScrollViewBuild"):GetComponent("ScrollRect");
    rectContent = uiLink:Get("rectContent"):GetComponent("RectTransform");
    rectLineGroup = uiLink:Get("rectLineGroup"):GetComponent("RectTransform");
    rectEventGroup = uiLink:Get("rectEventGroup"):GetComponent("RectTransform");
    rectNowPos = uiLink:Get("rectNowPos"):GetComponent("RectTransform");
    rectCharacterGroup = uiLink:Get("rectCharacterGroup"):GetComponent("RectTransform");
    rectBuffGroup = uiLink:Get("rectBuffGroup"):GetComponent("RectTransform");
    imgNowPos = uiLink:Get("rectNowPos"):GetComponent("Image");
    uiLink:AddClickEvent("btnSettlement", function()
        local fun=function ()
            this.SettlementHelpFun(false);
        end
        LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, ConfigMgr.LangGlobal("7227"), fun, nil);
    end);
end


this.Clear = function()
    for index, value in ipairs(this.buffItemList) do
        value:Destroy();
    end
    for index, value in ipairs(this.eventItemList) do
        value:Destroy();
    end
    for index, value in ipairs(this.characterItemList) do
        value:Destroy();
    end
    for index, value in ipairs(this.lineItemList) do
        value:Destroy();
    end
    tarGameObject = nil
    tarRect = nil
    UICollectorMainSceneEventVersion2ItemPrefab = nil;
    UICollectorMainSceneLineVersion2ItemPrefab = nil;
    UICollectorMainSceneCharacterVersion2ItemPrefab = nil;
    UICollectorMainSceneBuffVersion2ItemPrefab = nil;
    root = nil;
    Left = nil;
    Right = nil;
    goShowBuffGroup = nil;
    ScrollViewBuild = nil;
    rectContent = nil;
    rectLineGroup = nil;
    rectEventGroup = nil;
    rectNowPos = nil;
    rectCharacterGroup = nil;
    rectBuffGroup = nil;
    imgNowPos = nil;
    btnSettlement=nil;
    this=nil;
end

this.AwakeInitData = function()
    this.rectEventPos = {};

    for i = 1, #DataMgr.Player.practiceStage2.stages, 1 do
        local object=rectEventGroup:Find("EventNo" .. tostring(i));
        if IsObjectNull(object) then
            local targetPrefab=this.rectEventPos[1].gameObject;
            local tempObject=LuaMgr.InstantiateGO(targetPrefab, rectEventGroup, false);

            tempObject.name=("EventNo" .. tostring(i));
            table.insert(this.rectEventPos, object:GetComponent("RectTransform"));
        else
            table.insert(this.rectEventPos, object:GetComponent("RectTransform"));
        end
        local poolId=DataMgr.Player.practiceStage2.poolId
local config=CollectorPracticeMgrVersion2.EventPoolIdToEventNumberValue[poolId][i-1].EventCo;
        if not TableIsNull(config) then
            this.rectEventPos[i].anchoredPosition=Vector2(config[1],config[2])
        end
    end
    this.nowEventLength = #this.rectEventPos;
end

this.InitData = function()
    if this.nowEventLength ~= (#DataMgr.Player.practiceStage2.stages) then
        this.AwakeInitData();
    end
end

this.InitPanel = function()
    if DataMgr.Player.sex == 1 then
        imgNowPos.sprite = LuaMgr.GetSprite("CollectorMainSceneVersion2", "tui_sx_jy_tx1");
    else
        imgNowPos.sprite = LuaMgr.GetSprite("CollectorMainSceneVersion2", "ui_sx_jy_tx2");
    end

    for i = 1, this.nowEventLength, 1 do
        if i > #this.eventItemList then
            local temp = UICollectorMainSceneEventVersion2Item.New(UICollectorMainSceneEventVersion2ItemPrefab,
                this.rectEventPos[i]);
            table.insert(this.eventItemList, temp);
        end
        if i==1 then
            this.eventItemList[i]:SetData(0,"start");
        else
            this.eventItemList[i]:SetData(DataMgr.Player.practiceStage2.stages[i].EventNo,DataMgr.Player.practiceStage2.stages[i].EventID);
        end
    end
    for i = this.nowEventLength + 1, #this.eventItemList, 1 do
        this.eventItemList[i]:Hide();
    end
    rectContent.sizeDelta=Vector2(this.rectEventPos[#this.rectEventPos].anchoredPosition.x+300,720);
    this.RefreshPanel();
end

this.RefreshPanel = function()
local nowNo = DataMgr.Player.practiceStage2.crtEventNo+1;
    local nextPoint = DataMgr.Player.practiceStage2.stages[nowNo].NextEventNo;
if  DataMgr.Player.practiceStage2.stages[nowNo].State==1 then
this.HideAllEventTipsAndLine(nowNo);
    else
        this.RefreshEventTips(nowNo,nextPoint)
        this.RefreshLine(nowNo,nextPoint)
    end

rectNowPos.anchoredPosition = Vector2(this.rectEventPos[nowNo].anchoredPosition.x, this.rectEventPos[nowNo].anchoredPosition.y + 40);
    this.RefreshBuff()
    this.RefreshCharacter()

end

this.RefreshEventTips=function (nowNo,nextPoint)

     for index, value in ipairs(this.eventItemList) do
        value:SetNextIsEvent(false,false);
    end
    for index, value in ipairs(nextPoint) do
this.eventItemList[value+1]:SetNextIsEvent(true,true);
    end
   
end

this.RefreshLine=function (nowNo,nextPoint)

    for i = 1, #nextPoint, 1 do
        if i > #this.lineItemList then   
            local temp = UICollectorMainSceneLineVersion2Item.New(UICollectorMainSceneLineVersion2ItemPrefab,
                rectLineGroup);
            table.insert(this.lineItemList, temp);
        end
this.lineItemList[i]:SetData(this.rectEventPos[nowNo].anchoredPosition, this.rectEventPos[nextPoint[i]+1].anchoredPosition);
    end
    for i = #nextPoint + 1, #this.lineItemList, 1 do
        this.lineItemList[i]:Hide();
    end
end

this.RefreshBuff=function ()

    CollectorPracticeMgrVersion2.InitMainSceneBuffData();
    if TableIsNull(CollectorPracticeMgrVersion2.HaveRewardBuff) then
        SetActive(goShowBuffGroup,false);
    else
        SetActive(goShowBuffGroup,true);
        for i = 1, #CollectorPracticeMgrVersion2.HaveRewardBuff, 1 do
            if i > #this.buffItemList then
                local temp = UICollectorMainSceneBuffVersion2Item.New(UICollectorMainSceneBuffVersion2ItemPrefab,
                    rectBuffGroup);
                table.insert(this.buffItemList, temp);
            end
            if #CollectorPracticeMgrVersion2.HaveRewardBuff[i] ~= 0 then
                this.buffItemList[i]:SetData(CollectorPracticeMgrVersion2.HaveRewardBuff[i][1],
                    CollectorPracticeMgrVersion2.HaveAllRewardBuff[i]);
            else
                this.buffItemList[i]:Hide();
            end
        end
        for i = #CollectorPracticeMgrVersion2.HaveRewardBuff + 1, #this.buffItemList, 1 do
            this.buffItemList[i]:Hide();
        end
    end
end

this.RefreshCharacter=function ()

        local data = DataMgr.Player.practiceStage2.members;
        for i = 1, #data, 1 do
            if i > #this.characterItemList then
                local temp = UICollectorMainSceneCharacterVersion2Item.New(UICollectorMainSceneCharacterVersion2ItemPrefab,
                    rectCharacterGroup);
                table.insert(this.characterItemList, temp);
            end
            this.characterItemList[i]:SetData(data[i].ID, data[i].State);
        end
        for i = #data + 1, #this.characterItemList, 1 do
            this.characterItemList[i]:Hide();
        end
end

this.HideAllEventTipsAndLine=function (nowNo)

    for index, value in ipairs(this.eventItemList) do
        value:SetNextIsEvent(false,false);
    end
    this.eventItemList[nowNo]:SetNextIsEvent(true,false);

    for i = 1, #this.lineItemList, 1 do
        this.lineItemList[i]:Hide();
    end
end


this.CameraMove=function ()

    if CollectorPracticeMgrVersion2.IsFirstOpenPanel then

        ScrollViewBuild.horizontalNormalizedPosition=1;
        local nowPos=(-rectContent.anchoredPosition.x);
        local checkIndex=-1;
        for i = 1, #this.rectEventPos, 1 do
            this.eventItemList[i]:ReadyToShowFirstAnimation();
        end
this.startAnimationCoo= coroutine_runner.start(function()
            for i = #this.rectEventPos, 1, -1 do
                if this.rectEventPos[i].anchoredPosition.x>nowPos then
                    this.eventItemList[i]:ShowFirstAnimation();
                    checkIndex=i-1;
                    coroutine_runner.wait(0.1)
                end
            end
            local showTime=nowPos/1000;
            this.startDotween = DOTWeen.To(function() return ScrollViewBuild.horizontalNormalizedPosition end,
            function(vector)
                ScrollViewBuild.horizontalNormalizedPosition = vector;
                nowPos=(-rectContent.anchoredPosition.x);
                if checkIndex>0 and nowPos<this.rectEventPos[checkIndex].anchoredPosition.x then
                    this.eventItemList[checkIndex]:ShowFirstAnimation();
                    checkIndex=checkIndex-1;
                end
            end, 0, showTime);

            this.startDotween:SetEase(Ease.Linear)
            this.startDotween.onComplete = function()
                this.startDotween = nil;
            end
        end)
        CollectorPracticeMgrVersion2.IsFirstOpenPanel=false;
    else
if CollectorPracticeMgrVersion2.DeemNotLevelMainScene or CollectorPracticeMgrVersion2.IsOpenBattlePanel then
            rectContent.anchoredPosition=CollectorPracticeMgrVersion2.OpenEventBeforeScrollViewContentPos;
else
            local nowNo=DataMgr.Player.practiceStage2.crtEventNo+1;
            rectContent.anchoredPosition=Vector2(-this.rectEventPos[nowNo].anchoredPosition.x+300,0);
        end
    end
end









this.CheckIsFinish=function ()
    local data=DataMgr.Player.practiceStage2.stages;
    local nowNo=DataMgr.Player.practiceStage2.crtEventNo+1;
    local nowEvent=data[nowNo];
    local config=ConfigMgr.Config.YX2EventMap;
if nowEvent.State==1 then
        local notFinishEventStageIndex=CollectorPracticeMgrVersion2.GetNotFinishStage();
        local notFinishEventStage=data[nowNo].Stage[notFinishEventStageIndex+1];
        if config[notFinishEventStage.Event]~=nil then
            local data={};
            data.nowEventId=notFinishEventStage.Event;
            data.nowEventNo=DataMgr.Player.practiceStage2.crtEventNo;
            data.needShowFirstStage=false;
            LuaMgr.ShowLuaPanel(UIName.CollectorPracticeEventVersion2ViewModel,data);
        elseif notFinishEventStage.Event=="CHOOSE_BUFF" then
            LuaMgr.ShowLuaPanel(UIName.CollectorPracticeChooseBuffVersion2ViewModel,false);
        elseif notFinishEventStage.Event=="EXTRA_BUFF" then
            LuaMgr.ShowLuaPanel(UIName.CollectorPracticeChooseBuffVersion2ViewModel,true);
        elseif notFinishEventStage.Event=="REWARD" then





            local tempData={}
            tempData["EventID"] = DataMgr.Player.practiceStage2.stages[DataMgr.Player.practiceStage2.crtEventNo+1].EventID;
            tempData["EventNo"] = DataMgr.Player.practiceStage2.crtEventNo;
            tempData["Index"] = CollectorPracticeMgrVersion2.GetNotFinishStage();
            ApiMgr.Request("practice2/end_event", tempData, true, function(result)
                local re = json.decode(result)
                if re.code == 0 then
                    if not IsNull(re.result.Reward.Items) then
                        local items = {};
                        local reward = re.result.Reward.Items
                        for i, v in pairs(reward) do
                            local item = { ID = v.id, Count = v.count }
                            table.insert(items, item);
                        end
                        LuaMgr.ShowLuaPanel(UIName.CollectorPracticeChipItemsVersion2ViewModel,items,function ()
                            LuaMgr.InvokeUIEventListeners(UIEventConst.NeedRefreshState);
LuaMgr.InvokeUIEventListeners(UIEventConst.CheckEventFinish);
                        end)
else
                        LuaMgr.InvokeUIEventListeners(UIEventConst.NeedRefreshState);
LuaMgr.InvokeUIEventListeners(UIEventConst.CheckEventFinish);
                    end
                end
                    
            end, nil, true)
        end
    end
end

this.CheckNeedSettlement=function ()
    local data=DataMgr.Player.practiceStage2.stages;
    if data[#data].State==2 then
        this.SettlementHelpFun(true);
    end
end

this.SettlementHelpFun=function (isWin)
    local data = {}
    local Url = "practice2/settlement"
    ApiMgr.Request(Url, data, true,
        function(result)
            local re = json.decode(result)
            if re.code == 0 then
                local heroIdList={};
                local member=DataMgr.Player.practiceStage2.members;
                for index, value in ipairs(member) do
                    table.insert(heroIdList,value.ID);
                end
                local showBuffIdList={};
                if not TableIsNull(CollectorPracticeMgrVersion2.HaveRewardBuff) then
                    for index, value in ipairs(CollectorPracticeMgrVersion2.HaveRewardBuff) do
                        if #value~=0 then
                            table.insert(showBuffIdList,{
                                showBuffId=value[1];
                                showbuffCount=CollectorPracticeMgrVersion2.HaveAllRewardBuff[index];
                            });
                        end
                    end
                end
                local data={};
                data.isWin=isWin;
                data.score=re.result.Score;
                data.goodsItem=re.result.Reward.Items;
                data.tools=re.result.Tools;
                data.heroIdList=heroIdList;
                data.showBuffIdList=showBuffIdList
                LuaMgr.ShowLuaPanel(UIName.CollectorPracticeRewardResultVersion2ViewModel,data)
            end
        end,
        function(failCode)
            print("EnterDungeonError,ErrorCode:", failCode)
        end,
        true
    )
end

this.SaveRectContentData=function ()
    CollectorPracticeMgrVersion2.OpenEventBeforeScrollViewContentPos=rectContent.anchoredPosition;
end

this.CheckIsFail=function ()
    local data=DataMgr.Player.practiceStage2.members;
    local isFail=true;
    for key, value in pairs(data) do
        if value.State~=1 then
            isFail=false;
            return isFail;
        end
    end
    return isFail;
end

local hook = {
    before_awake = function(vm)
        this.Init(vm.behaviour.gameObject)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end

        vm.behaviour:UpdateTopBar("", function ()
            if LuaMgr.IsPanelOpen(UIName.CollectorPracticeEventVersion2ViewModel) then
                return;
            else
                LuaMgr.Back();
            end
        end)

        LuaMgr.RemoveUIEventListener(UIEventConst.NeedRefreshState, this.RefreshPanel);
        LuaMgr.RemoveUIEventListener(UIEventConst.NeedSaveData,this.SaveRectContentData);
        LuaMgr.RemoveUIEventListener(UIEventConst.CheckEventFinish, this.CheckIsFinish);
        LuaMgr.AddUIEventListener(UIEventConst.NeedRefreshState, this.RefreshPanel);
        LuaMgr.AddUIEventListener(UIEventConst.NeedSaveData, this.SaveRectContentData);
        LuaMgr.AddUIEventListener(UIEventConst.CheckEventFinish, this.CheckIsFinish);
        LuaMgr.RemoveNormalPanel(UIName.CollectorPracticeSelectMonsterVersion2ViewModel);
        this.InitData();
        this.InitPanel();
        this.CameraMove();
if this.CheckIsFail() then
            this.SettlementHelpFun(false);
        else
if CollectorPracticeMgrVersion2.FirstOpenMainScene or CollectorPracticeMgrVersion2.IsOpenBattlePanel then
                this.CheckIsFinish();
            end
            this.CheckNeedSettlement();
        end

CollectorPracticeMgrVersion2.FirstOpenMainScene=false;
CollectorPracticeMgrVersion2.DeemNotLevelMainScene=false;
CollectorPracticeMgrVersion2.IsOpenBattlePanel=false;
    end,
    before_deactive = function(vm)
        if vm.behaviour.Params == nil then
            return;
        end
        if this.startDotween~=nil then
            this.startDotween:Kill();
        end
        if (not coroutine_runner.checkIsDestory()) and this.startAnimationCoo~=nil then
           coroutine_runner.stop(this.startAnimationCoo);
           this.startAnimationCoo=nil;
        end
        LuaMgr.RemoveUIEventListener(UIEventConst.NeedRefreshState, this.RefreshPanel);
        LuaMgr.RemoveUIEventListener(UIEventConst.NeedSaveData,this.SaveRectContentData);
        LuaMgr.RemoveUIEventListener(UIEventConst.CheckEventFinish, this.CheckIsFinish);
    end,
    before_destroy = function(vm)
        this.Clear();
    end,
}

return vm({
    hook = hook
})