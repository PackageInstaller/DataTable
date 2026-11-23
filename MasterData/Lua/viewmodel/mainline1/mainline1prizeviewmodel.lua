require("ViewModel/MainLine1/MainLine1PrizeRewardItem")


local this = {
    vm = nil,
    rewardsUIList = {},
    rewardItemObj = nil,
    goodItemObj = nil,
    btnTypeTab = nil,
    msgList = { "23820", "23821", "23822", "23823" },
};

local posList = { Vector2(380, 0), Vector2(-456, 0) }
local itemList = {}
local cfgDrawMap = {}
local buyCount = 1;
local curDrawActivity = nil;
local drawTotalCount = nil;
local playDrawTotalCount = nil;
local myMaxDrawCount = nil;
local curPage = 1;
local groupId = nil;
local askStop = false;
local rootAnimator = nil;

local tarGameObject = nil;
local tarRect = nil;
local goodItem = nil;
local good = nil;
local root = nil;
local Middle = nil;
local Right = nil;
local goPanel1 = nil;
local goPanel2 = nil;
local goPanel3 = nil;
local Left = nil;
local btnWepon = nil;
local btnDiamond = nil;
local btnFurniture = nil;
local btnCard = nil;
local btnCultivate = nil;
local btnReward = nil;
local btnAdd = nil;
local btnSubtract = nil;
local btnMax = nil;
local btnMin = nil;
local btnConfrim = nil;
local btnBack = nil;
local tranFull = nil;
local tranContent = nil;
local tranRewards = nil;
local ScrollView = nil;
local rawImageIcon = nil;
local textCostCount = nil;
local textNum = nil;
local goBg2 = nil;
local goBg1 = nil;
local goPanel1Bg2 = nil;
local goPanel1Bg1 = nil;
local goPanel2Bg2 = nil;
local goPanel2Bg1 = nil;
local goPanel3Bg2 = nil;
local goPanel3Bg1 = nil;
local ScrollViewH = nil;
local tranContentH = nil;
local characterDrawing = nil;
local spineCharacter = nil;
local btnFinishObjTb = { [1] = nil, [2] = nil, [3] = nil, [4] = nil, [5] = nil }
local btnFinishTextTb = { [1] = nil, [2] = nil, [3] = nil, [4] = nil, [5] = nil }
local msgContent = nil;
local btnClick = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    goodItem = uiLink:Get("goodItem");
    good = uiLink:Get("good");
    root = uiLink:Get("root");
    Middle = uiLink:Get("Middle");
    Right = uiLink:Get("Right");
    goPanel1 = uiLink:Get("goPanel1");
    goPanel2 = uiLink:Get("goPanel2");
    goPanel3 = uiLink:Get("goPanel3");
    Left = uiLink:Get("Left");
    goBg2 = uiLink:Get("goBg2");
    goBg1 = uiLink:Get("goBg1");
    goPanel1Bg2 = uiLink:Get("goPanel1Bg2");
    goPanel1Bg1 = uiLink:Get("goPanel1Bg1");
    goPanel2Bg2 = uiLink:Get("goPanel2Bg2");
    goPanel2Bg1 = uiLink:Get("goPanel2Bg1");
    goPanel3Bg2 = uiLink:Get("goPanel3Bg2");
    goPanel3Bg1 = uiLink:Get("goPanel3Bg1");
    btnWepon = uiLink:Get("btnWepon"):GetComponent("Button");
    btnDiamond = uiLink:Get("btnDiamond"):GetComponent("Button");
    btnFurniture = uiLink:Get("btnFurniture"):GetComponent("Button");
    btnCard = uiLink:Get("btnCard"):GetComponent("Button");
    btnCultivate = uiLink:Get("btnCultivate"):GetComponent("Button");
    btnReward = uiLink:Get("btnReward"):GetComponent("Button");
    btnAdd = uiLink:Get("btnAdd"):GetComponent("Button");
    btnSubtract = uiLink:Get("btnSubtract"):GetComponent("Button");
    btnMax = uiLink:Get("btnMax"):GetComponent("Button");
    btnMin = uiLink:Get("btnMin"):GetComponent("Button");
    btnConfrim = uiLink:Get("btnConfrim"):GetComponent("Button");
    btnBack = uiLink:Get("btnBack"):GetComponent("Button");
    tranFull = uiLink:Get("tranFull"):GetComponent("RectTransform");
    tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    tranContentH = uiLink:Get("tranContentH"):GetComponent("RectTransform");
    tranRewards = uiLink:Get("tranRewards"):GetComponent("RectTransform");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    rawImageIcon = uiLink:Get("rawImageIcon"):GetComponent("RawImage");
    textNum = uiLink:Get("textCostCount"):GetComponent("Text");
    textCostCount = uiLink:Get("textNum"):GetComponent("Text");
    btnFinishObjTb[1] = uiLink:Get("goFinshD")
    btnFinishObjTb[5] = uiLink:Get("goFinshW")
    btnFinishObjTb[2] = uiLink:Get("goFinshF")
    btnFinishObjTb[4] = uiLink:Get("goFinshCa")
    btnFinishObjTb[3] = uiLink:Get("goFinshCu")
    btnFinishTextTb[1] = uiLink:Get("txtNumD"):GetComponent("Text");
    btnFinishTextTb[5] = uiLink:Get("txtNumW"):GetComponent("Text");
    btnFinishTextTb[2] = uiLink:Get("txtNumF"):GetComponent("Text");
    btnFinishTextTb[4] = uiLink:Get("txtNumCa"):GetComponent("Text");
    btnFinishTextTb[3] = uiLink:Get("txtNumCu"):GetComponent("Text");
    characterDrawing = uiLink:Get("goBody"):GetComponent("DrawingAdjustTool");
    spineCharacter = uiLink:Get("goBody"):GetComponent("UISpineCharacter");
    msgContent = uiLink:Get("txtContent"):GetComponent("Text");
    btnClick = uiLink:Get("btnClick"):GetComponent("Button");
    this.AddRegister(uiLink)
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    goodItem = nil;
    good = nil;
    root = nil;
    Middle = nil;
    Right = nil;
    goPanel1 = nil;
    goPanel2 = nil;
    goPanel3 = nil;
    Left = nil;
    btnWepon = nil;
    btnDiamond = nil;
    btnFurniture = nil;
    btnCard = nil;
    btnCultivate = nil;
    btnReward = nil;
    btnAdd = nil;
    btnSubtract = nil;
    btnMax = nil;
    btnMin = nil;
    btnConfrim = nil;
    btnBack = nil;
    tranFull = nil;
    tranContent = nil;
    tranRewards = nil;
    ScrollView = nil;
    rawImageIcon = nil;
    textCostCount = nil;
    textNum = nil;
    btnFinishObjTb = nil;
    btnFinishTextTb = nil;
    goBg2 = nil;
    goBg1 = nil;
    goPanel1Bg2 = nil;
    goPanel1Bg1 = nil;
    goPanel2Bg2 = nil;
    goPanel2Bg1 = nil;
    goPanel3Bg2 = nil;
    goPanel3Bg1 = nil;
    ScrollViewH = nil;
    tranContentH = nil;
    characterDrawing = nil;
    spineCharacter = nil;
    msgContent = nil
    btnClick = nil
