




require("ViewModel/Passes/Passes_RewardItemGroup")
require("ViewModel/Passes/Passes_RewardItem")
require("ViewModel/Passes/Passes_TaskItem")
local this = { vm = nil,

};

local panelSoundComp = nil

local rewardItemGroupObj = nil;
local rewardItemObj = nil;
local rewardScrollView = nil;
local high_norUIList = nil
local high_speUIList = nil;
local trafficPermitExp = nil;
local trafficPermitLevels = nil;
local payNowUIList = nil;
local payContinuousList = nil;
local payLockUIList = nil;
local chargeId = nil;
local order = nil;
local paying = false;
local medalActivityID = nil
local medalColor = nil
local medalImgKey = nil
local bgmPath = nil


local cfgThemePass = {};
local cfgRewards = {};
local reward_ScrollView = nil;
local dataPasses = nil;
local isExpRewarding = false;
local startIndex = nil;
local isInit = false;
local lastLoc = nil;
local trafficLevel = nil;

local goPayLock = nil;
local goPopBuy = nil;
local tranNowContent = nil;
local tranContinuousContent = nil;
local tranLockContent = nil;
local tranNormalReward = nil;
local tranHighRewards = nil;
local txtTime = nil;
local txtNum = nil;
local txtPrice = nil;
local btnMainBuy = nil;
local btnTask = nil;
local btnReward = nil;
local btnMask = nil;
local btnPay = nil;
local curScoreNum = nil;
local txtRatio = nil;
local goUnFinish1 = nil;
local goFinish1 = nil;
local imgIcon1 = nil;
local goUnFinish2 = nil;
local imgIcon2 = nil;
local goFinish2 = nil;
local goMain = nil;
local goTask = nil;
local imgMingke = nil;
local imgSelect = nil;


local tabIndex = nil;

local themId = nil
local taskBarIndex = nil;
local dataPassesMissions = nil;
local isTaskRewarding = false;
local isMaxExp = nil;
local norReward = nil;
local highReward = nil;
local taskUIList = nil
local taskItemObj = nil
local goWeek = nil;
local goAchieve = nil;
local btnWeek = nil;
local btnAchieve = nil;
local btnRewardAll = nil;
local tranTaskContent = nil;
local imgSlider = nil;
local txtPro = nil;
local txtMax = nil;



this.Init = function(prefab)
    panelSoundComp = prefab.gameObject:GetComponent("UIPanelSound");
    local uiLink = prefab.gameObject:GetComponent("UILink");

    goPayLock = uiLink:Get("goPayLock");
    goPopBuy = uiLink:Get("goPopBuy");
    goMain = uiLink:Get("goMain");
    goTask = uiLink:Get("goTask");
    reward_ScrollView = uiLink:Get("ScrollViewMain"):GetComponent("ScrollRect");
tranNowContent = uiLink:Get("tranNowContent"):GetComponent("RectTransform");
    tranContinuousContent = uiLink:Get("tranContinuousContent"):GetComponent("RectTransform");
    tranLockContent = uiLink:Get("tranLockContent"):GetComponent("RectTransform");
    tranNormalReward = uiLink:Get("tranNormalReward"):GetComponent("RectTransform");
    tranHighRewards = uiLink:Get("tranHighRewards"):GetComponent("RectTransform");
    txtTime = uiLink:Get("txtTime"):GetComponent("Text");
    txtNum = uiLink:Get("txtNum"):GetComponent("Text");
    txtPrice = uiLink:Get("txtPrice"):GetComponent("Text");
    btnMainBuy = uiLink:Get("btnMainBuy"):GetComponent("Button");
    btnTask = uiLink:Get("btnTask"):GetComponent("Button");
    btnReward = uiLink:Get("btnMainReward"):GetComponent("Button");
    btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    btnPay = uiLink:Get("btnPay"):GetComponent("Button");
    curScoreNum = uiLink:Get("txtLevel"):GetComponent("Text");
    txtRatio = uiLink:Get("txtRatio"):GetComponent("Text");
    goUnFinish1 = uiLink:Get("goUnFinish1");
    goFinish1 = uiLink:Get("goFinish1");
    imgIcon1 = uiLink:Get("imgIcon1"):GetComponent("Image");
    goUnFinish2 = uiLink:Get("goUnFinish2");
    goFinish2 = uiLink:Get("goFinish2");
    imgIcon2 = uiLink:Get("imgIcon2"):GetComponent("Image");
    imgMingke = uiLink:Get("imgMingke"):GetComponent("RawImage");
    imgSelect = uiLink:Get("imgSelect"):GetComponent("RectTransform");


    goWeek = uiLink:Get("goWeek");
    goAchieve = uiLink:Get("goAchieve");
    norReward = uiLink:Get("goNormal");
    highReward = uiLink:Get("goHigh");
    btnWeek = uiLink:Get("btnWeek"):GetComponent("Button");
    btnAchieve = uiLink:Get("btnAchieve"):GetComponent("Button");
    btnRewardAll = uiLink:Get("btnRewardAll"):GetComponent("Button");
    tranTaskContent = uiLink:Get("tranTaskContent"):GetComponent("RectTransform");
    imgSlider = uiLink:Get("imgSlider"):GetComponent("Image");
    txtPro = uiLink:Get("txtPro"):GetComponent("Text");
    txtMax = uiLink:Get("txtMax"):GetComponent("Text");


    this.AddRigister(uiLink);
