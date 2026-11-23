require("Qin/QinSurveyResultEnemyItem")

local this = {
    enemyList = nil,
    type = 0,
    gridData = nil,
    rewardList = {},
    CanBattle = false,
    dungeonConfig = nil
};

local objs = {

    maskBtn = { path = "root/Mask", type = "Button" },
    result1 = { path = "root/Middle/Result1", type = "GameObject" },
    result1Msg = { path = "root/Middle/Result1/Msg", type = "Text" },
    enemyItem = { path = "template/EnemyItem", type = "GameObject" },
    result1Ememys = { path = "root/Middle/Result1/Scroll View/Viewport/Enemys", type = "Transform" },
    result1HpTF = { path = "root/Middle/Result1/Hp", type = "Transform" },
    result1HpText = { path = "root/Middle/Result1/Hp", type = "Text" },
    result1LvText = { path = "root/Middle/Result1/Lv/LvNum", type = "Text" },
    result1BattleBtn = { path = "root/Middle/Result1/Group/Battle", type = "Button" },
    result1BattleText = { path = "root/Middle/Result1/Group/Battle/Count/Text", type = "Text" },
    result1BattleIcon = { path = "root/Middle/Result1/Group/Battle/Count/Text/Icon", type = "RawImage" },
    result1KillGO = { path = "root/Middle/Result1/Group/Kill", type = "GameObject" },
    result1KillBtn = { path = "root/Middle/Result1/Group/Kill", type = "Button" },
    result1KillCount = { path = "root/Middle/Result1/Group/Kill/Count/Text", type = "Text" },
    result1KillIcon = { path = "root/Middle/Result1/Group/Kill/Count/Text/Icon", type = "RawImage" },
    result1BoomBtn = { path = "root/Middle/Result1/Group/Boom", type = "Button" },
    result1BoomCount = { path = "root/Middle/Result1/Group/Boom/Count/Text", type = "Text" },
    result1BoomIcon = { path = "root/Middle/Result1/Group/Boom/Count/Text/Icon", type = "RawImage" },
    result2 = { path = "root/Middle/Result2", type = "GameObject" },
    result2ConfirmBtn = { path = "root/Middle/Result2/Confirm", type = "Button" },
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
    result5ConfirmBtn = { path = "root/Middle/Result5/Confirm", type = "Button" },
};


this.SetData = function()
    SetActive(this.result1, false);
    SetActive(this.result2, false);
    SetActive(this.result3, false);
    SetActive(this.result4, false);
    SetActive(this.result5, false);
    SetActive(this.result3Msg, false);       
    SetActive(this.result3Msg2, false);    
    if (this.type == QinSurveyResultType.Battle) then
        this.SetEnemys();
        if (this.gridData.Typ == QinSurveyGrid.Monster) then
            local killGridType = ConfigQinMgr.GetGridType(QinSurveyGrid.Kill);
            if (killGridType ~= nil) then
                local count = PlayerQinMgr.GetToolsCount(killGridType.ItemsID);
                if (count <= 0) then
                    this.result1KillCount.text = string.format("<color=#d30320>-%d</color>", 1);
                else
                    this.result1KillCount.text =  "-1";
                end                
                this.result1KillIcon.texture = GetItemTexture(killGridType.ItemsID);
            end
            SetActive(this.result1KillGO, true);
        else
            SetActive(this.result1KillGO, false);
        end
        local boomGridType = ConfigQinMgr.GetGridType(QinSurveyGrid.Boom);
        if (boomGridType ~= nil) then
            local count = PlayerQinMgr.GetToolsCount(boomGridType.ItemsID);
            if (count <= 0) then
                this.result1BoomCount.text = string.format("<color=#d30320>-%d</color>", 1);
            else
                this.result1BoomCount.text =  "-1";
            end
            this.result1BoomIcon.texture = GetItemTexture(boomGridType.ItemsID);
        end
        SetActive(this.result1, true);
    elseif (this.type == QinSurveyResultType.Lose) then
        SetActive(this.result2, true);
        AudioMgr.Singleton:PlayVoice(Path.audio_PATH.."DaQin/DQ_YP_07.mp3");
    elseif (this.type == QinSurveyResultType.NextLayer) then
        if(this.CheckGetAllGift())then
            SetActive(this.result3Msg, true); 
        else
            SetActive(this.result3Msg2, true); 
        end 
        SetActive(this.result3, true);       
    elseif (this.type == QinSurveyResultType.Leave) then
        SetActive(this.result4, true);
    elseif (this.type == QinSurveyResultType.Win) then
        this.SetReward();
        SetActive(this.result5, true);
        AudioMgr.Singleton:PlayVoice(Path.audio_PATH.."DaQin/DQ_YP_08.mp3");
    end
