





local this = {
    vm = nil;
    data =
    {
        typeBar=nil;
        subTypeBar=nil;
        marketList={};
        shelfGoods={};
        typeIndex=nil;
        shelfIndex=nil;
        distance=nil;
        lastTypeIndex=nil;
        limitTypes={};
        refreshCycle=nil;
        randRomShelf={};
        cfgRandomGoods={};
        shelfId=nil;
        shopFrushRemainTime=nil;
        shopLockState=nil;
        tweeer=nil;
        isComplete=true;
        type_scrollView=nil;
        subPos=nil;
    };
};


local data = {
    typeBarList={
        {
            pos=Vector2(0,0),
            barName="",
            isOn=false,
            isOff=false,
            barId="",
            alpha=1.0,
            isMore=false,
            isLock=false,
        }
    },
    subBarList={
        {
            barName="",
            isOn=false,
            isOff=false,
            barId="",
            alpha=1.0,
            isLock=false,
            isMask=false,
            isSellOut = false,
        }
    },
    goodsList={
        {
            animaName="";
            locIndex=0,
type=0,
            name="",
            rare=DefaultSprite,
            icon=DefaultTexture,
            isCount=false,
            count="",

            limitInfo="",
            isDis=false,
            isHot=false,
            isDisPrice=false,
            isPrice=false,
            isSellOut=false,
            isOwned = false,
            priceIcon=DefaultTexture,
            price="",
            disPrice="",
            disRate="",
            towPrice = false,
            priceIcon2 = DefaultTexture,
            price2 = "",
        }
    },
    subTfPos=Vector2(0,0);
    subTfIsBool=false;
    subTfSizeDelta=Vector2(0,0);
    timer="";
    timerBool=false;
    contentPos=Vector2(0,0);
    contentSize=Vector2(1060,580),
    

    
    pushGroupBool=false,
    pushImg=DefaultSprite,
    pushTime="",
    pushAllCount="",
    isPushTime=false,
    showBulkPurchaseBtn = false,
    

    goFoundationMusicText = "",
    showGoFoundationMusicBtn = false,
}

