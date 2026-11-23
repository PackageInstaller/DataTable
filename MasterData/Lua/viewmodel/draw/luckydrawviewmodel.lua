





require("ViewModel/Draw/LuckyDraw_LayoutGroup")
require("ViewModel/Draw/LuckyDraw_goodItem")


local this = {vm=nil,
              rewardUIList={},
              layoutItemObj=nil,
              goodItemObj=nil,
};

local cfgDrawMap=nil;
local cfgDrawActivityMap=nil;
local drawActivity=nil;
local constraintCount=6;
local groupId=1;
local dataDrawRewardProgress=nil;
local dataDrawRewardRecords=nil;
local buyCount=1;
local drawConsume=nil;
local drawStartId="1001";
local drawId=nil;
local drawTotalCount=nil;
local playDrawTotalCount=nil;
local myMaxDrawCount=nil;
local coroutineKey=nil;
local animaName="ani_ui_LuckyDrawPanel_001";
local askStop=nil;
local tranContent=nil;

local data = {

    drawList = { {layoutBool=true,layoutSizeData=Vector2(930,110),layoutColCount=6},
                 {layoutBool=true,layoutSizeData=Vector2(930,110),layoutColCount=6},
                 {layoutBool=true,layoutSizeData=Vector2(930,110),layoutColCount=6}
        
    };

    goodList1={{count="",seldOutBool=false,good={{}}}};
    goodList2={{count="",seldOutBool=false,good={{}}}};
    goodList3={{count="",seldOutBool=false,good={{}}}};
    
    buyBtnBool=true;
    unlockBtnBool=false;
    buyText="1";
    priceIcon=DefaultTexture;
    price="";
    endTime="";
    doorAnimaName="";
    askStop=false;
    btnBuyIsGray=false;
}

local command = {

    maxBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.UpdateDrawCount(playDrawTotalCount);
        end
    },
    minBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.UpdateDrawCount(1);
        end
    },
    addBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.UpdateDrawCount(1,1);
        end
    },
    lessenBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.UpdateDrawCount(1,-1);
        end
    },
    buyBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if askStop then return end;
            this.OnAskDrawReward();
        end
    },
    unlockBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,LuaMgr.GetLangText("LuckyDrawViewModel_0"),function()
                this.OnAskChangeDrawBox();
            end,nil);

        end
    },
    InputFild={
        type=XLuaCommandType.String,
        execute=function(vm,value)
            local num=tonumber(value);
            if num==nil then 
               num=1; 
            end
            this.UpdateDrawCount(num);
        end
    }
    
}
local hook = {
    before_awake = function(vm)
        this.vm=vm;
        tranContent=vm.behaviour.transform:Find("root/Left/ScrollView/Viewport/tranContent");
        this.rewardUIList=UIListView.New(tranContent);
        this.layoutItemObj=vm.behaviour.transform:Find("template/layoutItem").gameObject;
        this.goodItemObj=vm.behaviour.transform:Find("template/goodItem").gameObject;
        
        print("before_awake");
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then
            vm.behaviour:UpdateTopBar("", this.OnBack);
            cfgDrawActivityMap={};
            local activityMap=ConfigMgr.Config.DrawActivityMap;
            for i,v in pairs(activityMap) do
                if v.Group==tostring(groupId) then
                    cfgDrawActivityMap[i]=v;
                end
            end
            cfgDrawMap=ConfigMgr.Config.DrawMap;
            buyCount=1;
            askStop=false;
            this.OnAskOpenBox();
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        this.Clear();
    end,
    before_destroy=function()
        UIListView.ClearItem("LuckyDraw_LayoutGroup")
        UIListView.ClearItem("LuckyDraw_goodItem")
    end
}

this.OnBack=function()
    if not DataExHelper.Check_LuckDrawRunning() then
        LuaMgr.Back();
    else
        LuaMgr.Back("draw");
    end
end

this.Clear=function()
    cfgDrawActivityMap=nil;
    cfgDrawMap=nil;
end


this.OnAskDrawReward=function()
    if drawTotalCount==0 then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("10214"))
        return
    end
    askStop=true;
    local askData={Group=tostring(groupId),Count=buyCount};
    ApiMgr.Request("draw/drawReward", askData, true, function(result)
        local re=json.decode(result);
        local data=json.encode(re.result.Reward);
        this.ParseData();
        if coroutineKey~=nil then
            coroutine_runner.stop(coroutineKey);
        end
        coroutineKey=coroutine_runner.start(function()
            this.vm.data.doorAnimaName=animaName;
            coroutine_runner.wait(0.6) 
            LuaMgr.ShowGetRewardPanel(data);

            if re.result.CanChange then
                this.vm.data.unlockBtnBool=true;
                this.vm.data.buyBtnBool=false;
            end
            askStop=false;
        end)

    end, function()
        askStop=false;
    end, true);
    
end


this.OnAskChangeDrawBox=function()
    local askData={Group=tostring(groupId)};
    ApiMgr.Request("draw/changeBox", askData, true, function(result)
        this.ParseData();
    end,nil,true);
            
end