end


this.AddRegister = function(uiLink)
    uiLink:AddClickEvent("btnWepon", function()
        this.SetRewardData(this.btnTypeTab[5], btnWepon)
    end)
    uiLink:AddClickEvent("btnDiamond", function()
        this.SetRewardData(this.btnTypeTab[1], btnDiamond)
    end)
    uiLink:AddClickEvent("btnFurniture", function()
        this.SetRewardData(this.btnTypeTab[2], btnFurniture)
    end)
    uiLink:AddClickEvent("btnCard", function()
        this.SetRewardData(this.btnTypeTab[4], btnCard)
    end)
    uiLink:AddClickEvent("btnCultivate", function()
        this.SetRewardData(this.btnTypeTab[3], btnCultivate)
    end)
    uiLink:AddClickEvent("btnAdd", function()
        this.UpdateDrawCount(1, 1)
    end)
    uiLink:AddClickEvent("btnSubtract", function()
        this.UpdateDrawCount(1, -1)
    end)
    uiLink:AddClickEvent("btnMax", function()
        this.UpdateDrawCount(playDrawTotalCount)
    end)
    uiLink:AddClickEvent("btnMin", function()
        this.UpdateDrawCount(1)
    end)
    uiLink:AddClickEvent("btnBack", function()
        if curPage ~= 1 then
            this.SetPanelState(1)
            curPage = 1;
        else
            LuaMgr.HidePanel(UIName.MainLine1PrizeViewModel)
        end
    end)
    uiLink:AddClickEvent("btnReward", function()
        if playDrawTotalCount <= 0 then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,
                ConfigMgr.LangGlobal(LuaMgr.GetLangText("NianBeastPrizeViewModel_0")))
            return
        end
        if myMaxDrawCount <= 0 then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15510"))
            return
        end
        if askStop then return end;
        this.OnAskDrawReward()
    end)
    uiLink:AddClickEvent("btnConfrim", function()
        this.SetPanelState(2)
    end)
    uiLink:AddClickEvent("btnClick", function()
        this.OnClickCharacter()
    end)   
