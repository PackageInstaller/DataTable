local this = {
    itemList = nil,
    rewardData = nil,
    orderCount = 0,
}

local objs = {
    characterDrawing = { path = "root/Middle/Result/Character/Body", type = "DrawingAdjustTool" },
    spineCharacter = { path = "root/Middle/Result/Character/Body", type = "UISpineCharacter" },
    title1 = { path = "root/Middle/Result/Title1", type = "GameObject" },
    title2 = { path = "root/Middle/Result/Title2", type = "GameObject" },
    title3 = { path = "root/Middle/Result/Title3", type = "GameObject" },
    serveNum = { path = "root/Middle/Result/ServeNum", type = "Text" },
    rewardsTF = { path = "root/Middle/Result/Rewards", type = "Transform" },
    startGameBtn = { path = "root/Middle/Result/StartGame", type = "Button" },
    confirmBtn = { path = "root/Middle/Result/Confirm", type = "Button" },
}


this.SetData = function()
    local mixConstants = ConfigMgr.Config.MixConstants;
    local index = this.GetOrderLevel();
    local finishShow1 = mixConstants.FinishShow_1[index];
    SetActive(this.title1, finishShow1 == "ui_hd_zd_js1");
    SetActive(this.title2, finishShow1 == "ui_hd_zd_js2");
    SetActive(this.title3, finishShow1 == "ui_hd_zd_js3");
    this.serveNum.text = tostring(FoodComposeCharacterMgr.GetServeNum());
    this.SetRewards();
    local skinId = mixConstants.FinishShow_2[index];
    local characterId = string.sub(skinId, 1, 5);
    local path = HeroManager.SetCharacterDrawing(this.spineCharacter, characterId, skinId);
    if (path ~= "") then
        this.characterDrawing.Sprite = path;
    end
    FoodComposeMgr.PlayAudio("tag_complete");
end


this.GetOrderLevel = function()
    local countType = ConfigMgr.Config.MixConstants.CountType;
    local len = #countType - 1;
    for i = 1, len do
        if (this.orderCount >= countType[i][1] and this.orderCount < countType[i + 1][1]) then
            return countType[i][2];
        end
    end
    return 3;
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
            item:SetData(1, itemData, 1, false, Vector3(0.8, 0.8, 1));
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
    local maxCount = DataMgr.Player.MixGame.Challenge or 0
    if maxCount <= 0 then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7501")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    LuaMgr.HidePanel(UIName.FoodComposeResultViewModel);
    LuaMgr.InvokeUIEventListeners(UIEventConst.FoodComposeRestart);
end


this.OnClickConfirm = function()
    LuaMgr.HidePanel(UIName.FoodComposeResultViewModel);
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

        this.rewardData = vm.behaviour.Params[0];
        this.orderCount = vm.behaviour.Params[1];
        this.SetData();
    end,
    before_deactive = function(vm)
        if (this.spineCharacter ~= nil) then
            this.spineCharacter:Clear();
        end
        this.rewardData = nil;
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.startGameBtn, this.OnClickStartGame);
        LuaMgr.RemoveClick(this.confirmBtn, this.OnClickConfirm);
        this.spineCharacter = nil;
        this.DestroyRewards();
    end,
}

return vm({
    data = data,
    command = command,
    hook = hook
})