local command = {
    typeBarBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param)+1;
            if not this.data.isComplete then return end;
            if index~=this.data.typeIndex then
                this.data.typeIndex=index;
                this.SetTypeBarIsOn();
                this.CheckSetLeftSubBarList();
            else
                local shelfs=this.data.marketList[this.data.typeIndex].shelfs;
                if #shelfs==1 then
                    return;
                end
                if this.vm.data.subTfIsBool then
                    this.vm.data.subTfIsBool=false;
                    this.vm.data.typeBarList[this.data.typeIndex].isOn=false;
                    this.vm.data.typeBarList[this.data.typeIndex].isOff=true;
                    this.TypeBarDoMove(0.1,-1);
                    this.data.type_scrollView.content.sizeDelta=Vector2(336,#this.data.marketList*80);
                else
                    this.vm.data.subTfIsBool=true;
                    this.vm.data.typeBarList[this.data.typeIndex].isOn=true;
                    this.vm.data.typeBarList[this.data.typeIndex].isOff=false;
                    this.data.distance=this.SubShelfsCount(shelfs)*60;
                    this.TypeBarDoMove(0.2,1);
                end
            end
        end 
    },

    subBarMaskBtn= {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            
            local index = tonumber(param) + 1;
            local shelfCount = #this.data.marketList[this.data.typeIndex].shelfs;
            
            if shelfCount == 1 or index > shelfCount then
                return ;
            end

            local shelf = this.data.marketList[this.data.typeIndex].shelfs[index];

            local unlockStr = LuaMgr.GetLangText(shelf.UnlockLan);

            if unlockStr == nil then
                return ;
            end

            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, unlockStr);

        end
    },

    typeMaskBtn= {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            
            local index = tonumber(param) + 1;
            
            local shelf=this.data.marketList[index].shelfs;





            for i = 1, #shelf do

                local item= shelf[i];
                
                if this.GetSubLockState(item.Id) then

                    local unlockStr = LuaMgr.GetLangText(item.UnlockLan);

                    if unlockStr == nil then
                        return ;
                    end

                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, unlockStr);

                    break ;
                end
            end

        end
    },
    
    
    subBarBtn={
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index=tonumber(param)+1;
            if index==this.data.shelfIndex then return end;
            this.data.shelfIndex=index;
            this.SetSubBarIsOn();
            this.SetGoodsList();
        end
    },
  
    shopBuyBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
           local index=tonumber(param)+1;
            local goodItem=this.vm.data.goodsList[index];
            local locIndex=this.vm.data.goodsList[index].locIndex
            local goods=this.data.shelfGoods[locIndex];
            local towPrice = nil
            if not TableIsNull(goods) and goods.Price2 ~= nil and not TableIsNull(goods.Price2) then
                towPrice = goods.Price2
            end
            if goodItem.type==1 then

                towPrice = nil
                 local randomGoods=this.data.cfgRandomGoods[goodItem.id];
                 goods = {
                    RefreshCount = randomGoods.LimitCount,
                    Id = goodItem.id,
                    Item = goodItem.group == 1 and "3225" or randomGoods.Item[1].id,
                    Stack = goodItem.group == 1 and 1 or randomGoods.Item[1].count,
                    Price = randomGoods.Price,
                    Currency = randomGoods.Currency,
                    isRandom=true;
                    index=locIndex;
                    shelfId=this.data.shelfId;
                }
            end

            LuaMgr.ShowLuaPanel(UIName.BuyTipViewModel,goods,this.data.refreshCycle,function()
                if #this.data.marketList[this.data.typeIndex].shelfs>1 then

                    this.data.shopLockState=DataMgr.Player.shop.lockStatus;
                    for i,v in ipairs(this.vm.data.subBarList) do
                        v.isLock=this.GetSubLockState(v.barId);
                        v.alpha= v.isLock and 0.7 or 1.0;
                        v.isSellOut = this.CheckShelfIsSellOut(this.data.marketList[this.data.typeIndex].shelfs[i].goods)
                    end
                end
                this.SetGoodsList();
            end,towPrice)
        end
    },
    
    furnitureShopOrderCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.FurnitureShopOrderPopup, this.data.shelfGoods, function()
                if #this.data.marketList[this.data.typeIndex].shelfs>1 then

                    this.data.shopLockState=DataMgr.Player.shop.lockStatus;
                    for i,v in ipairs(this.vm.data.subBarList) do
                        v.isLock=this.GetSubLockState(v.barId);
                        v.alpha= v.isLock and 0.7 or 1.0;
                        v.isSellOut = this.CheckShelfIsSellOut(this.data.marketList[this.data.typeIndex].shelfs[i].goods)
                    end
                end
                this.SetGoodsList();
            end)
        end
    },
    
    goFoundationMusicBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if FeatureManager.IsLock("1302") then
                local tipStr = FeatureManager.TipStr("1302");
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipStr);
                return
            end
            LuaMgr.ShowLuaPanel(UIName.FoundationBgmViewModel)
        end
    }
}
local hook = {
    before_awake = function(vm)
        this.vm=vm;

        this.data.limitTypes={LuaMgr.GetLangText("MarketViewModel_0"),LuaMgr.GetLangText("MarketViewModel_1"),LuaMgr.GetLangText("MarketViewModel_2"),LuaMgr.GetLangText("MarketViewModel_3"),LuaMgr.GetLangText("MarketViewModel_4")}
        this.data.type_scrollView=vm.behaviour.transform:Find("root/Middle/LeftBG/types/ScrollView"):GetComponent("ScrollRect");
        this.data.type_scrollView.onValueChanged:AddListener(this.TypeBarOnValueChanged);
    end,
    before_active = function(vm)

        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length>0 then
            local strs = NumTool.split(vm.behaviour.Params[0], "_")
            this.data.typeBar=strs[1];
            if #strs > 1 then
                this.data.subTypeBar=strs[2];
            end
        else

            this.data.typeBar=ConfigMgr.Config.constants.DefaultShop[1];
        end
        this.data.marketList={}
        local shops=table.Copy(ConfigMgr.Config.shop)
        for i,v in pairs(shops) do
            if v.Type==2 and this.CheckShopTypeOnLine(v) then
                table.insert(this.data.marketList,v);
            end
        end
        if #this.data.marketList>0 then
            table.sort(this.data.marketList,function(a, b)  
                return a.Order<b.Order;
            end)
            this.data.cfgRandomGoods=ConfigMgr.Config.RandGoodsMap;
            this.data.distance=nil;
            this.data.lastTypeIndex=nil;
            this.data.shelfIndex=nil;
            this.data.subPos=nil;
            this.data.type_scrollView.content.anchoredPosition=Vector2.zero;
            this.ParseData();
        end
    end,
   
    before_deactive = function(vm)

    end,
    
    before_destroy = function(vm)
        this.vm.data = nil;
        this.vm.behaviour = nil;
        this.vm = nil;
        this.data = nil;
    end,
}

