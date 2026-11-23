




require("ViewModel/BrilliantGift/BrilliantGift_TaskItem")
require("ViewModel/BrilliantGift/BrilliantGift_DayItem")
require("ViewModel/BrilliantGift/BrilliantGift_progressItem")
local this = {vm=nil, 
              dayUIList=nil,
              taskUIList=nil,
              progressUIList=nil;
              dayItemObj=nil,
              taskItemObj=nil;
              progressItemObj=nil;
              rewardItemObj=nil;
              popItemList={},
              lableIndex=nil;
              dayIndex = nil;
              
};
local cokey=nil;


local tarGameObject = nil;
local tarRect = nil;
local btnDay = nil;
local btnSignIn = nil;
local btnMission = nil;
local btnClosePop = nil;
local slider = nil;
local text = nil;
local txtTime = nil;
local txtProValue = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local goSignInChoose = nil;
local goMissionChoose = nil;
local goPanel1 = nil;
local goRewardPopup = nil;
local goPanel2 = nil;
local Right = nil;
local tranTaskList = nil;
local tranDayList = nil;
local tranProgressList = nil;
local tranPopListContent = nil;
local imgFillAmount = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    btnDay = uiLink:Get("btnDay"):GetComponent("Button");
    btnSignIn = uiLink:Get("btnSignIn"):GetComponent("Button");
    btnMission = uiLink:Get("btnMission"):GetComponent("Button");
    btnClosePop = uiLink:Get("btnClosePop"):GetComponent("Button");
    slider = uiLink:Get("slider"):GetComponent("Slider");
    text = uiLink:Get("text"):GetComponent("Text");
    txtTime = uiLink:Get("txtTime"):GetComponent("Text");
    txtProValue = uiLink:Get("txtProValue"):GetComponent("Text");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    goSignInChoose = uiLink:Get("goSignInChoose");
    goMissionChoose = uiLink:Get("goMissionChoose");
    goPanel1 = uiLink:Get("goPanel1");
    goRewardPopup = uiLink:Get("goRewardPopup");
    goPanel2 = uiLink:Get("goPanel2");
    Right = uiLink:Get("Right");
    tranTaskList = uiLink:Get("tranTaskList"):GetComponent("RectTransform");
    tranDayList = uiLink:Get("tranDayList"):GetComponent("RectTransform");
    tranProgressList = uiLink:Get("tranProgressList"):GetComponent("RectTransform");
    tranPopListContent = uiLink:Get("tranPopListContent"):GetComponent("RectTransform");
    imgFillAmount = uiLink:Get("imgFillAmount"):GetComponent("Image");
    this.AddRigister(uiLink);
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    btnDay = nil;
    btnSignIn = nil;
    btnMission = nil;
    btnClosePop = nil;
    slider = nil;
    text = nil;
    txtTime = nil;
    txtProValue = nil;
    root = nil;
    Left = nil;
    Middle = nil;
    goSignInChoose = nil;
    goMissionChoose = nil;
    goPanel1 = nil;
    goRewardPopup = nil;
    goPanel2 = nil;
    Right = nil;
    tranTaskList = nil;
    tranDayList = nil;
    tranProgressList = nil;
    tranPopListContent = nil;
    imgFillAmount = nil;

end




this.AddRigister=function(uiLink)
    uiLink:AddClickEvent("btnClosePop",function()
        SetActive(goRewardPopup,false);
    end)
    uiLink:AddClickEvent("btnSignIn",function()
        this.SwitchLable(1)
    end)
    uiLink:AddClickEvent("btnMission",function()
        this.SwitchLable(2)
    end)
end


local data={}

local command = {

}


local hook = {
    before_awake = function(vm)
        this.vm=vm;
        print("before_awake");
        this.Init(vm.behaviour)
        RedMgr.Singleton:RegisterViewModel(UIName.BrilliantGiftViewModel);
        this.taskUIList=UIListView.New(tranTaskList)
        this.dayUIList=UIListView.New(tranDayList);
        this.progressUIList=UIListView.New(tranProgressList)
        this.taskItemObj=vm.behaviour.transform:Find("template/TaskItem").gameObject;
        this.dayItemObj=vm.behaviour.transform:Find("template/DayItem").gameObject;
        this.progressItemObj=vm.behaviour.transform:Find("template/ProgressItem").gameObject;
        this.rewardItemObj=vm.behaviour.transform:Find("template/RewardItem").gameObject;
       
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params == nil) then return end
        vm.behaviour:UpdateTopBar("", function()
            LuaMgr.HidePanel(UIName.BrilliantGiftPopUpViewModel);
            LuaMgr.Back();
        end);
        this.ParseCfg();
        this.ParseData();
    end,
   
    before_deactive = function(vm)
        print("before_deactive");
        if (vm.behaviour.Params == nil) then return end
        this.lableIndex=nil;
        this.taskUIList:Clear();
        this.dayUIList:Clear();
        this.progressUIList:Clear();
        if cokey~=nil then
            coroutine_runner.stop(cokey);
        end
    end,
    
    before_destroy=function()
        UIListView.ClearItem("BrilliantGift_TaskItem")
        UIListView.ClearItem("BrilliantGift_DayItem")
        UIListView.ClearItem("BrilliantGift_progressItem")
        this.Clear();
    end
    
}

