





require("ViewModel/WalkMount/WalkMount_MountItem")
local this = {
    vm=nil,
    mountUIList=nil,
    mountItemObj=nil,
    serverRewardData=nil,
};

local posList={Vector2(-500,163),Vector2(-267,-24),Vector2(336,-24),Vector2(500,163)}
local mountIds={"9000","9001","9002","9003"}
local spriteTag={"jhsm","xzqc","zytx","zyzr"}
local bigRewardId="9004"
local cfgLotteryActivityMap={}
local cfgLotteryMap={};
local dataLottery=nil
local curType=nil;
local proIndex=nil;
local totalCount=nil;
local isLack=false;
local isStopClick=false;
local rewardItem=nil;
local dayRewardItem=nil;
local curDayTask=nil;



local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Middle = nil;
local Right = nil;
local Left = nil;
local goMask = nil;
local goBig=nil;
local goNor=nil;
local goDone=nil;
local textTimer = nil;
local textNum = nil;
local textProValue = nil;
local tranContent = nil;
local tranReward = nil;
local rawImageIcon = nil;
local btnSubmit = nil;
local btnHero = nil;
local btnAllReward=nil;
local goCost=nil;
local goGrayCost=nil
local goDayTaskProing=nil;
local textDayInfo=nil;
local btnDayJump=nil;
local btnDayReward=nil;
local tranDayReward=nil;
local goDayTaskDone=nil;
local goDayTask=nil;



this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Middle = uiLink:Get("Middle");
    Right = uiLink:Get("Right");
    Left = uiLink:Get("Left");
    goMask = uiLink:Get("goMask");
    goBig=uiLink:Get("goBig");
    goNor=uiLink:Get("goNor");
    goDone=uiLink:Get("goDone");
    textTimer = uiLink:Get("textTimer"):GetComponent("Text");
    textNum = uiLink:Get("textNum"):GetComponent("Text");
    textProValue = uiLink:Get("textProValue"):GetComponent("Text");
    tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    tranReward = uiLink:Get("tranReward"):GetComponent("RectTransform");
    rawImageIcon = uiLink:Get("rawImageIcon"):GetComponent("RawImage");
    btnSubmit = uiLink:Get("btnSubmit"):GetComponent("UIButtonClick");
    btnHero = uiLink:Get("btnHero"):GetComponent("Button");
    btnAllReward=uiLink:Get("btnAllReward"):GetComponent("Button");
    goCost=uiLink:Get("goCost");
    goGrayCost=uiLink:Get("goGrayCost");
    
     goDayTaskProing=uiLink:Get("goDayTaskProing");
     textDayInfo=uiLink:Get("textDayInfo"):GetComponent("Text");;
     btnDayJump=uiLink:Get("btnDayJump"):GetComponent("Button");;
     btnDayReward=uiLink:Get("btnDayReward"):GetComponent("Button");;;
     tranDayReward=uiLink:Get("tranDayReward"):GetComponent("RectTransform");
     goDayTaskDone=uiLink:Get("goDayTaskDone");
    goDayTask=uiLink:Get("goDayTask");
    
    uiLink:AddClickEvent("btnSubmit",this.BtnSubmit_Execute);
    uiLink:AddClickEvent("btnHero",this.BtnHero_Execute);
    uiLink:AddClickEvent("btnAllReward",this.BtnAllReward_Execute);
    uiLink:AddClickEvent("btnDayJump",this.BtnDayJump_Execute);
    uiLink:AddClickEvent("btnDayReward",this.BtnDayReward_Execute);
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Middle = nil;
    Right = nil;
    Left = nil;
    goMask = nil;
    goBig=nil;
    textTimer = nil;
    textNum = nil;
    textProValue = nil;
    tranContent = nil;
    tranReward = nil;
    rawImageIcon = nil;
    btnSubmit = nil;
    btnHero = nil;
    goCost=nil;
    goGrayCost=nil;
    goDayTaskProing=nil;
    textDayInfo=nil;
    btnDayJump=nil;
    btnDayReward=nil;
    tranDayReward=nil;
    goDayTaskDone=nil;
    goDayTask=nil;
end





local data = {
}


local command = {
}

