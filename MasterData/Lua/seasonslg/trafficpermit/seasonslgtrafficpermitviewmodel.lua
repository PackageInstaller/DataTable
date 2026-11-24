






require("SeasonSLG/TrafficPermit/SeasonSLGTrafficPermit_RewardItemGroup")
require("SeasonSLG/TrafficPermit/SeasonSLGTrafficPermit_RewardItem")
local this = { vm = nil };


local TIMER_ID = (TimerConst and TimerConst.SeasonSLGTrafficPermitCountDown) or 20047

local rewardItemGroupObj = nil;
local rewardItemObj = nil;
local rewardScrollView = nil;
local high_norUIList = nil;
local high_speUIList = nil;
local trafficPermitExp = nil;
local trafficPermitLevels = nil;
local themId = nil;

local cfgThemePass = nil;
local cfgRewards = {};
local reward_ScrollView = nil;
local spineCharacter = nil;
local dataPasses = nil;
local missionsDatas = nil;
local rewardsDatas = nil;
local taskBarIndex = 1;
local barIndex = 1;
local weekIndex = nil;
local weekAni = nil;
local isMaxLevel = false;
local isExpRewarding = false;
local isTaskRewarding = false;
local startIndex = 1;
local rewardNum = 51;
local isInit = false;
local lastLoc = nil;
local lastLevel = nil;
local lastExp = nil;
local trafficLevel = 0;
local passConfigList = nil;
local characterId = nil;

local rewards = {
    nor = {},
    high = {},
}

local taskBarColor1 = UnityEngine.Color(1, 1, 1, 1)
local taskBarColor2 = UnityEngine.Color(1, 1, 1, 1)

local data = {
    barList = {
        { isOn = false },
        { isOn = false }
    },
    weekList = {
        { isOn = false, color = taskBarColor1 },
        { isOn = false, color = taskBarColor1 },
        { isOn = false, color = taskBarColor1 },
        { isOn = false, color = taskBarColor1 },
        { isOn = false, color = taskBarColor1 },
        { isOn = false, color = taskBarColor1 }
    },
    contentList =
    {
        { content = "" },
        { content = "" },
        { content = "" },
    },
    buffContent = "",
    trafficPermitList = {
        {
            isOn = true,
            lock = false,
            icon = DefaultTexture,
        },
        {
            isOn = false,
            lock = true,
            icon = DefaultTexture,
        }
    },
    levelTagList = {
        { icon = DefaultSprite },
        { icon = DefaultSprite },
        { icon = DefaultSprite },
        { icon = DefaultSprite },
        { icon = DefaultSprite },
        { icon = DefaultSprite }
    },
    goodsList = {
        {}
    },
    taskBarList = {
        {
            isOn = true,
            color = taskBarColor1,
            time = "",
        },
        {
            isOn = false,
            color = taskBarColor2,
            time = "",
        },
        {
            isOn = false,
            color = taskBarColor2,
            time = "",
        },
    },
    taskList = {
        {
            id = "",
            jumpId = "",
            bg = DefaultSprite,
            des = "",
            rewarding = false,
            rewarded = false,
            rewardno = false,
            sliderValue = 0.0,
            sliderText = "",
            isTime = false,
            timeText = "",
            goods = { {} },
        }
    },
    middle_rewardBool = false,
    middle_taskBool = false,
    rewardExpContentSizeData = Vector2(0, 0),
    rewardExpContentAnchor = Vector2(0, 0),
    taskContentAnchor = Vector2(0, 0),
    top_Level = "",
    top_Exp = "",
    top_MaxExp = "",
    top_slider = 0.0,
    high_Num1 = "",
    showHighNum = false,
    time = "",
    time2 = "",
    levelSlider = 0.0,
    rewardAllBtnBool = false,
    activeTrafficBool = true,
    buyExpBool = false,
    rewardContentBool = true,

    bodyPath = "",
    offBodyPos = Vector2.zero,
    offBodyScale = Vector3.zero,
    rewardBuy = false,
    rewardNotBuy = true,
    lvShow = true,
    lvNotShow = false,
    showBuyBtn = true,
    characterName = "",
    characterRare = UnityEngine.Color(1, 1, 1, 1),
    characterJob = DefaultSprite,
}

