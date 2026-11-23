





local this = {vm=nil};
local shopTab=nil
local shopRight_Panel=nil;
local shopLayoutGroup=nil;
local cfgShop=nil;
local curBarIndex=nil;
local shelfId=nil;
local limitTypes={};
local coroutine_Key=nil;
local updateTopBarAction=nil;
local shopFrushRemainTime=nil;
local data = {
    shopBarList={
        {
            barName="",
            barBool=false,
            barTogBg=DefaultSprite,
            barMark=DefaultSprite,
            barAngle=Vector3(0,0,0),
            barId="",
            lockBool=false,
        }
    },
    shopGoodsList={
        {
            limitType="",
            limitBuy="",
            limitBool=false,
            rare=DefaultSprite,
            interactable=false,
            countShow=false,
            icon=DefaultTexture,
            count="",
            name="",
            payIcon=DefaultTexture,
            payPrice="",
            reduceRate="",
            hotBool=false,
            discountBool=false,
            soldOut=false,
            aniName="",
            active=false,
            goods={},
        }
    },
    shopContentAnchorPos=Vector2(0,0);
    shopFrushTimeBool=false;
    shopFrushTimeText="";
}

local command = {
    shopBarTog={
        type=XLuaCommandType.Bool,
        execute=function(vm,isOn,param)
            local index=tonumber(param)+1;
            if isOn and index~=curBarIndex then
                curBarIndex=index;
                this.RefrushShopGoods(true)
                for i,v in ipairs(this.vm.data.shopBarList) do
                    v.barName=curBarIndex==i and string.format("<color=#ffffff>%s</color>",v.name)
                            or string.format("<color=#c1c0c0>%s</color>",v.name);
                end
            end
        end
    },
    shopLockBtn={
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index=tonumber(param)+1;
            local subLockId=shopTab[this.vm.data.shopBarList[index].barId];
            if FeatureManager.IsLock(subLockId) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,FeatureManager.TipStr(subLockId));
            end
        end
    },
  
    shopBuyButtom = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
           local index=tonumber(param)+1;
            local goods=this.vm.data.shopGoodsList[index].goods
            local limitType=this.vm.data.shopGoodsList[index].limitType;
            LuaMgr.ShowLuaPanel(UIName.BuyTipViewModel,goods,limitType,function()
                this.InitShop();
            end)
        end
    },
    
}
local hook = {
    before_awake = function(vm)
        this.vm=vm;
        print("before_awake");
        shopTab={};
        shopTab["1001001"]="1201";
        shopTab["1001007"]="1202";
        shopTab["1001010"]="1203";
        shopTab["1001011"]="1204";
        shopTab["1001002"]="1205";
        limitTypes={LuaMgr.GetLangText("BaseShopViewModel_24"),LuaMgr.GetLangText("BaseShopViewModel_25"),LuaMgr.GetLangText("BaseShopViewModel_26"),LuaMgr.GetLangText("BaseShopViewModel_27")}
        shopRight_Panel=vm.behaviour.transform:Find("root/Left/Right_Content"):GetComponent("RectTransform")
        shopLayoutGroup=vm.behaviour.transform:Find("root/Left/Right_Content/Contrl/Scroll View/Viewport/Content")
                :GetComponent("GridLayoutGroup")
        
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length>0 then
            shelfId=vm.behaviour.Params[0];
            updateTopBarAction=vm.behaviour.Params[1];
        end
        this.ParseData();
    end,
   
    before_deactive = function(vm)
        print("before_deactive");
        if coroutine_Key~=nil then
            coroutine_runner.stop(coroutine_Key);
        end
    end,
    before_destroy=function()
        shopRight_Panel=nil;
        shopLayoutGroup=nil;
    end
}

this.ParseData=function()
    this.ShopAdjustScreen();
    cfgShop=ConfigMgr.Config.shop[ShopType.Market]
    if cfgShop==nil then return end;
    curBarIndex=this.CheckDefaultIndex();
    this.InitShop();
end

this.InitShop=function()
    this.InitShopBar();
    this.RefrushShopGoods();
end

this.ShopAdjustScreen=function()
    local width=LuaMgr.ScreenWidth()-shopRight_Panel.anchoredPosition.x-LuaMgr.ScreenOffSet();
    shopRight_Panel.sizeDelta=Vector2(width,shopRight_Panel.sizeDelta.y);
    local count=math.floor((width+shopLayoutGroup.spacing.x)/(shopLayoutGroup.cellSize.x+shopLayoutGroup.spacing.x));
    local padding=(width+shopLayoutGroup.spacing.x)%(shopLayoutGroup.cellSize.x + shopLayoutGroup.spacing.x);
    shopLayoutGroup.constraintCount = count;
    shopLayoutGroup.padding.left = math.floor(padding / 2-10);
end

this.CheckDefaultIndex=function()
    local index=1;
    if shelfId==nil or FeatureManager.IsLock(shopTab[shelfId])  then  return index end;
    for i,v in ipairs(cfgShop.shelfs) do
        if v.Id==shelfId then
            index=i;
            break;
        end
    end
    return index;
        
    
end

