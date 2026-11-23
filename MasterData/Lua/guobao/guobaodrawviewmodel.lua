require("GuoBao/GuoBaoDrawGoodsItem")

local this = {
    groupId = "30",
    isSpeed = false,
    speedKey = "GuoBaoDraw_Speed_" .. DataMgr.Player.uid,
    drawActivityId = "",
    drawActivity = nil,
    goodsList = nil,
    posList = nil,
    rouleList = nil,
    canChange = false,
    maxDrawCount = 0,
    drawCount = 0,
};

local objs = {
    goodsItem = {path = "template/goodsItem", type = "GameObject"},
    roulesTF = {path = "root/Middle/center/roules", type = "Transform"},
    itemsTF = {path = "root/Middle/center/items", type = "Transform"},
    pointerTF = {path = "root/Middle/center/pointer", type = "RectTransform"},
    pointer = {path = "root/Middle/center/pointer", type = "UIRotateByCurve"},
    refreshGO = {path = "root/Middle/center/refresh", type = "GameObject"},
    refreshBtn = {path = "root/Middle/center/refresh", type = "Button"},
    oneBtn = {path = "root/Right/buttons/one", type = "Button"},
    oneCostIcon = {path = "root/Right/buttons/one/cost/icon", type = "RawImage"},
    oneCostNum = {path = "root/Right/buttons/one/cost/num", type = "Text"},
    oneText = {path = "root/Right/buttons/one/text", type = "Text"},
    tenGO = {path = "root/Right/buttons/ten", type = "GameObject"},
    tenBtn = {path = "root/Right/buttons/ten", type = "Button"},
    tenCostIcon = {path = "root/Right/buttons/ten/cost/icon", type = "RawImage"},
    tenCostNum = {path = "root/Right/buttons/ten/cost/num", type = "Text"},
    tenText = {path = "root/Right/buttons/ten/text", type = "Text"},
    timeText = {path = "root/Left/time/text", type = "Text"},
    itemBtn = {path = "root/Right/item", type = "Button"},
    itemIcon = {path = "root/Right/item/icon", type = "RawImage"},
    itemNum = {path = "root/Right/item/num", type = "Text"},
    speedBtn = {path = "root/Right/speed", type = "Button"},
    speedSelect = {path = "root/Right/speed/select", type = "GameObject"},
}


this.SetData = function()
    local variable = DataMgr.Player.variables["group.3021"];
    if (variable == nil) then return end

    this.SetDrawActivity();
    this.SetGoodsList();
    local consumeItem = this.drawActivity.Consume[1];
    local iconPath = ConfigHelper.GetItemHomeIconPath(consumeItem.id);
    local iconTexture = LuaMgr.GetTexture(iconPath);
    this.itemIcon.texture = iconTexture;
    this.oneCostIcon.texture = iconTexture;
    this.tenCostIcon.texture = iconTexture;
    local itemCount = PlayerItemMgr.GetItemCountById(consumeItem.id);
    this.itemNum.text = tostring(itemCount);
    this.drawCount = math.floor(itemCount / consumeItem.count);
    if (this.drawCount > this.maxDrawCount) then
        this.drawCount = this.maxDrawCount;
    end
    this.oneCostNum.text = tostring(consumeItem.count);
    this.tenCostNum.text = tostring(this.drawCount * consumeItem.count);
    local drawStr = LuaMgr.GetLangText("GuoBaoDrawViewModel_0");
    this.oneText.text = string.format(drawStr, this.drawCount >= 1 and 1 or 1);
    this.tenText.text = string.format(drawStr, this.drawCount);
    SetActive(this.tenGO, this.drawCount > 1);
    local startTimeStr = os.date("%Y %m.%d", variable.startTime);
    local endTimeStr = os.date("%m.%d", variable.expireTime);
    this.timeText.text = string.format("%s-%s", startTimeStr, endTimeStr);
    this.isSpeed = PlayerPrefs.GetInt(this.speedKey, 0) == 1;
    SetActive(this.speedSelect, this.isSpeed);
    SetActive(this.refreshGO, this.canChange);
    HeroRedDataHelper.SetGuoBaoRed();
    RedMgr.Singleton:Refresh();
end


this.SetDrawActivity = function()
    local drawRewardProgress = DataMgr.Player.drawRewardProgress;
    local id = drawRewardProgress[this.groupId];
    this.drawActivityId = id ~= nil and id or "30001";
    this.drawActivity = ConfigMgr.Config.DrawActivityMap[this.drawActivityId];
end


this.OnUpdate = function()
    this.SetRoules();
end


this.InitData = function()
    this.posList = {};
    this.rouleList = {};
    for i = 1, 8 do
        this.posList[i] = this.itemsTF:Find("item" .. i).localPosition;
        this.rouleList[i] = this.roulesTF:Find("roule" .. i):GetComponent("Image");
    end
end


this.SetGoodsList = function()
    this.goodsList:Clear();
    local drawConfig;
    local goodsData;
    local listData;
    local listDatas = {};
    this.maxDrawCount = 0;
    local drawMap = ConfigMgr.Config.DrawMap;
    local len = #this.drawActivity.Content;
    for i = 1, len do
        drawConfig = drawMap[this.drawActivity.Content[i]];
        goodsData = {
            id = drawConfig.Reward[1].id,
            count = drawConfig.Reward[1].count,
            drawCount = this.GetRewardRemainCount(drawConfig),
            pos = this.posList[i],
        };
        this.maxDrawCount = this.maxDrawCount + goodsData.drawCount;
        listData = UIListData.GetData(this.goodsItem, "GuoBaoDrawGoodsItem", goodsData);
        table.insert(listDatas, listData);
    end
    this.goodsList:SetData(listDatas, true);