end

this.CheckGetAllGift = function()
    local qinMap = DataMgr.Player.Qin.QinMap;
    local len = #qinMap;
    this.giftNum = 0
    for i = 1, len do
        local boxType = qinMap[i].Typ
        if(boxType == 7 or  boxType == 8)then
            this.giftNum = this.giftNum +1
        end      
    end   
    local q = DataMgr.Player.Qin;    
    local curGrid = DataMgr.Player.Qin.Explore[q.StageId].ExploreRecords[""..q.Storey]
    if(curGrid ~= nil)then   
        for k, v in pairs(curGrid) do
            this.giftNum = this.giftNum - 1
        end
    end    
    return this.giftNum > 0
end


this.SetEnemys = function()
    this.enemyList:Clear();
    local monsterData = PlayerQinMgr.GetMonster(this.gridData.Index);   
    if (monsterData == nil) then return end
    
    local dungeonConfig = ConfigMgr.Config.dungeonMap[monsterData.MonsterId];
    if (dungeonConfig == nil) then return end

    local monster;
    local listData;
    local listDatas = {};
    local monstersJson = LuaMgr.UpdateMonsterIdList(monsterData.MonsterId);
    local monsters = json.decode(monstersJson);   
    local monsterMap = ConfigMgr.Config.monsterMap;
    local len = #monsters;
    for i = 1, len do
        monster = monsterMap[monsters[i]];
        if (monster ~= nil and not monster.hideShowinfo) then
            listData = UIListData.GetData(this.enemyItem, "QinSurveyResultEnemyItem", monster);
            table.insert(listDatas, listData);
        end
    end
    this.enemyList:SetData(listDatas);
    local ratio = (10000 - monsterData.MonsterHurt) / 10000;
    local percent = math.floor(ratio * 100);
    if (ratio > 0 and percent == 0) then
        percent = 1;
    end
    this.result1LvText.text = dungeonConfig.levelShow
    this.result1HpText.text = LuaMgr.GetLangText("QinSurveyResultViewModel_0") .. percent .. "%";

    this.SetBattleCostShow(dungeonConfig)
end

this.SetBattleCostShow = function (dungeonConfig)
    this.dungeonConfig = dungeonConfig
    local item = dungeonConfig.consumeItem[1]
    this.CanBattle = false
    if item ~= nil then
        local num = tonumber(dungeonConfig.levelNum)
        local config = ConfigMgr.Config.itemMap[item.id]
        if config ~= nil then
            this.result1BattleIcon.texture = LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/ItemIcons/itemicon_%s.png", config.id))            
            if item.count==0 then
                this.CanBattle = true
                this.result1BattleText.text = "<color=#ffffff>0</color>"
            else
                if item.id == "101" then
                    num = DataMgr.Player.stamina
                else
                    local itemData = DataMgr.Player.items[item.id]
                    if itemData ~= nil then
                        num = itemData.count0
                    end
                end
                this.CanBattle = num >= item.count
                this.result1BattleText.text = string.format("<color=%s>-%s</color>", this.CanBattle and "#ffffff" or "#d30320", item.count)
            end           
        end
    end
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
    if(this.type == QinSurveyResultType.Win or this.type == QinSurveyResultType.Lose)then
        this.OnClickConfirm5()
    else
        LuaMgr.HidePanel(UIName.QinSurveyResultViewModel);
    end  
end


this.OnClickBattle = function()
    local monster = PlayerQinMgr.GetMonster(this.gridData.Index);
    if (monster == nil) then return end
    if(not this.CanBattle and  this.dungeonConfig ~= nil)then
        LuaMgr.HidePanel(UIName.QinSurveyResultViewModel);
        LuaMgr.ShowLuaPanel("FatigueReplyViewModel")

        return
    end    
    local members = DataMgr.Player.Qin.Members;
    PlayerQinMgr.EnterDungeon(monster.MonsterId, members, this.gridData.Index);
end


this.OnClickKill = function()
    local gridType = ConfigQinMgr.GetGridType(QinSurveyGrid.Kill);
    if (gridType == nil) then return end

    local count = PlayerQinMgr.GetToolsCount(gridType.ItemsID);
    if (count <= 0) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("QinSurveyResultViewModel_1"));
        return;
    end
    AudioMgr.Singleton:PlayVoice(Path.audio_PATH.."DaQin/DQ_YP_09.mp3");
    PlayerQinMgr.UseTools(gridType.ItemsID, this.gridData.Index);
