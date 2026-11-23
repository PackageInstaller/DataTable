
UICombineBagItem = {}
UICombineBagItem.__index = UICombineBagItem

function UICombineBagItem.New(prefab, parent)
    local self = {}
    setmetatable(self, UICombineBagItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    self.transform = self.gameObject:GetComponent("RectTransform")
    local uiLink = self.gameObject:GetComponent("UILink");
    self.goSoldOut = uiLink:Get("goSoldOut");
    self.btnClick = uiLink:Get("btnClick"):GetComponent("Button");
    self.textName = uiLink:Get("textName"):GetComponent("Text");
    self.textPrice = uiLink:Get("textPrice"):GetComponent("Text");
    self.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    self.rectContent = uiLink:Get("rectContent"):GetComponent("RectTransform");
    self.imgGood = uiLink:Get("imgGood"):GetComponent("Image");
    self.textlimitBuy=uiLink:Get("textlimitBuy"):GetComponent("Text");
    self.uiShopGiftGoodItem=uiLink:Get("UIShopGiftGoodItem")
    SetActive(self.uiShopGiftGoodItem,false);
    self.shopGiftGoodItems={};

    uiLink:AddClickEvent("btnClick", function()
        if  self.fun ~=nil and not self.seldOut then
            self.fun(self.data)
        end
    end)
    
    return self
end


function UICombineBagItem:Destroy()
    self.gameObject = nil
    self.transform = nil
    self.goSoldOut = nil
    self.btnClick = nil
    self.textName = nil
    self.textPrice = nil
    self.ScrollView = nil
    self.rectContent = nil
    self.imgGood = nil
    self.textlimitBuy = nil
    self.uiShopGiftGoodItem = nil
    self.shopGiftGoodItems = {}
end

function UICombineBagItem:SetData(good, combineGiftId, fun)
    self.data=good;
    self.fun=fun;
    
    local _cfgChargeMap= ConfigMgr.Config.charge

    local charge=_cfgChargeMap[good.Id];
    local buyCount=0;
    local _dataShopRecord=DataMgr.Player.shop.records;
    local hasBuy=_dataShopRecord[charge.Id];
    if hasBuy~=nil then
        buyCount=hasBuy;
    end

    self.textName.text=LuaMgr.GetLangText(charge.NameLan);
    self.textPrice.text = ConfigHelper.GetGoodsPriceStr(good.Id)
    self.imgGood.sprite=LuaMgr.GetSprite("Shop",charge.Icon);
    self.textlimitBuy.text=charge.RefreshCount>0 and string.format(LuaMgr.GetLangText(charge.DescriptionLan) .." ( <color=#FFDA73>%s</color>/%s )",buyCount,charge.RefreshCount) or "";
    self.seldOut = DataHelper.GetShopRecordByGoodsId(good.Id) > 0 or DataHelper.GetShopRecordByGoodsId(combineGiftId) > 0
    SetActive(self.goSoldOut, self.seldOut);
    
    
    local charge=_cfgChargeMap[charge.Id];
    local len=0;

    if charge.Reward~=nil then
        len=#charge.Reward
    end
    
    for i = 1, len do
        if i>#self.shopGiftGoodItems then
            table.insert(self.shopGiftGoodItems,UIShopGiftGoodItem.New(self.uiShopGiftGoodItem,self.rectContent))
        end
        
        SetActive(self.shopGiftGoodItems[i].gameObject,true);
        self.shopGiftGoodItems[i]:SetData(charge.Reward[i])
    end

    for i = (len+1), #self.shopGiftGoodItems do
        self.shopGiftGoodItems[i]:Clear();
    end
end

function UICombineBagItem:Clear()
    self.data = nil
    SetActive(self.gameObject, false)
end