local command = {



    expAllBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if not this.PassesIsRuning() then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("TrafficPermitViewModel_48"));
                return;
            end
            if barIndex == 1 and not isExpRewarding then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("TrafficPermitViewModel_49"));
                return;
            elseif barIndex == 2 and not isTaskRewarding then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("TrafficPermitViewModel_50"));
                return;
            end
            if barIndex == 1 then
                this.OnAskLevelReward("all", 2, function()
                    this.ParseData();
                end)
            else
                this.OnAskMissionReward("all", taskBarIndex, function()
                    this.ParseData();
                end)
            end
        end
    },



    rewardBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if not this.PassesIsRuning() then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("TrafficPermitViewModel_53"));
                return;
            end
            if param == nil then return end
            local index = tonumber(param) + 1;
            local task = this.vm.data.taskList and this.vm.data.taskList[index];
            if task ~= nil and task.id ~= nil then
                this.OnAskMissionReward(task.id, taskBarIndex, function()
                    this.ParseData();
                end)
            end
        end
    },



    jumpBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if param == nil then return end
            local index = tonumber(param) + 1;
            local task = this.vm.data.taskList and this.vm.data.taskList[index];
            if task ~= nil and task.jumpId ~= nil and task.jumpId ~= "" then
                FeatureManager.GotoViewModel(task.jumpId);
                HeroParameter.TrafficPermitTabIndex = 2;
            end
        end
    },



    buyExpBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.CheckExitPanel() then
                return
            end
            if not this.PassesIsRuning() then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("TrafficPermitViewModel_54"));
                return
            end
            if trafficLevel >= cfgThemePass.MaxLevel - 1 then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_35115"));
                return
            end
            if cfgThemePass == nil then
                return
            end
            LuaMgr.ShowLuaPanel(UIName.SeasonSLGTrafficPermitBuyTipViewModel,
                rewards, cfgThemePass.Id, function()
                    this.ParseData();
                end);
        end
    },



    activePayBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if not this.PassesIsRuning() then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("TrafficPermitViewModel_56"));
                return;
            end
            if cfgThemePass == nil then
                return
            end
            LuaMgr.ShowLuaPanel(UIName.SeasonSLGTrafficPermitPayViewModel, cfgThemePass.Id);
            RedMgr.Singleton:FrushRedCondition("18709");
        end
    },



    taskBarBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if param == nil then return end
            local index = tonumber(param);
            if index == nil then return end
            taskBarIndex = index;
            this.SetTaskBar(index);
        end
    },



    barBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if not this.PassesIsRuning() then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("TrafficPermitViewModel_51"));
                return;
            end
            if param == nil then return end
            local index = tonumber(param);
            if index == nil then return end
            barIndex = index;
            taskBarIndex = 1;
            this.SetBarState(index);
        end
    },



    weekBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if param == nil then return end
            local index = tonumber(param);
            if index == nil or index == weekIndex then return end
            weekIndex = index;
            weekAni = true;
            lastLoc = nil;
            this.SetWeekState(index);
            this.ParseData();
        end
    },



    skinBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if characterId ~= nil then
                LuaMgr.ShowPanel("Laigu.ViewModel.TakeCard.HeroAttrPreviewViewModel", characterId);
            end
        end
    }
}



this.ExpNorCommand = function(index)
    if not this.PassesIsRuning() then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("TrafficPermitViewModel_51"));
        return;
    end
    local rewardCfg = cfgRewards and cfgRewards[index];
    if rewardCfg == nil then
        return
    end
    local id = rewardCfg.Id;
    if not this.IsCanReward(id, false) then
        return
    end
    this.OnAskLevelReward(id, 0, function()
        this.ParseData();
    end)
end



this.ExpHighCommand = function(index)
    if not this.PassesIsRuning() then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("TrafficPermitViewModel_52"));
        return;
    end
    local rewardCfg = cfgRewards and cfgRewards[index];
    if rewardCfg == nil then
        return
    end
    local id = rewardCfg.Id;
    if not this.IsCanReward(id, true) then
        return
    end
    this.OnAskLevelReward(id, 1, function()
        this.ParseData();
    end)
end



