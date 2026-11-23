require("ViewModel/PackUp/PackUpExplore_EventItem")

local this = {
    vm = nil,
    groupList = {},
    eventList = {},
    shopList = {},
    cityUIList = {},
    curIndex = 0,
    curGroupIndex = 0,

    eventItemObj = nil,
    rewardItemObj = nil,
    curEvent = nil,
    uiSpine = nil,
    historyIndex = nil,
    spineOffPos = Vector2(-110, -15),
    cloudEffectList = {},
};

local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Middle = nil;
local ScrollView = nil;
local tranContent = nil;
local tranCity = nil;
local tranSpine = nil;
local btnTipPaneClose = nil;
local tranTipPanelBig = nil;
local imgIcon = nil
local imgBg = nil
local textTitle = nil;
local textContent = nil;
local tranLevelList = nil;
local rectContent = nil;
local btnBattle = nil;
local btnSearch = nil;
local btnLocation = nil;
local btnStory = nil;
local textRatio = nil


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root"):GetComponent("RectTransform");
    Middle = uiLink:Get("Middle");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    tranCity = uiLink:Get("tranCity"):GetComponent("RectTransform");
    tranSpine = uiLink:Get("tranSpine"):GetComponent("RectTransform");
    textTitle = uiLink:Get("textTitle"):GetComponent("Text");
    imgIcon = uiLink:Get("imgIcon"):GetComponent("Image");
    imgBg = uiLink:Get("imgBg"):GetComponent("Image");
    textRatio = uiLink:Get("textRatio"):GetComponent("Text");
    tranTipPanelBig = uiLink:Get("tranTipPanelBig"):GetComponent("RectTransform");
    btnTipPaneClose = uiLink:Get("btnTipPaneClose"):GetComponent("Button");
    textContent = uiLink:Get("textContent"):GetComponent("Text");
    tranLevelList = uiLink:Get("tranLevelList"):GetComponent("RectTransform");
    rectContent = uiLink:Get("rectContent"):GetComponent("Transform");
    btnBattle = uiLink:Get("btnBattle"):GetComponent("Button");
    btnSearch = uiLink:Get("btnSearch"):GetComponent("Button");
    btnLocation = uiLink:Get("btnLocation"):GetComponent("Button");
    btnStory = uiLink:Get("btnStory"):GetComponent("Button");
    this.AddRigister(uiLink);
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Middle = nil;
    ScrollView = nil;
    tranContent = nil;
    tranCity = nil;
    tranSpine = nil;
    btnTipPaneClose = nil;
    tranTipPanelBig = nil;
    textTitle = nil;
    textContent = nil;
    tranLevelList = nil;
    rectContent = nil;
    btnBattle = nil;
    btnSearch = nil;
    btnLocation = nil;
    btnStory = nil;
    imgBg = nil
    textRatio = nil
    imgIcon = nil
end


this.AddRigister = function(uiLink)
    uiLink:AddClickEvent("btnTipPaneClose", function()
        SetActive(tranTipPanelBig.gameObject, false);
        SetActive(btnTipPaneClose.gameObject, false);
    end)
    uiLink:AddClickEvent("btnBattle", function()
        if this.curEvent ~= nil then
            if (this.curEvent.config.type == 1) then
                LuaMgr.PlayNovel(this.curEvent.config.eventParam, function()
                    LuaMgr.ShowLuaPanel(UIName.PackUpExploreViewModel);
                end);
            elseif (this.curEvent.config.type == 2) then
                BattlePrepareMgr.EnterBattlePrepare(this.curEvent.config.id, this.curEvent.config.eventParam)
            elseif (this.curEvent.config.type == 3) then
                LuaMgr.ShowLuaPanel(UIName.PackUpGameViewModel, this.curEvent.config.id);
            end
        end
    end)
    uiLink:AddClickEvent("btnSearch", function()
        for i, v in ipairs(this.cityUIList.itemList) do
            if (not v.data.isLock and not v.data.isPass) then
                this.SetMapPos(i, true);
                return
            end
        end
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("26860"))
    end)
    uiLink:AddClickEvent("btnLocation", function()
        local num = #this.shopList;
        if (num > 0) then
            local randomNum = math.random(1, num);
            local param = this.shopList[randomNum].eventParam;
            LuaMgr.ShowLuaPanel(UIName.PackUpDailyShopViewModel, param);
        else
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("26861"))
        end
    end)
    uiLink:AddClickEvent("btnStory", function()
        LuaMgr.ShowLuaPanel(UIName.PackUpNovelViewModel);
    end)
end



