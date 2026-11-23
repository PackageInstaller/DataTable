require("DH/DHSurveyMapItem")
require("DH/DHSurveyRewardItem")
require("DH/DHConst")

local this = {
    mapList = nil,
    rewardList = nil,
    packageList = {},
    dhLevel = nil,
    canGoNext = false,
    startDelays = {}
};

local objs = {
    animator = { path = "root", type = "Animator" },
    mapItem = { path = "template/MapItem", type = "GameObject" },
    mapListTF = { path = "root/Middle/Map/List", type = "Transform" },
    mapName = { path = "root/Middle/Map/Name", type = "Text" },
    membersHp = { path = "root/Middle/Left/Members/Hp", type = "Text" },
    membersAck = { path = "root/Middle/Left/Members/Ack", type = "Text" },
    membersCount = { path = "root/Middle/Left/Members/Count/Text", type = "Text" },
    membersCost = { path = "root/Middle/Left/Members/Cost/Text", type = "Text" },
    ackShow = { path = "root/Middle/Left/Members/AckShow", type = "Text" },
    hpShow = { path = "root/Middle/Left/Members/HpShow", type = "Text" },
    msgObj = { path = "root/Middle/Left/Members/Msg", type = "GameObject" },
    msgContent = { path = "root/Middle/Left/Members/Msg/Content", type = "Text" },
    membersCostIcon = { path = "root/Middle/Left/Members/Cost/Text/Icon", type = "RawImage" },
    membersCostIconBtn = { path = "root/Middle/Left/Members/Cost/Text/Icon", type = "Button" },
    effectGO = { path = "root/Middle/Left/Effect", type = "GameObject" },
    effectListTF = { path = "root/Middle/Left/Effect/List", type = "Transform" },
    rewardListTF = { path = "root/Middle/Right/Reward/List", type = "Transform" },
    packageItem = { path = "template/PackageItem", type = "GameObject" },
    packageListTF = { path = "root/Middle/Left/Package/ScrollView/Viewport/Content", type = "Transform" },
    battleEffect = { path = "root/Middle/Right/Battle/BattleEffect", type = "GameObject" },
    battleGO = { path = "root/Middle/Right/Battle/BattleLock", type = "GameObject" },
    battleBtn = { path = "root/Middle/Right/Battle", type = "Button" },
    battleObj = { path = "root/Middle/Right/Battle", type = "GameObject" },
    ImgGoal1 = { path = "root/Middle/Right/ImgGoal1", type = "GameObject" },
    goalText1 = { path = "root/Middle/Right/ImgGoal1/TextGoal", type = "Text" },
    ImgGoal2 = { path = "root/Middle/Right/ImgGoal2", type = "GameObject" },
    goalText2 = { path = "root/Middle/Right/ImgGoal2/TextGoal", type = "Text" },
    cancelBattleGO = { path = "root/Middle/CancelBattle", type = "GameObject" },
    cancelBattleBtn = { path = "root/Middle/CancelBattle", type = "Button" },
    monsterComplete = { path = "root/Middle/Right/Enemys/Monster/Complete", type = "GameObject" },
    monsterSelect = { path = "root/Middle/Right/Enemys/Monster/Select", type = "GameObject" },
    monsterText = { path = "root/Middle/Right/Enemys/Monster/Text", type = "Text" },
    lineSlider = { path = "root/Middle/Right/Enemys/LineSlider", type = "Image" },
    boxLock = { path = "root/Middle/Right/Enemys/Box/Lock", type = "GameObject" },
    boxComplete = { path = "root/Middle/Right/Enemys/Box/Complete", type = "GameObject" },
    boxSelect = { path = "root/Middle/Right/Enemys/Box/Select", type = "GameObject" },
    boxText = { path = "root/Middle/Right/Enemys/Box/Text", type = "Text" },
    bossLock = { path = "root/Middle/Right/Enemys/Boss/Lock", type = "GameObject" },
    bossComplete = { path = "root/Middle/Right/Enemys/Boss/Complete", type = "GameObject" },
    bossSelect = { path = "root/Middle/Right/Enemys/Boss/Select", type = "GameObject" },
    bossText = { path = "root/Middle/Right/Enemys/Boss/Text", type = "Text" },
    effectYellow = { path = "root/Middle/Left/Members/Effect_kuang_yellow", type = "GameObject" },
    effectRed = { path = "root/Middle/Left/Members/Effect_kuang_red", type = "GameObject" },
    effectRed2 = { path = "root/Middle/Left/Members/Effect_kuang_red2", type = "GameObject" },
    effectGreen = { path = "root/Middle/Left/Members/Effect_kuang_green", type = "GameObject" },
    fxStart = { path = "root/fx_start", type = "GameObject" },
};


