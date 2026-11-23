require("ViewModel/KZRY/KZRYExplore_CityItem")
require("ViewModel/KZRY/KZRYExplore_EventItem")
require("ViewModel/KZRY/KZRYExplore_RewardItem")
local this = {
    vm = nil,
    groupList = {},
    eventList = {},
    cityUIList = {},
    eventUIList = {},
    rewardUIList_letterGame = {},
    rewardUIList_novel = {},
    rewardUIList_battle = {},
    cityItemObj = nil,
    eventItemObj = nil,
    rewardItemObj = nil,
    curEvent = nil,
    uiSpine = nil,
    historyIndex = nil,
    spineOffPos = Vector2(-154, -26)
};
local pos = { Vector2(-1325, -54), Vector2(-1004, -27.6), Vector2(-395.8, -31), Vector2(-43.2, -67.6),
    Vector2(137, -198), Vector2(694, -25), Vector2(1017, -40.8), Vector2(1310.5, -38.8), }
local contentPos = { Vector2(0, 0), Vector2(0, 0), Vector2(-625, 0), Vector2(-955, 0),
    Vector2(-1120, 0), Vector2(-1525, 0), Vector2(-1938, 0), Vector2(-2080, 0) }

local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local goods = nil;
local Middle = nil;
local goPopCity = nil;
local goPopEnter = nil;
local goLetterGame = nil;
local goNovel = nil;
local goBattle = nil;
local Right = nil;
local Left = nil;
local text = nil;
local txtPro = nil;
local txtLetterGamePro = nil;
local txtLetterGameName = nil;
local txtNovelPro = nil;
local txtNovelName = nil;
local txtNovelDes = nil;
local txtBattlePro = nil;
local txtBattleName = nil;
local btnClick = nil;
local btnPopCityMask = nil;
local btnEnterMask = nil;
local btnLetterGame = nil;
local btnNovel = nil;
local btnBattle = nil;
local btnEventRecard = nil;
local btnNovelRecard = nil;
local ScrollView = nil;
local tranCity = nil;
local tranSpine = nil;
local tranEventList = nil;
local tranLetterGameRewardList = nil;
local tranNovelRewardList = nil;
local tranBattleRewardList = nil;
local imgName = nil;
local tranContent = nil;
local goAnim = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    goods = uiLink:Get("goods");
    Middle = uiLink:Get("Middle");
    goPopCity = uiLink:Get("goPopCity");
    goPopEnter = uiLink:Get("goPopEnter");
    goLetterGame = uiLink:Get("goLetterGame");
    goNovel = uiLink:Get("goNovel");
    goBattle = uiLink:Get("goBattle");
    Right = uiLink:Get("Right");
    Left = uiLink:Get("Left");
    text = uiLink:Get("text"):GetComponent("Text");
    txtPro = uiLink:Get("txtPro"):GetComponent("Text");
    txtLetterGamePro = uiLink:Get("txtLetterGamePro"):GetComponent("Text");
    txtLetterGameName = uiLink:Get("txtLetterGameName"):GetComponent("Text");
    txtNovelPro = uiLink:Get("txtNovelPro"):GetComponent("Text");
    txtNovelName = uiLink:Get("txtNovelName"):GetComponent("Text");
    txtNovelDes = uiLink:Get("txtNovelDes"):GetComponent("Text");
    txtBattlePro = uiLink:Get("txtBattlePro"):GetComponent("Text");
    txtBattleName = uiLink:Get("txtBattleName"):GetComponent("Text");
    btnClick = uiLink:Get("btnClick"):GetComponent("Button");
    btnPopCityMask = uiLink:Get("btnPopCityMask"):GetComponent("Button");
    btnEnterMask = uiLink:Get("btnEnterMask"):GetComponent("Button");
    btnLetterGame = uiLink:Get("btnLetterGame"):GetComponent("Button");
    btnNovel = uiLink:Get("btnNovel"):GetComponent("Button");
    btnBattle = uiLink:Get("btnBattle"):GetComponent("Button");
    btnEventRecard = uiLink:Get("btnEventRecard"):GetComponent("Button");
    btnNovelRecard = uiLink:Get("btnNovelRecard"):GetComponent("Button");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    tranCity = uiLink:Get("tranCity"):GetComponent("RectTransform");
    tranSpine = uiLink:Get("tranSpine"):GetComponent("RectTransform");
    tranEventList = uiLink:Get("tranEventList"):GetComponent("RectTransform");
    tranLetterGameRewardList = uiLink:Get("tranLetterGameRewardList"):GetComponent("RectTransform");
    tranNovelRewardList = uiLink:Get("tranNovelRewardList"):GetComponent("RectTransform");
    tranBattleRewardList = uiLink:Get("tranBattleRewardList"):GetComponent("RectTransform");
    imgName = uiLink:Get("imgName"):GetComponent("Image");
    tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    goAnim = uiLink:Get("goAnim");
    this.AddRigister(uiLink);
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    goods = nil;
    Middle = nil;
    goPopCity = nil;
    goPopEnter = nil;
    goLetterGame = nil;
    goNovel = nil;
    goBattle = nil;
    Right = nil;
    Left = nil;
    text = nil;
    txtPro = nil;
    txtLetterGamePro = nil;
    txtLetterGameName = nil;
    txtNovelPro = nil;
    txtNovelName = nil;
    txtNovelDes = nil;
    txtBattlePro = nil;
    txtBattleName = nil;
    btnClick = nil;
    btnPopCityMask = nil;
    btnEnterMask = nil;
    btnLetterGame = nil;
    btnNovel = nil;
    btnBattle = nil;
    btnEventRecard = nil;
    btnNovelRecard = nil;
    ScrollView = nil;
    tranCity = nil;
    tranSpine = nil;
    tranEventList = nil;
    tranLetterGameRewardList = nil;
    tranNovelRewardList = nil;
    tranBattleRewardList = nil;
    imgName = nil;
    tranContent = nil;
    goAnim = nil
