local this = {
    vm=nil,
    rewardItemList={
        gameObject=nil;
        normalBG=nil;
        normalBGTimeText=nil;
        normalBGStateText=nil;
        normalBGGoodsItem=nil;
        normalBGFinishImage=nil;
        rewardBG=nil;
        rewardBGTimeText=nil;
        rewardBGStateText=nil;
        rewardBGGoodsItem=nil;
    },
    groupId=803;
    leftRect=nil;
    groupLayout=nil;
};
local HeroManager=CS.Laigu.ViewModel.Hero.HeroManager;
local cfgCheckInQuest={};
local dataQuests={};
local rootGo = nil;
local spineCharacter=nil
local timeText=nil;
local data = {
    bodyPath="";
}
local command = {

    rewordCommand={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.AskReword(param);
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        spineCharacter = vm.behaviour.transform:Find("root/Middle/Group/BG/Character/Group/Body"):GetComponent("UISpineCharacter");
        timeText= vm.behaviour.transform:Find("root/LeftNotLayout/Title/TimeImage/timeText"):GetComponent("Text");
        this.leftRect=vm.behaviour.transform:Find("root/LeftNotLayout"):GetComponent("RectTransform");
        this.groupLayout=vm.behaviour.transform:Find("root/LeftNotLayout/Group"):GetComponent("HorizontalLayoutGroup");

        rootGo = vm.behaviour.transform:Find("root").gameObject;
        this.InitPanelData();
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then
            LuaMgr.RemoveUIEventListener(UIEventConst.HeartBeat,this.FrushData);
            LuaMgr.AddUIEventListener(UIEventConst.HeartBeat,this.FrushData); 
            this.ParseData();
            this.InitPanel();
        end
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartBeat,this.FrushData);
    end,
    
    before_destroy=function()
        rootGo = nil;
        this.Clear();
        this=nil;
    end
}

this.Clear=function ()
    HeroManager=nil;
    cfgCheckInQuest=nil;
    dataQuests=nil;
    rootGo = nil;
    spineCharacter=nil
    timeText=nil;
end

this.InitPanelData=function ()
    for i = 1, 7, 1 do
        local  rewardItem={};
        rewardItem.gameObject=this.vm.behaviour.transform:Find("root/LeftNotLayout/Group/RewardItem"..tostring(i)).gameObject;
        rewardItem.normalBG=rewardItem.gameObject:GetComponent("RectTransform"):Find("NormalBG").gameObject;
        rewardItem.normalBGTimeText=rewardItem.gameObject:GetComponent("RectTransform"):Find("NormalBG/TimeText"):GetComponent("Text");
        rewardItem.normalBGStateText=rewardItem.gameObject:GetComponent("RectTransform"):Find("NormalBG/StateText"):GetComponent("Text");
        rewardItem.normalBGGoodsItem=rewardItem.gameObject:GetComponent("RectTransform"):Find("NormalBG/GoodsItem"):GetComponent("GoodsViewModel");
        rewardItem.normalBGFinishImage=rewardItem.gameObject:GetComponent("RectTransform"):Find("NormalBG/FinishImage").gameObject;
        rewardItem.rewardBG=rewardItem.gameObject:GetComponent("RectTransform"):Find("RewardBG").gameObject;
        rewardItem.rewardBGTimeText=rewardItem.gameObject:GetComponent("RectTransform"):Find("RewardBG/TimeText"):GetComponent("Text");
        rewardItem.rewardBGStateText=rewardItem.gameObject:GetComponent("RectTransform"):Find("RewardBG/StateText"):GetComponent("Text");
        rewardItem.rewardBGGoodsItem=rewardItem.gameObject:GetComponent("RectTransform"):Find("RewardBG/GoodsItem"):GetComponent("GoodsViewModel");
        table.insert(this.rewardItemList,rewardItem);
    end
end

this.FrushData=function()
    this.ParseData();
end


this.InitPanel=function ()
    local nowPrecent=(LuaMgr.GetScreenWidth()+LuaMgr.ScreenOffSet()-1280)/(1680-1280)
    if LuaMgr.ScreenOffSet()~=0 then
        this.leftRect.anchoredPosition = Vector2(this.GetNumberByPercent(56,95,nowPrecent),0);
    end
    this.groupLayout.spacing = this.GetNumberByPercent(5,35,nowPrecent);
end

this.GetNumberByPercent=function (startValue,endValue,percent)
    return startValue+((endValue-startValue)*percent);
