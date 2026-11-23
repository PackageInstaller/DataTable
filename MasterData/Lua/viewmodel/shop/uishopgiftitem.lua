
UIShopGiftItem = {}
UIShopGiftItem.__index = UIShopGiftItem

function UIShopGiftItem.New(prefab, parent)
    local self = {}
    setmetatable(self, UIShopGiftItem)
    if prefab==nil then 
        print("InstantiateGO prefab is nil")
        return
    end;
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    self.transform = self.gameObject:GetComponent("RectTransform")
    local uiLink = self.gameObject:GetComponent("UILink");
    self.goGoods = uiLink:Get("goGoods");
    self.goRed = uiLink:Get("goRed");
    self.goZheKou = uiLink:Get("goZheKou");
    self.goTuiJian = uiLink:Get("goTuiJian");
    self.goXianShi = uiLink:Get("goXianShi");
    self.goRemainTime = uiLink:Get("goRemainTime");
    self.goSoldOut = uiLink:Get("goSoldOut");
    self.btnClick = uiLink:Get("btnClick"):GetComponent("Button");
    self.textName = uiLink:Get("textName"):GetComponent("Text");
    self.goPrice = uiLink:Get("goPrice");
    self.textPrice = uiLink:Get("textPrice"):GetComponent("Text");
    self.textPrice2 = uiLink:Get("textPrice2"):GetComponent("Text");
    self.textDisCount = uiLink:Get("textDisCount"):GetComponent("Text");
    self.textRemainTime = uiLink:Get("textRemainTime"):GetComponent("Text");
    self.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    self.rectContent = uiLink:Get("rectContent"):GetComponent("RectTransform");
    self.rawImagePrice = uiLink:Get("rawImagePrice"):GetComponent("RawImage");
    self.imgGood = uiLink:Get("imgGood"):GetComponent("Image");
    self.imgAlpha = uiLink:Get("imgGood"):GetComponent("CanvasGroup");
    self.golimitCount= uiLink:Get("golimitCount");
    self.textlimitBuy=uiLink:Get("textlimitBuy"):GetComponent("Text");
    self.uiShopGiftGoodItem=uiLink:Get("UIShopGiftGoodItem")
    self.go7Days=uiLink:Get("go7days")
    self.jumpObj=uiLink:Get("btnJump");
    if self.jumpObj~=nil then
        self.btnJump=self.jumpObj:GetComponent("Button");
    end
    SetActive(self.uiShopGiftGoodItem,false);
    SetActive(self.go7Days,false);
    self.shopGiftGoodItems={};

    uiLink:AddClickEvent("btnClick", function()
        if  self.fun ~=nil and not self.seldOut and self.data.buyWay ~= 0 then
            self.fun(self.data)
        end
    end)
    if self.btnJump~=nil then
        uiLink:AddClickEvent("btnJump", function()
            if self.jumpInfo~=nil then
                HeroParameter.giftJump="gift";
                LuaMgr.HidePanel(UIName.ShopGiftViewModel);
                LuaMgr.ShowLuaPanel(UIName.HeroSkinViewModel,self.jumpInfo.id, self.jumpInfo.skinId)
            end
        end)
    end
    
    return self
end


function UIShopGiftItem:Destroy()
    self.gameObject = nil
    self.transform = nil
    self.uiMask = nil;
    self.goGoods = nil;
    self.goRed = nil;
    self.goZheKou = nil;
    self.goTuiJian = nil;
    self.goXianShi = nil;
    self.goRemainTime = nil;
    self.goSoldOut = nil;
    self.btnClick = nil;
    self.textName = nil;
    self.textPrice = nil;
    self.textDisCount = nil;
    self.textRemainTime = nil;
    self.ScrollView = nil;
    self.rectContent = nil;
    self.imgPrice = nil;
end

