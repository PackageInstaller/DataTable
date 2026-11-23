require("ViewModel/Simulate/Simulate_ManageTaskItem")
local this = {
    vm = nil,
    taskUIList={};
    taskItemObj=nil;
};

local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.tranCharacter = uiLink:Get("tranCharacter"):GetComponent("RectTransform");
    ui.tranList = uiLink:Get("tranList"):GetComponent("RectTransform");
    ui.tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    ui.txtContent = uiLink:Get("txtContent"):GetComponent("UIText");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.btnRewardAll = uiLink:Get("btnRewardAll"):GetComponent("Button");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end

this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnRewardAll",function()
        if not DataExHelper.CommonActivityCheck(ActivityKey.XCHD) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("15901"))
            return
        end
        DataExHelper.EX_GetGroupAward(4190,function()
            this.ParseData();
        end)
    end)
end


local data = {
    bodyPath=""
}
local command = {

}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        print("before_awake");
        this.InitUI(vm.behaviour)
        this.taskUIList=UIListView.New(ui.tranContent);
        this.taskItemObj=vm.behaviour.transform:Find("template/taskItem").gameObject;
        this.spineCharacter=vm.behaviour.transform:Find("root/Middle/tranCharacter/Body"):GetComponent("UISpineCharacter");
        this.randomIndex=0;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.taskList=DataExHelper.Check_ConfigQuestEventByText("XCRWTASK")
            if IsNull(this.taskList) then return end;
            this.SetCharacter();
            this.SetAjustScreen();
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        this.taskUIList:Clear();
        if this.spineCharacter~=nil then
            this.spineCharacter:Clear();
        end
    end,
    before_destroy = function()
        this.ClearUI()
        UIListView.ClearItem("Simulate_ManageTaskItem")
    end
}

this.SetAjustScreen=function()
    local rate=LuaMgr.ScreenWidth()/LuaMgr.ScreenHeight();
    if rate>=21/9 then
        ui.tranCharacter.anchoredPosition=Vector2(-490-50,-8)
        ui.tranList.anchoredPosition=Vector2(50,0);
    else
        ui.tranCharacter.anchoredPosition=Vector2(-490,-8)
        ui.tranList.anchoredPosition=Vector2(0,0);
    end

end


this.SetCharacter = function()
    local path = HeroManager.SetCharacterDrawing(this.spineCharacter, "D0067", "D0067001");
    if (path ~= "") then
        this.vm.data.bodyPath = path;
    end
end


this.ParseData=function()
    this.dataQuests=DataMgr.Player.quests;
    local index=this.randomIndex%3+3;
    ui.txtContent.text=ConfigMgr.LangGlobal("2941"..index)
    this.SetTaskUIList();
    this.randomIndex=this.randomIndex+1;
    
end


this.SetTaskUIList=function()
    this.taskUIList:Clear();
    local list={}
    local isRewardAll=false;
    for i,v in ipairs(this.taskList) do
        local taskState,curPro=this.GetTaskState(v.id);
        local taskItem={
            index=i,
            questId=v.id,
            info=LuaMgr.GetLangText(v.remarksLan),
            pro=curPro,
            max=v.progress,
            items=v.showReward,
            state=taskState;
            orderNum=v.sort,
            callBack=this.TaskCallBack,
        }
        if taskState==1 then
            isRewardAll=true;
        end
        local taskData=UIListData.GetData(this.taskItemObj,"Simulate_ManageTaskItem",taskItem);
        table.insert(list,taskData);
    end
    table.sort(list,function(a, b)
        if a.data.state==b.data.state then
            return a.data.orderNum<b.data.orderNum;
        else
            return a.data.state<b.data.state
        end
    end)
    this.taskUIList:SetData(list);
    SetActive(ui.btnRewardAll.gameObject,isRewardAll);
end


this.GetTaskState=function(id)
    if this.dataQuests[id]==nil then
        return 2,0;
    end
    local dataQuest=this.dataQuests[id];
    if  dataQuest.state==1 then
        return 2,dataQuest.progress;
    elseif dataQuest.state==2 then
        return 1,dataQuest.progress;
    elseif dataQuest.state==3 then
        return 3,dataQuest.progress
    end
end

this.TaskCallBack=function(index,questId)
    if not DataExHelper.CommonActivityCheck(ActivityKey.XCHD) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("15901"))
        return
    end
    for i,v in ipairs(this.taskUIList.itemList) do
        if v.data.questId==questId then
            v:SetRewardFX();
            break;
        end
    end
    NumTool.DelayHandler(function()
        DataExHelper.EX_GetAward(questId,function()
            this.ParseData();
        end) 
    end,1)
end


return vm({
    data = data,
    command = command,
    hook = hook
})