this.CheckShopTypeOnLine=function(shopItem)
    local len = #shopItem.shelfs;
    local i = 0;
    local sysTime = LuaMgr.Timestamp();
    while (i < len) do
        i = i + 1;
        if shopItem.shelfs[i].StartTime~=0 or shopItem.shelfs[i].EndTime~=0 then
            if sysTime<shopItem.shelfs[i].StartTime or sysTime>shopItem.shelfs[i].EndTime then
                table.remove(shopItem.shelfs, i);
                i = i - 1;
                len = len - 1;
            end
        end
    end
    return #shopItem.shelfs>0;
end


this.ParseData=function()
    this.data.isComplete=true;
    this.data.shopLockState=DataMgr.Player.shop.lockStatus;
    this.SetLeftTypeList();
end


this.SetTypeBarIsOn=function()
    for i,v in ipairs(this.vm.data.typeBarList) do
        v.isOn=i==this.data.typeIndex;
        v.isOff=i~=this.data.typeIndex;
    end
end

this.SetSubBarIsOn=function()
    for i,v in ipairs(this.vm.data.subBarList) do
        v.isOn=i==this.data.shelfIndex;
        v.isOff=i~=this.data.shelfIndex;
    end
end

this.SetLeftTypeList=function()
    this.vm.data.typeBarList={};
    local list={}
    local barItem=nil;
    this.data.typeIndex=1;
    for i,v in ipairs(this.data.marketList) do
        barItem= {
            pos = Vector2(0, 0),
            barName = LuaMgr.GetLangText(v.NameLan),
            isOn = v.Id ==  this.data.typeBar,
            isOff = v.Id ~=  this.data.typeBar,
            barId = v.Id,
        }

        barItem.isLock=this.GetTypeBarLockState(v.shelfs);
        barItem.alpha=barItem.isLock and 0.7 or 1.0;
        barItem.isMore=this.SubShelfsCount(v.shelfs)>1;
        barItem.pos=Vector2(0,-80*(i-1));
        table.insert(list,barItem);
        if barItem.isOn then
            this.data.typeIndex=i;
        end
    end
    this.vm.data.typeBarList=list;
    list=nil;
    this.CheckSetLeftSubBarList();
    local height=this.SubShelfsCount(this.data.marketList[this.data.typeIndex].shelfs)*60+#this.data.marketList*80
    this.data.type_scrollView.content.sizeDelta=Vector2(336,height);
end

this.SubShelfsCount=function(shelfs)
    local count=0;
    for i,v in ipairs(shelfs) do
        if FeatureManager.UnifyVerControls("shelf",v.Id) then
           count=count+1;
        end
    end
    return count;
end

this.GetTypeBarLockState=function(shelfs)
    for i,v in ipairs(shelfs) do
        if not this.GetSubLockState(v.Id) then
            return false;
        end
    end
    return true;
end

this.GetSubLockState=function(subBar)
    return this.data.shopLockState[subBar]~=nil and this.data.shopLockState[subBar];
end

this.CheckShelfIndex=function(delftShelf,shelfs)

    local tempShelf=nil;
    for i,v in ipairs(shelfs) do
        if not this.GetSubLockState(v.Id) and  not this.CheckShelfIsSellOut(v.goods) then
            if v.Id==delftShelf then
                return delftShelf;
            end
            if tempShelf==nil then
                tempShelf=v.Id;
            end
        end
    end

    if tempShelf==nil then
        tempShelf=delftShelf;
    end
    return tempShelf;