this.SwitchLable=function(index)
    if this.lableIndex~=nil and this.lableIndex==index then return end;
    this.lableIndex=index;
    SetActive(goSignInChoose,index==1);
    SetActive(goMissionChoose,index==2);
    SetActive(goPanel1,index==1)
    if index==2 then
        LuaMgr.ShowLuaPanel(UIName.BrilliantGiftPopUpViewModel,function()
            this.SwitchLable(1);
        end)
    else
        LuaMgr.HidePanel(UIName.BrilliantGiftPopUpViewModel)
        this.SetPanel1Info();
        RedMgr.Singleton:Refresh();
    end
end

this.ParseCfg=function()
    this.taskCfgList=DataExHelper.Check_ConfigQuestEventByText("BrilliantGiftDay")
    this.taskListByDay={}
    this.dayCount=0;
    for i,v in ipairs(this.taskCfgList) do
        if this.taskListByDay[v.parameter]==nil then
            this.taskListByDay[tostring(v.parameter)]={}
            this.dayCount=this.dayCount+1;
        end
        table.insert(this.taskListByDay[tostring(v.parameter)],v);
    end
    this.progressCfgList=DataExHelper.Check_ConfigQuestEventByText("BrilliantGiftTotal")
    table.sort(this.progressCfgList,function(a, b) return a.sort<b.sort end)
end

this.ParseData=function()
    this.questData=DataMgr.Player.quests;
    SetActive(goRewardPopup,false);

    this.SwitchLable(1);
end


this.SetPanel1Info=function()
    this.SetDayUIList();
    this.SetTaskUIList()
    this.SetProgressList();
    this.SetProInfo();
    local var=DataExHelper.GetDataExByTag(ActivityKey.BrilliantGift);
    if var==nil then return end;
    local time=var.expireTime-LuaMgr.Timestamp();
    if time<0 then time=0 end;
    local day,hour,min=GetTimeDHM2(time)
    txtTime.text=string.format(LuaMgr.GetLangText("BrilliantGiftViewModel_0"),day,hour,min);
end

this.SetProInfo=function()
    this.curProgress=0;
    this.totalProgress=0;
    for i,v in ipairs(this.taskCfgList) do
        if DataMgr.Player.quests[v.id]~=nil and DataMgr.Player.quests[v.id].state==3 then
            this.curProgress=this.curProgress+v.activeValue;
        end
        this.totalProgress=this.totalProgress+v.activeValue;
    end
    txtProValue.text=this.curProgress;
    imgFillAmount.fillAmount=this.curProgress/this.totalProgress;
end

this.SetDayUIList=function()
    this.dayUIList:Clear();
    if this.dayCount==0 then return end;
    this.dayIndex=0;
    local list={}
    for i=1,this.dayCount,1 do
        local dayItem={
            index=i,
            isCurDay=false,
            des=NumTool.GetDayText(i),
            isLock=this.CheckCurDayIsLock(i);
            redId="16201_"..i,
            callBack=this.DayCallBack,
        }
        if not dayItem.isLock then
            this.dayIndex=this.dayIndex+1;
        end
        local dayData=UIListData.GetData(this.dayItemObj,"BrilliantGift_DayItem",dayItem);
        table.insert(list,dayData);
    end
    if this.dayIndex>0 then
        list[this.dayIndex].data.isCurDay=true;
    end
    this.dayUIList:SetData(list);
end

this.CheckCurDayIsLock=function(index)
    local dayTaskList=this.taskListByDay[tostring(index)];
    if dayTaskList==nil or #dayTaskList==0 then return true end;
    local dayOne=dayTaskList[1];
    return this.questData[dayOne.id]==nil ;
end


