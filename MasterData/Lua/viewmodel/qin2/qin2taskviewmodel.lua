




require("ViewModel/Qin2/Qin2Task_ItemGroup")
require("ViewModel/Qin2/Qin2Task_Item")

local this = { vm = nil,
               taskUIView = nil;
               taskGroupItemObj = nil;
               taskItemObj = nil;
               cfgTask=nil;
               dataQuests = nil;
};


local tarGameObject = nil;
local tarRect = nil;
local slider = nil;
local root = nil;
local goods = nil;
local Middle = nil;
local goScrollView = nil;
local Right = nil;
local Left = nil;
local tranContent = nil;
local btnRewardAll = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    slider = uiLink:Get("slider"):GetComponent("Slider");
    root = uiLink:Get("root");
    goods = uiLink:Get("goods");
    Middle = uiLink:Get("Middle");
    goScrollView = uiLink:Get("goScrollView");
    Right = uiLink:Get("Right");
    Left = uiLink:Get("Left");
    tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    btnRewardAll = uiLink:Get("btnRewardAll"):GetComponent("Button");
    this.AddRegister(uiLink);
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    slider = nil;
    root = nil;
    goods = nil;
    Middle = nil;
    goScrollView = nil;
    Right = nil;
    Left = nil;
    tranContent = nil;
    btnRewardAll = nil;

end




local data={}
local command={}

this.AddRegister=function(uiLink)
   uiLink:AddClickEvent("btnRewardAll",function()
       if not DataExHelper.CommonActivityCheck(ActivityKey.QinTour) then
           LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("15901"))
           return
       end
       DataExHelper.EX_GetGroupAward(2050,function()
           this.ParseData();
       end)
   end)
   
end




local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
        this.taskGroupItemObj=vm.behaviour.transform:Find("template/taskGroupItem").gameObject;
        this.taskItemObj=vm.behaviour.transform:Find("template/taskItem").gameObject;
        this.taskUIView=UIScrollView.New(goScrollView);
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then
            this.ParseCfg();
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end;
        this.taskUIView:Clear();
    end,
    before_destroy=function()
        this.Clear()
        UIScrollView.ClearItem("Qin2Task_ItemGroup")
        UIListView.ClearItem("Qin2Task_Item")
    end
}

this.ParseCfg=function()
this.cfgTaskGroup={};
this.cfgTaskMapList={};
    local taskList=DataExHelper.Check_ConfigQuestEventByText("Qin2Task")
    for i,v in ipairs(taskList) do
        if v.special[2]=="2" then
            table.insert(this.cfgTaskGroup,v);
        elseif v.special[2]=="1" then
            if this.cfgTaskMapList[v.special[1]]==nil then
                this.cfgTaskMapList[v.special[1]]={}
            end
            table.insert(this.cfgTaskMapList[v.special[1]],v);
        end
    end
end

this.ParseData=function()
    this.dataQuests=DataMgr.Player.quests;
    this.SetTaskView();
end



this.CheckTaskState=function(taskId)
    local dataTask= this.dataQuests[taskId];
    if dataTask~=nil then
        return dataTask.state,dataTask.progress
    else
        return 1,0;
    end
end

this.CheckGroupComplete=function(groupTask)
    local childTaskList=this.cfgTaskMapList[groupTask.special[1]]
    for i,v in ipairs(childTaskList) do
        if this.CheckTaskState(v.id)~=3 then
            return false;
        end
    end
    if this.CheckTaskState(groupTask.id)~=3 then
        return false;
    end
    return true;
end


this.CheckShowBtnRewardAll=function(groupTask)
    local isShow=false;
    local childTaskList=this.cfgTaskMapList[groupTask.special[1]]
    for i,v in ipairs(childTaskList) do
        if this.CheckTaskState(v.id)==2 then
            isShow=true
            break;
        end
    end
    if this.CheckTaskState(groupTask.id)==2 then
        isShow=true;
    end
    return isShow;
end

this.SetTaskView=function()
    SetActive(btnRewardAll.gameObject,false)
    local list={}
    for i,v in ipairs(this.cfgTaskGroup) do
        local taskGroup={
            groupId=v.id,
            award=v.showReward,
            groupIcon=v.special[1],
            sort=v.sort,
            groupName=LuaMgr.GetLangText(v.namelan),
            groupComplete=this.CheckGroupComplete(v);
            childTaskList=this.cfgTaskMapList[v.special[1]],
            childObj=this.taskItemObj,
            rewardCallBack=this.RewardCallBack,
            jumpCallBack=this.JumpCallBack,
        }
        local groupData=UIScrollData.GetData(this.taskGroupItemObj,"Qin2Task_ItemGroup",1256,256,taskGroup)
        table.insert(list,groupData);
        if this.CheckShowBtnRewardAll(v) then
            SetActive(btnRewardAll.gameObject,true);
        end
    end
    table.sort(list,function(a, b)
        if not a.data.groupComplete and not b.data.groupComplete then
            return a.data.sort<b.data.sort;
        else
            return not a.data.groupComplete and b.data.groupComplete;
        end
    end)
    this.taskUIView:SetParams(1280,600)
    this.taskUIView:SetData(list,true);
    tranContent.sizeDelta=Vector2(1280,tranContent.sizeDelta.y+60);
end


this.RewardCallBack=function(id)
    if not DataExHelper.CommonActivityCheck(ActivityKey.QinTour) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("15901"))
        return
    end
    DataExHelper.EX_GetAward(id,function()
        this.ParseData();
    end)
end

this.JumpCallBack=function(skipPage)
    FeatureManager.GotoViewModel(skipPage);
end

return vm({
    data = data,
    command = command,
    hook = hook
})