local this = {
    itemList = nil,
    levelData = nil,
    curItemConfig = nil,
    nextItemConfig = nil,
}

local objs = {
    exitBtn = { path = "root/Middle/Result/Exit", type = "Button" },
    textRewardLab = { path = "root/Middle/Result/ImageReward/RewardLab", type = "Text" },
    imageReward = { path = "root/Middle/Result/ImageReward/Rewards", type = "GameObject" },
    rewardsTF = { path = "root/Middle/Result/ImageReward/Rewards", type = "Transform" },
    textReward = { path = "root/Middle/Result/ImageReward/Rewards/TextReward", type = "Text" },
    startGameBtn = { path = "root/Middle/Result/BtnBox/StartGame", type = "Button" },
    confirmBtn = { path = "root/Middle/Result/BtnBox/Confirm", type = "Button" },
    backBtn = { path = "root/Left/Back", type = "Button" },
}


this.SetData = function()

    this.SetRewardsText()

end

this.SetRewardsText = function()
    if not this.isFinish then
        SetActive(this.imageReward, true);
        this.textReward.text = string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_33204"),
            (this.levelData.Score or 0))
    else
        SetActive(this.imageReward, false);
    end
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


this.OnClickStartGame = function()
    LuaMgr.InvokeUIEventListeners(UIEventConst.WJWYGameRestart);
    LuaMgr.HidePanel(UIName.WJWYGameResultPanel);
end


this.OnClickConfirm = function()
    LuaMgr.InvokeUIEventListeners(UIEventConst.FSMYPlayGame, this.nextItemConfig);
    LuaMgr.HidePanel(UIName.WJWYGameResultPanel);
end

this.OnClickBack = function()
    LuaMgr.HidePanel(UIName.WJWYGameResultPanel);
    LuaMgr.Back();
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.startGameBtn, this.OnClickBack);
        LuaMgr.AddClick(this.exitBtn, this.OnClickBack);
        LuaMgr.AddClick(this.confirmBtn, this.OnClickConfirm);
        LuaMgr.AddClick(this.backBtn, this.OnClickBack);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.curItemConfig = vm.behaviour.Params[0];
        local dataBox = vm.behaviour.Params[1];
        this.isFinish = dataBox and dataBox.isFinish;
        this.levelData = ConfigMgr.Config.SurroundGameLevelMap[this.curItemConfig.eventParam]
        this.nextItemConfig = nil
        local cacheList = WJWYData.GetActiveEventsByArea("WJWY5")
        local curIndex = -1
        for i, v in ipairs(cacheList) do
            if (this.curItemConfig.id == v.id) then
                curIndex = i
            end
            if (curIndex + 1 == i) then
                local isUnLockTime, timeStr = WJWYData.CheckEventIsUnLockTime(v)
                if (isUnLockTime) then
                    this.nextItemConfig = v
                end
                break
            end
        end
        if (this.nextItemConfig ~= nil) then
            SetActive(this.confirmBtn.gameObject, true)
        else
            SetActive(this.confirmBtn.gameObject, false)
        end
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "Parkour/DH_parkour_7.mp3");
        this.textRewardLab.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_33205")
        this.SetData();
    end,
    before_deactive = function(vm)
        this.curItemConfig = nil
        this.nextItemConfig = nil
        this.levelData = nil;
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.startGameBtn, this.OnClickBack);
        LuaMgr.RemoveClick(this.exitBtn, this.OnClickBack);
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