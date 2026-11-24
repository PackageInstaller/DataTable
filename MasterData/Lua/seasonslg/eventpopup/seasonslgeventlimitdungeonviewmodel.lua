require("SeasonSLG/EventPopUp/EventTimeRewardItem")
local this = {
   rewardUIList={};
   rewardItemObj=nil;
};

local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.goods = uiLink:Get("goods");
    ui.Middle = uiLink:Get("Middle");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.goProgress = uiLink:Get("goProgress");
    ui.goActiveSelf = uiLink:Get("goActiveSelf");
    ui.goActiveAll = uiLink:Get("goActiveAll");
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.btnHelp = uiLink:Get("btnHelp"):GetComponent("Button");
    ui.btnSelf = uiLink:Get("btnSelf"):GetComponent("Button");
    ui.btnAll = uiLink:Get("btnAll"):GetComponent("Button");
    ui.btnBattle = uiLink:Get("btnBattle"):GetComponent("Button");
    ui.txtTitle = uiLink:Get("txtTitle"):GetComponent("Text");
    ui.txtDes = uiLink:Get("txtDes"):GetComponent("Text");
    ui.txtProgressValue = uiLink:Get("txtProgressValue"):GetComponent("Text");
    ui.txtRewardDes = uiLink:Get("txtRewardDes"):GetComponent("Text");
    ui.txtRewardDes1 = uiLink:Get("txtRewardDes1"):GetComponent("Text");
    ui.txtCostCount = uiLink:Get("txtCostCount"):GetComponent("Text");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.imgProgress = uiLink:Get("imgProgress"):GetComponent("Image");
    ui.tranRewardContent = uiLink:Get("tranRewardContent"):GetComponent("RectTransform");
    ui.rawCostIcon = uiLink:Get("rawCostIcon"):GetComponent("RawImage");
    ui.txtLocation=uiLink:Get("txtLocation"):GetComponent("Text");
    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end

this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnMask",function()
        LuaMgr.HidePanel(UIName.SeasonSlGEventLimitDungeonViewModel)
    end)
    uiLink:AddClickEvent("btnHelp",function()
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventLimitDungeonViewModel_0"))
    end)
    uiLink:AddClickEvent("btnSelf",function()
        this.SwitchRewardType(1)
    end)
    uiLink:AddClickEvent("btnAll",function()
        this.SwitchRewardType(2)
    end)
    uiLink:AddClickEvent("btnBattle",function()
        LuaMgr.HidePanel(UIName.SeasonSlGEventLimitDungeonViewModel)
        LuaMgr.ShowLuaPanel(UIName.ActivityBattlePrepareViewModel, ActivityKey.SeasonSLG,this.worldDungeonId,this.eventType, SeasonSLGEventMgr.curGridIndex,"timed",this.cfgWorldDungeon.DungeonId)
    end)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.InitUI(vm.behaviour)
        this.rewardUIList=UIListView.New(ui.tranRewardContent);
        this.rewardItemObj=vm.behaviour.transform:Find("template/rewardItem").gameObject;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length>1 then
            this.eventType=vm.behaviour.Params[0]
            this.worldDungeonId=vm.behaviour.Params[1]
            this.cfgWorldDungeon=ConfigMgr.Config.SeasonalGridWorldDungeonMap[this.worldDungeonId];
            local isUnLock = SeasonSLGMapMgr.CheckBlockEventsIsComplete(SeasonSLGEventMgr.curGridIndex)
            if not isUnLock then
                SetActive(ui.goProgress,true)
                this.fullProgress=vm.behaviour.Params[2].Progress or 0;
                this.SetProgress()
            else
                SetActive(ui.goProgress,false)
                this.progressRate = 0;
            end

            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.rewardUIList:Clear();
        UIListView.ClearItem("EventTimeRewardItem")
        this.rewardType=nil;
    end,
    before_destroy = function()
        this.ClearUI();
    end
}

this.ParseData=function()
    ui.txtTitle.text=ConfigMgr.LangGlobal(this.cfgWorldDungeon.Name);
    ui.txtDes.text=ConfigMgr.LangGlobal(this.cfgWorldDungeon.GridDesc);
    local des=this.cfgWorldDungeon.Type==0 and LuaMgr.GetLangText("SeasonSlGEventLimitDungeonViewModel_1") or LuaMgr.GetLangText("SeasonSlGEventLimitDungeonViewModel_2")
    ui.txtRewardDes.text=des;
    ui.txtRewardDes1.text=des;
    ui.txtLocation.text=SeasonSLGMapMgr.GetLocationPositionStr(SeasonSLGEventMgr.curGridIndex)
    this.dataTimeEvent=DataMgr.Player.SeasonalTimedEvent[tostring(SeasonSLGEventMgr.curGridIndex)]




    this.SwitchRewardType(1)

end

this.SetProgress = function()
    this.progressRate=this.fullProgress/this.cfgWorldDungeon.Progress
    ui.txtProgressValue.text=string.format("%.2f%%",this.progressRate*100);
    ui.imgProgress.fillAmount=this.progressRate;
end

this.SwitchRewardType=function(index)
    if this.rewardType~=nil and this.rewardType==index then
        return;
    end
    SetActive(ui.goActiveSelf,index==1);
    SetActive(ui.goActiveAll,index==2);
    this.rewardList=index==1 and this.cfgWorldDungeon.PersonalReward or this.cfgWorldDungeon.Reward;
    this.isComplete=false;
    if index==1 then
        this.isComplete=DataHelper.CheckDungeonComplete(this.cfgWorldDungeon.DungeonId);
        SetActive(ui.btnBattle.gameObject,not this.isComplete);
    else
        local key=string.format("%s_%s_%s","seasonal_world_dungeon_progress",SeasonSLGEventMgr.curGridIndex,this.cfgWorldDungeon.Id)
        this.isComplete=SeasonSLGEventMgr.CheckLimitEventRewardIsComplete(key);
        if not this.isComplete and this.progressRate>=1 then
            SeasonSLGAPI.OnAskTimeEventDungeonReward(tostring(SeasonSLGEventMgr.curGridIndex),this.cfgWorldDungeon.Id,function()
                this.ParseData();
            end)
        end
    end
    this.SetRewardUIList();
end

this.SetRewardUIList=function()
    this.rewardUIList:Clear();
    local list={};
    for i,v in ipairs(this.rewardList) do
        local rewardItem={
            item=v,
            isComplete=this.isComplete
        }
        local rewardData=UIListData.GetData(this.rewardItemObj,"EventTimeRewardItem",rewardItem);
        table.insert(list,rewardData);
    end
    this.rewardUIList:SetData(list);
end


return vm({
    data = data,
    command = command,
    hook = hook
})