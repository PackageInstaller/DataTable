local this = {
    gridCount = 9,
    ruleItemCount = 3,
    rewardItemCount = 6,

    gridItemUIs = {},

    ruleItemUIs = {},

    rewardItemUIs = {},

    buyPanelPriceUI = nil,
    chargeIds={"100009071","100009072"},
    freeChargeId="100009073",
}

local objs = {
    downTimeTxt = {path = "root/Middle/Group/DownTimeBG/DownTimeTxt", type = UITool.Text},
    leftTrans = {path = "root/Middle/Group/Left", type = UITool.Transform},
    rightTrans = {path = "root/Middle/Group/Right", type = UITool.Transform},






    freeRewardGroup = {path = "root/Middle/Group/Right/FreeRewardGroup", type = UITool.GameObject},
    freeItemParent = {path = "root/Middle/Group/Right/FreeRewardGroup/FreeItemParent", type = UITool.GameObject},
    freeRewardGetBtn = {path = "root/Middle/Group/Right/FreeRewardGroup/GetBtn", type = UITool.Button},

}

this.before_awake = function()
    this.BatchInitNode()
end

this.BatchInitNode = function()
    this.nameTexts = {}
    this.goodsItems = {}
    this.buyCountTexts = {}
    this.priceTexts = {}
    this.priceIcons = {}
    this.shopBG = {}
    local parents = {this.leftTrans, this.rightTrans}
    for i = 1, #parents do
        local index = i
        local onclick = function()
            this.OnOpenBuyPanel(index)
        end
        local parent = parents[i]
        local buyButton = parent:Find("BuyButton"):GetComponent(UITool.Button)
        LuaMgr.AddClick(buyButton, onclick)
        local nameText = parent:Find("Name"):GetComponent(UITool.Text)
        local itemParent = parent:Find("Name/ItemParent"):GetComponent(UITool.Transform)
        local buyCountText = parent:Find("BuyCount"):GetComponent(UITool.Text)
        local priceText = parent:Find("BuyButton/Price"):GetComponent(UITool.Text)
        local priceIcon = parent:Find("BuyButton/Price/Icon"):GetComponent(UITool.RawImage)

        this.nameTexts[i] = nameText
        this.goodsItems[i] = GoodsDataItem.New(itemParent)
        this.buyCountTexts[i] = buyCountText
        this.priceTexts[i] = priceText
        this.priceIcons[i] = priceIcon

    end

    local flag = CommonRewardItem.ResetStatusSlibing.CanGet | CommonRewardItem.ResetStatusSlibing.Got | CommonRewardItem.ResetStatusSlibing.Lock
    this.freeItemUI = CommonRewardItem.New(this.freeItemParent, true, 0.7, flag)
end
this.OnRefreshTime = function()
    local activityData =  DataExHelper.GetDataExByTag(ActivityKey.ZNHD)
    if activityData==nil then return end;
    local time = activityData.expireTime - LuaMgr.Timestamp()
    if time <= 0 then
        this.downTimeTxt.text=ConfigMgr.LangGlobal("18344")
        return;
    end
    local timeStr = ""
    local d, h, m = GetTimeDHM(time)
    if (not IsNullOrEmpty(d)) then
        timeStr = timeStr .. string.format("%s%s", d, ConfigMgr.LangGlobal("10365"))
    end
    if (not IsNullOrEmpty(h)) then
        timeStr = timeStr .. string.format("%s%s", h, ConfigMgr.LangGlobal("10366"))
    end
    if (not IsNullOrEmpty(m)) then
        timeStr = timeStr .. string.format("%s%s", m, ConfigMgr.LangGlobal("10367"))
    end
    this.downTimeTxt.text=timeStr
end

this.FreeReward = function()
    if this.questCelebrationFree == nil then
        this.questCelebrationFree = DataExHelper.Check_ConfigQuestEventByText("ZNFLFree")
    end
    local quests = DataMgr.Player.quests
    local questConfig = this.questCelebrationFree[1]
    local questData = quests[questConfig.id]
    local data = {}
    data.config = questConfig
    data.rewards = questConfig.showReward
    data.goalProgress = questConfig.progress
    data.status = questData and questData.state or (CommonRewardItem.Status.None + 1)
    data.questData = questData
    if (data.status - 1) == CommonRewardItem.Status.Got then
        return true, data
    end
    return false, data
end