this.ScrollCallBack = function(screenList)
    if IsNull(screenList) or #screenList == 0 then return end;
    local lastItem = screenList[#screenList];
    if lastItem == nil or lastItem.data == nil or lastItem.data.index == nil then return end;
    local index = lastItem.data.index
    index = math.ceil(index / 10) * 10
    if rewardNum ~= nil and index > rewardNum then
        index = rewardNum
    end
    if lastLoc == nil or lastLoc ~= index then
        lastLoc = index
        this.SetHighReward(index);
    end
end





this.OnAskLevelReward = function(pid, ptype, callBack)
    if this.CheckExitPanel() then
        return
    end
    if cfgThemePass == nil then
        return
    end
    local askData = {
        passesID = cfgThemePass.Id,
        id = pid,
        type = ptype,
    }
    ApiMgr.Request("passes/get_level_award", askData, true, function(result)
        local re = json.decode(result);
        if re and re.result then
            local data = json.encode(re.result);
            LuaMgr.ShowItemRewared(data);
        end
        if callBack ~= nil then
            callBack();
        end
    end, nil, true)
end





this.IsCanReward = function(id, isHigh)
    if rewardsDatas == nil or id == nil then
        return false;
    end
    local dataReward = rewardsDatas[id] or rewardsDatas[tonumber(id)] or rewardsDatas[tostring(id)];
    if dataReward == nil then
        return false;
    end
    local freeState, payState = SeasonSLGMapMgr.CheckSeasonSLGRewardState(dataReward, trafficLevel,
        this.IsChargeRecord(), rewardNum, dataPasses);
    local state = isHigh and payState or freeState;
    return state == 2;
end





this.OnAskMissionReward = function(pid, ptab, callBack)
    if this.CheckExitPanel() then
        return
    end
    if cfgThemePass == nil then
        return
    end
    local tag = "daily";
    if ptab == 2 then
        tag = "weekly"
    elseif ptab == 3 then
        tag = "period"
    end
    local askData = {
        passesID = cfgThemePass.Id,
        id = pid,
        tab = tag
    }
    ApiMgr.Request("passes/get_mission_award", askData, true, function(result)
        local re = json.decode(result);
        if re and re.result then
            local data = json.encode(re.result);
            LuaMgr.ShowItemRewared(data);
        end
        if callBack ~= nil then
            callBack();
        end
    end, nil, true)
end


this.OnPaySuccess = function()
    this.ParseData();
end

local hook = {


    before_awake = function(vm)
        this.vm = vm;
        local tf = this.vm.behaviour.transform;
        RedMgr.Singleton:RegisterViewModel(UIName.SeasonSLGTrafficPermitViewModel);
        reward_ScrollView = tf:Find("root/Left/Left_root/Middle_rewards/ScrollView"):GetComponent("ScrollRect");
        spineCharacter = tf:Find("root/Middle/right/Character/offset/body"):GetComponent("UISpineCharacter");
        rewardItemGroupObj = tf:Find("template/rewardItemGroup").gameObject
        rewardItemObj = tf:Find("template/rewardItem").gameObject
        rewardScrollView = UIScrollView.New(reward_ScrollView.gameObject)
        rewardScrollView.scrollCallBack = this.ScrollCallBack;

        high_norUIList = UIListView.New(tf:Find("root/Left/Left_root/Middle_rewards/High_1/normalReward"));
        high_speUIList = UIListView.New(tf:Find("root/Left/Left_root/Middle_rewards/High_1/highRewards"));
        this.GetPassConfigIDList()
    end,


    before_active = function(vm)
        this.vm = vm;
        LuaMgr.RemoveTimer(TIMER_ID);
        LuaMgr.AddTimer(TIMER_ID, this.UpdateCountDown, 1);

        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess, this.OnPaySuccess);
        LuaMgr.AddUIEventListener(UIEventConst.OnPaySuccess, this.OnPaySuccess);

        taskBarColor1 = HexToRGBA("#FBF5D5")
        taskBarColor2 = HexToRGBA("#cda5f7")
        lastLevel = nil;
        lastExp = nil;
        lastLoc = nil;
        isInit = true;
        barIndex = 1;
        taskBarIndex = 1;
        rewardNum = 51;
        themId = nil;
        weekIndex = nil;
        weekAni = nil;

        if vm and vm.behaviour and vm.behaviour.Params ~= nil and vm.behaviour.Params.Length > 0 then
            local p0 = vm.behaviour.Params[0];
            if type(p0) == "number" then
                weekIndex = p0;
            end
            if vm.behaviour.Params.Length > 1 then
                local p1 = vm.behaviour.Params[1];
                if type(p1) == "number" then
                    barIndex = p1;
                end
            end
        end

        this.ParseData();
    end,


    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TIMER_ID);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess, this.OnPaySuccess);

        if (spineCharacter ~= nil) then
            spineCharacter:Clear();
        end
        if rewardScrollView ~= nil then
            rewardScrollView:Clear(true)
        end
        if high_norUIList ~= nil then
            high_norUIList:Clear(true)
        end
        if high_speUIList ~= nil then
            high_speUIList:Clear(true)
        end
        dataPasses = nil;
        cfgThemePass = nil;
        missionsDatas = nil;
        rewardsDatas = nil;
    end,

    before_destroy = function()
        spineCharacter = nil;
        reward_ScrollView = nil;
        rewardScrollView = nil;
        high_norUIList = nil;
        high_speUIList = nil;
        rewardItemGroupObj = nil;
        rewardItemObj = nil;
        UIScrollView.ClearItem("SeasonSLGTrafficPermit_RewardItemGroup")
        UIListView.ClearItem("SeasonSLGTrafficPermit_RewardItem")
        RedMgr.Singleton:RemoveViewModel(UIName.SeasonSLGTrafficPermitViewModel);
    end
}


