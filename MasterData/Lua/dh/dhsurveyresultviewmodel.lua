require("DH/DHSurveyResultEnemyItem")

local this = {    
    type = 0,
    gridData = nil,
    battleData = nil,
    rewardList = {},
    CanBattle = false,
    dungeonConfig = nil,
    rewardData = nil,
    toolItem = nil
};

local objs = {

    maskBtn = { path = "root/Mask", type = "Button" },
    result1 = { path = "root/Middle/Result1", type = "GameObject" },
    result1Group = { path = "root/Middle/Result1/Group", type = "GameObject" },  
    result1BattleBtn = { path = "root/Middle/Result1/Group/Battle", type = "Button" },
    result1Title = { path = "root/Middle/Result1/Title/TextTitle", type = "Text" },
    result1Msg = { path = "root/Middle/Result1/ScrollView/Viewport/Content/Msg", type = "Text" },
    result1IconBox = { path = "root/Middle/Result1/IconBox", type = "Transform" },
    result1Cancel = { path = "root/Middle/Result1/Group/Cancel", type = "GameObject" },
    result1CancelBtn = { path = "root/Middle/Result1/Group/Cancel", type = "Button" },
    result2 = { path = "root/Middle/Result2", type = "GameObject" },
    result3 = { path = "root/Middle/Result3", type = "GameObject" },
    result3ConfirmBtn = { path = "root/Middle/Result3/Confirm", type = "Button" },
    result3GotoBtn = { path = "root/Middle/Result3/Goto", type = "Button" },
    result3Msg = { path = "root/Middle/Result3/Msg", type = "GameObject" },
    result3Msg2 = { path = "root/Middle/Result3/Msg2", type = "GameObject" },
    result4 = { path = "root/Middle/Result4", type = "GameObject" },
    result4ConfirmBtn = { path = "root/Middle/Result4/Confirm", type = "Button" },
    result4LeaveBtn = { path = "root/Middle/Result4/Leave", type = "Button" },
    result5 = { path = "root/Middle/Result5", type = "GameObject" },
    result5Items = { path = "root/Middle/Result5/Items", type = "Transform" },
    result5Msg = { path = "root/Middle/Result5/Msg", type = "Text" },
};


this.SetData = function()
    SetActive(this.result1, false);
    SetActive(this.result2, false);
    SetActive(this.result3, false);
    SetActive(this.result4, false);
    SetActive(this.result5, false);
    SetActive(this.result3Msg, false);
    SetActive(this.result3Msg2, false);
    if (this.type == DHSurveyResultType.Battle) then
        if (this.toolItem == nil) then
            this.toolItem = GoodsDataItem.New(this.result1IconBox);
            this.toolItem.goodsBtn.onClick:RemoveAllListeners();
        end
        local itemData = ConfigMgr.Config.itemMap[this.battleData.gridData.ItemsID]
        local scale = Vector3(0.82, 0.82, 1);
        this.toolItem:SetData(1, itemData, 1, false, scale, false, true);
        this.toolItem:SetIconBg(false);
        this.result1Title.text = LuaMgr.GetLangText(itemData.nameLan)
        this.result1Msg.text = LuaMgr.GetLangText(itemData.DescriptionLan)
        this.battleCallback = this.battleData.callback
        local type = this.battleData.gridData.GridType  
        local showBtn = type ~= DHSurveyGrid.UnDeath and type ~= DHSurveyGrid.Box2 and type ~= DHSurveyGrid.Box
        SetActive(this.result1Group, showBtn)
        SetActive(this.result1, true);
    elseif (this.type == DHSurveyResultType.Lose) then
        this.SetReward();
        SetActive(this.result5, true);
        AudioMgr.Singleton:PlayVoice(Path.audio_PATH .. "DH/DH_YP_03.mp3");
    elseif (this.type == DHSurveyResultType.NextLayer) then
        if (this.CheckGetAllGift()) then
            SetActive(this.result3Msg, true);
        else
            SetActive(this.result3Msg2, true);
        end
        SetActive(this.result3, true);
    elseif (this.type == DHSurveyResultType.Leave) then
        SetActive(this.result4, true);
    elseif (this.type == DHSurveyResultType.Win) then
        this.SetReward();
        SetActive(this.result5, true);
        AudioMgr.Singleton:PlayVoice(Path.audio_PATH .. "DH/DH_YP_04.mp3");
    end
end

this.CheckGetAllGift = function()
    local map = DataMgr.Player.DunHuang.DHMap;
    local len = #map;
    this.giftNum = 0
    for i = 1, len do
        local boxType = map[i].Typ
        if (boxType == 7 or boxType == 8) then
            this.giftNum = this.giftNum + 1
        end
    end
    local q = DataMgr.Player.DunHuang;
    local curGrid = DataMgr.Player.DunHuang.Explore[q.StageId].ExploreRecords["" .. q.Storey]
    if (curGrid ~= nil) then
        for k, v in pairs(curGrid) do
            this.giftNum = this.giftNum - 1
        end
    end
    return this.giftNum > 0
end


