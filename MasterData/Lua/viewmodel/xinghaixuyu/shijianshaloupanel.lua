require("ViewModel/XingHaiXuYu/ViewItem/ShaLouGroupItem")
local objs = {
    itemModel = {path = "template/ItemModel", type = UITool.GameObject},
    itemGroup = {path = "template/ItemParent", type = UITool.GameObject},
    downTimeTxt = {path = "root/Left/DownTimeBG/DownTimeTxt", type = UITool.Text},
    scrollView = {path = "root/Middle/ScrollView", type = UITool.GameObject},
    buyPopNode = {path = "root/Middle/GoPopBuy", type = UITool.GameObject},
    normalRewardScroll = {path = "root/Middle/GoPopBuy/Group/NormalRewardGroup/Content", type = UITool.Transform},
    highRewardScroll = {path = "root/Middle/GoPopBuy/Group/HighRewardGroup/Content", type = UITool.Transform},
    getRewardBtn = {path = "root/Right/Group/GetRewardBtn", type = UITool.Button},
    buyBtn = {path = "root/Right/Group/BuyBtn", type = UITool.Button},
    goPopBuyBtnMask = {path = "root/Middle/GoPopBuy/BtnMask", type = UITool.Button},
    popBuyBtn = {path = "root/Middle/GoPopBuy/Group/BuyBtn", type = UITool.Button}
}
local this = {
    paying = false,
    maxUnlockRewardCount = 3
}

this.before_awake = function()
    this.allRewardScrollUI = UIScrollView.New(this.scrollView)

    this.normalRewardUIs = {}

    this.heighRewardUIs = {}
    for i = 1, this.maxUnlockRewardCount do
        local item1 = CommonRewardItem.New(this.itemGroup, false, 0.8, nil, this.normalRewardScroll)
        local item2 = CommonRewardItem.New(this.itemGroup, false, 0.8, nil, this.highRewardScroll)
        table.insert(this.normalRewardUIs, item1)
        table.insert(this.heighRewardUIs, item2)
    end
    SetActive(this.buyPopNode, false)
end

this.before_active = function()
    local data = XingHaiData.GetPassData()
    this.dataPasses = data.dataPasses
    this.allRewardDatas = data.allRewardDatas
    this.chargeId = data.chargeId
    this.cfgThemePass = data.cfgThemePass
    this.isBuyHeighPass = data.isBuyHeighPass
    this.haveCanGetReward = data.haveCanGetReward
    this.RefreshPassScrollView()
    SetActive(this.buyBtn.gameObject, this.isBuyHeighPass == false)
    SetActive(this.getRewardBtn.gameObject, this.haveCanGetReward == true)
end

this.RefreshPassScrollView = function()
    this.allRewardScrollUI:Clear()
    local allDatas = this.allRewardDatas
    if allDatas == nil then
        return
    end
    local scrollDatas = {}
    for i = 1, #allDatas do
        local data = allDatas[i]
        local tempData = UIScrollData.GetData(this.itemModel, "ShaLouGroupItem", 165, 508, data)
        table.insert(scrollDatas, tempData)
    end
    local offsetX = LuaMgr.GetScreenWidth() - 1280
    this.allRewardScrollUI:SetParams(1020 + offsetX, 508)
    this.allRewardScrollUI:SetData(scrollDatas, true)
end

this.RefreshBuyPanelScrollView = function()
    local curCharge = ConfigMgr.Config.charge[this.chargeId]
    local nowRewards = curCharge.Reward
    local unLockRewards = this.cfgThemePass.ShowRewards
    for i = 1, this.maxUnlockRewardCount do
        local itemUI = this.normalRewardUIs[i]
        local data = nowRewards[i]
        if data ~= nil then
            SetActive(itemUI.gameObject, true)
            itemUI:SetData1(data)
        else
            SetActive(itemUI.gameObject, false)
        end
    end
    for i = 1, this.maxUnlockRewardCount do
        local itemUI = this.heighRewardUIs[i]
        local config = unLockRewards[i]
        if config ~= nil then
            local data = {
                id = config[1],
                count = config[2]
            }
            SetActive(itemUI.gameObject, true)
            itemUI:SetData1(data)
        else
            SetActive(itemUI.gameObject, false)
        end
    end
