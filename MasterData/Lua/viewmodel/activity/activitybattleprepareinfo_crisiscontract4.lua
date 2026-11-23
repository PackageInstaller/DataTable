ActivityBattlePrepareInfo_CrisisContract4 = {};

ActivityBattlePrepareInfo_CrisisContract4.__index = ActivityBattlePrepareInfo_CrisisContract4;

require("ViewModel/CrisisContract2/CrisisContract2SimpleEnemyBuffItem")
require("ViewModel/CrisisContract2/CrisisContract2SimpleSelfBuffItem")

local objs = {
    level = { path = "RightInfo/Level/Text", type = "Text" },

    enemyBuffItem = { path = "RightInfo/Buff/BuffList/EnemyScrollView/Viewport/Content/EnemyBuffItem", type = "GameObject" },
    enemyBuffOn = { path = "RightInfo/Buff/ToggleGroup/Enemy/On", type = "GameObject" },
    enemyBuffBtn = { path = "RightInfo/Buff/ToggleGroup/Enemy/Off", type = "Button" },
    enemyBuffListTF = { path = "RightInfo/Buff/BuffList/EnemyScrollView", type = "Transform" },

    selfBuffItem = { path = "RightInfo/Buff/BuffList/SelfScrollView/Viewport/Content/SelfBuffItem", type = "GameObject" },
    selfBuffOn = { path = "RightInfo/Buff/ToggleGroup/Self/On", type = "GameObject" },
    selfBuffBtn = { path = "RightInfo/Buff/ToggleGroup/Self/Off", type = "Button" },
    selfBuffListTF = { path = "RightInfo/Buff/BuffList/SelfScrollView", type = "Transform" },

    enemyItem = { path = "RightInfo/Enemys/EnemyItem", type = "GameObject" },
    enemysBtn = { path = "RightInfo/Enemys", type = "Button" },
    enemysListTF = { path = "RightInfo/Enemys/List", type = "Transform" },
    scoreTxt = { path = "RightInfo/Reward/Text/Score", type = "Text" },
    startBtn = { path = "RightInfo/Start", type = "Button" },
    tips = { path = "MiddleInfo/Tips/Text", type = "Text" },
};

function ActivityBattlePrepareInfo_CrisisContract4.New()
    local self = {};
    setmetatable(self, ActivityBattlePrepareInfo_CrisisContract4);
    return self;
end

function ActivityBattlePrepareInfo_CrisisContract4:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.monsterList = nil
    self.curShowBuffType = 0
    self.enemyBuffScrollView = UIScrollView.New(self.enemyBuffListTF);
    self.selfBuffScrollView = UIScrollView.New(self.selfBuffListTF);
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
        local selectMembers = ActivityBattlePrepareMgr.GetSelectMembers();
        self:EnterDungeon(self.dungeonConfig.id, selectMembers);
    end
    LuaMgr.AddClick(self.enemyBuffBtn, self.OnClickEnemyBuff);
    LuaMgr.AddClick(self.selfBuffBtn, self.OnClickSelfBuff);
    LuaMgr.AddClick(self.enemysBtn, self.OnClickEnemys);
    LuaMgr.AddClick(self.startBtn, self.OnClickStart);
    SetActive(self.enemyBuffItem, false)
    SetActive(self.selfBuffItem, false)
    SetActive(self.enemyItem, false)
    SetActive(self.gameObject, false)
end

function ActivityBattlePrepareInfo_CrisisContract4:SetData(dungeonConfig, activityData)
    self.dungeonConfig = dungeonConfig
    self.activityData = activityData
    self.level.text = dungeonConfig.levelShow;
    self.scoreTxt.text = activityData.totalScore
    self:ShowBuffList(1)
    self:SetEmemys();
    SetActive(self.gameObject, true)
end

