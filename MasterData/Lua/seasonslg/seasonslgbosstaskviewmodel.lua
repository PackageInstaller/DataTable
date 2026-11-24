require("SeasonSLG/BossTaskSpecialGroup")
require("SeasonSLG/BossTaskSpecialItem")
require("SeasonSLG/BossTaskNormalItem")
local this = {
   normalTaskUIList={};
   specialTaskScrollView={};
   normalItemObj=nil;
   specialGroupObj=nil;
   specialItemObj=nil;
};

local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Left = uiLink:Get("Left");
    ui.Middle = uiLink:Get("Middle");
    ui.goBar1 = uiLink:Get("goBar1");
    ui.goBar1Checkmark = uiLink:Get("goBar1Checkmark");
    ui.goBar2 = uiLink:Get("goBar2");
    ui.goBar2Checkmark = uiLink:Get("goBar2Checkmark");
    ui.goBar3 = uiLink:Get("goBar3");
    ui.goBar3Checkmark = uiLink:Get("goBar3Checkmark");
    ui.goNormalGroup = uiLink:Get("goNormalGroup");
    ui.goAllServerGroup = uiLink:Get("goAllServerGroup");
    ui.goAllServerScrollView = uiLink:Get("goAllServerScrollView");
    ui.Right = uiLink:Get("Right");
    ui.btnBar1 = uiLink:Get("btnBar1"):GetComponent("Button");
    ui.btnBar2 = uiLink:Get("btnBar2"):GetComponent("Button");
    ui.btnBar3 = uiLink:Get("btnBar3"):GetComponent("Button");
    ui.tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    ui.txtProgressValue = uiLink:Get("txtProgressValue"):GetComponent("Text");
    ui.imgProgress = uiLink:Get("imgProgress"):GetComponent("Image");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end

this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnBar1",function()
        this.SwitchBar(1);
    end)
    uiLink:AddClickEvent("btnBar2",function()
        this.SwitchBar(2);
    end)
    uiLink:AddClickEvent("btnBar3",function()
        this.SwitchBar(3);
    end)

end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.InitUI(vm.behaviour)
        this.normalTaskUIList=UIListView.New(ui.tranContent);
        this.normalItemObj=vm.behaviour.transform:Find("template/normalItem").gameObject;
        this.specialTaskScrollView=UIScrollView.New(ui.goAllServerScrollView);
        this.specialGroupObj=vm.behaviour.transform:Find("template/specialGroup").gameObject;
        this.specialItemObj=vm.behaviour.transform:Find("template/specialItem").gameObject;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length>0 then
            local type=tonumber(vm.behaviour.Params[0]);
            this.isBoss2Task=type==2;
            SetActive(ui.goBar3,this.isBoss2Task);
            SetActive(ui.goBar1,false)
            SetActive(ui.goAllServerGroup,this.isBoss2Task);
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.barIndex=nil;
        this.normalTaskUIList:Clear();
        this.specialTaskScrollView:Clear();
    end,
    before_destroy = function()
        this.ClearUI();
        UIListView.ClearItem("BossTaskNormalItem")
        UIScrollView.ClearItem("BossTaskSpecialGroup")
        UIListView.ClearItem("BossTaskSpecialItem")
    end
}

this.ParseData=function()
    this.taskListDic={};
    for i,v in pairs(ConfigMgr.Config.SeasonalTaskMap) do
        if this.taskListDic[v.Type]==nil then
            this.taskListDic[v.Type]={}
        end
        table.insert(this.taskListDic[v.Type],v);
    end
    this.dataBossTask=DataMgr.Player.SeasonalTasks;
    this.SwitchBar(2);
end