function UIShopGiftItem:SetData(good,fun)
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
    
    local priceStyle=0;
    local RMBPrice=nil;
    local chargeChanel=nil;
    local price_Icon=DefaultTexture;
    if charge.ChargeGroup~=nil and charge.ChargeGroup~="" then
        priceStyle=0
        chargeChanel=ConfigHelper.GetChargeChannel(charge.ChargeGroup);
        if chargeChanel~=nil then
            local priceShow=chargeChanel.PriceShow;
            if charge.RefreshCycle==6 then
                priceShow=string.format("%d",tonumber(priceShow)/7)
            end
            RMBPrice=chargeChanel.CurrencySymbol..priceShow;
        else
            LuaDebug.error("chargeChanel is nil:"..charge.ChargeGroup);
        end
    elseif charge.Cost.count==0 then
        priceStyle=0;
        RMBPrice=LuaMgr.GetLangText("ShopGiftViewModel_5")
    elseif charge.Cost.id~="" and charge.Cost.count~=0  then
        priceStyle=1;
        RMBPrice=tostring(charge.Cost.count);
        price_Icon=ConfigHelper.GetItemTexture_large(charge.Cost.id);
    end
    self.seldOut=charge.RefreshCycle~=6 and charge.RefreshCount~=0 and charge.RefreshCount-buyCount==0;
    self.imgAlpha.alpha=(charge.RefreshCount==0 or charge.RefreshCount-buyCount>0) and 1.0 or 0.5;
    self.imgGood.sprite=LuaMgr.GetSprite("ShopSmallIcon",charge.Icon);
    self.textName.text=LuaMgr.GetLangText(charge.NameLan);
    self.sort=charge.Sort;
    SetActive(self.goPrice, self.data.buyWay ~= 0)
    self.textPrice.text=RMBPrice;
    self.textPrice2.text=RMBPrice;
    SetActive(self.goGoods,priceStyle==1);
    SetActive(self.textPrice.gameObject,priceStyle==0);
    self.rawImagePrice.texture=price_Icon;
    local isFree=charge.ChargeGroup=="" and charge.Cost.count==0 and not self.seldOut and DataMgr.Player.level>=charge.UnlockLv;

    if not isFree and charge ~= nil and charge.ShowGroup == 0 and charge.UnlockLv > 0 and DataMgr.Player.level >= charge.UnlockLv then
        local isBuy = _dataShopRecord[charge.Id] ~= nil
        local tempSortType = UnityEngine.PlayerPrefs.GetInt(DataMgr.Player.uid.."shop_gift"..charge.Id)
        if not isBuy and (tempSortType == nil or tempSortType == 0) then
            isFree = true
            UnityEngine.PlayerPrefs.SetInt(DataMgr.Player.uid.."shop_gift"..charge.Id,1)
            HeroRedDataHelper.FrushMainShopRed();
        end
    end

    self.jumpInfo=nil;
    if not IsNullOrEmpty(charge.Preview) then
        local characterId=string.sub(charge.Preview, 1,5);
        if DataMgr.Player.characters[characterId]~=nil then
            SetActive(self.jumpObj,true)
            self.jumpInfo={id=characterId,skinId=charge.Preview}
        else
            SetActive(self.jumpObj,false)
        end
    else
        SetActive(self.jumpObj,false)
    end
    SetActive(self.goRed,isFree);
    SetActive(self.goZheKou,false)
    self.textDisCount.text=""
    SetActive(self.goTuiJian,charge.Logo=="1")
    SetActive(self.goXianShi,charge.Logo=="2")
    SetActive(self.golimitCount,charge.RefreshCount>0 and not self.seldOut)
    if charge.RefreshCycle==6 then
        SetActive(self.go7Days,true);
        local dayNum=DataHelper.GetCycleBagRemainDays(charge.Id)
        local tips=dayNum<0 and ConfigMgr.LangGlobal("23501") or ConfigMgr.LangGlobal("23502")
        self.textlimitBuy.text=dayNum<0 and string.format(tips,charge.MaxDays) or string.format(tips,dayNum);
        SetActive(self.goSoldOut,false);
        self.imgAlpha.alpha=1.0;
    else
        SetActive(self.go7Days,false);
        SetActive(self.goSoldOut,self.seldOut);
        self.textlimitBuy.text=charge.RefreshCount>0 and string.format(LuaMgr.GetLangText(charge.DescriptionLan) .." ( <color=#ffffff>%s</color>/%s )",buyCount,charge.RefreshCount) or "";
    end
    SetActive(self.goRemainTime,charge.RefreshCycle==5)
    self.textRemainTime.text=HeroRedDataHelper.GetRemianTime(charge);
    local charge=_cfgChargeMap[charge.Id];
    local rewardList=charge.Reward;

    if charge.Shelf=="4001008" then
        rewardList=charge.DayGoods;
    end
    local len=0;
    if not IsNull(rewardList) then
        len=#rewardList
    end
    for i = 1, len do
        if i>#self.shopGiftGoodItems then
            table.insert(self.shopGiftGoodItems,UIShopGiftGoodItem.New(self.uiShopGiftGoodItem,self.rectContent))
        end
        
        SetActive(self.shopGiftGoodItems[i].gameObject,true);
        self.shopGiftGoodItems[i]:SetData(rewardList[i])
    end

    for i = (len+1), #self.shopGiftGoodItems do
        self.shopGiftGoodItems[i]:Clear();
    end
end

function UIShopGiftItem:Clear()
    self.data = nil
    SetActive(self.gameObject, false)
end