end


this.AddRigister = function(uiLink)
    uiLink:AddClickEvent("btnPopCityMask", function()
        SetActive(goPopCity, false);
    end)
    uiLink:AddClickEvent("btnEnterMask", function()
        SetActive(goPopEnter, false);
    end)
    uiLink:AddClickEvent("btnNovel", function()
        if this.curEvent ~= nil and this.curEvent.type == 1 then
            HeroParameter.KZRYGroupId = this.curEvent.groupId
            LuaMgr.PlayNovel(this.curEvent.eventParam, function()
                KZRYMgr.SetShowAni(false);
                LuaMgr.ShowLuaPanel(UIName.KZRYExploreViewModel);
            end);
        end
    end)
    uiLink:AddClickEvent("btnLetterGame", function()
        if this.curEvent ~= nil then
            KZRYMgr.SetShowAni(false);
            if this.curEvent.type == 3 then
                local isUnlock, tipsContent = Match3GameManager.PassIsUnlock(this.curEvent)
                if isUnlock == false then
                    if tipsContent then
                        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
                    end
                    return
                end
                local data = {}
                data.Id = this.curEvent.eventParam
                local callback = function(result)
                    local res = json.decode(result)
                    if res.code ~= 0 then
                        return
                    end
                    LuaMgr.ShowLuaPanel(UIName.Match3GameMainViewModel, data)
                end
                ApiMgr.Request("eliminate/start", data, true, callback, nil, true)
            elseif this.curEvent.type == 2 then
                BattlePrepareMgr.EnterBattlePrepare(this.curEvent.id, this.curEvent.eventParam)
            end
            HeroParameter.KZRYGroupId = this.curEvent.groupId
        end
    end)
    uiLink:AddClickEvent("btnBattle", function()
        if this.curEvent ~= nil and this.curEvent.type == 4 then
            KZRYMgr.SetShowAni(false);
            BattlePrepareMgr.EnterBattlePrepare(this.curEvent.id, this.curEvent.eventParam)
            HeroParameter.KZRYGroupId = this.curEvent.groupId
        end
    end)
    uiLink:AddClickEvent("btnEventRecard", function()
        LuaMgr.ShowLuaPanel(UIName.KZRYPuzzleViewModel);
    end)
    uiLink:AddClickEvent("btnNovelRecard", function()
        LuaMgr.ShowLuaPanel(UIName.KZRYNovelViewModel);
    end)
end



