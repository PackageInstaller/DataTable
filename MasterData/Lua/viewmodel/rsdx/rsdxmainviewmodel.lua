require("ViewModel/RSDX/RSDX_EventItem")

local this =
{
    medalActivityID = "31101",
    tagList={"fs","jq","xyx","zx","gn"},
    eventUIList={},
    eventItemObj=nil;
};

local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Left = uiLink:Get("Left");
    ui.Middle = uiLink:Get("Middle");
    ui.goBody = uiLink:Get("goBody");
    ui.goDialog = uiLink:Get("goDialog");
    ui.goMsgBg = uiLink:Get("goMsgBg");
    ui.goPro = uiLink:Get("goPro");
    ui.goPopUp = uiLink:Get("goPopUp");
    ui.btnPhase = uiLink:Get("btnPhase"):GetComponent("Button");
    ui.btnShop = uiLink:Get("btnShop"):GetComponent("Button");
    ui.btnRSDX1 = uiLink:Get("btnRSDX1"):GetComponent("Button");
    ui.btnRSDX2 = uiLink:Get("btnRSDX2"):GetComponent("Button");
    ui.btnRSDX3 = uiLink:Get("btnRSDX3"):GetComponent("Button");
    ui.btnRSDX4 = uiLink:Get("btnRSDX4"):GetComponent("Button");
    ui.btnRSDX5 = uiLink:Get("btnRSDX5"):GetComponent("Button");
    ui.btnReward = uiLink:Get("btnReward"):GetComponent("Button");
    ui.btnMsgContinue = uiLink:Get("btnMsgContinue"):GetComponent("Button");
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.txtCollectCount = uiLink:Get("txtCollectCount"):GetComponent("Text");
    ui.text = uiLink:Get("text"):GetComponent("Text");
    ui.txtTime = uiLink:Get("txtTime"):GetComponent("Text");
    ui.txtMsg = uiLink:Get("txtMsg"):GetComponent("Text");
    ui.txtPro = uiLink:Get("txtPro"):GetComponent("Text");
    ui.tranBody3 = uiLink:Get("tranBody3"):GetComponent("RectTransform");
    ui.tranBody3hand = uiLink:Get("tranBody3hand"):GetComponent("RectTransform");
    ui.tranMsgBg = uiLink:Get("tranMsgBg"):GetComponent("RectTransform");
    ui.tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnPhase",this.BtnPhaseExecute);
    uiLink:AddClickEvent("btnShop",this.BtnShopExecute);
    uiLink:AddClickEvent("btnReward",function()
        SetActive(ui.goDialog,true);
        SetActive(ui.goPro,false);
        SetActive(ui.btnReward.gameObject,false);
        SetActive(ui.goBody,true);
        this.SetDialog();
    end);
    uiLink:AddClickEvent("btnMsgContinue",function()
        this.SetDialogContinue();
    end);
    uiLink:AddClickEvent("btnMask",function()
        SetActive(ui.goPopUp,false);
        RSDXMgr.typeIndex=nil;
    end);
    uiLink:AddClickEvent("btnRSDX1",function()
        this.BtnRSDXExecute(1);
    end);
    uiLink:AddClickEvent("btnRSDX2",function()
        this.BtnRSDXExecute(2);
    end);
    uiLink:AddClickEvent("btnRSDX3",function()
        this.BtnRSDXExecute(3);
    end);
    uiLink:AddClickEvent("btnRSDX4",function()
        this.BtnRSDXExecute(4);
    end);
    uiLink:AddClickEvent("btnRSDX5",function()
        this.BtnRSDXExecute(5);
    end);
end



this.BtnPhaseExecute = function()
    if RSDXMgr.CheckActiveIsRunning() then
        local data = {}
        data.medalActivityID = this.medalActivityID
        data.medalColor = "#3d6053"
        data.medalImgKey = "ui_hd_ty_dtyl_bt_rsdx"
        data.bgmPath = ""
        LuaMgr.ShowLuaPanel(UIName.PassesMain2ViewModel, data);
    end
end


this.BtnShopExecute = function()
    if RSDXMgr.CheckActiveIsRunning() then
        LuaMgr.ShowLuaPanel(UIName.RSDXShopViewModel);
    end
end

this.BtnRSDXExecute=function(type)
    this.SetEventUIList(type);
