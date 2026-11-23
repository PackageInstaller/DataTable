





local this = {vm=nil};

local animator=nil;
local anima_CLOSE="ani_ui_BuyTipPanel_02"
local anima_OPEN="ani_ui_BuyTipPanel_01"
local buyNum=1;
local buyScucessHandler=nil;
local maxCount=nil;
local stopClick=false;
local goods=nil;
local costList=nil;
local isCanBuy=true;

local data = {
    goodsName="";
    goodsCount="";
    goodsDes="";
    goodsRare=DefaultSprite;
    goodsIcon=DefaultTexture;
    goodsStack="";
    priceIcon=DefaultTexture;
    price="";
    limitBuy="";
    buyCount="";
    limitBool=false;
    limitCount="";
    contentAnchorPos=Vector2(0,0);
    desContentSizeFilter=false;
    
    costList={{
        icon=DefaultTexture,
        count="", }
    };
    
    

    buyTipAnchorPos=Vector2(0,0);
    buyBgSizeData=Vector2(0,0);
    dropDown=false;
}

local command = {
    minBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            buyNum=1;
            this.RefreshPrice();
        end
    },
    maxBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            buyNum=this.GetMaxBuyNum();
            buyNum=buyNum>0 and buyNum or 1;
            this.RefreshPrice();
        end
    },
    addBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if buyNum<this.GetMaxBuyNum() then
                buyNum=buyNum+1;
                this.RefreshPrice();
            end

        end
    },
    subtractBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if buyNum>1 then
                buyNum=buyNum-1;
                this.RefreshPrice();
            end

        end
    },
    buyBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
           this.OnClick_Buy();
        end
    },
    buyInput = {
        type = XLuaCommandType.String,
        execute = function(vm,value,param)
           local num=0;
            if value=="" or value=="-" then
                num=1
            else
                num=tonumber(value);
                local maxNum=this.GetMaxBuyNum();
                if num>maxNum then
                    num=maxNum;
                elseif num<1 then
                    num=1;
                end
            end
            buyNum=num;
            this.RefreshPrice();
        end
    },
    closeBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.DelayHidePanel();
        end
    },
    
}
local hook = {
    before_awake = function(vm)
        this.vm=vm;
        print("before_awake");
        animator=vm.behaviour.transform:Find("root"):GetComponent("Animator")
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params == nil) then return end
        this.vm.data.contentAnchorPos=Vector2(0,0);
        goods=vm.behaviour.Params[0];
        costList=vm.behaviour.Params[1];
        maxCount=vm.behaviour.Params[2];
        maxCount=maxCount<1 and 1 or maxCount;
        buyScucessHandler=vm.behaviour.Params[3];
        
        this.ParseData();
        this.vm.data.desContentSizeFilter=false;
        LuaMgr.NextFrame(function()
            this.vm.data.desContentSizeFilter=true;
        end)
    end,
    before_deactive = function(vm)
        print("before_deactive");
        costList=nil;
        goods=nil;
        maxCount=nil;
        costList=nil;
        buyScucessHandler=nil;
    end,
}

this.AdjustScreen=function(isDropDown)
    this.vm.data.dropDown=isDropDown;
    if isDropDown then
        this.vm.data.buyTipAnchorPos=Vector2(0,0);
        this.vm.data.buyBgSizeData=Vector2(530,528);
    else
        this.vm.data.buyTipAnchorPos=Vector2(0,-90);
        this.vm.data.buyBgSizeData=Vector2(538,340);
    end
end

this.ParseData=function()
   stopClick=false;
    isCanBuy=true;
    buyNum=1;
    this.AdjustScreen(false);
    local item=ConfigHelper.GetItemById(goods.id)
    this.vm.data.goodsName=LuaMgr.GetLangText(item.nameLan);
    local goodsNum=DataHelper.GetItemCountById(goods.id);
    this.vm.data.goodsCount=LuaMgr.NumFormat(goodsNum);
    this.vm.data.goodsDes=LuaMgr.GetLangText(item.DescriptionLan);
    this.vm.data.goodsStack="X"..goods.count;
    this.vm.data.goodsRare=LuaMgr.GetSprite("ItemRare","itemRare"..item.rare);
    this.vm.data.goodsIcon=LuaMgr.GetTexture(ConfigHelper.GetItemIconPath(goods.id))
    this.SetCostItem();
    this.RefreshPrice();
    
end

this.SetCostItem=function()
    this.vm.data.costList={}
    local list={}
    for i,v in ipairs(costList) do
        local costItem={
            icon=LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath(tostring(v.id))),
            count=tostring(v.count);
        }
        table.insert(list,costItem);
    end
    this.vm.data.costList=list;
end


this.RefreshPrice=function()
    for i,v in ipairs(this.vm.data.costList) do
        local count=costList[i].count*buyNum; 
        local myCount=DataHelper.GetItemCountById(costList[i].id);
        v.count=myCount<count and string.format("<color=#EE0A0A>%s</color>",count)
              or string.format("<color=#ffffff>%s</color>",count);
        isCanBuy=isCanBuy and myCount>=count;
    end
    this.vm.data.buyCount=buyNum;
end


this.GetMaxBuyNum=function()
    local myCount=maxCount;
    for i,v in ipairs(costList) do
        local count=math.floor(DataHelper.GetItemCountById(v.id)/v.count);
        myCount=count<myCount and count or myCount;
    end
    return myCount>1 and myCount or 1;
end

this.OnClick_Buy=function()
    if stopClick then return end;
    stopClick=true;
    if not isCanBuy then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("10204"))
        stopClick=false;
        return
    end
    
    if buyScucessHandler~=nil then
        buyScucessHandler(buyNum);
    end
    this.DelayHidePanel();










    
end


this.DelayHidePanel=function()
    animator:Play(anima_CLOSE);
    coroutine_runner.start(function()
        coroutine_runner.wait(0.5);
        LuaMgr.HidePanel(UIName.ActivityBuyTipViewModel)
    end)
end

return vm({
    data = data,
    command = command,
    hook = hook
})