local data = {

}
local command = {

}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        RedMgr.Singleton:RegisterViewModel(UIName.KZRYExploreViewModel);
        print("before_awake");
        this.Init(vm.behaviour)
        this.cityUIList = UIListView.New(tranCity);
        this.eventUIList = UIListView.New(tranEventList);
        this.rewardUIList_letterGame = UIListView.New(tranLetterGameRewardList);
        this.rewardUIList_battle = UIListView.New(tranBattleRewardList);
        this.rewardUIList_novel = UIListView.New(tranNovelRewardList);
        this.cityItemObj = vm.behaviour.transform:Find("template/cityItem").gameObject
        this.eventItemObj = vm.behaviour.transform:Find("template/eventItem").gameObject
        this.rewardItemObj = vm.behaviour.transform:Find("template/rewardItem").gameObject
        this.uiSpine = vm.behaviour.transform:Find(
            "root/Middle_1/ScrollView/Viewport/tranContent/area/tranSpine/npcA0167001"):GetComponent("UISpineCharacter");
    end,
    before_active = function(vm)
        if (RedMgr.Singleton:CheckRedCondition("16838")) then
            RedMgr.Singleton:FrushRedCondition("16838")
        end
        HeroRedDataHelper.SetKZRYRed()
        RedMgr.Singleton:Refresh()
        if (vm.behaviour.Params ~= nil) then           
            this.ParseData();
        end
        if(KZRYMgr.CheckShowAni())then
            SetActive(goAnim,true)
            AudioMgr.Singleton:StopVoice(false);
            AudioMgr.Singleton:PlayVoice(Path.audio_PATH .. "Bgm/KZRYAni.mp3");    
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        SetActive(goAnim,false)
        AudioMgr.Singleton:StopVoice(false);
        if this.cityUIList ~= nil then
            this.cityUIList:Clear();
        end
        if this.eventList ~= nil then
            this.eventUIList:Clear();
        end
        if this.rewardUIList_battle ~= nil then
            this.rewardUIList_battle:Clear();
        end
        if this.rewardUIList_novel ~= nil then
            this.rewardUIList_novel:Clear();
        end
        if this.rewardUIList_letterGame ~= nil then
            this.rewardUIList_letterGame:Clear();
        end
        if this.tweener ~= nil then
            this.tweener:Kill();
        end
        if this.delay ~= nil then
            coroutine_runner.stop(this.delay)
            this.delay = nil
        end
    end,
    before_destroy = function()
        this.Clear()
        RedMgr.Singleton:RemoveViewModel(UIName.KZRYExploreViewModel);
        UIListView.ClearItem("KZRYExplore_RewardItem")
        UIListView.ClearItem("KZRYExplore_EventItem")
        UIListView.ClearItem("KZRYExplore_CityItem")
    end
}

this.InitPanelState = function()
    SetActive(goPopCity, false)
    SetActive(goPopEnter, false)
end

this.ParseData = function()
    this.groupList = KZRYMgr.GetGroupsByKZRY();
    this.InitPanelState();
    this.SetSpineHistoryPosition();
    this.curIndex = KZRYMgr.GetGroupsUnLockProIndex();
    if(tranContent ~= nil and not LuaMgr.IsObjectNull(tranContent))then
        tranContent.anchoredPosition = contentPos[this.curIndex];
    else
        LuaDebug.error("KZRYExploreViewModel.lua [tranContent] is null!");
    end  
    if this.curIndex > this.historyIndex then

        this.SetCityList(this.historyIndex);
        this.SetSpineMove(this.curIndex);
    else
        this.SetCityList();
    end
    if HeroParameter.KZRYGroupId ~= nil then
        local openIndex = nil;
        for i, v in ipairs(this.groupList) do
            if v.id == HeroParameter.KZRYGroupId then
                openIndex = i;
                break
            end
        end
        if openIndex ~= nil then
            this.CityCallBack(openIndex);
        end
        HeroParameter.KZRYGroupId = nil
    end
end

this.SetSpineHistoryPosition = function()
    this.historyIndex = KZRYMgr.GetHistoryProIndex();
    if this.historyIndex == 0 then
        this.historyIndex = 1;
    end
    local locPosition = pos[this.historyIndex] + this.spineOffPos;
    if(tranSpine ~= nil and not LuaMgr.IsObjectNull(tranSpine))then
        tranSpine.anchoredPosition = locPosition;
    else
        LuaDebug.error("KZRYExploreViewModel.lua [tranSpine] is null!");
    end    
    this.SetSpineIdle();
