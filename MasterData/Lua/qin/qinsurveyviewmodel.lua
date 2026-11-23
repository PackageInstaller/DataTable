require("Qin/QinSurveyMapItem")
require("Qin/QinSurveyEffectItem")
require("Qin/QinSurveyMemberItem")

local this = {
    mapList = nil,
    memberList = nil,
    effectList = nil,
    rewardList = {},
    packageList = {},
    qinLevel = nil,  
    
};

local objs = {

    mapItem = { path = "template/MapItem", type = "GameObject" },
    mapListTF = { path = "root/Middle/Map/List", type = "Transform" },
    mapName = { path = "root/Middle/Map/Name", type = "Text" },
    memberItem = { path = "template/MemberItem", type = "GameObject" },
    membersListTF = { path = "root/Middle/Left/Members/List", type = "Transform" },
    membersHp = { path = "root/Middle/Left/Members/Hp", type = "Text" },
    membersCount = { path = "root/Middle/Left/Members/Count/Text", type = "Text" },
    membersCost = { path = "root/Middle/Left/Members/Cost/Text", type = "Text" },
    membersCostIcon = { path = "root/Middle/Left/Members/Cost/Text/Icon", type = "RawImage" },
    effectItem = { path = "template/EffectItem", type = "GameObject" },
    effectGO = { path = "root/Middle/Left/Effect", type = "GameObject" },
    effectListTF = { path = "root/Middle/Left/Effect/List", type = "Transform" },
    rewardListTF = { path = "root/Middle/Right/Reward/List", type = "Transform" },
    collectAllObj = { path = "root/Middle/Right/Reward/ImageCollectAll", type = "GameObject" },
    packageItem = { path = "template/PackageItem", type = "GameObject" },
    packageListTF = { path = "root/Middle/Right/Package/List", type = "Transform" },
    battleGO = { path = "root/Middle/Right/Battle", type = "GameObject" },
    battleBtn = { path = "root/Middle/Right/Battle", type = "Button" },
    monsterComplete = { path = "root/Middle/Right/Enemys/Monster/Complete", type = "GameObject" },
    monsterSelect = { path = "root/Middle/Right/Enemys/Monster/Select", type = "GameObject" },
    monsterText = { path = "root/Middle/Right/Enemys/Monster/Text", type = "Text" },
    boxLock = { path = "root/Middle/Right/Enemys/Box/Lock", type = "GameObject" },
    boxComplete = { path = "root/Middle/Right/Enemys/Box/Complete", type = "GameObject" },
    boxSelect = { path = "root/Middle/Right/Enemys/Box/Select", type = "GameObject" },
    boxText = { path = "root/Middle/Right/Enemys/Box/Text", type = "Text" },
    boxStatus1 = { path = "root/Middle/Right/Enemys/Box/Status1", type = "GameObject" },
    boxStatus2 = { path = "root/Middle/Right/Enemys/Box/Status2", type = "GameObject" },
    bossLock = { path = "root/Middle/Right/Enemys/Boss/Lock", type = "GameObject" },
    bossComplete = { path = "root/Middle/Right/Enemys/Boss/Complete", type = "GameObject" },
    bossSelect = { path = "root/Middle/Right/Enemys/Boss/Select", type = "GameObject" },
    bossText = { path = "root/Middle/Right/Enemys/Boss/Text", type = "Text" },
    bossEvaluateGO = { path = "root/Middle/Right/Enemys/Boss/Evaluate", type = "GameObject" },
    bossEvaluateImg = { path = "root/Middle/Right/Enemys/Boss/Evaluate/Text", type = "Image" },
};


this.OnBack = function()
    LuaMgr.ShowLuaPanel(UIName.QinSurveyResultViewModel, QinSurveyResultType.Leave);
end


this.SetData = function()   
    local stageId = DataMgr.Player.Qin.StageId;
    this.qinLevel = ConfigMgr.Config.QinLevelMap[stageId];
    if(this.qinLevel == nil)then

        return
    end
    this.mapName.text = this.qinLevel.Name;
    this.SetMapList();
    this.SetMembers();
    this.SetEffectList();
    this.SetReward();
    this.SetPackage();
    this.SetEnemy();
