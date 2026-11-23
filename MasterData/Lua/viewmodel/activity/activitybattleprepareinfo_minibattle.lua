ActivityBattlePrepareInfo_MiniBattle = {};

ActivityBattlePrepareInfo_MiniBattle.__index = ActivityBattlePrepareInfo_MiniBattle;

local objs = {
    level = { path = "RightInfo/Level/Text", type = "Text" },
    winScore = { path = "RightInfo/Reward/Win/Score", type = "Text" },
    loseScore = { path = "RightInfo/Reward/Lose/Score", type = "Text" },
    enemyItem = { path = "RightInfo/Enemys/EnemyItem", type = "GameObject" },
    enemysBtn = { path = "RightInfo/Enemys", type = "Button" },
    enemysListTF = { path = "RightInfo/Enemys/List", type = "Transform" },
    startBtn = { path = "RightInfo/Start", type = "Button" },
};

function ActivityBattlePrepareInfo_MiniBattle.New()
    local self = {};
    setmetatable(self, ActivityBattlePrepareInfo_MiniBattle);
    return self;
end

function ActivityBattlePrepareInfo_MiniBattle:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.monsterList = nil
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
    SetActive(self.enemyItem, false)
    SetActive(self.gameObject, false)
end

function ActivityBattlePrepareInfo_MiniBattle:SetData(dungeonConfig, activityData)
    self.dungeonConfig = dungeonConfig
    self.activityData = activityData
    self.level.text = dungeonConfig.levelShow;
    self.winScore.text = activityData.plotCfg.Win;
    self.loseScore.text = activityData.plotCfg.Lose;
    self:SetEmemys();
    SetActive(self.gameObject, true)
end


function ActivityBattlePrepareInfo_MiniBattle:SetEmemys()
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


function ActivityBattlePrepareInfo_MiniBattle:SetMonsterIdList()
    if (self.monsterList == nil) then
        local str = LuaMgr.UpdateMonsterIdList(self.dungeonConfig.flowScript);
        self.monsterList = json.decode(str);
    end
end


function ActivityBattlePrepareInfo_MiniBattle:EnterDungeon(dungeonId, members)
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
    local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams();
    enterDungeonParams.eventId = dungeonId;
    enterDungeonParams.dungeonId = dungeonId;
    enterDungeonParams.members = memberDic;
    enterDungeonParams.helps = helpDic;
    enterDungeonParams.extraParams = { "miniBattle", LuaMgr.GetLangText(self.activityData.plotCfg.NameLan), self.activityData.plotCfg.BuffId };
    MiniBattleMgr.recordedScore = MiniBattleMgr.GetTotalScore()

    BattlePrepareMgr._enterDungeonParams = enterDungeonParams;
    LuaMgr.SceneSwitchMark({ UIName.ActivityBattlePrepareViewModel });
    PlayerAreaMgr.SetAreaDungeonId("-1");
    ApiMgr.Request("enter_dungeon", enterDungeonParams, true, function(result)
        local re = json.decode(result);
        local data = json.encode(re.result);
        LuaMgr.EnterBattle(data, -1);
    end, function(code)
    end, true);
end

function ActivityBattlePrepareInfo_MiniBattle:Clear()
    LuaMgr.RemoveClick(self.enemysBtn, self.OnClickEnemys);
    LuaMgr.RemoveClick(self.startBtn, self.OnClickStart);
    self.enemysListView:Clear();
end

function ActivityBattlePrepareInfo_MiniBattle:Destroy()
    LuaMgr.RemovePrefabRefCount(self.path);
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end