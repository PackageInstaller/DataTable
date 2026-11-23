ActivityBattlePrepareInfo_CrisisContract3 = {};

ActivityBattlePrepareInfo_CrisisContract3.__index = ActivityBattlePrepareInfo_CrisisContract3;

require("ViewModel/CrisisContract3/CrisisContract3SimpleBuffItem")

local objs = {
    level = { path = "RightInfo/Level/Text", type = "Text" },

    enemyBuffItem = { path = "RightInfo/Buff/BuffList/ScrollView/Viewport/Content/EnemyBuffItem", type = "GameObject" },
    enemyBuffListTF = { path = "RightInfo/Buff/BuffList/ScrollView", type = "Transform" },

    enemyItem = { path = "RightInfo/Enemys/EnemyItem", type = "GameObject" },
    enemysBtn = { path = "RightInfo/Enemys", type = "Button" },
    enemysListTF = { path = "RightInfo/Enemys/List", type = "Transform" },
    scoreTxt = { path = "RightInfo/Reward/Text/Score", type = "Text" },
    startBtn = { path = "RightInfo/Start", type = "Button" },
    tips = { path = "MiddleInfo/Tips/Text", type = "Text" },
};

function ActivityBattlePrepareInfo_CrisisContract3.New()
    local self = {};
    setmetatable(self, ActivityBattlePrepareInfo_CrisisContract3);
    return self;
end

function ActivityBattlePrepareInfo_CrisisContract3:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.monsterList = nil
    self.curShowBuffType = 0
    self.enemyBuffScrollView = UIScrollView.New(self.enemyBuffListTF);
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
    SetActive(self.enemyBuffItem, false)
    SetActive(self.enemyItem, false)
    SetActive(self.gameObject, false)
end

function ActivityBattlePrepareInfo_CrisisContract3:SetData(dungeonConfig, activityData)
    self.dungeonConfig = dungeonConfig
    self.activityData = activityData
    self.level.text = dungeonConfig.levelShow;
    self.scoreTxt.text = activityData.totalScore
    local anotherDungeonName = ConfigAreaMgr.GetDungeonName(activityData.anotherPlotCfg.DungeonId)
    self.tips.text = string.format(LuaMgr.GetLangText("ActivityBattlePrepareInfo_CrisisContract3_0"), anotherDungeonName)
    self:ShowBuffList()
    self:SetEmemys();
    SetActive(self.gameObject, true)
end

function ActivityBattlePrepareInfo_CrisisContract3:ShowBuffList()
    SetActive(self.enemyBuffListTF.gameObject, true)

    local scrollData, scrollDatas = {}, {}
    local groupData = nil
    local enemyBuff = self.activityData.buffList
    local len = #enemyBuff
    for i = 1, #enemyBuff do
        groupData = enemyBuff[i]
        scrollData = UIScrollData.GetData(self.enemyBuffItem, "CrisisContract3SimpleBuffItem", 272, 50, groupData)
        table.insert(scrollDatas, scrollData)
    end

    self.enemyBuffScrollView:Clear(false)
    self.enemyBuffScrollView:SetPadding(0, 0, 0, 0)
    self.enemyBuffScrollView:SetParams(280, 130)
    self.enemyBuffScrollView:SetData(scrollDatas, true)
end


function ActivityBattlePrepareInfo_CrisisContract3:SetEmemys()
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


function ActivityBattlePrepareInfo_CrisisContract3:SetMonsterIdList()
    if (self.monsterList == nil) then
        local str = LuaMgr.UpdateMonsterIdList(self.dungeonConfig.flowScript);
        self.monsterList = json.decode(str);
    end
end


function ActivityBattlePrepareInfo_CrisisContract3:EnterDungeon(dungeonId, members)
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
    enterDungeonParams.extraParams = { "contract3_plot", self.activityData.plotId };
    for i, v in ipairs(self.activityData.chooseBuffList) do
        table.insert(enterDungeonParams.extraParams, v)
    end
    local curReinf = CrisisContract3Mgr.GetCurScoreDiffAddition(self.activityData.totalScore)
    if curReinf ~= nil then
        for _, v in ipairs(curReinf.Buff) do
            table.insert(enterDungeonParams.extraParams, v)
        end
    end
    local recommendbuff = self.activityData.plotCfg.RecommendBuff
    if not TableIsNull(recommendbuff) then
        for _, v in ipairs(recommendbuff) do
            table.insert(enterDungeonParams.extraParams, v)
        end
    end
    
    CrisisContract3Mgr.SavePlotScore(self.activityData.totalScore)
    
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

function ActivityBattlePrepareInfo_CrisisContract3:Clear()
    LuaMgr.RemoveClick(self.enemysBtn, self.OnClickEnemys);
    LuaMgr.RemoveClick(self.startBtn, self.OnClickStart);
    self.enemysListView:Clear();
    self.enemyBuffScrollView:Clear();
    UIScrollView.ClearItem("CrisisContract3SimpleBuffItem")
end

function ActivityBattlePrepareInfo_CrisisContract3:Destroy()
    LuaMgr.RemovePrefabRefCount(self.path);
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end