end


this.GetRewardRemainCount = function(config)
    local count = config.Time;
    local key = string.format("%s_%s", this.drawActivityId, config.ID);
    local hasBuyCount = DataMgr.Player.drawRewardRecords[key];
    if (hasBuyCount ~= nil) then
        count = count - hasBuyCount;
    end
    return count;
end


this.SetRoules = function()
    local startAngle;
    local endAngle;
    local angle = this.pointerTF.localEulerAngles.z;
    local len = #this.rouleList;
    for i = 1, len do
        startAngle = (i - 1) * 45;
        endAngle = i * 45;
        this.rouleList[i].enabled = angle > startAngle and angle < endAngle;
    end
end


this.ClearRoules = function()
    local len = #this.rouleList;
    for i = 1, len do
        this.rouleList[i].enabled = false;
    end
end


this.PlayAnimation = function(endAngle, callback)
    local onceTime = 0.6;
    local turnCount = 4;
    if (this.isSpeed) then
        turnCount = 3;
        onceTime = 0.4
    end
    local angel = -360 * turnCount + endAngle - 360;
    local time = (math.abs(angel) / 360) * onceTime;
    this.pointer:DOLocalRotate(angel, time, callback, this.isSpeed);
end


this.OnClickRefresh = function()
    this.ChangeBox();
end


this.OnClickOne = function()
    this.DrawReward(1);
end


this.OnClickTen = function()
    this.DrawReward(this.drawCount);
end


this.OnClickSpeed = function()
    this.isSpeed = not this.isSpeed;
    SetActive(this.speedSelect, this.isSpeed);
    PlayerPrefs.SetInt(this.speedKey, this.isSpeed and 1 or 0);
end


this.OnClickItem = function()
    local consumeItem = this.drawActivity.Consume[1];
    LuaMgr.ShowPanel(UIName.GoodsTipsViewModel, consumeItem.id, false, false, false);
end


this.DrawReward = function(count)
    if (this.maxDrawCount > 0 and this.drawCount <= 0) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("10154"));
        return;
    end
    if (this.drawCount <= 0) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal(this.canChange and "10155" or "10156"));
        return;
    end
    ApiMgr.Request("draw/drawReward", {Group=this.groupId, Count=count}, true, this.DrawRewardResponse, nil, true);
end


this.DrawRewardResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        this.canChange = data.result.CanChange;
        local rewardId = data.result.RewardIDs[1];
        local drawLoc = 1;
        local len = #this.drawActivity.Content;
        for i = 1, len do
            if (this.drawActivity.Content[i] == rewardId) then
                drawLoc = i;
                break;
            end
        end
        local reward = json.encode(data.result.Reward);
        local endAngle = 23 + (drawLoc - 1) * 45;
        LuaMgr.AddUpdate(this.OnUpdate);
        this.PlayAnimation(endAngle, function()
            LuaMgr.RemoveUpdate(this.OnUpdate);
            this.SetData();
            LuaMgr.ShowGetRewardPanel(reward);
        end);
    end
end


this.ChangeBox = function()
    ApiMgr.Request("draw/changeBox", {Group=this.groupId}, true, this.ChangeBoxResponse, nil, true);
end


this.ChangeBoxResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        this.canChange = data.result.CanChange;
        this.SetData();
    end
end


this.OpenBox=function()
    ApiMgr.Request("draw/openBox", {Group=this.groupId}, true, this.OpenBoxResponse, nil, true);
end


this.OpenBoxResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        this.canChange = data.result.CanChange;
        SetActive(this.refreshGO, this.canChange);
    end
end

local data = {};

local command = {};

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.goodsList = UIListView.New(this.itemsTF);
        LuaMgr.AddClick(this.refreshBtn, this.OnClickRefresh);
        LuaMgr.AddClick(this.oneBtn, this.OnClickOne);
        LuaMgr.AddClick(this.tenBtn, this.OnClickTen);
        LuaMgr.AddClick(this.speedBtn, this.OnClickSpeed);
        LuaMgr.AddClick(this.itemBtn, this.OnClickItem);
        this.InitData();
        RedMgr.Singleton:RegisterViewModel(UIName.GuoBaoDrawViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        this.canChange = false;
        this.ClearRoules();
        this.OpenBox();
        this.SetData();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUpdate(this.OnUpdate);
        this.goodsList:Clear();
        RedMgr.Singleton:RefreshOtherViewModel(UIName.GuoBaoDrawViewModel);
    end,
    before_destroy=function()
        LuaMgr.RemoveClick(this.refreshBtn, this.OnClickRefresh);
        LuaMgr.RemoveClick(this.oneBtn, this.OnClickOne);
        LuaMgr.RemoveClick(this.tenBtn, this.OnClickTen);
        LuaMgr.RemoveClick(this.speedBtn, this.OnClickSpeed);
        LuaMgr.RemoveClick(this.itemBtn, this.OnClickItem);
        this.posList = nil;
        this.rouleList = nil;
        UIListView.ClearItem("GuoBaoDrawGoodsItem");
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})