this.OnAskOpenBox=function()
    local askData={Group=tostring(groupId)}
    ApiMgr.Request("draw/openBox", askData, true, function(result)
        local re=json.decode(result);
        if re.result.CanChange then
            this.vm.data.unlockBtnBool=re.result.CanChange;
            this.vm.data.buyBtnBool=not re.result.CanChange;
            drawId=re.result.NextBox;
        end
       
    end,nil,true);
end

this.ShowOpenTime=function()
    local groupId = ActivityMgr.groupKeyList["draw"]
    local dataGroup_draw=DataMgr.Player.variables[groupId];
    local endTime=os.date("*t",dataGroup_draw.expireTime);
    this.vm.data.endTime=string.format(LuaMgr.GetLangText("LuckyDrawViewModel_1"), 
            endTime.year,endTime.month,endTime.day,endTime.hour,endTime.min)
end



this.UpdateDrawCount=function(value,dir)
    if dir==nil then
        buyCount=value;
    else
        if dir>0 then
            buyCount=buyCount+value;
        elseif dir<0 then
            buyCount=buyCount-value;
        end
    end
    if buyCount>myMaxDrawCount then
        buyCount=myMaxDrawCount>0 and myMaxDrawCount or 1;
    elseif buyCount<1 then
        buyCount=1;
    end
    this.vm.data.buyText=tostring(buyCount);
         
    
    local countText=playDrawTotalCount==0 
            and string.format("<color=#FD0B0B>%s</color>", LuaMgr.NumFormat(buyCount*drawConsume.count))
            or LuaMgr.NumFormat(buyCount*drawConsume.count);
    
    this.vm.data.price=countText;
end


this.ParseData=function()
    coroutineKey=nil;
    this.vm.data.unlockBtnBool=false;
    this.vm.data.buyBtnBool=true;
    dataDrawRewardProgress=DataMgr.Player.drawRewardProgress;
    dataDrawRewardRecords=DataMgr.Player.drawRewardRecords;
    drawId=dataDrawRewardProgress[tostring(groupId)];
    if drawId==nil then
        drawId=drawStartId
    end;
    this.ShowReward(drawId);
    drawConsume=cfgDrawActivityMap[drawId].Consume[1];
    local playerTotalCount=DataHelper.GetItemCountById(drawConsume.id);
    local priceIconPath=ConfigHelper.GetItemIconPath(drawConsume.id);
    this.vm.data.priceIcon=LuaMgr.GetTexture(priceIconPath);
    drawTotalCount=drawTotalCount-this.GetHasRewardCount();
    playDrawTotalCount=math.floor(playerTotalCount/drawConsume.count);
    myMaxDrawCount=playDrawTotalCount>drawTotalCount and drawTotalCount or playDrawTotalCount;
    this.vm.data.btnBuyIsGray=drawTotalCount<=0
    this.UpdateDrawCount(buyCount);
    this.ShowOpenTime();
end


this.ShowReward=function(id)
    drawActivity=cfgDrawActivityMap[id];
    drawTotalCount=0;
    local typeMapList={}
    for i,v in ipairs(drawActivity.Content) do
        local drawItem=cfgDrawMap[v];
        drawTotalCount=drawTotalCount+drawItem.Time;

        if typeMapList[drawItem.Type]==nil then
            typeMapList[drawItem.Type]={}
        end
        table.insert(typeMapList[drawItem.Type],drawItem)
    end
    local typeList={}
    for i,v in pairs(typeMapList) do
        table.insert(typeList,{kType=i,kValue=v});
    end
    table.sort(typeList,function(a, b) return a.kType<b.kType end);
    local list={}
    local height=0;
    for i,v in ipairs(typeList) do
        local contWidth,h=this.GetHeight(#v.kValue);
        local layoutItem={
            drawId=id,
            type=v.kType,
            layoutList=v.kValue,
            itemObj=this.goodItemObj,
            posY=-height,
            width=contWidth,
        }
        height=height+h;
        local layoutData=UIListData.GetData(this.layoutItemObj,"LuckyDraw_LayoutGroup",layoutItem);
        table.insert(list,layoutData);
    end
    this.rewardUIList:SetData(list);
    tranContent.sizeDelta=Vector2(1032,height);
     
end


this.GetHeight=function(len)
    local rate=LuaMgr.ScreenWidth()/LuaMgr.ScreenHeight();
    local loRate=16/9;
    local count=math.floor(constraintCount*(1+rate-loRate));
    local row=math.ceil(len/count)
    return count*90+40,row*130;
    
end


this.GetRewardItemRemainCount=function(id)
    local count=cfgDrawMap[id].Time;
    if dataDrawRewardRecords~=nil then
        local key=string.format("%s_%s",drawId,id);
        local hasBuyCount=dataDrawRewardRecords[key];
        if hasBuyCount~=nil then
            count= count-hasBuyCount;
        end
    end
    return count;
end


this.GetHasRewardCount=function()
    local count=0;
    local id=dataDrawRewardProgress[tostring(groupId)];
    if id~=nil and dataDrawRewardRecords~=nil then
        for i,v in pairs(dataDrawRewardRecords) do
            if string.match(i,tostring(drawId)) then
                count=count+v;
            end
        end
    end
    return count;
end


return vm({
    data = data,
    command = command,
    hook = hook
})