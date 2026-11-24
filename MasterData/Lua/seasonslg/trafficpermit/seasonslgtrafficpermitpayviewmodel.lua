






local this = { vm = nil };

local passId = nil;
local chargeId = nil;
local order = nil;
local cfgCharge = {};
local shopRecords = nil;
local cfgThemePass = nil;
local cfgThemeData = nil
local cfgThemePassList = nil;
local paying = false;
local highPass = nil;
local spineCharacter = nil;
local characterId = nil;
local strList = { LuaMgr.GetLangText("SeasonSLGTrafficPermitPayViewModel_1"), LuaMgr.GetLangText("SeasonSLGTrafficPermitPayViewModel_2"), LuaMgr.GetLangText("SeasonSLGTrafficPermitPayViewModel_3"), LuaMgr.GetLangText("SeasonSLGTrafficPermitPayViewModel_4"), LuaMgr.GetLangText("SeasonSLGTrafficPermitPayViewModel_5"), LuaMgr.GetLangText("SeasonSLGTrafficPermitPayViewModel_6") }

local data = {
    rewardIcon = DefaultSprite,
    normalOrigBool = false,
    normalOrigPrice = "",
    contentList =
    {
        { content = "" },
        { content = "" },
        { content = "" },
    },
    chargeList = {
        {
            nowGoods = { {} },
            unlockGoods = { {} },
            continuousGoods = { {} },
            price = "",
        },
        {
            nowGoods = { {} },
            unlockGoods = { {} },
            continuousGoods = { {} },
            price = "",
        },
    },
    bodyPath = "",
    highUnlockRewardBool = false,
    levelInfo = "",
    offBodyPos = Vector2.zero,
    offBodyScale = Vector3.zero,
    highOrigPrice = "",
    buffTime = "",
    buffContent = "",
    highOrigBool = false,
    specialOrigPrice = "",
    specialOrigBool = false,
    characterName = "",
    characterRare = UnityEngine.Color(1, 1, 1, 1),
    characterJob = DefaultSprite,
    showRight = true,
    totalBuyText = "",
}

local command = {
    norPayBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if not this.PassesIsRuning() or not this.CheckPayOnLine() then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("TrafficPermitPayViewModel_16"));
                return;
            end
            if paying then return end;
            chargeId = cfgThemePass.Charge1[1]
            local pass2_chargeId = this.GetHighShowChargId()
            if not this.IsPayCharge(chargeId) or not this.IsPayCharge(pass2_chargeId) then
                return;
            end
            if not IsNull(cfgThemePass) and SeasonSLGMapMgr.PassesIsCurRuning(cfgThemePass) == -1 then
                local secondTipVM = UIName.SeasonSLGTrafficPermitBuyTipSecondViewModel;
                LuaMgr.ShowLuaPanel(secondTipVM, LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_35160"), function()
                    paying = true;
                    LuaMgr.LuaOnAskPay(chargeId);
                    LuaMgr.HidePanel(secondTipVM)
                end, nil);
                return
            end
            paying = true;
            LuaMgr.LuaOnAskPay(chargeId);
        end

    },
    highPayBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if not this.PassesIsRuning() or not this.CheckPayOnLine() then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("TrafficPermitPayViewModel_17"));
                return;
            end
            if paying then return end;

            chargeId = this.GetHighShowChargId()
            if not this.IsPayCharge(chargeId) then
                return;
            end
            paying = true;
            LuaMgr.LuaOnAskPay(chargeId);
        end
    },
    skinBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowPanel("Laigu.ViewModel.TakeCard.HeroAttrPreviewViewModel", characterId);
        end
    }
}


local hook = {
    before_awake = function(vm)
        this.vm = vm;
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length > 0 then
            local data = vm.behaviour.Params;
            passId = data[0];
        end
        spineCharacter = this.vm.behaviour.transform:Find("root/Middle/BG/character/offset/body"):GetComponent(
            "UISpineCharacter")
        LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder, this.PayOrder);
        LuaMgr.AddUIEventListener(UIEventConst.PayOrder, this.PayOrder);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult, this.OnPayResult);
        LuaMgr.AddUIEventListener(UIEventConst.OnPayResult, this.OnPayResult);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess, this.OnPaySuccess);
        LuaMgr.AddUIEventListener(UIEventConst.OnPaySuccess, this.OnPaySuccess);
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartBeat, this.FrushData);
        LuaMgr.AddUIEventListener(UIEventConst.HeartBeat, this.FrushData);
        cfgCharge = ConfigMgr.Config.charge;
        cfgThemePass = ConfigMgr.Config.PassesMap[passId];
        cfgThemeData = DataMgr.Player.passesMultiple[passId];
        cfgThemePassList = SeasonSLGMapMgr.GetSeasonSLGPassConfigList();

        this.ParseData();

        DataReportMgr.ClickPayView("", 5);
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder, this.PayOrder);
        LuaMgr.RemoveTimer(TimerConst.FristPayRechargeStatus)
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult, this.OnPayResult);
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess, this.OnPaySuccess);
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartBeat, this.FrushData);

        if (spineCharacter ~= nil) then
            spineCharacter:Clear();
        end
        print("before_deactive");
    end,
}


this.PassesIsRuning = function()
    return not IsNull(cfgThemeData) and not IsNullOrEmpty(cfgThemeData.id)
end