end


this.Clear = function()

    goPayLock = nil;
    goPopBuy = nil;
    goMain = nil;
    goTask = nil;
    reward_ScrollView = nil;
    tranNowContent = nil;
    tranContinuousContent = nil;
    tranLockContent = nil;
    tranNormalReward = nil;
    tranHighRewards = nil;
    txtTime = nil;
    txtNum = nil;
    txtPrice = nil;
    btnMainBuy = nil;
    btnTask = nil;
    btnReward = nil;
    btnMask = nil;
    btnPay = nil;
    txtRatio = nil;
    goUnFinish1 = nil;
    goFinish1 = nil;
    imgIcon1 = nil;
    goUnFinish2 = nil;
    goFinish2 = nil;
    imgIcon2 = nil;
    imgMingke = nil;
    imgSelect = nil;


    goWeek = nil;
    goAchieve = nil;
    btnWeek = nil;
    btnAchieve = nil;
    btnRewardAll = nil;
    tranTaskContent = nil;
    imgSlider = nil;
    txtPro = nil;
    txtMax = nil;

end



this.AddRigister = function(uiLink)

    uiLink:AddClickEvent("btnMainReward", function()
        if not this.PassesIsRuning() then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("18002"));
            return;
        end
        if not isExpRewarding then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("TrafficPermitViewModel_49"));
            return;
        end
        this.OnAskLevelReward("all", 2, function()
            this.ParseData();
        end)
    end)
    uiLink:AddClickEvent("btnTask", function()
        if (tabIndex == 2) then
            return
        end
        this.SwitchTab(2)
    end)
    uiLink:AddClickEvent("btnMask", function()
        SetActive(goPopBuy, false);
    end)
    uiLink:AddClickEvent("btnMainBuy", function()
        if not this.IsChargeRecord() then
            SetActive(goPopBuy, true);
            this.SetPayInfo();
        end
    end)
    uiLink:AddClickEvent("btnPay", function()
        this.OnAskPay();
    end)
    uiLink:AddClickEvent("btnMK", function()
        LuaMgr.ShowLuaPanel(UIName.ActivityCollect2Panel, medalActivityID, medalColor, medalImgKey)
    end)
    uiLink:AddClickEvent("btnReturn", function()
        if (tabIndex == 1) then
            return
        end
        this.SwitchTab(1)
    end)


    uiLink:AddClickEvent("btnWeek", function()
        taskBarIndex = 1;
        this.SetTopBarState();
    end)
    uiLink:AddClickEvent("btnAchieve", function()
        taskBarIndex = 2;
        this.SetTopBarState();
    end)
    uiLink:AddClickEvent("btnRewardAll", function()
        if not this.PassesIsRuning() then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("18002"));
            return;
        end
        this.OnAskMissionReward("all", function()
            this.ParseTaskData();
        end)
    end)
    uiLink:AddClickEvent("btnTaskBuy", function()
        if not this.PassesIsRuning() then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("18002"));
            return;
        end
        if isMaxExp then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("18003"));
            return
        end
        LuaMgr.ShowLuaPanel(UIName.PassesBuyTip2ViewModel, themId, function()
            this.ParseTaskData();
        end);
    end)
