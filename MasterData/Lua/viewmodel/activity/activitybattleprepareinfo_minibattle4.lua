ActivityBattlePrepareInfo_MiniBattle4 = {};

ActivityBattlePrepareInfo_MiniBattle4.__index = ActivityBattlePrepareInfo_MiniBattle4;

require("ViewModel/MiniBattle4/MiniBattle4BuffGroupItem")

local objs = {
    leftCountText = { path = "RightInfo/LeftCount/Text", type = "Text" },
    level = { path = "RightInfo/Level/Text", type = "Text" },
    buffCardScrollViewTF = { path = "RightInfo/Buff/ScrollView", type = "Transform" },
    buffCardGroupItem = { path = "RightInfo/Buff/ScrollView/Viewport/Content/BuffGroup", type = "GameObject" },
    enemyItem = { path = "RightInfo/Enemys/EnemyItem", type = "GameObject" },
    enemysBtn = { path = "RightInfo/Enemys", type = "Button" },
    enemysListTF = { path = "RightInfo/Enemys/List", type = "Transform" },
    rewardScoreText = { path = "RightInfo/Reward/Text/Score", type = "Text" },
    startBtn = { path = "RightInfo/StartBattle", type = "Button" },
    delegateBattle = { path = "RightInfo/DelegateBattle", type = "Button" },
    delegateLock = { path = "RightInfo/DelegateBattle/LockBg", type = "GameObject" },
    tips = { path = "MiddleInfo/Tips/Text", type = "Text" },
};

function ActivityBattlePrepareInfo_MiniBattle4.New()
    local self = {};
    setmetatable(self, ActivityBattlePrepareInfo_MiniBattle4);
    return self;
end

function ActivityBattlePrepareInfo_MiniBattle4:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.monsterList = nil
    self.buffCardScrollView = UIScrollView.New(self.buffCardScrollViewTF);
    self.enemysListView = UIListView.New(self.enemysListTF);

    self.OnClickEnemys = function()
        LuaMgr.ShowLuaPanel(UIName.BattlePrepareEnemyViewModel, self.dungeonConfig, self.monsterList);
    end
    self.OnClickStart = function()
        local startFunc = function()
            local selectMembers = ActivityBattlePrepareMgr.GetSelectMembers();
            self:EnterDungeon(self.dungeonConfig.id, selectMembers);
        end
        local IsSkipWarningToday = function()
            local curDataStr = os.date("%Y-%m-%d", LuaMgr.Timestamp())
            local savedDataStr = PlayerPrefs.GetString(DataMgr.Player.uid .. "_MiniBattle4LeftCountWarning", "");
            return savedDataStr == curDataStr
        end
        if self.leftCountEnough or IsSkipWarningToday() then
            startFunc()
        else
            LuaMgr.ShowLuaPanel(UIName.MiniBattle4ConfirmTipsPopup, startFunc);
        end
    end
    self.OnClickDelegate = function()
        if self.isDelegateLock then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("26660"));
            return
        end
        if self.leftCountEnough then
            LuaMgr.ShowLuaPanel(UIName.MiniBattle4DelegetePopup, self.activityData.plotId, function(count)
                self:OnDelegateDungeon(count)
            end);
        else
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("26661"));
        end
    end

    self.OnDelegateComplate = function()
        local leftCount, totalCount = MiniBattle4Mgr.GetSeriesLeftChallengeCount(self.activityData.plotCfg.SeriesId)
        self.leftCountEnough = leftCount > 0
        self.leftCountText.text = string.format(LuaMgr.GetLangText("ActivityBattlePrepareInfo_MiniBattle4_0"), leftCount, totalCount)
    end
    
    LuaMgr.AddClick(self.enemysBtn, self.OnClickEnemys);
    LuaMgr.AddClick(self.startBtn, self.OnClickStart);
    LuaMgr.AddClick(self.delegateBattle, self.OnClickDelegate);
    SetActive(self.delegateLock, false)
    SetActive(self.buffCardGroupItem, false)
    SetActive(self.enemyItem, false)
    SetActive(self.gameObject, false)

    LuaMgr.AddUIEventListener(UIEventConst.MiniBattle4DelegateComplate, self.OnDelegateComplate)
end

function ActivityBattlePrepareInfo_MiniBattle4:SetData(dungeonConfig, activityData)
    self.dungeonConfig = dungeonConfig
    self.activityData = activityData
    local leftCount, totalCount = MiniBattle4Mgr.GetSeriesLeftChallengeCount(activityData.plotCfg.SeriesId)
    self.leftCountEnough = leftCount > 0
    local beseScore = MiniBattle4Mgr.GetPlotBestScore(activityData.plotId)
    self.isDelegateLock = beseScore == 0
    self.leftCountText.text = string.format(LuaMgr.GetLangText("ActivityBattlePrepareInfo_MiniBattle4_1"), leftCount, totalCount)
    self.rewardScoreText.text = beseScore
    self.level.text = dungeonConfig.levelShow;
    self.tips.text = LuaMgr.GetLangText("ActivityBattlePrepareInfo_MiniBattle4_2")
    self:ShowBuffList()
    self:SetEmemys();
    SetActive(self.delegateLock, beseScore == 0)
    SetActive(self.gameObject, true)
end

