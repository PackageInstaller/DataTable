
local this = {
    vm = nil,
    configCount1,
    configCount2,
    areaMap,areaExplore,lastIndex,StartDispatchBgRect,StartDispatchRect,
    IsClickStartDispatch = false,ITEM_ICON_FOLDER_PATH = "Assets/_BundleResources/Images/ItemIcons/",
    rewardDataList = {},ChickenMsgTr = nil,currentArea = nil,isInitExploreDucks = nil
}

local data = {
    redPoint=false;
    animName = "",
    dispatchRecordText = "",
    mapName = "",
    startDispatchIcon = DefaultTexture,
    startDispatchCost = "",
    startDispatchCount = "",
    dispatchingIcon = DefaultTexture,
    dispatchingCost = "",
    dispatchingCount = "",
    progress = "",
    introImage = DefaultSprite,
    introText = "",
    isStartDispatch = false,
    isCompleteState = false,
    isDispatching = false,
    isDispatchingAni = false,
    exploreDucks = {{ResDuck = "", TextLan = ""}},
    isShop = false,
    instructions = "",
    isShowChicken = false,

    rare_1 = DefaultSprite,
    rare_2 = DefaultSprite,
    icon_1 = DefaultTexture,
    icon_2 = DefaultTexture,
    count_1 = "",
    count_2 = "",
    isGet_1 = false,
    isGet_2 = false,
    text_1 = "",
    text_2 = "",
    bgIcon_1 = DefaultSprite,
    bgIcon_2 = DefaultSprite,
    rewardProgress = "",
    slider1 = 0.0,
    slider2 = 0.0,
    countItems = {{}},
}

local command = {
    backCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.AreaExploreViewModel)
        end
    },
    dispatchRecordCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.AreaExploreRecordViewModel, this.areaMap.area)
            LuaMgr.HidePanel(UIName.AreaExploreViewModel)
        end
    },
    startDispatchCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.IsClickStartDispatch then
                return
            end
            local data = {Area = this.areaMap.area}
            ApiMgr.Request("explore_area",data,true,this.ExploreAreaResponse,nil,true)
        end
    },
    dispatchingCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.AreaExploreViewModel)
            LuaMgr.ShowLuaPanel(UIName.AreaExploreResultViewModel, this.areaMap.area)
        end
    },
    chickenCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SetChickenInfo()
        end
    },
    btnClickGetReward = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = tonumber(param)
            local missionData = this.rewardDataList[index]
            if not missionData.completed and missionData.current >= MissionHelper.GetTargetCount(missionData.id) then
                local data = {
                    Tab = this.areaMap.area,
                    MissionID = missionData.id
                }
                ApiMgr.Request("complete_mission",data,true,this.MissionReward,nil,true)
            else
                local missionRow = ConfigMgr.Config.missionMap[missionData.id]
                local reward = ConfigMgr.Config.itemMap[missionRow.rewards[1].itemId]
                LuaMgr.ShowPanel(UIName.GoodsTipsViewModel, reward.id, true,false,false)
            end
        end
    },
    shopCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickShop()
        end
    },
    costClickCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local itemId = this.areaMap.exploreCost[1].itemId
            LuaMgr.ShowPanel(UIName.GoodsTipsViewModel,itemId,true,true,true)
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;

        if not this.StartDispatchBgRect then
            this.StartDispatchBgRect = vm.behaviour.transform:Find("root/Middle/StartDispatch/CL/CLBg")
            this.StartDispatchRect = vm.behaviour.transform:Find("root/Middle/StartDispatch")
        end
        if this.ChickenMsgTr == nil then
            this.ChickenMsgTr = vm.behaviour.transform:Find("root/Middle/Chicken/Msg"):GetComponent('RectTransform')
        end
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then return end
        
        RedMgr.Singleton:RegisterViewModel(UIName.AreaExploreViewModel);
        LuaMgr.RemoveUIEventListener(UIEventConst.AreaExplorePanelShow,this.OnAnimatorPlayFinish)
        LuaMgr.AddUIEventListener(UIEventConst.AreaExplorePanelShow, this.OnAnimatorPlayFinish);
        LuaMgr.InvokeUIEventListeners(UIEventConst.AreaExplorePanelOpen)
        this.vm.data.animName = "UI_AreaExplorePanel_01"
        this.StartDispatchBgRect.rotation = UnityEngine.Quaternion.Euler(Vector3(0, 0, 0))
        this.isInitExploreDucks = false
        this.lastIndex = -1;
        this.currentArea = vm.behaviour.Params[0]
        this.SetData()
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.AreaExplorePanelShow, this.OnAnimatorPlayFinish);
        LuaMgr.InvokeUIEventListeners(UIEventConst.AreaExplorePanelClose)
        this.IsClickStartDispatch = false
        coroutine_runner.stopAll();
    end,
    before_destroy = function(vm)
        this = nil
    end,
}

