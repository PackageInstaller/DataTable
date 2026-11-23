





local this = {vm=nil};
local cityName={laigu="ui_tcd1_zp_dd_lg",zhengzhou="ui_tcd1_zp_dd_bd",shanghai="ui_tcd1_zp_dd_sh"}
local areaKey=nil;
local cfgShop=nil;
local dataShop=nil;
local curShelf=nil;

local data = {
   
    chaperList={ {
                     angle = Vector3(0, 0, 0);
                     sprite = DefaultSprite,
                     text = "",
                     numSprite = DefaultSprite,
                     unselect = false,
                     select = false,
                     sellOut=false,
                 } 
    },
    goodsList={{   
                   goods=nil;
                   bg=DefaultSprite,
                   rareSprite=DefaultSprite,
                   goodTexture=DefaultTexture,
                   goodCount="",
                   goodName="",
                   remainCount="",
                   spriceTexture=DefaultTexture,
                   price="",
                   lockBool=false,
                   sellOutBool=false,
                   limitType="",
                   lightBool=false,
                   alpha=0.0,
                   refreshCycle=nil;
               }
    },
    
    citySprite=DefaultSprite;
    lineBool=false;
    scrollSizeData=Vector2(0,0);
    
    
}

local command = {
    chapterBarBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
           local index=tonumber(param)+1;
            this.SwitchLeftBar(index);
        end
    },
    buyGoodsBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
           local index=tonumber(param)+1;
            local goods=this.vm.data.goodsList[index].goods
            local limitType=this.vm.data.goodsList[index].refreshCycle;
            LuaMgr.ShowLuaPanel(UIName.BuyTipViewModel,goods,limitType,function()
                this.ParseData(curShelf);
            end)
        end
    },
    
}
local hook = {
    before_awake = function(vm)
        this.vm=vm;
        print("before_awake");
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params == nil) then return end
        areaKey="Area_";
        if vm.behaviour.Params.Length>0 then
            local area=tostring(vm.behaviour.Params[0]);
            if area~="nil" then
                vm.behaviour:UpdateTopBar(area,this.Back);
                areaKey=areaKey..area;
                this.vm.data.citySprite=LuaMgr.GetSprite("AreaShop",cityName[area]);
                
            end
        end
        this.ParseData();
    end,
   
    before_deactive = function(vm)
        print("before_deactive");
    end,
}

this.OnBack=function()
    LuaMgr.Back();
end



this.GetCanBuyShelfs=function()
    for i,v in ipairs(cfgShop.shelfs) do
        if dataShop.lockStatus[v.Id]==nil then
            if not this.ShelfsIsSellOut(v) then
                return i;
            end
        end
    end
    return 1;
    
end



this.ShelfsIsSellOut=function(shelfts)
    local sellOut=true;
    for o,p in ipairs(shelfts.goods) do
        local remainCount=p.RefreshCount;
        if remainCount==0 then
            sellOut=false;
            break;
        else
            local hasBuyCount=DataHelper.GetShopRecordByGoodsId(p.Id);
            remainCount=remainCount-hasBuyCount;
            sellOut=sellOut and remainCount<=0;
        end
    end
    return sellOut;
end


this.ParseData=function(no)
   cfgShop=ConfigMgr.Config.shop[areaKey];
    dataShop=DataMgr.Player.shop;
    this.vm.data.scrollSizeData=Vector2(LuaMgr.GetScreenWidth()-LuaMgr.ScreenOffSet()-150,720);
    if no==nil then
        no=this.GetCanBuyShelfs();
    end
    this.SetLeftBar(no);
    
end

this.SwitchLeftBar=function(no)
    this.SetLeftBar(no);
end


this.SetLeftBar=function(no)
    this.vm.data.chaperList={};
    local list={};
    for i,v in ipairs(cfgShop.shelfs) do
        local unLock=dataShop.lockStatus[v.Id]==nil;
        local chaperItem={
            angle=i%2~=0 and Vector3(0,0,2) or Vector3(0,0,-2);
            sprite=i==no and LuaMgr.GetSprite("AreaShop","ui_tcd1_bqwz"..i) or LuaMgr.GetSprite("AreaShop","ui_tcd1_bqwz"..i.."_2");
            numSprite=LuaMgr.GetSprite("AreaShop","ui_tcd1_bqsz"..i);
            select=i==no;
            unselect=i~=no;
            text=unLock and LuaMgr.GetLangText("AreaShopViewModel_7") or LuaMgr.GetLangText("AreaShopViewModel_8");
            sellOut=this.ShelfsIsSellOut(v);
        }
        table.insert(list,chaperItem);
    end
    this.vm.data.chaperList=list;
    this.SetGoods(no);
end


this.SetGoods=function(no)
    curShelf=no;
    local selflock=dataShop.lockStatus[cfgShop.shelfs[no].Id]~=nil;
    this.vm.data.lineBool=selflock;
    this.vm.data.goodsList={};
    local list={};
    for i,v in ipairs(cfgShop.shelfs[no].goods) do
        local item=ConfigHelper.GetItemById(v.Item)
        local remainCount=v.RefreshCount;
        local sellOut=false;
        if remainCount<=0 then
            remainCount=LuaMgr.GetLangText("AreaShopViewModel_5");
        else
            local hasBuyCount=DataHelper.GetShopRecordByGoodsId(v.Id);
            remainCount=remainCount-hasBuyCount;
            sellOut=remainCount<=0;
            remainCount=LuaMgr.GetLangText("AreaShopViewModel_6")..remainCount;
        end
        local isSelling=not selflock and not sellOut;
        local selfPrice=DataHelper.GetItemCountById(v.Currency)
        local goodItem={
            goods=v;
            refreshCycle=cfgShop.shelfs[no].RefreshCycle;
            rareSprite=LuaMgr.GetSprite("ItemRare","itemRare"..item.rare);
            goodTexture=LuaMgr.GetTexture(ConfigHelper.GetItemIconPath(v.Item)),
            goodCount="X"..v.Stack,
            goodName=LuaMgr.GetLangText(item.nameLan),
            remainCount=remainCount,
            spriceTexture=LuaMgr.GetTexture(ConfigHelper.GetItemIconPath(v.Currency)),
            price=selfPrice>=v.Price and string.format("<color=#f1eded>%s</color>",v.Price) or
                    string.format("<color=#f11212>%s</color>",v.Price),
            lockBool=selflock,
            sellOutBool=sellOut,
            lightBool=isSelling;
            bg= isSelling and LuaMgr.GetSprite("AreaShop","ui_tcd1_dj_di0") or LuaMgr.GetSprite("AreaShop","ui_tcd1_dj_di");
            alpha=0.0,
        }
        table.insert(list,goodItem);
        
    end
    table.sort(list,function(a, b) return not a.sellOutBool and b.sellOutBool end)
    this.vm.data.goodsList=list;
    list=nil;
    this.ShowAnimation();
end

this.ShowAnimation=function()
    for i,v in ipairs(this.vm.data.goodsList) do
        DOTWeen.To(function() return v.alpha  end,
                function(value) v.alpha=value  end,
                1,0.5+0.3*i);
    end
end


return vm({
    data = data,
    command = command,
    hook = hook
})