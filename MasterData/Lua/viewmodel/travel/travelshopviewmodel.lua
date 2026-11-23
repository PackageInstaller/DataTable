




local this = {vm=nil};
local cfgShop={};
local dataQuests={};
local spineCharacter=nil;
local travelExchangeArray={};
local data = {
  shopList={
      {
          
      }
  },
  contentAnchor=Vector2(0,0);
  scrollRectSizeData=Vector2(0,0);
  bodyPath="";
  
  isCollecting=false,
  isCollectDone=false;
  isCollected=false;
  collectPro="";
  collectValue=0.0;
  chName="";
  chJob=DefaultSprite,
}

local command = {

    buyBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if not DataExHelper.Check_TravelRunning() then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("TravelShopViewModel_6"));
                return;
            end
            local index=tonumber(param+1);
            local rewardId=this.vm.data.shopList[index].quesId;
            local item=this.vm.data.shopList[index].goods;
            local maxCount=this.vm.data.shopList[index].maxBuyCount;
            local cost=this.vm.data.shopList[index].cost;

            local myCount=DataHelper.GetItemCountById(cost[1].id)
            if myCount<cost[1].count then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("TravelShopViewModel_7"));
                return;
            end
            LuaMgr.ShowLuaPanel(UIName.ActivityBuyTipViewModel,item,cost,maxCount,function(count)
                DataExHelper.EX_ShopConvert(rewardId,count,function()
                    this.ParseData();
                end)
            end)
        end
    },
    collectBtn= {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            ApiMgr.Request("travel/exchangeChar",{},true,function(result)
                local re=json.decode(result);
                local data=json.encode(re.result.Rewards);
                LuaMgr.ShowItemRewared(data);
                this.ParseData();
            end,nil,true);
        end
    },
    chJumpBtn={
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowPanel("Laigu.ViewModel.TakeCard.HeroAttrPreviewViewModel",travelExchangeArray[3]);
        end
    }

}
local hook = {
    before_awake = function(vm)
        this.vm=vm;
        spineCharacter =vm.behaviour.transform:Find("root/Middle/Character/Body"):GetComponent("UISpineCharacter");
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            cfgShop=DataExHelper.Check_ConfigQuestEventByText("Travelshop");
            table.sort(cfgShop,function(a, b) return a.id<b.id end);
            travelExchangeArray=ConfigMgr.Config.constants.TravelCurrencyExchangeChar;
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        if spineCharacter~=nil then
            spineCharacter:Clear();
        end
    end,
}

this.SetCharacter=function()
    local characterId="D0045";
    local skinId = characterId.."003";
    local path = HeroManager.SetCharacterDrawing( spineCharacter, characterId,skinId);
    if path ~= "" then
        this.vm.data.bodyPath=path;
    end

    local item=ConfigMgr.Config.itemMap[travelExchangeArray[3]]
    this.vm.data.chName=LuaMgr.GetLangText(item.nameLan);

end


this.ParseData=function()
    this.SetCharacter();
    this.SetCollectInfo();
    local scrWidth=LuaMgr.GetScreenWidth()-500;
    scrWidth=scrWidth>900 and 900 or scrWidth;
    this.vm.data.scrollRectSizeData=Vector2(scrWidth,620)
    this.vm.data.contentAnchor=Vector2(0,0);
    dataQuests=DataMgr.Player.quests;
    this.vm.data.shopList={};
    local list={};
    for i,v in ipairs(cfgShop) do
        if dataQuests[v.id]~=nil  then
            local dataQuest=dataQuests[v.id];
            local item=ConfigHelper.CreateGoodsItem(v.reward[1].id,v.reward[1].count,0.7,true,true);
            
            item.quesId=v.id;
            item.isSellOut=dataQuest.state==3;
            local limitNum=v.progress-dataQuest.progress
            item.limitNum=limitNum>0 and tostring(limitNum) or string.format("<color=#890000>%s</color>",limitNum);
            local cost=v.cost[1];
            item.costIcon=LuaMgr.GetTexture(ConfigHelper.GetItemIconPath(cost.id));
            local myCount=DataHelper.GetItemCountById(cost.id)
            if cost.count>0 then
                item.isRed=false;
                item.costNum=myCount>=cost.count and tostring(cost.count) or string.format("<color=#890000>%s</color>",cost.count);
            else
                item.costNum=LuaMgr.GetLangText("TravelShopViewModel_8");
                item.isRed=dataQuest.state~=3;
            end
            
            item.goods=v.reward[1];
            local canBuyCount=math.floor(myCount/cost.count);
            local maxBuyCount=v.progress-dataQuest.progress;
            item.maxBuyCount=canBuyCount>maxBuyCount and maxBuyCount or canBuyCount;
            item.cost=v.cost;
            table.insert(list,item);
        end
    end
    table.sort(list,function(a, b)
        if not a.isSellOut and not b.isSellOut then
            if not a.isRed and not b.isRed then
                return a.quesId<b.quesId
            else
                return a.isRed and not b.isRed;
            end
        elseif a.isSellOut and b.isSellOut then
            return a.quesId<b.quesId
        else
            return not a.isSellOut and b.isSellOut;
        end
    end)





    this.vm.data.shopList=list;
    list=nil;
end


this.SetCollectInfo=function()
    if IsNull(travelExchangeArray) or travelExchangeArray==nil then
        return;
    end
    local dataItemsAccumulate=DataMgr.Player.itemsAccumulate;
    local dataTravel=DataMgr.Player.travel;
    local itemId=travelExchangeArray[1];
    local maxCount=travelExchangeArray[2];
    
    this.vm.data.isCollected=dataTravel.HadExchanged;
    this.vm.data.isCollecting=not dataTravel.HadExchanged;

    if not dataTravel.adExchanged then
        local proCount=dataItemsAccumulate[itemId];
        proCount=proCount==nil and 0 or proCount;
        this.vm.data.isCollectDone=proCount>=tonumber(maxCount);
        this.vm.data.collectValue=math.floor(proCount/tonumber(maxCount));
        this.vm.data.collectPro=string.format("<color=#32716f>%s</color>/%s",LuaMgr.NumFormat(proCount),LuaMgr.NumFormat(tonumber(maxCount)));
    end
    
end

return vm({
    data = data,
    command = command,
    hook = hook
})