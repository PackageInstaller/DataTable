





require("ViewModel/Activity/JinYuZhuRi_CheckInItem")


local this = {vm=nil,
              checkInItemObj=nil,
              checkInUIList=nil,
              

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
    ui.textName = uiLink:Get("textName"):GetComponent("Text");
    ui.textDes = uiLink:Get("textDes"):GetComponent("Text");
    ui.textTime = uiLink:Get("textTime"):GetComponent("Text");
    ui.imgTypeOne = uiLink:Get("imgTypeOne"):GetComponent("Image");
    ui.scrollView = uiLink:Get("scrollView"):GetComponent("ScrollRect");
    ui.ScrollbarVertical = uiLink:Get("ScrollbarVertical"):GetComponent("ScrollRect");
    ui.textDes = uiLink:Get("textDes"):GetComponent("UIText");
    ui.tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end



this.AddRegister=function(uiLink)
    
end

local data = {
 
}


local command = {
    
}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.InitUI(vm.behaviour);
        this.checkInItemObj=vm.behaviour.transform:Find("template/checkItem").gameObject;
        this.checkInUIList=UIListView.New(ui.tranContent)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.questList=DataExHelper.Check_ConfigQuestEventByText("checkIn7JinSha")
            this.curIndex=nil;
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        if vm.behaviour.Params == nil then return end;
        this.checkInUIList:Clear();
    end,
    before_destroy=function()
        UIListView.ClearItem("JinYuZhuRi_CheckInItem")
    end
}

this.CheckInCallBack=function(index)
    local item=this.questList[index]
    if this.questList==index or this.dataQuest[item.id].state==1 then
        return
    end
    this.curIndex=index;
    for i,v in ipairs(this.checkInUIList.itemList) do
        v:SelectState(i==index);
    end
    if this.dataQuest[item.id].state==2 then
        DataExHelper.EX_GetAward(item.id,function()
            this.ParseData();
            HeroRedDataHelper.SetJinYuZhuRiRed();
            RedMgr.Singleton:RefreshOtherViewModel(UIName.ActivityOnViewModel);
        end)
    else
        this.ShowKuPu();
    end
    
end


this.ParseData=function()
    this.dataQuest=DataMgr.Player.quests;
    this.SetTimer();
    this.SetCheckInList();
end



this.SetCheckInList=function()
    local locIndex=nil;
    local checkInList={}
    for i,v in ipairs(this.questList) do
        local state=this.dataQuest[v.id]==nil and 0 or this.dataQuest[v.id].state;
        if this.curIndex==nil and state==3 then
            locIndex=i;
        end
        local dayItem={
            checkInState=state,
            index=i,
            callBack=this.CheckInCallBack,
            showReward=v.reward[1];
        }
        local dayData=UIListData.GetData(this.checkInItemObj,"JinYuZhuRi_CheckInItem",dayItem);
        table.insert(checkInList,dayData)
    end
    this.checkInUIList:SetData(checkInList);
    if this.curIndex==nil then
        this.curIndex=locIndex;
    end
    if this.curIndex~=nil then
        this.checkInUIList.itemList[this.curIndex]:SelectState(true);
    end
    this.ShowKuPu()
end


this.SetTimer=function()
    local variables=DataExHelper.GetDataExByTag(ActivityKey.JYZR)
    local remainTime=variables.expireTime-LuaMgr.Timestamp();
    if remainTime<0 then remainTime=0 end;
    local d, h, m = GetTimeDHM(remainTime);
    if IsNullOrEmpty(d) then
        d="0";
    end
    ui.textTime.text=string.format(ConfigMgr.LangGlobal("15506"),d,h,m);
end

this.ShowKuPu=function()
    local index=this.curIndex==nil and 1 or this.curIndex;
    ui.textDes.text=LuaMgr.GetLangText(this.questList[index].remarksLan)
    ui.textName.text=LuaMgr.GetLangText(this.questList[index].namelan)
    ui.imgTypeOne.sprite=LuaMgr.GetSprite("JinYuZhuRi",this.questList[index].parameter)
end


return vm({
    data = data,
    command = command,
    hook = hook
})