





require("ViewModel/Activity/TiXingBoHua_CheckInItem")


local this = {vm=nil,
              checkInItemObj=nil,
              checkInUIList=nil,
              

};

local curQuest=nil;
local dataQuest=nil;
local curIndex=nil;

local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Middle = nil;
local goTypeTwo = nil;
local goTypeOne = nil;
local Left = nil;
local Right = nil;
local textTime = nil;
local textTag = nil;
local textDes = nil;
local imgTypeTwo1 = nil;
local imgTypeTwo2 = nil;
local imgTypeOne = nil;
local scroll = nil;
local scrollView = nil;
local ScrollbarVertical = nil;
local tranContent = nil;
local textName=nil;
local goTag=nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Middle = uiLink:Get("Middle");
    goTypeTwo = uiLink:Get("goTypeTwo");
    goTypeOne = uiLink:Get("goTypeOne");
    Left = uiLink:Get("Left");
    Right = uiLink:Get("Right");
    textTime = uiLink:Get("textTime"):GetComponent("Text");
    textTag = uiLink:Get("textTag"):GetComponent("Text");
    imgTypeTwo1 = uiLink:Get("imgTypeTwo1"):GetComponent("Image");
    imgTypeTwo2 = uiLink:Get("imgTypeTwo2"):GetComponent("Image");
    imgTypeOne = uiLink:Get("imgTypeOne"):GetComponent("Image");
    scroll = uiLink:Get("scroll"):GetComponent("ScrollRect");
    scrollView = uiLink:Get("scrollView"):GetComponent("ScrollRect");
    ScrollbarVertical = uiLink:Get("ScrollbarVertical"):GetComponent("ScrollRect");
    textDes = uiLink:Get("textDes"):GetComponent("UIText");
    tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    textName=uiLink:Get("textName"):GetComponent("Text");
    goTag=uiLink:Get("goTag");
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Middle = nil;
    goTypeTwo = nil;
    goTypeOne = nil;
    Left = nil;
    Right = nil;
    textTime = nil;
    textTag = nil;
    textDes = nil;
    imgTypeTwo1 = nil;
    imgTypeTwo2 = nil;
    imgTypeOne = nil;
    scroll = nil;
    scrollView = nil;
    ScrollbarVertical = nil;
    tranContent = nil;
    textName=nil;
    goTag=nil;
end


local data = {
 
}


local command = {
    
}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour);
        this.checkInItemObj=vm.behaviour.transform:Find("template/checkItem").gameObject;
        this.checkInUIList=UIListView.New(tranContent)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            curQuest=DataExHelper.Check_ConfigQuestEventByText("checkIn7Txingbohua")
            table.sort(curQuest,function(a,b) return a.id<b.id  end)
            curIndex=nil;
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        if vm.behaviour.Params == nil then return end;
        UIListView.ClearItem("TiXingBoHua_CheckInItem")
    end,
}

this.CheckInCallBack=function(index)
    local item=curQuest[index]
    if curIndex==index or dataQuest[item.id].state==1 then
        return
    end
    curIndex=index;
    for i,v in ipairs(this.checkInUIList.itemList) do
        v:SelectState(i==index);
    end
    if dataQuest[item.id].state==2 then
        DataExHelper.EX_GetAward(item.id,function()
            this.ParseData();
            HeroRedDataHelper.SetTiXingBoHuaRed();
            RedMgr.Singleton:RefreshOtherViewModel(UIName.ActivityOnViewModel);
        end)
    else
        this.ShowKuPu();
    end
    
end


this.ParseData=function()
    dataQuest=DataMgr.Player.quests;
    this.SetTimer();
    this.SetCheckInList(true);
end



this.SetCheckInList=function()
    local locIndex=nil;
    local checkInList={}
    for i,v in ipairs(curQuest) do
        local state=dataQuest[v.id]==nil and 0 or dataQuest[v.id].state;
        if curIndex==nil and state==3 then
            locIndex=i;
        end
        local dayItem={
            checkInState=state,
            index=i,
            callBack=this.CheckInCallBack,
            showReward=v.reward[1];
        }
        local dayData=UIListData.GetData(this.checkInItemObj,"TiXingBoHua_CheckInItem",dayItem);
        table.insert(checkInList,dayData)
    end
    this.checkInUIList:SetData(checkInList);
    if curIndex==nil then
        curIndex=locIndex;
    end
    if curIndex~=nil then
        this.checkInUIList.itemList[curIndex]:SelectState(true);
    end
    this.ShowKuPu()
end


this.SetTimer=function()
    textTag.text=ConfigMgr.LangGlobal("15715")
    local variables=DataExHelper.GetDataExByTag(ActivityKey.tixingbohua)
    local remainTime=variables.expireTime-LuaMgr.Timestamp();
    if remainTime<0 then remainTime=0 end;
    local d, h, m = GetTimeDHM(remainTime);
    if IsNullOrEmpty(d) then
        d="0";
    end
    textTime.text=string.format(ConfigMgr.LangGlobal("15506"),d,h,m);
end

this.ShowKuPu=function()
    local index=curIndex==nil and 1 or curIndex;
    textDes.text=LuaMgr.GetLangText(curQuest[index].remarksLan)
    textName.text=LuaMgr.GetLangText(curQuest[index].namelan)
    SetActive(goTypeOne,true);
    SetActive(goTypeTwo,false);
    SetActive(goTag,index%2==0);

    imgTypeOne.sprite=LuaMgr.GetSprite("TiXingBoHua","ui_hd_qd_t_tp_"..index)




end


return vm({
    data = data,
    command = command,
    hook = hook
})