end


this.OnAskDrawReward = function()
    askStop = true;
    local askData = { Group = tostring(groupId), Count = buyCount };
    btnReward.enabled = false
    ApiMgr.Request("draw/drawReward", askData, true, function(result)
        local re = json.decode(result)
        this.ShowRewardsEffect(re.result.Reward)
    end, function(...)
        btnReward.enabled = true
        askStop = false;
    end, true);
end

this.ShowRewardsEffect = function(reward)
    local endIndex = 0
    local totalTime = 0.5
    local speed = 1
    local frameTime = 0.02
    local currentIndex = 1
    local currentTime = 0
    local itemList = {}
    local endId = nil
    for i, v in pairs(reward.Items) do
        endId = v.id
        break
    end
    if (endId == nil) then
        for i, v in pairs(reward.Equipments) do
            local equipData = table.Copy(DataMgr.Player.equipments[v]);
            endId = equipData.equipmentId
        end
    end
    if (endId == nil) then return end
    for i, v in ipairs(this.rewardsHUIList.itemList) do
        local cacheList = v.goodsUIList.itemList
        for key, value in ipairs(cacheList) do
            if (not value:CheckSellOut()) then
                if (endId == value:GetRewardId()) then
                    endIndex = i
                end
                table.insert(itemList, value)
            end
        end
    end
    for i, v in ipairs(this.rewardsUIList.itemList) do
        local cacheList = v.goodsUIList.itemList
        for key, value in ipairs(cacheList) do
            if (not value:CheckSellOut()) then
                if (endId == value:GetRewardId()) then
                    endIndex = i
                end
                table.insert(itemList, value)
            end
        end
    end

    local update = function(deltaTime)
        currentTime = currentTime + deltaTime
        local currentSpeed = speed * math.exp(-currentTime / totalTime)
        currentIndex = currentIndex + currentSpeed * deltaTime
        if currentIndex > #itemList then
            currentIndex = currentIndex - #itemList
        end
        currentIndex = math.floor(currentIndex) + 1
        for i, v in ipairs(itemList) do
            v:ShowEffect(i == currentIndex)
        end
        if currentIndex == endIndex and currentTime >= totalTime then
            return true
        end
        return false
    end

    if this.animationCo ~= nil then
        coroutine_runner.stop(this.animationCo);
        this.animationCo = nil;
    end
    this.animationCo = coroutine_runner.start(function()
        while true do
            if update(frameTime) then
                this.SetPanelState(3)
                this.ShowRewards(reward);
                this.SetRewardList();
                this.SetCostInfo();
                btnReward.enabled = true
                break
            end
            coroutine_runner.wait(frameTime)
        end
        this.animationCo = nil;
    end)
