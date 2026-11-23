require("Voyage/VoyageTradePriceGoodsItem")
require("Voyage/VoyageTradePricePortItem")

local this = {
    goodsData = nil,
    goodsList = nil,
};

local objs = {
    closeBtn = { path = "root/Middle/Prices/Close", type = "Button" },
    goodsItem = { path = "template/GoodsItem", type = "GameObject" },
    portItem = { path = "template/PortItem", type = "GameObject" },
    goodsTF = { path = "root/Middle/Prices/Goods/Viewport/Content", type = "Transform" },
};


this.SetData = function()
    this.goodsList:Clear();
    local listData;
    local listDatas = {};
    local len = #this.goodsData;
    for i = 1, len do
        listData = UIListData.GetData(this.goodsItem, "VoyageTradePriceGoodsItem", this.goodsData[i]);
        table.insert(listDatas, listData);
    end
    this.goodsList:SetData(listDatas);
end


this.OnClickClose = function()
    LuaMgr.HidePanel(UIName.VoyageTradePriceViewModel);
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.goodsList = UIListView.New(this.goodsTF);
        LuaMgr.AddClick(this.closeBtn, this.OnClickClose);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        VoyageSceneMgr.SetOperate(false);
        VoyageTradePriceGoodsItem.PortItem = this.portItem;
        this.goodsData = vm.behaviour.Params[0];
        this.SetData();
    end,
    before_deactive = function(vm)
        VoyageTradePriceGoodsItem.PortItem = nil;
        this.goodsList:Clear();
        this.goodsData = nil;
        VoyageSceneMgr.SetOperate(true);
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickClose);
        UIListView.ClearItem("VoyageTradePriceGoodsItem");
        UIListView.ClearItem("VoyageTradePricePortItem");
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})