local this = {
    gridCount = 9,
    ruleItemCount = 3,
    rewardItemCount = 6,

    gridItemUIs = {},

    ruleItemUIs = {},

    rewardItemUIs = {},

    buyPanelPriceUI = nil
}

local objs = {
    downTimeTxt = {path = "root/Middle/Group/DownTimeBG/DownTimeTxt", type = UITool.Text},
    leftTrans = {path = "root/Middle/Group/Left", type = UITool.Transform},
    rightTrans = {path = "root/Middle/Group/Right", type = UITool.Transform},
    buyPanel = {path = "root/Middle/GoPopBuy", type = UITool.GameObject},
    buyPanelGroup = {path = "root/Middle/GoPopBuy/Group", type = UITool.Transform},
    buyPanelPrice = {path = "root/Middle/GoPopBuy/Group/PriceBG/PriceText", type = UITool.Text},
    buyPanelBuyBtn = {path = "root/Middle/GoPopBuy/Group/BuyBtn", type = UITool.Button},
    buyPanelItem = {path = "root/Middle/GoPopBuy/Group/ItemParent", type = UITool.GameObject},
    buyPanelMaskBtn = {path = "root/Middle/GoPopBuy/BtnMask", type = UITool.Button},
    freeRewardGroup = {path = "root/Middle/Group/Right/FreeRewardGroup", type = UITool.GameObject},
    freeItemParent = {path = "root/Middle/Group/Right/FreeRewardGroup/FreeItemParent", type = UITool.GameObject},
    freeRewardGetBtn = {path = "root/Middle/Group/Right/FreeRewardGroup/GetBtn", type = UITool.Button},
    freeRewardAnim = {path = "root/Middle/Group/Right/FreeRewardGroup", type = UITool.Animator}
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
        local shopBG = this.buyPanelGroup:Find("ShopBG" .. index).gameObject
        this.nameTexts[i] = nameText
        this.goodsItems[i] = GoodsDataItem.New(itemParent)
        this.buyCountTexts[i] = buyCountText
        this.priceTexts[i] = priceText
        this.priceIcons[i] = priceIcon
        this.shopBG[i] = shopBG
    end
    this.buyPanelItemUI = CommonRewardItem.New(this.buyPanelItem, true, 0.8)
    local flag = CommonRewardItem.ResetStatusSlibing.CanGet | CommonRewardItem.ResetStatusSlibing.Got | CommonRewardItem.ResetStatusSlibing.Lock
    this.freeItemUI = CommonRewardItem.New(this.freeItemParent, true, 0.7, flag)
end

this.OnRefreshTime = function()
    this.downTimeTxt.text = XingHaiData.GetRemainTimeStr()
end

this.RefreshUI = function()
    local contentTitle = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7301")
    for i = 1, #XingHaiConst.TongXingGiftIDs do
        local goodsID = XingHaiConst.TongXingGiftIDs[i]
        local config = ConfigMgr.Config.charge[goodsID]

        local giftItem = config.Reward[1]
        local itemConfig = ConfigMgr.Config.itemMap[giftItem.id]
        this.nameTexts[i].text = string.format("%s x%d", LuaMgr.GetLangText(itemConfig.nameLan), giftItem.count)

        local goodsItem = this.goodsItems[i]
        local itemData = table.Copy(itemConfig)
        itemData.count0 = giftItem.count
        goodsItem:SetData(1, itemData, 1, false, Vector3(0.3, 0.3, 1), false)
        goodsItem:SetCount(nil, Vector2(-10, 10), Vector3.one)
        goodsItem:SetIconBg(false)

        local buyCountStr = string.format("%s%d/%d", contentTitle, DataHelper.GetShopRecordByGoodsId(config.Id), config.RefreshCount)
        this.buyCountTexts[i].text = buyCountStr
        this.priceTexts[i].text = ConfigHelper.GetGoodsPriceStr(goodsID)
    end

    local isGot, freeItemData = XingHaiData.TongXingFreeReward()
    this.freeItemData = freeItemData
    this.freeItemUI:SetData1(freeItemData.rewards[1])
    if isGot == true then
        this.freeItemUI:SetStatus(CommonRewardItem.Status.Got)
        this.freeRewardAnim.enabled = false
    else
        this.freeItemUI:SetStatus(CommonRewardItem.Status.None)
        this.freeRewardAnim.enabled = true
    end
end

this.OnOpenBuyPanel = function(index)
    this.selectIndex = index
    local goodsID = XingHaiConst.TongXingGiftIDs[this.selectIndex]
    this.buyPanelPrice.text = ConfigHelper.GetGoodsPriceStr(goodsID)

    local config = ConfigMgr.Config.charge[goodsID]
    local giftItem = config.Reward[1]
    this.buyPanelItemUI:SetData1(giftItem)

    if DataHelper.GetShopRecordByGoodsId(config.Id) >= config.RefreshCount then
        local tipsContent = LuaMgr.GetLangText("FurnitureShopOrderPopup_0")
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tipsContent)
        return
    end
    SetActive(this.buyPanel, true)
    for i = 1, #this.shopBG do
        local obj = this.shopBG[i]
        SetActive(obj.gameObject, i == index)
    end
end

this.OnClickBuyPanelBuyBtn = function()
    if XingHaiData.CheckActivityRunning() == false then
        return
    end
    if this.paying then
        return
    end
    this.paying = true
    LuaMgr.LuaOnAskPay(XingHaiConst.TongXingGiftIDs[this.selectIndex])
end

this.OnClickBuyPanelMaskBtn = function()
    SetActive(this.buyPanel, false)
end

this.OnClickFreeRewardGetBtn = function()
    local isGot = XingHaiData.TongXingFreeReward()
    if isGot == true then
        return
    end
    local func = function()
        this.freeItemUI:SetStatus(CommonRewardItem.Status.Got)
        this.freeRewardAnim.enabled = false
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
        if XingHaiConst.TongXingGiftIDs[this.selectIndex] ~= reChargeId then
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
        LuaMgr.AddClick(this.buyPanelBuyBtn, this.OnClickBuyPanelBuyBtn)
        LuaMgr.AddClick(this.buyPanelMaskBtn, this.OnClickBuyPanelMaskBtn)
        LuaMgr.AddClick(this.freeRewardGetBtn, this.OnClickFreeRewardGetBtn)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
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
        LuaMgr.RemoveClick(this.buyPanelBuyBtn, this.OnClickBuyPanelBuyBtn)
        LuaMgr.RemoveClick(this.buyPanelMaskBtn, this.OnClickBuyPanelMaskBtn)
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