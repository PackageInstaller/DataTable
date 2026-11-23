ActivityBattlePrepareInfo_MiniBattle3 = {};

ActivityBattlePrepareInfo_MiniBattle3.__index = ActivityBattlePrepareInfo_MiniBattle3;

require("ViewModel/MiniBattle3/MiniBattle3SimpleBuffItem")

local objs = {
    bestCoinGo = { path = "RightInfo/BestCoin", type = "GameObject" },
    bestScoreGo = { path = "RightInfo/BestScore", type = "GameObject" },
    bestCoinText = { path = "RightInfo/BestCoin/Score", type = "Text" },
    bestScoreText = { path = "RightInfo/BestScore/Score", type = "Text" },
    rewardCoinGo = { path = "RightInfo/Reward/Coin", type = "GameObject" },
    rewardScoreGo = { path = "RightInfo/Reward/Score", type = "GameObject" },
    rewardCoinText = { path = "RightInfo/Reward/Coin/BestCoin/Score", type = "Text" },
    rewardScoreText = { path = "RightInfo/Reward/Score/BestScore/Score", type = "Text" },
    level = { path = "RightInfo/Level/Text", type = "Text" },

    enemyBuffOn = { path = "RightInfo/Buff/ToggleGroup/EnemyOn", type = "GameObject" },
    enemyBuffBtn = { path = "RightInfo/Buff/ToggleGroup/EnemyOff", type = "Button" },
    selfBuffOn = { path = "RightInfo/Buff/ToggleGroup/SelfOn", type = "GameObject" },
    selfBuffBtn = { path = "RightInfo/Buff/ToggleGroup/SelfOff", type = "Button" },

    buffCardScrollViewTF = { path = "RightInfo/Buff/BuffList/ScrollView", type = "Transform" },
    buffCardItem = { path = "RightInfo/Buff/BuffList/ScrollView/Viewport/Content/BuffCardItem", type = "GameObject" },
    
    enemyItem = { path = "RightInfo/Enemys/EnemyItem", type = "GameObject" },
    enemysBtn = { path = "RightInfo/Enemys", type = "Button" },
    enemysListTF = { path = "RightInfo/Enemys/List", type = "Transform" },
    startBtn1 = { path = "RightInfo/StartBattle_1", type = "Button" },
    startBtn2 = { path = "RightInfo/StartBattle_2", type = "Button" },
    startBtnGo1 = { path = "RightInfo/StartBattle_1", type = "GameObject" },
    startBtnGo2 = { path = "RightInfo/StartBattle_2", type = "GameObject" },
    delegateBattle = { path = "RightInfo/DelegateBattle", type = "Button" },
    delegateBattleGo = { path = "RightInfo/DelegateBattle", type = "GameObject" },
    delegateLock = { path = "RightInfo/DelegateBattle/LockBg", type = "GameObject" },
    tips = { path = "MiddleInfo/Tips/Text", type = "Text" },
};

function ActivityBattlePrepareInfo_MiniBattle3.New()
    local self = {};
    setmetatable(self, ActivityBattlePrepareInfo_MiniBattle3);
    return self;
end

function ActivityBattlePrepareInfo_MiniBattle3:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.monsterList = nil
    self.curShowBuffType = 0
    self.BuffCardScrollView = UIScrollView.New(self.buffCardScrollViewTF);
    self.enemysListView = UIListView.New(self.enemysListTF);

    self.OnClickEnemyBuff = function()
        self:ShowBuffList(1)
    end
    self.OnClickSelfBuff = function()
        self:ShowBuffList(2)
    end
    self.OnClickEnemys = function()
        LuaMgr.ShowLuaPanel(UIName.BattlePrepareEnemyViewModel, self.dungeonConfig, self.monsterList);
    end
    self.OnClickStart = function()
        local startFunc = function()
            MiniBattle3Mgr.SaveDailyLeftBattleCount()
            local selectMembers = ActivityBattlePrepareMgr.GetSelectMembers();
            self:EnterDungeon(self.dungeonConfig.id, selectMembers);
        end
        if self.dailyBattleCountIsEnough then
            startFunc()
        else
            LuaMgr.ShowLuaPanel(UIName.MiniBattle3ConfirmTipsPopup, self.dailyBattleCountEmptyTips, startFunc);
        end
    end
    self.OnClickDelegate = function()
        if self.isDelegateLock then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("26660"));
            return
        end
        if self.dailyBattleCountIsEnough then
            LuaMgr.ShowLuaPanel(UIName.MiniBattle3DelegetePopup, self.activityData.plotId, function(count)
                self:OnDelegateDungeon(self.dungeonConfig.id, count)
            end);
        else
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("26661"));
        end
    end
    LuaMgr.AddClick(self.enemyBuffBtn, self.OnClickEnemyBuff);
    LuaMgr.AddClick(self.selfBuffBtn, self.OnClickSelfBuff);
    LuaMgr.AddClick(self.enemysBtn, self.OnClickEnemys);
    LuaMgr.AddClick(self.startBtn1, self.OnClickStart);
    LuaMgr.AddClick(self.startBtn2, self.OnClickStart);
    LuaMgr.AddClick(self.delegateBattle, self.OnClickDelegate);
    SetActive(self.delegateLock, false)
    SetActive(self.buffCardItem, false)
    SetActive(self.enemyItem, false)
    SetActive(self.gameObject, false)