end

this.SetSpineIdle = function()
    this.uiSpine:PlayAnimation("idle", true, nil);
end

this.SetSpineMove = function(moveIndex)
    local tarPosition = pos[moveIndex] + this.spineOffPos;
    this.uiSpine:PlayAnimation("move", true, nil);
     if(tranSpine == nil or LuaMgr.IsObjectNull(tranSpine))then
        luaDebug.error("KZRYExploreViewModel.lua [tranSpine] is null!");
        return
    end  
    this.tweener = DOTWeen.To(function() return tranSpine.anchoredPosition end, function(value)
        tranSpine.anchoredPosition = value;
    end, tarPosition, 2):SetEase(Ease.Linear);
    this.tweener.onComplete = function()
        this.SetSpineDrop(moveIndex);
        this.PlayCityUnlockAnimation(moveIndex);
    end
end

this.SetSpineDrop = function(index)
    KZRYMgr.UpdateHistoryProIndex(index);
    this.uiSpine:PlayAnimation("transition", false, this.SetSpineIdle);
end


this.PlayCityUnlockAnimation = function(index)

    if this.delay ~= nil then
        coroutine_runner.stop(this.delay)
        this.delay = nil
    end
    this.delay = coroutine_runner.start(function()
        this.cityUIList.itemList[index]:ShowUnlockEff();
        coroutine_runner.wait(0.5)

        this.cityUIList.itemList[index].data.isLock = false;
        this.cityUIList.itemList[index]:SetLock(false);
        this.delay = nil
    end)
end;



this.GetEventsProStrTip = function(groupId)
    local pro, max = KZRYMgr.GetEventsProByGroup(groupId);
    local proStr = ConfigMgr.LangGlobal("25203");
    local endStr = string.format("<color=#f8febe>%s</color>/%s", pro, max);
    return string.format(proStr, endStr);
end

this.SetCityList = function(historyIndex)
    if IsNull(this.groupList) then return end;
    this.cityUIList:Clear();
    local list = {}
    for i, v in ipairs(this.groupList) do
        local pLock, type, lockInfo = KZRYMgr.CheckGroupIsLock(v)
        if historyIndex ~= nil and not pLock and i == this.curIndex then
            pLock = true;
        end
        local tips = this.GetEventsProStrTip(v.id);
        local cityItem = {
            index = i,
            isLock = pLock,
            lockInfo = type == 1 and lockInfo or ConfigMgr.LangGlobal("10352"),
            lockInfoTips = lockInfo,
            proInfo = tips,
            locPos = pos[i] ~= nil and pos[i] or Vector2.zero,
            callBack = this.CityCallBack,
        }
        local cityData = UIListData.GetData(this.cityItemObj, "KZRYExplore_CityItem", cityItem);
        table.insert(list, cityData);
    end
    this.cityUIList:SetData(list);
end


this.CityCallBack = function(index)
    local curGroup = this.groupList[index];
    if curGroup == nil then return end;
    this.SetEventList(index, curGroup);
end

this.SetEventList = function(index, curGroup)
    this.eventList = KZRYMgr.GetEventsByGroupId(curGroup.id)
    if this.eventList == nil or #this.eventList == 0 then return end;
    SetActive(goPopCity, true);
    imgName.sprite = LuaMgr.GetSprite("KZRY", string.format("ui_hd_kz_zx_gk_st%s_1", index));
    txtPro.text = this.GetEventsProStrTip(curGroup.id);
    this.eventUIList:Clear();
    local list = {}
    for i, v in ipairs(this.eventList) do
        local pUnLock = KZRYMgr.CheckEventIsUnLock(v);
        local pPass = KZRYMgr.CheckEventIsComplete(v);
        local eventItem = {
            index = i,
            iconName = v.statusIcon,
            isLock = not pUnLock,
            isPass = pPass,
            locPos = KZRYMgr.GetEventLocPosition(v.classId),
            lockIconName = (v.type == 2 or v.type == 3) and "ui_hd_kz_zx_tc_rk_zxwjs" or "ui_hd_kz_zx_tc_rk_wjs",
            isRepeat = v.type == 2,
            callBack = this.EventCallBack,
        }
        local eventData = UIListData.GetData(this.eventItemObj, "KZRYExplore_EventItem", eventItem);
        table.insert(list, eventData);
    end
    this.eventUIList:SetData(list);