end

local data = {
    rsdxArea={
        {name="",isOn=false,isVFX=false},
        {name="",isOn=false,isVFX=false},
        {name="",isOn=false,isVFX=false},
        {name="",isOn=false,isVFX=false},
        {name="",isOn=false,isVFX=false},
    },
    buildTaskProList={false,false,false,false}
}

local command = {}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.InitUI(vm.behaviour);
        this.eventUIList=UIListView.New(ui.tranContent);
        this.eventItemObj=vm.behaviour.transform:Find("template/eventItem").gameObject;
        RedMgr.Singleton:RegisterViewModel(UIName.RSDXMainViewModel);
        this.animator=vm.behaviour.transform:Find("root"):GetComponent("Animator")
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        vm.behaviour:UpdateTopBar("",this.Back);
        RSDXMgr.Init();
        this.typeIndex=nil;
        this.isShowUnLockFX=false;
        HeroRedDataHelper.SetRSDXRed();
        if RSDXMgr.typeIndex~=nil then
            this.typeIndex=RSDXMgr.typeIndex;
            RSDXMgr.typeIndex=nil;
        else
            this.animator:Play("ani_RSDXMainPanel_root",0,0);
        end
        this.ParseData();
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.eventUIList:Clear();
    end,
    before_destroy = function()
        UIListView.ClearItem("RSDX_EventItem");
    end
    
}

this.Back=function()
    if ui.goPopUp.activeInHierarchy then
        SetActive(ui.goPopUp,false)
        return;
    end
    if not DataExHelper.CommonActivityCheck(ActivityKey.RSDX) then
        LuaMgr.Back();
    else
        LuaMgr.Back("RSDX");
    end
end

this.ParseData=function()
    SetActive(ui.goPopUp,false)
    SetActive(ui.goDialog,false);
    SetActive(ui.goPro,true);
    SetActive(ui.btnReward.gameObject,false);
    this.SetBaseInfo();
    if this.typeIndex~=nil and not this.isShowUnLockFX then
        this.SetEventUIList(this.typeIndex);
    end
end

this.CheckAreaIsComplete=function(index)
    local area=RSDXMgr.areaList[index].area;

    this.groupId=RSDXMgr.groupMapList[area][1].id;
    this.eventList=RSDXMgr.eventMapList[this.groupId];
    for i,v in ipairs(this.eventList) do
        if not RSDXMgr.CheckEventIsComplete(v) then
            return false;
        end
    end
    return true;
end