end


this.SetMapList = function()  
    local qinMap = DataMgr.Player.Qin.QinMap;
    local len = #qinMap;
    if(#this.mapList.itemList ~= len)then
        this.mapList:Clear()
        local listDatas = {}
        for i = 1, len do
            local listData = UIListData.GetData(this.mapItem, "QinSurveyMapItem", qinMap[i]);
            listDatas[i] = listData   
        end
        this.mapList:SetData(listDatas);
    else
        for i,v in ipairs(this.mapList.itemList) do
            local data = {}
            data.data = qinMap[i]
            v:SetData(data,true)
        end
    end
end


this.SetEffectList = function()
    this.effectList:Clear();
    local listData;
    local listDatas = {};
    local buffIds = DataMgr.Player.Qin.BuffIds;
    local len = #buffIds;
    for i = 1, len do
        listData = UIListData.GetData(this.effectItem, "QinSurveyEffectItem", buffIds[i]);
        table.insert(listDatas, listData);
    end
    this.effectList:SetData(listDatas);
    SetActive(this.effectGO, len > 0);
end


this.SetReward = function()
    local item;
    local itemData;
    local typeData;
    local gridType;
    local itemCount;
    local index = 1;
    local scale = Vector3(0.7, 0.7, 1);
    local types = {{type=QinSurveyGrid.Draw, count=this.qinLevel.BoxNum[1]}, 
                   {type=QinSurveyGrid.Box2, count=this.qinLevel.BoxNum[2]}};
    local len = #types;
    local bColloctAll = true
    for i = 1, len do
        typeData = types[i];
        gridType = ConfigQinMgr.GetGridType(typeData.type);        
        if (gridType ~= nil) then
            item = this.rewardList[index];
            if (item == nil) then
                item = GoodsDataItem.New(this.rewardListTF);
                this.rewardList[index] = item;
            end
            itemCount = PlayerQinMgr.GetBoxToolsCount(gridType.ItemsID);
            itemData = table.Copy(ConfigMgr.Config.itemMap[gridType.ItemsID]);
            itemData.count0 = 0;
            item:SetData(i, itemData, 1, false, scale, false, false);
            item:SetCount(string.format("%d/%d", itemCount, typeData.count));
            item:SetIconBg(false);
            index = index + 1;
            if(bColloctAll and itemCount < typeData.count)then
                bColloctAll = false
            end
        end
    end
    SetActive(this.collectAllObj,bColloctAll)
    len = #this.rewardList;
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


this.SetPackage = function()
    local item;
    local itemData;
    local itemCount;
    local gridType;
    local scale = Vector3(0.7, 0.7, 1);
    local index = 1;
    local types = {QinSurveyGrid.Boom, QinSurveyGrid.Kill};
    local len = #types;
    for i = 1, len do
        gridType = ConfigQinMgr.GetGridType(types[i]);
        if (gridType ~= nil) then
            itemCount = PlayerQinMgr.GetToolsCount(gridType.ItemsID);
            item = this.packageList[index];
            if (item == nil) then
                item = GoodsDataItem.New(this.packageListTF);
                this.packageList[index] = item;
            end
            itemData = table.Copy(ConfigMgr.Config.itemMap[gridType.ItemsID]);
            itemData.count0 = itemCount;
            item:SetData(i, itemData, 1, false, scale, false, false);
            item:SetIconBg(false);
            index = index + 1;
        end
    end




end


this.ClearPackage = function()
    local len = #this.packageList;
    if (len > 0) then
        for i = 1, len do
            this.packageList[i]:Clear();
        end
        this.packageList = {};
    end
end


this.SetMembers = function()
    local hp = 0;
    local tHp = 0;
    local listData;   
    local qin = DataMgr.Player.Qin;
    local members = qin.Members; 
    local cacheList = {}
    for k, v in pairs(members) do
        table.insert(cacheList,v)
        hp = hp + v.HP;
        tHp = tHp + v.MaxHP;
    end
    local ratio = hp / tHp;
    local hpPercent = math.floor(ratio * 100);
    if (ratio > 0 and hpPercent == 0) then
        hpPercent = 1;
    end
    if(this.oldHpPercent ~= nil and hpPercent > this.oldHpPercent)then
        AudioMgr.Singleton:PlayVoice(Path.audio_PATH.."DaQin/DQ_YP_11.mp3");
    end  
    if(#this.memberList.itemList ~= #cacheList)then       
        this.memberList:Clear();   
        local listDatas = {}
        for _, v in ipairs(cacheList) do           
            listData = UIListData.GetData(this.memberItem, "QinSurveyMemberItem", v);
            table.insert(listDatas, listData);  
        end
        this.memberList:SetData(listDatas);    
    else       
        for i,v in ipairs(this.memberList.itemList) do
            for key,value in ipairs(cacheList) do              
                local id = v:GetId()
                if(id == value.ID)then
                    local data = {}
                    data.data = cacheList[i]
                    if(this.oldHpPercent ~= nil and hpPercent ~= this.oldHpPercent)then
                        v:SetData(data,true)
                    else
                        v:SetData(data)
                    end 
                end
            end           
        end       
    end      
    this.oldHpPercent = hpPercent
    this.membersHp.text = LuaMgr.GetLangText("QinSurveyViewModel_5") .. hpPercent .. "%";
    this.membersCount.text = tostring(qin.StepCount);
    local cost = ConfigMgr.Config.QinConstants.MoveCost[1];
    local gridType = ConfigQinMgr.GetGridType(QinSurveyGrid.Step);
    if (gridType ~= nil) then
        local itemCount = PlayerQinMgr.GetToolsCount(gridType.ItemsID);
        this.membersCost.text = cost.count .. "/" .. itemCount;
    end
    this.membersCostIcon.texture = GetItemTexture(cost.id);
end


this.SetEnemy = function()
    local stageId = DataMgr.Player.Qin.StageId;
    local explore = DataMgr.Player.Qin.Explore[stageId];
    local storey = DataMgr.Player.Qin.Storey;
    SetActive(this.monsterComplete, storey > 1);
    SetActive(this.monsterSelect, storey == 1);
    this.monsterText.text = LuaMgr.GetLangText("QinSurveyViewModel_6");
    local boxReward = explore ~= nil and explore.BoxReward;
    SetActive(this.boxLock, not boxReward);
    SetActive(this.boxComplete, boxReward);
    SetActive(this.boxStatus1, not boxReward);
    SetActive(this.boxStatus2, boxReward);
    SetActive(this.boxSelect, storey == 2);
    local boxStr = LuaMgr.GetLangText("QinSurveyViewModel_7");
    if (boxReward or storey == 2) then
        this.boxText.text = boxStr;
    else
        this.boxText.text = "<color=#81807e>" .. boxStr .. "</color>";
    end
    local firstBoss = explore ~= nil and explore.FirstBoss;
    SetActive(this.bossLock, not firstBoss);
    SetActive(this.bossComplete, firstBoss);
    SetActive(this.bossSelect, storey == 3);
    local bossStr = LuaMgr.GetLangText("QinSurveyViewModel_8");
    if (firstBoss or storey == 3) then
        this.bossText.text = bossStr;
    else
        this.bossText.text = "<color=#81807e>" .. bossStr .. "</color>";
    end
    local record = DataMgr.Player.dungeonRecords[this.qinLevel.MonsterLevel];
    if (record ~= nil and not IsNullOrEmpty(record.historyRating)) then
        this.bossEvaluateImg.sprite = LuaMgr.GetSprite("Qin", "ui_qin_pj_" .. record.historyRating);
        SetActive(this.bossEvaluateGO, true);
        SetActive(this.battleGO, record.historyRating == "S");
    else
        SetActive(this.bossEvaluateGO, false);
        SetActive(this.battleGO, false);
    end
end


this.OnClickBattle = function()
    local record = DataMgr.Player.dungeonRecords[this.qinLevel.MonsterLevel];
    if (record == nil or record.historyRating ~= "S") then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("QinSurveyViewModel_9"));
        return;
    end
    local dungeonConfig = ConfigMgr.Config.dungeonMap[this.qinLevel.MonsterLevel];  
    if(not this.CheckBattleCost(dungeonConfig))then        
        LuaMgr.ShowLuaPanel("FatigueReplyViewModel")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_2454"))        
        return
    end    
    local members = DataMgr.Player.Qin.Members;
    PlayerQinMgr.EnterDungeon(this.qinLevel.MonsterLevel, members, 0);
end

this.CheckBattleCost = function (dungeonConfig)       
    local item = dungeonConfig.consumeItem[1]
    local canBattle = false
    if item ~= nil then
        local num = tonumber(dungeonConfig.levelNum)
        local config = ConfigMgr.Config.itemMap[item.id]
        if config ~= nil then                      
            if item.count==0 then
                canBattle = true                
            else
                if item.id == "101" then
                    num = DataMgr.Player.stamina
                else
                    local itemData = DataMgr.Player.items[item.id]
                    if itemData ~= nil then
                        num = itemData.count0
                    end
                end
                canBattle = num >= item.count              
            end           
        end
    end
    return canBattle
end


this.OnMapRefresh = function(args)   
    this.SetData();
end


this.OnUseTools = function(args)    
    local result = args[0];

    local monster = PlayerQinMgr.GetMonster(result.Index);
    if (monster ~= nil and monster.MonsterHurt >= 10000) then
        if this.startDelay ~= nil then
            coroutine_runner.stop(this.startDelay)
        end
        this.startDelay = coroutine_runner.start(function()        
            coroutine_runner.wait(0.9)
            PlayerQinMgr.EnterLeaveDungeon(monster.MonsterId, result.Index);
            coroutine_runner.wait(0.5)
            if (PlayerQinMgr.IsChallengeBoss()) then
                PlayerQinMgr.Settlement(QinSurveyResultType.Win);                
            end
        end)  
    end
    this.SetData();
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.mapList = UIListView.New(this.mapListTF);
        this.memberList = UIListView.New(this.membersListTF);
        this.effectList = UIListView.New(this.effectListTF);
        LuaMgr.AddClick(this.battleBtn, this.OnClickBattle);
    end,
    before_active = function(vm)
        this.oldHpPercent = nil
        if (vm.behaviour.Params == nil) then return end
        this.bShow = PlayerQinMgr.GetPlayAudio()
        if(this.bShow)then
            PlayerQinMgr.SetPlayAudio(false)
            AudioMgr.Singleton:PlayVoice(Path.audio_PATH.."DaQin/DQ_YP_05.mp3");
        end   
            
        PlayerQinMgr.SetEffectFlyPos("reward",this.rewardListTF.position)
        PlayerQinMgr.SetEffectFlyPos("attack",this.packageListTF.position)
        PlayerQinMgr.SetEffectFlyPos("effect",this.effectGO.transform.position)
        LuaMgr.RemoveNormalPanel(UIName.HeroChoiceViewModel);
        LuaMgr.AddUIEventListener(UIEventConst.QinSurveyMapRefresh, this.OnMapRefresh);
        LuaMgr.AddUIEventListener(UIEventConst.QinSurveyUseTools, this.OnUseTools);
        vm.behaviour:UpdateTopBar("", this.OnBack);        

        this.SetData();
        if (PlayerQinMgr.IsChallengeBoss()) then
            PlayerQinMgr.Settlement(QinSurveyResultType.Win);
            return;
        end
        if (not PlayerQinMgr.IsMemberLive()) then
            PlayerQinMgr.Settlement(QinSurveyResultType.Lose);
            return;
        end
        if (PlayerQinMgr.IsKillBoss()) then
            PlayerQinMgr.Settlement(QinSurveyResultType.Win);
            return;
        end
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.QinSurveyMapRefresh, this.OnMapRefresh);
        LuaMgr.RemoveUIEventListener(UIEventConst.QinSurveyUseTools, this.OnUseTools);        
        this.mapList:Clear();
        this.memberList:Clear();
        this.effectList:Clear();
        if this.startDelay ~= nil then
            coroutine_runner.stop(this.startDelay)
        end
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.battleBtn, this.OnClickBattle);
        this.ClearReward();
        this.ClearPackage();
        UIListView.ClearItem("QinSurveyMapItem");
        UIListView.ClearItem("QinSurveyEffectItem");
        UIListView.ClearItem("QinSurveyMemberItem");
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})