this.OnBack = function()
    LuaMgr.ShowLuaPanel(UIName.DHSurveyResultViewModel, DHSurveyResultType.Leave);
end


this.SetData = function()
    local stageId = DataMgr.Player.DunHuang.StageId;
    this.dhLevel = ConfigMgr.Config.DHLevelMap[stageId];
    if (this.dhLevel == nil) then

        return
    end
    this.SetMapGoalInfo()
    this.mapName.text = this.dhLevel.Name;
    local ackMonsterType = PlayerDHMgr.GetAckMonsterType()
    SetActive(this.cancelBattleGO, ackMonsterType ~= nil)
    this.SetMapList();
    this.SetMembers();
    this.SetReward();
    this.SetPackage();
    this.SetEnemy();
    if ((PlayerDHMgr.IsChallengeBoss() or PlayerDHMgr.IsKillBoss()) and this.canGoNext) then
        PlayerDHMgr.Settlement(DHSurveyResultType.Win);
        return;
    end
    if (not PlayerDHMgr.IsMemberLive()) then
        PlayerDHMgr.Settlement(DHSurveyResultType.Lose);
        return;
    end
end


this.SetMapList = function()
    local dhMap = DataMgr.Player.DunHuang.DHMap;
    local len = #dhMap;
    if (#this.mapList.itemList ~= len) then
        this.mapList:Clear()
        local listDatas = {}
        for i = 1, len do
            local listData = UIListData.GetData(this.mapItem, "DHSurveyMapItem", dhMap[i]);
            listDatas[i] = listData
        end
        this.mapList:SetData(listDatas);
    else
        for i, v in ipairs(this.mapList.itemList) do
            local data = {}
            data.data = dhMap[i]
            v:SetData(data, true)
        end
    end
end


this.SetMapGoalInfo = function()
    local storey = DataMgr.Player.DunHuang.Storey;
    local gridType = ConfigDHMgr.GetGridType(DHSurveyGrid.Box2);
    this.canGoNext = false
    if (gridType ~= nil) then
        local itemCount = PlayerDHMgr.GetBoxToolsCount(DataMgr.Player.DunHuang.StageId, gridType.ItemsID);
        local totalnum = 0
        for k, v in pairs(this.dhLevel.BoxNum) do
            if (k < storey) then
                totalnum = totalnum + v
            end
        end
        local curTotleNum = this.dhLevel.BoxNum[storey]
        itemCount = itemCount - totalnum
        this.canGoNext = itemCount >= curTotleNum
        this.goalText1.text = string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_22406"), curTotleNum);
        SetActive(this.battleGO, not this.canGoNext);
        SetActive(this.battleEffect, this.canGoNext);
    end
    this.goalText2.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_22407")
    SetActive(this.ImgGoal2, storey == 3)
    SetActive(this.battleObj, storey ~= 3)
end


this.SetReward = function()
    local types = { { type = DHSurveyGrid.Box2, curLevel = this.dhLevel }, { type = DHSurveyGrid.Box, curLevel = this.dhLevel } };
    local len = #types;
    if (#this.rewardList.itemList ~= len) then
        this.rewardList:Clear()
        local listDatas = {}
        for i = 1, len do
            local typeData = types[i];
            local listData = UIListData.GetData(this.packageItem, "DHSurveyRewardItem", typeData);
            listDatas[i] = listData
        end
        this.rewardList:SetData(listDatas);
    else
        for i, v in ipairs(this.rewardList.itemList) do
            local data = {}
            local typeData = types[i];
            data.data = typeData
            v:SetData(data, true)
        end
    end
end


this.SetPackage = function()
    local item;
    local itemData;
    local itemCount;
    local index = 1;
    local types = { DHSurveyGrid.Boom, DHSurveyGrid.Kill, DHSurveyGrid.Sacrifice,
        DHSurveyGrid.Critical, DHSurveyGrid.UnDeath };
    local len = #types;    
    if not this.packageScale then
        this.packageScale = Vector3(0.5, 0.5, 1);
    end  

    for i = 1, len do
        local gridType = ConfigDHMgr.GetGridType(types[i]);
        if (gridType ~= nil) then
            itemCount = PlayerDHMgr.GetToolsCount(gridType.ItemsID);
            if (itemCount > 0) then                
                if (this.packageList[index] == nil) then
                    local newItem = GoodsDataItem.New(this.packageListTF);
                    this.packageList[index] = {
                        item = newItem,
                        data = table.Copy(ConfigMgr.Config.itemMap[gridType.ItemsID])
                    };
                end
                
                item = this.packageList[index].item;
                item.goodsBtn.onClick:RemoveAllListeners();
                item.CacheCommand = function()
                    this.ItemOnClick(gridType)
                end
                LuaMgr.AddClick(item.goodsBtn, item.CacheCommand)    
                if this.packageList[index].data == nil or
                    this.packageList[index].data.id ~= gridType.ItemsID or
                    this.packageList[index].data.count0 ~= itemCount then
                    itemData = table.Copy(ConfigMgr.Config.itemMap[gridType.ItemsID]);
                    itemData.count0 = itemCount;
                    this.packageList[index].data = itemData;                    
                end
                itemData = this.packageList[index].data;
                item:SetData(i, itemData, 1, false, this.packageScale, false, false);
                item:SetIconBg(false);
                index = index + 1;
            end
        end
    end
    len = #this.packageList;
    for i = index, len do
        this.packageList[i].item:Hide();
    end
end

this.ItemOnClick = function(item)
    if (item.GridType == DHSurveyGrid.Box) then
        LuaMgr.ShowLuaPanel(UIName.DHAllusionViewModel, DataMgr.Player.DunHuang.StageId);
    else
        local data = {}
        data.gridData = item
        data.callback = this.battleClickCallBack
        LuaMgr.ShowLuaPanel(UIName.DHSurveyResultViewModel, DHSurveyResultType.Battle, data);
    end
end

this.battleClickCallBack = function(data)
    if (data.GridType == DHSurveyGrid.Kill or data.GridType == DHSurveyGrid.Boom) then
        PlayerDHMgr.SetAckMonsterType(data.GridType)
        this.SetMapList()
        SetActive(this.cancelBattleGO, true)
    else
        PlayerDHMgr.UseTools(data.ItemsID, -1);
    end
end


this.ClearPackage = function()
    local len = #this.packageList;
    if (len > 0) then
        for i = 1, len do
            if this.packageList[i].item and this.packageList[i].item.goodsBtn then
                this.packageList[i].item.goodsBtn.onClick:RemoveAllListeners();
            end
            if this.packageList[i].item then
                this.packageList[i].item:Clear();
            end
        end
        this.packageList = {};
    end
end


this.SetMembers = function()
    local dh = DataMgr.Player.DunHuang;
    local hp = dh.Hp;
    local tHp = this.dhLevel.RoleState[1];
    local ratio = hp / tHp;
    local hpPercent = math.floor(ratio * 100);
    if (ratio > 0 and hpPercent == 0) then
        hpPercent = 1;
    end
    if (this.oldHp ~= nil and hp ~= this.oldHp) then
        local interval = hp - this.oldHp
        if (interval > 0) then
            this.SetEffectShow(1, interval)
            AudioMgr.Singleton:PlayVoice(Path.audio_PATH .. "DH/DH_YP_07.mp3");
        else
            this.SetEffectShow(2, interval)
        end
    end
    if (this.oldAck ~= nil and dh.Ack > this.oldAck) then
        this.SetEffectShow(3, 0)
    end
    local time=ConfigMgr.Config.constants.AnalectsTips;
    SetActive(this.effectRed2, hp <= time)
    this.oldHp = hp
    this.oldAck = dh.Ack
this.membersHp.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_21106") .. hp
    this.membersAck.text = LuaMgr.GetLangText("DHSurveyViewModel_0") .. dh.Ack
    this.membersCount.text = tostring(dh.StepCount);
    local cost = ConfigMgr.Config.DHConstants.MoveCost[1];
    local gridType = ConfigDHMgr.GetGridType(DHSurveyGrid.Step);
    if (gridType ~= nil) then
        local itemCount = PlayerDHMgr.GetToolsCount(gridType.ItemsID);
        this.membersCost.text = itemCount;
    end
    this.membersCostIcon.texture = GetItemTexture(cost.id);
end

this.StartSafeCoroutine = function(name, func)
    if this.startDelays[name] then
        coroutine_runner.stop(this.startDelays[name])
    end
    this.startDelays[name] = coroutine_runner.start(func)
    return this.startDelays[name]
end

this.StopAllCoroutines = function()
    for name, routine in pairs(this.startDelays) do
        if routine then
            coroutine_runner.stop(routine)
        end
    end
    this.startDelays = {}
end

this.SetEffectShow = function(showType, num)
    SetActive(this.effectRed, false)
    SetActive(this.effectYellow, false)
    SetActive(this.effectGreen, false)
    if (showType == 3) then
        this.animator:Rebind();
        this.animator:Play("ani_DHSurveyPanel_root_002");
        SetActive(this.effectYellow, true)
        AudioMgr.Singleton:PlayVoice(Path.audio_PATH .. "DH/DH_YP_10.mp3");
        return
    end


    this.StartSafeCoroutine("effectShow", function()
        if (showType == 1) then
            this.ackShow.text = ""
            this.hpShow.text = "b+" .. num
            SetActive(this.effectGreen, true)
            this.animator:Rebind();
            this.animator:Play("ani_DHSurveyPanel_root_003");
            coroutine_runner.wait(1)
            this.hpShow.text = ""
        elseif (showType == 2) then
            this.ackShow.text = "b+" .. num
            this.hpShow.text = ""
            SetActive(this.effectRed, true)
            this.animator:Rebind();
            this.animator:Play("ani_DHSurveyPanel_root_003");
            this.spineCharacter:Play("suffer", false, function()
                this.spineCharacter:Play("idle", true, nil)
            end)
            coroutine_runner.wait(1)
            this.ackShow.text = ""
        end
    end)
end


this.SetEnemy = function()
    local stageId = DataMgr.Player.DunHuang.StageId;
    local explore = DataMgr.Player.DunHuang.Explore[stageId];
    local storey = DataMgr.Player.DunHuang.Storey;
    local finishNum = 0
    SetActive(this.monsterComplete, storey >= 1);
    SetActive(this.monsterSelect, false);
    this.monsterText.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_21109");
    local boxReward = explore ~= nil and explore.BoxReward;
    SetActive(this.boxLock, storey < 2);
    SetActive(this.boxComplete, storey >= 2);
    SetActive(this.boxSelect, false);
    local boxStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_21110");
    if (storey >= 2) then
        this.boxText.text = boxStr;
        finishNum = 0.5
    else
        this.boxText.text = "<color=#81807e>" .. boxStr .. "</color>";
    end
    local firstBoss = explore ~= nil and explore.FirstBoss;
    SetActive(this.bossLock, storey < 3);
    SetActive(this.bossComplete, storey == 3);
    SetActive(this.bossSelect, false);
    local bossStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_21111");
    if (storey == 3) then
        this.bossText.text = bossStr;
        finishNum = 1
    else
        this.bossText.text = "<color=#81807e>" .. bossStr .. "</color>";
    end
    this.lineSlider.fillAmount = finishNum
end

this.SetMsgShow = function(args)
    local strContent = ConfigMgr.LangGlobal("" .. args[0])


    this.StartSafeCoroutine("msgShow", function()
        SetActive(this.msgObj, true)
        this.msgContent.text = strContent
        coroutine_runner.wait(2)
        SetActive(this.msgObj, false)
    end)
end


this.OnClickNextLevel = function()
    if (not this.canGoNext) then
        this.SetMsgShow({ [0] = 22408 })
    else
        SetActive(this.fxStart, false)
        PlayerDHMgr.Explore(-1);
        SetActive(this.fxStart, true)
    end
end

this.OnClickCancelBattle = function()
    PlayerDHMgr.SetAckMonsterType(nil)
    this.SetMapList()
    SetActive(this.cancelBattleGO, false)
end

this.OnClickMembersCostIcon = function()
    local cost = ConfigMgr.Config.DHConstants.MoveCost[1];
    LuaMgr.ShowPanel(UIName.GoodsTipsViewModel, cost.id, true, false, false, 0);
end


this.OnMapRefresh = function(args)
    this.SetData();
end


this.OnUseTools = function(args)
    local result = args[0];

    local monster = PlayerDHMgr.GetMonster(result.Index);
    if (monster ~= nil and monster.Hp <= 0) then

        this.StartSafeCoroutine("battleResult", function()
            coroutine_runner.wait(0.5)
            if (PlayerDHMgr.IsChallengeBoss() and this.canGoNext) then
                PlayerDHMgr.Settlement(DHSurveyResultType.Win);
            end
        end)
    end
    this.SetData();
end


this.OnBattle = function(args)



    this.OnUseTools(args)
end

this.SetCharacter = function()
    local characterId = "W0147"
    local skinId = characterId .. "001";
    this.spineCharacter:Clear()
    this.spineCharacter:SetBattle(characterId, skinId, "",
        ConfigMgr.Config.characterTable[characterId].job)
    this.spineCharacter:Play("idle", true, nil)
end

local data =
{
    bodyPath = "",
}

local command = {}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.spineCharacter = vm.behaviour.transform:Find("root/Middle/Left/Members/ImageMask/Character/Body")
            :GetComponent(
                "UISpineCharacter");
        this.mapList = UIListView.New(this.mapListTF);
        this.rewardList = UIListView.New(this.rewardListTF);
        LuaMgr.AddClick(this.battleBtn, this.OnClickNextLevel);
        LuaMgr.AddClick(this.membersCostIconBtn, this.OnClickMembersCostIcon);
        LuaMgr.AddClick(this.cancelBattleBtn, this.OnClickCancelBattle);
    end,
    before_active = function(vm)
        this.oldHp = nil
        this.oldAck = nil
        this.ackShow.text = ""
        this.hpShow.text = ""
        if (vm.behaviour.Params == nil) then return end
        this.bShow = PlayerDHMgr.GetPlayAudio()
        if (this.bShow) then
            PlayerDHMgr.SetPlayAudio(false)
            AudioMgr.Singleton:PlayVoice(Path.audio_PATH .. "DH/DH_YP_01.mp3");
        end
        PlayerDHMgr.SetAckMonsterType(nil)
        PlayerDHMgr.SetEffectFlyPos("reward", this.rewardListTF.position)
        PlayerDHMgr.SetEffectFlyPos("attack", this.packageListTF.position)


        LuaMgr.AddUIEventListener(UIEventConst.QinSurveyMapRefresh, this.OnMapRefresh);
        LuaMgr.AddUIEventListener(UIEventConst.QinSurveyUseTools, this.OnUseTools);
        LuaMgr.AddUIEventListener(UIEventConst.QinBattleCountry, this.OnBattle);
        LuaMgr.AddUIEventListener(UIEventConst.DHMsgShow, this.SetMsgShow);
        vm.behaviour:UpdateTopBar("", this.OnBack);
        this.SetCharacter()
        SetActive(this.effectRed, false)
        SetActive(this.effectYellow, false)
        SetActive(this.effectGreen, false)
        this.animator:Rebind();
        this.animator:Play("ani_DHSurveyPanel_root_001");

        this.SetData();
        SetActive(this.msgObj, false)
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.QinSurveyMapRefresh, this.OnMapRefresh);
        LuaMgr.RemoveUIEventListener(UIEventConst.QinSurveyUseTools, this.OnUseTools);
        LuaMgr.RemoveUIEventListener(UIEventConst.QinBattleCountry, this.OnBattle);
        LuaMgr.RemoveUIEventListener(UIEventConst.DHMsgShow, this.SetMsgShow);
        this.mapList:Clear();
        this.rewardList:Clear();


        this.StopAllCoroutines();

        if this.spineCharacter then
            this.spineCharacter:Clear();
        end
        PlayerDHMgr.SetAckMonsterType(nil)


        this.oldHp = nil
        this.oldAck = nil
        this.ClearPackage();
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.battleBtn, this.OnClickNextLevel);
        LuaMgr.RemoveClick(this.membersCostIconBtn, this.OnClickMembersCostIcon);
        LuaMgr.RemoveClick(this.cancelBattleBtn, this.OnClickCancelBattle);
        UIListView.ClearItem("DHSurveyMapItem");
        UIListView.ClearItem("DHSurveyRewardItem");
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})