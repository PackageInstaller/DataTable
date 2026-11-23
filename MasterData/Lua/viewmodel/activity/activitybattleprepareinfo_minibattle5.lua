ActivityBattlePrepareInfo_MiniBattle5 = {};

ActivityBattlePrepareInfo_MiniBattle5.__index = ActivityBattlePrepareInfo_MiniBattle5;

require("ViewModel/MiniBattle2/MiniBattle2BuffCardSimpleItem")

local objs = {
    bestScore = { path = "RightInfo/BestScore/Score", type = "Text" },
    level = { path = "RightInfo/Level/Text", type = "Text" },

    enemyBuffOn = { path = "RightInfo/Buff/ToggleGroup/EnemyOn", type = "GameObject" },
    enemyBuffBtn = { path = "RightInfo/Buff/ToggleGroup/EnemyOff", type = "Button" },
    selfBuffOn = { path = "RightInfo/Buff/ToggleGroup/SelfOn", type = "GameObject" },
    selfBuffBtn = { path = "RightInfo/Buff/ToggleGroup/SelfOff", type = "Button" },

    notEmptyGo = { path = "RightInfo/Buff/BuffList/NotEmpty", type = "GameObject" },
    emptyGo = { path = "RightInfo/Buff/BuffList/Empty", type = "GameObject" },
    enemyLevelGo = { path = "RightInfo/Buff/BuffList/NotEmpty/EnemyLevelName", type = "GameObject" },
    enemyLevelName = { path = "RightInfo/Buff/BuffList/NotEmpty/EnemyLevelName/Text", type = "Text" },
    buffCardScrollViewTF = { path = "RightInfo/Buff/BuffList/NotEmpty/ScrollView", type = "Transform" },
    buffCardItem = { path = "RightInfo/Buff/BuffList/NotEmpty/ScrollView/Viewport/Content/BuffCardItem", type = "GameObject" },

    enemyItem = { path = "RightInfo/Enemys/EnemyItem", type = "GameObject" },
    enemysBtn = { path = "RightInfo/Enemys", type = "Button" },
    enemysListTF = { path = "RightInfo/Enemys/List", type = "Transform" },
    scoreTxt = { path = "RightInfo/Reward/Text/Score", type = "Text" },
    startBtn = { path = "RightInfo/StartBattle", type = "Button" },
    delegateBattle = { path = "RightInfo/DelegateBattle", type = "Button" },
    delegateLock = { path = "RightInfo/DelegateBattle/LockBg", type = "GameObject" },
    tips = { path = "MiddleInfo/Tips/Text", type = "Text" },
};

function ActivityBattlePrepareInfo_MiniBattle5.New()
    local self = {};
    setmetatable(self, ActivityBattlePrepareInfo_MiniBattle5);
    return self;
end

function ActivityBattlePrepareInfo_MiniBattle5:Init()
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
            local selectMembers = ActivityBattlePrepareMgr.GetSelectMembers();
            self:EnterDungeon(self.dungeonConfig.id, selectMembers);
        end
        if MiniBattle5Mgr.CheckDailyBattleCount() then
            startFunc()
        else
            LuaMgr.ShowLuaPanel(UIName.MiniBattle2ConfirmTipsPopup, startFunc);
        end
    end
    self.OnClickDelegate = function()
        if self.curBestScore == 0 then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("25221"));
            return
        end
        if MiniBattle5Mgr.CheckDailyBattleCount() then
            LuaMgr.ShowLuaPanel(UIName.MiniBattle5DelegetePopup, self.activityData.plotId, function(count)
                self:OnDelegateDungeon(self.dungeonConfig.id, count)
            end);
        else
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("25222"));
        end
    end
    LuaMgr.AddClick(self.enemyBuffBtn, self.OnClickEnemyBuff);
    LuaMgr.AddClick(self.selfBuffBtn, self.OnClickSelfBuff);
    LuaMgr.AddClick(self.enemysBtn, self.OnClickEnemys);
    LuaMgr.AddClick(self.startBtn, self.OnClickStart);
    LuaMgr.AddClick(self.delegateBattle, self.OnClickDelegate);
    SetActive(self.delegateLock, false)
    SetActive(self.buffCardItem, false)
    SetActive(self.enemyItem, false)
    SetActive(self.gameObject, false)
end

function ActivityBattlePrepareInfo_MiniBattle5:SetData(dungeonConfig, activityData)
    self.dungeonConfig = dungeonConfig
    self.activityData = activityData
    self.curBestScore = MiniBattle5Mgr.GetDungeonScore(activityData.plotId)
    self.bestScore.text = self.curBestScore
    self.level.text = dungeonConfig.levelShow;
    local enemyLevelCfg = ConfigMgr.Config.MiniBattleNewBuffMap[activityData.enemyLevelId]
    self.enemyLevelName.text = LuaMgr.GetLangText(enemyLevelCfg.OptionDescLan)
    self.curScore = enemyLevelCfg.Credit
    self.scoreTxt.text = self.curScore
    if activityData.anotherPlotCfg == nil then
        SetActive(self.tips.gameObject,false) 
    else
        local anotherDungeonName = ConfigAreaMgr.GetDungeonName(activityData.anotherPlotCfg.DungeonId)
        self.tips.text = string.format(LuaMgr.GetLangText("ActivityBattlePrepareInfo_MiniBattle5_0"), anotherDungeonName)
        SetActive(self.tips.gameObject,true)
    end

    self:ShowBuffList(1)
    self:SetEmemys();
    SetActive(self.delegateLock, self.curBestScore == 0)
    SetActive(self.gameObject, true)