local data = {

}
local command = {

}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        RedMgr.Singleton:RegisterViewModel(UIName.PackUpExploreViewModel);
        this.Init(vm.behaviour)
        this.cityUIList = UIListView.New(tranCity);
        this.eventItemObj = vm.behaviour.transform:Find("template/Item").gameObject
        this.rewardItemObj = vm.behaviour.transform:Find("template/RewardItem").gameObject
        this.uiSpine = vm.behaviour.transform:Find(
            "root/Middle1/ScrollView/Viewport/tranContent/area/tranSpine/npcA0167001"):GetComponent("UISpineCharacter");
        this.cloudEffectList = {}
        for i = 0, tranCity.childCount - 1 do
            local ani = tranCity:GetChild(i).gameObject:GetComponent("Animator");
            table.insert(this.cloudEffectList, ani);
        end
    end,
    before_active = function(vm)
        if (RedMgr.Singleton:CheckRedCondition("17004")) then
            RedMgr.Singleton:FrushRedCondition("17004")
        end
        HeroRedDataHelper.SetPackUpRed()
        RedMgr.Singleton:Refresh()
        SetActive(tranTipPanelBig.gameObject, false);
        SetActive(btnTipPaneClose.gameObject, false);
        if (vm.behaviour.Params ~= nil) then
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        AudioMgr.Singleton:StopVoice(false);
        if this.cityUIList ~= nil then
            this.cityUIList:Clear();
        end
        if this.tweener ~= nil then
            this.tweener:Kill();
        end
        if this.tweener2 ~= nil then
            this.tweener2:Kill();
        end
        if this.delay ~= nil then
            coroutine_runner.stop(this.delay)
            this.delay = nil
        end
    end,
    before_destroy = function()
        this.Clear()
        RedMgr.Singleton:RemoveViewModel(UIName.PackUpExploreViewModel);
        UIListView.ClearItem("PackUpExplore_EventItem")
    end
}


this.ParseData = function()
    this.groupList = PackUpMgr.GetGroupsByPackUp();
    this.curGroupIndex = PackUpMgr.GetGroupsUnLockProIndex();    
    this.SetCityList();
    this.curIndex = this.curIndex > 0 and this.curIndex or 1
    this.SetSpineMove(this.curIndex);
    this.SetGroupUnlock(this.curGroupIndex - 1);
end

this.SetSpineIdle = function()
    this.uiSpine:PlayAnimation("idle", true, nil);
end

this.SetSpineMove = function(moveIndex)
    local tarPosition = this.cityUIList.itemList[moveIndex].transform.anchoredPosition + this.spineOffPos;

    if (tranSpine == nil or LuaMgr.IsObjectNull(tranSpine)) then

        return
    end
    tranSpine.anchoredPosition = tarPosition;






    this.SetMapPos(moveIndex, false)
end

this.SetGroupUnlock = function(index)
    local oldIndex = PackUpMgr.GetHistoryProIndex();    
    for i, v in ipairs(this.cloudEffectList) do
        SetActive(v.gameObject, i > oldIndex);
        v.enabled = false;
    end
    if (index <= oldIndex) then
        return
    end
    this.PlayCityUnlockAnimation(index);
end

this.SetMapPos = function(moveIndex, bAnim)
    local tar = this.cityUIList.itemList[moveIndex].transform
    if (bAnim) then
        if this.tweener2 ~= nil then
            this.tweener2:Kill();
        end
        this.tweener2 = DOTWeen.To(function() return tranContent.anchoredPosition end, function(value)
            tranContent.anchoredPosition = value;
        end, tar.anchoredPosition * -1, 0.5):SetEase(Ease.Linear);
    else
        tranContent.anchoredPosition = tar.anchoredPosition * -1
    end
end


this.PlayCityUnlockAnimation = function(index)

    if this.delay ~= nil then
        coroutine_runner.stop(this.delay)
        this.delay = nil
    end
    this.delay = coroutine_runner.start(function()
        coroutine_runner.wait(1)
        for i, v in ipairs(this.cloudEffectList) do
            v.enabled = i == index;
        end
        PackUpMgr.UpdateHistoryProIndex(index);

        this.delay = nil
    end)
end;