this.SetReward = function()
    local index = 1;
    if (this.rewardData ~= nil) then
        local item;
        local itemData;
        local scale = Vector3(0.6, 0.6, 1);
        for k, v in pairs(this.rewardData) do
            item = this.rewardList[index];
            if (item == nil) then
                item = GoodsDataItem.New(this.result5Items);
                this.rewardList[index] = item;
            end
            itemData = table.Copy(ConfigMgr.Config.itemMap[k]);
            itemData.count0 = v;
            item:SetData(index, itemData, 1, false, scale, false, false);
            index = index + 1;
        end
    end
    local len = #this.rewardList;
    for i = index, len do
        this.rewardList[i]:Hide();
    end   
    this.result5Msg.text = ConfigMgr.LangGlobal("22424")
    SetActive(this.result5Msg.gameObject,index == 1)
end


this.ClearReward = function()
    local len = #this.rewardList;
    if (len > 0) then
        for i = 1, len do
            this.rewardList[i]:Clear();
        end
        this.rewardList = {};
    end
end


this.OnClickMask = function()
    if (this.type == DHSurveyResultType.Win or this.type == DHSurveyResultType.Lose) then
        this.OnClickConfirm5()
    else
        LuaMgr.HidePanel(UIName.DHSurveyResultViewModel);
    end
end


this.OnClickBattle = function()
    if(this.battleCallback ~= nil)then
        this.battleCallback(this.battleData.gridData)
        LuaMgr.HidePanel(UIName.DHSurveyResultViewModel);
    end  
end


this.OnClickKill = function()
    local gridType = ConfigDHMgr.GetGridType(DHSurveyGrid.Kill);
    if (gridType == nil) then return end

    local count = PlayerDHMgr.GetToolsCount(gridType.ItemsID);
    if (count <= 0) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("QinSurveyResultViewModel_1"));
        return;
    end
    AudioMgr.Singleton:PlayVoice(Path.audio_PATH .. "DH/DH_YP_06.mp3");
    PlayerDHMgr.UseTools(gridType.ItemsID, this.gridData.Index);
end


this.OnClickBoom = function()
    local gridType = ConfigDHMgr.GetGridType(DHSurveyGrid.Boom);
    if (gridType == nil) then return end

    local count = PlayerDHMgr.GetToolsCount(gridType.ItemsID);
    if (count <= 0) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("QinSurveyResultViewModel_2"));
        return;
    end
    AudioMgr.Singleton:PlayVoice(Path.audio_PATH .. "DH/DH_YP_05.mp3");
    PlayerDHMgr.UseTools(gridType.ItemsID, this.gridData.Index);
end


this.OnClickConfirm3 = function()
    LuaMgr.HidePanel(UIName.DHSurveyResultViewModel);
end


this.OnClickCancel = function()
    LuaMgr.HidePanel(UIName.DHSurveyResultViewModel);
end


this.OnClickGoto = function()
    PlayerDHMgr.Explore(this.gridData.Index);
    LuaMgr.HidePanel(UIName.DHSurveyResultViewModel);
end


this.OnClickConfirm4 = function()
    PlayerDHMgr.Settlement(DHSurveyResultType.Quit);
    LuaMgr.HidePanel(UIName.DHSurveyResultViewModel);
end


this.OnClickLeave = function()
    LuaMgr.ShowLuaPanel(UIName.DHSeekViewModel);
    LuaMgr.HidePanel(UIName.DHSurveyResultViewModel);

end


this.OnClickConfirm5 = function()
    LuaMgr.ShowLuaPanel(UIName.DHSeekViewModel);
    LuaMgr.HidePanel(UIName.DHSurveyResultViewModel);

end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.maskBtn, this.OnClickMask);
        LuaMgr.AddClick(this.result1BattleBtn, this.OnClickBattle);
        LuaMgr.AddClick(this.result1CancelBtn, this.OnClickCancel);       
        LuaMgr.AddClick(this.result3ConfirmBtn, this.OnClickConfirm3);
        LuaMgr.AddClick(this.result3GotoBtn, this.OnClickGoto);
        LuaMgr.AddClick(this.result4ConfirmBtn, this.OnClickConfirm4);
        LuaMgr.AddClick(this.result4LeaveBtn, this.OnClickLeave);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end


        local len = vm.behaviour.Params.Length;
        this.type = vm.behaviour.Params[0];
        if (len >= 2) then
            if (this.type == DHSurveyResultType.Win or this.type == DHSurveyResultType.Lose) then
                this.rewardData = vm.behaviour.Params[1];
            elseif (this.type == DHSurveyResultType.Battle) then
                this.battleData = vm.behaviour.Params[1];
            else
                this.gridData = vm.behaviour.Params[1];
            end
        end
        this.SetData();
    end,
    before_deactive = function(vm)       
        this.gridData = nil;
        this.rewardData = nil;
        this.dungeonConfig = nil
        this.CanBattle = false
        this.battleData = nil
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickMask);
        LuaMgr.RemoveClick(this.result1BattleBtn, this.OnClickBattle);
        LuaMgr.RemoveClick(this.result1CancelBtn, this.OnClickCancel);
        LuaMgr.RemoveClick(this.result3ConfirmBtn, this.OnClickConfirm3);
        LuaMgr.RemoveClick(this.result3GotoBtn, this.OnClickGoto);
        LuaMgr.RemoveClick(this.result4ConfirmBtn, this.OnClickConfirm4);
        LuaMgr.RemoveClick(this.result4LeaveBtn, this.OnClickLeave);
        this.ClearReward();
        UIListView.ClearItem("DHSurveyResultEnemyItem");
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})