this.GetPassConfigIDList = function()
    passConfigList = SeasonSLGMapMgr.GetSeasonSLGPassConfigList();
end


this.ParseCfg = function()
    trafficPermitExp = {};
    cfgRewards = {};
    missionsDatas = {};
    rewardsDatas = {};
    cfgThemePass = nil;
    dataPasses = nil;

    if passConfigList == nil or #passConfigList == 0 then
        this.GetPassConfigIDList();
    end

    if weekIndex == nil then

        for i, v in ipairs(passConfigList or {}) do
            if SeasonSLGMapMgr.PassesIsCurRuning(v) == 0 then
                cfgThemePass = v
                weekIndex = i
                break
            end
        end

        if cfgThemePass == nil and passConfigList and #passConfigList > 0 then
            local fallbackIndex = 1
            for i, v in ipairs(passConfigList) do
                if SeasonSLGMapMgr.PassesIsCurRuning(v) == 1 then
                    fallbackIndex = i
                end
            end
            weekIndex = fallbackIndex
            cfgThemePass = passConfigList[fallbackIndex]
        end
    else
        if passConfigList and passConfigList[weekIndex] then
            cfgThemePass = passConfigList[weekIndex]
        end
    end


    if cfgThemePass ~= nil and DataMgr.Player ~= nil then
        if DataMgr.Player.passesMissionsMultiple ~= nil then
            missionsDatas = DataMgr.Player.passesMissionsMultiple[cfgThemePass.Id] or {}
        end
        if DataMgr.Player.passesRewardsMultiple ~= nil then
            rewardsDatas = DataMgr.Player.passesRewardsMultiple[cfgThemePass.Id] or {}
        end
        if DataMgr.Player.passesMultiple ~= nil then
            dataPasses = DataMgr.Player.passesMultiple[cfgThemePass.Id]
        end
    end

    this.SetWeekState(weekIndex);


    if rewardsDatas ~= nil and next(rewardsDatas) ~= nil then
        for _, v in pairs(rewardsDatas) do
            if v and v.id and ConfigMgr.Config and ConfigMgr.Config.PassesRewardMap and ConfigMgr.Config.PassesRewardMap[v.id] ~= nil then
                table.insert(cfgRewards, ConfigMgr.Config.PassesRewardMap[v.id])
            end
        end
    end


    if #cfgRewards == 0 and cfgThemePass ~= nil and ConfigMgr.Config and ConfigMgr.Config.PassesRewardMap ~= nil then
        for _, v in pairs(ConfigMgr.Config.PassesRewardMap) do
            if v and v.Passes == cfgThemePass.Id then
                table.insert(cfgRewards, v)
            end
        end
    end

    if cfgThemePass ~= nil then
        table.insert(trafficPermitExp, cfgThemePass.MaxLevel or 50);
        table.insert(trafficPermitExp, cfgThemePass.Exp or 100);
    else
        table.insert(trafficPermitExp, 50);
        table.insert(trafficPermitExp, 100);
    end

    if ConfigMgr.Config and ConfigMgr.Config.constants then
        trafficPermitLevels = ConfigMgr.Config.constants.TrafficPermitLevels;
    end
    table.sort(cfgRewards, function(a, b)
        return (tonumber(a.Id) or 0) < (tonumber(b.Id) or 0)
    end);
end



this.PassesIsRuning = function()
    return not IsNull(dataPasses) and dataPasses.endTime ~= nil and LuaMgr.Timestamp() < dataPasses.endTime
end



this.CheckExitPanel = function()
    return false;
end


