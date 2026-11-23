local this = {
    itemList = nil,
    rewardData = nil,
    orderCount = 0,
}

local objs = {
    serveNum = { path = "root/Middle/Result/ServeNum", type = "Text" },
    rewardsTF = { path = "root/Middle/Result/Rewards", type = "Transform" },
    startGameBtn = { path = "root/Middle/Result/StartGame", type = "Button" },
    confirmBtn = { path = "root/Middle/Result/Confirm", type = "Button" },
}


this.SetData = function()
    this.serveNum.text = tostring(YPSGameCharacterMgr.GetServeNum());
    this.SetRewards();
    YPSGameMgr.PlayAudio("tag_complete");
end


this.SetRewards = function()
    if (this.itemList == nil) then
        this.itemList = {};
    end
    local index = 0;
    local rewardItems = this.rewardData.Items;
    if (not IsNull(rewardItems)) then
        local item;
        local itemData;
        for _, v in pairs(rewardItems) do
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
    if(YPSMgr.CheckChallengeTimes() == false)then
        return
    end
    LuaMgr.HidePanel(UIName.YPSGameResultViewModel);
    LuaMgr.InvokeUIEventListeners(UIEventConst.YPSGameRestart);
end


this.OnClickConfirm = function()
    LuaMgr.HidePanel(UIName.YPSGameResultViewModel);
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
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/hightea_correct.mp3");
        this.rewardData = vm.behaviour.Params[0];
        this.orderCount = vm.behaviour.Params[1];
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