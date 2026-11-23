require("Qin/QinDrawGoodsItem")

local this = {
    pool1List = {},
    pool2List = {},
    poolType = "1",
    pool1DrawActivity = nil,
    pool2DrawActivity = nil,
    costItem = nil,
    drawCount = 1,
    drawMaxCount = 0,
};

local objs = {
    aniRoot = { path = "root", type = "Animator" },
    banner1 = { path = "root/Middle/Banner1", type = "GameObject" },
    banner2 = { path = "root/Middle/Banner2", type = "GameObject" },
    goodsItem = { path = "template/GoodsItem", type = "GameObject" },
    pool1Btn = { path = "root/Right/Draw/Pool1", type = "Button" },
    pool1Items = { path = "root/Right/Draw/Pool1/ScrollView/Viewport/Content", type = "Transform" },
    pool1Select = { path = "root/Right/Draw/Pool1/Select", type = "GameObject" },
    pool2Btn = { path = "root/Right/Draw/Pool2", type = "Button" },
    pool2Items = { path = "root/Right/Draw/Pool2/ScrollView/Viewport/Content", type = "Transform" },
    pool2Select = { path = "root/Right/Draw/Pool2/Select", type = "GameObject" },
    costItemTF = { path = "root/Right/Draw/Cost/Item", type = "Transform" },
    costCount = { path = "root/Right/Draw/Cost/Count/Text", type = "Text" },
    minBtn = { path = "root/Right/Draw/Min", type = "Button" },
    subBtn = { path = "root/Right/Draw/Sub", type = "Button" },
    drawBtn = { path = "root/Right/Draw/DrawBtn", type = "Button" },
    drawText = { path = "root/Right/Draw/DrawBtn/Text", type = "Text" },
    drawMask = { path = "root/Right/Draw/DrawBtn/Mask", type = "GameObject" },
    addBtn = { path = "root/Right/Draw/Add", type = "Button" },
    maxBtn = { path = "root/Right/Draw/Max", type = "Button" },
};


this.SetData = function()
    this.pool1DrawActivity = ConfigMgr.Config.DrawActivityMap["13001"];
    this.pool2DrawActivity = ConfigMgr.Config.DrawActivityMap["14001"];
    this.SetPool(this.pool1List, this.pool1DrawActivity, this.pool1Items, "#11644e");
    this.SetPool(this.pool2List, this.pool2DrawActivity, this.pool2Items, "#914538");
    this.SetPoolType("1");
    this.drawCount = 1;
    this.drawMaxCount = this.GetDrawMaxCount();
    this.SetDrawCount();
end


this.SetPool = function(poolList, drawActivity, parent, color)
    local item;
    local drawConfig;
    local remainCount;
    local drawMap = ConfigMgr.Config.DrawMap;
    local len = #drawActivity.Content;
    for i = 1, len do
        drawConfig = drawMap[drawActivity.Content[i]];
        item = poolList[i];
        if (item == nil) then
            item = QinDrawGoodsItem.New(this.goodsItem, parent);
            poolList[i] = item;
        end
        remainCount = this.GetRewardRemainCount(drawConfig, drawActivity.ID);
        item:SetData({showReward={id=drawConfig.Reward[1].id,count=drawConfig.Reward[1].count},
                      count=string.format("<color=%s>%d</color>", color, remainCount),
                      totalCount = drawConfig.Time,
                      bFinish = remainCount <= 0});
    end
end


this.GetDrawMaxCount = function()
    local drawConfig;
    local remainCount;
    local maxCount = 0;
    local drawMap = ConfigMgr.Config.DrawMap;
    local drawActivity = this.GetDrawActivity();
    local len = #drawActivity.Content;
    for i = 1, len do
        drawConfig = drawMap[drawActivity.Content[i]];
        remainCount = this.GetRewardRemainCount(drawConfig, drawActivity.ID);
        maxCount = maxCount + remainCount;
    end
    local cost = this.GetDrawActivityCost();
    if (cost ~= nil) then
        local itemCount = PlayerItemMgr.GetItemCountById(cost.id);
        count = math.floor(itemCount / cost.count);
        if (count < maxCount) then
            return count;
        end
    end
    return maxCount;
end


this.GetRewardRemainCount = function(config, drawActivityId)
    local count = config.Time;
    local key = string.format("%s_%s", drawActivityId, config.ID);
    local hasBuyCount = DataMgr.Player.drawRewardRecords[key];
    if (hasBuyCount ~= nil) then
        count = count - hasBuyCount;
    end
    return count;
end


this.ClearPools = function()
    local len = #this.pool1List;
    for i = 1, len do
        this.pool1List[i]:Clear();
    end
    len = #this.pool2List;
    for i = 1, len do
        this.pool2List[i]:Clear();
    end
end


this.DestroyPools = function()
    local len = #this.pool1List;
    for i = 1, len do
        this.pool1List[i]:Destroy();
    end
    this.pool1List = {};
    len = #this.pool2List;
    for i = 1, len do
        this.pool2List[i]:Destroy();
    end
    this.pool2List = {};
end


this.GetDrawActivity = function()
    if (this.poolType == "1") then
        return this.pool1DrawActivity;
    elseif (this.poolType == "2") then
        return this.pool2DrawActivity;
    end
    return nil;
end