this.SetBaseInfo=function()
    for i,v in ipairs(RSDXMgr.areaList) do
        local isComplete=this.CheckAreaIsComplete(i);
        this.vm.data.rsdxArea[i].name=string.format("·%s·",LuaMgr.GetLangText(v.namelan))
        this.vm.data.rsdxArea[i].isOn=isComplete;
        local key=DataMgr.Player.uid.."RSDX_VFX"..v.area;
        this.vm.data.rsdxArea[i].isVFX=isComplete and PlayerPrefs.GetInt(key)==0;
        if not this.isShowUnLockFX then
            this.isShowUnLockFX=isComplete and PlayerPrefs.GetInt(key)==0
        end
        if isComplete then
            PlayerPrefs.SetInt(key,1);
        end
    end
    local finishMedalCount1 = DataExHelper.GetMedalFinishCount(this.medalActivityID)
    local medalList = DataExHelper.GetMedalList(this.medalActivityID)
    ui.txtCollectCount.text = string.format(LuaMgr.GetLangText("CrisisContract2MainViewModel_0"), finishMedalCount1,
            #medalList)
    local buildTaskState,curProgress,maxProgress=RSDXMgr.GetBuildTaskStateAndProgress();
    for i=1,4 do
        this.vm.data.buildTaskProList[i]=curProgress>=i;
    end
    ui.txtPro.text=string.format(LuaMgr.GetLangText("RSDXMainViewModel_0"),curProgress,maxProgress);
    SetActive(ui.btnReward.gameObject,buildTaskState==2);
    SetActive(ui.goBody,buildTaskState>2);
    ui.txtTime.text=DataExHelper.GetActivityTimeStr(ActivityKey.RSDX)
end

this.SetEventUIList=function(typeIndex)
    this.typeIndex=typeIndex;
    this.eventUIList:Clear();
    local area=RSDXMgr.areaList[typeIndex].area;

    this.groupId=RSDXMgr.groupMapList[area][1].id;
    this.eventList=RSDXMgr.eventMapList[this.groupId];
    if #this.eventList==0 then return end;
    ui.ScrollView.transform.anchoredPosition=#this.eventList>3 and Vector2(0,0) or Vector2(80,0);
    SetActive(ui.goPopUp,true);
    local list={};
    local locIndex=0;
    for i,v in ipairs(this.eventList) do
        local unlock,lockTip=RSDXMgr.CheckEventIsUnLock(v);
        local isComplete=RSDXMgr.CheckEventIsComplete(v)
        if isComplete then
            locIndex=locIndex+1;
        end
        local eventItem={
            index=i,
            type=typeIndex,
            isUnlock=unlock;
            tag=this.tagList[typeIndex];
            passTag=RSDXMgr.GetEventCompleteTag(v);
            name=LuaMgr.GetLangText(v.namelan);
            lockInfo=lockTip~=nil and lockTip or LuaMgr.GetLangText(v.tipslan),
            isRed=RSDXMgr.redEventMap[v.id]~=nil;
            callBack=this.EventCallBack,
        }
        local eventData=UIListData.GetData(this.eventItemObj,"RSDX_EventItem",eventItem);
        table.insert(list,eventData);
    end
    this.eventUIList:SetData(list);
    if locIndex<=3 or locIndex==#list then
        ui.tranContent.anchoredPosition=Vector2(0,0);
    else
        ui.tranContent.anchoredPosition=Vector2(-246*(locIndex-2),0);
    end
end

this.EventCallBack=function(index)
    if not RSDXMgr.CheckActiveIsRunning() then
        return;
    end
    local eventData=this.eventUIList.itemList[index].data;
    if not eventData.isUnlock then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,eventData.lockInfo);
        return;
    end
    local cfgEvent=this.eventList[index];
    RSDXMgr.typeIndex=this.typeIndex;
    local key=DataMgr.Player.uid.."RSDX_"..cfgEvent.id;
    PlayerPrefs.SetInt(key,1);
    if cfgEvent.type==1 then

        LuaMgr.PlayNovel(cfgEvent.eventParam, function()
            LuaMgr.ShowLuaPanel(UIName.RSDXMainViewModel);
        end);
    elseif cfgEvent.type==2 then

        local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
        enterDungeonParams.eventId = cfgEvent.eventParam
        enterDungeonParams.dungeonId = cfgEvent.eventParam
        BattlePrepareMgr.BattlePrepare(enterDungeonParams)
    elseif cfgEvent.type==3 then

        LuaMgr.ShowLuaPanel(UIName.RSDXGamePanel,cfgEvent.eventParam);
    end
end

this.SetDialog=function()
    this.dialogIndex=1;
    this.dialogMsgList={};
    table.insert(this.dialogMsgList,{index=2,msg=ConfigMgr.LangGlobal("31150")})
    table.insert(this.dialogMsgList,{index=3,msg=ConfigMgr.LangGlobal("31151")})
    table.insert(this.dialogMsgList,{index=1,msg=ConfigMgr.LangGlobal("31152")})
    table.insert(this.dialogMsgList,{index=2,msg=ConfigMgr.LangGlobal("31153")})
    this.SetDialogContinue();
end

this.SetMsg=function(msg,bodyIndex)









    ui.txtMsg.text=msg;
    ui.tranMsgBg.sizeDelta=Vector2(180,ui.txtMsg.preferredHeight+40);
end

this.SetDialogContinue=function()
    if this.dialogIndex>#this.dialogMsgList then
        this.OnAskbuildTaskReward();
        return;
    end
    SetActive(ui.goMsgBg,false)
    SetActive(ui.goMsgBg,true);
    local msgInfo=this.dialogMsgList[this.dialogIndex];
    this.SetMsg(msgInfo.msg,msgInfo.index)
    this.dialogIndex=this.dialogIndex+1;
end

this.OnAskbuildTaskReward=function()
    local questId=RSDXMgr.buildTaskList[1].id
    DataExHelper.EX_GetAward(questId,function()
        this.typeIndex=nil;
        this.ParseData();
    end)
end

return vm({
    data = data,
    command = command,
    hook = hook
})