this.ParseData = function()
    this.ParseCfg();
    this.vm.data.buffContent = ""
    if cfgThemePass ~= nil and cfgThemePass.SeasonBuff ~= nil then
        for _, v in ipairs(cfgThemePass.SeasonBuff) do
            local buff = ConfigMgr.Config and ConfigMgr.Config.SeasonalProduceBuffMap and ConfigMgr.Config.SeasonalProduceBuffMap[v]
            if buff ~= nil then
                this.vm.data.buffContent = this.vm.data.buffContent .. LuaMgr.GetLangText("SeasonSLGTrafficPermitViewModel_0") .. LuaMgr.GetLangText(buff.NameLan) .. "\n"
            end
        end
    end
    local maxLvl = (trafficPermitExp and trafficPermitExp[1]) or 50
    local width = (maxLvl * 95) + 50
    this.vm.data.rewardExpContentSizeData = Vector2(width, 522);
    this.SetCharacter();

    themId = (dataPasses and dataPasses.id) or (cfgThemePass and cfgThemePass.Id);
    this.SetLevelExp();
    if lastLoc ~= nil then
        this.SetHighReward(lastLoc);
    end
    if HeroParameter.TrafficPermitTabIndex ~= nil then
        barIndex = HeroParameter.TrafficPermitTabIndex;
        HeroParameter.TrafficPermitTabIndex = nil;
    end
    this.SetBarState(barIndex);
    this.SetTrafficPermitState();
    this.vm.data.showBuyBtn = cfgThemePass ~= nil and SeasonSLGMapMgr.PassesIsCurRuning(cfgThemePass) ~= -1;
end


this.SetCharacter = function()
    if cfgThemePass == nil or cfgThemePass.CharacterInfos == nil or cfgThemePass.CharacterInfos[1] == nil then
        return
    end
    characterId = cfgThemePass.CharacterInfos[1][1];
    local skinId = cfgThemePass.CharacterInfos[1][2];
    local path = HeroManager.SetCharacterDrawing(spineCharacter, characterId, skinId);
    if (path ~= "") then
        this.vm.data.bodyPath = path;
    end
    this.vm.data.offBodyPos = Vector2(tonumber(cfgThemePass.CharacterInfos[1][3]) or 0,
        tonumber(cfgThemePass.CharacterInfos[1][4]) or 0)
    this.vm.data.offBodyScale = Vector3.one * (tonumber(cfgThemePass.CharacterInfos[1][5]) or 1)
    local characterConfig = ConfigMgr.Config and ConfigMgr.Config.characterTable and ConfigMgr.Config.characterTable[characterId]
    if characterConfig ~= nil then
        this.vm.data.characterName = LuaMgr.GetLangText(characterConfig.namelan)
        this.vm.data.characterJob = LuaMgr.GetSprite("JobIcon", "job_" .. characterConfig.job)
        if (characterConfig.rare == 2) then
            this.vm.data.characterRare = UnityEngine.Color(33 / 225, 155 / 225, 161 / 225, 1)
        elseif (characterConfig.rare == 3) then
            this.vm.data.characterRare = UnityEngine.Color(216 / 225, 187 / 225, 70 / 225, 1)
        elseif (characterConfig.rare == 4) then
            this.vm.data.characterRare = UnityEngine.Color(236 / 225, 56 / 225, 57 / 225, 1)
        else
            this.vm.data.characterRare = UnityEngine.Color(0, 0, 0, 0)
        end
    end
end



this.SetWeekState = function(index)
    for i, v in ipairs(this.vm.data.weekList) do
        v.isOn = i == index;
        v.color = index == i and taskBarColor1 or taskBarColor2;
    end
end



this.SetBarState = function(index)
    for i, v in ipairs(this.vm.data.barList) do
        v.isOn = i == index;
    end
    this.vm.data.middle_rewardBool = index == 1;
    this.vm.data.middle_taskBool = index == 2;
    if index == 1 then

        this.ShowRewards();
        for i, v in ipairs(this.vm.data.taskBarList) do
            v.color = index == i and taskBarColor1 or taskBarColor2;
            v.isOn = index == i;
        end
        this.RefreshRed()
    else

        this.SetTaskBar(taskBarIndex);
    end
end



this.GetHighShowChargId = function()
    return SeasonSLGMapMgr.GetSeasonSLGHighShowChargeId(cfgThemePass, passConfigList);
end




this.IsPayCharge = function(charge_Id)
    return SeasonSLGMapMgr.IsSeasonSLGChargeAvailable(charge_Id);
end


