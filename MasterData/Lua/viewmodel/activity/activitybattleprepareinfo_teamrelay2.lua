ActivityBattlePrepareInfo_TeamRelay2 = {};

ActivityBattlePrepareInfo_TeamRelay2.__index = ActivityBattlePrepareInfo_TeamRelay2;

require("ViewModel/TeamRelay2/TeamRelay2BuffItem")

local objs = {
    totalScore = { path = "RightInfo/BestScore/Score", type = "Text" },
    level = { path = "RightInfo/Level/Text", type = "Text" },
    buffCardScrollViewTF = { path = "RightInfo/Buff/BuffList/ScrollView/Viewport/Content", type = "Transform" },
    buffCardGroupItem = { path = "RightInfo/Buff/BuffList/ScrollView/Viewport/Content/BuffItem", type = "GameObject" },
    enemyItem = { path = "RightInfo/Enemys/EnemyItem", type = "GameObject" },
    enemysBtn = { path = "RightInfo/Enemys", type = "Button" },
    enemysListTF = { path = "RightInfo/Enemys/List", type = "Transform" },
    startBtn = { path = "RightInfo/StartBattle", type = "Button" },
};

function ActivityBattlePrepareInfo_TeamRelay2.New()
    local self = {};
    setmetatable(self, ActivityBattlePrepareInfo_TeamRelay2);
    return self;
end

function ActivityBattlePrepareInfo_TeamRelay2:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.monsterList = nil
    self.buffCardListView = UIListView.New(self.buffCardScrollViewTF);
    self.enemysListView = UIListView.New(self.enemysListTF);

    self.OnClickEnemys = function()
        LuaMgr.ShowLuaPanel(UIName.BattlePrepareEnemyViewModel, self.dungeonConfig, self.monsterList);
    end
    self.OnClickStart = function()
        local selectMembers = ActivityBattlePrepareMgr.GetSelectMembers();
        self:EnterDungeon(self.dungeonConfig.id, selectMembers);
    end

    LuaMgr.AddClick(self.enemysBtn, self.OnClickEnemys);
    LuaMgr.AddClick(self.startBtn, self.OnClickStart);
    SetActive(self.buffCardGroupItem, false)
    SetActive(self.enemyItem, false)
    SetActive(self.gameObject, false)
end

function ActivityBattlePrepareInfo_TeamRelay2:SetData(dungeonConfig, activityData)
    self.dungeonConfig = dungeonConfig
    self.activityData = activityData
    self.totalScore.text = TeamRelay2Mgr.GetCurChallengeTotalScore(activityData.plotId)
    self.level.text = dungeonConfig.levelShow;
    self:ShowBuffList()
    self:SetEmemys();
    SetActive(self.gameObject, true)
end

function ActivityBattlePrepareInfo_TeamRelay2:ShowBuffList()
    local buffInfoList = {}
    local dungeonCfg = TeamRelay2Mgr.GetDungeonCfg(self.activityData.activityDungeonId)
    for i, v in ipairs(dungeonCfg.BuffGroup) do
        local buffCfg = TeamRelay2Mgr.GetBuffDescCfg(v)
        local buffData = {
            buffDescId = v,
            icon = LuaMgr.GetSprite("BuffIcon", buffCfg.BuffIcon),
            name = LuaMgr.GetLangText(buffCfg.BuffNameLan),
            iconType = IsNullOrEmpty(buffCfg.IconType) and 1 or tonumber(buffCfg.IconType),
        }
        table.insert(buffInfoList, buffData)
    end

    local listData, listDataList = {}, {}
    for i, v in ipairs(buffInfoList) do
        local buffData = v
        listData = UIListData.GetData(self.buffCardGroupItem, "TeamRelay2BuffItem", buffData);
        table.insert(listDataList, listData);
    end
    self.buffCardListView:SetData(listDataList);
end


function ActivityBattlePrepareInfo_TeamRelay2:SetEmemys()
    self.enemysListView:Clear();
    self:SetMonsterIdList();
    local listData, listDataList = {}, {}
    local monsterMap = ConfigMgr.Config.monsterMap;
    for _, v in ipairs(self.monsterList) do
        local monster = monsterMap[v];
        if (monster ~= nil and not monster.hideShowinfo) then
            listData = UIListData.GetData(self.enemyItem, "ActivityBattlePrepareEnemyItem", monster);
            table.insert(listDataList, listData);
            if (#listDataList >= 3) then
                break ;
            end
        end
    end
    self.enemysListView:SetData(listDataList);
end


function ActivityBattlePrepareInfo_TeamRelay2:SetMonsterIdList()
    if (self.monsterList == nil) then
        local str = LuaMgr.UpdateMonsterIdList(self.dungeonConfig.flowScript);
        self.monsterList = json.decode(str);
    end
end


function ActivityBattlePrepareInfo_TeamRelay2:EnterDungeon(dungeonId, members)
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
    LuaMgr.SceneSwitchMark({ UIName.ActivityBattlePrepareViewModel })
    TeamRelay2Mgr.SaveCurDungeonHighScore(self.activityData.activityDungeonId)
    ApiMgr.Request("enter_dungeon", enterDungeonParams, true, function(result)
        local re = json.decode(result);
        local data = json.encode(re.result);
        LuaMgr.EnterBattle(data, -1);
    end, function(code)
    end, true);
end

function ActivityBattlePrepareInfo_TeamRelay2:GetEnterDungeonParam(dungeonId, memberDic, helpDic, levelId)
    local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams();
    enterDungeonParams.eventId = dungeonId;
    enterDungeonParams.dungeonId = dungeonId;
    enterDungeonParams.members = memberDic;
    enterDungeonParams.helps = helpDic;
    local teamId = TeamRelay2Mgr.GetTeamIdByActivityDungeonId(self.activityData.activityDungeonId)
    enterDungeonParams.extraParams = { "team_relay2", self.activityData.plotId, teamId, self.activityData.activityDungeonId };
    local activityDungeonCfg = TeamRelay2Mgr.GetDungeonCfg(self.activityData.activityDungeonId)
    for i, v in ipairs(activityDungeonCfg.BuffGroup) do
        table.insert(enterDungeonParams.extraParams, v)
    end
    return enterDungeonParams
end

function ActivityBattlePrepareInfo_TeamRelay2:Clear()
    LuaMgr.RemoveClick(self.enemysBtn, self.OnClickEnemys);
    LuaMgr.RemoveClick(self.startBtn, self.OnClickStart);
    self.enemysListView:Clear();
    self.buffCardListView:Clear();
    UIListView.ClearItem("TeamRelay2BuffItem")
end

function ActivityBattlePrepareInfo_TeamRelay2:Destroy()
    LuaMgr.RemovePrefabRefCount(self.path);
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end