end





local data = {
}


local command = {
}


local hook = {
    before_awake = function(vm)
        this.vm = vm;
        this.Init(vm.behaviour)
        this.rewardsUIList = UIListView.New(tranContent)
        this.rewardsHUIList = UIListView.New(tranContentH)
        this.rewardItemObj = vm.behaviour.transform:Find("template/rewardItem").gameObject;
        this.goodItemObj = vm.behaviour.transform:Find("template/goodItem").gameObject;
        rootAnimator = root.transform:GetComponent("Animator");
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            vm.behaviour:UpdateTopBar("", this.OnBack);
            this.CheckSwitchType()
            btnReward.enabled = true
            askStop = false;

            cfgDrawMap = ConfigMgr.Config.DrawMap;
            this.SetPanelState(1)

            curPage = 1;
            rootAnimator:Play("ani_NianBeastPrizePanel_root");
            this.SetCharacter();
            LuaMgr.AddTimer(TimerConst.SGYShopMsgTime, this.SetMsg, 10, -1, true);
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then

        end
        HeroRedDataHelper.ShowRewardNum()
        RedMgr.Singleton:Refresh();
        if this.animationCo ~= nil then
            coroutine_runner.stop(this.animationCo);
            this.animationCo = nil;
        end
        if (spineCharacter ~= nil) then
            spineCharacter:Clear();
        end
        LuaMgr.RemoveTimer(TimerConst.SGYShopMsgTime);
    end,
    before_destroy = function()
        UIListView.ClearItem("MainLine1PrizeRewardItem")
        UIListView.ClearItem("MainLine1PrizeGoodItem")
        this.Clear();
        itemList = nil;
    end
}

this.OnBack = function()
    if curPage ~= 1 then
        this.SetPanelState(1)
        curPage = 1;
    else
        LuaMgr.Back()
    end
end


this.SetCharacter = function()
    local weiSuoShopSpine = ConfigMgr.Config.constants.MainShopSpine;
    if(weiSuoShopSpine == nil)then
        LuaDebug.error("ConfigMgr.Config.constants.MainShopSpine 配置需要检查，没有读到内容")
        return
    end
    local path = HeroManager.SetCharacterDrawing(spineCharacter, weiSuoShopSpine[1], weiSuoShopSpine[2]);
    if (path ~= "" and characterDrawing ~= nil) then
        characterDrawing.Sprite = path;
    end
end

this.CheckSwitchType = function()
    local showType1 = ConfigMainLineMgr.CheckCanSwitch()
    local type1 = { 41, 42, 43, 44, 45 }
    local type2 = { 51, 52, 53, 54, 55 }
    this.btnTypeTab = showType1 and type1 or type2;
    SetActive(goBg1, showType1)
    SetActive(goBg2, not showType1)
    SetActive(goPanel1Bg1, showType1)
    SetActive(goPanel1Bg2, not showType1)
    SetActive(goPanel2Bg1, showType1)
    SetActive(goPanel2Bg2, not showType1)
    SetActive(goPanel3Bg1, showType1)
    SetActive(goPanel3Bg2, not showType1)
end

this.SetPanelState = function(index)
    SetActive(goPanel1, index == 1)
    SetActive(goPanel3, index == 3);
    SetActive(goPanel2, index == 2);
    if (index == 1) then
        for i, v in pairs(btnFinishObjTb) do
            local groupId = this.btnTypeTab[i];
            SetActive(v, this.checkPanelFinsh(i, groupId))
        end
    end
end

