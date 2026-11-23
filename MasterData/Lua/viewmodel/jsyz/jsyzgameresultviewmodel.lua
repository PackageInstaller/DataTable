local this = {
    itemList = nil,
    rewardData = nil,
}

local objs = {
    imageScore = { path = "root/Middle/Result/ImageScore", type = "Transform" },
    serveNum = { path = "root/Middle/Result/ImageScore/ServeNum", type = "Text" },
    textTitle = { path = "root/Middle/Result/TextTitle", type = "Text" },
    imageReward = { path = "root/Middle/Result/ImageReward", type = "GameObject" },
    rewardsTF = { path = "root/Middle/Result/ImageReward/Rewards", type = "Transform" },
    startGameBtn = { path = "root/Middle/Result/StartGame", type = "Button" },
    confirmBtn = { path = "root/Middle/Result/Confirm", type = "Button" },
}


this.SetData = function()    
    this.serveNum.text = JSYZGameMgr.GetGameState().player.score;
    this.SetRewards();

end


this.SetRewards = function()
    if (this.itemList == nil) then
        this.itemList = {};
    end
    local index = 0;
    if (this.rewardData ~= nil and not IsNull(this.rewardData.Items)) then
        SetActive(this.imageReward, true);
        this.imageScore.localPosition = Vector3(0, 85, 0);
        local item;
        local itemData;
        for _, v in pairs(this.rewardData.Items) do
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
        this.imageScore.localPosition = Vector3(0, 50, 0);
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



    LuaMgr.HidePanel(UIName.JSYZGameResultViewModel);
    LuaMgr.InvokeUIEventListeners(UIEventConst.JSYZGameRestart);
end


this.OnClickConfirm = function()
    LuaMgr.HidePanel(UIName.JSYZGameResultViewModel);
    LuaMgr.Back();
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.startGameBtn, this.OnClickStartGame);
        LuaMgr.AddClick(this.confirmBtn, this.OnClickConfirm);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        local isFinish = vm.behaviour.Params[0];
        this.rewardData = vm.behaviour.Params[1];
        if (isFinish) then
            this.textTitle.text = LuaMgr.GetLangText("JSYZGameResultViewModel_0")
        else
            this.textTitle.text = LuaMgr.GetLangText("JSYZGameResultViewModel_1")
        end
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "Parkour/DH_parkour_7.mp3");
        this.SetData();
    end,
    before_deactive = function(vm)
        this.rewardData = nil;
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.startGameBtn, this.OnClickStartGame);
        LuaMgr.RemoveClick(this.confirmBtn, this.OnClickConfirm);
        this.DestroyRewards();
    end,
}

return vm({
    data = data,
    command = command,
    hook = hook
})