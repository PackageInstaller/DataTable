
UIShopGiftGoodItem = {}
UIShopGiftGoodItem.__index = UIShopGiftGoodItem

function UIShopGiftGoodItem.New(prefab, parent)
    local self = {}
    setmetatable(self, UIShopGiftGoodItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    self.transform = self.gameObject:GetComponent("RectTransform")
    local uiLink = self.gameObject:GetComponent("UILink");
    self.uiGoodsItem = uiLink:Get("uiGoodsItem");
    self.uiLine = uiLink:Get("uiLine");
    self.textName = uiLink:Get("textName"):GetComponent("Text");
    self.textCount = uiLink:Get("textCount"):GetComponent("Text");
    self.uiGoods= uiLink:Get("uiGoodsItem"):GetComponent("GoodsViewModel");
    return self
end

function UIShopGiftGoodItem:Destroy()
    self.gameObject = nil
    self.transform = nil
    self.uiGoodsItem = nil;
    self.uiLine = nil;
    self.textName = nil;
    self.textCount = nil;
end

function UIShopGiftGoodItem:SetData(data)
    local item =ConfigMgr.Config.itemMap[tostring(data.id)];
    self.uiGoods:SetData(tostring(data.id),data.count,1,0.62,true)
    self.textName.text = LuaMgr.GetLangText(item.nameLan);
    self.textCount.text = "x ".. data.count;
end

function UIShopGiftGoodItem:Clear()
    self.data = nil
    SetActive(self.gameObject, false)
end