end


this.OnClickBoom = function()
    local gridType = ConfigQinMgr.GetGridType(QinSurveyGrid.Boom);
    if (gridType == nil) then return end
    
    local count = PlayerQinMgr.GetToolsCount(gridType.ItemsID);
    if (count <= 0) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("QinSurveyResultViewModel_2"));
        return;
    end
    AudioMgr.Singleton:PlayVoice(Path.audio_PATH.."DaQin/DQ_YP_10.mp3");
    PlayerQinMgr.UseTools(gridType.ItemsID, this.gridData.Index);
end


this.OnClickConfirm2 = function()
    LuaMgr.ShowLuaPanel(UIName.QinLevelViewModel, 2);
    LuaMgr.HidePanel(UIName.QinSurveyResultViewModel);
end


this.OnClickConfirm3 = function()
    LuaMgr.HidePanel(UIName.QinSurveyResultViewModel);
end


this.OnClickGoto = function()
    PlayerQinMgr.Explore(this.gridData.Index);
    LuaMgr.HidePanel(UIName.QinSurveyResultViewModel);
end


this.OnClickConfirm4 = function()
    PlayerQinMgr.Settlement(QinSurveyResultType.Quit);
    LuaMgr.HidePanel(UIName.QinSurveyResultViewModel);
end


this.OnClickLeave = function()
    LuaMgr.ShowLuaPanel(UIName.QinLevelViewModel, 2);
    LuaMgr.HidePanel(UIName.QinSurveyResultViewModel);

end


this.OnClickConfirm5 = function()
    LuaMgr.ShowLuaPanel(UIName.QinLevelViewModel, 2);
    LuaMgr.HidePanel(UIName.QinSurveyResultViewModel);

end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.enemyList = UIListView.New(this.result1Ememys);
        LuaMgr.AddClick(this.maskBtn, this.OnClickMask);
        LuaMgr.AddClick(this.result1BattleBtn, this.OnClickBattle);
        LuaMgr.AddClick(this.result1KillBtn, this.OnClickKill);
        LuaMgr.AddClick(this.result1BoomBtn, this.OnClickBoom);
        LuaMgr.AddClick(this.result2ConfirmBtn, this.OnClickConfirm2);
        LuaMgr.AddClick(this.result3ConfirmBtn, this.OnClickConfirm3);
        LuaMgr.AddClick(this.result3GotoBtn, this.OnClickGoto);
        LuaMgr.AddClick(this.result4ConfirmBtn, this.OnClickConfirm4);
        LuaMgr.AddClick(this.result4LeaveBtn, this.OnClickLeave);
        LuaMgr.AddClick(this.result5ConfirmBtn, this.OnClickConfirm5);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        

        local len = vm.behaviour.Params.Length;
        this.type = vm.behaviour.Params[0];
        if (len >= 2) then
            if (this.type == QinSurveyResultType.Win) then
                this.rewardData = vm.behaviour.Params[1];
            else
                this.gridData = vm.behaviour.Params[1];
            end
        end
        this.SetData();
    end,
    before_deactive = function(vm)
        this.enemyList:Clear();
        this.gridData = nil;
        this.rewardData = nil;
        this.dungeonConfig = nil
        this.CanBattle = false
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickMask);
        LuaMgr.RemoveClick(this.result1BattleBtn, this.OnClickBattle);
        LuaMgr.RemoveClick(this.result1KillBtn, this.OnClickKill);
        LuaMgr.RemoveClick(this.result1BoomBtn, this.OnClickBoom);
        LuaMgr.RemoveClick(this.result2ConfirmBtn, this.OnClickConfirm2);
        LuaMgr.RemoveClick(this.result3ConfirmBtn, this.OnClickConfirm3);
        LuaMgr.RemoveClick(this.result3GotoBtn, this.OnClickGoto);
        LuaMgr.RemoveClick(this.result4ConfirmBtn, this.OnClickConfirm4);
        LuaMgr.RemoveClick(this.result4LeaveBtn, this.OnClickLeave);
        LuaMgr.RemoveClick(this.result5ConfirmBtn, this.OnClickConfirm5);
        this.ClearReward();
        UIListView.ClearItem("QinSurveyResultEnemyItem");
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})