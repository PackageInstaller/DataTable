





local this = { vm = nil,
               characterId1 = "D0045",
               characterId2 = "A0086",
               cfgCharacters = {},
               cfgmoreModShop = {},
               cfgShop = {},
               dataShop = {},
               curCharacterId=nil,
               curShop = nil,
               isFrushing = false,
               path = "Assets/_BundleResources/Character/",
};

local shopCharacters=nil;


local data = {
  shopList={
      {
          name="",
          remainCount="",
          priceIcon=DefaultTexture,
          price="",
          tag_isLimit=false,
          isSellOut=false,
          isGetAll=false,
          bgSprite=DefaultSprite,
          sellOutSprite=DefaultSprite,
          fullOutSprite=DefaultSprite,
      }
  },
  itemList={
      {
          phaseName="",
          phasePrice="",
          isPass=false,
          isCur=false,
          islock=false,
      }  
  },
  
  ch1Name="",
  ch1Job=DefaultSprite,
  ch1Bg=DefaultTexture,
  ch2Name="",
  ch2Job=DefaultSprite,
  ch2Bg=DefaultTexture,
  
  ch1Scale=Vector3(1,1,1);
  ch1Pos=Vector2(0,0);
  ch1NamePos=Vector2(0,0);
  ch2Scale=Vector3(1,1,1);
  ch2Pos=Vector2(0,0);
  ch2NamePos=Vector2(0,0);
  
  contentAnchorPos=Vector2(0,0);
  popPanelBool=false;
  
  goodsName="",
  goodsDes="",
  goodsRare=DefaultSprite,
  goodsIcon=DefaultTexture,
  goodsPriceIcon=DefaultTexture,
  goodsPrice="",
  
  timer="",
  animaName="",
  bgTexture=DefaultTexture;
  maskSprite=DefaultSprite,
  titleSprite=DefaultSprite,
  nameSprite=DefaultSprite,
}

local command = {

    closeBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
          this.vm.data.popPanelBool=false;
        end
    },
    buyBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param+1);
            local shopItem=this.vm.data.shopList[index];
            local isLimit=shopItem.tag_isLimit;
            local maxCount=tonumber(shopItem.remainCount);
            local cost=shopItem.cost;
            local item=shopItem.goods;
            
            if isLimit then

                this.ShowPopPanelInfo(shopItem.Id);
            else

                this.curShop=nil;
                this.curShop=this.cfgmoreModShop[shopItem.Id];
                LuaMgr.ShowLuaPanel(UIName.ActivityBuyTipViewModel,item,cost,maxCount,function(count)
                    this.OnAskBuyShop(count);
                end)
            end
        end
    },
    checkDetailsBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)

            if this.curCharacterId~=nil then
                LuaMgr.ShowPanel("Laigu.ViewModel.TakeCard.HeroAttrPreviewViewModel",this.curCharacterId);
            end
        end
    },
    buyAgainBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
          this.OnAskBuyShop(1);
        end
    },
    chara1Btn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.ShowPanel("Laigu.ViewModel.TakeCard.HeroAttrPreviewViewModel",this.characterId1);
        end
    },
    chara2Btn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.ShowPanel("Laigu.ViewModel.TakeCard.HeroAttrPreviewViewModel",this.characterId2);
        end
    },
    
}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params== nil) then return  end

        this.vm.data.animaName="ui_AreaSqualShopPanel_root";
        
        LuaMgr.AddUIEventListener(UIEventConst.HeartAcrossDay,this.HeartAcrossDay);
        this.cfgCharacters=ConfigMgr.Config.characterTable;
        this.cfgmoreModShop=ConfigMgr.Config.moreModShopMap;
        this.vm.data.popPanelBool=false;
        this.vm.data.contentAnchorPos=Vector2(0,0);
        this.cfgShop={}
        for i,v in pairs(this.cfgmoreModShop) do
            table.insert(this.cfgShop,v);
        end



        
        this.ParseData();
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params== nil) then return  end
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartAcrossDay,this.HeartAcrossDay)
        LuaMgr.RemoveTimer(TimerConst.MoreModExprie)
    end,
    before_destroy=function(vm)
        this=nil
    end
}

this.HeartAcrossDay=function()
    this.ParseData();
end

this.OnAskBuyShop=function(count)
    if this.isFrushing then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("AreaSqualShopViewModel_0"))
        return;
    end
    if this.curShop==nil then return end;
    local askData={GoodId=tostring(this.curShop.Id),Count=count}
    local myCount=DataHelper.GetItemCountById(this.curShop.Currency)
    local hasBuyCount=this.dataShop.buyinfo[tostring(this.curShop.Id)]==nil and 0 or this.dataShop.buyinfo[tostring(this.curShop.Id)];
    local costCount=this.curShop.Price[1]
    if this.curShop.Price[hasBuyCount+1]~=nil then
        costCount=this.curShop.Price[hasBuyCount+1];
    end
    if myCount<costCount then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(ConfigMgr.LangGlobal("1601"),ConfigHelper.ItemName(this.curShop.Currency)));
        return
    end
    ApiMgr.Request("moremod/buygood",askData,true,function(result)
        local re=json.decode(result);
        local data=json.encode(re.result);
        LuaMgr.ShowItemRewared(data);
        this.ParseData();
        this.vm.data.popPanelBool=false;
    end,nil,true)