end


local data = {
}


this.ExpNorCommand = function(index)
    if not this.PassesIsRuning() then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("18002"));
        return;
    end
    local id = cfgRewards[index].Id;
    if not this.IsCanReward(id, false) then
        return
    end
    this.OnAskLevelReward(id, 0, function()
        this.ParseData();
    end)
end

this.ExpHighCommand = function(index)
    if not this.PassesIsRuning() then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("18002"));
        return;
    end
    local id = cfgRewards[index].Id;
    if not this.IsCanReward(id, true) then
        return
    end
    this.OnAskLevelReward(id, 1, function()
        this.ParseData();
    end)
end

this.ScrollCallBack = function(screenList)
    if IsNull(screenList) or #screenList == 0 then return end;
    local index = screenList[#screenList].data.index
    index = math.ceil(index / 10) * 10
    if lastLoc == nil or lastLoc ~= index then
        lastLoc = index
        this.SetHighReward(index);
    end
end




this.OnAskLevelReward = function(pid, ptype, callBack)
    local askData = {
        passesID = cfgThemePass.Id,
        id = pid,
        type = ptype,
    }
    ApiMgr.Request("passes/get_level_award", askData, true, function(result)
        local re = json.decode(result);
        local data = json.encode(re.result);
        LuaMgr.ShowItemRewared(data);
        if callBack ~= nil then
            callBack();
        end
    end, nil, true)
end



this.IsCanReward = function(id, isHigh)
    if isHigh and not this.IsChargeRecord() then
        return false;
    end
    local passesRewards = DataMgr.Player.passesRewardsMultiple[cfgThemePass.Id];
    if passesRewards[id] == nil or passesRewards[id].level > trafficLevel then
        return false
    end
    if isHigh and passesRewards[id].payReceiveTime > 0 then
        return false;
    end
    if not isHigh and passesRewards[id].freeReceiveTime > 0 then
        return false;
    end
    return true;
end

this.FrushData = function()
    this.ParseData();
end


this.SetPayInfo = function()
    local curCharge = ConfigMgr.Config.charge[chargeId];
    local chargeChannel = ConfigHelper.GetChargeChannel(curCharge.ChargeGroup);
    txtPrice.text = chargeChannel.CurrencySymbol .. chargeChannel.PriceShow;

    local nowRewards = curCharge.Reward;
    local nowList = {}
    local goodsItemScale = 0.6
    if not IsNull(nowRewards) then
        for i, v in ipairs(nowRewards) do
            local item = {
                item = v,
                isLock = false,
                isRed = false,
                isRewarded = false,
                alpha = 1,
                scale = goodsItemScale,
            }
            local itemData = UIListData.GetData(rewardItemObj, "Passes_RewardItem", item);
            table.insert(nowList, itemData);
        end
        payNowUIList:SetData(nowList);
    end

    local continuousRewards = {}
    if not IsNull(cfgThemePass) and not IsNull(cfgThemePass.RenewalBonusDisplay) then
        for i, v in ipairs(cfgThemePass.RenewalBonusDisplay) do
            local item = {
                item = { id = v[1], count = v[2] },
                isLock = false,
                isRed = false,
                isRewarded = false,
                alpha = 1,
                scale = goodsItemScale,
            }
            local itemData = UIListData.GetData(rewardItemObj, "Passes_RewardItem", item);
            table.insert(continuousRewards, itemData);
        end
        payContinuousList:SetData(continuousRewards);
    end

    local lockList = {}
    local unLockRewards = cfgThemePass.ShowRewards
    if not IsNull(unLockRewards) then
        for i, v in ipairs(unLockRewards) do
            local item = {
                item = { id = v[1], count = v[2] },
                isLock = false,
                isRed = false,
                isRewarded = false,
                alpha = 1,
                scale = goodsItemScale,
            }
            local itemData = UIListData.GetData(rewardItemObj, "Passes_RewardItem", item);
            table.insert(lockList, itemData);
        end
        payLockUIList:SetData(lockList);
    end
end

this.OnAskPay = function()
    if not this.PassesIsRuning() then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("18002"));
        return;
    end
    if paying then return end;
    if this.IsChargeRecord() then
        return;
    end
    paying = true;
    LuaMgr.LuaOnAskPay(chargeId);