this.CheckPayOnLine = function()
    if IsNull(cfgThemeData) then return false end;
    local expireTime = cfgThemeData.endTime;
    return LuaMgr.Timestamp() < expireTime
end


this.FrushData = function()
    this.ParseData();
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

this.ParseData = function()
    paying = false;
    this.SetCharacter();
    this.SetChargeInfo();
end

this.SetCharacter = function()
    characterId = cfgThemePass.CharacterInfos[2][1];
    local skinId = cfgThemePass.CharacterInfos[2][2];
    local path = HeroManager.SetCharacterDrawing(spineCharacter, characterId, skinId);
    if (path ~= "") then
        this.vm.data.bodyPath = path;
    end
    this.vm.data.offBodyPos = Vector2(tonumber(cfgThemePass.CharacterInfos[2][3]),
        tonumber(cfgThemePass.CharacterInfos[2][4]))
    this.vm.data.offBodyScale = Vector3.one * tonumber(cfgThemePass.CharacterInfos[2][5])
    local characterConfig = ConfigMgr.Config.characterTable[characterId]
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


this.IsPayCharge = function(charge_Id)
    return SeasonSLGMapMgr.IsSeasonSLGChargeAvailable(charge_Id);
end

this.SetChargeInfo = function()

    local now1List = {}
    local itemScale = 0.45
    for i, v in ipairs(cfgCharge[cfgThemePass.Charge1[1]].Reward) do
        local item = ConfigHelper.CreateGoodsItem(v.id, v.count, itemScale, true, true);
        table.insert(now1List, item);
    end
    local charge_id = cfgThemePass.Charge1[1];
    local curCharge = cfgCharge[charge_id]
    local isBuy = SeasonSLGMapMgr.IsSeasonSLGPassPaid(cfgThemePass)
    local chargeChannel = ConfigHelper.GetChargeChannel(curCharge.ChargeGroup);
    if not isBuy and not IsNullOrEmpty(curCharge.OriginalPrice) and curCharge.OriginalPrice > 0 then
        this.vm.data.highOrigBool = true
        this.vm.data.highOrigPrice = LuaMgr.GetLangText("TrafficPermitPayViewModel_0") ..
            chargeChannel.CurrencySymbol .. curCharge.OriginalPrice;
    else
        this.vm.data.highOrigBool = false;
    end
    this.vm.data.chargeList[1].nowGoods = now1List;
    this.vm.data.chargeList[1].price = isBuy and LuaMgr.GetLangText("TrafficPermitPayViewModel_18") or
        chargeChannel.CurrencySymbol .. curCharge.DiscountPrice;
    this.vm.data.highUnlockRewardBool = true;


    local highShowRewards = {};
    local chargeChannel2 = nil;
    local charge_id2, buyNum = this.GetHighShowChargId()
    if charge_id2 ~= nil then
        local curCharge2 = cfgCharge[charge_id2]
        highShowRewards = curCharge2.Reward
        chargeChannel2 = ConfigHelper.GetChargeChannel(curCharge2.ChargeGroup);
        if (chargeChannel2 == nil) then
            LuaDebug.error("ConfigHelper.GetChargeChannel没有获取到内容，检查相应配置，charge_id2 = " .. charge_id2)
        end
        if this.IsPayCharge(charge_id2) and not IsNullOrEmpty(curCharge2.OriginalPrice) and curCharge2.OriginalPrice > 0 then
            this.vm.data.specialOrigBool = true;
            this.vm.data.specialOrigPrice = LuaMgr.GetLangText("TrafficPermitPayViewModel_0") ..
                chargeChannel2.CurrencySymbol .. curCharge2.OriginalPrice
        else
            this.vm.data.specialOrigBool = false;
        end
        local nowList = {}

        for i, v in ipairs(highShowRewards) do
            local item = ConfigHelper.CreateGoodsItem(v.id, v.count, itemScale, true, true);
            table.insert(nowList, item);
        end
        this.vm.data.chargeList[2].nowGoods = nowList;
        this.vm.data.chargeList[2].price = this.IsPayCharge(charge_id2) and
            chargeChannel2.CurrencySymbol .. curCharge2.DiscountPrice or
            LuaMgr.GetLangText("TrafficPermitPayViewModel_19");
        this.vm.data.showRight = true
        if (buyNum ~= nil) then
            local cacheNum = 6 - buyNum
            this.vm.data.totalBuyText = strList[cacheNum] .. LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_35159")
        else
            this.vm.data.totalBuyText = ""
        end
    else
        this.vm.data.showRight = false
    end


    this.vm.data.levelInfo = ConfigMgr.LangGlobal("10207")








    this.vm.data.buffContent = ""
    if cfgThemePass.SeasonBuff ~= nil then
        for i, v in ipairs(cfgThemePass.SeasonBuff) do
            local buff = ConfigMgr.Config.SeasonalProduceBuffMap[v]
            if buff ~= nil then
                this.vm.data.buffContent = this.vm.data.buffContent ..
                    LuaMgr.GetLangText("SeasonSLGTrafficPermitPayViewModel_0") ..
                    LuaMgr.GetLangText(buff.NameLan) .. "\n"
            end
        end
    end
end

this.GetHighShowChargId = function()
    return SeasonSLGMapMgr.GetSeasonSLGHighShowChargeId(cfgThemePass, cfgThemePassList);
end




return vm({
    data = data,
    command = command,
    hook = hook

})