this.SetLevelExp = function()
    if cfgThemePass == nil then
        return
    end
    trafficLevel = SeasonSLGMapMgr.GetSeasonSLGTrafficLevel(cfgThemePass);
    local maxLevel = (trafficPermitExp and trafficPermitExp[1]) or cfgThemePass.MaxLevel or 50;
    local expPerLevel = (trafficPermitExp and trafficPermitExp[2] and trafficPermitExp[2] > 0) and trafficPermitExp[2] or (cfgThemePass.Exp or 1);

    this.vm.data.lvShow = trafficLevel < maxLevel;
    this.vm.data.lvNotShow = trafficLevel >= maxLevel;

    local count = DataHelper.GetItemCountById(cfgThemePass.Expitems or "19");
    local curExp = count - (trafficLevel * expPerLevel);
    if curExp < 0 then
        curExp = 0;
    end

    this.vm.data.top_Level = trafficLevel;
    this.vm.data.top_Exp = curExp;
    this.vm.data.top_MaxExp = "/" .. expPerLevel;
    this.vm.data.top_slider = math.min(1.0, math.max(0.0, curExp / expPerLevel));

    lastLevel = trafficLevel;
    lastExp = curExp;

    local isPaid = this.IsChargeRecord();
    this.vm.data.rewardBuy = isPaid;
    this.vm.data.rewardNotBuy = not isPaid;
    this.vm.data.activeTrafficBool = this.IsPayCharge(this.GetHighShowChargId());

    this.UpdateCountDown();
end


this.UpdateCountDown = function()
    if this.vm == nil or this.vm.data == nil then
        return
    end
    local curTime = LuaMgr.Timestamp()


    if cfgThemePass ~= nil and SeasonSLGMapMgr.PassesIsCurRuning(cfgThemePass) == 0 then
        this.vm.data.time2 = ConfigMgr.LangGlobal("34255") .. SeasonSLGMapMgr.GetSeasonWeekLeftTime(true)
    else
        this.vm.data.time2 = ""
    end


    local endTime = 0
    if dataPasses ~= nil and not IsNullOrEmpty(dataPasses.id) and dataPasses.endTime ~= nil then
        endTime = dataPasses.endTime
    elseif cfgThemePass ~= nil and cfgThemePass.SeasonalEndTime ~= nil then
        endTime = cfgThemePass.SeasonalEndTime
    end
    local remainTime = math.max(0, endTime - curTime)
    this.vm.data.time = TimeString(remainTime) .. ConfigMgr.LangGlobal("10210")


    if this.vm.data.taskBarList ~= nil then
        local weekExpired = 0
        local periodExpired = 0
        if dataPasses ~= nil and dataPasses.tabExpired ~= nil then
            weekExpired = dataPasses.tabExpired.weekly or 0
            periodExpired = dataPasses.tabExpired.period or 0
        end
        local weekRemainTime = math.max(0, weekExpired - curTime)
        local periodRemainTime = math.max(0, periodExpired - curTime)
        if this.vm.data.taskBarList[2] ~= nil then
            this.vm.data.taskBarList[2].time = TimeString(weekRemainTime)
        end
        if this.vm.data.taskBarList[3] ~= nil then
            this.vm.data.taskBarList[3].time = TimeString(periodRemainTime)
        end
    end
end


this.SeasonTaskCountDown = this.UpdateCountDown;



this.IsChargeRecord = function()
    if cfgThemePass == nil or cfgThemePass.Charge1 == nil then
        return false
    end
    return SeasonSLGMapMgr.IsSeasonSLGPassPaid(cfgThemePass)
end


this.SetTrafficPermitState = function()
    local isOn = this.IsChargeRecord();
    this.vm.data.trafficPermitList[2].isOn = isOn;
    this.vm.data.trafficPermitList[2].lock = not isOn;
end



this.SetHighReward = function(index)
    if index == nil or rewardNum == nil or #cfgRewards == 0 then return end
    if index > rewardNum then
        index = rewardNum
    end
    if index <= 0 then
        index = 1
    end
    local targetRewardCfg = cfgRewards[index]
    if targetRewardCfg == nil then
        return
    end

    local isLast = index == rewardNum
    this.vm.data.showHighNum = isLast
    this.vm.data.high_Num1 = isLast and "" or string.format("%.2d", index);

    local norReward = this.GetRewardItem(targetRewardCfg, true)
    local sepReward = this.GetRewardItem(targetRewardCfg, false)

    local norList = {}
    for _, v in ipairs(norReward) do
        local dataItem = UIListData.GetData(rewardItemObj, "SeasonSLGTrafficPermit_RewardItem", v)
        table.insert(norList, dataItem);
    end
    if high_norUIList ~= nil then
        high_norUIList:SetData(norList, true)
    end

    local highList = {}
    for _, v in ipairs(sepReward) do
        local dataItem = UIListData.GetData(rewardItemObj, "SeasonSLGTrafficPermit_RewardItem", v)
        table.insert(highList, dataItem);
    end
    if high_speUIList ~= nil then
        high_speUIList:SetData(highList, true)
    end
end