function ActivityBattlePrepareInfo_MiniBattle4:ShowBuffList()
    local buffInfoList = {}
    local levelCfg = MiniBattle4Mgr.GetLevelCfg(self.activityData.levelId)
    for i, v in ipairs(levelCfg.BuffGroup) do
        local buffInfo = MiniBattle4Mgr.GetBuffCardInfo(v)
        if buffInfo ~= nil then
            buffInfo.levelStr = ""
            table.insert(buffInfoList, buffInfo)
        end
    end

    local scrollData, scrollDatas = {}, {}
    local groupData = nil
    local len = #buffInfoList
    for i = 1, #buffInfoList, 2 do
        groupData = { 
            cardId_1 = buffInfoList[i].id,
            name_1 = buffInfoList[i].name,
            cardId_2 = "",
            name_2 = ""
        }
        if i + 1 <= len then
            groupData.cardId_2 = buffInfoList[i + 1].id
            groupData.name_2 = buffInfoList[i + 1].name
        end
        scrollData = UIScrollData.GetData(self.buffCardGroupItem, "MiniBattle4BuffGroupItem", 262, 44, groupData)
        table.insert(scrollDatas, scrollData)
    end

    self.buffCardScrollView:Clear(false)
    self.buffCardScrollView:SetPadding(0, 0, 0, 0)
    self.buffCardScrollView:SetParams(262, 133)
    self.buffCardScrollView:SetData(scrollDatas, true)
end


function ActivityBattlePrepareInfo_MiniBattle4:SetEmemys()
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


function ActivityBattlePrepareInfo_MiniBattle4:SetMonsterIdList()
    if (self.monsterList == nil) then
        local str = LuaMgr.UpdateMonsterIdList(self.dungeonConfig.flowScript);
        self.monsterList = json.decode(str);
    end
end


function ActivityBattlePrepareInfo_MiniBattle4:EnterDungeon(dungeonId, members)
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
    local enterDungeonParams = self:GetEnterDungeonParam(dungeonId, memberDic, helpDic, self.activityData.levelId)
    BattlePrepareMgr._enterDungeonParams = enterDungeonParams
    LuaMgr.SceneSwitchMark({ UIName.ActivityBattlePrepareViewModel });
    PlayerAreaMgr.SetAreaDungeonId("-1");
    MiniBattle4Mgr.SaveCurBattleScore(self.activityData.levelId, self.leftCountEnough)
    ApiMgr.Request("enter_dungeon", enterDungeonParams, true, function(result)
        local re = json.decode(result);
        local data = json.encode(re.result);
        LuaMgr.EnterBattle(data, -1);
    end, function(code)
    end, true);
end


function ActivityBattlePrepareInfo_MiniBattle4:OnDelegateDungeon(count)
    local highestLevelId = MiniBattle4Mgr.GetPlotHighestLevel(self.activityData.plotId)
    local levelCfg = MiniBattle4Mgr.GetLevelCfg(highestLevelId)
    local enterDungeonParams = self:GetEnterDungeonParam(levelCfg.LevelDungeonId, {}, {}, "-1")
    enterDungeonParams.count = count
    ApiMgr.Request("enter_leave_dungeon", enterDungeonParams, true, function(result)
        LuaMgr.ShowLuaPanel(UIName.MiniBattle4DelegeteResultPopup, count, self.activityData.plotId, self.dungeonConfig.id)
        LuaMgr.InvokeUIEventListeners(UIEventConst.MiniBattle4DelegateComplate)
    end, nil, true, true);
end

function ActivityBattlePrepareInfo_MiniBattle4:GetEnterDungeonParam(dungeonId, memberDic, helpDic, levelId)
    local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams();
    enterDungeonParams.eventId = dungeonId;
    enterDungeonParams.dungeonId = dungeonId;
    enterDungeonParams.members = memberDic;
    enterDungeonParams.helps = helpDic;
    enterDungeonParams.extraParams = { "dual2battle", self.activityData.plotId, levelId, self.activityData.helpId };
    local levelCfg = MiniBattle4Mgr.GetLevelCfg(self.activityData.levelId)
    for i, v in ipairs(levelCfg.BuffGroup) do
        table.insert(enterDungeonParams.extraParams, v)
    end
    if not IsNullOrEmpty(self.activityData.helpId) then
        local monsterInfo = MiniBattle4Mgr.GetMonsterInfo(self.activityData.helpId)
        for i, v in ipairs(monsterInfo.dualBattleCfg.ActorBuff) do
            table.insert(enterDungeonParams.extraParams, v)
        end
    end
    for i, exBossId in ipairs(self.activityData.plotCfg.ExMonsterId) do
        local exBossInfo = MiniBattle4Mgr.GetMonsterInfo(exBossId)
        for n, v in ipairs(exBossInfo.dualBattleCfg.ActorBuff) do
            table.insert(enterDungeonParams.extraParams, v)
        end
    end
    return enterDungeonParams
end

function ActivityBattlePrepareInfo_MiniBattle4:Clear()
    LuaMgr.RemoveClick(self.enemysBtn, self.OnClickEnemys);
    LuaMgr.RemoveClick(self.startBtn, self.OnClickStart);
    LuaMgr.RemoveClick(self.delegateBattle, self.OnClickDelegate);
    self.enemysListView:Clear();
    self.buffCardScrollView:Clear();
    UIScrollView.ClearItem("MiniBattle4BuffGroupItem")
    LuaMgr.RemoveUIEventListener(UIEventConst.MiniBattle4DelegateComplate, self.OnDelegateComplate)
end

function ActivityBattlePrepareInfo_MiniBattle4:Destroy()
    LuaMgr.RemovePrefabRefCount(self.path);
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end