this.checkPanelFinsh = function(index, curGroupId)
    local curDrawA = nil
    local drawActList = {}
    for i, v in pairs(ConfigMgr.Config.DrawActivityMap) do
        if v.Group == tostring(curGroupId) then
            table.insert(drawActList, v);
            if DataMgr.Player.drawRewardProgress[tostring(curGroupId)] ~= nil then
                curDrawA = v;
            end
        end
    end
    if curDrawA == nil then
        curDrawA = drawActList[1];
    end
    local totalNum = 0
    local getNum = 0
    for i, v in ipairs(curDrawA.Content) do
        local drawItem = cfgDrawMap[v];
        local curNum = this.GetRewardItemBuyCount(curDrawA.ID, drawItem.ID)
        totalNum = totalNum + drawItem.Time
        getNum = getNum + curNum
    end
    local finish = getNum >= totalNum
    local str = nil
    if (totalNum > 300) then
        str = LuaMgr.GetLangText("MainLine1PrizeViewModel_0")
    else
        if (finish) then
            str = string.format("<color=#43c297>%s/%s</color>", getNum, totalNum)
        else
            str = string.format("%s<color=#ceb78d>/%s</color>", getNum, totalNum)
        end
    end
    btnFinishTextTb[index].text = str
    return finish
end


this.DOMove = function(posIndex, callBack)
    curPage = posIndex;
    DOTWeen.To(function() return tranFull.anchoredPosition end, function(vector)
        tranFull.anchoredPosition = vector;
    end, posList[posIndex], 0.5).onComplete = function()
        tranFull.anchoredPosition = posList[posIndex];
        if callBack ~= nil then
            callBack();
        end
    end
end

this.SetRewardData = function(group, btn)
    groupId = group;
    curDrawActivity = nil;
    local drawActList = {}
    for i, v in pairs(ConfigMgr.Config.DrawActivityMap) do
        if v.Group == tostring(groupId) then
            table.insert(drawActList, v);
            if DataMgr.Player.drawRewardProgress[tostring(groupId)] ~= nil then
                curDrawActivity = v;
            end
        end
    end
    if curDrawActivity == nil then
        curDrawActivity = drawActList[1];
    end

    buyCount = 1;
    this.SetRewardList()
    this.SetCostInfo();
    this.SetPanelState(2)
    curPage = 2;

end


this.SetCostInfo = function()
    local drawConsume = curDrawActivity.Consume[1];
    local playerTotalCount = DataHelper.GetItemCountById(drawConsume.id);
    local priceIconPath = ConfigHelper.GetItemIconPath(drawConsume.id);
    rawImageIcon.texture = LuaMgr.GetTexture(priceIconPath);
    textCostCount.text = drawConsume.count;
    playDrawTotalCount = math.floor(playerTotalCount / drawConsume.count);
    myMaxDrawCount = playDrawTotalCount > drawTotalCount and drawTotalCount or playDrawTotalCount;
    this.UpdateDrawCount(buyCount);
end



this.UpdateDrawCount = function(value, dir)
    if dir == nil then
        buyCount = value;
    else
        if dir > 0 then
            buyCount = buyCount + value;
        elseif dir < 0 then
            buyCount = buyCount - value;
        end
    end
    if buyCount > myMaxDrawCount then
        buyCount = myMaxDrawCount > 0 and myMaxDrawCount or 1;
    elseif buyCount < 1 then
        buyCount = 1;
    end
    local drawStr = LuaMgr.GetLangText("GuoBaoDrawViewModel_0");
    textNum.text = string.format(drawStr, buyCount);   

    local countText = playDrawTotalCount == 0
        and string.format("<color=#FD0B0B>%s</color>", LuaMgr.NumFormat(buyCount * curDrawActivity.Consume[1].count))
        or LuaMgr.NumFormat(buyCount * curDrawActivity.Consume[1].count);
    textCostCount.text =  countText;
end



