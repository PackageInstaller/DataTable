require("Voyage/VoyageRewardItem")
require("Voyage/VoyageRewardGoodsItem")

local this = {
    rewardList = nil,
    questList = nil,
    itemList = nil,
    itemPos = Vector3(0,0,0),
};

local objs = {
    animator = { path = "root", type = "UIAnimator" },
    maskBtn = { path = "root/Mask", type = "Button" },
    reward1 = { path = "root/Middle/Rewards/Reward1", type = "GameObject" },
    reward2 = { path = "root/Middle/Rewards/Reward2", type = "GameObject" },
    reward3 = { path = "root/Middle/Rewards/Reward3", type = "GameObject" },
    reward4 = { path = "root/Middle/Rewards/Reward4", type = "GameObject" },
    reward5 = { path = "root/Middle/Rewards/Reward5", type = "GameObject" },
    reward6 = { path = "root/Middle/Rewards/Reward6", type = "GameObject" },
    goodsItem = { path = "template/GoodsItem", type = "GameObject" },
    rewardsTF = { path = "root/Middle/Rewards", type = "RectTransform" },
    itemsGO = { path = "root/Middle/Rewards/Items", type = "GameObject" },
    itemsTF = { path = "root/Middle/Rewards/Items", type = "Transform" },
    itemsListTF = { path = "root/Middle/Rewards/Items/List", type = "Transform" },
};


this.SetData = function()
    this.SetRewards();
    SetActive(this.itemsGO, false);
end


this.InitRewards = function()
    this.rewardList = {};
    for i = 1, 6 do
        this.rewardList[i] = VoyageRewardItem.New(this["reward" .. i]);
    end
    this.questList = ConfigVoyageMgr.GetMoneyQuestList();
end


this.DestroyRewards = function()
    if (this.rewardList ~= nil) then
        local len = #this.rewardList;
        for i = 1, len do
            this.rewardList[i]:Destroy();
        end
        this.rewardList = nil;
    end
end


this.SetRewards = function()
    if (this.rewardList ~= nil) then
        local len = #this.rewardList;
        for i = 1, len do
            this.rewardList[i]:SetData(this.questList[i]);
        end
    end
end


this.SetItems = function(rewardItems)
    this.itemList:Clear();
    local listData;
    local listDatas = {};
    local len = #rewardItems;
    for i = 1, len do
        listData = UIListData.GetData(this.goodsItem, "VoyageRewardGoodsItem", rewardItems[i]);
        table.insert(listDatas, listData);
    end
    this.itemList:SetData(listDatas);
    SetActive(this.itemsGO, true);
end


this.OnClickMask = function()
    LuaMgr.HidePanel(UIName.VoyageRewardsViewModel);
end


this.OnClickReward = function(args)
    local item = args[0];
    local questData = PlayerVoyageMgr.GetQuestData(item.data.QuestID);
    if (questData == nil) then return end 
    
    if (questData.Status == 1) then
        PlayerVoyageMgr.GetQuestionReward(item.data.QuestID, this.OnRewardResponse);
        SetActive(this.itemsGO, false);
        return;
    end
    VoyageRewardGoodsItem.status = questData.Status ~= 0;
    this.SetItems(item.data.RewardItems);
    local pos = RectTransformTool.ToContainer(item.transform, this.rewardsTF, LuaMgr.UICamera());
    this.itemPos.x = pos.x;
    this.itemPos.y = pos.y + 100;
    this.itemsTF.localPosition = this.itemPos;
end


this.OnRewardResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        local reward = json.encode(data.result.Rewards);
        LuaMgr.ShowItemRewared(reward);
        this.SetRewards();
    end
end


this.OnAnimatorPlayFinish = function(args)
    LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAnimatorPlayFinish);
    this.animator.Loop = true;
    this.animator.AnimationName = "ani_VoyageRewardsPanel_root_loop";
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.InitRewards();
        this.itemList = UIListView.New(this.itemsListTF);
        LuaMgr.AddClick(this.maskBtn, this.OnClickMask);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        LuaMgr.AddUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAnimatorPlayFinish);
        LuaMgr.AddUIEventListener(UIEventConst.VoyageRewardsClickItem, this.OnClickReward);
        this.SetData();
        this.animator.Loop = false;
        this.animator.AnimationName = "ani_VoyageRewardsPanel_root";
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAnimatorPlayFinish);
        LuaMgr.RemoveUIEventListener(UIEventConst.VoyageRewardsClickItem, this.OnClickReward);
        this.itemList:Clear();
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickMask);
        this.DestroyRewards();
        UIListView.ClearItem("VoyageRewardGoodsItem");
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})