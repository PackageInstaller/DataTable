require("ViewModel/Simulate/Simulate_BlessingPrayItem")
require("ViewModel/Simulate/Simulate_BlessingListRewardItem")
local this = {
    vm = nil,
    blessUIList={};
    blessItemObj=nil;
    rewardUIList={};
    rewardItemObj=nil;
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
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    ui.tranGoods = uiLink:Get("tranGoods"):GetComponent("RectTransform");
    ui.txtLikeCount = uiLink:Get("txtLikeCount"):GetComponent("Text");
    ui.btnBless = uiLink:Get("btnBless"):GetComponent("Button");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end

this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnBless",function()
        LuaMgr.ShowLuaPanel(UIName.SimulateBlessingViewModel)
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
        this.InitUI(vm.behaviour)
        this.blessUIList=UIListView.New(ui.tranContent)
        this.blessItemObj=vm.behaviour.transform:Find("template/blessItem").gameObject;
        this.rewardUIList=UIListView.New(ui.tranGoods);
        this.rewardItemObj=vm.behaviour.transform:Find("template/rewardItem").gameObject;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.blessList=SimulateRoomMgr.BlessList;
            this.maxLikeCount=ConfigMgr.Config.SimulateConstants.SimulatePrayLikeLimit;
            this.likeRewards=ConfigMgr.Config.SimulateConstants.SimulatePrayLikeReward;
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        this.blessUIList:Clear();
        this.rewardUIList:Clear();
    end,
    before_destroy = function()
        this.ClearUI()
        UIListView.ClearItem("Simulate_BlessingPrayItem")
        UIListView.ClearItem("Simulate_BlessingListRewardItem")
    end
}


this.ParseData=function()
    this.dataSimulatePray=DataMgr.Player.SimulatePray;
    this.triggerAddLikeCount=SimulateRoomMgr.CheckTriggerAddLikeCount();
    ui.txtLikeCount.text= string.format(LuaMgr.GetLangText("SimulateBlessingListViewModel_0"),this.dataSimulatePray.DailyLikeLimit,this.maxLikeCount+this.triggerAddLikeCount)
    this.SetBlessUIList();
    this.SetLikeReward();
end

this.SetBlessUIList=function()
    this.blessUIList:Clear();
    local list={}
    for i,v in ipairs(this.blessList) do
        local blessItem={
            index=i,
            likeCount=v.LikeCount,
            isLike=v.Like,
            isMy=v.UID==DataMgr.Player.uid,
            name=v.Name,
            prayList=v.Pray;
            callBack=this.BlessCallBack,
        }
        local blessData=UIListData.GetData(this.blessItemObj,"Simulate_BlessingPrayItem",blessItem);
        table.insert(list,blessData);
    end
    this.blessUIList:SetData(list);
end

this.BlessCallBack=function(index)
    local bless=this.blessList[index]
    if bless.Like then
        return;
    end
    if this.dataSimulatePray.DailyLikeLimit>=this.maxLikeCount+this.triggerAddLikeCount then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SimulateBlessingListViewModel_1"));
        return;
    end
    SimulateRoomMgr.OnAskOnAskBlessingPrayLike(bless.UID,function(list)
        this.blessList=list;
        this.ParseData();
    end)
end


this.SetLikeReward=function()
    this.rewardUIList:Clear();
    local list={}
    for i,v in ipairs(this.likeRewards) do
        local item={
            item=v,
            isGet=this.dataSimulatePray.DailyLikeLimit>=this.maxLikeCount+this.triggerAddLikeCount;
        }
        local itemData=UIListData.GetData(this.rewardItemObj,"Simulate_BlessingListRewardItem",item);
        table.insert(list,itemData);
    end
    this.rewardUIList:SetData(list);
end
    



return vm({
    data = data,
    command = command,
    hook = hook
})