this.ShowRewards = function()
    startIndex = 1;
    rewards = {
        nor = {},
        high = {},
    }
    local norRewardsList = {};
    local highRewardsList = {};
    isExpRewarding = false;
    local dataList = {};

    local maxLvl = (trafficPermitExp and trafficPermitExp[1]) or #cfgRewards
    for i = 1, maxLvl do
        local rewardCfg = cfgRewards[i]
        if rewardCfg ~= nil then
            if IsNull(rewardCfg.FreeReward) then
                table.insert(norRewardsList, {});
            else
                table.insert(norRewardsList, rewardCfg.FreeReward);
            end
            if IsNull(rewardCfg.PayReward) then
                table.insert(highRewardsList, {});
            else
                table.insert(highRewardsList, rewardCfg.PayReward);
            end
            local norItems, norIsRewarding = this.GetRewardItem(rewardCfg, true);
            local speItems, speIsRewarding = this.GetRewardItem(rewardCfg, false);
            local rewardItem = {
                index = i,
                num_1 = string.format("%.2d", i),
                normalItems = norItems,
                specialItems = speItems,
                rewardItemObj = rewardItemObj,
                callBackNor = this.ExpNorCommand,
                callBackSpe = this.ExpHighCommand,
                isNorRewarding = norIsRewarding,
                isSpeRewarding = speIsRewarding,
                isLast = false,
                weekAni = weekAni,
            }
            local rewardData = UIScrollData.GetData(rewardItemGroupObj, "SeasonSLGTrafficPermit_RewardItemGroup", 92, 387,
                rewardItem)
            table.insert(dataList, rewardData);
        end
    end

    if #dataList > 0 then
        dataList[#dataList].data.isLast = true
        for i, v in ipairs(dataList) do
            if #v.data.normalItems > 0 and not v.data.normalItems[1].isRewarded then
                startIndex = i
                break
            end
        end
    end

    rewardNum = #dataList
    rewards.nor = norRewardsList;
    rewards.high = highRewardsList;

    if rewardScrollView ~= nil then
        rewardScrollView:SetParams(553, 387)
        rewardScrollView:SetData(dataList, false, startIndex)
    end

    this.vm.data.rewardAllBtnBool = isExpRewarding;


    if lastLoc == nil and rewardNum > 0 then
        local initialHighLoc = math.ceil(startIndex / 10) * 10
        if initialHighLoc > rewardNum then
            initialHighLoc = rewardNum
        end
        lastLoc = initialHighLoc
        this.SetHighReward(lastLoc)
    end

    if isInit and rewardScrollView and rewardScrollView.screenList then
        coroutine_runner.start(function()
            if rewardScrollView and rewardScrollView.screenList then
                for i, v in ipairs(rewardScrollView.screenList) do
                    if v and v.DOAlphaAnimation then
                        v:DOAlphaAnimation(0.03 * i)
                    end
                end
            end
        end)
        isInit = false;
    end
end






this.GetRewardItem = function(rewardItem, isNor)
    local itemList = {}
    if rewardItem == nil then
        return itemList, false
    end
    local dataReward = nil
    if rewardsDatas ~= nil then
        dataReward = rewardsDatas[rewardItem.Id] or rewardsDatas[tonumber(rewardItem.Id)] or rewardsDatas[tostring(rewardItem.Id)]
    end
    local rewardsConfig = isNor and rewardItem.FreeReward or rewardItem.PayReward;
    local freeState, payState = SeasonSLGMapMgr.CheckSeasonSLGRewardState(dataReward, trafficLevel,
        this.IsChargeRecord(), rewardNum, dataPasses);
    local state = isNor and freeState or payState;
    if state == 2 then
        isExpRewarding = true;
    end

    if not IsNull(rewardsConfig) and #rewardsConfig > 0 then
        for _, v in ipairs(rewardsConfig) do
            local item = {
                item = v,
                isLock = state == 1,
                isRed = state == 2,
                isRewarded = state == 3,
                alpha = state == 2 and 1.0 or 0.9,
            }
            table.insert(itemList, item)
        end
    end
    return itemList, state == 2;
end



this.SetTaskBar = function(index)
    if not this.PassesIsRuning() then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("TrafficPermitViewModel_51"));
        return
    end
    for i, v in ipairs(this.vm.data.taskBarList) do
        v.color = index == i and taskBarColor1 or taskBarColor2;
        v.isOn = index == i;
    end
    this.ShowTask(index);
    this.RefreshRed()
end