end


this.ParseData = function()
    cfgCheckInQuest=DataExHelper.Check_ConfigQuestEventByGroupId(this.groupId);
    table.sort(cfgCheckInQuest,function(a,b) return tonumber(a.id)<tonumber(b.id); end)
    dataQuests=DataMgr.Player.quests;
    this.SetCharacter()
    this.InitTime();
    this.ShowReword();
    
end

this.InitTime=function ()
    local currenTime = LuaMgr.Timestamp();
    local time=DataMgr.Player.variables["group."..tostring(this.groupId)].delTime-LuaMgr.Timestamp();
    local timeFormat=ConfigMgr.LangGlobal("15702");
    local day=math.floor(time/86400);
    local hours=math.ceil((time%86400)/3600);
    timeText.text=string.format(timeFormat,day,hours);
end

this.SetCharacter=function()
    local characterId ="W0029";
    local path = HeroManager.SetCharacterDrawing(spineCharacter, characterId,"W0029002");
    if (path ~= "") then
        this.vm.data.bodyPath = path;
    end
end




this.ShowReword=function()
    local datalist = {};
    local passDay=0;
    local curIndex=0;
    local normalBGState1=ConfigMgr.LangGlobal("15704");
    local normalBGState3=ConfigMgr.LangGlobal("15705");
    local rewardBGState=ConfigMgr.LangGlobal("15706");
    for i,v in ipairs(cfgCheckInQuest) do
        local rewardItem_1=v.reward[1];
        local state=DataExHelper.Check_RewardState(v.id)
        if state==3 then
            passDay=passDay+1;
        elseif state==2 then
            curIndex=i
        end
        local timeTextFormat=ConfigMgr.LangGlobal(tostring(15707+(i-1)));
        this.rewardItemList[i].normalBGTimeText.text=string.format(timeTextFormat,i);
        this.rewardItemList[i].normalBGStateText.text=state==3 and normalBGState3 or normalBGState1;
        this.rewardItemList[i].rewardBGTimeText.text=string.format(timeTextFormat,i);
        this.rewardItemList[i].rewardBGStateText.text=rewardBGState;
        this.rewardItemList[i].rewardBGGoodsItem:SetData(rewardItem_1.id, rewardItem_1.count, 1, 1, true,state~=2);
        this.rewardItemList[i].normalBGGoodsItem:SetData(rewardItem_1.id, rewardItem_1.count, 1, 1, true,state~=2);

if state==2 then
            SetActive(this.rewardItemList[i].normalBG,false);
            SetActive(this.rewardItemList[i].rewardBG,true);
        else
            SetActive(this.rewardItemList[i].normalBG,true);
            SetActive(this.rewardItemList[i].rewardBG,false);
            if state==3 then
                SetActive(this.rewardItemList[i].normalBGFinishImage,true);
            else
                SetActive(this.rewardItemList[i].normalBGFinishImage,false);
            end
        end
    end

    if curIndex==0 and passDay>0 then
        curIndex=passDay;
    end  
end


this.CheckInCanReward=function()
    local dataCheckIn=DataExHelper.Check_DataExByGroupId(this.groupId);
    table.sort(dataCheckIn,function(a,b) return tonumber(a.id)<tonumber(b.id)  end)
    for i,v in ipairs(dataCheckIn) do
        if v.state==1 then
            return v.id;
        end
    end
end



this.AskReword=function(index)
    index=tonumber(index);
    if(index<0)then return end;
    local reward=cfgCheckInQuest[index+1].reward;
    DataExHelper.EX_GetAward(cfgCheckInQuest[index+1].id,function()
        this.ParseData();
        local groupId=tostring(this.groupId);
local re=(ActivityMgr.ActivityCanFinish(ConfigMgr.Config.activityGroup[groupId].key));
local redNum=re and 1 or 0;
        RedMgr.Singleton:UpdateClientRedData(ConfigMgr.Config.activityGroup[groupId].RedId,redNum);
        RedMgr.Singleton:Refresh();

        local rewardids={};
        local rewardNums={};
        for i,v in ipairs(reward) do
            table.insert(rewardids,v.id);
            table.insert(rewardNums,v.count);
            ActivityMgr.CompleteActivity("checkin",groupId.."_"..index+1,rewardids,rewardNums);
        end

    end, true)
end




return vm({
    data = data,
    command = command,
    hook = hook
})