
local this = {
    vm = nil,
    randShop = {},
    cfgRandomGoods = {},
    shelfId = nil,   
};
local data = {
    goodList = {
        {
            name = "",
            rare = DefaultSprite,
            icon = DefaultTexture,
            count = "",
            isDis = false,
            priceIcon = DefaultTexture,
            price = "",
            disRate = "",
            isSellOut = false,
        }
    },
    contentAnchorPos = Vector2(0, 0),
    timer = "",
    titleIcon = DefaultSprite,


}

local command = {
    buyBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)         
            local index = tonumber(param) + 1;
            local goodItem = this.vm.data.goodList[index];
            local locIndex = this.vm.data.goodList[index].locIndex
            local isSellOut = goodItem.isSellOut
            local randomGoods = this.cfgRandomGoods[goodItem.id];
            if(isSellOut == true) then
                return;
            end
            local goods = {
                RefreshCount = randomGoods.LimitCount,
                Id = goodItem.id,
                Item = randomGoods.Item[1].id,
                Stack = randomGoods.Item[1].count,
                Price = randomGoods.Price,
                Currency = randomGoods.Currency,
                isRandom = true,
                index = locIndex,
                shelfId = this.shelfId,
            }

            LuaMgr.ShowLuaPanel(UIName.BuyTipViewModel, goods, 1, function()
                this.ParseData();
            end)
        end
    },
    closeBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.PackUpDailyShopViewModel)
        end
    },

}
local hook = {
    before_awake = function(vm)
        this.vm = vm;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.cfgRandomGoods = ConfigMgr.Config.RandGoodsMap;
            this.vm.data.contentAnchorPos = Vector2(0, 0)
            RedMgr.Singleton:FrushRedCondition("17005")
            PackUpMgr.CheckRandomShopRedDot()
            RedMgr.Singleton:Refresh()
            this.shelfId = vm.behaviour.Params[0]
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then
        end
    end,
    before_destroy = function()
        this.Clear();
    end


}

this.Clear = function()
    this.randShop = nil;
    this.cfgRandomGoods = nil;
    this.shelfId = "";
end

this.ParseData = function()
    this.randShop = DataMgr.Player.randShop[this.shelfId]
    local iconName = string.gsub(this.shelfId, "PUActivityShop", "")
    this.vm.data.titleIcon = LuaMgr.GetSprite("PackUp", "ui_hd_ysjt_zx_sdtc_bt0" .. iconName),
        this.SetShop();
end
this.SetShop = function()
    local list = {}
    local goodItem = {}
    for i, v in ipairs(this.randShop.goods) do
        local cfgGoods = this.cfgRandomGoods[v];
        local item = ConfigHelper.GetItemById(cfgGoods.Item[1].id);
        goodItem = {
            locIndex = i - 1,
            id = v,
            rare = LuaMgr.GetSprite("ItemRare", "itemRare" .. item.rare),
            icon = LuaMgr.GetTexture(ConfigHelper.GetItemIconPath(cfgGoods.Item[1].id)),
            count = "x" .. LuaMgr.NumFormat(cfgGoods.Item[1].count),
            isDis = tonumber(cfgGoods.Discount) < 1,
            isSellOut = cfgGoods.LimitCount <= this.randShop.buycnt[i],
            priceIcon = LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath(cfgGoods.Currency)),
            price = LuaMgr.NumFormat(cfgGoods.Price),
            orderNum = cfgGoods.Discount,

        }

goodItem.name = LuaMgr.GetLangText(item.nameLan)
        if goodItem.isDis then
            goodItem.disRate = string.format("%2d", cfgGoods.Discount * 100) .. "%";
        end
        table.insert(list, goodItem);
    end
    table.sort(list, function(a, b)
        if not a.isSellOut and not b.isSellOut then
            return tonumber(a.orderNum) < tonumber(b.orderNum);
        end
        return not a.isSellOut and b.isSellOut
    end)
    this.vm.data.goodList = list;
    list = nil;
    this.vm.data.timer = LuaMgr.GetLangText("ChanganDailyShopViewModel_0");
end

return vm({
    data = data,
    command = command,
    hook = hook
})