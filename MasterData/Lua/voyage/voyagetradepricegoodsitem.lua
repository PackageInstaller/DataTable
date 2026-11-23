VoyageTradePriceGoodsItem = {};

VoyageTradePriceGoodsItem.__index = VoyageTradePriceGoodsItem;

VoyageTradePriceGoodsItem.PortItem = nil;

local objs = {
    icon = { path = "Item/Icon", type = "RawImage" },
    num = { path = "Item/Num/Text", type = "Text" },
    name = { path = "Name", type = "Text" },
    price = { path = "Price", type = "Text" },
    priceIcon = { path = "Price/Icon", type = "RawImage" },
    buys = { path = "Buys", type = "Text" },
    portListTF = { path = "PortList", type = "Transform" },
};

function VoyageTradePriceGoodsItem.New()
    local self = {};
    setmetatable(self, VoyageTradePriceGoodsItem);
    return self;
end

function VoyageTradePriceGoodsItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.portList = UIListView.New(self.portListTF);
end

function VoyageTradePriceGoodsItem:SetData(data)
    self.data = data.data;
    self.icon.texture = GetItemTexture(self.data.GoodsID);
    local count = PlayerVoyageMgr.GetGoods(self.data.GoodsID);
    self.num.text = tostring(count);
    local itemConfig = ConfigItemMgr.GetItemById(self.data.GoodsID);
    if (itemConfig ~= nil) then
        self.name.text = LuaMgr.GetLangText(itemConfig.nameLan);
    end
    self.price.text = tostring(self.data.OriginalPrice);
    self.priceIcon.texture = GetItemHomeIcon("5130");
    self.buys.text = self:GetBuyPort();
    self:SetPorts();
end


function VoyageTradePriceGoodsItem:GetBuyPort()
    local harbor;
    local sailingHarborMap = ConfigMgr.Config.SailingHarborMap;
    local buyPort = "";
    local len = #self.data.BuyHarbors;
    for i = 1, len do
        harbor = sailingHarborMap[self.data.BuyHarbors[i]];
        if (harbor ~= nil) then
            if (buyPort ~= "") then
                buyPort = buyPort .. "\r\n";
            end
            buyPort = buyPort .. LuaMgr.GetLangText("VoyageTradePriceGoodsItem_0") .. LuaMgr.GetLangText(harbor.HarborNameLan);
        end
    end
    return buyPort;
end


function VoyageTradePriceGoodsItem:SetPorts()
    self.portList:Clear();
    local listData;
    local listDatas = {};
    local len = #self.data.SoldHarbors;
    for i = 1, len do
        listData = UIListData.GetData(VoyageTradePriceGoodsItem.PortItem, "VoyageTradePricePortItem", self.data.SoldHarbors[i]);
        table.insert(listDatas, listData);
    end
    self.portList:SetData(listDatas);
end

function VoyageTradePriceGoodsItem:Clear()
    self.data = nil;
    self.icon.texture = nil;
    self.priceIcon.texture = nil;
    self.portList:Clear();
end

function VoyageTradePriceGoodsItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end