this.BtnSubmit_Execute=function()
    if isLack then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("10504"))
        return
    end
    if proIndex>=totalCount then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("10501"))
        return
    end
    if isStopClick then return end;
    isStopClick=true;
    local body={ActivityID=curType}
    ApiMgr.Request("buy_lottery", body, true, function(result)
        local re=json.decode(result);
        this.serverRewardData=re.result;
        local data=json.encode(this.serverRewardData.Reward);
        if body.ActivityID==bigRewardId then
            LuaMgr.ShowLuaPanel(UIName.WalkMountCardViewModel,re.result.LotteryID,function()
                LuaMgr.ShowItemRewared(data);
            end)
        else
            LuaMgr.ShowLuaPanel(UIName.WalkMountAnalyseViewModel,re.result.LotteryID,true,function()
                LuaMgr.ShowItemRewared(data);
            end)
        end
        this.ParseData()

            HeroRedDataHelper.SetWalkMountRed();
            RedMgr.Singleton:RefreshOtherViewModel(UIName.WalkMountMainViewModel)

    end, nil,true);
end

this.BtnHero_Execute=function()
    if FeatureManager.IsLock("1040") then
        local tipStr=FeatureManager.TipStr("1040")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tipStr);
        return;
    end
    HeroParameter.SavePanelType("branchprop")
    FeatureManager.GotoPanel("1041")
end

this.BtnAllReward_Execute=function()
    LuaMgr.ShowLuaPanel(UIName.WalkMountRewardsViewModel)
end

this.MountClick_Execute=function(index)
    LuaMgr.ShowLuaPanel(UIName.WalkMountPoemViewModel,mountIds[index],spriteTag[index]);
end

this.BtnDayJump_Execute=function()
    if curDayTask==nil then
        return
    end
    FeatureManager.GotoViewModel(curDayTask.skipPage);
end

this.BtnDayReward_Execute=function()
    if curDayTask==nil then
        return
    end
    DataExHelper.EX_GetAward(curDayTask.id,function()
        this.SetDayTaskInfo();
        this.LotteryCost();
        HeroRedDataHelper.SetWalkMountRed();
        RedMgr.Singleton:Refresh();
    end)
end

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
        this.mountUIList = UIListView.New(tranContent);
        this.mountItemObj=vm.behaviour.transform:Find("template/mountItem").gameObject;
        RedMgr.Singleton:RegisterViewModel(UIName.WalkMountMainViewModel);
      
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            vm.behaviour:UpdateTopBar("", this.OnBack);
            cfgLotteryActivityMap=ConfigMgr.Config.LotteryActivityMap;
            cfgLotteryMap=ConfigMgr.Config.LotteryMap;
            LuaMgr.AddUIEventListener(UIEventConst.PropUse, this.ParseData);
            this.ParseData()
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then
            LuaMgr.RemoveTimer(TimerConst.ChanganTimer);
            LuaMgr.RemoveUIEventListener(UIEventConst.PropUse, this.ParseData);
        end
    end,
    before_destroy=function()
         this.Clear();
    end
        
    
}
this.OnBack=function()
    if not DataExHelper.Check_WalkMount() then
        LuaMgr.Back();
    else
        LuaMgr.Back("walkmount");
    end
end



this.ParseData=function()
    dataLottery=DataMgr.Player.lottery;
    proIndex=0;
    totalCount=0;
    isStopClick=false;
    this.SetMountList()
    this.LotteryCost();
    this.SetTime();
    this.SetDayTaskInfo();
    SetActive(goNor,curType~=bigRewardId and proIndex<totalCount)
    SetActive(goBig,curType==bigRewardId and proIndex<totalCount)
    SetActive(goDone,proIndex>=totalCount)
    SetActive(goCost,proIndex<totalCount)
    SetActive(goGrayCost,proIndex>=totalCount)
end

this.SetMountList=function()
    local list={};
    local lastPass=true;;
    curType=nil;
    for i,v in ipairs(mountIds) do
        local proValue,totalValue=this.GetMountProgross(v);
        local mountItem={
            index=i,
            locPos=posList[i],
            curValue=proValue,
            maxValue=totalValue,
            unLock=proValue>0,
            spriteTag=spriteTag[i],
            mountClick=this.MountClick_Execute,
            id=v,
        }
        if lastPass and proValue~=totalValue then
            curType=v;
        end
        lastPass=proValue==totalValue;
        proIndex=proIndex+proValue;
        totalCount=totalCount+totalValue;
        local mountData=UIListData.GetData(this.mountItemObj,"WalkMount_MountItem",mountItem);
        table.insert(list,mountData);
    end
    if curType==nil then
        curType=bigRewardId
    end
    this.mountUIList:SetData(list)
    if dataLottery[bigRewardId]~=nil then
        proIndex=proIndex+#dataLottery[bigRewardId]
    end
    totalCount=totalCount+#cfgLotteryActivityMap[bigRewardId].Content
end


