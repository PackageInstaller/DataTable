




local this = {
    vm=nil,
    cfgShop={},
    dataQuests={},
    characterId="S0012",
    spineCharacter=nil,
    
};

local data = {
    shopList= {
        {
            id="",
            name = "",
            rare = DefaultSprite,
            icon = DefaultTexture,
            count = "",
            priceIcon = DefaultTexture,
            price = "",
            isSellOut=false,
            limitNum="",
            limitTextBool=true,
        }
    },
    contentAnchor=Vector2(0,0);
    bodyPath="";

    isCollecting=false,
    isCollect=false;
    isCollected=false;
    collectPro="";
    collectInfo="";
    collectValue=0.0;
    characterName="",
    characterJob=DefaultSprite,
}

local command = {

    buyBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if not DataExHelper.Check_ChanganRunning() then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("ChanganShopViewModel_0"));
                return;
            end
            local index=tonumber(param+1);
            local rewardId=this.vm.data.shopList[index].quesId;
            local item=this.vm.data.shopList[index].goods;
            local maxCount=this.vm.data.shopList[index].maxBuyCount;
            local cost=this.vm.data.shopList[index].cost;






            LuaMgr.ShowLuaPanel(UIName.ActivityBuyTipViewModel,item,cost,maxCount,function(count)
                DataExHelper.EX_ShopConvert(rewardId,count,function()
                    this.dataQuests=DataMgr.Player.quests;
                    this.SetShopGoods();
                end)
            end)
        end
    },
    collectBtn= {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local collectShop=ChanganMgr.changanShopCollect;
            if this.dataQuests[collectShop.id]==nil then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("10005"));
                return;
            end
            local rewardId=collectShop.id
            local item=collectShop.showReward[1];
            local maxCount=1;
            local cost=collectShop.cost;





            LuaMgr.ShowLuaPanel(UIName.ActivityBuyTipViewModel,item,cost,maxCount,function(count)
                DataExHelper.EX_ShopConvert(rewardId,count,function()
                    this.dataQuests=DataMgr.Player.quests;
                    this.SetCollectInfo();
                end)
            end)
        end
    },
    skinBtn={
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowPanel("Laigu.ViewModel.TakeCard.HeroAttrPreviewViewModel",this.characterId);
        end
    }


}
local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.spineCharacter =vm.behaviour.transform:Find("root/Middle/Character/Body"):GetComponent("UISpineCharacter");
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            ChanganMgr.InitData();
            this.cfgShop=ChanganMgr.changanShopQuestEventList;











            this.vm.data.contentAnchor=Vector2(0,0);
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        
    end,
    before_destroy=function(vm)
        if (vm.behaviour.Params == nil) then return end;
        if this.spineCharacter~=nil then
            this.spineCharacter:Clear();
        end
        this.Clear();
    end
}


this.Clear=function()
    this.cfgShop=nil
    this.dataQuests=nil
    this.characterId=nil
    this.spineCharacter=nil
end


this.SetCharacter=function()
    local skinId = this.characterId.."001";
    local path = HeroManager.SetCharacterDrawing(this.spineCharacter, this.characterId,skinId);
    if path ~= "" then
        this.vm.data.bodyPath=path;
    end
    local cfgCharacter=ConfigMgr.Config.characterTable[this.characterId];
    this.vm.data.characterName=LuaMgr.GetLangText(cfgCharacter.namelan);
    this.vm.data.characterJob=LuaMgr.GetSprite("JobIcon","job2_"..cfgCharacter.job);
end


this.ParseData=function()
    this.dataQuests=DataMgr.Player.quests;
    this.SetCollectInfo();
    this.SetShopGoods();
    this.SetCharacter();
end

this.SetShopGoods=function()
    local list={};
    for i,v in ipairs(this.cfgShop) do
        local item=ConfigHelper.GetItemById(v.showReward[1].id);
        if this.dataQuests[v.id]~=nil  then
            local shopItem={
                id=item.id;
                quesId=v.id,
                rare=LuaMgr.GetSprite("ItemRare","itemRare"..item.rare),
                icon=LuaMgr.GetTexture(ConfigHelper.GetItemIconPath(v.showReward[1].id)),
                count="x"..LuaMgr.NumFormat(v.showReward[1].count),
                isSellOut=this.dataQuests[v.id].state==3;
                priceIcon=LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath(v.cost[1].id)),
                price=LuaMgr.NumFormat(v.cost[1].count);
                limitNum=string.format("<color=#9a581e>%s</color>/%s",this.dataQuests[v.id].progress,v.progress);
                limitTextBool=true;
                goods=v.showReward[1],
                maxBuyCount=v.progress-this.dataQuests[v.id].progress,
                cost=v.cost,
                sortNum=v.sort;
            }
            if v.progress>99999 then
                shopItem.limitNum=LuaMgr.GetLangText("ChanganShopViewModel_3")
                shopItem.limitTextBool=false
            end

shopItem.name=LuaMgr.GetLangText(item.nameLan)
            table.insert(list,shopItem);
        end
    end
    table.sort(list,function(a, b)
        if not a.isSellOut and not b.isSellOut then
            return a.sortNum<b.sortNum
        else
            return not a.isSellOut and b.isSellOut;
        end

    end)
    this.vm.data.shopList=list;
    list=nil;
end


this.SetCollectInfo=function()
    local collectTask=ChanganMgr.changanShopCollectTask
    local collectShop=ChanganMgr.changanShopCollect;
    if collectTask==nil or collectShop==nil then
        return
    end
    local dataCollectPro=this.dataQuests[collectTask.id]
    local dataCollect=this.dataQuests[collectShop.id]
    if  dataCollectPro==nil then
        return;
    end
    this.vm.data.isCollected=dataCollect~=nil and dataCollect.state==3;
    this.vm.data.isCollecting=not this.vm.data.isCollected and dataCollectPro.state==3;
    this.vm.data.isCollect=dataCollect==nil or dataCollect.state~=3
    if this.vm.data.isCollect then
        this.vm.data.collectInfo=LuaMgr.GetLangText(collectTask.namelan);
        this.vm.data.collectValue=dataCollectPro.progress/collectTask.progress;
        this.vm.data.collectPro=string.format("<color=#c85435><size=26>%s</size></color>/%s",LuaMgr.NumFormat(dataCollectPro.progress),LuaMgr.NumFormat(collectTask.progress));
    end

end

return vm({
    data = data,
    command = command,
    hook = hook
})