end


this.PayOrder = function(data)
    if data.Length == 2 then
        local reChargeId = tostring(data[0]);
        order = tostring(data[1]);
        if chargeId ~= reChargeId then return end;
        if LuaMgr.GetPlatform() ~= "EDITOR" then return end;
        LuaMgr.RemoveTimer(TimerConst.FristPayRechargeStatus)
        LuaMgr.AddTimer(TimerConst.FristPayRechargeStatus, this.OnTimer, 1, 100, true);
    end
end

this.OnPayResult = function(data)
    if data.Length == 1 then
        if order ~= nil and order ~= tostring(data[0]) then return end;
        paying = false;
    end
end

this.OnPaySuccess = function(data)
    if data.Length == 1 then
        if order ~= nil and order ~= tostring(data[0]) then return end;
        this.ParseData();
    end
end

this.OnTimer = function()
    local askData = { order = order }
    ApiMgr.Request("check_recharge_status", askData, true, function(result)
        local re = json.decode(result);
        if re.result.status == 2 then
            LuaMgr.RemoveTimer(TimerConst.FristPayRechargeStatus)
            local rewards = re.result.rewards;
            if rewards ~= nil then
                local data = json.encode(rewards);
                LuaMgr.ShowItemRewared(data);
            end
            paying = false;
            this.ParseData();
        end
    end, nil, true);
end


this.ParseCfg = function()
    cfgThemePass = {};
    trafficPermitExp = {};
    cfgRewards = {};
    for i, v in pairs(DataMgr.Player.passesMultiple) do
        if ConfigMgr.Config.PassesMap[v.id].type == 2 then
            cfgThemePass = ConfigMgr.Config.PassesMap[v.id];
            dataPasses = v;
            break;
        end
    end
    chargeId = cfgThemePass.Charge1[1];
    for i, v in pairs(DataMgr.Player.passesRewardsMultiple[cfgThemePass.Id]) do
        table.insert(cfgRewards, ConfigMgr.Config.PassesRewardMap[v.id])
    end

    table.insert(trafficPermitExp, cfgThemePass.MaxLevel);
    table.insert(trafficPermitExp, cfgThemePass.Exp);
    trafficPermitLevels = ConfigMgr.Config.constants.TrafficPermitLevels;
    table.sort(cfgRewards, function(a, b) return a.Id < b.Id end);
end

this.PassesIsRuning = function()
    return not IsNull(dataPasses) and LuaMgr.Timestamp() < dataPasses.endTime;
end


this.ParseData = function()
    paying = false;
    this.ParseCfg();
    SetActive(goPopBuy, false);
    local count = DataHelper.GetItemCountById(cfgThemePass.Expitems);
    trafficLevel = math.floor(count / trafficPermitExp[2]);
    curScoreNum.text = count
    if lastLoc ~= nil then
        this.SetHighReward(lastLoc);
    end
    this.ShowRewards();
    SetActive(goPayLock, not this.IsChargeRecord())
    local remainTime = dataPasses.endTime - LuaMgr.Timestamp()
    if remainTime < 0 then
        remainTime = 0;
    end
    txtTime.text = TimeString(remainTime) .. ConfigMgr.LangGlobal("10210")
    SetActive(btnMainBuy.gameObject, not this.IsChargeRecord());
end


this.IsChargeRecord = function()
    return not IsNull(dataPasses) and dataPasses.payRecord[cfgThemePass.Charge1[1]] ~= nil
end



this.SetHighReward = function(index)
    txtNum.text = string.format("%s", index * cfgThemePass.Exp);
    local norReward = this.GetRewardItem(cfgRewards[index], true)
    local sepReward = this.GetRewardItem(cfgRewards[index], false)
    local norList = {}
    for i, v in ipairs(norReward) do
        local dataItem = UIListData.GetData(rewardItemObj, "Passes_RewardItem", v)
        table.insert(norList, dataItem);
    end
    high_norUIList:SetData(norList, true)
    local highList = {}
    for i, v in ipairs(sepReward) do
        local dataItem = UIListData.GetData(rewardItemObj, "Passes_RewardItem", v)
        table.insert(highList, dataItem);
    end
    high_speUIList:SetData(highList, true)