this.SetData = function()
    this.areaMap = ConfigMgr.Config.areas[this.currentArea];
    if not this.areaMap then
        return
    end

    this.areaExplore = DataMgr.Player.areaExplores[this.currentArea];
    if not this.areaExplore then
        return
    end

    this.vm.data.mapName = LuaMgr.GetLangText(this.areaMap.mapTitlelan)
    this.InitMapCount()
    
    if IsNull(this.areaExplore.currentExplores) or next(this.areaExplore.currentExplores) == nil then
        local stateBool = this.configCount2 == 0 and this.configCount1 == ConfigHelper.GetTableLength(this.areaExplore.completedExplores)
        this.vm.data.isStartDispatch = not stateBool
        this.vm.data.isCompleteState = stateBool
        this.vm.data.isDispatching = false
        this.vm.data.progress=""
    else
        this.vm.data.isStartDispatch = false
        this.vm.data.isCompleteState = false
        this.vm.data.isDispatching = true
        this.vm.data.isDispatchingAni = true

        local count = 0
        local totalCount = 0
for i, item in pairs(this.areaExplore.currentExplores) do
            if item.status == 0 then
                count = count + 1;
            end
            totalCount = totalCount + 1;
        end
        this.vm.data.progress = count .. "/" .. totalCount;
    end

    if #this.areaMap.exploreCost > 0 then
        local itemId = this.areaMap.exploreCost[1].itemId;
        local itemConfig = ConfigMgr.Config.itemMap[itemId];
        if not itemConfig then
            return
        end

        local itemIconPath = ConfigHelper.GetItemIconPath(itemId)
        this.vm.data.startDispatchIcon = LuaMgr.GetTexture(itemIconPath)
        this.vm.data.dispatchingIcon = LuaMgr.GetTexture(itemIconPath)
        local haveString;
        local maxHave = itemConfig.maxHave == 0 and "" or itemConfig.maxHave;
        local exploreCost = this.areaMap.exploreCost[1].count;
        local haveCount = DataHelper.GetItemCountById(itemId);

        if (haveCount < exploreCost) then
            this.vm.data.redPoint=false;
            haveString = string.format("<color=#d73030>%s</color>/%s", haveCount, maxHave);
        else
            this.vm.data.redPoint=true;
            if this.vm.data.isCompleteState then
                haveString = string.format("<color=#2cf2f0>%s</color>/%s", haveCount, maxHave);
            else
                haveString = string.format("<color=#007a7e>%s</color>/%s", haveCount, maxHave);
            end
        end
        this.vm.data.startDispatchCount = haveString
        this.vm.data.dispatchingCount = haveString
        this.vm.data.startDispatchCost = exploreCost
        this.vm.data.dispatchingCost = exploreCost
    end

    this.vm.data.isShowChicken = false
    LuaMgr.NextFrame(function()
        this.vm.data.isShowChicken = not LuaMgr.IsGuide()
    end)
    this.vm.data.instructions = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2440"].NameLan)
    this.SetDispatchRecord();
    this.SetChickenInfo();
    this.SetShop()
end