this.GetMountProgross=function(id)
    local lotteryActivity=cfgLotteryActivityMap[id]
    if dataLottery==nil or dataLottery[id]==nil then
        return 0,#lotteryActivity.Content;
    end
    return #dataLottery[id],#lotteryActivity.Content;
end


this.CheckReward=function(rewardId)
    if(dataLottery==nil or dataLottery[curType]==nil) then return true end;
    local rewards=dataLottery[curType];
    for i,v in ipairs(rewards) do
        if(v==rewardId) then
            return false;
        end
    end
    return true;
end

this.LotteryCost=function()
    local lotteryActivity=cfgLotteryActivityMap[curType]
    local curTypeProIndex=0;
    for i,v in ipairs(lotteryActivity.Content) do
        if(this.CheckReward(v)) then
            curTypeProIndex=i;
            break
        end
    end
    SetActive(goMask,curTypeProIndex==0)
    if(curTypeProIndex==0) then
        curTypeProIndex=1;
    end
    local consume=lotteryActivity.Consume[curTypeProIndex];
    local path=ConfigHelper.GetItemHomeIconPath(consume.id);
    rawImageIcon.texture=LuaMgr.GetTexture(path);
    local myCount=DataHelper.GetItemCountById(consume.id)
    isLack=myCount<consume.count
    if isLack then
        textNum.text=string.format("<color=#FF1807>%s</color>",consume.count)
    else
        textNum.text= proIndex>=totalCount and  string.format("<color=#CACACA>%s</color>",consume.count) or consume.count;
    end
    textProValue.text=string.format("<color=#ffc600>%s</color>/%s",proIndex,totalCount)
    this.SetReward(lotteryActivity.Content[curTypeProIndex])
end


this.SetTime=function()
    local variables=DataExHelper.GetDataExByTag(ActivityKey.walkmount)
    local startDate=os.date("*t",variables.startTime);
    local endDate=os.date("*t",variables.expireTime);
    textTimer.text=string.format(LuaMgr.GetLangText("WalkMountMainViewModel_0"),
            startDate.year,startDate.month,startDate.day,endDate.year,endDate.month,endDate.day);
    
end

this.SetReward=function(rewardId)
    local rewardInfo=cfgLotteryMap[rewardId];
    if rewardInfo==nil then
        return
    end;
    local reward=rewardInfo.Reward[1];
    if rewardItem==nil then
        rewardItem=GoodsDataItem.New(tranReward)
    end
    local itemConfig = ConfigMgr.Config.itemMap[reward.id]
    itemConfig["count0"] = reward.count
    rewardItem:SetData(1,itemConfig,1,false,Vector3(0.5,0.5,0.5),false)
end


this.SetDayTaskInfo=function()
    if proIndex>=totalCount then
        SetActive(goDayTask,false);
        return
    end
    local cfgDayTaskData=DataExHelper.Check_ConfigQuestEventByText("walkmountTask")
    local questData=DataMgr.Player.quests;
    local curTaskList={};
    for i,v in ipairs(cfgDayTaskData) do
        if questData[v.id]~=nil then
            table.insert(curTaskList,v);
        end
    end
    if #curTaskList==0 then 
       SetActive(goDayTask,false); 
        return 
    end;
    SetActive(goDayTask,true);
    table.sort(curTaskList,function(a, b) return tonumber(a.id)<tonumber(b.id) end)
    curDayTask=nil;
    for i,v in ipairs(curTaskList) do
        if questData[v.id]~=nil and questData[v.id].state~=3 then
            curDayTask=v;
            break;
        end
    end
    if curDayTask~=nil then
        SetActive(goDayTaskProing,true);
        SetActive(goDayTaskDone,false)
        textDayInfo.text=LuaMgr.GetLangText(curDayTask.namelan)
        SetActive(btnDayJump.gameObject,questData[curDayTask.id].state==1)
        SetActive(btnDayReward.gameObject,questData[curDayTask.id].state==2)
    else
        SetActive(goDayTaskProing,false)
        SetActive(goDayTaskDone,true);
        curDayTask=curTaskList[#curTaskList];
    end

    local reward=curDayTask.showReward[1]
    if dayRewardItem==nil then
        dayRewardItem=GoodsDataItem.New(tranDayReward)
    end
    local itemConfig = ConfigMgr.Config.itemMap[reward.id]
    itemConfig["count0"] = reward.count
    dayRewardItem:SetData(1,itemConfig,1,false,Vector3(0.5,0.5,0.5),false)
end


return vm({
    data = data,
    command = command,
    hook = hook
})