end

this.OnAskPay = function()
    if XingHaiData.CheckActivityRunning() == false then
        return
    end
    if this.paying then
        return
    end
    if not IsNull(this.dataPasses) and this.dataPasses.payRecord[this.chargeId] ~= nil then
        return
    end
    this.paying = true
    LuaMgr.LuaOnAskPay(this.chargeId)
end




this.OnAskMissionReward = function()
    if this.haveCanGetReward ~= true then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_22401")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    local askData = {
        passesID = this.cfgThemePass.Id,
        id = "all",
        type = 2
    }
    local callback = function(result)
        local re = json.decode(result)
        local data = json.encode(re.result)
        LuaMgr.ShowItemRewared(data)
        this.before_active()
    end
    ApiMgr.Request("passes/get_level_award", askData, true, callback, nil, true)
end

this.OnRefreshTime = function()
    this.downTimeTxt.text = XingHaiData.GetRemainTimeStr()
end

this.OnClickGetRewardBtn = function()
    if XingHaiData.CheckActivityRunning() == false then
        return
    end
    this.OnAskMissionReward()
end
this.OnClickBuyBtn = function()
    if XingHaiData.CheckActivityRunning() == false then
        return
    end
    SetActive(this.buyPopNode, true)
    this.RefreshBuyPanelScrollView()
end

this.OnClickGoPopBuyBtnMask = function()
    SetActive(this.buyPopNode, false)
end
this.OnClickPopBuyBtn = function()
    if XingHaiData.CheckActivityRunning() == false then
        return
    end
    this.OnAskPay()
end

this.OnPayResult = function(params)
    this.paying = false
end
this.OnPaySuccess = function(params)
    this.paying = false
    this.OnClickGoPopBuyBtnMask()
    this.before_active()
end

this.PayOrder = function(data)
    if data.Length == 2 then
        local reChargeId = tostring(data[0])
        this.order = tostring(data[1])
        if this.chargeId ~= reChargeId then
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
            this.OnClickGoPopBuyBtnMask()
            this.before_active()
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
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        LuaMgr.AddTimer(TimerConst.XingZhiCeHuiTimer, this.OnRefreshTime, 60, -1, true)
        LuaMgr.AddClick(this.getRewardBtn, this.OnClickGetRewardBtn)
        LuaMgr.AddClick(this.buyBtn, this.OnClickBuyBtn)
        LuaMgr.AddClick(this.goPopBuyBtnMask, this.OnClickGoPopBuyBtnMask)
        LuaMgr.AddClick(this.popBuyBtn, this.OnClickPopBuyBtn)
        LuaMgr.AddUIEventListener(UIEventConst.HeartAcrossDay, this.before_active)
        LuaMgr.AddUIEventListener(UIEventConst.PayOrder, this.PayOrder)
        LuaMgr.AddUIEventListener(UIEventConst.OnPayResult, this.OnPayResult)
        LuaMgr.AddUIEventListener(UIEventConst.OnPaySuccess, this.OnPaySuccess)
        this.paying = false
        this.before_active()
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.XingZhiCeHuiTimer)
        LuaMgr.RemoveClick(this.getRewardBtn, this.OnClickGetRewardBtn)
        LuaMgr.RemoveClick(this.buyBtn, this.OnClickBuyBtn)
        LuaMgr.RemoveClick(this.goPopBuyBtnMask, this.OnClickGoPopBuyBtnMask)
        LuaMgr.RemoveClick(this.popBuyBtn, this.OnClickPopBuyBtn)
        LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder, this.PayOrder)
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult, this.OnPayResult)
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess, this.OnPaySuccess)
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("ShaLouGroupItem")
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartAcrossDay, this.before_active)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)