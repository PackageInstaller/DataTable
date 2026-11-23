require("ViewModel/Activity/ZhongQiuJieGoodsItem")

local this = {
    groupId = "3",
    isSpeed = false,
    speedKey = "ZhongQiuJie_Speed_" .. DataMgr.Player.uid,
    drawActivityId = "",
    drawActivity = nil,
    goodsList = nil,
    posList = nil,
    rouleList = nil,
    canChange = false,
    maxDrawCount = 0,
    drawCount = 0,
    taskItem = nil,
    dayTask = nil,
};

local objs = {
    spineCharacter = {path = "root/Middle/bg/character/body", type = "UISpineCharacter"},
    drawingAdjustTool = {path = "root/Middle/bg/character/body", type = "DrawingAdjustTool"},
    goodsItem = {path = "template/goodsItem", type = "GameObject"},
    roulesTF = {path = "root/Middle/center/roules", type = "Transform"},
    itemsTF = {path = "root/Middle/center/items", type = "Transform"},
    pointerTF = {path = "root/Middle/center/pointer", type = "RectTransform"},
    pointer = {path = "root/Middle/center/pointer", type = "UIRotateByCurve"},
    refreshGO = {path = "root/Middle/center/refresh", type = "GameObject"},
    refreshBtn = {path = "root/Middle/center/refresh", type = "Button"},
    oneBtn = {path = "root/Middle/buttons/one", type = "Button"},
    oneCostIcon = {path = "root/Middle/buttons/one/cost/icon", type = "RawImage"},
    oneCostNum = {path = "root/Middle/buttons/one/cost/num", type = "Text"},
    oneText = {path = "root/Middle/buttons/one/text", type = "Text"},
    tenGO = {path = "root/Middle/buttons/ten", type = "GameObject"},
    tenBtn = {path = "root/Middle/buttons/ten", type = "Button"},
    tenCostIcon = {path = "root/Middle/buttons/ten/cost/icon", type = "RawImage"},
    tenCostNum = {path = "root/Middle/buttons/ten/cost/num", type = "Text"},
    tenText = {path = "root/Middle/buttons/ten/text", type = "Text"},
    timeText = {path = "root/Left/time/text", type = "Text"},
    itemIcon = {path = "root/Left/item/icon", type = "RawImage"},
    itemNum = {path = "root/Left/item/num", type = "Text"},
    speedBtn = {path = "root/Right/speed", type = "Button"},
    speedSelect = {path = "root/Right/speed/select", type = "GameObject"},
    taskGO = {path = "root/Right/task", type = "GameObject"},
    taskItemTF = {path = "root/Right/task/item", type = "Transform"},
    taskGotoGO = {path = "root/Right/task/goto", type = "GameObject"},
    taskGotoBtn = {path = "root/Right/task/goto", type = "Button"},
    taskReceiveGO = {path = "root/Right/task/receive", type = "GameObject"},
    taskReceiveBtn = {path = "root/Right/task/receive", type = "Button"},
    taskFinish = {path = "root/Right/task/finish", type = "GameObject"},
    taskDescGO = {path = "root/Right/task/desc", type = "GameObject"},
    taskDescText = {path = "root/Right/task/desc/Text", type = "Text"},
    taskReceivedGO = {path = "root/Right/task/received", type = "GameObject"},
}


this.SetData = function()
    local variable = DataMgr.Player.variables["group.2002"];
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
    this.oneCostNum.text = tostring(this.drawCount >= consumeItem.count and 1 or 1);
    this.tenCostNum.text = tostring(this.drawCount);
    local drawStr = LuaMgr.GetLangText("ZhongQiuJieViewModel_0");
    this.oneText.text = string.format(drawStr, this.drawCount >= 1 and 1 or 1);
    this.tenText.text = string.format(drawStr, this.drawCount);
    SetActive(this.tenGO, this.drawCount > 1);
    local dateStr = LuaMgr.GetLangText("ZhongQiuJieViewModel_1");
    local startTimeStr = os.date(dateStr, variable.startTime);
    local endTimeStr = os.date(dateStr, variable.expireTime);
    this.timeText.text = string.format("%s-%s", startTimeStr, endTimeStr);
    this.isSpeed = PlayerPrefs.GetInt(this.speedKey, 0) == 1;
    SetActive(this.speedSelect, this.isSpeed);
    SetActive(this.refreshGO, this.canChange);
    HeroRedDataHelper.SetZhongQiuJieRed();
    RedMgr.Singleton:Refresh();
end