end


this.ParseData=function()
    this.dataShop=DataMgr.Player.moreModShop;
    this.isFrushing=false;
    shopCharacters=nil;
    local wheelName="shopA"
    if ConfigMgr.Config.moreModConstants.NowShop==wheelName then
        shopCharacters=ConfigMgr.Config.moreModConstants.ShopAcharacter
    else
        wheelName="shopB"
        shopCharacters=ConfigMgr.Config.moreModConstants.ShopBcharacter
    end
    this.characterId1=shopCharacters[1][1];
    this.characterId2=shopCharacters[1][2];
    this.SetCharacterInfo();
    this.SetInfosByTheme(wheelName)
    this.SetGoods(wheelName);
    this.SetTimer()
end


this.SetInfosByTheme=function(theme)
    this.vm.data.bgTexture= LuaMgr.GetTexture(Path.Image..string.format("Squal/ui_dzr_sx_bj_%s.png",theme));
    this.vm.data.titleSprite=LuaMgr.GetSprite("Squad","ui_dzr_sx_bt_"..theme)
    this.vm.data.maskSprite=LuaMgr.GetSprite("Squad","ui_dzr_sx_bj_yx_"..theme);
    this.vm.data.nameSprite=LuaMgr.GetSprite("Squad","ui_dzr_sx_mcd_"..theme);
end

this.SetTimer=function()
    local moreRemainTime=this.dataShop.nextrefreshtime-LuaMgr.Timestamp();
    if moreRemainTime<=0 then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("AreaSqualShopViewModel_1"))
        return;
    end
    LuaMgr.RemoveTimer(TimerConst.MoreModExprie)
    LuaMgr.AddTimer(TimerConst.MoreModExprie,function()
        local day=math.floor(moreRemainTime/86400);
        local hour=math.fmod(math.floor(moreRemainTime/3600),24);
        local minute=math.fmod(math.floor(moreRemainTime/60), 60);
        this.vm.data.timer=string.format(LuaMgr.GetLangText("AreaSqualShopViewModel_2"),day,hour,minute);
        moreRemainTime=moreRemainTime-1;
        if moreRemainTime<0 then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("AreaSqualShopViewModel_3"))
            this.isFrushing=true;
            LuaMgr.RemoveTimer(TimerConst.MoreModExprie)
            return;
        end
    end,1,-1,true);
end


this.SetCharacterInfo=function()
    local ch1=this.cfgCharacters[this.characterId1];
    local ch2=this.cfgCharacters[this.characterId2];
    local ch1Path=this.path..string.format("%s/Drawing/%s001.png",this.characterId1,this.characterId1);
    local ch2Path=this.path..string.format("%s/Drawing/%s002.png",this.characterId2,this.characterId2);
    this.vm.data.ch1Bg=LuaMgr.GetTexture(ch1Path);
    this.vm.data.ch2Bg=LuaMgr.GetTexture(ch2Path);
    
    this.vm.data.ch1Name=LuaMgr.GetLangText(ch1.namelan);
    this.vm.data.ch1Job=LuaMgr.GetSprite("JobIcon","job2_"..ch1.job);
    this.vm.data.ch2Name=LuaMgr.GetLangText(ch2.namelan);
    this.vm.data.ch2Job=LuaMgr.GetSprite("JobIcon","job2_"..ch2.job);
    local posStr1=shopCharacters[2][1];
    local posNameStr1=shopCharacters[4][1]
    local pos1=NumTool.split(posStr1,"_")
    local posName1=NumTool.split(posNameStr1,"_")
    this.vm.data.ch1Pos=Vector2(tonumber(pos1[1]),tonumber(pos1[2]));
    this.vm.data.ch1NamePos=Vector2(tonumber(posName1[1]),tonumber(posName1[2]));
    this.vm.data.ch1Scale=Vector3.one*tonumber(shopCharacters[3][1])

    local posStr2=shopCharacters[2][2];
    local posNameStr2=shopCharacters[4][2]
    local pos2=NumTool.split(posStr2,"_")
    local posName2=NumTool.split(posNameStr2,"_")
    this.vm.data.ch2Pos=Vector2(tonumber(pos2[1]),tonumber(pos2[2]));
    this.vm.data.ch2NamePos=Vector2(tonumber(posName2[1]),tonumber(posName2[2]));
    this.vm.data.ch2Scale=Vector3.one*tonumber(shopCharacters[3][2])
end

