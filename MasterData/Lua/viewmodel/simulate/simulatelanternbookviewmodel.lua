require("ViewModel/Simulate/Simulate_LanternBookItem")
local this = {
    vm = nil,
    bookUIList={};
    bookItemObj=nil;
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
    ui.goPopRewardPanel = uiLink:Get("goPopRewardPanel");
    ui.txtBookPro = uiLink:Get("txtBookPro"):GetComponent("Text");
    ui.txtTaskDes = uiLink:Get("txtTaskDes"):GetComponent("Text");
    ui.txtTaskPro = uiLink:Get("txtTaskPro"):GetComponent("Text");
    ui.btnReward = uiLink:Get("btnReward"):GetComponent("Button");
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    ui.tranRewardList = uiLink:Get("tranRewardList"):GetComponent("RectTransform");
    ui.slider = uiLink:Get("slider"):GetComponent("Slider");
    ui.imgSlider = uiLink:Get("imgSlider"):GetComponent("Image");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end



this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnReward",function()
       this.SetTaskRewardPanel();
    end)
    uiLink:AddClickEvent("btnMask",function()
       SetActive(ui.goPopRewardPanel,false)
    end)
  
end

local data = {
  
}
local command = {

}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        print("before_awake");
        this.InitUI(vm.behaviour);
        this.bookUIList=UIListView.New(ui.tranContent)
        this.bookItemObj=vm.behaviour.transform:Find("template/bookItem").gameObject;
        this.rewardItemDic={}
        this.animator=vm.behaviour.transform:Find("root"):GetComponent("Animator");
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.bookList={}
            for i,v in pairs(ConfigMgr.Config.SimulateHandBookMap) do
                table.insert(this.bookList,v);
            end
            table.sort(this.bookList,function(a, b) return tonumber(a.Id)<tonumber(b.Id) end)
            SetActive(ui.goPopRewardPanel,false);
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        this.bookUIList:Clear();
    end,
    before_destroy = function()
        this.ClearUI()
        UIListView.ClearItem("Simulate_LanternBookItem")
    end
}

this.ParseData=function()
    this.dataQuest=DataMgr.Player.quests;
    this.SetBookUIList();
end

    

this.SetBookUIList=function()
    this.bookUIList:Clear();
    local list={}
    local proCount=0;
    for i,v in ipairs(this.bookList) do
        local bookItem={
            iconName=v.Icon,
            isUnLock=SimulateRoomMgr.CheckLanternTypeUnLock(v.Id),
            name=LuaMgr.GetLangText(v.NameLan),
            isSpecial=v.IsSpecial>0;
        }
        if bookItem.isUnLock then
            proCount=proCount+1;
        end
        local bookData=UIListData.GetData(this.bookItemObj,"Simulate_LanternBookItem",bookItem);
        table.insert(list,bookData);
    end
    this.bookUIList:SetData(list);
    ui.txtBookPro.text=string.format("%s/%s",proCount,#this.bookList);

    local questList=DataExHelper.Check_ConfigQuestEventByText("XCRW")
    this.rewardIds={};
    this.curQuestTask=nil;
    for i,v in ipairs(questList) do
        if this.dataQuest[v.id]~=nil and this.dataQuest[v.id].state==2 then
            table.insert(this.rewardIds,v.id);
        end
        if this.curQuestTask==nil and  (this.dataQuest[v.id]==nil or this.dataQuest[v.id].state==1) then
            this.curQuestTask=v;
        end
    end
    if #this.rewardIds>0 then
        this.animator:Play("ani_SimulateLanternBookPanel_root_002");
    end
end

this.SetTaskRewardPanel=function()
    if #this.rewardIds>0 then
        DataExHelper.EX_GetAwards(this.rewardIds,function()
            this.ParseData();
        end)
        return;
    end
    if this.curQuestTask==nil then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SimulateLanternBookViewModel_0"));
        return;
    end
    this.ShowRewardInfo();
end

this.ShowRewardInfo=function()
    if this.curQuestTask==nil then
        SetActive(ui.goPopRewardPanel,false);
        return 
    end;
    SetActive(ui.goPopRewardPanel,true);
    this.animator:Play("ani_SimulateLanternBookPanel_root_001");
    ui.txtTaskDes.text=LuaMgr.GetLangText(this.curQuestTask.remarksLan)
    local curPro=0;
    if this.dataQuest[this.curQuestTask.id]~=nil then
        curPro=this.dataQuest[this.curQuestTask.id].progress;
    end
    ui.txtTaskPro.text=string.format("%s/%s",curPro,this.curQuestTask.progress)
    ui.imgSlider.fillAmount=curPro/this.curQuestTask.progress;

    for i,v in ipairs(this.curQuestTask.showReward) do
        if this.rewardItemDic[tostring(i)]==nil then
            this.rewardItemDic[tostring(i)]=GoodsDataItem.New(ui.tranRewardList);
        end
        local itemConfig = table.Copy(ConfigMgr.Config.itemMap[v.id])
        itemConfig["count0"] = v.count
        this.rewardItemDic[tostring(i)]:SetData(i,itemConfig,1,false,Vector3(0.5,0.5,0.5),false,true)
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})