end


this.ShowRewards = function()
    startIndex = 0;
    isExpRewarding = false;
    local dataList = {};
    for i, v in ipairs(cfgRewards) do
        local norItems, norIsRewarding = this.GetRewardItem(v, true);
        local speItems, speIsRewarding = this.GetRewardItem(v, false);
        local rewardItem = {
            index = i,
            num_1 = not norItems[1].isRewarded and string.format("%s", i * cfgThemePass.Exp) or
                string.format("<color=#98a7b3>%s</color>", i * cfgThemePass.Exp),
            normalItems = norItems,
            specialItems = speItems,
            rewardItemObj = rewardItemObj,
            callBackNor = this.ExpNorCommand,
            callBackSpe = this.ExpHighCommand,
            isNorRewarding = norIsRewarding,
            isSpeRewarding = speIsRewarding,
        }
        local rewardData = UIScrollData.GetData(rewardItemGroupObj, "Passes_RewardItemGroup", 160, 450, rewardItem)
        table.insert(dataList, rewardData);
    end

    for i, v in ipairs(dataList) do
        if #v.data.normalItems > 0 and not v.data.normalItems[1].isRewarded then
            startIndex = i
            break
        end
    end

    rewardScrollView:SetParams(711, 450)
    reward_ScrollView.transform.sizeDelta = Vector2(711, 450);
    rewardScrollView:SetData(dataList, false)
    rewardScrollView:MoveToIndex(startIndex);
    SetActive(btnReward.gameObject, isExpRewarding)
    if isInit then
        coroutine_runner.start(function()
            for i, v in ipairs(rewardScrollView.screenList) do
                v:DOAlphaAnimation(0.03 * i)
            end
        end)
        isInit = false;
    end
end

this.GetRewardItem = function(rewardItem, isNor)
    local itemList = {}
    local state = 1;
    local dataPassesRewardsMultiple = DataMgr.Player.passesRewardsMultiple[cfgThemePass.Id];
    local dataReward = dataPassesRewardsMultiple[rewardItem.Id];
    local receiveTime = isNor and dataReward.freeReceiveTime or dataReward.payReceiveTime;
    local rewards = isNor and rewardItem.FreeReward or rewardItem.PayReward;
    if receiveTime > 0 then
        state = 3;
    elseif trafficLevel >= dataReward.level and (isNor or this.IsChargeRecord()) then
        state = 2;
        isExpRewarding = true;
    end
    if not IsNull(rewards) and #rewards > 0 then
        for i, v in ipairs(rewards) do
            local item = {
                item = v,
                isLock = state == 1,
                isRed = state == 2,
                isRewarded = state == 3,
                alpha = state == 2 and 1.0 or 0.5,
            }
            table.insert(itemList, item)
        end
    end
    return itemList, state == 2;
end








this.OnAskMissionReward = function(pid, callBack)
    local tag = taskBarIndex == 1 and "weekly" or "period"
    local askData = {
        passesID = themId,
        id = pid,
        tab = tag
    }
    ApiMgr.Request("passes/get_mission_award", askData, true, function(result)
        local re = json.decode(result);
        local data = json.encode(re.result);
        LuaMgr.ShowItemRewared(data);
        if callBack ~= nil then
            callBack();
        end
    end, nil, true)
end

this.PassesIsRuning = function()
    return not IsNull(dataPasses) and LuaMgr.Timestamp() < dataPasses.endTime;
end


this.ParseTaskData = function()
    this.ParseCfg();
    this.SetBaseInfo();
    themId = cfgThemePass.Id
    dataPasses = DataMgr.Player.passesMultiple[themId]
    dataPassesMissions = DataMgr.Player.passesMissionsMultiple[themId];
    this.SetTopBarState();

    HeroRedDataHelper.GetPassesRed()
    local remainTime = dataPasses.endTime - LuaMgr.Timestamp()
    if remainTime < 0 then
        remainTime = 0;
    end
end

this.SetTopBarState = function()
    SetActive(goWeek, taskBarIndex == 1)
    SetActive(goAchieve, taskBarIndex == 2)
    this.SetTaskList();
end


