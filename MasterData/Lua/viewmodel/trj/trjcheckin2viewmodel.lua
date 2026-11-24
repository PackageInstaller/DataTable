require("ViewModel/TRJ/TRJRoulette_RewardItemGroup")
require("ViewModel/TRJ/TRJRoulette_RewardItem")
local this = {
    rewardUIList = {},

};
local passesId = "10003";

local paying = false;
local order = nil;


local ui = {}

this.InitUI = function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.good = uiLink:Get("good");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.goPopBuy = uiLink:Get("goPopBuy");
    ui.txtTime = uiLink:Get("txtTime"):GetComponent("Text");
    ui.txtPrice1 = uiLink:Get("txtPrice1"):GetComponent("Text");
    ui.txtPrice = uiLink:Get("txtPrice"):GetComponent("Text");
    ui.btnPay = uiLink:Get("btnPay"):GetComponent("Button");
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.btnPaySecond = uiLink:Get("btnPaySecond"):GetComponent("Button");
    ui.ScrollViewMain = uiLink:Get("ScrollViewMain"):GetComponent("ScrollRect");
    ui.ScrollViewContinuous = uiLink:Get("ScrollViewContinuous"):GetComponent("ScrollRect");
    ui.ScrollViewLock = uiLink:Get("ScrollViewLock"):GetComponent("ScrollRect");
    ui.tranTaskContent = uiLink:Get("tranTaskContent"):GetComponent("RectTransform");
    ui.tranNowContent = uiLink:Get("tranNowContent"):GetComponent("RectTransform");
    ui.tranContinuousContent = uiLink:Get("tranContinuousContent"):GetComponent("RectTransform");
    ui.tranLockContent = uiLink:Get("tranLockContent"):GetComponent("RectTransform");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister = function(uiLink)
    uiLink:AddClickEvent("btnPaySecond", function()
        this.OnAskPay();
    end)
    uiLink:AddClickEvent("btnMask", function()
        SetActive(ui.goPopBuy, false);
    end)
    uiLink:AddClickEvent("btnPay", function()
        this.SetPayInfo();
    end)
end
this.OnAskPay = function()
    if not this.CheckPayActive() then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("27105"));
        return;
    end
    if paying then return end;
    if this.IsPay() or this.passes_ChargeId == nil then
        return;
    end
    paying = true;
    LuaMgr.LuaOnAskPay(this.passes_ChargeId);
end


this.CheckPayActive = function()
    if this.passesCfg == nil then
        return false;
    end
    if LuaMgr.Timestamp() > this.passesCfg.StartTime and LuaMgr.Timestamp() < this.passesCfg.EndTime then
        return true;
    end
    return false;
end


local data = {}
local command = {}

local hook = {
    before_awake = function(vm)
        this.InitUI(vm.behaviour);
        this.rewardUIList = UIListView.New(ui.tranTaskContent);
        this.rewardItemGroupObj = vm.behaviour.transform:Find("template/rewardItemGroup").gameObject;
        this.rewardItemObj = vm.behaviour.transform:Find("template/rewardItem").gameObject;
        this.payNowUIList = UIListView.New(ui.tranNowContent);
        this.payLockUIList = UIListView.New(ui.tranLockContent)
    end,

    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder, this.PayOrder);
        LuaMgr.AddUIEventListener(UIEventConst.PayOrder, this.PayOrder);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult, this.OnPayResult);
        LuaMgr.AddUIEventListener(UIEventConst.OnPayResult, this.OnPayResult);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess, this.OnPaySuccess);
        LuaMgr.AddUIEventListener(UIEventConst.OnPaySuccess, this.OnPaySuccess);
        this.ParseData();
        HeroRedDataHelper.CheckTRJ2Red();
    end,
    before_deactive = function(vm)
        this.rewardUIList:Clear();
        LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder, this.PayOrder);
        LuaMgr.RemoveTimer(TimerConst.FristPayRechargeStatus)
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult, this.OnPayResult);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess, this.OnPaySuccess);
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartBeat, this.ParseData_Passes);
    end,
    before_destroy = function()
        this.ClearUI()
        UIListView.ClearItem("TRJRoulette_RewardItemGroup")
        UIListView.ClearItem("TRJRoulette_RewardItem")
    end
}

this.PayOrder = function(data)
    if data.Length == 2 then
        local reChargeId = tostring(data[0]);
        order = tostring(data[1]);
        if this.passes_ChargeId ~= reChargeId then return end;
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
        HeroRedDataHelper.CheckTRJ2Red();
        this.ParseData_Passes();
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
            HeroRedDataHelper.CheckTRJ2Red();
            this.ParseData_Passes();
        end
    end, nil, true);
end

this.ParseData = function()
    this.ParseData_Passes();
end

