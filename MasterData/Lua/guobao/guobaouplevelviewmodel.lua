require("GuoBao/GuoBaoUpLevelCostItem")

local this = {
    costList = nil,
    config = nil,
    rewardItem = nil,
};

local objs = {
    costItem = { path = "template/CostItem", type = "GameObject" },
    costListTF = { path = "root/Middle/Group/Cost/List", type = "RectTransform" },
    bottomMask = { path = "root/BottomMask", type = "GameObject" },
    title = { path = "root/Middle/Group/Title/Text", type = "Image" },
    closeBtn = { path = "root/Middle/Group/Close", type = "Button" },
    pic = { path = "root/Middle/Group/Pic", type = "Image" },
    msg = { path = "root/Middle/Group/Msg/Text", type = "Text" },
    itemTF = { path = "root/Middle/Group/Reward/Item/Item", type = "Transform" },
    currentLevelTF = { path = "root/Middle/Group/Reward/CurrentLevel", type = "Transform" },
    currentLevelText = { path = "root/Middle/Group/Reward/CurrentLevel/Text", type = "Text" },
    nextLevelGO = { path = "root/Middle/Group/Reward/NextLevel", type = "GameObject" },
    nextLevelText = { path = "root/Middle/Group/Reward/NextLevel/NextLevel/Text", type = "Text" },
    rewardLimit = { path = "root/Middle/Group/Reward/Limit", type = "Text" },
    maxLevel = { path = "root/Middle/Group/Cost/MaxLevel", type = "GameObject" },
    collectGO = { path = "root/Middle/Group/Collect", type = "GameObject" },
    collectBtn = { path = "root/Middle/Group/Collect", type = "Button" },
    collectImg = { path = "root/Middle/Group/Collect", type = "Image" },
    collectRedDot = { path = "root/Middle/Group/Collect/RedDot", type = "GameObject" },
    upLevelGO = { path = "root/Middle/Group/UpLevel", type = "GameObject" },
    upLevelBtn = { path = "root/Middle/Group/UpLevel", type = "Button" },
    upLevelImg = { path = "root/Middle/Group/UpLevel", type = "Image" },
};


this.SetData = function()
    SetActive(this.bottomMask, false);
    this.title.sprite = LuaMgr.GetSprite("GuoBaoScene", "ui_hd_gb_jy_tc_title_" .. this.config.Group);
    this.pic.sprite = LuaMgr.GetSprite("GuoBaoScene", "ui_hd_gb_jy_tc_pic_" .. this.config.Group);
    this.msg.text = LuaMgr.GetLangText(this.config.DescribeLan);
    this.SetRewardItem();
    local unit = LuaMgr.GetLangText("GuoBaoUpLevelViewModel_0");
    local nextConfig = ConfigGuoBaoMgr.GetSimulatedShop(this.config.Group, this.config.Level + 1);
    if (nextConfig ~= nil) then
        this.nextLevelText.text = ConfigGuoBaoMgr.GetBuildingYields(nextConfig) .. unit;
        this.currentLevelTF.localPosition = Vector3(98,9,0);
        SetActive(this.nextLevelGO, true);
        SetActive(this.maxLevel, false);
        SetActive(this.collectGO, false);
        local color = UnityEngine.Color(1,1,1,0.6);
        if (this.SetCost(this.config.Cost) and PlayerGuoBaoMgr.IsBuildingUnlock(nextConfig, false)) then
            color.a = 1;
        end
        this.upLevelImg.color = color;
        SetActive(this.upLevelGO, true);
    else
        this.SetCost(nil);
        this.currentLevelTF.localPosition = Vector3(98,-16,0);
        SetActive(this.nextLevelGO, false);
        SetActive(this.maxLevel, true);
        SetActive(this.collectGO, true);
        SetActive(this.collectRedDot, PlayerGuoBaoMgr.IsCollectReward(this.config.Group));
        SetActive(this.upLevelGO, false);
        this.collectImg.sprite = LuaMgr.GetSprite("GuoBaoScene", string.format("ui_hd_gb_jy_ss_hj_%s_1", this.config.Group));
    end
    this.currentLevelText.text = ConfigGuoBaoMgr.GetBuildingYields(this.config) .. unit;
    local yields = PlayerGuoBaoMgr.GetBuildingYields(this.config);
    if (yields > this.config.YieldsLimit) then
        yields = this.config.YieldsLimit;
    end
    this.rewardLimit.text = LuaMgr.GetLangText("GuoBaoUpLevelViewModel_1") .. yields .. "/" .. this.config.YieldsLimit;
