local this = {
    itemList = nil,
    levelData = nil,
    curItemConfig = nil,
    nextItemConfig = nil,
    baseScore = nil,
    addScore = nil,
    isInitStar = true,
    stars = {},
    addTimes = nil,
    minusScore = nil,
    minusTimes = nil,
    addStepScore = nil,
    totalStep = nil,
}

local objs = {
    imageScore = { path = "root/Middle/Result/ImageScore", type = "Transform" },
    serveNum = { path = "root/Middle/Result/ImageScore/ServeNum", type = "Text" },
    imageReward = { path = "root/Middle/Result/ImageReward/Rewards", type = "GameObject" },
    rewardsTF = { path = "root/Middle/Result/ImageReward/Rewards", type = "Transform" },
    startGameBtn = { path = "root/Middle/Result/BtnBox/StartGame", type = "Button" },
    confirmBtn = { path = "root/Middle/Result/BtnBox/Confirm", type = "Button" },
    backBtn = { path = "root/Left/Back", type = "Button" },
    textAddNum = { path = "root/Middle/Result/NumBox/ImageAdd/TextNum", type = "Text" },
    textMinusNum = { path = "root/Middle/Result/NumBox/ImageMinus/TextNum", type = "Text" },
    textStepsNum = { path = "root/Middle/Result/NumBox/ImageSteps/TextNum", type = "Text" },
    textAddTimesNum = { path = "root/Middle/Result/NumBox/ImageAdd/TextTimes", type = "Text" },
    textMinusTimesNum = { path = "root/Middle/Result/NumBox/ImageMinus/TextTimes", type = "Text" },
    textStepsTimesNum = { path = "root/Middle/Result/NumBox/ImageSteps/TextTimes", type = "Text" },
    healthBg = { path = "root/Middle/Result/HealthBg", type = "RectTransform" },
}


this.SetData = function()
    this.isInitStar = true
    this.serveNum.text = this.baseScore;
    local cacheCofig = ConfigMgr.Config.HackGameElementMap
    this.textStepsNum.text = "+" .. tonumber(cacheCofig["1003"].Score) * -1
    this.textAddNum.text = "+" .. cacheCofig["1004"].Score
    this.textMinusNum.text = cacheCofig["1005"].Score
    this.SetRewards();
    this.RefreshScore()

end


this.SetRewards = function()
    if (this.itemList == nil) then
        this.itemList = {};
    end
    local index = 0;
    if (this.levelData ~= nil and not IsNull(this.levelData.Reward) and not this.isFinish) then
        SetActive(this.imageReward, true);
        local item;
        local itemData;
        for _, v in pairs(this.levelData.Reward) do
            index = index + 1;
            item = this.itemList[index];
            if (item == nil) then
                item = GoodsDataItem.New(this.rewardsTF);
                this.itemList[index] = item;
            end
            itemData = table.Copy(ConfigMgr.Config.itemMap[v.id]);
            itemData.count0 = v.count;
            item:SetData(1, itemData, 1, false, Vector3(0.6, 0.6, 1));
            item:SetIconBg(false);
        end
    else
        SetActive(this.imageReward, false);
    end
    local rlen = #this.itemList;
    for i = index + 1, rlen do
        this.itemList[i]:Hide();
    end
end


this.DestroyRewards = function()
    if (this.itemList ~= nil) then
        local len = #this.itemList;
        for i = 1, len do
            this.itemList[i]:Clear();
        end
        this.itemList = nil;
    end
end

this.InitStar = function()
    for i = 1, this.healthBg.childCount do
        local star = this.healthBg:GetChild(i - 1)
        local star1 = star.transform:GetChild(3)
        this.stars[i] = {
            star = star,
            star1 = star1,
        }
    end
end

this.RefreshScore = function()
    this.textAddTimesNum.text = "x" .. this.addTimes
    this.textMinusTimesNum.text = "x" .. this.minusTimes
    this.textStepsTimesNum.text = LuaMgr.GetLangText("FSMYGameResultViewModel_0") .. this.totalStep
    local levelConfig = this.levelData
    if not levelConfig then return end
    if (this.isInitStar) then
        for i = 1, #this.stars do
            local star = this.stars[i]
            SetActive(star.star.gameObject, false)
        end
    end
    for i, v in ipairs(levelConfig.Conditions) do
        local star = this.stars[i]
        if (this.isInitStar) then
            SetActive(star.star.gameObject, true)
        end
        if (v <= this.baseScore) then
            star.star1.gameObject:SetActive(true)
        else
            star.star1.gameObject:SetActive(false)
        end
    end
    this.isInitStar = false
end




this.OnClickStartGame = function()
    LuaMgr.InvokeUIEventListeners(UIEventConst.FSMYGameRestart);
    LuaMgr.HidePanel(UIName.FSMYGameResultViewModel);
end


this.OnClickConfirm = function()
    LuaMgr.InvokeUIEventListeners(UIEventConst.FSMYPlayGame, this.nextItemConfig);
    LuaMgr.HidePanel(UIName.FSMYGameResultViewModel);
end

this.OnClickBack = function()
    LuaMgr.HidePanel(UIName.FSMYGameResultViewModel);
    LuaMgr.Back();
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.startGameBtn, this.OnClickStartGame);
        LuaMgr.AddClick(this.confirmBtn, this.OnClickConfirm);
        LuaMgr.AddClick(this.backBtn, this.OnClickBack);
        this.InitStar()
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.curItemConfig = vm.behaviour.Params[0];
        local dataBox = vm.behaviour.Params[1];
        this.baseScore = dataBox.baseScore
        this.addScore = dataBox.addScore
        this.addTimes = dataBox.addTimes
        this.minusScore = dataBox.minusScore
        this.minusTimes = dataBox.minusTimes
        this.addStepScore = dataBox.addStepScore
        this.totalStep = dataBox.totalStep
        this.isFinish = dataBox.isFinish
        this.levelData = ConfigMgr.Config.HackGameLevelMap[this.curItemConfig.eventParam]
        this.nextItemConfig = nil
        local cacheList = FSMYMgr.GetActiveEventsByArea("FSMY5")
        local curIndex = -1
        for i, v in ipairs(cacheList) do
            if (this.curItemConfig.id == v.id) then
                curIndex = i
            end
            if (curIndex + 1 == i) then
                this.nextItemConfig = v
                break
            end
        end
        if (this.nextItemConfig ~= nil) then
            SetActive(this.confirmBtn.gameObject, true)
        else
            SetActive(this.confirmBtn.gameObject, false)
        end
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "Parkour/DH_parkour_7.mp3");
        this.SetData();
    end,
    before_deactive = function(vm)
        this.curItemConfig = nil
        this.nextItemConfig = nil
        this.levelData = nil;
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.startGameBtn, this.OnClickStartGame);
        LuaMgr.RemoveClick(this.confirmBtn, this.OnClickConfirm);
        LuaMgr.RemoveClick(this.backBtn, this.OnClickBack);
        this.DestroyRewards();
    end,
}

return vm({
    data = data,
    command = command,
    hook = hook
})