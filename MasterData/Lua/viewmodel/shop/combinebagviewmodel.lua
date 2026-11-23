require("ViewModel/Shop/UICombineBagItem")
require("ViewModel/Shop/UIShopGiftGoodItem")

local this = {
    vm=nil,
    data={
        giftList = {},
        combineBagGiftItems = {},
        combineBagGift = "",
        isPaying = false,
        curChooseGoodsId = "",
        showSecondBuyFunc = nil,
    },
    rectContent = nil,
    uiCombineBagItem = nil,
    bgRect = nil,
};

local data = {
    canBuyCombine = false,
    canNotBuyCombine = false,
}

local command = {
    CombineBuyCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.data.showSecondBuyFunc(this.data.combineBagGift)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        local uiLink = vm.behaviour.gameObject.gameObject:GetComponent("UILink");
        this.rectContent = uiLink:Get("rectContent"):GetComponent("RectTransform");
        this.uiCombineBagItem = uiLink:Get("UICombineBagItem")
        this.bgRect = uiLink:Get("rectBg"):GetComponent("RectTransform");

        SetActive(this.uiCombineBagItem, false)
    end,
    
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        if vm.behaviour.Params.Length > 0 then
            this.data.giftList = ConfigHelper.CheckGiftListByTime(vm.behaviour.Params[0])
        end

        if vm.behaviour.Params.Length > 1 then
            this.data.showSecondBuyFunc = vm.behaviour.Params[1]
        end
        
        local addWidth = LuaMgr.GetScreenAddWidth();
        local width = math.min(1000 + addWidth, 1200)
        this.bgRect.sizeDelta = Vector2(width, 524)

        this.ParseData()

        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess,this.FrushData);
        LuaMgr.AddUIEventListener(UIEventConst.OnPaySuccess,this.FrushData);
        LuaMgr.RemoveUIEventListener(UIEventConst.ShopGiftBuyEditorSuccess,this.FrushData);
        LuaMgr.AddUIEventListener(UIEventConst.ShopGiftBuyEditorSuccess,this.FrushData);
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartAcrossDay,this.FrushData);
        LuaMgr.AddUIEventListener(UIEventConst.HeartAcrossDay,this.FrushData);
    end,

    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess,this.FrushData);
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartAcrossDay,this.FrushData);
        LuaMgr.RemoveUIEventListener(UIEventConst.ShopGiftBuyEditorSuccess,this.FrushData);
    end,

    before_destroy = function(vm)
        this.vm.data = nil;
        this.vm.behaviour = nil;
        this.vm = nil;
        this.data=nil;
    end,
}

this.ParseData = function()
    this.data.isPaying = false
    this.data.chargeId = ""
    local canBuyCombineGift = true
    local combineBagCfg = ConfigMgr.Config.CombineBagMap
    local goodsDataList = {}
    for i,v in ipairs(this.data.giftList) do
        local cfg = combineBagCfg[v.Id]
        if IsNull(cfg.Mark) or next(cfg.Mark) == nil then
            table.insert(goodsDataList, v)
        else
            this.data.combineBagGift = v
        end

        if DataHelper.GetShopRecordByGoodsId(v.Id) > 0 then
            canBuyCombineGift = false
        end
    end
    
    local index=0;
    for i, v in ipairs(goodsDataList) do
        index=index+1;
        if index > #this.data.combineBagGiftItems then
            table.insert(this.data.combineBagGiftItems, UICombineBagItem.New(this.uiCombineBagItem, this.rectContent))
        end
        SetActive(this.data.combineBagGiftItems[index].gameObject,true);
        this.data.combineBagGiftItems[index]:SetData(v, this.data.combineBagGift.Id, function(good)
            if this.data.showSecondBuyFunc ~= nil then
                this.data.showSecondBuyFunc(good)
            end
        end);
    end
    
    for i = (index+1), #this.data.combineBagGiftItems do
        this.data.combineBagGiftItems[i]:Clear();
    end

    this.vm.data.canBuyCombine = canBuyCombineGift
    this.vm.data.canNotBuyCombine = not canBuyCombineGift
end

this.FrushData=function()
    this.ParseData();
end

return vm({
    data = data,
    command = command,
    hook = hook
})