end


this.EventCallBack = function(index)
    SetActive(goPopEnter, true);
    SetActive(goLetterGame, false)
    SetActive(goNovel, false);
    SetActive(goBattle, false);
    this.curEvent = this.eventList[index];
    local isCompleteEvent = KZRYMgr.CheckEventIsComplete(this.curEvent);
    if this.curEvent.type == 2 or this.curEvent.type == 3 then
        SetActive(goLetterGame, true)
        txtLetterGamePro.text = txtPro.text;
        txtLetterGameName.text = LuaMgr.GetLangText(this.curEvent.namelan)
        this.rewardUIList_letterGame:Clear();
        local list = {};
        if this.curEvent.type == 2 then

            local dungeon = ConfigMgr.Config.dungeonMap[this.curEvent.eventParam];
            local firstList = ConfigHelper.GetRewardListByDrop(dungeon.firstDrop);
            local secondList = ConfigHelper.GetRewardListByDrop(dungeon.secondDrop);
            list = this.GetRewardsList(firstList, secondList, isCompleteEvent);
        else

            local eliminate = ConfigMgr.Config.EliminateGameMap[this.curEvent.eventParam];
            if eliminate ~= nil then
                list = this.GetRewardsList(eliminate.Reward, nil, isCompleteEvent);
            end
        end
        this.rewardUIList_letterGame:SetData(list);
    elseif this.curEvent.type == 1 then
        SetActive(goNovel, true);
        txtNovelPro.text = txtPro.text;
        txtNovelName.text = LuaMgr.GetLangText(this.curEvent.namelan)
        local narrative = ConfigMgr.Config.narrativeMap[this.curEvent.eventParam];
        txtNovelDes.text = LuaMgr.GetLangText(this.curEvent.descriptionlan)
        local firstList = ConfigHelper.GetRewardListByDrop(narrative.fixedDrop);
        local list = this.GetRewardsList(firstList, nil, isCompleteEvent);
        this.rewardUIList_novel:Clear();
        this.rewardUIList_novel:SetData(list);
    elseif this.curEvent.type == 4 then
        SetActive(goBattle, true);
        txtBattlePro.text = txtPro.text;
        txtBattleName.text = LuaMgr.GetLangText(this.curEvent.namelan)
        local dungeon = ConfigMgr.Config.dungeonMap[this.curEvent.eventParam];
        local firstList = ConfigHelper.GetRewardListByDrop(dungeon.firstDrop);
        local secondList = ConfigHelper.GetRewardListByDrop(dungeon.secondDrop);
        local list = this.GetRewardsList(firstList, secondList, isCompleteEvent);
        this.rewardUIList_battle:Clear();
        this.rewardUIList_battle:SetData(list);
    end
end

this.GetRewardsList = function(firstRewards, secondRewards, pIsComplete)
    local list = {};
    if firstRewards ~= nil and #firstRewards > 0 then
        if not pIsComplete or secondRewards == nil or #secondRewards == 0 then

            for i, v in ipairs(firstRewards) do
                local item = {
                    id = v.id,
                    count = v.count,
                    isFirst = not pIsComplete,
                    isSecond = false,
                    isComplete = pIsComplete
                }
                local itemData = UIListData.GetData(this.rewardItemObj, "KZRYExplore_RewardItem", item);
                table.insert(list, itemData)
            end
        end
    end
    if pIsComplete and secondRewards ~= nil and #secondRewards > 0 then

        for i, v in ipairs(secondRewards) do
            local item = {
                id = v.id,
                count = v.count,
                isFirst = false,
                isSecond = true,
                isComplete = false
            }
            local itemData = UIListData.GetData(this.rewardItemObj, "KZRYExplore_RewardItem", item);
            table.insert(list, itemData)
        end
    end
    return list;
end


return vm({
    data = data,
    command = command,
    hook = hook
})