this.SetBaseInfo = function()
    local myCount = DataHelper.GetItemCountById(cfgThemePass.Expitems);
    txtPro.text = myCount;
    local maxExp = cfgThemePass.MaxLevel * cfgThemePass.Exp;
    isMaxExp = myCount >= maxExp;
    txtMax.text = "/" .. maxExp
    imgSlider.fillAmount = myCount / maxExp
    SetActive(norReward.gameObject, not this.IsChargeRecord())
    SetActive(highReward.gameObject, this.IsChargeRecord())
end


this.SetTaskList = function()
    isTaskRewarding = false;
    local missionMap = nil;
    if taskBarIndex == 1 then
        missionMap = dataPassesMissions.weekly;
    elseif taskBarIndex == 2 then
        missionMap = dataPassesMissions.period
    end
    if IsNull(missionMap) then return end;
    local list = {}
    for i, v in pairs(missionMap) do
        local cfgMissionItem = ConfigMgr.Config.PassesTaskMap[v.id]
        local missionItem = {
            id = v.id,
            sort = cfgMissionItem.Sort,
            des = LuaMgr.GetLangText(cfgMissionItem.Namelan),
            exp = cfgMissionItem.Exp,
            pro = string.format("(<color=#3d6053>%s</color>/%s)", v.current, v.target),
            state = this.GetMissionState(v),
            rewardCallBack = this.RewardCallBack,
            jumpCallBack = this.JumpCallBack,
            item = { id = cfgThemePass.Expitems, count = cfgMissionItem.Exp }
        }
        local missionData = UIListData.GetData(taskItemObj, "Passes_TaskItem", missionItem);
        table.insert(list, missionData);
        if missionItem.state == 1 then
            isTaskRewarding = true;
        end
    end
    table.sort(list, function(a, b)
        if a.data.state == b.data.state then
            return a.data.sort < b.data.sort;
        else
            return a.data.state < b.data.state;
        end
    end)
    taskUIList:SetData(list);
    SetActive(btnRewardAll.gameObject, isTaskRewarding)
end



this.GetMissionState = function(mission)
    local state = 2;
    if mission.completed then
        state = 3;
    elseif mission.current >= mission.target then
        state = 1;
    end
    return state;
end



this.RewardCallBack = function(id)
    if not this.PassesIsRuning() then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("18002"));
        return;
    end
    this.OnAskMissionReward(id, function()
        this.ParseTaskData();
    end)
end


this.JumpCallBack = function(id)
    local cfgMissionItem = ConfigMgr.Config.PassesTaskMap[id]
    if cfgMissionItem ~= nil and not IsNullOrEmpty(cfgMissionItem.PageSkip) then
        FeatureManager.GotoViewModel(cfgMissionItem.PageSkip);
    end
end




this.OnBack = function()
    tabIndex = nil
    taskBarIndex = nil
    LuaMgr.Back();
end

this.SwitchTab = function(index)
    SetActive(goMain, index == 1)
    SetActive(goTask, index ~= 1)
    if index == 1 then
        this.ParseData();
    else
        this.ParseTaskData();
    end
    tabIndex = index