this.InitMapCount = function()
    this.configCount1,this.configCount2 = 0,0
    local surveyEvents = ConfigAreaMgr.GetAreaMapSurveyEvent(this.areaMap.area)
    local tempList = {}
    local rareCount = {0, 0, 0, 0}
    local totalCount = {0, 0, 0, 0}
    local completedExplores = this.areaExplore.completedExplores;
    if not IsNull(completedExplores) then
        for i, v in ipairs(surveyEvents or {}) do
            if v.uniqueness == 1 then this.configCount1 = this.configCount1 + 1 end
            if v.uniqueness == 2 then this.configCount2 = this.configCount2 + 1 end
            totalCount[v.rare] = totalCount[v.rare] + 1
            if completedExplores[v.id] then
                rareCount[v.rare] = rareCount[v.rare] + 1
            end
        end
    end

    for i = 1, 4 do
        local countItem = {}
        countItem.countRara = LuaMgr.GetSprite("ExploreRes", "ui_dc_icon" .. i)
        local countStr
        if rareCount[i] == totalCount[i] then
            countStr = "<color=#316c6a>%s</color>/%s"
        else
            countStr = "<color=#d12a2a>%s</color>/%s";
        end
        countItem.countText = string.format(countStr, rareCount[i], totalCount[i])
        table.insert(tempList, countItem)
    end
    this.vm.data.countItems = tempList
    this.Progress("204")
end

this.Progress = function(eventType)
    local missionProgress = table.Copy(DataMgr.Player.missions[this.areaMap.area][eventType])
    local missionList = {}
    for i, v in pairs(missionProgress) do
        table.insert(missionList, v)
    end
    table.sort(missionList, function(a, b) 
        return MissionHelper.GetTargetCount(a.id) < MissionHelper.GetTargetCount(b.id)
    end)
    local missionData = nil
    this.rewardDataList = {}
    local current = 0
    local target1 = 0
    local target2 = 0
    for i, v in ipairs(missionList) do
        missionData = v
        if missionData == nil then
            return
        end
        local missionRow = ConfigMgr.Config.missionMap[missionData.id]
        local reward = ConfigMgr.Config.itemMap[missionRow.rewards[1].itemId]
        this.rewardDataList[i] = missionData
        local targetCount = MissionHelper.GetTargetCount(missionData.id)
        if not missionData.completed and missionData.current == targetCount then
            RedMgr.Singleton:UpdateClientRedData("1063_".. i, 1);
        else
            RedMgr.Singleton:UpdateClientRedData("1063_".. i, 0);
        end
        RedMgr.Singleton:RefreshOtherViewModel(UIName.AreaExploreViewModel)
        
        this.vm.data["isGet_" .. i] = missionData.completed
        this.vm.data["bgIcon_" .. i] = LuaMgr.GetSprite("ExploreRes", missionData.completed and "ui_dc_jdt_icon3" or "ui_dc_jdt_icon2")
        this.vm.data["rare_" .. i] = LuaMgr.GetSprite("ItemRare", "itemRare" .. reward.rare)
        this.vm.data["icon_" .. i] = LuaMgr.GetTexture(this.ITEM_ICON_FOLDER_PATH .. "itemicon_" .. reward.id .. ".png")
        this.vm.data["count_" .. i] = missionRow.rewards[1].count
        this.vm.data["text_" .. i] = targetCount
        if i == 1 then
            target1 = targetCount
        elseif i == 2 then
            target2 = targetCount            
        end
        current = missionData.current
    end
    this.vm.data.slider1 = current / target1
    this.vm.data.slider2 = (current - target1) / (target2 - target1)
    
    this.vm.data.redPoint=(this.vm.data.redPoint and (current<target2));
    
    this.vm.data.rewardProgress = string.format("%s/%s", current, target2)
end

this.SetDispatchRecord = function()
    local current = 0;
    local total = 0;
    local areaExplores = ConfigAreaMgr.GetAreaMapSurveyEvent(this.areaMap.area);
    if IsNull(areaExplores) then return end;
    local completedExplores = this.areaExplore.completedExplores;
    for i, item in ipairs(areaExplores) do
        if (not IsNull(completedExplores)) and completedExplores[item.id] then
            current = current + 1
        end
        total = total + 1
        this.vm.data.dispatchRecordText = string.format("<color=#262429>%s</color>/%s", current, total)  
    end