this.SetRewardList = function()
    local showType1 = ConfigMainLineMgr.CheckCanSwitch()
    askStop = false;
    local drawTypeMap = {}
    drawTotalCount = 0;
    for i, v in ipairs(curDrawActivity.Content) do
        local drawItem = cfgDrawMap[v];
        drawItem.reCount = drawItem.Time - this.GetRewardItemBuyCount(curDrawActivity.ID, drawItem.ID)
        drawTotalCount = drawTotalCount + drawItem.reCount;
        if drawTypeMap[drawItem.Type] == nil then
            drawTypeMap[drawItem.Type] = {}
        end
        table.insert(drawTypeMap[drawItem.Type], drawItem);
    end
    local drawTypeList = {}
    for i, v in pairs(drawTypeMap) do
        table.insert(drawTypeList, { type = i, data = v })
    end
    table.sort(drawTypeList, function(a, b) return a.type < b.type end);
    local list1 = {}
    local list2 = {}
    for i, v in ipairs(drawTypeList) do
        local typeItem = {
            index = i,
            type = v.type,
            dataList = v.data,
            goodItemObj = this.goodItemObj,
            showType1 = showType1
        }
        local typeData = UIListData.GetData(this.rewardItemObj, "MainLine1PrizeRewardItem", typeItem);
        if (v.type == 1) then
            table.insert(list1, typeData);
        else
            table.insert(list2, typeData);
        end
    end
    this.rewardsUIList:SetData(list2);
    this.rewardsHUIList:SetData(list1);
    tranContent.anchoredPosition = Vector2.zero
end



this.GetRewardItemBuyCount = function(drawId, id)
    if DataMgr.Player.drawRewardRecords ~= nil then
        local key = string.format("%s_%s", drawId, id);
        local hasBuyCount = DataMgr.Player.drawRewardRecords[key];
        if hasBuyCount ~= nil then
            return hasBuyCount;
        end
    end
    return 0;
end


this.ShowRewards = function(Reward)
    rootAnimator:Play("ani_NianBeastPrizePanel_goPanel3");
    this.ClearItems()
    tranRewards.anchoredPosition = Vector2(0, 0);
    local index = 1;
    for i, v in pairs(Reward.Items) do
        if itemList[index] == nil then
            local item = GoodsDataItem.New(tranRewards)
            table.insert(itemList, item);
        end
        SetActive(itemList[index].transform.gameObject, true);
        local itemConfig = table.Copy(ConfigMgr.Config.itemMap[v.id]);
        itemConfig["count0"] = v.count
        itemList[index]:SetData(index, itemConfig, 1, false, Vector3(0.8, 0.8, 1), false)
        index = index + 1;
    end
    for i, v in pairs(Reward.Equipments) do
        if itemList[index] == nil then
            local item = GoodsDataItem.New(tranRewards)
            table.insert(itemList, item);
        end
        SetActive(itemList[index].transform.gameObject, true);
        local equipData = table.Copy(DataMgr.Player.equipments[v]);
        local equipConfig = ConfigMgr.Config.equipments[equipData.equipmentId]
        equipData.choose = false;
        equipData.wearBool = false;
        equipData.rare = equipConfig.rare;
        equipData.isVisiable = false;
        itemList[index]:SetData(index, equipData, 2, false, Vector3(0.8, 0.8, 1), false)
        index = index + 1;
    end
end

this.ClearItems = function()
    for i, v in ipairs(itemList) do
        SetActive(v.transform.gameObject, false);
    end
end


this.SetMsg = function()
    local len = #this.msgList;
    local index = math.random(1, len);
    if (this.msgIndex ~= index) then
        this.msgIndex = index;
    else
        if (index >= len) then
            this.msgIndex = index - 1;
        else
            this.msgIndex = index + 1;
        end
    end
    msgContent.text = ConfigMgr.LangGlobal(this.msgList[this.msgIndex]);
end


this.OnClickCharacter = function()
    this.SetMsg();
    LuaMgr.RemoveTimer(TimerConst.SGYShopMsgTime);
    LuaMgr.AddTimer(TimerConst.SGYShopMsgTime, this.SetMsg, 10, -1, true);
end

return vm({
    data = data,
    command = command,
    hook = hook
})