this.RefreshRed = function()
    local cache = HeroRedDataHelper.FrushSeasonSLGTrafficPermitRed();
    if cache ~= nil and weekIndex ~= nil and cache[weekIndex] ~= nil then
        local curWeek = cache[weekIndex];
        local rRed = curWeek.rewardRed or 0;
        local dRed = curWeek.dayRed or 0;
        local wRed = curWeek.weekRed or 0;
        local aRed = curWeek.archRed or 0;

        RedMgr.Singleton:UpdateClientRedData("18712", rRed);
        local taskRed = dRed + wRed + aRed;
        RedMgr.Singleton:UpdateClientRedData("18713", taskRed);
        RedMgr.Singleton:UpdateClientRedData("18714", dRed);
        RedMgr.Singleton:UpdateClientRedData("18715", wRed);
        RedMgr.Singleton:UpdateClientRedData("18716", aRed);
        RedMgr.Singleton:Refresh();
    end
end



this.ShowTask = function(index)
    isTaskRewarding = false;
    this.vm.data.taskContentAnchor = Vector2(0, 0);
    this.vm.data.taskList = {};
    local list = {};
    local tasklist, passesMissions = this.GetCfgTaskListByType(index);
    local colorString = "%s";

    for _, v in ipairs(tasklist) do
        local dataTask = passesMissions and (passesMissions[v.Id] or passesMissions[tonumber(v.Id)] or passesMissions[tostring(v.Id)]);
        if dataTask ~= nil then
            local state = SeasonSLGMapMgr.CheckSeasonSLGTaskState(dataTask);
            local sortNum = 2;
            if state == 3 then
                colorString = "<color=#0b0a1b>%s</color>"
                sortNum = 3
            elseif state == 2 then
                isTaskRewarding = true;
                colorString = "<color=#eae3c0>%s</color>"
                sortNum = 1
            else
                colorString = "<color=#bebff0>%s</color>"
                sortNum = 2
            end
            local goodList = {};
            local expItemId = (cfgThemePass and cfgThemePass.Expitems) or "19";
            local item = ConfigHelper.CreateGoodsItem(expItemId, v.Exp or 0, 0.4, true, true);
            table.insert(goodList, item);

            local targetVal = (dataTask.target and dataTask.target > 0) and dataTask.target or 1;
            local curVal = dataTask.current or 0;
            local sliderProgress = math.min(1.0, math.max(0.0, curVal / targetVal));

            local taskItem =
            {
                bg = LuaMgr.GetSprite("SeasonSLG", "sjz-zlfy-txz-rw0" .. state),
                des = string.format(colorString, LuaMgr.GetLangText(v.Namelan)),
                rewarding = state == 2,
                rewarded = state == 3,
                rewardno = state == 1 and (cfgThemePass ~= nil and SeasonSLGMapMgr.PassesIsCurRuning(cfgThemePass) == 0 and not IsNullOrEmpty(v.PageSkip)),
                sliderValue = sliderProgress,
                sliderText = string.format(colorString, curVal .. "/" .. targetVal),
                goods = goodList,
                id = v.Id,
                jumpId = v.PageSkip,
                stateNum = sortNum,
                sort = v.Sort or 0,
                isTime = false
            }
            table.insert(list, taskItem);
        end
    end

    table.sort(list, function(a, b)
        if a.stateNum == b.stateNum then
            local aSort = a.sort or 0;
            local bSort = b.sort or 0;
            if aSort == bSort then
                return (tonumber(a.id) or 0) < (tonumber(b.id) or 0)
            end
            return aSort < bSort;
        end
        return a.stateNum < b.stateNum
    end)
    this.vm.data.taskList = list;
    this.vm.data.rewardAllBtnBool = isTaskRewarding;

    this.UpdateCountDown();
end





this.GetCfgTaskListByType = function(typeIndex)
    local taskList = {}
    local taskMap = {}
    if missionsDatas ~= nil then
        if typeIndex == 1 then
            taskMap = missionsDatas.daily or {}
        elseif typeIndex == 2 then
            taskMap = missionsDatas.weekly or {}
        elseif typeIndex == 3 then
            taskMap = missionsDatas.period or {}
        end
    end
    if taskMap ~= nil and ConfigMgr.Config and ConfigMgr.Config.PassesTaskMap ~= nil then
        for _, v in pairs(taskMap) do
            if v and v.id and ConfigMgr.Config.PassesTaskMap[v.id] ~= nil then
                table.insert(taskList, ConfigMgr.Config.PassesTaskMap[v.id])
            end
        end
    end
    table.sort(taskList, function(a, b)
        local aId = tonumber(a.Id) or 0
        local bId = tonumber(b.Id) or 0
        return aId < bId
    end)
    return taskList, taskMap;
end

return vm({
    data = data,
    command = command,
    hook = hook
})