this.GetDrawActivityCost = function()
    local drawActivity = this.GetDrawActivity();
    if (drawActivity ~= nil) then
        return drawActivity.Consume[1];
    end
    return nil;
end


this.SetPoolType = function(type)
    this.poolType = type;
    SetActive(this.pool1Select, type == "1");
    SetActive(this.pool2Select, type == "2");
    SetActive(this.banner1, type == "1");
    SetActive(this.banner2, type == "2");
    this.aniRoot:Rebind();
    this.aniRoot:Play("ani_QinDrawPanel_root_Banner"..type);
    local cost = this.GetDrawActivityCost();
    if (cost ~= nil) then
        local itemData = table.Copy(ConfigMgr.Config.itemMap[cost.id]);
        this.costItem:SetData(1, itemData, 1, false, Vector3(0.7, 0.7, 1), false, true);
        this.costItem:SetIconBg(false);
        this.costItem:SetRareBg(false);
    end
end


this.SetRemainCount = function()
    if (this.poolType == "1") then       
        this.SetPool(this.pool1List, this.pool1DrawActivity, this.pool1Items, "#11644e");
    elseif (this.poolType == "2") then       
        this.SetPool(this.pool2List, this.pool2DrawActivity, this.pool2Items, "#914538");
    end
end


this.SetDrawCount = function()
    local cost = this.GetDrawActivityCost();
    if (cost ~= nil) then
        local itemCount = PlayerItemMgr.GetItemCountById(cost.id);
        this.drawText.text = string.format(LuaMgr.GetLangText("QinDrawViewModel_0"), this.drawCount);
        local bMask = this.drawMaxCount <= 0 or itemCount < cost.count * this.drawCount
        SetActive(this.drawMask, bMask);
        this.addBtn.enabled = not bMask
        this.maxBtn.enabled = not bMask
        this.minBtn.enabled = not bMask
        this.subBtn.enabled = not bMask
        this.costCount.text = string.format("<color=#dfd4bc>%d</color>/<color=#a1906a>%d</color>", itemCount, cost.count);
    end
end


this.OnClickPool1 = function()
    this.SetPoolType("1");
    this.drawCount = 1;
    this.drawMaxCount = this.GetDrawMaxCount();
    this.SetDrawCount();
end


this.OnClickPool2 = function()
    this.SetPoolType("2");
    this.drawCount = 1;
    this.drawMaxCount = this.GetDrawMaxCount();
    this.SetDrawCount();
end


this.OnClickDraw = function()
    local drawActivity = this.GetDrawActivity();
    if (drawActivity == nil) then return end

    local cost = drawActivity.Consume[1];
    local itemCount = PlayerItemMgr.GetItemCountById(cost.id);
    local count = cost.count * this.drawCount;
    if (itemCount < count) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("QinDrawViewModel_1"));
        return;
    end
    if (this.drawMaxCount <= 0) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("QinDrawViewModel_2"));
        return;
    end
    PlayerQinMgr.DrawReward(drawActivity.Group, this.drawCount, this.DrawRewardResponse);
end


this.DrawRewardResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        this.drawMaxCount = this.GetDrawMaxCount();
        this.SetRemainCount();
        this.SetDrawCount();
        local reward = json.encode(data.result.Reward);
        LuaMgr.ShowGetRewardPanel(reward);
    end
end


this.OnClickMin = function()
    this.drawCount = 1;
    this.SetDrawCount();
end


this.OnClickSub = function()
    if (this.drawCount > 1) then
        this.drawCount = this.drawCount - 1;
        this.SetDrawCount();
    end
end


this.OnClickAdd = function()
    if (this.drawCount < this.drawMaxCount) then
        this.drawCount = this.drawCount + 1;
        this.SetDrawCount();
    end
end


this.OnClickMax = function()
    this.drawCount = this.drawMaxCount;
    this.SetDrawCount();
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.pool1Btn, this.OnClickPool1);
        LuaMgr.AddClick(this.pool2Btn, this.OnClickPool2);
        LuaMgr.AddClick(this.minBtn, this.OnClickMin);
        LuaMgr.AddClick(this.subBtn, this.OnClickSub);
        LuaMgr.AddClick(this.drawBtn, this.OnClickDraw);
        LuaMgr.AddClick(this.addBtn, this.OnClickAdd);
        LuaMgr.AddClick(this.maxBtn, this.OnClickMax);
        this.costItem = GoodsDataItem.New(this.costItemTF);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        

        this.SetData();
    end,
    before_deactive = function(vm)
        this.ClearPools();
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.pool1Btn, this.OnClickPool1);
        LuaMgr.RemoveClick(this.pool2Btn, this.OnClickPool2);
        LuaMgr.RemoveClick(this.minBtn, this.OnClickMin);
        LuaMgr.RemoveClick(this.subBtn, this.OnClickSub);
        LuaMgr.RemoveClick(this.drawBtn, this.OnClickDraw);
        LuaMgr.RemoveClick(this.addBtn, this.OnClickAdd);
        LuaMgr.RemoveClick(this.maxBtn, this.OnClickMax);
        this.DestroyPools();
        if (this.costItem ~= nil) then
            this.costItem:Clear();
            this.costItem = nil;
        end
        UIListView.ClearItem("QinDrawGoodsItem");
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})