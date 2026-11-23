





require("ViewModel/WalkMount/WalkMount_RewardGroup")
local this = {
    vm=nil,
    scrollList=nil,
    rewardGroupItemObj=nil,
    rewardItemObj=nil;
    
};

local mountIds={"9000","9001","9002","9003"}
local bigRewardId="9004"
local dataLottery=nil;
local cfgLotteryActivityMap=nil;
local cfgLotteryMap=nil;
local bigReward=nil;

local tarGameObject = nil;
local tarRect = nil;
local goods = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local goReward = nil;
local Right = nil;
local btnMask = nil;
local btnClose = nil;
local tranScrollView = nil;
local tranContent = nil;
local tranGoods = nil;
local ScrollbarVertical = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    goods = uiLink:Get("goods");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    goReward = uiLink:Get("goReward");
    Right = uiLink:Get("Right");
    btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    btnClose = uiLink:Get("btnClose"):GetComponent("Button");
    tranScrollView = uiLink:Get("tranScrollView"):GetComponent("RectTransform");
    tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    tranGoods = uiLink:Get("tranGoods"):GetComponent("RectTransform");
    ScrollbarVertical = uiLink:Get("ScrollbarVertical"):GetComponent("ScrollRect");
    uiLink:AddClickEvent("btnMask",function()
        LuaMgr.HidePanel(UIName.WalkMountRewardsViewModel)
    end);
    uiLink:AddClickEvent("btnClose",function()
        LuaMgr.HidePanel(UIName.WalkMountRewardsViewModel)
    end);
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    goods = nil;
    root = nil;
    Left = nil;
    Middle = nil;
    goReward = nil;
    Right = nil;
    btnMask = nil;
    btnClose = nil;
    tranScrollView = nil;
    tranContent = nil;
    tranGoods = nil;
    ScrollbarVertical = nil;

end


local data = {
}


local command = {
}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
        this.rewardGroupItemObj=vm.behaviour.transform:Find("template/rewardGroup").gameObject;
        this.rewardItemObj=vm.behaviour.transform:Find("template/rewardItem").gameObject;
        this.scrollList = UIScrollView.New(tranScrollView)
      
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            cfgLotteryActivityMap=ConfigMgr.Config.LotteryActivityMap;
            cfgLotteryMap=ConfigMgr.Config.LotteryMap;
            this.ParseData()
        end
    end,
    before_deactive = function(vm)
        UIScrollView.ClearItem("WalkMount_RewardGroup")
        this.scrollList:Clear();
    end,
    before_destroy=function()
        UIScrollView.ClearItem("WalkMount_RewardGroup")
    end
        
    
}

this.ParseData=function()
    dataLottery=DataMgr.Player.lottery;
    this.SetRewardList()
    this.SetBigReward();
end

this.SetRewardList=function()
    local rewardGroutList={}
    for i,v in ipairs(mountIds) do
        local lotActMap=cfgLotteryActivityMap[v];
        local rewardGroupItem={
            type=v,
            title=LuaMgr.GetLangText(lotActMap.NameLan),
            content=lotActMap.Content,
            rewardItemObj=this.rewardItemObj
        }
        local height=28+68*#lotActMap.Consume
        local itemData=UIScrollData.GetData(this.rewardGroupItemObj,"WalkMount_RewardGroup",388,height,rewardGroupItem);
        table.insert(rewardGroutList,itemData);
    end
    this.scrollList:SetParams(390,390)
    this.scrollList:SetData(rewardGroutList,false);
    this.scrollList.content.anchoredPosition=Vector2(0,0)
end

this.SetBigReward=function()
    if bigReward==nil then
        bigReward=GoodsDataItem.New(tranGoods)
    end
    local lotteryId=cfgLotteryActivityMap[bigRewardId].Content[1]
    local reward=cfgLotteryMap[lotteryId].Reward[1]
    local isRe=false;
    if(dataLottery[bigRewardId]~=nil and #dataLottery[bigRewardId]>0) then
        for i,v in ipairs(dataLottery[bigRewardId]) do
            if v==lotteryId then
                isRe=true;
                break
            end
        end
    end
    local itemConfig = ConfigMgr.Config.itemMap[reward.id]
    itemConfig["count0"] = reward.count
    bigReward:SetData(1,itemConfig,1,false,Vector3(0.6,0.6,0.6),false)
    SetActive(goReward,isRe)
    
end



return vm({
    data = data,
    command = command,
    hook = hook
})