end

function ActivityBattlePrepareInfo_MiniBattle3:SetData(dungeonConfig, activityData)
    self.dungeonConfig = dungeonConfig
    self.activityData = activityData
    local bestRecord = MiniBattle3Mgr.GetDungeonMaxScore(activityData.plotId)
    local levelCfg = ConfigMgr.Config.DualBattleBuffMap[activityData.enemyLevelId]
    if levelCfg.Coin > 0 then
        self.bestCoinText.text = bestRecord
        self.rewardCoinText.text = levelCfg.Coin
        self.dailyBattleCountIsEnough = MiniBattle3Mgr.CheckUpDailyBattleCount()
        self.dailyBattleCountEmptyTips = ConfigMgr.LangGlobal("26658")
        
        SetActive(self.bestCoinGo, true)
        SetActive(self.bestScoreGo, false)
        SetActive(self.rewardCoinGo, true)
        SetActive(self.rewardScoreGo, false)
        SetActive(self.startBtnGo1, true)
        SetActive(self.startBtnGo2, false)
        SetActive(self.delegateBattleGo, false)
    elseif levelCfg.Credit > 0 then
        self.bestScoreText.text = bestRecord
        self.rewardScoreText.text = levelCfg.Credit
        self.isDelegateLock = bestRecord == 0
        self.dailyBattleCountIsEnough = MiniBattle3Mgr.CheckDownDailyBattleCount()
        self.dailyBattleCountEmptyTips = ConfigMgr.LangGlobal("26659")
        self.curBestScore = bestRecord
        
        SetActive(self.bestCoinGo, false)
        SetActive(self.bestScoreGo, true)
        SetActive(self.rewardCoinGo, false)
        SetActive(self.rewardScoreGo, true)
        SetActive(self.startBtnGo1, false)
        SetActive(self.startBtnGo2, true)
        SetActive(self.delegateBattleGo, true)
        SetActive(self.delegateLock, bestRecord == 0)
    end

    self.level.text = dungeonConfig.levelShow;
    local anotherDungeonName = ConfigAreaMgr.GetDungeonName(activityData.anotherPlotCfg.DungeonId)
    self.tips.text = string.format(LuaMgr.GetLangText("ActivityBattlePrepareInfo_MiniBattle3_1"), anotherDungeonName)
    self.curShowBuffType = 0
    self:ShowBuffList(1)
    self:SetEmemys();
    SetActive(self.gameObject, true)
end

function ActivityBattlePrepareInfo_MiniBattle3:ShowBuffList(type)
    if self.curShowBuffType == type then
        return
    end
    self.curShowBuffType = type

    SetActive(self.enemyBuffOn, self.curShowBuffType == 1)
    SetActive(self.selfBuffOn, self.curShowBuffType == 2)

    local buffInfoList = {}
    if self.curShowBuffType == 1 then
        local buffLevelId = self.activityData.enemyLevelId
        local levelCfg = ConfigMgr.Config.DualBattleBuffMap[buffLevelId]
        for i, v in ipairs(levelCfg.BuffGroup) do
            local buffInfo = MiniBattle3Mgr.GetBuffCardInfo(v)
            buffInfo.levelStr = ""
            table.insert(buffInfoList, buffInfo)
        end
    elseif self.curShowBuffType == 2 then
        for i, buffGroupId in ipairs(self.activityData.selfBuff) do
            local buffId = MiniBattle3Mgr.GetBuffIdByLevelGroupId(buffGroupId)
            local buffInfo = MiniBattle3Mgr.GetBuffCardInfo(buffId)
            local curLevel = MiniBattle3Mgr.GetBuffLevel(buffGroupId)
            local buffLevelCfg = ConfigMgr.Config.DualBattleBuffLevelMap[buffGroupId]
            local maxLevel = #buffLevelCfg.GroupId
            buffInfo.levelStr = string.format(LuaMgr.GetLangText("ActivityBattlePrepareInfo_MiniBattle3_0"), curLevel, maxLevel)
            table.insert(buffInfoList, buffInfo)
        end
    end

    local scrollData, scrollDatas = {}, {}
    local groupData = nil
    local len = #buffInfoList
    for i = 1, #buffInfoList do
        groupData = buffInfoList[i]
        groupData.onClick = function(cardId)
            LuaMgr.ShowLuaPanel(UIName.MiniBattle3BuffCardInfoPopup, cardId);
        end
        scrollData = UIScrollData.GetData(self.buffCardItem, "MiniBattle3SimpleBuffItem", 119, 138, groupData)
        table.insert(scrollDatas, scrollData)
    end

    self.BuffCardScrollView:Clear(false)
    self.BuffCardScrollView:SetPadding(0, 0, 0, 0)
    self.BuffCardScrollView:SetParams(280, 138)
    self.BuffCardScrollView:SetData(scrollDatas, true)