end

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        this.Init(this.vm.behaviour)
        local tf = this.vm.behaviour.transform;
        RedMgr.Singleton:RegisterViewModel(UIName.PassesMain2ViewModel);

        rewardItemGroupObj = tf:Find("template/rewardItemGroup").gameObject
        rewardItemObj = tf:Find("template/rewardItem").gameObject
        rewardScrollView = UIScrollView.New(reward_ScrollView.gameObject)
        rewardScrollView.scrollCallBack = this.ScrollCallBack;
        high_norUIList = UIListView.New(tranNormalReward);
        high_speUIList = UIListView.New(tranHighRewards);
        payNowUIList = UIListView.New(tranNowContent);
        payContinuousList = UIListView.New(tranContinuousContent);
        payLockUIList = UIListView.New(tranLockContent)
        this.buyUIGray = btnMainBuy.transform:GetComponent("UIGray");

        taskUIList = UIListView.New(tranTaskContent);
        taskItemObj = vm.behaviour.transform:Find("template/taskItem").gameObject
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        vm.behaviour:UpdateTopBar("", this.OnBack);
        if vm.behaviour.Params.Length > 0 then
            local paramData = vm.behaviour.Params[0]
            if type(paramData) == "table" then
                medalActivityID = paramData.medalActivityID
                medalColor = paramData.medalColor
                medalImgKey = paramData.medalImgKey
                if panelSoundComp and paramData.bgmPath ~= nil and paramData.bgmPath ~= "" then
                    panelSoundComp.bgmPath = paramData.bgmPath
                    AudioMgr.Singleton:PlayBgm(paramData.bgmPath, true);
                else

                end
            else
                medalActivityID = vm.behaviour.Params[0];
                medalColor = vm.behaviour.Params[1];
                medalImgKey = vm.behaviour.Params[2];
            end
        else
            if (medalActivityID == nil) then
                medalActivityID = "4170"
                medalColor = "#3d6053"
                medalImgKey = "ui_hd_ty_dtyl_bt_wps"
            end
        end

        isInit = true;
        LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder, this.PayOrder);
        LuaMgr.AddUIEventListener(UIEventConst.PayOrder, this.PayOrder);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult, this.OnPayResult);
        LuaMgr.AddUIEventListener(UIEventConst.OnPayResult, this.OnPayResult);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess, this.OnPaySuccess);
        LuaMgr.AddUIEventListener(UIEventConst.OnPaySuccess, this.OnPaySuccess);
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartBeat, this.FrushData);
        LuaMgr.AddUIEventListener(UIEventConst.HeartBeat, this.FrushData);

        this.OnUpdateMedalCollect()
        taskBarIndex = 1
        this.SwitchTab(1)








    end,

    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder, this.PayOrder);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult, this.OnPayResult);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess, this.OnPaySuccess);
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartBeat, this.FrushData);
        LuaMgr.RemoveTimer(TimerConst.FristPayRechargeStatus)
        high_norUIList:Clear();
        high_speUIList:Clear();
        rewardScrollView:Clear(true)
        payLockUIList:Clear();
        payNowUIList:Clear();
        payContinuousList:Clear();
        taskUIList:Clear();
    end,

    before_destroy = function()
        this.Clear();
        UIScrollView.ClearItem("Passes_RewardItemGroup")
        UIListView.ClearItem("Passes_RewardItem")
        UIListView.ClearItem("Passes_TaskItem")
    end
}


this.OnUpdateMedalCollect = function()
    imgMingke.texture = LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/Passes2/%s.png", medalImgKey));
    local finishMedalCount1 = DataExHelper.GetMedalFinishCount(medalActivityID)
    local medalList1 = DataExHelper.GetMedalList(medalActivityID)

    local totalFinishMedalCount = finishMedalCount1
    this.medalList = {}
    for key, value in pairs(medalList1) do
        table.insert(this.medalList, value)
    end
    txtRatio.text = string.format(LuaMgr.GetLangText("CrisisContract2MainViewModel_0"), totalFinishMedalCount,
        #this.medalList)
    if (#this.medalList <= 0) then
        return
    end
    if (this.medalList[1] ~= nil) then
        local curScore1 = DataExHelper.GetTotalScore(this.medalList[1].id)
        SetActive(goUnFinish1, curScore1.Current < curScore1.Target)
        SetActive(goFinish1, curScore1.Current >= curScore1.Target)
        imgIcon1.sprite = LuaMgr.GetSprite("ZhanXunIcon", this.medalList[1].id)
    else
        SetActive(goUnFinish1, false)
        SetActive(goFinish1, false)
    end
    if (this.medalList[2] ~= nil) then
        local curScore2 = DataExHelper.GetTotalScore(this.medalList[2].id)
        SetActive(goUnFinish2, curScore2.Current < curScore2.Target)
        SetActive(goFinish2, curScore2.Current >= curScore2.Target)
        imgIcon2.sprite = LuaMgr.GetSprite("ZhanXunIcon", this.medalList[2].id)
        imgSelect.sizeDelta = Vector2(167,327)
    else
        SetActive(goUnFinish2, false)
        SetActive(goFinish2, false)
        imgSelect.sizeDelta = Vector2(167,184)
    end
    PlayerMedalMgr.CheckMedalPopup(medalActivityID)
end




return vm({
    data = data,
    command = command,
    hook = hook
})