end

this.CheckShelfIsSellOut=function(goods)
    local isSellOut = false
    local isOwned = false
    for i,v in ipairs(goods) do
        isOwned = this.CheckGoodsIsOwned(v)
        isSellOut=v.RefreshCount>0 and v.RefreshCount-DataHelper.GetShopRecordByGoodsId(v.Id)<=0;
        if not isSellOut and not isOwned then
            return false
        end
    end
    return true;
end


this.UpdateBarByID=function(interfaceId)
    if interfaceId==nil or interfaceId=="" then
        return;
    end
    local interface=nil;
    for i,v in ipairs(ConfigMgr.Config.interfaces) do
        if v.id==interfaceId then
            interface=v;
            break;
        end
    end
    if interface==nil then
        return
    end
    local tab=interface.tab;
    this.vm.behaviour:UpdateTopBar(tab,nil);
end


this.CheckSetLeftSubBarList=function()
    local typeBarShop=this.data.marketList[this.data.typeIndex];
    if typeBarShop~=nil then
        this.UpdateBarByID(typeBarShop.InterfaceId);
        if #typeBarShop.shelfs>1 then
            local defaultShelf = this.data.subTypeBar == nil and typeBarShop.DefaultShelf or this.data.subTypeBar
            local openShelf=this.CheckShelfIndex(defaultShelf,typeBarShop.shelfs)
            this.SetLeftSubBarList(openShelf,typeBarShop.shelfs);
            local callBack=function()
                this.data.subPos=Vector2(0,-this.data.typeIndex*80)
                this.vm.data.subTfPos=this.data.subPos;
                this.TypeBarOnValueChanged();

                this.vm.data.subTfSizeDelta=Vector2(336,60*#this.vm.data.subBarList)

                this.data.distance=#this.vm.data.subBarList*60;
                this.TypeBarDoMove(0.2,1);
            end
            if  this.data.distance~=nil then
                this.TypeBarDoMove(0.1,-1,callBack);
            else
                callBack();
            end
        else
            this.data.shelfIndex=1;
            this.TypeBarDoMove(0.1,-1);
            
        end
        this.SetGoodsList()
    end
end


this.SetLeftSubBarList=function(openShelf,shelfs)
    this.vm.data.subBarList={}
    local list={}
    local subBarItem=nil;
    this.data.shelfIndex=1;
    for i,v in ipairs(shelfs) do
        if FeatureManager.UnifyVerControls("shelf",v.Id) then
            subBarItem= {
                barName = LuaMgr.GetLangText(v.NameLan),
                isOn = openShelf == v.Id,
                isOff = openShelf ~= v.Id,
                barId = v.Id,
                isMask=i==1,
                isSellOut = this.CheckShelfIsSellOut(v.goods),
            }
            subBarItem.isLock=this.GetSubLockState(v.Id);
            subBarItem.alpha= subBarItem.isLock and 0.7 or 1.0;
            table.insert(list,subBarItem);
            if subBarItem.isOn then
                this.data.shelfIndex=i;
            end
        end
    end
    this.vm.data.subBarList=list;
    list=nil;
end



this.PushBaseInfo=function(shelf,goodsCount)
    this.vm.data.contentPos=Vector2(0,0);
    local height=math.ceil(goodsCount/4)*290;
    if shelf.Recommend=="" then
        this.vm.data.contentSize=Vector2(1060,height)
        this.vm.data.pushGroupBool=false;
        return
    end
    this.vm.data.pushGroupBool=true;
    this.vm.data.pushImg=LuaMgr.GetSprite("Market",shelf.Recommend);
    this.vm.data.contentSize=Vector2(1060,height+300)
    this.vm.data.isPushTime=shelf.HideTime==1;
    if shelf.HideTime==1 then
        this.data.shopFrushRemainTime= shelf.EndTime - LuaMgr.Timestamp();
        if this.data.shopFrushRemainTime<0 then
            this.vm.data.timer=string.format(LuaMgr.GetLangText("MarketViewModel_7"),0,0);
        else
            local day=math.floor(this.data.shopFrushRemainTime/(24*60*60));
            local hour=math.floor((this.data.shopFrushRemainTime%(24*60*60))/(60*60));
            this.vm.data.pushTime=string.format(LuaMgr.GetLangText("MarketViewModel_8"),day,hour);
        end
    end
end

this.SetGoodsList=function()
    local shelf=this.data.marketList[this.data.typeIndex].shelfs[this.data.shelfIndex];
    this.data.shelfId=shelf.Id;
    this.vm.data.showBulkPurchaseBtn = this.data.marketList[this.data.typeIndex].Id == "furnitureShop"
    this.vm.data.showGoFoundationMusicBtn = shelf.Shop == "avatarShop"

    if this.data.marketList[this.data.typeIndex].Id=="random" then
        this.data.refreshCycle=1;
        this.data.randRomShelf=DataMgr.Player.randShop[shelf.Id]
        this.SetRandRomGoods();
        this.PushBaseInfo(shelf,#this.data.randRomShelf.goods)
        DataReportMgr.OpenShopView(this.data.marketList[this.data.typeIndex].Id,shelf.Id,LuaMgr.GetLangText(shelf.NameLan),this.data.randRomShelf.goods,2)
        DataReportMgr.OpenShopShowView(this.data.marketList[this.data.typeIndex].Id,shelf.Id,LuaMgr.GetLangText(shelf.NameLan),this.data.randRomShelf.goods,2)
        return;
    end
    this.PushBaseInfo(shelf,#shelf.goods)
    this.data.shelfGoods=shelf.goods;
    this.data.refreshCycle=shelf.RefreshCycle;
    this.vm.data.goodsList={};
    local isAllSellOut = true
    local list={}
    for i,v in ipairs(this.data.shelfGoods) do
        local item=ConfigHelper.GetItemById(v.Item);

        local goodItem={
            locIndex=i,
            type=0,
            rare=LuaMgr.GetSprite("ItemRare","itemRare"..item.rare),
            icon=LuaMgr.GetTexture(ConfigHelper.GetItemIconPath(v.Item)),
            isCount=v.Stack>1,
            count=LuaMgr.NumFormat(v.Stack),

            isDis=tonumber(v.Discount)<1,
            isHot=v.Hot,
            isPrice=tonumber(v.Discount)==1 and TableIsNull(v.Price2),
            towPrice = tonumber(v.Discount) == 1 and not TableIsNull(v.Price2),
            isSellOut=v.RefreshCount>0 and v.RefreshCount-DataHelper.GetShopRecordByGoodsId(v.Id)<=0;
            priceIcon=LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath(v.Currency)),
            price=LuaMgr.NumFormat(v.Price),
            orderNum=v.Order,
            isOwned = false,

        }

goodItem.name=LuaMgr.GetLangText(item.nameLan)
        if v.RefreshCount~=0 then
            goodItem.limitInfo=this.data.refreshCycle==0 and "" or  string.format("%s %s/<color=#777777>%s</color>", this.data.limitTypes[this.data.refreshCycle],
                    DataHelper.GetShopRecordByGoodsId(v.Id),v.RefreshCount);
        else
            goodItem.limitInfo=""
        end
        if goodItem.isDis then
            goodItem.disRate=string.format("%2d",v.Discount*100).."%";
            goodItem.disPrice=LuaMgr.NumFormat(tonumber(v.Discount)*v.Price);
        end
        goodItem.animaName="ani_MarketPanelGoodItem"
        if not TableIsNull(v.Price2) then
            goodItem.priceIcon2 = LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath(v.Price2[1]))
            goodItem.price2 = LuaMgr.NumFormat(v.Price2[2])
        end

        if v.Shelf == "avatarShop1" or v.Shelf == "PassesShop" then
            goodItem.isSellOut = this.GetPlayerWhetherHave(v.IsFind,v.Item)
        end
        if not goodItem.isSellOut then
            isAllSellOut = false
            goodItem.isOwned = this.CheckGoodsIsOwned(v)
        end
        table.insert(list,goodItem);
    end
    table.sort(list,function(a,b)
        if a.isSellOut == b.isSellOut then
            if a.isOwned == b.isOwned then
                return a.orderNum>b.orderNum;
            else
                return not a.isOwned and b.isOwned
            end
        else
            return not a.isSellOut and b.isSellOut
        end
    end)










    this.vm.data.goodsList=list;
    list=nil;
    this.SetFrushTime(0);
    DataReportMgr.OpenShopView(this.data.marketList[this.data.typeIndex].Id,shelf.Id,LuaMgr.GetLangText(shelf.NameLan),shelf.goods,3,false)
    DataReportMgr.OpenShopShowView(this.data.marketList[this.data.typeIndex].Id,shelf.Id,LuaMgr.GetLangText(shelf.NameLan),shelf.goods,3,false)
    
    if isAllSellOut then
        this.vm.data.showBulkPurchaseBtn = false
    end
end

this.SetRandRomGoods=function()
    this.vm.data.goodsList={};
    local list={}
    for i,v in ipairs(this.data.randRomShelf.goods) do
        local cfgGoods=this.data.cfgRandomGoods[v];
        local item=ConfigHelper.GetItemById(cfgGoods.Item[1].id);

        local goodItem={
            id=v,
            locIndex=i-1,
            type=1,
            rare=cfgGoods.Group == 1 and LuaMgr.GetSprite("ItemRare","itemRare4") or LuaMgr.GetSprite("ItemRare","itemRare"..item.rare),
            icon=cfgGoods.Group == 1 and LuaMgr.GetTexture(ConfigHelper.GetItemIconPath("3225")) or LuaMgr.GetTexture(ConfigHelper.GetItemIconPath(cfgGoods.Item[1].id)),
            isCount= not (cfgGoods.Group == 1) and cfgGoods.Item[1].count>1 or false,
            count=LuaMgr.NumFormat(cfgGoods.Item[1].count),
            limitInfo=string.format("%s %s/<color=#777777>%s</color>", this.data.limitTypes[this.data.refreshCycle],
                    this.data.randRomShelf.buycnt[i],cfgGoods.LimitCount);
            isHot=cfgGoods.Hot,
            isDis=tonumber(cfgGoods.Discount)<1,
            isPrice=tonumber(cfgGoods.Discount)==1,
            isSellOut=cfgGoods.LimitCount<=this.data.randRomShelf.buycnt[i];
            priceIcon=LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath(cfgGoods.Currency)),
            price=LuaMgr.NumFormat(cfgGoods.Price);
            orderNum=cfgGoods.Discount;
            group = cfgGoods.Group,
            towPrice = false,
            isOwned = false,

        }
        local name=cfgGoods.Group == 1 and LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["15605"].NameLan) or LuaMgr.GetLangText(item.nameLan);
        goodItem.name=NumTool.GetStringLength(name)<6 and name or string.format("<size=26>%s</size>",name);
        if goodItem.isDis then
            goodItem.disRate=string.format("%2d",cfgGoods.Discount*100).."%";
            goodItem.disPrice=LuaMgr.NumFormat(tonumber(cfgGoods.OriginalPrice));
        end
        goodItem.animaName="ani_MarketPanelGoodItem"
        table.insert(list,goodItem);
    end
    table.sort(list,function(a, b)
        if not a.isSellOut and not b.isSellOut then
            return tonumber(a.orderNum)<tonumber(b.orderNum);
        end
        return not a.isSellOut and b.isSellOut end)
    this.vm.data.goodsList=list;
    list=nil;
    this.SetFrushTime(1);
    