this.InitShopBar=function()
    this.vm.data.shopBarList={};
    local list={};
    for i,v in ipairs(cfgShop.shelfs) do
        local bgName = i%2~=0 and "ui_shop_tab02_01" or "ui_shop_tab02_02";
        local maskName = i%2~=0 and "ui_shop_tab01_01" or "ui_shop_tab01_02";
        local shopBar={
            barId=v.Id;
            barName=curBarIndex==i and string.format("<color=#ffffff>%s</color>",LuaMgr.GetLangText(v.NameLan))
                    or string.format("<color=#c1c0c0>%s</color>",LuaMgr.GetLangText(v.NameLan));
            barBool=curBarIndex==i,
            barTogBg=LuaMgr.GetSprite("Shop",bgName),
            barMark=LuaMgr.GetSprite("Shop",maskName),
            barAngle=1%2~=0 and Vector3(0,0,3) or Vector3(0,0,-3);
            lockBool=FeatureManager.IsLock(shopTab[v.Id]),
            name=LuaMgr.GetLangText(v.NameLan);
        }
        table.insert(list,shopBar);
    end
    this.vm.data.shopBarList=list;
end

this.RefrushShopGoods=function(sub)
    local tab="market_"..cfgShop.shelfs[curBarIndex].Id;
    if updateTopBarAction~=nil then
        updateTopBarAction(tab);
    end
    this.SetFrushTime(cfgShop.shelfs[curBarIndex].RefreshCycle);
    this.vm.data.shopContentAnchorPos=Vector2(0,0);
    this.vm.data.shopGoodsList={};
    local list={};
    local shelf=cfgShop.shelfs[curBarIndex];
    local goods=shelf.goods;
    if  IsNull(goods) or goods==nil  then return end;
    for i,v in ipairs(goods) do
        local item=ConfigHelper.GetItemById(v.Item);

        local myPrice=DataHelper.GetItemCountById(v.Currency);

        local isSoldOut=v.RefreshCount>0 and v.RefreshCount-DataHelper.GetShopRecordByGoodsId(v.Id)<=0;
        if item~=nil then
            local goodItem={
                goods=v,
                limitType=shelf.RefreshCycle,
                limitBuy=string.format("%s<color=#ffffff>%s/%s</color>",limitTypes[shelf.RefreshCycle],
                        DataHelper.GetShopRecordByGoodsId(v.Id),v.RefreshCount);
                limitBool=v.RefreshCount~=0,
                rare=LuaMgr.GetSprite("ShopRare","ui_shop_zt0"..item.rare),
                interactable=not isSoldOut,
                countShow=v.Stack>1,
                icon=LuaMgr.GetTexture(ConfigHelper.GetItemIconPath(v.Item)),
                count=string.format("<size=20>X </size>%s",LuaMgr.NumFormat(v.Stack)),
                name=LuaMgr.GetLangText(item.nameLan),
                payIcon=LuaMgr.GetTexture(ConfigHelper.GetItemIconPath(v.Currency)),
                payPrice=myPrice==nil or myPrice<v.Price
                        and string.format("<color=#EE0A0A>%s</color>",tostring(v.Price)) or tostring(v.Price);
                reduceRate=v.Discount,
                hotBool=v.Hot;
                discountBool=tonumber(v.Discount)<1 and tonumber(v.Discount)>=0;
                soldOut=isSoldOut,
                aniName="",
                active=not sub,
                goods=v,
            }
            table.insert(list,goodItem);
        end
    end
    table.sort(list,function(a, b) return not a.soldOut and b.soldOut end)
    this.vm.data.shopGoodsList=list;
    if not sub then return end;

    if coroutine_Key~=nil then
        coroutine_runner.stop(coroutine_Key);
    end
    coroutine_Key=coroutine_runner.start(function()
        coroutine_runner.wait(0.05);
        local row=math.ceil(#this.vm.data.shopGoodsList/shopLayoutGroup.constraintCount);
        local rowIndex=1;
        for i,v in ipairs(this.vm.data.shopGoodsList) do
            if (i-1)==rowIndex*shopLayoutGroup.constraintCount then
                coroutine_runner.wait(0.1);
                if rowIndex<row then
                    rowIndex=rowIndex+1;
                end
            end
            v.active=true;
            v.aniName="UI_shopItem_02";
        end
    end)
end

this.SetFrushTime=function(frushType)
    local dataShop=DataMgr.Player.shop;
    local tarTimeStamp = 0;
    this.vm.data.shopFrushTimeBool=frushType~=0 or frushType~=4
    if frushType==3 then
        tarTimeStamp = dataShop.monthlyExpiredTime
    elseif frushType==2 then
        tarTimeStamp = dataShop.weeklyExpiredTime
    elseif frushType==1 then
        tarTimeStamp = dataShop.dailyExpiredTime
    else
        return;
    end
    shopFrushRemainTime= tarTimeStamp - LuaMgr.Timestamp();
    if shopFrushRemainTime<0 then
        this.vm.data.shopFrushTimeText=string.format(LuaMgr.GetLangText("BaseShopViewModel_28"),0,0);
    else
        local day=math.floor(shopFrushRemainTime/(24*60*60));
        local hour=math.floor((shopFrushRemainTime%(24*60*60))/(60*60));
        this.vm.data.shopFrushTimeText=string.format(LuaMgr.GetLangText("BaseShopViewModel_29"),day,hour);
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})