end

this.SetChickenInfo = function()
    if not this.isInitExploreDucks then
        this.isInitExploreDucks = true
        local chickenInfos = {}
        local cfg = ConfigMgr.Config.ExploreDuckMap
        for i, item in pairs(cfg) do
            if string.find(item.Map, this.areaMap.area) then
                local tempItem = {
                    ResDuck = item.ResDuck,
                    Text = LuaMgr.GetLangText(item.TextLan)
                }
                table.insert(chickenInfos, tempItem)
            end
        end
        this.vm.data.exploreDucks = chickenInfos
    end
    local tipsIndex = this.GetRandomNum();
    this.vm.data.introImage = LuaMgr.GetSprite("ExploreChicken", this.vm.data.exploreDucks[tipsIndex].ResDuck)
    this.vm.data.introText = this.vm.data.exploreDucks[tipsIndex].Text
    RectTool.RebuildLayoutImmediate(this.ChickenMsgTr)
    LuaMgr.NextFrame(function()
        RectTool.RebuildLayoutImmediate(this.ChickenMsgTr)
    end)
end

this.SetShop = function()
    if FeatureManager.IsLock("2300") then
        this.vm.data.isShop = false
    else
        this.vm.data.isShop = true
        if UnityEngine.PlayerPrefs.GetInt(DataMgr.Player.uid .. "1030") == 0 then
            RedMgr.Singleton:UpdateClientRedData("1030", 1);
        else
            RedMgr.Singleton:UpdateClientRedData("1030", 0);
        end
    end
end

this.OnClickShop = function()
    UnityEngine.PlayerPrefs.SetInt(DataMgr.Player.uid .. "1030", 1);
    AreaMapSceneMgr.isEnterShop = true;
    LuaMgr.ShowLuaPanel(UIName.MarketViewModel,"area_" .. this.currentArea)
    LuaMgr.HidePanel(UIName.AreaExploreViewModel)
end

this.ExploreAreaResponse = function(result)
    coroutine_runner.stopAll();

    local positionY = 43
    coroutine_runner.start(function()
        while true do
            coroutine_runner.wait(0.02);
            positionY = positionY - 20
            this.StartDispatchRect.localPosition = Vector3(2, positionY, 0)
            if math.abs(positionY + 570) < 10 then
                this.OnStartDispatch()
            end
        end
    end)
    this.IsClickStartDispatch = true
    LuaMgr.InvokeUIEventListeners(UIEventConst.AreaExploreRewardRefresh)
end

this.OnStartDispatch = function()
    LuaMgr.ShowLuaPanel(UIName.AreaExploreAniViewModel, this.areaMap.area);
    LuaMgr.HidePanel(UIName.AreaExploreViewModel)
end

this.OnAnimatorPlayFinish = function(args)
    LuaMgr.RemoveUIEventListener(UIEventConst.AreaExplorePanelShow, this.OnAnimatorPlayFinish);
    this.StartDispatchRect.localPosition = Vector3(2, 43, 0)
    local rotationZ = 360
    coroutine_runner.start(function()
        while true do
            coroutine_runner.wait(0.03);
            rotationZ = rotationZ - 1
            if rotationZ < 0 then
                rotationZ = 360 + rotationZ 
            end
            this.StartDispatchBgRect.rotation = UnityEngine.Quaternion.Euler(Vector3(0, 0, rotationZ))
        end
    end)
end

this.GetRandomNum = function()
    local tipsIndex = math.random(1, #this.vm.data.exploreDucks);
    if this.lastIndex == tipsIndex then
        this.GetRandomNum();
    else
        this.lastIndex = tipsIndex;
    end
    return this.lastIndex;
end

this.MissionReward = function(result)
    local re=json.decode(result);
    local data=json.encode(re.result);
    LuaMgr.ShowItemRewared(data)
    this.Progress("204")
    LuaMgr.InvokeUIEventListeners(UIEventConst.AreaExploreRewardRefresh)
end

return vm({
    data = data,
    command = command,
    hook = hook,
})