this.ParseData_Passes = function()
    paying = false;
    this.passesCfg = nil;
    SetActive(ui.goPopBuy, false);
    if DataMgr.Player.passesMultiple[passesId] == nil then
        return;
    end
    this.passesCfg = ConfigMgr.Config.PassesMap[passesId];
    this.remainTime = this.passesCfg.EndTime - LuaMgr.Timestamp();
    if this.remainTime < 0 then
        this.remainTime = 0
    end
    local day, hour, min = GetTimeDHM2(this.remainTime)
    ui.txtTime.text = LuaMgr.GetLangText("TRJCheckIn2ViewModel_0") ..
    string.format(ConfigMgr.LangGlobal("10205"), day, hour)
    this.passes_ChargeId = nil;
    if not IsNull(this.passesCfg.Charge1) and #this.passesCfg.Charge1 > 0 then
        this.passes_ChargeId = this.passesCfg.Charge1[1]
    end
    this.dataMissions = nil;
    if DataMgr.Player.passesMissionsMultiple[passesId] ~= nil then
        this.dataMissions = DataMgr.Player.passesMissionsMultiple[passesId].period;
    end
    this.rewardDataList = {};
    this.dataRewardsMultiple = DataMgr.Player.passesRewardsMultiple[passesId];
    if not IsNull(this.dataRewardsMultiple) then
        for i, v in pairs(this.dataRewardsMultiple) do
            table.insert(this.rewardDataList, v);
        end
    end
    table.sort(this.rewardDataList, function(a, b) return a.id < b.id end);
    this.SetBaseInfo();
    this.SetRewardUIList();
    local addWidth = math.floor(LuaMgr.GetScreenAddWidth() * 0.5);
    ui.ScrollViewMain.transform.sizeDelta = Vector2(784 + addWidth, 546)
end


this.SetBaseInfo = function()
    if this.IsPay() then
        SetActive(ui.btnPay.gameObject, false);
        return;
    end
    SetActive(ui.btnPay.gameObject, true);
    local curCharge = ConfigMgr.Config.charge[this.passes_ChargeId];
    local chargeChannel = ConfigHelper.GetChargeChannel(curCharge.ChargeGroup);
    ui.txtPrice1.text = chargeChannel.CurrencySymbol .. chargeChannel.PriceShow;
end

this.IsPay = function()
    local passesMultiple = DataMgr.Player.passesMultiple[passesId];
    return not IsNull(passesMultiple) and not IsNull(passesMultiple.payRecord) and
        passesMultiple.payRecord[this.passes_ChargeId] ~= nil;
end


this.SetRewardUIList = function()
    this.rewardUIList:Clear();
    local list = {}
    for i, v in ipairs(this.rewardDataList) do
        local rewardsCfg = ConfigMgr.Config.PassesRewardMap[v.id]
        local isCan = this.dataMissions[rewardsCfg.TaskId].completed
        if rewardsCfg ~= nil then
            local rewardItem = {
                index = i,
                id = v.id,
                level = rewardsCfg.Level,
                freeReward = rewardsCfg.FreeReward,
                payReward = rewardsCfg.PayReward,
                freeState = 1,
                payState = this.IsPay() and 1 or 0,
                itemObj = this.rewardItemObj,
                callBack = this.RewardCallBack,
            }
            if v.freeReceiveTime > 0 then
                rewardItem.freeState = 3;
            elseif isCan then
                rewardItem.freeState = 2;
            end
            if rewardItem.payState > 0 then
                if v.payReceiveTime > 0 then
                    rewardItem.payState = 3;
                elseif isCan then
                    rewardItem.payState = 2;
                end
            end
            local rewardData = UIListData.GetData(this.rewardItemGroupObj, "TRJRoulette_RewardItemGroup", rewardItem)
            table.insert(list, rewardData);
        end
    end
    this.rewardUIList:SetData(list);
end

this.RewardCallBack = function(index)
    if not this.CheckPayActive() then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("27105"));
        return;
    end
    local dataItem = this.rewardUIList.dataList[index].data;
    if dataItem.freeState == 2 or dataItem.payState == 2 then
        local askData = {
            passesID = this.passesCfg.Id,
            id = dataItem.id,
            type = 2,
        }
        ApiMgr.Request("passes/get_level_award", askData, true, function(result)
            local re = json.decode(result);
            local data = json.encode(re.result);
            LuaMgr.ShowItemRewared(data);
            HeroRedDataHelper.CheckTRJ2Red();
            this.ParseData_Passes();
        end, nil, true)
    end
end

this.SetPayInfo = function()
    SetActive(ui.goPopBuy, true);
    local curCharge = ConfigMgr.Config.charge[this.passes_ChargeId];
    local chargeChannel = ConfigHelper.GetChargeChannel(curCharge.ChargeGroup);
    ui.txtPrice.text = chargeChannel.CurrencySymbol .. chargeChannel.PriceShow;

    local nowRewards = curCharge.Reward;
    local nowList = {}
    if not IsNull(nowRewards) then
        for i, v in ipairs(nowRewards) do
            local item = {
                item = v,
                isLock = false,
                isRed = false,
                isRewarded = false,
                alpha = 1,
                scale = 0.8,
            }
            local itemData = UIListData.GetData(this.rewardItemObj, "TRJRoulette_RewardItem", item);
            table.insert(nowList, itemData);
        end
        this.payNowUIList:SetData(nowList);
    end


    local lockList = {}
    local unLockRewards = this.passesCfg.ShowRewards
    if not IsNull(unLockRewards) then
        for i, v in ipairs(unLockRewards) do
            local item = {
                item = { id = v[1], count = v[2] },
                isLock = false,
                isRed = false,
                isRewarded = false,
                alpha = 1,
                scale = 0.8,
            }
            local itemData = UIListData.GetData(this.rewardItemObj, "TRJRoulette_RewardItem", item);
            table.insert(lockList, itemData);
        end
        this.payLockUIList:SetData(lockList);
    end
end


return vm({
    data = data,
    command = command,
    hook = hook
})