this.SwitchBar=function(index)
    if this.barIndex~=nil and this.barIndex==index then
        return;
    end
    this.barIndex=index;
    SetActive(ui.goBar1Checkmark,this.barIndex==1)
    SetActive(ui.goBar2Checkmark,this.barIndex==2)
    SetActive(ui.goBar3Checkmark,this.barIndex==3)
    this.taskList={};
    SetActive(ui.goAllServerGroup,this.barIndex==3)
    SetActive(ui.goNormalGroup,this.barIndex<3);
    if this.barIndex==3 then
        this.taskList=this.taskListDic["S303"]
        this.SetSpecialScrollView();
    elseif this.barIndex==2 then
        this.taskList=this.isBoss2Task and this.taskListDic["S301"] or this.taskListDic["S305"]
        this.SetNormalUIList();
    elseif this.barIndex==1 then
        this.taskList=this.isBoss2Task and this.taskListDic["S302"] or this.taskListDic["S304"]
        this.SetNormalUIList();
    end
end

this.SetNormalUIList=function()
    this.normalTaskUIList:Clear();
    if this.taskList == nil or #this.taskList==0 then return end;
    local list={};
    for i,v in ipairs(this.taskList) do
        local status,current=this.GetTaskStatus(v.Id)
        local taskItem={
            callbackGetReward=this.NormalRewardCallBack,
            Id=v.Id,
            Status=status,
            Sort=v.Sort,
            Desc=string.format(LuaMgr.GetLangText(v.DescLan),tostring(current)),
            Rewards=v.Reward
        }
        local taskData=UIListData.GetData(this.normalItemObj,"BossTaskNormalItem",taskItem);
        table.insert(list,taskData);
    end
    table.sort(list,function(a, b)
        if a.data.Status<2 and b.data.Status<2 then
            if a.data.Status==b.data.Status then
                return a.data.Sort<b.data.Sort;
            else
                return a.data.Status>b.data.Status
            end
        else
            if a.data.Status==b.data.Status then
                return a.data.Sort<b.data.Sort;
            else
                return a.data.Status<2 and b.data.Status==2;
            end
        end
    end)
    this.normalTaskUIList:SetData(list);
end

this.GetTaskStatus=function(taskId)
    local status=0;
    local dataItem= this.dataBossTask[taskId];
    if dataItem~=nil then
        if dataItem.completed then
            status=2;
        else
            status=dataItem.current==dataItem.target and 1 or 0;
        end
    end
    return status,dataItem and dataItem.current or 0;
end

this.NormalRewardCallBack=function(Id)
    SeasonSLGAPI.OnAskTaskReward({Id},function()
       this.SetNormalUIList();;
    end)
end

this.SetSpecialScrollView=function()
    local curProgress=SeasonSLGMapMgr.GetBoss2ChallengeProgress();
    local maxProgress=SeasonSLGMapMgr.Constants().SeasonalBossHeatMax[1]*SeasonSLGMapMgr.Constants().SeasonalBossHeatMax[2]
    local rate=curProgress/maxProgress;
    ui.txtProgressValue.text=string.format("%.f%%",rate*100);
    ui.imgProgress.fillAmount=rate;
    this.specialTaskScrollView:Clear();
    if #this.taskList==0 then return end;
    table.sort(this.taskList,function(a,b) return a.Sort<b.Sort  end)
    local groupList={};

    for i = 1, #this.taskList, 5 do
        local group = {}
        for j = i, math.min(i + 4, #this.taskList) do
            this.taskList[j].Status=this.GetTaskStatus(this.taskList[j].Id)
            table.insert(group, this.taskList[j])
        end
        table.insert(groupList, group)
    end
    local list={};
    for i,v in ipairs(groupList) do
        local groupItem={
            rowIndex=i,
            item=this.specialItemObj,
            list=v,
            groupCallback=this.SpecialItemCallBack,
        }
        local groupItemData=UIScrollData.GetData(this.specialGroupObj,"BossTaskSpecialGroup",953,180,groupItem);
        table.insert(list,groupItemData);
    end
    this.specialTaskScrollView:SetParams(954,506)
    this.specialTaskScrollView:SetData(list);
end

this.SpecialItemCallBack=function(rowIndex,colIndex)
    local index=(rowIndex-1)*5+colIndex;
    if this.specialTaskScrollView.itemList[index].data.Status~=1 then
        return;
    end
    local taskId=this.taskList[index];
    SeasonSLGAPI.OnAskTaskReward({taskId},function()
       this.SetSpecialScrollView();
    end)
end


return vm({
    data = data,
    command = command,
    hook = hook
})