end


function ActivityBattlePrepareInfo_MiniBattle3:SetEmemys()
    self.enemysListView:Clear();
    self:SetMonsterIdList();
    local listData;
    local listDatas = {};
    local monsterMap = ConfigMgr.Config.monsterMap;
    for _, v in ipairs(self.monsterList) do
        local monster = monsterMap[v];
        if (monster ~= nil and not monster.hideShowinfo) then
            listData = UIListData.GetData(self.enemyItem, "ActivityBattlePrepareEnemyItem", monster);
            table.insert(listDatas, listData);
            if (#listDatas >= 3) then
                break ;
            end
        end
    end
    self.enemysListView:SetData(listDatas);
end


function ActivityBattlePrepareInfo_MiniBattle3:SetMonsterIdList()
    if (self.monsterList == nil) then
        local str = LuaMgr.UpdateMonsterIdList(self.dungeonConfig.flowScript);
        self.monsterList = json.decode(str);
    end
end


function ActivityBattlePrepareInfo_MiniBattle3:EnterDungeon(dungeonId, members)
    local len = #members;
    if (len <= 0) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("MiniBattlePrepareViewModel_1"));
        return ;
    end
    local memberDic = {};
    local helpDic = {};
    for i = 1, len do
        local id = members[i];
        local index = tostring(i - 1);
        memberDic[index] = id;
        if (PlayerAssistMgr.IsAssistMember(id)) then
            helpDic[index] = PlayerAssistMgr.GetAssistMemberUid(id);
        else
            helpDic[index] = "";
        end
    end
    local enterDungeonParams = self:GetEnterDungeonParam(dungeonId, memberDic, helpDic, self.activityData.enemyLevelId)
    BattlePrepareMgr._enterDungeonParams = enterDungeonParams
    LuaMgr.SceneSwitchMark({ UIName.ActivityBattlePrepareViewModel });
    PlayerAreaMgr.SetAreaDungeonId("-1");
    ApiMgr.Request("enter_dungeon", enterDungeonParams, true, function(result)
        local re = json.decode(result);
        local data = json.encode(re.result);
        LuaMgr.EnterBattle(data, -1);
    end, function(code)
    end, true);
end


function ActivityBattlePrepareInfo_MiniBattle3:OnDelegateDungeon(dungeonId, count)
    local enterDungeonParams = self:GetEnterDungeonParam(dungeonId, {}, {}, "-1")
    enterDungeonParams.count = count
    ApiMgr.Request("enter_leave_dungeon", enterDungeonParams, true, function(result)
        LuaMgr.ShowLuaPanel(UIName.MiniBattle3DelegeteResultPopup, count, self.curBestScore, dungeonId)
    end, nil, true, true);
end

function ActivityBattlePrepareInfo_MiniBattle3:GetEnterDungeonParam(dungeonId, memberDic, helpDic, levelId)
    local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams();
    enterDungeonParams.eventId = dungeonId;
    enterDungeonParams.dungeonId = dungeonId;
    enterDungeonParams.members = memberDic;
    enterDungeonParams.helps = helpDic;
    enterDungeonParams.extraParams = { "dualbattle", self.activityData.plotId, levelId };
    local levelCfg = ConfigMgr.Config.DualBattleBuffMap[self.activityData.enemyLevelId]
    for i, v in ipairs(levelCfg.BuffGroup) do
        table.insert(enterDungeonParams.extraParams, v)
    end
    for i, v in ipairs(self.activityData.selfBuff) do
        local buffId = MiniBattle3Mgr.GetBuffIdByLevelGroupId(v)
        table.insert(enterDungeonParams.extraParams, buffId)
    end
    return enterDungeonParams
end

function ActivityBattlePrepareInfo_MiniBattle3:Clear()
    LuaMgr.RemoveClick(self.enemyBuffBtn, self.OnClickEnemyBuff);
    LuaMgr.RemoveClick(self.selfBuffBtn, self.OnClickSelfBuff);
    LuaMgr.RemoveClick(self.enemysBtn, self.OnClickEnemys);
    LuaMgr.RemoveClick(self.startBtn1, self.OnClickStart);
    LuaMgr.RemoveClick(self.startBtn2, self.OnClickStart);
    LuaMgr.RemoveClick(self.delegateBattle, self.OnClickDelegate);
    self.enemysListView:Clear();
    self.BuffCardScrollView:Clear();
    UIScrollView.ClearItem("MiniBattle3SimpleBuffItem")
end

function ActivityBattlePrepareInfo_MiniBattle3:Destroy()
    LuaMgr.RemovePrefabRefCount(self.path);
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end