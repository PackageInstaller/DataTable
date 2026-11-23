require("ViewModel/SpringCamp/SpringCampRewardItem")

local this = {
    scrollView = nil,
    campSeries = nil,
    rewardDatas = nil,
};

local objs = {

    closeBtn = { path = "root/Middle/Reward/Close", type = "Button" },
    rewardItem = { path = "template/RewardItem", type = "GameObject" },
    scrollViewGO = { path = "root/Middle/Reward/ScrollView", type = "GameObject" },
};


this.SetData = function()
    local curSeriesId=TrainingCampMgr.GetCurWheelSeriesID();
    if curSeriesId==nil then return end;
    this.campSeries = TrainingCampMgr.GetCampSeries(curSeriesId);
    if this.campSeries==nil then return end;
    if (this.rewardDatas == nil) then
        this.rewardDatas = TrainingCampMgr.GetCampRewards(this.campSeries.ID);
    end
    this.SetRewardList();
end


this.SetRewardList = function()
    this.scrollView:Clear(false);
    local rewardData;
    local scrollData;
    local scrollDatas = {};
    local receiveList = {};
    local totalStar = TrainingCampMgr.GetTotalStar(this.campSeries.ID);
    local len = #this.rewardDatas;
    for i = 1, len do
        rewardData = this.rewardDatas[i];
        scrollData = UIScrollData.GetData(this.rewardItem, "SpringCampRewardItem", 850, 96, {config=rewardData, star=totalStar});
        if (TrainingCampMgr.IsReceiveReward(rewardData.ID)) then
            table.insert(receiveList, scrollData);
        else
            table.insert(scrollDatas, scrollData);    
        end
    end
    len = #receiveList;
    for i = 1, len do
        table.insert(scrollDatas, receiveList[i]);
    end
    this.scrollView:SetParams(850, 418);
    this.scrollView:SetData(scrollDatas, true);
end


this.OnClickClose = function()
    LuaMgr.HidePanel(UIName.SpringCampRewardViewModel);
end


this.OnRewardGet = function(args)
    TrainingCampMgr.GetRewards(args[0], this.GetRewardsResponse);
end


this.GetRewardsResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        local reward = json.encode(data.result.Rewards);
        LuaMgr.ShowItemRewared(reward);
        this.SetRewardList();
        HeroRedDataHelper.SetSpringCampRed();
        RedMgr.Singleton:RefreshOtherViewModel(UIName.SpringCampLevelViewModel);
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.scrollView = UIScrollView.New(this.scrollViewGO);
        LuaMgr.AddClick(this.closeBtn, this.OnClickClose);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        LuaMgr.AddUIEventListener(UIEventConst.SpringCampRewardGet, this.OnRewardGet);
        this.SetData();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.SpringCampRewardGet, this.OnRewardGet);
        this.scrollView:Clear(true);
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickClose);
        UIScrollView.ClearItem("SpringCampRewardItem");
        this.rewardDatas = nil;
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})