function ActivityBattlePrepareInfo_CrisisContract4:ShowBuffList(type)
    if self.curShowBuffType == type then
        return
    end
    self.curShowBuffType = type

    if self.curShowBuffType == 1 then
        SetActive(self.enemyBuffOn, true)
        SetActive(self.enemyBuffListTF.gameObject, true)
        SetActive(self.selfBuffOn, false)
        SetActive(self.selfBuffListTF.gameObject, false)
        
        local scrollData, scrollDatas = {}, {}
        local groupData = nil
        local enemyBuff = self.activityData.enemyBuff
        local len = #enemyBuff
        for i = 1, #enemyBuff do
            groupData = enemyBuff[i]
            scrollData = UIScrollData.GetData(self.enemyBuffItem, "CrisisContract2SimpleEnemyBuffItem", 272, 50, groupData)
            table.insert(scrollDatas, scrollData)
        end

        self.enemyBuffScrollView:Clear(false)
        self.enemyBuffScrollView:SetPadding(4, 0, 0, 0)
        self.enemyBuffScrollView:SetParams(280, 130)
        self.enemyBuffScrollView:SetData(scrollDatas, true)
    else
        SetActive(self.enemyBuffOn, false)
        SetActive(self.enemyBuffListTF.gameObject, false)
        SetActive(self.selfBuffOn, true)
        SetActive(self.selfBuffListTF.gameObject, true)
        
        local scrollData, scrollDatas = {}, {}
        local groupData = nil
        local selfBuff = self.activityData.selfBuff
        local len = #selfBuff
        local index = 1
        while (index <= len) do
            groupData = {
                leftData = selfBuff[index],
                rightData = #selfBuff >= index + 1 and selfBuff[index + 1] or nil
            }
            scrollData = UIScrollData.GetData(self.selfBuffItem, "CrisisContract2SimpleSelfBuffItem", 272, 50, groupData)
            table.insert(scrollDatas, scrollData)
            index = index + 2
        end

        self.selfBuffScrollView:Clear(false)
        self.selfBuffScrollView:SetPadding(4, 0, 0, 0)
        self.selfBuffScrollView:SetParams(280, 130)
        self.selfBuffScrollView:SetData(scrollDatas, true)
    end
end


function ActivityBattlePrepareInfo_CrisisContract4:SetEmemys()
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


function ActivityBattlePrepareInfo_CrisisContract4:SetMonsterIdList()
    if (self.monsterList == nil) then
        local str = LuaMgr.UpdateMonsterIdList(self.dungeonConfig.flowScript);
        self.monsterList = json.decode(str);
    end
end


function ActivityBattlePrepareInfo_CrisisContract4:EnterDungeon(dungeonId, members)
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
    local dungeonCfg = CrisisContract4Mgr.GetDungeonCfg(self.activityData.activityDungeonId)
    local levelCfg = CrisisContract4Mgr.GetLevelCfg(dungeonCfg.DiffId)
    local teamIndex = 1
    for i, v in ipairs(levelCfg.DungeonGroupId) do
        if v == self.activityData.activityDungeonId then
            teamIndex = i
            break
        end
    end
    enterDungeonParams.extraParams = { "team_relay3", levelCfg.TeamRelayId, tostring(teamIndex), self.activityData.activityDungeonId };
    for i, v in ipairs(self.activityData.chooseBuffList) do
        table.insert(enterDungeonParams.extraParams, v)
    end
    CrisisContract4Mgr.SaveCurBattleScore(levelCfg.TeamRelayId, self.activityData.totalScore)
    
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

function ActivityBattlePrepareInfo_CrisisContract4:Clear()
    LuaMgr.RemoveClick(self.enemyBuffBtn, self.OnClickEnemyBuff);
    LuaMgr.RemoveClick(self.selfBuffBtn, self.OnClickSelfBuff);
    LuaMgr.RemoveClick(self.enemysBtn, self.OnClickEnemys);
    LuaMgr.RemoveClick(self.startBtn, self.OnClickStart);
    self.enemysListView:Clear();
    self.enemyBuffScrollView:Clear();
    self.selfBuffScrollView:Clear();
    UIScrollView.ClearItem("CrisisContract2SimpleEnemyBuffItem")
    UIScrollView.ClearItem("CrisisContract2SimpleSelfBuffItem")
end

function ActivityBattlePrepareInfo_CrisisContract4:Destroy()
    LuaMgr.RemovePrefabRefCount(self.path);
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end