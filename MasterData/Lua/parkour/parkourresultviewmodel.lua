local this = {
    levelConfig = nil,
    itemList = nil,
    colorStr = "%s：<color=#efd18b>%d</color>",
};

local objs = {

    maxScore = { path = "root/Right/Count/MaxScore", type = "GameObject" },
    detailsItem1 = { path = "root/Right/Details/Item1", type = "Text" },
    detailsItem2 = { path = "root/Right/Details/Item2", type = "Text" },
    detailsCurrentScore = { path = "root/Right/Details/CurrentScore", type = "Text" },
    detailsHistoryScore = { path = "root/Right/Details/HistoryScore", type = "Text" },
    rewardsContent = { path = "root/Right/Rewards/ScrollView/Viewport/Content", type = "Transform" },
    confirmBtn = { path = "root/Right/Confirm", type = "Button" },
    character = { path = "root/Left/character/Body", type = "UISpineCharacter" },
};


this.SetData = function()
    ParkourMap.PlayAudio("DH_parkour_7");
    this.character:SetBattle("ED90201", "ED90201", "-1", 0, this.OnCharacter);
    SetActive(this.maxScore, false);
    this.detailsItem1.text = string.format(this.colorStr, LuaMgr.GetLangText("ParkourResultViewModel_0"), ParkourCharacter.GetCoins1());
    this.detailsItem2.text = string.format(this.colorStr, LuaMgr.GetLangText("ParkourResultViewModel_1"), ParkourCharacter.GetCoins2());
    local score = ParkourCharacter.GetScore();
    this.detailsCurrentScore.text = string.format(this.colorStr, LuaMgr.GetLangText("ParkourResultViewModel_2"), score);
    local historyScore = ParkourCharacter.GetHistoryScore();
    this.detailsHistoryScore.text = string.format(this.colorStr, LuaMgr.GetLangText("ParkourResultViewModel_3"), historyScore);
    if (historyScore < this.levelConfig.Score and score >= this.levelConfig.Score) then
        this.SetItemList();
    end
end


this.OnCharacter = function()
    this.character:Play("idle", true, nil);
end


this.SetItemList = function()
    local itemData;
    this.itemList = {};
    local itemMap = ConfigMgr.Config.itemMap;
    local scale = Vector3(0.7, 0.7, 0.7);
    local rewards = this.levelConfig.Reward;
    local len = #rewards;
    for i = 1, len do
        local item = GoodsDataItem.New(this.rewardsContent);
        this.itemList[i] = item;
        itemData = table.Copy(itemMap[rewards[i].id]);
        itemData.count0 = rewards[i].count;
        item:SetData(i, itemData, 1, false, scale, false);
    end
end


this.ClearItemList = function()
    if (this.itemList ~= nil) then
        local len = #this.itemList;
        for i = 1, len do
            this.itemList[i]:Clear();
        end
        this.itemList = nil;
    end
end


this.OnClickConfirm = function()
    LuaMgr.ShowLuaPanel(UIName.ParkourLevelViewModel);
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.confirmBtn, this.OnClickConfirm);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        LuaMgr.HidePanel(UIName.ParkourPauseViewModel);
        vm.behaviour:UpdateTopBar("", this.OnClickConfirm);
        this.levelConfig = vm.behaviour.Params[0];
        this.SetData();
    end,
    before_deactive = function(vm)
        this.levelConfig = nil;
        this.ClearItemList();
        this.character:Clear();
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.confirmBtn, this.OnClickConfirm);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})