this.DayCallBack=function(index)
    if this.dayIndex==index then return end;
    this.dayIndex=index;
    for i,v in ipairs(this.dayUIList.itemList) do
        v:SetIsOn(index==i);
    end
    this.SetTaskUIList()
end


this.SetTaskUIList=function()
    this.taskUIList:Clear();
    local taskList=this.taskListByDay[tostring(this.dayIndex)];
    if taskList==nil or #taskList==0 then return end;
    local list={}
    for i,v in ipairs(taskList) do
        local taskItem={
            questId=v.id,
            dse=LuaMgr.GetLangText(v.remarksLan),
            state=this.questData[v.id]~=nil and  this.questData[v.id].state or 1;
            pro=this.questData[v.id]~=nil and this.questData[v.id].progress or 0;
            tar=v.progress;
            reward=v.reward,
            sort=v.sort,
            skipPage=v.skipPage,
            taskCallBack=this.TaskCallBack,
            reward=v.reward,
        }
        local taskData=UIListData.GetData(this.taskItemObj,"BrilliantGift_TaskItem",taskItem);
        table.insert(list,taskData);
    end
    table.sort(list,function(a, b)
        if a.data.state~=2 and b.data.state~=2 then
            if a.data.state==b.data.state then
                return a.data.sort<b.data.sort;
            else
                return a.data.state<b.data.state;
            end
        else
            return a.data.state==2 and b.data.state~=2;
        end
    end);
    this.taskUIList:SetData(list);
    if cokey~=nil then
        coroutine_runner.stop(cokey);
    end
    cokey=coroutine_runner.start(function()
        for i,v in ipairs(this.taskUIList.itemList) do
            if v~=nil then
                v:SetActive();
                coroutine_runner.wait(0.04);
            end
        end
    end)
end



this.TaskCallBack=function(questId,skipPage,type)
    if type==1 then
        if not IsNullOrEmpty(skipPage) then
            FeatureManager.GotoPanel(skipPage);
        end
    elseif type==2 then
        DataExHelper.EX_GetAward(questId,function()
            this.questData=DataMgr.Player.quests;
            this.SetTaskUIList();
            this.SetProInfo();
            this.SetProgressList();
            HeroRedDataHelper.SetBrilliantGiftRed();
            RedMgr.Singleton:Refresh();
        end)
    end
end

this.SetProgressList=function()
    this.progressUIList:Clear();
    if this.progressCfgList==nil or #this.progressCfgList==0 then return end;
    local list={}
    for i,v in ipairs(this.progressCfgList) do
        local progressItem={
            index=i,
            dse=LuaMgr.GetLangText(v.remarksLan),
            state=this.questData[v.id]~=nil and  this.questData[v.id].state or 1;
            pro=v.progress,
            progressCallBack=this.ProgressCallBack,
        }
        local progressData=UIListData.GetData(this.progressItemObj,"BrilliantGift_progressItem",progressItem);
        table.insert(list,progressData);
    end
    this.progressUIList:SetData(list);
end

this.ProgressCallBack=function(index)
    this.progressIndex=index;
    local progressItem=this.progressCfgList[index];
    local state= this.questData[progressItem.id]~=nil and  this.questData[progressItem.id].state or 1;
    if state==2 then

        DataExHelper.EX_GetAward(progressItem.id,function()
            this.questData=DataMgr.Player.quests;
            this.SetProgressList();
            HeroRedDataHelper.SetBrilliantGiftRed();
            RedMgr.Singleton:Refresh();
        end)
    else

        this.ShowProgressRewards(index,progressItem.reward)
    end
end



this.ShowProgressRewards=function(index,rewards)
    local count=0
    if not IsNull(rewards) and  #rewards>0 then
        count=#rewards;
    end;
    if #this.popItemList>count then
        for i=count+1,#this.popItemList,1 do
            SetActive(this.popItemList[i].transform.gameObject,false);
        end
    end
    if count==0 then return end;
    SetActive(goRewardPopup,true);
    local offWidth=(index-1)*166
    tranPopListContent.anchoredPosition=Vector2(-85+offWidth,-170);
    for i,v in ipairs(rewards) do
        if this.popItemList[i]==nil then
            this.popItemList[i]=GoodsDataItem.New(tranPopListContent);
        end
        local itemConfig = ConfigMgr.Config.itemMap[v.id]
        itemConfig["count0"] = v.count
        this.popItemList[i]:SetData(1,itemConfig,1,false,Vector3.one*0.5,true)
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})