this.SetCityList = function()
    if IsNull(this.groupList) then return end;
    this.cityUIList:Clear();
    local list = {}
    this.eventList = {}
    this.shopList = {}
    local totalNum = 0
    local passNum = 0
    for i, value in ipairs(this.groupList) do
        local eventList = PackUpMgr.GetEventsByGroupId(value.id)
        if eventList ~= nil and #eventList >= 0 then
            for k, v in ipairs(eventList) do
                local pUnLock = PackUpMgr.CheckEventIsUnLock(v);
                local pPass = PackUpMgr.CheckEventIsComplete(v);
                totalNum = totalNum + 1
                local eventItem = {
                    id = v.id,
                    index = totalNum,
                    config = v,
                    isLock = not pUnLock,
                    isPass = pPass,
                    locPos = PackUpMgr.GetEventLocPosition(v.classId),
                    callBack = this.EventCallBack,
                }
                if (pUnLock and pPass) then
                    passNum = passNum + 1
                end
                if (v.type == 6 and pUnLock) then
                    table.insert(this.shopList, v)
                end
                if (pUnLock) then
                    table.insert(this.eventList, eventItem);
                end
            end
        end
    end
    table.sort(this.eventList, function(a, b)
        return a.id < b.id
    end)
    this.curIndex = 0
    for i, v in ipairs(this.eventList) do
        v.index = i
        if ((v.config.statusIcon == "jq" or v.config.statusIcon == "fs") and not v.isLock) then
            this.curIndex = i

        end
        local eventData = UIListData.GetData(this.eventItemObj, "PackUpExplore_EventItem", v);
        table.insert(list, eventData);
    end
    this.cityUIList:SetData(list);
    textRatio.text = math.floor(passNum / totalNum * 100) .. "%"
end

this.EventCallBack = function(index)
    this.curEvent = this.eventList[index];
    if (this.curEvent.config.type == 6) then
        LuaMgr.ShowLuaPanel(UIName.PackUpDailyShopViewModel, this.curEvent.config.eventParam);
    else
        this.ShowTipPanelBig(this.cityUIList.itemList[index], this.curEvent)
    end
end

this.ShowTipPanelBig = function(_obj, _config)
    SetActive(tranTipPanelBig.gameObject, true)

    SetActive(btnTipPaneClose.gameObject, true)
    imgIcon.sprite = LuaMgr.GetSprite("PackUp", "ui_hd_ysjt_zx_gk_jd_" .. _config.config.statusIcon);
    imgBg.sprite = LuaMgr.GetSprite("PackUp", "ui_hd_ysjt_zx_gk_bt_" .. _config.config.statusIcon);
    textTitle.text = LuaMgr.GetLangText(_config.config.namelan)
    this.SetRewardItems(_config.config, rectContent)
end

this.SetRewardItems = function(_config, _container)
    local area = _config.type
    local rewardConfigList = {}
    local itemDataLis = {}
    local isFirst = false
    local isFinish = false
    if (area == 2) then
        local dropShow = nil
        local record = DataMgr.Player.dungeonRecords[_config.eventParam];
        local dungeonConfig = ConfigMgr.Config.dungeonMap[_config.eventParam]
        if (record == nil or record.completeCount == 0) then
            isFirst = true
            dropShow = dungeonConfig.firstDropShow;
        elseif (record.completeCount ~= 0 and _config.statusIcon ~= "fs") then
            isFinish = true
            dropShow = dungeonConfig.firstDropShow;
        else
            dropShow = dungeonConfig.fixedDropShow;
        end
        itemDataLis = NumTool.split(dropShow, ';')
    elseif (area == 1) then
        local narrativeConfig = ConfigMgr.Config.narrativeMap[_config.eventParam];
        itemDataLis = NumTool.split(narrativeConfig.fixedDropShow, ';')
        isFinish = DataHelper.CheckNovelComplete(_config.eventParam);
    elseif (area == 3) then
        if (PackUpMgr.CheckGameIsComplete(_config.eventParam)) then
            isFinish = true
        end
        local rewardConf = ConfigMgr.Config.PackUpGameMap[_config.eventParam]
        for k, v in pairs(rewardConf.Reward) do
            table.insert(itemDataLis, v.id)
        end
    end
    for i = 1, #itemDataLis do
        local itemData = table.Copy(ConfigMgr.Config.itemMap[itemDataLis[i]]);
        table.insert(rewardConfigList, itemData)
    end
    if (this.rewardItems ~= nil) then
        for k, v in pairs(this.rewardItems) do
            v.rewardObj:Hide();
            SetActive(v.go, false)
        end
    end
    if (#rewardConfigList > 0) then
        for i, v in ipairs(rewardConfigList) do
            if (this.rewardItems == nil) then
                this.rewardItems = {}
            end
            if (this.rewardItems[i] == nil) then
                local go = GameObject.Instantiate(this.rewardItemObj)
                local cache = {}
                cache.go = go
                cache.box = go.transform:Find("reward"):GetComponent("Transform");
                cache.get = go.transform:Find("get").gameObject;
                cache.first = go.transform:Find("first").gameObject;
                cache.rewardObj = GoodsDataItem.New(cache.box);
                this.rewardItems[i] = cache
            end
            local obj = this.rewardItems[i]
            obj.go.transform:SetParent(_container, false);
            obj.rewardObj:SetData(1, v, 1, false, Vector3(0.6, 0.6, 0.6), false, true);

            SetActive(obj.get, isFinish)
            SetActive(obj.first, isFirst)
            SetActive(obj.go, true)
        end
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})