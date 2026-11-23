




require("ViewModel/Terminal/Review_ShopItem")
local this = {vm=nil, 
              shopUIList={},
              shopItemObj=nil;
              cfgShopList={}
};


local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Middle = nil;
local Left = nil;
local Right = nil;
local ScrollView = nil;
local tranContent = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Middle = uiLink:Get("Middle");
    Left = uiLink:Get("Left");
    Right = uiLink:Get("Right");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Middle = nil;
    Left = nil;
    Right = nil;
    ScrollView = nil;
    tranContent = nil;

end



local data={}

local command = {

}


local hook = {
    before_awake = function(vm)
        this.vm=vm;
        print("before_awake");
        this.Init(vm.behaviour)
        this.shopUIList=UIListView.New(tranContent);
        this.shopItemObj=vm.behaviour.transform:Find("template/shopItem").gameObject
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params == nil) then return end
        this.cfgShopList={}
        for i,v in pairs(ConfigMgr.Config.ActivityThemeShopMap) do
            table.insert(this.cfgShopList,v);
        end
        this.ParseData();
    end,
   
    before_deactive = function(vm)
        print("before_deactive");
        if (vm.behaviour.Params == nil) then return end
        this.shopUIList:Clear();
    end,
    
    before_destroy=function()
       UIListView.ClearItem("Review_ShopItem") 
        this.Clear();
    end
}


this.ParseData=function()
   this.SetShopList();
end

this.SetShopList=function()
    this.shopUIList:Clear();
    local list={}
    for i,v in ipairs(this.cfgShopList) do
        if this.CheckShopUnlock(v.Unlock) then
            local reCount=v.Num;
            if v.IfFind[1]=="1" then

                reCount =DataHelper.IsContainsSkin(v.IfFind[2],v.IfFind[3]) and 0 or v.Num;
            elseif v.IfFind[1]=="3" then

                local myCG=DataMgr.Player.collectCGMap[v.IfFind[3]];
                if myCG~=nil and (myCG.unlock or myCG.current>=myCG.target) then
                    reCount=0;
                end
            elseif v.IfFind[1]=="4" then

                if not IsNull(DataMgr.Player.avatarFrameMap) and DataMgr.Player.avatarFrameMap[v.IfFind[2]]~=nil then
                    reCount=0;
                end
            elseif v.IfFind[1]=="5" then

                if not IsNull(DataMgr.Player.avatarFrameMap) and DataMgr.Player.avatarFrameMap[v.IfFind[2]]~=nil then
                    reCount=0;
                end
            elseif v.IfFind[1]=="6" then

                if not IsNull(DataMgr.Player.items) and DataMgr.Player.items[v.IfFind[2]]~=nil then
                    reCount=0;
                end
            else
                reCount=reCount-this.GetShopBuyCount(v.ID);
            end
            reCount=reCount<0 and 0 or reCount;
            local shopItem={
                sort=v.Sort;
                index=i,
                item=v.ShowReward,
                cost=v.Cost,
                pro=reCount,
                isSellOut=reCount==0;
                callBack=this.ClickCallBack
            }
            local shopData=UIListData.GetData(this.shopItemObj,"Review_ShopItem",shopItem);
            table.insert(list,shopData);
        end
    end
    table.sort(list,function(a, b)
        if not a.data.isSellOut and not b.data.isSellOut then
            return a.data.sort<b.data.sort
        else
            return not a.data.isSellOut and b.data.isSellOut
        end
    end)
    this.shopUIList:SetData(list);
end

this.GetShopBuyCount=function(id)
    if IsNull(DataMgr.Player.activityReview) or IsNull(DataMgr.Player.activityReview.shop) then
        return 0
    end;
    if DataMgr.Player.activityReview.shop[tostring(id)]==nil then
        return 0;
    end
    return DataMgr.Player.activityReview.shop[tostring(id)];
end

this.CheckShopUnlock=function(id)
    if IsNullOrEmpty(id) then
        return true;
    end
    if IsNull(DataMgr.Player.activityReview) or IsNull(DataMgr.Player.activityReview.unlock) then
        return false
    end;
    if DataMgr.Player.activityReview.unlock[id]==nil then
        return false;
    end
    return DataMgr.Player.activityReview.unlock[id]>0;
end

this.ClickCallBack=function(index)
    local goodsItem=this.cfgShopList[index]
    local myCount=DataHelper.GetItemCountById(goodsItem.Cost[1].id);
    local buyCount=myCount;
    if goodsItem.Cost[1].count>0 then
         buyCount=math.floor(myCount/goodsItem.Cost[1].count);
    end
    local maxCount=goodsItem.Num-this.GetShopBuyCount(goodsItem.ID);
    maxCount=maxCount>buyCount and buyCount or maxCount;
    LuaMgr.ShowLuaPanel(UIName.ActivityBuyTipViewModel,goodsItem.ShowReward[1],goodsItem.Cost,maxCount,function(count)
        local askData={
            ID=goodsItem.ID,
            Total=count;
        }
        this.ShopConvert(askData);
    end)
end

this.ShopConvert=function(askData)
    ApiMgr.Request("activityreview/shop", askData, true, function(result)
        local re=json.decode(result);
        local data=json.encode(re.result);

        LuaMgr.ShowItemRewared(data);
        this.ParseData();
    end, nil, true);
end

return vm({
    data = data,
    command = command,
    hook = hook
})