this.SetDrawActivity = function()
    local drawRewardProgress = DataMgr.Player.drawRewardProgress;
    local id = drawRewardProgress[this.groupId];
    this.drawActivityId = id ~= nil and id or "3001";
    this.drawActivity = ConfigMgr.Config.DrawActivityMap[this.drawActivityId];
end


this.SetSpine = function()
    local path = HeroManager.SetCharacterDrawing(this.spineCharacter, "W0081", "W0081002");
    if (path ~= "") then
        this.drawingAdjustTool.Sprite = path;
    end
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
        listData = UIListData.GetData(this.goodsItem, "ZhongQiuJieGoodsItem", goodsData);
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


this.SetTask = function()
    this.dayTask = nil;
    local configs = DataExHelper.Check_ConfigQuestEventByText("zhongqiujieTask");
    local quests = DataMgr.Player.quests;
    local taskList = {};
    for _, v in ipairs(configs) do
        if (quests[v.id] ~= nil) then
            table.insert(taskList, v);
        end
    end
    if (#taskList <= 0) then
        SetActive(this.taskGO, false);
        return;
    end;
    SetActive(this.taskGO, true);
    table.sort(taskList, function(a, b) return tonumber(a.id)<tonumber(b.id) end);
    local task;
    for _, v in ipairs(taskList) do
        if (quests[v.id] ~= nil and quests[v.id].state ~= 3) then
            task = v;
            this.dayTask = v;
            break;
        end
    end
    if (task ~= nil) then
        local taskData = quests[task.id];
        if (taskData ~= nil) then
            SetActive(this.taskGotoGO, taskData.state == 1);
            SetActive(this.taskReceiveGO, taskData.state == 2);
        end
        this.taskDescText.text = LuaMgr.GetLangText(task.namelan);
        SetActive(this.taskDescGO, true);
        SetActive(this.taskFinish, false);
        SetActive(this.taskReceivedGO, false);
    else
        SetActive(this.taskGotoGO, false);
        SetActive(this.taskReceiveGO, false);
        SetActive(this.taskDescGO, false);
        SetActive(this.taskFinish, true);
        SetActive(this.taskReceivedGO, true);
        task = taskList[#taskList];
    end

    local reward = task.showReward[1];
    if (this.taskItem == nil) then
        this.taskItem = GoodsDataItem.New(this.taskItemTF);
    end
    local itemConfig = table.Copy(ConfigMgr.Config.itemMap[reward.id]);
    itemConfig.count0 = reward.count;
    this.taskItem:SetData(1, itemConfig, 1, false, Vector3(0.5,0.5,1), false);
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


this.OnClickTaskGoto = function()
    if (this.dayTask ~= nil) then
        FeatureManager.GotoViewModel(this.dayTask.skipPage);
    end
end


this.OnClickTaskReceive = function()
    if (this.dayTask ~= nil) then
        DataExHelper.EX_GetAward(this.dayTask.id, this.GetAwardResponse);
    end
end


this.GetAwardResponse = function()
    this.SetData();
    this.SetTask();
    HeroRedDataHelper.SetZhongQiuJieRed();
    RedMgr.Singleton:Refresh();
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
        LuaMgr.AddClick(this.taskGotoBtn, this.OnClickTaskGoto);
        LuaMgr.AddClick(this.taskReceiveBtn, this.OnClickTaskReceive);
        this.InitData();
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        this.canChange = false;
        this.ClearRoules();
        this.OpenBox();
        this.SetData();
        this.SetTask();
        this.SetSpine();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUpdate(this.OnUpdate);
        this.spineCharacter:Clear();
        this.drawingAdjustTool.Sprite = nil;
        this.goodsList:Clear();
        this.dayTask = nil;
        RedMgr.Singleton:RefreshOtherViewModel(UIName.ZhongQiuJieViewModel);
    end,
    before_destroy=function()
        LuaMgr.RemoveClick(this.refreshBtn, this.OnClickRefresh);
        LuaMgr.RemoveClick(this.oneBtn, this.OnClickOne);
        LuaMgr.RemoveClick(this.tenBtn, this.OnClickTen);
        LuaMgr.RemoveClick(this.speedBtn, this.OnClickSpeed);
        LuaMgr.RemoveClick(this.taskGotoBtn, this.OnClickTaskGoto);
        LuaMgr.RemoveClick(this.taskReceiveBtn, this.OnClickTaskReceive);
        this.posList = nil;
        this.rouleList = nil;
        if (this.taskItem ~= nil) then
            this.taskItem:Clear();
            this.taskItem = nil;
        end
        UIListView.ClearItem("ZhongQiuJieGoodsItem");
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})