end

function ActivityBattlePrepareInfo_MiniBattle5:ShowBuffList(type)
    if self.curShowBuffType == type then
        return
    end
    self.curShowBuffType = type

    SetActive(self.enemyBuffOn, self.curShowBuffType == 1)
    SetActive(self.enemyLevelGo, self.curShowBuffType == 1)
    SetActive(self.selfBuffOn, self.curShowBuffType == 2)

    local scrollWidth = 0
    local buffCardIdList = {}
    if self.curShowBuffType == 1 then
        local buffLevelId = self.activityData.enemyLevelId
        local levelCfg = ConfigMgr.Config.MiniBattleNewBuffMap[buffLevelId]
        buffCardIdList = levelCfg.BuffGroup
        scrollWidth = 221
    elseif self.curShowBuffType == 2 then
        buffCardIdList = self.activityData.selfBuff
        scrollWidth = 280
    end

    local scrollData, scrollDatas = {}, {}
    local groupData = nil
    local len = #buffCardIdList
    for i = 1, #buffCardIdList do
        groupData = MiniBattle5Mgr.GetBuffCardInfo(buffCardIdList[i])
        groupData.onClick = function(cardId)
            LuaMgr.ShowLuaPanel(UIName.MiniBattle2BuffCardInfoPopup, cardId);
        end
        scrollData = UIScrollData.GetData(self.buffCardItem, "MiniBattle2BuffCardSimpleItem", 120, 138, groupData)
        table.insert(scrollDatas, scrollData)
    end

    self.BuffCardScrollView:Clear(false)
    self.BuffCardScrollView:SetPadding(20, 0, 0, 0)
    self.BuffCardScrollView:SetParams(scrollWidth, 138)
    self.BuffCardScrollView:SetData(scrollDatas, true)
end


function ActivityBattlePrepareInfo_MiniBattle5:SetEmemys()
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


function ActivityBattlePrepareInfo_MiniBattle5:SetMonsterIdList()
    if (self.monsterList == nil) then
        local str = LuaMgr.UpdateMonsterIdList(self.dungeonConfig.flowScript);
        self.monsterList = json.decode(str);
    end
end


function ActivityBattlePrepareInfo_MiniBattle5:EnterDungeon(dungeonId, members)
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
    MiniBattle5Mgr.SavePlotScores(self.curScore)
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


function ActivityBattlePrepareInfo_MiniBattle5:OnDelegateDungeon(dungeonId, count)
    local enterDungeonParams = self:GetEnterDungeonParam(dungeonId, {}, {}, "-1")
    enterDungeonParams.count = count
    ApiMgr.Request("enter_leave_dungeon", enterDungeonParams, true, function(result)
        LuaMgr.ShowLuaPanel(UIName.MiniBattle5DelegeteResultPopup, count, self.curBestScore, dungeonId)
    end, nil, true, true);
end

function ActivityBattlePrepareInfo_MiniBattle5:GetEnterDungeonParam(dungeonId, memberDic, helpDic, levelId)
    local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams();
    enterDungeonParams.eventId = dungeonId;
    enterDungeonParams.dungeonId = dungeonId;
    enterDungeonParams.members = memberDic;
    enterDungeonParams.helps = helpDic;
    enterDungeonParams.extraParams = { "minibattle5", self.activityData.plotId, levelId};
    local levelCfg = ConfigMgr.Config.MiniBattleNewBuffMap[self.activityData.enemyLevelId]
    for i, v in ipairs(levelCfg.BuffGroup) do
        table.insert(enterDungeonParams.extraParams, v)
    end
    for i, v in ipairs(levelCfg.InitialBuff) do
        table.insert(enterDungeonParams.extraParams, v)
    end
    for i, v in ipairs(self.activityData.selfBuff) do
        table.insert(enterDungeonParams.extraParams, v)
    end
    return enterDungeonParams
end

function ActivityBattlePrepareInfo_MiniBattle5:Clear()
    LuaMgr.RemoveClick(self.enemyBuffBtn, self.OnClickEnemyBuff);
    LuaMgr.RemoveClick(self.selfBuffBtn, self.OnClickSelfBuff);
    LuaMgr.RemoveClick(self.enemysBtn, self.OnClickEnemys);
    LuaMgr.RemoveClick(self.startBtn, self.OnClickStart);
    LuaMgr.RemoveClick(self.delegateBattle, self.OnClickDelegate);
    self.enemysListView:Clear();
    self.BuffCardScrollView:Clear();
    UIScrollView.ClearItem("MiniBattle2BuffCardSimpleItem")
    UIListView.ClearItem("ActivityBattlePrepareEnemyItem")
end

function ActivityBattlePrepareInfo_MiniBattle5:Destroy()
    LuaMgr.RemovePrefabRefCount(self.path);
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end