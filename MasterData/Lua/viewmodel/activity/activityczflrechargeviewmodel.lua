require("ViewModel/Activity/CZFLRecharge_RewardItem")
local this = {
    vm = nil,
    rewardUIList={},
    rewardItemObj=nil,
}
local proValue={0.1,0.3,0.5,0.7,0.9}

local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.goods = uiLink:Get("goods");
    ui.Left = uiLink:Get("Left");
    ui.Middle = uiLink:Get("Middle");
    ui.Right = uiLink:Get("Right");
    ui.canvas = uiLink:Get("canvas"):GetComponent("Canvas");
    ui.txtTimer = uiLink:Get("txtTimer"):GetComponent("Text");
    ui.txtSocre = uiLink:Get("txtSocre"):GetComponent("Text");
    ui.sliderScore = uiLink:Get("sliderScore"):GetComponent("Slider");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    ui.btnJump = uiLink:Get("btnJump"):GetComponent("Button");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end

this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnJump",function()
        LuaMgr.ShowLuaPanel(UIName.MainShopViewModel,"charge")
        HeroParameter.SaveActivityKey(ActivityKey.CZFL)
    end)
end

local data = {
}

local command = {
   
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.InitUI(vm.behaviour);
        this.rewardUIList=UIListView.New(ui.tranContent)
        this.rewardItemObj=vm.behaviour.transform:Find("template/rewardItem").gameObject
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.ParseData();
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.rewardUIList:Clear();
    end,
    before_destroy = function(vm)
        this.ClearUI();
        UIListView.ClearItem("CZFLRecharge_RewardItem")
    end,
}

this.ParseData=function()
    this.questList=DataExHelper.Check_ConfigQuestEventByText("CZFLRecharge")
    this.curScore=IsNull(DataMgr.Player.GoodsHoursGoldChargePoint) and 0 or DataMgr.Player.GoodsHoursGoldChargePoint ;
    this.dataQuest=DataMgr.Player.quests;
    this.SetBaseInfo();
    this.SetRewardUIList();
end

this.SetBaseInfo=function()
    local groupId = ActivityMgr.groupKeyList[ActivityKey.CZFL]
    local dataGroup_CZFL = DataMgr.Player.variables[groupId]



    
    local time = dataGroup_CZFL.expireTime - LuaMgr.Timestamp();
    local timeStr = "";
    local d, h, m = GetTimeDHM(time);
    if (not IsNullOrEmpty(d)) then
        timeStr = timeStr .. string.format("<color=#F3F0C9>%s</color>%s", d, ConfigMgr.LangGlobal("10365"));
    end
    if (not IsNullOrEmpty(h)) then
        timeStr = timeStr .. string.format("<color=#F3F0C9>%s</color>%s", h, ConfigMgr.LangGlobal("10366"));
    end
    if (not IsNullOrEmpty(m)) then
        timeStr = timeStr .. string.format("<color=#F3F0C9>%s</color>%s", m, ConfigMgr.LangGlobal("10367"));
    end
    ui.txtTimer.text = timeStr
    ui.txtSocre.text=this.curScore;
end

this.SetRewardUIList=function()
    this.rewardUIList:Clear()
    local list={}
    local proIndex=0;
    for i,v in ipairs(this.questList) do
        local state=this.dataQuest[v.id]==nil and 1 or this.dataQuest[v.id].state
        local quest={
            questId=v.id,
            reward=v.showReward,
            progress=v.progress,
            state=state,
            callBack=this.RewardCallBack,
        }
        if state>1 then
            proIndex=proIndex+1;
        end
        local questData=UIListData.GetData(this.rewardItemObj,"CZFLRecharge_RewardItem",quest);
        table.insert(list,questData);
    end
    this.rewardUIList:SetData(list);
    this.SetSlider(proIndex)
end

this.SetSlider=function(proIndex)
    if proIndex==0 then
        ui.sliderScore.value=0
        return;
    end
    local baseValue=proValue[proIndex];
    local curCfgScore=tonumber(this.questList[proIndex].progress);
    local nextCfgScore=0;
    local nextValue=0;
    if proIndex+1>#this.questList then
        nextCfgScore=5000;
        nextValue=1.0
    else
        nextCfgScore=tonumber(this.questList[proIndex+1].progress);
        nextValue=proValue[proIndex+1]
    end
    local stepValue=(this.curScore-curCfgScore)/(nextCfgScore-curCfgScore)
    ui.sliderScore.value=baseValue+(nextValue-baseValue)*stepValue;
end

this.RewardCallBack=function(questId)
    if not IsNullOrEmpty(questId) then
        DataExHelper.EX_GetAward(questId,function()
            this.ParseData();
            HeroRedDataHelper.SetCZFLRechargeRed();
        end)
    end
end


return vm({
    data = data,
    command = command,
    hook = hook
})