end


this.SetRewardItem = function()
    if (this.rewardItem == nil) then
        this.rewardItem = GoodsDataItem.New(this.itemTF);
    end
    local itemConfig = table.Copy(ConfigMgr.Config.itemMap[this.config.YieldsItem]);
    itemConfig.count0 = 0;
    this.rewardItem:SetData(1, itemConfig, 1, false, Vector3(0.6,0.6,1), false, true);
end


this.SetCost = function(cost)
    this.costList:Clear();
    local status = true;
    if (not IsNull(cost)) then
        local listDatas = {};
        local len = #cost;
        for i = 1, len do
            local item = cost[i];
            local itemCount = PlayerItemMgr.GetItemCountById(item.id);
            if (itemCount < item.count) then
                status = false;
            end
            local listData = UIListData.GetData(this.costItem, "GuoBaoUpLevelCostItem", item);
            table.insert(listDatas, listData);
        end
        this.costList:SetData(listDatas);
    end
    return status;
end


this.CloseUpLevel = function()
    LuaMgr.HidePanel(UIName.GuoBaoUpLevelViewModel);
end


this.OnClickClose = function()
    LuaMgr.NextFrame(this.CloseUpLevel);
end


this.OnClickUpLevel = function()
    local nextConfig = ConfigGuoBaoMgr.GetSimulatedShop(this.config.Group, this.config.Level + 1);
    if (PlayerGuoBaoMgr.IsBuildingUnlock(nextConfig, true)) then
        PlayerGuoBaoMgr.SimulatedShopUpgrade(this.config.Group);
    end
end


this.OnClickCollect = function()
    local questConfig = ConfigGuoBaoMgr.GetSimulatedShopQuestEvent("GuoBaostamp" .. this.config.Group);
    if (questConfig ~= nil) then
        local questData = PlayerGuoBaoMgr.GetQuestEvent(questConfig.id);
        if (questData.state == 2) then
            DataExHelper.EX_GetAward(questConfig.id, this.GetAwardResponse);
            return;
        end
    end
    LuaMgr.ShowLuaPanel(UIName.GuoBaoCollectDetailsViewModel, this.config.Group);
end


this.GetAwardResponse = function()
    LuaMgr.ShowLuaPanel(UIName.GuoBaoCollectDetailsViewModel, this.config.Group);
    SetActive(this.collectRedDot, false);
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.costList = UIListView.New(this.costListTF);
        LuaMgr.AddClick(this.closeBtn, this.OnClickClose);
        LuaMgr.AddClick(this.upLevelBtn, this.OnClickUpLevel);
        LuaMgr.AddClick(this.collectBtn, this.OnClickCollect);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        
        this.config = vm.behaviour.Params[0];
        this.SetData();
    end,
    before_deactive = function(vm)
        this.costList:Clear();
        this.title.sprite = nil;
        this.pic.sprite = nil;
        this.config = nil;
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickClose);
        LuaMgr.RemoveClick(this.upLevelBtn, this.OnClickUpLevel);
        LuaMgr.RemoveClick(this.collectBtn, this.OnClickCollect);
        if (this.rewardItem ~= nil) then
            this.rewardItem:Clear();
            this.rewardItem = nil;
        end
        UIListView.ClearItem("GuoBaoUpLevelCostItem");
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})