end

this.TypeBarDoMove=function(time,dir,callBack)
    this.vm.data.subTfIsBool=dir>0;
    if dir>0 then
        this.data.type_scrollView.content.sizeDelta=Vector2(336,#this.data.marketList*80+this.data.distance);
    else

    end
if  this.data.distance==nil then
        return
    end

if (this.data.typeIndex>=#this.vm.data.typeBarList and dir>0) or (dir<0 and this.data.lastTypeIndex>=#this.vm.data.typeBarList) then
if dir>0 then
            this.data.lastTypeIndex= this.data.typeIndex
            this.data.distance=0;
else
            this.data.distance=nil
            this.data.lastTypeIndex=nil;
        end
        if callBack~=nil then
            callBack();
        end
        return;
    end
    this.data.isComplete=false
    local dis=dir>0 and - this.data.distance or  this.data.distance;
local index=dir>0 and this.data.typeIndex or this.data.lastTypeIndex;
    for i,v in ipairs(this.vm.data.typeBarList) do
        if i>index then
            this.data.tweeer=DOTWeen.To(function() return v.pos; end,
                    function(vector) v.pos=vector; end,
                    Vector2(0,v.pos.y+dis),time):SetEase(Ease.Linear);
            this.data.tweeer.onComplete=function()
this.data.isComplete=true;
                v.pos=dir>0 and Vector2(0,-80*(i-1)+dis) or Vector2(0,-80*(i-1));
                if i==index+1 then
                    if dir>0 then
                        this.data.lastTypeIndex=this.data.typeIndex;
                    else
                        this.data.distance=nil;
                    end
                    if callBack~=nil then
                        callBack();
                    end
                end
            end;
        end
    end
    
end

this.SetFrushTime=function(type)
    local tarTimeStamp = 0;
    if type==1 then

        tarTimeStamp=this.data.randRomShelf.expiredtime
        this.vm.data.timerBool=true;
    else
        local dataShop=DataMgr.Player.shop;
        this.vm.data.timerBool=this.data.refreshCycle~=0 and this.data.refreshCycle<4
        if this.data.refreshCycle==3 then
            tarTimeStamp = dataShop.monthlyExpiredTime
        elseif this.data.refreshCycle==2 then
            tarTimeStamp = dataShop.weeklyExpiredTime
        elseif this.data.refreshCycle==1 then
            tarTimeStamp = dataShop.dailyExpiredTime
        else
            
            return;
        end
    end
    this.data.shopFrushRemainTime= tarTimeStamp - LuaMgr.Timestamp();
    if this.data.shopFrushRemainTime<0 then
        this.vm.data.timer=string.format(LuaMgr.GetLangText("MarketViewModel_5"),0,0,0);
    else
        local day=math.floor(this.data.shopFrushRemainTime/(24*60*60));
        local hour=math.floor((this.data.shopFrushRemainTime%(24*60*60))/(60*60));
        local min=math.floor((this.data.shopFrushRemainTime%(24*60*60))%(60*60)/60);
        this.vm.data.timer=string.format(LuaMgr.GetLangText("MarketViewModel_6"),day,hour,min);
    end
end


this.TypeBarOnValueChanged=function(value)
    if this.data.subPos~=nil then
        this.vm.data.subTfPos=this.data.subPos+Vector2(0,this.data.type_scrollView.content.anchoredPosition.y)
    end
end




this.GetPlayerWhetherHave = function(type,id)
    if TableIsNull(type) then
        local avatarId = ""
        for i = 1, #ConfigMgr.Config.avatarFrames do
            if ConfigMgr.Config.avatarFrames[i].unlock == id then
                avatarId = ConfigMgr.Config.avatarFrames[i].id
                break
            end
        end
        if IsNullOrEmpty(avatarId) then return false end
        return DataMgr.Player.avatarFrameMap[avatarId] ~= nil
    end

    if type[1] == "3" then
        local skinData = HeroRedDataHelper.GetSkinByItemID(id)
        if not TableIsNull(skinData) then
            return HeroRedDataHelper.CheckSkinIDById(skinData.characterId,skinData.skinID)
        end
    end
end

this.CheckGoodsIsOwned = function(goodsData)
    local isOwned = false
    local isFind = goodsData.IsFind
    if not TableIsNull(isFind) then
        if isFind[1] == "1" then
            local data = DataMgr.Player.characters[isFind[2]]
            isOwned = data ~= nil
        elseif isFind[1] == "2" then
            isOwned = HeroMgr.GetCharacterZZWithBadge(isFind[2]) >= 6
        end
    end
    return isOwned
end

return vm({
    data = data,
    command = command,
    hook = hook
})