this.SetGoods=function(theme)
    this.curCharacterId=nil;
    this.vm.data.shopList={};
    local list={}
    local hasBuyCouont=nil;
    for i,v in ipairs(this.cfgShop) do
        hasBuyCouont=this.dataShop.buyinfo[tostring(v.Id)]==nil and 0 or this.dataShop.buyinfo[tostring(v.Id)];
        local shopItem=ConfigHelper.CreateGoodsItem(v.Goods[1].id,v.Goods[1].count,0.7,true,true);
        shopItem.name=LuaMgr.GetLangText(v.GoodsNameLan);
        shopItem.remainCount=tostring(v.RefreshCount-hasBuyCouont);
        shopItem.priceIcon=LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath(v.Currency));
        if v.Type==1 then
            local priceIndex=hasBuyCouont>=#v.Price and #v.Price or hasBuyCouont+1;
            shopItem.price=tostring(v.Price[priceIndex]);
        else
            shopItem.price=tostring(v.Price[1]);
        end
        shopItem.tag_isLimit=v.Refresh==0;
        shopItem.isSellOut=v.Type==2 and hasBuyCouont>=v.RefreshCount;
        shopItem.isGetAll=v.Type==1 and hasBuyCouont>=v.RefreshCount;
        shopItem.Id=tostring(v.Id);
        shopItem.Rank=v.Rank;
        shopItem.sortNum=(shopItem.isSellOut or shopItem.isGetAll) and 2 or 1;
        shopItem.cost={{id=v.Currency,count=v.Price[1]}}
        shopItem.goods=v.Goods[1];
        shopItem.bgSprite=LuaMgr.GetSprite("Squad","ui_dzr_sx_gmd_"..theme);
        shopItem.sellOutSprite=LuaMgr.GetSprite("Squad","ui_dzr_sx_sqd_"..theme);
        shopItem.fullOutSprite=LuaMgr.GetSprite("Squad","ui_dzr_sx_qbyyd_"..theme);
        table.insert(list,shopItem);
    end
    DataReportMgr.OpenShopView("MoreModShop","","MoreModShop",this.cfgShop,4,false)
    DataReportMgr.OpenShopShowView("MoreModShop","","MoreModShop",this.cfgShop,4,false)
    table.sort(list,function(a, b)
        if a.sortNum==b.sortNum then
            return a.Rank<b.Rank;
        else
            return a.sortNum<b.sortNum;
        end
    end)
    this.vm.data.shopList=list;
end

this.ShowPopPanelInfo=function(id)
    this.vm.data.popPanelBool=true;
    this.vm.data.animaName="ui_AreaSqualShopPanel_popPanel";
    this.curShop=nil;
    this.curShop=this.cfgmoreModShop[id];
    local hasBuyCouont=this.dataShop.buyinfo[id]==nil and 0 or this.dataShop.buyinfo[id];
    this.vm.data.goodsName=LuaMgr.GetLangText(this.curShop.GoodsNameLan);
    local cfgItem=ConfigMgr.Config.itemMap[this.curShop.Goods[1].id];
    this.vm.data.goodsDes=LuaMgr.GetLangText(cfgItem.DescriptionLan);
    this.vm.data.goodsRare=LuaMgr.GetSprite("Squad","ui_dzr_sx_tc_z"..cfgItem.rare);
    this.vm.data.goodsIcon=LuaMgr.GetTexture(ConfigHelper.GetItemIconPath(cfgItem.id));
    this.vm.data.goodsPriceIcon=LuaMgr.GetTexture(ConfigHelper.GetItemIconPath(this.curShop.Currency));
    local priceIndex=hasBuyCouont>=#this.curShop.Price and #this.urShop.Price or hasBuyCouont+1;
    this.vm.data.goodsPrice=tostring(this.curShop.Price[priceIndex]);

    for key,v in pairs(this.cfgCharacters) do
        if v.mapItem==this.curShop.Goods[1].id or v.crystalItemId==this.curShop.Goods[1].id  then
            this.curCharacterId=key;
            break;
        end
    end
    this.ShowItems(this.curShop);
    
end


this.ShowItems=function(shop)
    this.vm.data.itemList={};
    local hasBuyCouont=this.dataShop.buyinfo[tostring(shop.Id)]==nil and 0 or this.dataShop.buyinfo[tostring(shop.Id)];
    local list={};
    for i,v in ipairs(shop.Price) do
        local item= {
            isPass = hasBuyCouont>=i,
            isCur = hasBuyCouont+1==i,
            islock = hasBuyCouont+1<i,
        }
        local lanID=tostring(2500+(i-1));
        local tips=LuaMgr.GetLangText(ConfigMgr.Config.langGlobal[lanID].NameLan);
        if item.isPass then
            item.phaseName=string.format("<color=#888888>%s</color>",tips);
            item.phasePrice=string.format("<color=#888888>%s</color>",tostring(v));
        elseif item.isCur then
            item.phaseName=string.format("<color=#32716f>%s</color>",tips);
            item.phasePrice=string.format("<color=#32716f>%s</color>",tostring(v));
        elseif item.islock then
            item.phaseName=string.format("<color=#98886d>%s</color>",tips);
            item.phasePrice=string.format("<color=#98886d>%s</color>",tostring(v));
        end
        table.insert(list,item);
    end
    this.vm.data.itemList=list;
end


return vm({
    data = data,
    command = command,
    hook = hook
})