this.RefreshUI = function()
    local contentTitle = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7301")
    for i = 1, #this.chargeIds do
        local goodsID = this.chargeIds[i]
        local config = ConfigMgr.Config.charge[goodsID]

        local giftItem = config.Reward[1]
        local itemConfig = ConfigMgr.Config.itemMap[giftItem.id]
        this.nameTexts[i].text = string.format("%s x%d", LuaMgr.GetLangText(itemConfig.nameLan), giftItem.count)

        local goodsItem = this.goodsItems[i]
        local itemData = table.Copy(itemConfig)
        itemData.count0 = giftItem.count
        goodsItem:SetData(1, itemData, 1, false, Vector3(0.25, 0.25, 1), false)
        goodsItem:SetCount(nil, Vector2(-10, 10), Vector3.one)
        goodsItem:SetIconBg(false)

        local buyCountStr = string.format("%s%d/%d", contentTitle, DataHelper.GetShopRecordByGoodsId(config.Id), config.RefreshCount)
        this.buyCountTexts[i].text = buyCountStr
        this.priceTexts[i].text = ConfigHelper.GetGoodsPriceStr(goodsID)
    end

    local isGot, freeItemData = this.FreeReward()
    this.freeItemData = freeItemData
    this.freeItemUI:SetData1(freeItemData.rewards[1])
    if isGot == true then
        this.freeItemUI:SetStatus(CommonRewardItem.Status.Got)

    else
        this.freeItemUI:SetStatus(CommonRewardItem.Status.None)

    end
end


this.OnOpenBuyPanel = function(index)
    local activityData =  DataExHelper.GetDataExByTag(ActivityKey.ZNHD)
    local time = activityData.expireTime - LuaMgr.Timestamp();
    if time <= 0 then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("18344"));
        return;
    end
    this.selectIndex = index
    local goodsID = this.chargeIds[this.selectIndex]


    local config = ConfigMgr.Config.charge[goodsID]



    if DataHelper.GetShopRecordByGoodsId(config.Id) >= config.RefreshCount then
        local tipsContent = LuaMgr.GetLangText("FurnitureShopOrderPopup_0")
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tipsContent)
        return
    end
    this.OnClickBuyPanelBuyBtn();





end

this.OnClickBuyPanelBuyBtn = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.ZNHD) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"))
        return false
    end
    if this.paying then
        return
    end
    this.paying = true
    LuaMgr.LuaOnAskPay(this.chargeIds[this.selectIndex])
end

this.OnClickBuyPanelMaskBtn = function()
    SetActive(this.buyPanel, false)
end

this.OnClickFreeRewardGetBtn = function()
    local isGot = this.FreeReward()
    if isGot == true then
        return
    end
    local func = function()
        this.freeItemUI:SetStatus(CommonRewardItem.Status.Got)
        HeroRedDataHelper.CheckTRJRed();

    end
    DataExHelper.EX_GetAward(this.freeItemData.config.id, func)
end

this.OnPayResult = function(params)
    this.paying = false
end
this.OnPaySuccess = function(params)
    this.OnClickBuyPanelMaskBtn()
    this.paying = false
    this.RefreshUI()
end

this.PayOrder = function(data)
    if data.Length == 2 then
        local reChargeId = tostring(data[0])
        this.order = tostring(data[1])
        if this.chargeIds[this.selectIndex] ~= reChargeId then
            return
        end
        if LuaMgr.GetPlatform() ~= "EDITOR" then
            return
        end
        LuaMgr.RemoveTimer(TimerConst.FristPayRechargeStatus)
        LuaMgr.AddTimer(TimerConst.FristPayRechargeStatus, this.OnTimer, 1, 100, true)
    end
end

this.OnTimer = function()
    local askData = {order = this.order}
    local onSucc = function(result)
        local re = json.decode(result)
        if re.result.status == 2 then
            LuaMgr.RemoveTimer(TimerConst.FristPayRechargeStatus)
            local rewards = re.result.rewards
            if rewards ~= nil then
                local data = json.encode(rewards)
                LuaMgr.ShowItemRewared(data)
            end
            this.paying = false
            this.OnClickBuyPanelMaskBtn()
            this.RefreshUI()
        end
    end
    ApiMgr.Request("check_recharge_status", askData, true, onSucc, nil, true)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
        LuaMgr.AddTimer(TimerConst.TongXingZhiYuanTimer, this.OnRefreshTime, 60, -1, true)


        LuaMgr.AddClick(this.freeRewardGetBtn, this.OnClickFreeRewardGetBtn)
        RedMgr.Singleton:RegisterViewModel(UIName.TRJMarketPayViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        HeroRedDataHelper.CheckTRJRed();
        LuaMgr.AddUIEventListener(UIEventConst.PayOrder, this.PayOrder)
        LuaMgr.AddUIEventListener(UIEventConst.OnPayResult, this.OnPayResult)
        LuaMgr.AddUIEventListener(UIEventConst.OnPaySuccess, this.OnPaySuccess)
        this.paying = false
        SetActive(this.buyPanel, false)
        this.RefreshUI()
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder, this.PayOrder)
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult, this.OnPayResult)
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess, this.OnPaySuccess)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveTimer(TimerConst.TongXingZhiYuanTimer)


        LuaMgr.RemoveClick(this.freeRewardGetBtn, this.OnClickFreeRewardGetBtn)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)