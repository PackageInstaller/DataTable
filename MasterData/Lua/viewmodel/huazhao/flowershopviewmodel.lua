




local this = {vm=nil};
local cfgShopQuestEvent={};
local dataExQuests={};
local ScrollView_x=0;
local list={};
local data = {
    
    shopList= {{info="",taskPro = "0/0",count="",icon=DefaultTexture,isLimit=false,isNoLimit=false,changedBool=false, tarList={{}}}};

    contentAnchorPos=Vector2(0,0);


}

local command = {
    
    rewardBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if not DataExHelper.EX_CheckLocalRunning(ActivityKey.huazhao) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("10211"));
                return
            end
            local index=tonumber(param+1);
            local rewardId=this.vm.data.shopList[index].id;
            local item=this.vm.data.shopList[index].goods;
            local maxCount=this.vm.data.shopList[index].maxBuyCount;
            local cost=list[index].cost;
            LuaMgr.ShowLuaPanel(UIName.ActivityBuyTipViewModel,item,cost,maxCount,function(count)
                DataExHelper.EX_ShopConvert(rewardId,count,function()
                    this.ParseData();
                end)
            end)
            
        end
    }

}
local hook = {
    before_awake = function(vm)
        this.vm=vm;

        print("before_awake");
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then
            cfgShopQuestEvent=DataExHelper.Check_ConfigQuestEventByText("shop");
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
    end,
}


this.ParseData=function()
    dataExQuests=DataMgr.Player.quests;

    this.ShowShop();
end

this.AdjustScreen=function()
    local rate=LuaMgr.ScreenWidth()/LuaMgr.ScreenHeight();
    local baseRate=16/9;
    local tarWidth=1150;
    local baseWidth=920;
    local offWidth=(rate/baseRate-1)*(tarWidth-baseWidth);
    this.vm.data.ScrollViewSizeData=Vector2(920+offWidth*2.5,720);
end

this.ShowShop=function()
    this.vm.data.contentAnchorPos=Vector2.zero;
    this.vm.data.shopList={};
    list={}
    for i,v in ipairs(cfgShopQuestEvent) do
        local shop=v;
        local progrssing,state=this.CheckShopState(v);
        local subList={};
        local showReward=shop.showReward[1];
        local subItem =ConfigMgr.Config.itemMap[tostring(showReward.id)];
        local subRewardItem={
            id=tostring(showReward.id),count=tostring(showReward.count),isCount=true,
            rare=ActivityMgr.GetRareSprite(subItem.rare),
            icon=ActivityMgr.GetItemTexture(tostring(showReward.id)),
            scale=Vector3(0.8,0.8,0.8),
            sizeDelta=Vector2(84,84),
            isClick=true
        }
        table.insert(subList,subRewardItem);















        
        local name=LuaMgr.GetLangText(subItem.nameLan);

        local taskItem={
            taskPro="<color=#d86a8c>"..progrssing.."</color>".."<color=#262429>/"..shop.progress.."</color>",
            info=name;
            count=tostring(shop.cost[1].count);
            icon=LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath(shop.cost[1].id)),
            id=shop.id;
            sortNum=state;
            changedBool=state==4,
            tarList=subList,
            cost=shop.cost,
            goods=showReward;
            isLimit=shop.progress<=99999;
            isNoLimit=shop.progress>99999;
            maxBuyCount=shop.progress-progrssing;
        }
        
        table.insert(list,taskItem);
    end
    this.SortList(list);
    this.vm.data.shopList=list;
    DataReportMgr.OpenShopView("huazhaoShop","","huazhaoShop",cfgShopQuestEvent,5,false)
    DataReportMgr.OpenShopShowView("huazhaoShop","","huazhaoShop",cfgShopQuestEvent,5,false)
end

this.SortList=function(list)
    table.sort(list,function(a,b)
        return this.FunSort(a,b);
    end)
    for i,v in ipairs(list) do
        v.BGSize=i%2~=0 and Vector2(148,676) or Vector2(148,615);
    end
end

this.FunSort=function(a,b)
    if a.sortNum<b.sortNum then
        return true;
    end
    if a.sortNum==b.sortNum and tonumber(a.id)<tonumber(b.id) then
        return true
    end
end



this.CheckShopState=function(shop)
    local state=0;
    local progress=0;
    local dataTask= dataExQuests[shop.id];
    if dataTask==nil then
        state=3;
        progress=0;
    elseif dataTask.state==3 then
        state=4;
        progress=dataTask.progress;
    elseif dataTask.state==1 then
        local re= this.CheckExchange(shop);
        if re then
            state=1;
        else
            state=2;
        end
        progress=dataTask.progress;
    end
    return progress,state;
end

this.CheckExchange=function(shop)
    for i,v in ipairs(shop.cost) do
        local myCount=DataHelper.GetItemCountById(v.id)
        if myCount<v.count then
            return false;
        end
    end
    return true;
end


return vm({
    data = data,
    command = command,
    hook = hook
})